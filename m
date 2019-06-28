From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Fri, 28 Jun 2019 18:32:18 +0800
Subject: [LTP] Bug Report: diotest4 fails on mips64
Message-ID: <dc4e1e30-face-9039-db90-5a6dae2fc2ea@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

*Ltp:*

latest master


*Kernel:*

After v5.1 ARCH=mips64


*Error info:*

diotest4 10 TBROK : diotest4.c:368: can't mmap file: Invalid argument
diotest4 11 TBROK : diotest4.c:368: Remaining cases broken


I think the first argument of mmap is invalid.

 ?? >shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz - 1));

 ?? >shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,


Regards,

--Hongzhi

