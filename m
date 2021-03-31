From: yangx.jy@fujitsu.com <yangx.jy@fujitsu.com>
Date: Wed, 31 Mar 2021 01:25:43 +0000
Subject: [LTP] [PATCH] min_kver: Add kernel version requestions
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E79C@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E79C@dggeml531-mbx.china.huawei.com>
Message-ID: <6063CF94.4000505@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/3/30 17:31, zhaogongyi wrote:
> ----- I mean that in this testcase, it should call preadv2/pwritev2 in libc since its kernel version < 4.6. So I think this testcase need to be skipped on this system?or it would fail for EINVALID even though
> 	I don?t known the root cause of it. Maybe it is the dismatch of libc with kernel.
Hi Zhongyi,

I think you didn't understand the logic of "preadv2.h/pwritev2.h".
I have said that 1) LTP will call preadv2()/pwritev2() in libc if
HAVE_PREADV2/HAVE_PWRITEV2 is defined or 2) LTP will call
syscall(__NR_PREADV2/__NR_PWRITEV2) in kernel if
HAVE_PREADV2/HAVE_PWRITEV2 is not defined.

Running these tests report TFAIL instead of TCONF on your enviroment so
I think your libc actually provides these syscalls.
For example, see the detailed implementation in libc:
-----------------------------------------------------------
24 ssize_t
25 pwritev2 (int fd, const struct iovec *vector, int count, off_t offset,
26 int flags)
27 {
28 # ifdef __NR_pwritev2
29 ssize_t result = SYSCALL_CANCEL (pwritev2, fd, vector, count,
30 LO_HI_LONG (offset), flags);
31 if (result >= 0 || errno != ENOSYS)
32 return result;
33 # endif
34 /* Trying to emulate the pwritev2 syscall flags is troublesome:
35
36 * We can not temporary change the file state of the O_DSYNC and O_SYNC
37 flags to emulate RWF_{D}SYNC (attempts to change the state of using
38 fcntl are silently ignored).
39
40 * IOCB_HIPRI requires the file opened in O_DIRECT and uses an internal
41 semantic not provided by any other flag (O_NONBLOCK for instance). */
42
43 if (flags != 0)
44 {
45 __set_errno (ENOTSUP);
46 return -1;
47 }
48 if (offset == -1)
49 return __writev (fd, vector, count);
50 else
51 return pwritev (fd, vector, count, offset);
52 }
-----------------------------------------------------------
Note?libc will use writev and pwritev instead if kernel doesn't support
pwritev2.

Could you tell me the version of libc? Perhaps, your libc hits the
following bug:
----------------------------------------------------------
commit d4b4a00a462348750bb18544eb30853ee6ac5d10
Author: Florian Weimer <fweimer@redhat.com>
Date: Fri Feb 2 10:46:26 2018 +0100

preadv2/pwritev2: Handle offset == -1 [BZ #22753]

Reviewed-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
----------------------------------------------------------

Best Regards,
Xiao Yang
> Thanks!
