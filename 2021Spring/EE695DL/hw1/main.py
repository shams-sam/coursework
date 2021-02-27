from people import People
from people_with_money import PeopleWithMoney
from utils import get_random_name_set, get_random_num_set


if __name__ == "__main__":
    # generate randoms
    first_names = get_random_name_set()
    middle_names = get_random_name_set()
    last_names = get_random_name_set()
    wealth = get_random_num_set()

    # initialize People instance
    # set first_name_first
    # iterator print
    p = People(
        first_names=first_names,
        middle_names=middle_names,
        last_names=last_names,
        order='first_name_first'
    )
    for _ in p:
        print(_)
    print()


    # reset to last_name_first
    # iterator print
    p.set_order('last_name_first')
    # i
    for _ in p:
        print(_)
    print()


    # reset to last_name_with_comma_first
    # iterator print
    p.set_order('last_name_with_comma_first')
    for _ in p:
        print(_)
    print()


    # People instance call
    p()
    print()


    # initialize PeopleWithMoney instance
    # iterator print
    pwm = PeopleWithMoney(
        first_names=first_names,
        middle_names=middle_names,
        last_names=last_names,
        order='first_name_first',
        wealth=wealth,
    )
    for _ in pwm:
        print(_)
    print()

    # PeopleWithMoney instance call
    pwm()
