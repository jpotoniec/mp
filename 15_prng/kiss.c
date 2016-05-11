#include <stdint.h>

uint32_t x=123456789;
uint32_t y=362436000;
uint32_t z=521288629;
uint32_t c=7654321;

uint32_t KISS()
{
	x=69069*x+13245;

	y^=y<<13;
	y^=y>>17;
	y^=y<<5;

	uint64_t t=698769069;
	t=t*z+c;
	c=t>>32;

	return x+y+z;
}

int main()
{
	printf("%d\n", KISS());
	return 0;
}
