
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 72 02 00 00       	call   280 <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 fa 02 00 00       	call   318 <sleep>
  exit();
  1e:	e8 65 02 00 00       	call   288 <exit>
  23:	90                   	nop

00000024 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	57                   	push   %edi
  28:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  29:	8b 4d 08             	mov    0x8(%ebp),%ecx
  2c:	8b 55 10             	mov    0x10(%ebp),%edx
  2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  32:	89 cb                	mov    %ecx,%ebx
  34:	89 df                	mov    %ebx,%edi
  36:	89 d1                	mov    %edx,%ecx
  38:	fc                   	cld    
  39:	f3 aa                	rep stos %al,%es:(%edi)
  3b:	89 ca                	mov    %ecx,%edx
  3d:	89 fb                	mov    %edi,%ebx
  3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  42:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  45:	5b                   	pop    %ebx
  46:	5f                   	pop    %edi
  47:	5d                   	pop    %ebp
  48:	c3                   	ret    

00000049 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  49:	55                   	push   %ebp
  4a:	89 e5                	mov    %esp,%ebp
  4c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  4f:	8b 45 08             	mov    0x8(%ebp),%eax
  52:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  55:	90                   	nop
  56:	8b 45 0c             	mov    0xc(%ebp),%eax
  59:	0f b6 10             	movzbl (%eax),%edx
  5c:	8b 45 08             	mov    0x8(%ebp),%eax
  5f:	88 10                	mov    %dl,(%eax)
  61:	8b 45 08             	mov    0x8(%ebp),%eax
  64:	0f b6 00             	movzbl (%eax),%eax
  67:	84 c0                	test   %al,%al
  69:	0f 95 c0             	setne  %al
  6c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  70:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  74:	84 c0                	test   %al,%al
  76:	75 de                	jne    56 <strcpy+0xd>
    ;
  return os;
  78:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7b:	c9                   	leave  
  7c:	c3                   	ret    

0000007d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7d:	55                   	push   %ebp
  7e:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  80:	eb 08                	jmp    8a <strcmp+0xd>
    p++, q++;
  82:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  86:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8a:	8b 45 08             	mov    0x8(%ebp),%eax
  8d:	0f b6 00             	movzbl (%eax),%eax
  90:	84 c0                	test   %al,%al
  92:	74 10                	je     a4 <strcmp+0x27>
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	0f b6 10             	movzbl (%eax),%edx
  9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  9d:	0f b6 00             	movzbl (%eax),%eax
  a0:	38 c2                	cmp    %al,%dl
  a2:	74 de                	je     82 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	0f b6 00             	movzbl (%eax),%eax
  aa:	0f b6 d0             	movzbl %al,%edx
  ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	0f b6 c0             	movzbl %al,%eax
  b6:	89 d1                	mov    %edx,%ecx
  b8:	29 c1                	sub    %eax,%ecx
  ba:	89 c8                	mov    %ecx,%eax
}
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    

000000be <strlen>:

uint
strlen(char *s)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  cb:	eb 04                	jmp    d1 <strlen+0x13>
  cd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d4:	03 45 08             	add    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	75 ef                	jne    cd <strlen+0xf>
    ;
  return n;
  de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e1:	c9                   	leave  
  e2:	c3                   	ret    

000000e3 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
  e9:	8b 45 10             	mov    0x10(%ebp),%eax
  ec:	89 44 24 08          	mov    %eax,0x8(%esp)
  f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	89 04 24             	mov    %eax,(%esp)
  fd:	e8 22 ff ff ff       	call   24 <stosb>
  return dst;
 102:	8b 45 08             	mov    0x8(%ebp),%eax
}
 105:	c9                   	leave  
 106:	c3                   	ret    

00000107 <strchr>:

char*
strchr(const char *s, char c)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 04             	sub    $0x4,%esp
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 113:	eb 14                	jmp    129 <strchr+0x22>
    if(*s == c)
 115:	8b 45 08             	mov    0x8(%ebp),%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11e:	75 05                	jne    125 <strchr+0x1e>
      return (char*)s;
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	eb 13                	jmp    138 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 125:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	0f b6 00             	movzbl (%eax),%eax
 12f:	84 c0                	test   %al,%al
 131:	75 e2                	jne    115 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 133:	b8 00 00 00 00       	mov    $0x0,%eax
}
 138:	c9                   	leave  
 139:	c3                   	ret    

0000013a <gets>:

char*
gets(char *buf, int max)
{
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 140:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 147:	eb 44                	jmp    18d <gets+0x53>
    cc = read(0, &c, 1);
 149:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 150:	00 
 151:	8d 45 ef             	lea    -0x11(%ebp),%eax
 154:	89 44 24 04          	mov    %eax,0x4(%esp)
 158:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15f:	e8 3c 01 00 00       	call   2a0 <read>
 164:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 167:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16b:	7e 2d                	jle    19a <gets+0x60>
      break;
    buf[i++] = c;
 16d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 170:	03 45 08             	add    0x8(%ebp),%eax
 173:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 177:	88 10                	mov    %dl,(%eax)
 179:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(c == '\n' || c == '\r')
 17d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 181:	3c 0a                	cmp    $0xa,%al
 183:	74 16                	je     19b <gets+0x61>
 185:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 189:	3c 0d                	cmp    $0xd,%al
 18b:	74 0e                	je     19b <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 190:	83 c0 01             	add    $0x1,%eax
 193:	3b 45 0c             	cmp    0xc(%ebp),%eax
 196:	7c b1                	jl     149 <gets+0xf>
 198:	eb 01                	jmp    19b <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 19b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19e:	03 45 08             	add    0x8(%ebp),%eax
 1a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a7:	c9                   	leave  
 1a8:	c3                   	ret    

000001a9 <stat>:

int
stat(char *n, struct stat *st)
{
 1a9:	55                   	push   %ebp
 1aa:	89 e5                	mov    %esp,%ebp
 1ac:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b6:	00 
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	89 04 24             	mov    %eax,(%esp)
 1bd:	e8 06 01 00 00       	call   2c8 <open>
 1c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c9:	79 07                	jns    1d2 <stat+0x29>
    return -1;
 1cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d0:	eb 23                	jmp    1f5 <stat+0x4c>
  r = fstat(fd, st);
 1d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1dc:	89 04 24             	mov    %eax,(%esp)
 1df:	e8 fc 00 00 00       	call   2e0 <fstat>
 1e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ea:	89 04 24             	mov    %eax,(%esp)
 1ed:	e8 be 00 00 00       	call   2b0 <close>
  return r;
 1f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <atoi>:

int
atoi(const char *s)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 204:	eb 23                	jmp    229 <atoi+0x32>
    n = n*10 + *s++ - '0';
 206:	8b 55 fc             	mov    -0x4(%ebp),%edx
 209:	89 d0                	mov    %edx,%eax
 20b:	c1 e0 02             	shl    $0x2,%eax
 20e:	01 d0                	add    %edx,%eax
 210:	01 c0                	add    %eax,%eax
 212:	89 c2                	mov    %eax,%edx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f be c0             	movsbl %al,%eax
 21d:	01 d0                	add    %edx,%eax
 21f:	83 e8 30             	sub    $0x30,%eax
 222:	89 45 fc             	mov    %eax,-0x4(%ebp)
 225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 229:	8b 45 08             	mov    0x8(%ebp),%eax
 22c:	0f b6 00             	movzbl (%eax),%eax
 22f:	3c 2f                	cmp    $0x2f,%al
 231:	7e 0a                	jle    23d <atoi+0x46>
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	0f b6 00             	movzbl (%eax),%eax
 239:	3c 39                	cmp    $0x39,%al
 23b:	7e c9                	jle    206 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 23d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 240:	c9                   	leave  
 241:	c3                   	ret    

00000242 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 242:	55                   	push   %ebp
 243:	89 e5                	mov    %esp,%ebp
 245:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 254:	eb 13                	jmp    269 <memmove+0x27>
    *dst++ = *src++;
 256:	8b 45 f8             	mov    -0x8(%ebp),%eax
 259:	0f b6 10             	movzbl (%eax),%edx
 25c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25f:	88 10                	mov    %dl,(%eax)
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 269:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 26d:	0f 9f c0             	setg   %al
 270:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 274:	84 c0                	test   %al,%al
 276:	75 de                	jne    256 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 278:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27b:	c9                   	leave  
 27c:	c3                   	ret    
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 280:	b8 01 00 00 00       	mov    $0x1,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <exit>:
SYSCALL(exit)
 288:	b8 02 00 00 00       	mov    $0x2,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <wait>:
SYSCALL(wait)
 290:	b8 03 00 00 00       	mov    $0x3,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <pipe>:
SYSCALL(pipe)
 298:	b8 04 00 00 00       	mov    $0x4,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <read>:
SYSCALL(read)
 2a0:	b8 05 00 00 00       	mov    $0x5,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <write>:
SYSCALL(write)
 2a8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <close>:
SYSCALL(close)
 2b0:	b8 15 00 00 00       	mov    $0x15,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <kill>:
SYSCALL(kill)
 2b8:	b8 06 00 00 00       	mov    $0x6,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <exec>:
SYSCALL(exec)
 2c0:	b8 07 00 00 00       	mov    $0x7,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <open>:
SYSCALL(open)
 2c8:	b8 0f 00 00 00       	mov    $0xf,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <mknod>:
SYSCALL(mknod)
 2d0:	b8 11 00 00 00       	mov    $0x11,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <unlink>:
SYSCALL(unlink)
 2d8:	b8 12 00 00 00       	mov    $0x12,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <fstat>:
SYSCALL(fstat)
 2e0:	b8 08 00 00 00       	mov    $0x8,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <link>:
SYSCALL(link)
 2e8:	b8 13 00 00 00       	mov    $0x13,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <mkdir>:
SYSCALL(mkdir)
 2f0:	b8 14 00 00 00       	mov    $0x14,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <chdir>:
SYSCALL(chdir)
 2f8:	b8 09 00 00 00       	mov    $0x9,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <dup>:
SYSCALL(dup)
 300:	b8 0a 00 00 00       	mov    $0xa,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <getpid>:
SYSCALL(getpid)
 308:	b8 0b 00 00 00       	mov    $0xb,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <sbrk>:
SYSCALL(sbrk)
 310:	b8 0c 00 00 00       	mov    $0xc,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <sleep>:
SYSCALL(sleep)
 318:	b8 0d 00 00 00       	mov    $0xd,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <uptime>:
SYSCALL(uptime)
 320:	b8 0e 00 00 00       	mov    $0xe,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <random>:
SYSCALL(random)
 328:	b8 16 00 00 00       	mov    $0x16,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <random_set>:
SYSCALL(random_set)
 330:	b8 17 00 00 00       	mov    $0x17,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <change_seed>:
SYSCALL(change_seed)
 338:	b8 18 00 00 00       	mov    $0x18,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <actual_seed>:
SYSCALL(actual_seed)
 340:	b8 19 00 00 00       	mov    $0x19,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	83 ec 28             	sub    $0x28,%esp
 34e:	8b 45 0c             	mov    0xc(%ebp),%eax
 351:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 354:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 35b:	00 
 35c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 35f:	89 44 24 04          	mov    %eax,0x4(%esp)
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	89 04 24             	mov    %eax,(%esp)
 369:	e8 3a ff ff ff       	call   2a8 <write>
}
 36e:	c9                   	leave  
 36f:	c3                   	ret    

00000370 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	83 ec 48             	sub    $0x48,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 376:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 37d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 381:	74 17                	je     39a <printint+0x2a>
 383:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 387:	79 11                	jns    39a <printint+0x2a>
    neg = 1;
 389:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 390:	8b 45 0c             	mov    0xc(%ebp),%eax
 393:	f7 d8                	neg    %eax
 395:	89 45 ec             	mov    %eax,-0x14(%ebp)
 398:	eb 06                	jmp    3a0 <printint+0x30>
  } else {
    x = xx;
 39a:	8b 45 0c             	mov    0xc(%ebp),%eax
 39d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ad:	ba 00 00 00 00       	mov    $0x0,%edx
 3b2:	f7 f1                	div    %ecx
 3b4:	89 d0                	mov    %edx,%eax
 3b6:	0f b6 90 28 0a 00 00 	movzbl 0xa28(%eax),%edx
 3bd:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3c0:	03 45 f4             	add    -0xc(%ebp),%eax
 3c3:	88 10                	mov    %dl,(%eax)
 3c5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  }while((x /= base) != 0);
 3c9:	8b 55 10             	mov    0x10(%ebp),%edx
 3cc:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 3cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d2:	ba 00 00 00 00       	mov    $0x0,%edx
 3d7:	f7 75 d4             	divl   -0x2c(%ebp)
 3da:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3dd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3e1:	75 c4                	jne    3a7 <printint+0x37>
  if(neg)
 3e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e7:	74 2a                	je     413 <printint+0xa3>
    buf[i++] = '-';
 3e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3ec:	03 45 f4             	add    -0xc(%ebp),%eax
 3ef:	c6 00 2d             	movb   $0x2d,(%eax)
 3f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  while(--i >= 0)
 3f6:	eb 1b                	jmp    413 <printint+0xa3>
    putc(fd, buf[i]);
 3f8:	8d 45 dc             	lea    -0x24(%ebp),%eax
 3fb:	03 45 f4             	add    -0xc(%ebp),%eax
 3fe:	0f b6 00             	movzbl (%eax),%eax
 401:	0f be c0             	movsbl %al,%eax
 404:	89 44 24 04          	mov    %eax,0x4(%esp)
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	89 04 24             	mov    %eax,(%esp)
 40e:	e8 35 ff ff ff       	call   348 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 413:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 417:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 41b:	79 db                	jns    3f8 <printint+0x88>
    putc(fd, buf[i]);
}
 41d:	c9                   	leave  
 41e:	c3                   	ret    

0000041f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 41f:	55                   	push   %ebp
 420:	89 e5                	mov    %esp,%ebp
 422:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 425:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 42c:	8d 45 0c             	lea    0xc(%ebp),%eax
 42f:	83 c0 04             	add    $0x4,%eax
 432:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 435:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 43c:	e9 7d 01 00 00       	jmp    5be <printf+0x19f>
    c = fmt[i] & 0xff;
 441:	8b 55 0c             	mov    0xc(%ebp),%edx
 444:	8b 45 f0             	mov    -0x10(%ebp),%eax
 447:	01 d0                	add    %edx,%eax
 449:	0f b6 00             	movzbl (%eax),%eax
 44c:	0f be c0             	movsbl %al,%eax
 44f:	25 ff 00 00 00       	and    $0xff,%eax
 454:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 457:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45b:	75 2c                	jne    489 <printf+0x6a>
      if(c == '%'){
 45d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 461:	75 0c                	jne    46f <printf+0x50>
        state = '%';
 463:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 46a:	e9 4b 01 00 00       	jmp    5ba <printf+0x19b>
      } else {
        putc(fd, c);
 46f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 472:	0f be c0             	movsbl %al,%eax
 475:	89 44 24 04          	mov    %eax,0x4(%esp)
 479:	8b 45 08             	mov    0x8(%ebp),%eax
 47c:	89 04 24             	mov    %eax,(%esp)
 47f:	e8 c4 fe ff ff       	call   348 <putc>
 484:	e9 31 01 00 00       	jmp    5ba <printf+0x19b>
      }
    } else if(state == '%'){
 489:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 48d:	0f 85 27 01 00 00    	jne    5ba <printf+0x19b>
      if(c == 'd'){
 493:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 497:	75 2d                	jne    4c6 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 499:	8b 45 e8             	mov    -0x18(%ebp),%eax
 49c:	8b 00                	mov    (%eax),%eax
 49e:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 4a5:	00 
 4a6:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 4ad:	00 
 4ae:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b2:	8b 45 08             	mov    0x8(%ebp),%eax
 4b5:	89 04 24             	mov    %eax,(%esp)
 4b8:	e8 b3 fe ff ff       	call   370 <printint>
        ap++;
 4bd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c1:	e9 ed 00 00 00       	jmp    5b3 <printf+0x194>
      } else if(c == 'x' || c == 'p'){
 4c6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ca:	74 06                	je     4d2 <printf+0xb3>
 4cc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4d0:	75 2d                	jne    4ff <printf+0xe0>
        printint(fd, *ap, 16, 0);
 4d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d5:	8b 00                	mov    (%eax),%eax
 4d7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 4de:	00 
 4df:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 4e6:	00 
 4e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	89 04 24             	mov    %eax,(%esp)
 4f1:	e8 7a fe ff ff       	call   370 <printint>
        ap++;
 4f6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fa:	e9 b4 00 00 00       	jmp    5b3 <printf+0x194>
      } else if(c == 's'){
 4ff:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 503:	75 46                	jne    54b <printf+0x12c>
        s = (char*)*ap;
 505:	8b 45 e8             	mov    -0x18(%ebp),%eax
 508:	8b 00                	mov    (%eax),%eax
 50a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 511:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 515:	75 27                	jne    53e <printf+0x11f>
          s = "(null)";
 517:	c7 45 f4 e3 07 00 00 	movl   $0x7e3,-0xc(%ebp)
        while(*s != 0){
 51e:	eb 1e                	jmp    53e <printf+0x11f>
          putc(fd, *s);
 520:	8b 45 f4             	mov    -0xc(%ebp),%eax
 523:	0f b6 00             	movzbl (%eax),%eax
 526:	0f be c0             	movsbl %al,%eax
 529:	89 44 24 04          	mov    %eax,0x4(%esp)
 52d:	8b 45 08             	mov    0x8(%ebp),%eax
 530:	89 04 24             	mov    %eax,(%esp)
 533:	e8 10 fe ff ff       	call   348 <putc>
          s++;
 538:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 53c:	eb 01                	jmp    53f <printf+0x120>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53e:	90                   	nop
 53f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 542:	0f b6 00             	movzbl (%eax),%eax
 545:	84 c0                	test   %al,%al
 547:	75 d7                	jne    520 <printf+0x101>
 549:	eb 68                	jmp    5b3 <printf+0x194>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54f:	75 1d                	jne    56e <printf+0x14f>
        putc(fd, *ap);
 551:	8b 45 e8             	mov    -0x18(%ebp),%eax
 554:	8b 00                	mov    (%eax),%eax
 556:	0f be c0             	movsbl %al,%eax
 559:	89 44 24 04          	mov    %eax,0x4(%esp)
 55d:	8b 45 08             	mov    0x8(%ebp),%eax
 560:	89 04 24             	mov    %eax,(%esp)
 563:	e8 e0 fd ff ff       	call   348 <putc>
        ap++;
 568:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56c:	eb 45                	jmp    5b3 <printf+0x194>
      } else if(c == '%'){
 56e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 572:	75 17                	jne    58b <printf+0x16c>
        putc(fd, c);
 574:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 577:	0f be c0             	movsbl %al,%eax
 57a:	89 44 24 04          	mov    %eax,0x4(%esp)
 57e:	8b 45 08             	mov    0x8(%ebp),%eax
 581:	89 04 24             	mov    %eax,(%esp)
 584:	e8 bf fd ff ff       	call   348 <putc>
 589:	eb 28                	jmp    5b3 <printf+0x194>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58b:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 592:	00 
 593:	8b 45 08             	mov    0x8(%ebp),%eax
 596:	89 04 24             	mov    %eax,(%esp)
 599:	e8 aa fd ff ff       	call   348 <putc>
        putc(fd, c);
 59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
 5ab:	89 04 24             	mov    %eax,(%esp)
 5ae:	e8 95 fd ff ff       	call   348 <putc>
      }
      state = 0;
 5b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5be:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c4:	01 d0                	add    %edx,%eax
 5c6:	0f b6 00             	movzbl (%eax),%eax
 5c9:	84 c0                	test   %al,%al
 5cb:	0f 85 70 fe ff ff    	jne    441 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d1:	c9                   	leave  
 5d2:	c3                   	ret    
 5d3:	90                   	nop

000005d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5da:	8b 45 08             	mov    0x8(%ebp),%eax
 5dd:	83 e8 08             	sub    $0x8,%eax
 5e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e3:	a1 44 0a 00 00       	mov    0xa44,%eax
 5e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5eb:	eb 24                	jmp    611 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f0:	8b 00                	mov    (%eax),%eax
 5f2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f5:	77 12                	ja     609 <free+0x35>
 5f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5fd:	77 24                	ja     623 <free+0x4f>
 5ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 602:	8b 00                	mov    (%eax),%eax
 604:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 607:	77 1a                	ja     623 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 609:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 611:	8b 45 f8             	mov    -0x8(%ebp),%eax
 614:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 617:	76 d4                	jbe    5ed <free+0x19>
 619:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61c:	8b 00                	mov    (%eax),%eax
 61e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 621:	76 ca                	jbe    5ed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 623:	8b 45 f8             	mov    -0x8(%ebp),%eax
 626:	8b 40 04             	mov    0x4(%eax),%eax
 629:	c1 e0 03             	shl    $0x3,%eax
 62c:	89 c2                	mov    %eax,%edx
 62e:	03 55 f8             	add    -0x8(%ebp),%edx
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	39 c2                	cmp    %eax,%edx
 638:	75 24                	jne    65e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	8b 40 04             	mov    0x4(%eax),%eax
 648:	01 c2                	add    %eax,%edx
 64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	8b 00                	mov    (%eax),%eax
 655:	8b 10                	mov    (%eax),%edx
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	89 10                	mov    %edx,(%eax)
 65c:	eb 0a                	jmp    668 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 10                	mov    (%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 40 04             	mov    0x4(%eax),%eax
 66e:	c1 e0 03             	shl    $0x3,%eax
 671:	03 45 fc             	add    -0x4(%ebp),%eax
 674:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 677:	75 20                	jne    699 <free+0xc5>
    p->s.size += bp->s.size;
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 50 04             	mov    0x4(%eax),%edx
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	8b 40 04             	mov    0x4(%eax),%eax
 685:	01 c2                	add    %eax,%edx
 687:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	8b 10                	mov    (%eax),%edx
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	89 10                	mov    %edx,(%eax)
 697:	eb 08                	jmp    6a1 <free+0xcd>
  } else
    p->s.ptr = bp;
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 69f:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	a3 44 0a 00 00       	mov    %eax,0xa44
}
 6a9:	c9                   	leave  
 6aa:	c3                   	ret    

000006ab <morecore>:

static Header*
morecore(uint nu)
{
 6ab:	55                   	push   %ebp
 6ac:	89 e5                	mov    %esp,%ebp
 6ae:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6b8:	77 07                	ja     6c1 <morecore+0x16>
    nu = 4096;
 6ba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c1:	8b 45 08             	mov    0x8(%ebp),%eax
 6c4:	c1 e0 03             	shl    $0x3,%eax
 6c7:	89 04 24             	mov    %eax,(%esp)
 6ca:	e8 41 fc ff ff       	call   310 <sbrk>
 6cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6d2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6d6:	75 07                	jne    6df <morecore+0x34>
    return 0;
 6d8:	b8 00 00 00 00       	mov    $0x0,%eax
 6dd:	eb 22                	jmp    701 <morecore+0x56>
  hp = (Header*)p;
 6df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e8:	8b 55 08             	mov    0x8(%ebp),%edx
 6eb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f1:	83 c0 08             	add    $0x8,%eax
 6f4:	89 04 24             	mov    %eax,(%esp)
 6f7:	e8 d8 fe ff ff       	call   5d4 <free>
  return freep;
 6fc:	a1 44 0a 00 00       	mov    0xa44,%eax
}
 701:	c9                   	leave  
 702:	c3                   	ret    

00000703 <malloc>:

void*
malloc(uint nbytes)
{
 703:	55                   	push   %ebp
 704:	89 e5                	mov    %esp,%ebp
 706:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
 70c:	83 c0 07             	add    $0x7,%eax
 70f:	c1 e8 03             	shr    $0x3,%eax
 712:	83 c0 01             	add    $0x1,%eax
 715:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 718:	a1 44 0a 00 00       	mov    0xa44,%eax
 71d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 720:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 724:	75 23                	jne    749 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 726:	c7 45 f0 3c 0a 00 00 	movl   $0xa3c,-0x10(%ebp)
 72d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 730:	a3 44 0a 00 00       	mov    %eax,0xa44
 735:	a1 44 0a 00 00       	mov    0xa44,%eax
 73a:	a3 3c 0a 00 00       	mov    %eax,0xa3c
    base.s.size = 0;
 73f:	c7 05 40 0a 00 00 00 	movl   $0x0,0xa40
 746:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 749:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74c:	8b 00                	mov    (%eax),%eax
 74e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 751:	8b 45 f4             	mov    -0xc(%ebp),%eax
 754:	8b 40 04             	mov    0x4(%eax),%eax
 757:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 75a:	72 4d                	jb     7a9 <malloc+0xa6>
      if(p->s.size == nunits)
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	8b 40 04             	mov    0x4(%eax),%eax
 762:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 765:	75 0c                	jne    773 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	8b 10                	mov    (%eax),%edx
 76c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76f:	89 10                	mov    %edx,(%eax)
 771:	eb 26                	jmp    799 <malloc+0x96>
      else {
        p->s.size -= nunits;
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8b 40 04             	mov    0x4(%eax),%eax
 779:	89 c2                	mov    %eax,%edx
 77b:	2b 55 ec             	sub    -0x14(%ebp),%edx
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	8b 40 04             	mov    0x4(%eax),%eax
 78a:	c1 e0 03             	shl    $0x3,%eax
 78d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	8b 55 ec             	mov    -0x14(%ebp),%edx
 796:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 799:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79c:	a3 44 0a 00 00       	mov    %eax,0xa44
      return (void*)(p + 1);
 7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a4:	83 c0 08             	add    $0x8,%eax
 7a7:	eb 38                	jmp    7e1 <malloc+0xde>
    }
    if(p == freep)
 7a9:	a1 44 0a 00 00       	mov    0xa44,%eax
 7ae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7b1:	75 1b                	jne    7ce <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 7b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7b6:	89 04 24             	mov    %eax,(%esp)
 7b9:	e8 ed fe ff ff       	call   6ab <morecore>
 7be:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c5:	75 07                	jne    7ce <malloc+0xcb>
        return 0;
 7c7:	b8 00 00 00 00       	mov    $0x0,%eax
 7cc:	eb 13                	jmp    7e1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	8b 00                	mov    (%eax),%eax
 7d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7dc:	e9 70 ff ff ff       	jmp    751 <malloc+0x4e>
}
 7e1:	c9                   	leave  
 7e2:	c3                   	ret    
