From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2021 12:31:53 +0100
Subject: [LTP] LTP testcase(sysctl02) failed
In-Reply-To: <0efaa481ffd24bc48fd41385159be66c@exch01.asrmicro.com>
References: <0efaa481ffd24bc48fd41385159be66c@exch01.asrmicro.com>
Message-ID: <X/ROKQGrQ4OKAbu0@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am currently condulting Ltp test for our own yocto project, now I encouter below error.
> 
> sysctl02_sh                                        FAIL       1
> sysctl02 1 TFAIL: /proc/sys/fs/file-max overflows and is set to 0
> sysctl02 2 TINFO: trying to set fs.file-max=18446744073709551615
> sysctl02 2 TPASS: /proc/sys/fs/file-max keeps old value (33398)
> sysctl02 3 TINFO: trying to set fs.file-max=9223372036854775808
> sysctl02 3 TFAIL: /proc/sys/fs/file-max overflows and is set to 0
> sysctl02 4 TCONF: kernel doesn't support KASAN
> 
> after investigated it, this testcase is for bufffer overflow, I checked source code (kernel 4.19),
> all of required patched had been applied, I dig into it and found new patch applied as flow , that might make testcase failed
> 
> commit b227f15712691096027163a4600a7af1c4864320
> Author: Christian Brauner <christian@brauner.io>
> Date:   Thu Mar 7 16:29:43 2019 -0800
> 
>     sysctl: handle overflow for file-max

...

> so is this testcase out of date or something wrong wih my kernel ?
> who can help me figure this out? Thanks in advance.

If you look into the testcase source there is a comment that the test is
a regression test for this commit as well.

Also if I remember correctly if you manage to overflow and set the
file-max to 0 the system will crash sooner or later. So if the test
manages to set it to 0 your kernel is either missing this patch or the
bug has been reintroduced.

-- 
Cyril Hrubis
chrubis@suse.cz
