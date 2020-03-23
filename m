From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 23 Mar 2020 10:00:46 +0000
Subject: [LTP] cpio01_sh testcase failure
Message-ID: <MAXPR0101MB1468BC364EA06FEE7D6F217CEEF00@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running cpio01_sh testcase on RISC v with our customized yocto distro i am getting following failure i am usinf LTP version  20200120-105-gae32c07c4
can someone help us to rectify
sage: cpio [-dmvu] [-F FILE] [-R USER[:GRP]] [-ti] [EXTR_FILE]...
cpio_tests 1 TFAIL: cpio -o > cpio.out < filelist failed unexpectedly
cpio_tests 1 TPASS: cpio -i < cpio.out passed as expected
Only in dir_orig: a
Only in dir_orig: b
Only in dir_orig: c
Only in dir_orig: d
Only in dir_orig: e
Only in dir_orig: f
Only in dir_orig: g
Only in dir_orig: h
Only in dir_orig: i
Only in dir_orig: j
Only in dir_orig: k
Only in dir_orig: l
Only in dir_orig: m
Only in dir_orig: n
Only in dir_orig: o
Only in dir_orig: p
Only in dir_orig: q
Only in dir_orig: r
Only in dir_orig: s
Only in dir_orig: t
Only in dir_orig: u
Only in dir_orig: v
Only in dir_orig: w
Only in dir_orig: x
Only in dir_orig: y
Only in dir_orig: z
cpio_tests 1 TFAIL: Directories dir and dir_orig differ
dir_orig:
a  b  c  d  e  f  g  h i  j  k  l  m  n  o  p q  r  s  t  u  v  w  x y  z

dir:

Summary:
passed   1
failed   2
skipped  0
warnings 0
<<<execution_status>>>
initiation_status="ok"


Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200323/aa69017c/attachment.htm>
