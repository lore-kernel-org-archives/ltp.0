From: Nikita Gupta <nikitarulz@gmail.com>
Date: Mon, 26 Nov 2018 09:24:38 +0530
Subject: [LTP] LTP: HugeTLB failures in version ltp-20170516-179-g18916a2
Message-ID: <CAGyGwR2x=f=h2ZsXz1AEHhjoChRffY69zRndA_7SC1C1D53qHg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All,

HugeTLB is resulting into Conf in one version and Fail in another version
for same kernel configuration.

*Version LTP-20170116:*
All test cases of HugeTLB are marked *Conf by ltp*, stating:
*1  TCONF  :  hugetlb.c:45: Huge page is not supported.
  *
*2  TCONF  :  **hugetlb.c:45: Remaining cases not appropriate for
configuration*

*Version LTP-20170516-179-g18916a2:*
All test cases of HugeTLB are marked *Fail by LTP*, stating:
*tst_test.c:908: INFO: Timeout per run is 0h 05m 00s hugetlb.c:46: CONF:
Huge page is not supported. mem.c:850: INFO: set nr_hugepages to 0
safe_file_ops.c:283: WARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'
for writing at mem.c:853: ENOENT*

Isn't in version ltp-20170516-179-g18916a2 also, all test cases should be
marked Conf.
As the file /proc/sys/vm/nr_hugepages is not present for both the versions.

-- 
Regards,
Nikita Gupta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181126/78d99280/attachment.html>
