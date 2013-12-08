
_seed_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char** argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
	if(argc == 2)
   9:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
   d:	75 3a                	jne    49 <main+0x49>
	{
		long index = atoi(argv[1]);
   f:	8b 45 0c             	mov    0xc(%ebp),%eax
  12:	83 c0 04             	add    $0x4,%eax
  15:	8b 00                	mov    (%eax),%eax
  17:	89 04 24             	mov    %eax,(%esp)
  1a:	e8 74 02 00 00       	call   293 <atoi>
  1f:	89 44 24 1c          	mov    %eax,0x1c(%esp)
		printf(1, "%d\n", actual_seed(index));
  23:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  27:	89 04 24             	mov    %eax,(%esp)
  2a:	e8 ad 03 00 00       	call   3dc <actual_seed>
  2f:	89 44 24 08          	mov    %eax,0x8(%esp)
  33:	c7 44 24 04 80 08 00 	movl   $0x880,0x4(%esp)
  3a:	00 
  3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  42:	e8 74 04 00 00       	call   4bb <printf>
  47:	eb 70                	jmp    b9 <main+0xb9>
	}

	else if(argc == 3)
  49:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  4d:	75 56                	jne    a5 <main+0xa5>
	{
		int  index = atoi(argv[1]);
  4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  52:	83 c0 04             	add    $0x4,%eax
  55:	8b 00                	mov    (%eax),%eax
  57:	89 04 24             	mov    %eax,(%esp)
  5a:	e8 34 02 00 00       	call   293 <atoi>
  5f:	89 44 24 18          	mov    %eax,0x18(%esp)
		long  set = atoi(argv[2]);
  63:	8b 45 0c             	mov    0xc(%ebp),%eax
  66:	83 c0 08             	add    $0x8,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	89 04 24             	mov    %eax,(%esp)
  6e:	e8 20 02 00 00       	call   293 <atoi>
  73:	89 44 24 14          	mov    %eax,0x14(%esp)
		
		if(change_seed(index, set) < 0)
  77:	8b 44 24 14          	mov    0x14(%esp),%eax
  7b:	89 44 24 04          	mov    %eax,0x4(%esp)
  7f:	8b 44 24 18          	mov    0x18(%esp),%eax
  83:	89 04 24             	mov    %eax,(%esp)
  86:	e8 49 03 00 00       	call   3d4 <change_seed>
  8b:	85 c0                	test   %eax,%eax
  8d:	79 2a                	jns    b9 <main+0xb9>
		{
			printf(2, "Cannot change seed");
  8f:	c7 44 24 04 84 08 00 	movl   $0x884,0x4(%esp)
  96:	00 
  97:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  9e:	e8 18 04 00 00       	call   4bb <printf>
  a3:	eb 14                	jmp    b9 <main+0xb9>
		
	}

	else
	{
		printf(2, "seed_test format could be seed_test int or seed_test int long");
  a5:	c7 44 24 04 98 08 00 	movl   $0x898,0x4(%esp)
  ac:	00 
  ad:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b4:	e8 02 04 00 00       	call   4bb <printf>
	}

	exit();
  b9:	e8 66 02 00 00       	call   324 <exit>
  be:	90                   	nop
  bf:	90                   	nop

000000c0 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c8:	8b 55 10             	mov    0x10(%ebp),%edx
  cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ce:	89 cb                	mov    %ecx,%ebx
  d0:	89 df                	mov    %ebx,%edi
  d2:	89 d1                	mov    %edx,%ecx
  d4:	fc                   	cld    
  d5:	f3 aa                	rep stos %al,%es:(%edi)
  d7:	89 ca                	mov    %ecx,%edx
  d9:	89 fb                	mov    %edi,%ebx
  db:	89 5d 08             	mov    %ebx,0x8(%ebp)
  de:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  e1:	5b                   	pop    %ebx
  e2:	5f                   	pop    %edi
  e3:	5d                   	pop    %ebp
  e4:	c3                   	ret    

000000e5 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  e5:	55                   	push   %ebp
  e6:	89 e5                	mov    %esp,%ebp
  e8:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  eb:	8b 45 08             	mov    0x8(%ebp),%eax
  ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  f1:	90                   	nop
  f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  f5:	0f b6 10             	movzbl (%eax),%edx
  f8:	8b 45 08             	mov    0x8(%ebp),%eax
  fb:	88 10                	mov    %dl,(%eax)
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 00             	movzbl (%eax),%eax
 103:	84 c0                	test   %al,%al
 105:	0f 95 c0             	setne  %al
 108:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 10c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 110:	84 c0                	test   %al,%al
 112:	75 de                	jne    f2 <strcpy+0xd>
    ;
  return os;
 114:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 117:	c9                   	leave  
 118:	c3                   	ret    

00000119 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 119:	55                   	push   %ebp
 11a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 11c:	eb 08                	jmp    126 <strcmp+0xd>
    p++, q++;
 11e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 122:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	0f b6 00             	movzbl (%eax),%eax
 12c:	84 c0                	test   %al,%al
 12e:	74 10                	je     140 <strcmp+0x27>
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	0f b6 10             	movzbl (%eax),%edx
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	0f b6 00             	movzbl (%eax),%eax
 13c:	38 c2                	cmp    %al,%dl
 13e:	74 de                	je     11e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 140:	8b 45 08             	mov    0x8(%ebp),%eax
 143:	0f b6 00             	movzbl (%eax),%eax
 146:	0f b6 d0             	movzbl %al,%edx
 149:	8b 45 0c             	mov    0xc(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	0f b6 c0             	movzbl %al,%eax
 152:	89 d1                	mov    %edx,%ecx
 154:	29 c1                	sub    %eax,%ecx
 156:	89 c8                	mov    %ecx,%eax
}
 158:	5d                   	pop    %ebp
 159:	c3                   	ret    

0000015a <strlen>:

uint
strlen(char *s)
{
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 160:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 167:	eb 04                	jmp    16d <strlen+0x13>
 169:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 16d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 170:	03 45 08             	add    0x8(%ebp),%eax
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	84 c0                	test   %al,%al
 178:	75 ef                	jne    169 <strlen+0xf>
    ;
  return n;
 17a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17d:	c9                   	leave  
 17e:	c3                   	ret    

0000017f <memset>:

void*
memset(void *dst, int c, uint n)
{
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
 182:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 185:	8b 45 10             	mov    0x10(%ebp),%eax
 188:	89 44 24 08          	mov    %eax,0x8(%esp)
 18c:	8b 45 0c             	mov    0xc(%ebp),%eax
 18f:	89 44 24 04          	mov    %eax,0x4(%esp)
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	89 04 24             	mov    %eax,(%esp)
 199:	e8 22 ff ff ff       	call   c0 <stosb>
  return dst;
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a1:	c9                   	leave  
 1a2:	c3                   	ret    

000001a3 <strchr>:

char*
strchr(const char *s, char c)
{
 1a3:	55                   	push   %ebp
 1a4:	89 e5                	mov    %esp,%ebp
 1a6:	83 ec 04             	sub    $0x4,%esp
 1a9:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ac:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1af:	eb 14                	jmp    1c5 <strchr+0x22>
    if(*s == c)
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	0f b6 00             	movzbl (%eax),%eax
 1b7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ba:	75 05                	jne    1c1 <strchr+0x1e>
      return (char*)s;
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
 1bf:	eb 13                	jmp    1d4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	0f b6 00             	movzbl (%eax),%eax
 1cb:	84 c0                	test   %al,%al
 1cd:	75 e2                	jne    1b1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1d4:	c9                   	leave  
 1d5:	c3                   	ret    

000001d6 <gets>:

char*
gets(char *buf, int max)
{
 1d6:	55                   	push   %ebp
 1d7:	89 e5                	mov    %esp,%ebp
 1d9:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1e3:	eb 44                	jmp    229 <gets+0x53>
    cc = read(0, &c, 1);
 1e5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1ec:	00 
 1ed:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1f0:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1fb:	e8 3c 01 00 00       	call   33c <read>
 200:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 203:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 207:	7e 2d                	jle    236 <gets+0x60>
      break;
    buf[i++] = c;
 209:	8b 45 f4             	mov    -0xc(%ebp),%eax
 20c:	03 45 08             	add    0x8(%ebp),%eax
 20f:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 213:	88 10                	mov    %dl,(%eax)
 215:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 219:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 21d:	3c 0a                	cmp    $0xa,%al
 21f:	74 16                	je     237 <gets+0x61>
 221:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 225:	3c 0d                	cmp    $0xd,%al
 227:	74 0e                	je     237 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 229:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22c:	83 c0 01             	add    $0x1,%eax
 22f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 232:	7c b1                	jl     1e5 <gets+0xf>
 234:	eb 01                	jmp    237 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 236:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 237:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23a:	03 45 08             	add    0x8(%ebp),%eax
 23d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 240:	8b 45 08             	mov    0x8(%ebp),%eax
}
 243:	c9                   	leave  
 244:	c3                   	ret    

00000245 <stat>:

int
stat(char *n, struct stat *st)
{
 245:	55                   	push   %ebp
 246:	89 e5                	mov    %esp,%ebp
 248:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 24b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 252:	00 
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	89 04 24             	mov    %eax,(%esp)
 259:	e8 06 01 00 00       	call   364 <open>
 25e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 261:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 265:	79 07                	jns    26e <stat+0x29>
    return -1;
 267:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 26c:	eb 23                	jmp    291 <stat+0x4c>
  r = fstat(fd, st);
 26e:	8b 45 0c             	mov    0xc(%ebp),%eax
 271:	89 44 24 04          	mov    %eax,0x4(%esp)
 275:	8b 45 f4             	mov    -0xc(%ebp),%eax
 278:	89 04 24             	mov    %eax,(%esp)
 27b:	e8 fc 00 00 00       	call   37c <fstat>
 280:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 283:	8b 45 f4             	mov    -0xc(%ebp),%eax
 286:	89 04 24             	mov    %eax,(%esp)
 289:	e8 be 00 00 00       	call   34c <close>
  return r;
 28e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 291:	c9                   	leave  
 292:	c3                   	ret    

00000293 <atoi>:

int
atoi(const char *s)
{
 293:	55                   	push   %ebp
 294:	89 e5                	mov    %esp,%ebp
 296:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 299:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2a0:	eb 23                	jmp    2c5 <atoi+0x32>
    n = n*10 + *s++ - '0';
 2a2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2a5:	89 d0                	mov    %edx,%eax
 2a7:	c1 e0 02             	shl    $0x2,%eax
 2aa:	01 d0                	add    %edx,%eax
 2ac:	01 c0                	add    %eax,%eax
 2ae:	89 c2                	mov    %eax,%edx
 2b0:	8b 45 08             	mov    0x8(%ebp),%eax
 2b3:	0f b6 00             	movzbl (%eax),%eax
 2b6:	0f be c0             	movsbl %al,%eax
 2b9:	01 d0                	add    %edx,%eax
 2bb:	83 e8 30             	sub    $0x30,%eax
 2be:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
 2c8:	0f b6 00             	movzbl (%eax),%eax
 2cb:	3c 2f                	cmp    $0x2f,%al
 2cd:	7e 0a                	jle    2d9 <atoi+0x46>
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	0f b6 00             	movzbl (%eax),%eax
 2d5:	3c 39                	cmp    $0x39,%al
 2d7:	7e c9                	jle    2a2 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2dc:	c9                   	leave  
 2dd:	c3                   	ret    

000002de <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2de:	55                   	push   %ebp
 2df:	89 e5                	mov    %esp,%ebp
 2e1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ed:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2f0:	eb 13                	jmp    305 <memmove+0x27>
    *dst++ = *src++;
 2f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2f5:	0f b6 10             	movzbl (%eax),%edx
 2f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2fb:	88 10                	mov    %dl,(%eax)
 2fd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 301:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 305:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 309:	0f 9f c0             	setg   %al
 30c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 310:	84 c0                	test   %al,%al
 312:	75 de                	jne    2f2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 314:	8b 45 08             	mov    0x8(%ebp),%eax
}
 317:	c9                   	leave  
 318:	c3                   	ret    
 319:	90                   	nop
 31a:	90                   	nop
 31b:	90                   	nop

0000031c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31c:	b8 01 00 00 00       	mov    $0x1,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <exit>:
SYSCALL(exit)
 324:	b8 02 00 00 00       	mov    $0x2,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <wait>:
SYSCALL(wait)
 32c:	b8 03 00 00 00       	mov    $0x3,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <pipe>:
SYSCALL(pipe)
 334:	b8 04 00 00 00       	mov    $0x4,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <read>:
SYSCALL(read)
 33c:	b8 05 00 00 00       	mov    $0x5,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <write>:
SYSCALL(write)
 344:	b8 10 00 00 00       	mov    $0x10,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <close>:
SYSCALL(close)
 34c:	b8 15 00 00 00       	mov    $0x15,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <kill>:
SYSCALL(kill)
 354:	b8 06 00 00 00       	mov    $0x6,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <exec>:
SYSCALL(exec)
 35c:	b8 07 00 00 00       	mov    $0x7,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <open>:
SYSCALL(open)
 364:	b8 0f 00 00 00       	mov    $0xf,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <mknod>:
SYSCALL(mknod)
 36c:	b8 11 00 00 00       	mov    $0x11,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <unlink>:
SYSCALL(unlink)
 374:	b8 12 00 00 00       	mov    $0x12,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <fstat>:
SYSCALL(fstat)
 37c:	b8 08 00 00 00       	mov    $0x8,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <link>:
SYSCALL(link)
 384:	b8 13 00 00 00       	mov    $0x13,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <mkdir>:
SYSCALL(mkdir)
 38c:	b8 14 00 00 00       	mov    $0x14,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <chdir>:
SYSCALL(chdir)
 394:	b8 09 00 00 00       	mov    $0x9,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <dup>:
SYSCALL(dup)
 39c:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <getpid>:
SYSCALL(getpid)
 3a4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <sbrk>:
SYSCALL(sbrk)
 3ac:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <sleep>:
SYSCALL(sleep)
 3b4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <uptime>:
SYSCALL(uptime)
 3bc:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <random>:
SYSCALL(random)
 3c4:	b8 16 00 00 00       	mov    $0x16,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <random_set>:
SYSCALL(random_set)
 3cc:	b8 17 00 00 00       	mov    $0x17,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <change_seed>:
SYSCALL(change_seed)
 3d4:	b8 18 00 00 00       	mov    $0x18,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <actual_seed>:
SYSCALL(actual_seed)
 3dc:	b8 19 00 00 00       	mov    $0x19,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	83 ec 28             	sub    $0x28,%esp
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f7:	00 
 3f8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
 402:	89 04 24             	mov    %eax,(%esp)
 405:	e8 3a ff ff ff       	call   344 <write>
}
 40a:	c9                   	leave  
 40b:	c3                   	ret    

0000040c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 412:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 419:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41d:	74 17                	je     436 <printint+0x2a>
 41f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 423:	79 11                	jns    436 <printint+0x2a>
    neg = 1;
 425:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 42c:	8b 45 0c             	mov    0xc(%ebp),%eax
 42f:	f7 d8                	neg    %eax
 431:	89 45 ec             	mov    %eax,-0x14(%ebp)
 434:	eb 06                	jmp    43c <printint+0x30>
  } else {
    x = xx;
 436:	8b 45 0c             	mov    0xc(%ebp),%eax
 439:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 43c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 443:	8b 4d 10             	mov    0x10(%ebp),%ecx
 446:	8b 45 ec             	mov    -0x14(%ebp),%eax
 449:	ba 00 00 00 00       	mov    $0x0,%edx
 44e:	f7 f1                	div    %ecx
 450:	89 d0                	mov    %edx,%eax
 452:	0f b6 90 1c 0b 00 00 	movzbl 0xb1c(%eax),%edx
 459:	8d 45 dc             	lea    -0x24(%ebp),%eax
 45c:	03 45 f4             	add    -0xc(%ebp),%eax
 45f:	88 10                	mov    %dl,(%eax)
 461:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 465:	8b 55 10             	mov    0x10(%ebp),%edx
 468:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 46b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46e:	ba 00 00 00 00       	mov    $0x0,%edx
 473:	f7 75 d4             	divl   -0x2c(%ebp)
 476:	89 45 ec             	mov    %eax,-0x14(%ebp)
 479:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47d:	75 c4                	jne    443 <printint+0x37>
  if(neg)
 47f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 483:	74 2a                	je     4af <printint+0xa3>
    buf[i++] = '-';
 485:	8d 45 dc             	lea    -0x24(%ebp),%eax
 488:	03 45 f4             	add    -0xc(%ebp),%eax
 48b:	c6 00 2d             	movb   $0x2d,(%eax)
 48e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 492:	eb 1b                	jmp    4af <printint+0xa3>
    putc(fd, buf[i]);
 494:	8d 45 dc             	lea    -0x24(%ebp),%eax
 497:	03 45 f4             	add    -0xc(%ebp),%eax
 49a:	0f b6 00             	movzbl (%eax),%eax
 49d:	0f be c0             	movsbl %al,%eax
 4a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a4:	8b 45 08             	mov    0x8(%ebp),%eax
 4a7:	89 04 24             	mov    %eax,(%esp)
 4aa:	e8 35 ff ff ff       	call   3e4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4af:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b7:	79 db                	jns    494 <printint+0x88>
    putc(fd, buf[i]);
}
 4b9:	c9                   	leave  
 4ba:	c3                   	ret    

000004bb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4bb:	55                   	push   %ebp
 4bc:	89 e5                	mov    %esp,%ebp
 4be:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4cb:	83 c0 04             	add    $0x4,%eax
 4ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d8:	e9 7d 01 00 00       	jmp    65a <printf+0x19f>
    c = fmt[i] & 0xff;
 4dd:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e3:	01 d0                	add    %edx,%eax
 4e5:	0f b6 00             	movzbl (%eax),%eax
 4e8:	0f be c0             	movsbl %al,%eax
 4eb:	25 ff 00 00 00       	and    $0xff,%eax
 4f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f7:	75 2c                	jne    525 <printf+0x6a>
      if(c == '%'){
 4f9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4fd:	75 0c                	jne    50b <printf+0x50>
        state = '%';
 4ff:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 506:	e9 4b 01 00 00       	jmp    656 <printf+0x19b>
      } else {
        putc(fd, c);
 50b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50e:	0f be c0             	movsbl %al,%eax
 511:	89 44 24 04          	mov    %eax,0x4(%esp)
 515:	8b 45 08             	mov    0x8(%ebp),%eax
 518:	89 04 24             	mov    %eax,(%esp)
 51b:	e8 c4 fe ff ff       	call   3e4 <putc>
 520:	e9 31 01 00 00       	jmp    656 <printf+0x19b>
      }
    } else if(state == '%'){
 525:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 529:	0f 85 27 01 00 00    	jne    656 <printf+0x19b>
      if(c == 'd'){
 52f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 533:	75 2d                	jne    562 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 535:	8b 45 e8             	mov    -0x18(%ebp),%eax
 538:	8b 00                	mov    (%eax),%eax
 53a:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 541:	00 
 542:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 549:	00 
 54a:	89 44 24 04          	mov    %eax,0x4(%esp)
 54e:	8b 45 08             	mov    0x8(%ebp),%eax
 551:	89 04 24             	mov    %eax,(%esp)
 554:	e8 b3 fe ff ff       	call   40c <printint>
        ap++;
 559:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55d:	e9 ed 00 00 00       	jmp    64f <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 562:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 566:	74 06                	je     56e <printf+0xb3>
 568:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 56c:	75 2d                	jne    59b <printf+0xe0>
        printint(fd, *ap, 16, 0);
 56e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 571:	8b 00                	mov    (%eax),%eax
 573:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 57a:	00 
 57b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 582:	00 
 583:	89 44 24 04          	mov    %eax,0x4(%esp)
 587:	8b 45 08             	mov    0x8(%ebp),%eax
 58a:	89 04 24             	mov    %eax,(%esp)
 58d:	e8 7a fe ff ff       	call   40c <printint>
        ap++;
 592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 596:	e9 b4 00 00 00       	jmp    64f <printf+0x194>
      } else if(c == 's'){
 59b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 59f:	75 46                	jne    5e7 <printf+0x12c>
        s = (char*)*ap;
 5a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a4:	8b 00                	mov    (%eax),%eax
 5a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5b1:	75 27                	jne    5da <printf+0x11f>
          s = "(null)";
 5b3:	c7 45 f4 d6 08 00 00 	movl   $0x8d6,-0xc(%ebp)
        while(*s != 0){
 5ba:	eb 1e                	jmp    5da <printf+0x11f>
          putc(fd, *s);
 5bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bf:	0f b6 00             	movzbl (%eax),%eax
 5c2:	0f be c0             	movsbl %al,%eax
 5c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c9:	8b 45 08             	mov    0x8(%ebp),%eax
 5cc:	89 04 24             	mov    %eax,(%esp)
 5cf:	e8 10 fe ff ff       	call   3e4 <putc>
          s++;
 5d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5d8:	eb 01                	jmp    5db <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5da:	90                   	nop
 5db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5de:	0f b6 00             	movzbl (%eax),%eax
 5e1:	84 c0                	test   %al,%al
 5e3:	75 d7                	jne    5bc <printf+0x101>
 5e5:	eb 68                	jmp    64f <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5e7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5eb:	75 1d                	jne    60a <printf+0x14f>
        putc(fd, *ap);
 5ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f0:	8b 00                	mov    (%eax),%eax
 5f2:	0f be c0             	movsbl %al,%eax
 5f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f9:	8b 45 08             	mov    0x8(%ebp),%eax
 5fc:	89 04 24             	mov    %eax,(%esp)
 5ff:	e8 e0 fd ff ff       	call   3e4 <putc>
        ap++;
 604:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 608:	eb 45                	jmp    64f <printf+0x194>
      } else if(c == '%'){
 60a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60e:	75 17                	jne    627 <printf+0x16c>
        putc(fd, c);
 610:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 613:	0f be c0             	movsbl %al,%eax
 616:	89 44 24 04          	mov    %eax,0x4(%esp)
 61a:	8b 45 08             	mov    0x8(%ebp),%eax
 61d:	89 04 24             	mov    %eax,(%esp)
 620:	e8 bf fd ff ff       	call   3e4 <putc>
 625:	eb 28                	jmp    64f <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 627:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 62e:	00 
 62f:	8b 45 08             	mov    0x8(%ebp),%eax
 632:	89 04 24             	mov    %eax,(%esp)
 635:	e8 aa fd ff ff       	call   3e4 <putc>
        putc(fd, c);
 63a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63d:	0f be c0             	movsbl %al,%eax
 640:	89 44 24 04          	mov    %eax,0x4(%esp)
 644:	8b 45 08             	mov    0x8(%ebp),%eax
 647:	89 04 24             	mov    %eax,(%esp)
 64a:	e8 95 fd ff ff       	call   3e4 <putc>
      }
      state = 0;
 64f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 656:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 65a:	8b 55 0c             	mov    0xc(%ebp),%edx
 65d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 660:	01 d0                	add    %edx,%eax
 662:	0f b6 00             	movzbl (%eax),%eax
 665:	84 c0                	test   %al,%al
 667:	0f 85 70 fe ff ff    	jne    4dd <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 66d:	c9                   	leave  
 66e:	c3                   	ret    
 66f:	90                   	nop

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 676:	8b 45 08             	mov    0x8(%ebp),%eax
 679:	83 e8 08             	sub    $0x8,%eax
 67c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67f:	a1 38 0b 00 00       	mov    0xb38,%eax
 684:	89 45 fc             	mov    %eax,-0x4(%ebp)
 687:	eb 24                	jmp    6ad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 691:	77 12                	ja     6a5 <free+0x35>
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 699:	77 24                	ja     6bf <free+0x4f>
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a3:	77 1a                	ja     6bf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 00                	mov    (%eax),%eax
 6aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6b3:	76 d4                	jbe    689 <free+0x19>
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6bd:	76 ca                	jbe    689 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c2:	8b 40 04             	mov    0x4(%eax),%eax
 6c5:	c1 e0 03             	shl    $0x3,%eax
 6c8:	89 c2                	mov    %eax,%edx
 6ca:	03 55 f8             	add    -0x8(%ebp),%edx
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 00                	mov    (%eax),%eax
 6d2:	39 c2                	cmp    %eax,%edx
 6d4:	75 24                	jne    6fa <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d9:	8b 50 04             	mov    0x4(%eax),%edx
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 00                	mov    (%eax),%eax
 6e1:	8b 40 04             	mov    0x4(%eax),%eax
 6e4:	01 c2                	add    %eax,%edx
 6e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 00                	mov    (%eax),%eax
 6f1:	8b 10                	mov    (%eax),%edx
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	89 10                	mov    %edx,(%eax)
 6f8:	eb 0a                	jmp    704 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fd:	8b 10                	mov    (%eax),%edx
 6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 702:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 40 04             	mov    0x4(%eax),%eax
 70a:	c1 e0 03             	shl    $0x3,%eax
 70d:	03 45 fc             	add    -0x4(%ebp),%eax
 710:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 713:	75 20                	jne    735 <free+0xc5>
    p->s.size += bp->s.size;
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	8b 50 04             	mov    0x4(%eax),%edx
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	8b 40 04             	mov    0x4(%eax),%eax
 721:	01 c2                	add    %eax,%edx
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 729:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72c:	8b 10                	mov    (%eax),%edx
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	89 10                	mov    %edx,(%eax)
 733:	eb 08                	jmp    73d <free+0xcd>
  } else
    p->s.ptr = bp;
 735:	8b 45 fc             	mov    -0x4(%ebp),%eax
 738:	8b 55 f8             	mov    -0x8(%ebp),%edx
 73b:	89 10                	mov    %edx,(%eax)
  freep = p;
 73d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 740:	a3 38 0b 00 00       	mov    %eax,0xb38
}
 745:	c9                   	leave  
 746:	c3                   	ret    

00000747 <morecore>:

static Header*
morecore(uint nu)
{
 747:	55                   	push   %ebp
 748:	89 e5                	mov    %esp,%ebp
 74a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 74d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 754:	77 07                	ja     75d <morecore+0x16>
    nu = 4096;
 756:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 75d:	8b 45 08             	mov    0x8(%ebp),%eax
 760:	c1 e0 03             	shl    $0x3,%eax
 763:	89 04 24             	mov    %eax,(%esp)
 766:	e8 41 fc ff ff       	call   3ac <sbrk>
 76b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 772:	75 07                	jne    77b <morecore+0x34>
    return 0;
 774:	b8 00 00 00 00       	mov    $0x0,%eax
 779:	eb 22                	jmp    79d <morecore+0x56>
  hp = (Header*)p;
 77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	8b 55 08             	mov    0x8(%ebp),%edx
 787:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	83 c0 08             	add    $0x8,%eax
 790:	89 04 24             	mov    %eax,(%esp)
 793:	e8 d8 fe ff ff       	call   670 <free>
  return freep;
 798:	a1 38 0b 00 00       	mov    0xb38,%eax
}
 79d:	c9                   	leave  
 79e:	c3                   	ret    

0000079f <malloc>:

void*
malloc(uint nbytes)
{
 79f:	55                   	push   %ebp
 7a0:	89 e5                	mov    %esp,%ebp
 7a2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a5:	8b 45 08             	mov    0x8(%ebp),%eax
 7a8:	83 c0 07             	add    $0x7,%eax
 7ab:	c1 e8 03             	shr    $0x3,%eax
 7ae:	83 c0 01             	add    $0x1,%eax
 7b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b4:	a1 38 0b 00 00       	mov    0xb38,%eax
 7b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c0:	75 23                	jne    7e5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c2:	c7 45 f0 30 0b 00 00 	movl   $0xb30,-0x10(%ebp)
 7c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cc:	a3 38 0b 00 00       	mov    %eax,0xb38
 7d1:	a1 38 0b 00 00       	mov    0xb38,%eax
 7d6:	a3 30 0b 00 00       	mov    %eax,0xb30
    base.s.size = 0;
 7db:	c7 05 34 0b 00 00 00 	movl   $0x0,0xb34
 7e2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	8b 00                	mov    (%eax),%eax
 7ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	8b 40 04             	mov    0x4(%eax),%eax
 7f3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f6:	72 4d                	jb     845 <malloc+0xa6>
      if(p->s.size == nunits)
 7f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fb:	8b 40 04             	mov    0x4(%eax),%eax
 7fe:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 801:	75 0c                	jne    80f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	8b 10                	mov    (%eax),%edx
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	89 10                	mov    %edx,(%eax)
 80d:	eb 26                	jmp    835 <malloc+0x96>
      else {
        p->s.size -= nunits;
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	89 c2                	mov    %eax,%edx
 817:	2b 55 ec             	sub    -0x14(%ebp),%edx
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 820:	8b 45 f4             	mov    -0xc(%ebp),%eax
 823:	8b 40 04             	mov    0x4(%eax),%eax
 826:	c1 e0 03             	shl    $0x3,%eax
 829:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 832:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 835:	8b 45 f0             	mov    -0x10(%ebp),%eax
 838:	a3 38 0b 00 00       	mov    %eax,0xb38
      return (void*)(p + 1);
 83d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 840:	83 c0 08             	add    $0x8,%eax
 843:	eb 38                	jmp    87d <malloc+0xde>
    }
    if(p == freep)
 845:	a1 38 0b 00 00       	mov    0xb38,%eax
 84a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 84d:	75 1b                	jne    86a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 84f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 852:	89 04 24             	mov    %eax,(%esp)
 855:	e8 ed fe ff ff       	call   747 <morecore>
 85a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 861:	75 07                	jne    86a <malloc+0xcb>
        return 0;
 863:	b8 00 00 00 00       	mov    $0x0,%eax
 868:	eb 13                	jmp    87d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 870:	8b 45 f4             	mov    -0xc(%ebp),%eax
 873:	8b 00                	mov    (%eax),%eax
 875:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 878:	e9 70 ff ff ff       	jmp    7ed <malloc+0x4e>
}
 87d:	c9                   	leave  
 87e:	c3                   	ret    
