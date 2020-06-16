From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Jun 2020 20:56:07 +0200
Subject: [LTP] [PATCH 2/5] include: Add declaration of struct ipc64_perm
In-Reply-To: <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
References: <cover.1590057824.git.viresh.kumar@linaro.org>
 <5a10d33509ac73c26b233ab72c579f44386d0a55.1590057824.git.viresh.kumar@linaro.org>
Message-ID: <20200616185607.GA9342@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> --- /dev/null
> +++ b/include/ipcbuf.h
...
> +#include <linux/posix_types.h>
> +
> +#ifndef HAVE_IPC64_PERM
...

> +struct ipc64_perm {
> +	__kernel_key_t		key;
> +	__kernel_uid32_t	uid;
> +	__kernel_gid32_t	gid;
> +	__kernel_uid32_t	cuid;
> +	__kernel_gid32_t	cgid;
> +	__kernel_mode_t		mode;
> +				/* pad if mode_t is u16: */
> +	unsigned char		__pad1[4 - sizeof(__kernel_mode_t)];
> +	unsigned short		seq;
> +	unsigned short		__pad2;
> +	__kernel_ulong_t	__unused1;
> +	__kernel_ulong_t	__unused2;

Since this commit we depend on kernel headers from v3.4-rc1
- __kernel_ulong_t was defined in afead38d011a ("posix_types: Introduce
__kernel_[u]long_t").

I'll send a RFC patch, because not sure, whether we should still support these
old versions, or just drop the oldest distro from Travis and declare kernel v3.4
dependency. BTW current glibc requires v3.2.

Kind regards,
Petr
