From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Wed, 17 Jul 2019 17:21:32 +0800
Subject: [LTP] Question about kernel/syscall/signal/signal06.c
Message-ID: <56f854e2-9cc6-4725-3182-ff83e106ee23@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Wang,

Sorry for bother you.

I find signal06 fails on qemux86-64 when qemu has a small number cores, 
e.g. "qemu -smp 1/2/4/6".

ERROR INFO:

signal06??? 0? TINFO? :? loop = 23
signal06??? 1? TFAIL? :? signal06.c:87: Bug Reproduced!

But if boot qemu with "-smp 16", the case has great chance to pass.


I have two questions about this case:

1. I don't know why multi-core will affect the case.

2. On failure situation, what does break the "while loop" shown in below 
code.

 ??? while (D == VALUE && loop < LOOPS) {
 ??????? /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
 ???????? * fp regs around c call */
 ??????? asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
 ??????? asm ("syscall" : : : "ax");

 ??????? loop++;
 ??? }

 ??? ...

 ??? if (loop == LOOPS) {
 ??????? tst_resm(TPASS, "%s call succeeded", TCID);
 ??? } else {
 >>> tst_resm(TFAIL, "Bug Reproduced!");
 ??????? tst_exit();
 ??? }


Thanks.

--Hongzhi

