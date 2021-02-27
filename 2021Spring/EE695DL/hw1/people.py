class People:
    def __call__(self):
        for _ in sorted(self.last_names):
            print(_)
    
    def __init__(
            self,
            first_names=None,
            middle_names=None,
            last_names=None,
            order=None,
    ):
        self.first_names = first_names
        self.middle_names = middle_names
        self.last_names = last_names
        self.order = order

    def __iter__(self):
        for i in range(len(self.first_names)):
            yield self._str_i(i)

    def _str_i(self, i):
        if not self.order or \
           self.order=='first_name_first':
            return '{} {} {}'.format(
                self.first_names[i],
                self.middle_names[i],
                self.last_names[i]
            )
        elif self.order=='last_name_first':
            return '{} {} {}'.format(
                self.last_names[i],
                self.first_names[i],
                self.middle_names[i],
            )
        elif self.order=='last_name_with_comma_first':
            return '{}, {} {}'.format(
                self.last_names[i],
                self.first_names[i],
                self.middle_names[i],
            )
        
    def set_first_names(self, first_names):
        self.first_names = first_names

    def set_middle_names(self, middle_names):
        self.middle_names = middle_names

    def set_last_names(self, last_names):
        self.last_names = last_names

    def set_order(self, order):
        self.order = order
