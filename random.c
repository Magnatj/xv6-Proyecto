#include "types.h"
#include  "defs.h"

#define MODLUS 2147483647
#define MULTONE 24112
#define MULTTWO 26143

static float randomValue = 0.0;
static int seed = 0;

static long zrng[] = 
{         0, 
 1973272912, 281629770,  20006270,1280689831,2096730329,1933576050,
  913566091, 246780520,1363774876, 604901985,1511192140,1259851944,
  824064364, 150493284, 242708531,  75253171,1964472944,1202299975,
  233217322,1911216000, 726370533, 403498145, 993232223,1103205531,
  762430696,1922803170,1385516923,  76271663, 413682397, 726466604,
  336157058,1432650381,1120463904, 595778810, 877722890,1046574445,
   68911991,2088367019, 748545416, 622401386,2122378830, 640690903,
 1774806513,2132545692,2079249579,  78130110, 852776735,1187867272,
 1351423507,1645973084,1997049139, 922510944,2045512870, 898585771,
  243649545,1004818771, 773686062, 403188473, 372279877,1901633463,
  498067494,2087759558, 493157915, 597104727,1530940798,1814496276,
  536444882,1663153658, 855503735,  67784357,1432404475, 619691088,
  119025595, 880802310, 176192644,1116780070, 277854671,1366580350,
 1142483975,2026948561,1053920743, 786262391,1792203830,1494667770,
 1923011392,1433700034,1244184613,1147297105, 539712780,1545929719,
  190641742,1645390429, 264907697, 620389253,1502074852, 927711160,
  364849192,2049576050, 638580085, 547070247} ;

/* Regresa el numero random */
float sys_random(void)
{
	long zi, lowprd, hi3l;

        if(seed<=0)
	{
		seed = 0;
        }

        if(seed > 0 && seed < 101)
        {
                zi = zrng[seed];

                lowprd = (zi & 65535) * MULTONE;
                hi3l = (zi >> 16) * MULTONE + (lowprd >> 16);
                zi = ((lowprd & 65535) - MODLUS) + ((hi3l & 32767) << 16) + (hi3l >> 15);

                if(zi < 0) zi += MODLUS;
                lowprd = (zi & 65535) * MULTTWO;
                hi3l = (zi >> 16) * MULTTWO + (lowprd >> 16);
                zi = ((lowprd & 65535)-MODLUS) + ((hi3l &32767) << 16) + (hi3l >> 15);

                if(zi < 0) zi += MODLUS;
                zrng[seed] = zi;

                randomValue = ((zi >> 7 | 1) + 1) / 1667772116.0;
	}
	return randomValue;
}

/* Genera el numero random */
int sys_random_set(void)
{
	long zi, lowprd, hi3l;

	if(argint(0, &seed)<0)
	{
		return -1;
	}
	if(seed > 0 && seed < 101)
	{		
		zi = zrng[seed];
	
		lowprd = (zi & 65535) * MULTONE;
		hi3l = (zi >> 16) * MULTONE + (lowprd >> 16);
		zi = ((lowprd & 65535) - MODLUS) + ((hi3l & 32767) << 16) + (hi3l >> 15);
	
		if(zi < 0) zi += MODLUS;
		lowprd = (zi & 65535) * MULTTWO;
		hi3l = (zi >> 16) * MULTTWO + (lowprd >> 16);
		zi = ((lowprd & 65535)-MODLUS) + ((hi3l &32767) << 16) + (hi3l >> 15);

		if(zi < 0) zi += MODLUS;
		zrng[seed] = zi;
	
		randomValue = ((zi >> 7 | 1) + 1) / 1667772116.0; //¦
	
		return 0;
	}

	else
	{
		return -1;
	}
}

//Cambiamos el valor de la semilla solicitada
int sys_change_seed (void)
{
	int stream;
	argint(0, &stream);
	
	int  set;
	argint(1, &set);

	if(argint(0, &stream) < 0 )
	{
		return -1;
	}	

	if(argint(1, &set) < 0)
	{
		return -1;
	}

	zrng[stream] = set;
	
	return 0;
}

//Regresa el zrng actual del stream 
int sys_actual_seed ()
{
	int stream;
	if(argint(0, &stream) < 0)
	{
		return -1;
	}
	return (int)zrng[stream];
} 
