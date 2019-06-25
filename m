From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Jun 2019 05:01:02 -0400 (EDT)
Subject: [LTP] [PATCH v3 2/2] pkey: add test for memory protection keys
In-Reply-To: <20190625070737.30408-3-liwang@redhat.com>
References: <20190625070737.30408-1-liwang@redhat.com>
 <20190625070737.30408-2-liwang@redhat.com>
 <20190625070737.30408-3-liwang@redhat.com>
Message-ID: <123680949.29869386.1561453262485.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> +
> +#ifndef PKEYS_H
> +#define PKEYS_H
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +#ifndef PKEY_DISABLE_ACCESS
> +# define PKEY_DISABLE_ACCESS 0x1
> +# define PKEY_DISABLE_WRITE  0x2
> +#endif
> +
> +#ifndef HAVE_PKEY_MPROTECT
> +static inline int pkey_mprotect(void *addr, size_t len, int prot, int pkey)
> +{
> +	return tst_syscall(SYS_pkey_mprotect, addr, len, prot, pkey);

Hi,

This should be __NR_*:

In file included from pkey01.c:32:
pkey.h: In function ?pkey_mprotect?:
pkey.h:20: error: ?SYS_pkey_mprotect? undeclared (first use in this function)
pkey.h:20: error: (Each undeclared identifier is reported only once
pkey.h:20: error: for each function it appears in.)
pkey.h: In function ?pkey_alloc?:
pkey.h:25: error: ?SYS_pkey_alloc? undeclared (first use in this function)
pkey.h: In function ?pkey_free?:
pkey.h:30: error: ?SYS_pkey_free? undeclared (first use in this function)

> +static void setup(void)
> +{
> +	int i, fd;
> +
> +	if (access("/proc/sys/vm/nr_hugepages", F_OK)) {
> +		tst_res(TINFO, "Huge page is not supported");
> +		size = getpagesize();
> +		no_hugepage = 1;
> +	} else {
> +		SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%d", 1);

There are 2 problems here, both related to fact that this file exists,
but may return EOPNOTSUPP on read/write.

1. save_restore should ignore also read/open errors if path is prefixed with '?'
   I'll send this separately.

2. SAFE_FILE_PRINTF in pkey01.c shouldn't be safe, because we need to somehow
   detect that write worked

# ls -la /proc/sys/vm/nr_hugepages
-rw-r--r--. 1 root root 0 Jun 25 04:12 /proc/sys/vm/nr_hugepages

# cat /proc/sys/vm/nr_hugepages
cat: /proc/sys/vm/nr_hugepages: Operation not supported

> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +	.test = verify_pkey,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.save_restore = save_restore,

.needs_root = 1 as well, since we write to /proc and mount tmpfs

Rest looks good to me, but I haven't found yet system that could run the test.

Regards,
Jan
