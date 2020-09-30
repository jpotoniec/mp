#include <iostream>
#include <cstdint>
#include <cmath>
#include <random>


//--------------
//http://www.johndcook.com/blog/cpp_phi/
double phi(double x)
{
    // constants
    double a1 =  0.254829592;
    double a2 = -0.284496736;
    double a3 =  1.421413741;
    double a4 = -1.453152027;
    double a5 =  1.061405429;
    double p  =  0.3275911;

    // Save the sign of x
    int sign = 1;
    if (x < 0)
        sign = -1;
    x = fabs(x)/sqrt(2.0);

    // A&S formula 7.1.26
    double t = 1.0/(1.0 + p*x);
    double y = 1.0 - (((((a5*t + a4)*t) + a3)*t + a2)*t + a1)*t*exp(-x*x);

    return 0.5*(1.0 + sign*y);
}
//-------------------

typedef int (*Dice)();

void test(Dice dice, uint32_t n)
{
	double den=6*6*6*6;
	uint32_t k=0;
	for(uint32_t i=0;i<n;++i)
	{
		int r1 = dice();
		int r2 = dice();
		int r3 = dice();
		int r4 = dice();
		int r5 = dice();
		if(r1 == r2 && r2 == r3 && r3 == r4 && r4 == r5)
			k++;
	}
	std::cout<<"Test: "<<k<<std::endl;
	std::cout<<"Expected: "<<n/den<<std::endl;
	std::cout<<1.0*k/n<<" "<<1.0/den<<std::endl;
	double delta=fabs(n/den-k);
	std::cout<<"delta: "<<delta<<std::endl;
	double p=2*(1-phi(delta/sqrt(n/den)));
	std::cout<<"p-value: "<<p<<std::endl;
	std::cout<<std::endl;
}

int rand_dice()
{
	return rand()%6+1;
}

int rand_dice2()
{
	for(;;)
	{
		int x=rand()&0b111;
		if(x>=1 && x<=6)
			return x;
	}
}

int dilbert()
{
	return 9;
}

int crappy_lcg()
{
	static std::linear_congruential_engine<uint32_t, 1229, 1, 2048> eng;
	return eng()%6+1;
}

int mt()
{
	static std::mt19937 eng;
	for(;;)
	{
		int x=eng()&0b111;
		if(x>=1 && x<=6)
			return x;
	}
}

int xorshift()
{
	static uint32_t x=0xdeadbeef;
	x^=x<<2;
	x^=x>>7;
	x^=x<<9;
	return (x%6)+1;
}

int broken_xorshift()
{
	static uint32_t x=0xdeadbeef;
	x^=x<<2;
	x^=x>>7;
//	x^=x<<9;
	return (x%6)+1;
}

uint32_t KISS()
{
	static uint32_t x=123456789;
	static uint32_t y=362436000;
	static uint32_t z=521288629;
	static uint32_t c=7654321;

	x=69069*x+13245;

	y^=y<<13;
	y^=y>>17;
	y^=y<<5;

	uint64_t t=698769069;
	t=t*z+c;
	c=t>>32;

	return x+y+z;
}

int KISS_mod()
{
	return KISS()%6+1;
}

int KISS_cut()
{
	for(;;)
	{
		uint32_t x = KISS()&0b111;
		if(1<=x && x<=6)
			return x;
	}
}


int main()
{
	uint32_t n=1e9;
//	srand(0xdeadbeef);
//	test(rand_dice, n);
//	test(rand_dice2, n);
//	test(dilbert, n);
//	test(crappy_lcg, n);
//	test(mt, n);
//	test(xorshift, n);
//	test(broken_xorshift, n);
	test(KISS_mod, n);
	test(KISS_cut, n);
	return 0;
}
