#include "types.h"
#include "user.h"

int main(int argc, char** argv)
{
	if(argc == 2)
	{
		long index = atoi(argv[1]);
		printf(1, "%d\n", actual_seed(index));
	}

	else if(argc == 3)
	{
		int  index = atoi(argv[1]);
		long  set = atoi(argv[2]);
		
		if(change_seed(index, set) < 0)
		{
			printf(2, "Cannot change seed");
		}
		
	}

	else
	{
		printf(2, "seed_test format could be seed_test int or seed_test int long");
	}

	exit();
}
