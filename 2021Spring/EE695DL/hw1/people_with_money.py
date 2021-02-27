from people import People
from utils import sorted_indices

class PeopleWithMoney(People):
    def __call__(self):
        sorted_idx = sorted_indices(self.wealth)
        for idx in sorted_idx:
            print(
                '{} {} {} {}'.format(
                    self.first_names[idx],
                    self.middle_names[idx],
                    self.last_names[idx],
                    self.wealth[idx],
                )
            )

    def __init__(
            self,
            first_names=None,
            middle_names=None,
            last_names=None,
            order=None,
            wealth=None,
    ):
        super().__init__(
            first_names,
            middle_names,
            last_names,
            order,
        )
        self.wealth = wealth

    def __iter__(self):
        p_iter = super().__iter__()
        for w, p_str in zip(self.wealth, p_iter):
            yield "{} {}".format(p_str, w)
