From: Gao =?unknown-8bit?b?TWVpdGFv77yI6auY546r5rab77yJ?= <meitaogao@asrmicro.com>
Date: Thu, 24 Dec 2020 05:56:14 +0000
Subject: [LTP] LTP testcase(sysctl02) failed
Message-ID: <0efaa481ffd24bc48fd41385159be66c@exch01.asrmicro.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All:

I am currently condulting Ltp test for our own yocto project, now I encouter below error.

sysctl02_sh                                        FAIL       1
sysctl02 1 TFAIL: /proc/sys/fs/file-max overflows and is set to 0
sysctl02 2 TINFO: trying to set fs.file-max=18446744073709551615
sysctl02 2 TPASS: /proc/sys/fs/file-max keeps old value (33398)
sysctl02 3 TINFO: trying to set fs.file-max=9223372036854775808
sysctl02 3 TFAIL: /proc/sys/fs/file-max overflows and is set to 0
sysctl02 4 TCONF: kernel doesn't support KASAN

after investigated it, this testcase is for bufffer overflow, I checked source code (kernel 4.19),
all of required patched had been applied, I dig into it and found new patch applied as flow , that might make testcase failed

commit b227f15712691096027163a4600a7af1c4864320
Author: Christian Brauner <christian@brauner.io>
Date:   Thu Mar 7 16:29:43 2019 -0800

    sysctl: handle overflow for file-max

    [ Upstream commit 32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5 ]

    Currently, when writing

      echo 18446744073709551616 > /proc/sys/fs/file-max

    /proc/sys/fs/file-max will overflow and be set to 0.  That quickly
    crashes the system.

    This commit sets the max and min value for file-max.  The max value is
    set to long int.  Any higher value cannot currently be used as the
    percpu counters are long ints and not unsigned integers.

    Note that the file-max value is ultimately parsed via
    __do_proc_doulongvec_minmax().  This function does not report error when
    min or max are exceeded.  Which means if a value largen that long int is
    written userspace will not receive an error instead the old value will be
    kept.  There is an argument to be made that this should be changed and
    __do_proc_doulongvec_minmax() should return an error when a dedicated min
    or max value are exceeded.  However this has the potential to break
    userspace so let's defer this to an RFC patch.

so is this testcase out of date or something wrong wih my kernel ?
who can help me figure this out? Thanks in advance.


-----------------------------------
Best Regards
Meitao Gao
------------------------------------



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201224/4393242d/attachment.htm>
