From: rahul gupta <rahul.gupta412@gmail.com>
Date: Tue, 16 Jan 2018 15:32:34 +0530
Subject: [LTP] cross compilation failing
Message-ID: <CAN9dZwefF=KqefnuMS-OAVN+icQt=bczdk0QGrBRWEPKdNWFhg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

we are facing issue while compiling ltp for kernel version 2.6.34.15.
could you please let me know, does ltp depend on kernel version.

# uname -a
Linux IPNIMP7-0
2.6.34.15-WR4.3.fp_octwnd_6880_ampp2_standard-00719-g2f89460 #1 SMP PREEMPT
Thu Sep 14 16:51:08 IST 2017 mips64 mips64 mips64 GNU/Linux

while compilation went fine for kernel 4.4.84.
# uname -a
Linux CLA-0 4.4.84-pc64-distro.git-v2.66-23-rc19 #1 SMP Tue Dec 26 08:16:42
UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

Regards,
Rahul Gupta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180116/c12946ee/attachment-0001.html>
