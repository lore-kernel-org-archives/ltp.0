From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Thu, 20 Feb 2020 12:49:12 +0000
Subject: [LTP] ksm03, ksm04 testcases don't work with cgroup
Message-ID: <BM1PR0101MB145982BF4AAC059931EA2013EE130@BM1PR0101MB1459.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I am running ksm03 and kms04 on my RISC  v system wth linux 5.4.3,LTP Version: 20200120-55-g537fb6535
with custom Yocto distro,the test is getting failed with following errors.why it is failing?

root@exaleapsemi:~/pankaj_ltp/ltp/testcases/kernel/mem/ksm# ./ksm03
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
safe_macros.c:167: BROK: mem.c:750: mkdir(/dev/cgroup,0777) failed: EEXIST (17)

Thank you
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/3cc5cefb/attachment.htm>
