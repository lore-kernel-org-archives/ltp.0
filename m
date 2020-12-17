From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Dec 2020 11:09:26 +0100
Subject: [LTP] [PATCH V2 3/3] syscalls: finit_module: Add tests
In-Reply-To: <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
References: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
 <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
Message-ID: <X9suVu55wgMPiOxC@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This finit_module02 fails for me:

tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
finit_module02.c:66: TFAIL: finit_module(*tc->fd, tc->param, tc->flags) expected ENOEXEC: EBADF (9)
finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EFAULT (14)
finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
tst_capability.c:29: TINFO: Dropping CAP_SYS_MODULE(16)
finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EPERM (1)
tst_capability.c:41: TINFO: Permitting CAP_SYS_MODULE(16)
finit_module02.c:59: TPASS: finit_module(*tc->fd, tc->param, tc->flags) passed
finit_module02.c:63: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EEXIST (17)
finit_module02.c:66: TFAIL: finit_module(*tc->fd, tc->param, tc->flags) expected EBADF: ETXTBSY (26)

Linux 5.9.12

Also it looks to me like EBADF is more reasonable error for fd set to -1
also ETXTBSY sounds more reasonable for a file opened for writing.

I guess that someone cleaned up the kernel implementation but forget to
update the manual pages?

-- 
Cyril Hrubis
chrubis@suse.cz
