From: Na Nha <minhnhan0801@gmail.com>
Date: Sat, 11 Nov 2017 00:14:41 +0700
Subject: [LTP] Failling_Zram01&Zram02_LTP_testsuite
Message-ID: <CAPiF6TiCjTVGNYH9EDkMFuVKvM-=qscQ0J4d-S8mfxi1-iA8Nw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Nice to meet you all.
My name's Nhan. I am using some LTP test cases

I faced 2 problems when running testcase "zram01.sh" & "zram02.sh" on
my 32-bit ARM board.

- First is regarding *Zram01*:

My target is using a optimized version of dd command.
In this testcase it use below command:
" dd conv=notrunc if=/dev/zero of=zram${i}/file oflag=append count=1
bs=1024 status=none > /dev/null 2>&1 || break "

 However , my "dd --help" output:











*BusyBox v1.24.1 (2017-09-26 20:41:13 CEST) multi-call binary.Usage: dd
[if=FILE] [of=FILE] [bs=N] [count=N] [skip=N][seek=N]Copy a file with
converting and formattingif=FILE Read from FILE instead of stdinof=FILE
Write to FILE instead of stdoutbs=N Read and write N bytes at a timecount=N
Copy only N input blocksskip=N Skip N input blocksseek=N Skip N output
blocksN may be suffixed by c (1), w (2), b (512), kB (1000), k (1024), MB,
M, GB, G*

So I don't have conv, oflag & status" arguments for dd command
Therefore, when I run "zram01.sh", it is failed
But when I remove those argument, it is passed.
Can I remove those arguments. Dose it make sense, still keep the
meaning of this test case?

- Second is regarding *Zram02*:
This is the output when I execute this test:











*root@arm:/opt/ltp/testcases/bin# ./zram02.shzram02 1 TINFO: create '1'
zram device(s)zram02 1 TPASS: test succeededzram02 2 TCONF: The device
attribute max_comp_streams was introducedin kernel 3.15 and deprecated in
4.7zram02 2 TINFO: set disk size to zram
device(s)/opt/ltp/testcases/bin/zram_lib.sh: line 121: echo: write
error:Cannot allocate memoryzram02 2 TFAIL: can't set '107374182400' to
/sys/block/zram0/disksizezram02 3 TINFO: zram cleanup*
I think this testcase is not the kind of Stress test, so we don't need
to configure disksize of zram with such 100GB (it is so large).
We only need to confirm that we can configure disksize.

So I think 10GB is fine , Is it OK?

Please help me to clarify those problems(Zram 01&Zram02)?
I look forward to any reply

---------------------------------------------------------------------------------------------------------

Thanks and best regard,

Le Minh Nhan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171111/d5ae3090/attachment.html>
