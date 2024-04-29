import random
import time
from collections import defaultdict, deque
from multiprocessing.managers import BaseManager
from typing import Dict, List

import numpy as np

__all__ = ['MemPool', 'MultiprocessingMemPool', 'MemPoolManager']


class MemPool:
    def __init__(self, capacity: int = None, keys: List[str] = None) -> None:
        self._keys = keys
        if keys is None:
            self.data = defaultdict(lambda: deque(maxlen=capacity))
        else:
            self.data = {key: deque(maxlen=capacity) for key in keys}

    def push(self, data: Dict[str, np.ndarray]) -> None:
        print("calling mem push")
        """Push data into memory pool"""
        for key, value in data.items():
            self.data[key].extend(value)

        if self._keys is None:
            self._keys = list(self.data.keys())

    def sample(self, size: int = -1) -> Dict[str, np.ndarray]:
        print("calling memsample")
        """
        Sample training data from memory pool
        :param size: The number of sample data, default '-1' that indicates all data
        :return: The sampled and concatenated training data
        """

        num = len(self)
        #print(num)
        indices = list(range(num))
        #print(indices)
        if 0 < size < num:
            indices = random.sample(indices, size)
            #print(indices)

        result = {}
        #print(self._keys)
        #print('noaction:'+str(len(self.data['x_no_action'])))
        #print('action:'+str(len(self.data['action'])))
        #print('q:'+str(len(self.data['q'])))
        #print('reward:'+str(len(self.data['reward'])))
        for key in self._keys:
            #print(key)
            #print(self.data[key])
            result[key] = np.stack([self.data[key][idx] for idx in indices])
            #print(result[key])
        return result

    def clear(self) -> None:
        """Clear all data"""
        for key in self._keys:
            self.data[key].clear()

    def __len__(self):
        if self._keys is None:
            return 0
        return len(self.data[self._keys[0]])


class MultiprocessingMemPool(MemPool):
    def __init__(self, capacity: int = None, keys: List[str] = None) -> None:
        super().__init__(capacity, keys)

        self._receiving_data_throughput = None
        self._consuming_data_throughput = None

    def push(self, data: Dict[str, np.ndarray]) -> None:
        print("calling multimem push")
        super().push(data)

        if self._receiving_data_throughput is not None:
            self._receiving_data_throughput += len(data[self._keys[0]])

    def sample(self, size: int = -1) -> Dict[str, np.ndarray]:
        print("calling multimem sample")
        data = super().sample(size)

        if self._consuming_data_throughput is not None:
            self._consuming_data_throughput += len(data[self._keys[0]])

        # super().clear()
        
        return data

    def clear(self) -> None:
        super().clear()

        self._receiving_data_throughput = None
        self._consuming_data_throughput = None

    def _get_receiving_data_throughput(self):
        return self._receiving_data_throughput

    def _get_consuming_data_throughput(self):
        return self._consuming_data_throughput

    def _reset_receiving_data_throughput(self):
        self._receiving_data_throughput = 0

    def _reset_consuming_data_throughput(self):
        self._consuming_data_throughput = 0

    @classmethod
    def record_throughput(cls, obj, interval=10):
        """Print receiving and consuming periodically"""

        while True:
            obj._reset_receiving_data_throughput()
            obj._reset_consuming_data_throughput()

            time.sleep(interval)

            print(f'Receiving FPS: {obj._get_receiving_data_throughput() / interval:.2f}, '
                  f'Consuming FPS: {obj._get_consuming_data_throughput() / interval:.2f}')


class MemPoolManager(BaseManager):
    pass


MemPoolManager.register('MemPool', MultiprocessingMemPool,
                        exposed=['__len__', 'push', 'sample', 'clear', '_get_receiving_data_throughput',
                                 '_get_consuming_data_throughput', '_reset_receiving_data_throughput',
                                 '_reset_consuming_data_throughput'])
