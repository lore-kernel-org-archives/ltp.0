From: Jakub =?unknown-8bit?q?Ra=C4=8Dek?= <jracek@redhat.com>
Date: Fri, 24 Mar 2017 16:42:35 +0100
Subject: [LTP] [PATCH v5 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <20170324152658.GB9961@rei.lan>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
 <1490292957-26941-6-git-send-email-jracek@redhat.com>
 <20170324152658.GB9961@rei.lan>
Message-ID: <7bd5cf45-bbdd-93da-5b72-f0233fcc99e2@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

thank you for the reviews. I learned a lot from that.

I'm also glad it finally made it through.

Best regards,

Jakub Racek


On 03/24/2017 04:26 PM, Cyril Hrubis wrote:
> Hi!
> Patchset pushed with cosmetic chnages to this patch (see diff below),
> thanks.
>
> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
> index c181fe6..04a5f4f 100644
> --- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
> @@ -75,7 +75,7 @@ static void test_seal_write(int fd)
>  	CHECK_MFD_NON_WRITEABLE(fd);
>  	CHECK_MFD_SHRINKABLE(fd);
>  	CHECK_MFD_GROWABLE(fd);
> -	CHECK_NON_GROWABLE_BY_WRITE(fd);
> +	CHECK_MFD_NON_GROWABLE_BY_WRITE(fd);
>  }
>
> *** Added MFD here just for consistency
>
>  /*
> @@ -109,7 +109,7 @@ static void test_seal_grow(int fd)
>  	CHECK_MFD_WRITEABLE(fd);
>  	CHECK_MFD_SHRINKABLE(fd);
>  	CHECK_MFD_NON_GROWABLE(fd);
> -	CHECK_NON_GROWABLE_BY_WRITE(fd);
> +	CHECK_MFD_NON_GROWABLE_BY_WRITE(fd);
>  }
>
>  /*
> @@ -126,7 +126,7 @@ static void test_seal_resize(int fd)
>  	CHECK_MFD_WRITEABLE(fd);
>  	CHECK_MFD_NON_SHRINKABLE(fd);
>  	CHECK_MFD_NON_GROWABLE(fd);
> -	CHECK_NON_GROWABLE_BY_WRITE(fd);
> +	CHECK_MFD_NON_GROWABLE_BY_WRITE(fd);
>  }
>
>  /*
> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> index 0c7143b..dfc75a8 100644
> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.c
> @@ -13,22 +13,22 @@
>   *
>   */
>
> - #define _GNU_SOURCE
> -
> - #include <sys/types.h>
> - #include <sys/syscall.h>
> - #include <sys/uio.h>
> - #include <lapi/fallocate.h>
> - #include <lapi/fcntl.h>
> - #include <lapi/memfd.h>
> - #include <errno.h>
> - #include <string.h>
> - #include <stdio.h>
> - #include <stdlib.h>
> - #include <unistd.h>
> -
> - #define TST_NO_DEFAULT_MAIN
> - #include <tst_test.h>
> +#define _GNU_SOURCE
> +
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <sys/uio.h>
> +#include <lapi/fallocate.h>
> +#include <lapi/fcntl.h>
> +#include <lapi/memfd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include <tst_test.h>
>
> *** Removed spaces before #
>
>  #include "linux_syscall_numbers.h"
>
> @@ -146,7 +146,8 @@ void check_mfd_fail_new(const char *filename, const int lineno,
>  	fd = sys_memfd_create(name, flags);
>  	if (fd >= 0) {
>  		safe_close(filename, lineno, NULL, fd);
> -		tst_brk(TFAIL, "memfd_create(%s, %d) succeeded unexpectedly",
> +		tst_brk_(filename, lineno, TFAIL,
> +			 "memfd_create(%s, %d) succeeded unexpectedly",
>  			name, flags);
>  	}
>
> *** Added forgotten filename and lineno to the message
>
> @@ -172,6 +173,7 @@ void check_mmap_fail(const char *file, const int lineno, void *addr,
>  		size_t length, int prot, int flags, int fd, off_t offset)
>  {
>  	if (mmap(addr, length, prot, flags, fd, offset) != MAP_FAILED) {
> +		safe_munmap(file, lineno, NULL, addr, length);
>  		tst_res_(file, lineno, TFAIL,
>  			"mmap(%p, %zu, %i, %i, %i, %zi) succeeded unexpectedly",
>  			addr, length, prot, flags, fd, offset);
> @@ -191,6 +193,19 @@ void check_munmap(const char *file, const int lineno, void *p, size_t length)
>  	tst_res_(file, lineno, TPASS, "munmap(%p, %ld) succeeded", p, length);
>  }
>
> *** Added forgotten munmap
>
> +void check_mfd_has_seals(const char *file, const int lineno, int fd, int seals)
> +{
> +	int ret = SAFE_FCNTL((fd), F_GET_SEALS);
> +	if (ret	!= seals) {
> +		tst_brk_(file, lineno, TFAIL,
> +			"fd %d doesn't have expected seals (%d expected %d)",
> +			fd, ret, seals);
> +	}
> +
> +	tst_res_(file, lineno, TPASS,
> +		 "fd %d has expected seals (%d)", fd, seals);
> +}
>
> *** Changed this macro for a function and make it print the values of seals
>
>  void check_mprotect(const char *file, const int lineno, void *addr,
>  		size_t length, int prot)
>  {
> @@ -297,7 +312,7 @@ void check_mfd_writeable(const char *filename, const int lineno, int fd)
>  	/* verify write() succeeds */
>  	safe_write(filename, lineno, NULL, 1, fd, "\0\0\0\0", 4);
>  	tst_res_(filename, lineno, TPASS, "write(%d, %s, %d) succeeded", fd,
> -		"\0\0\0\0", 4);
> +		"\\0\\0\\0\\0", 4);
>
> ** Changed this to print literal '\0\0\0\0' instead of random pointer
>
>  	/* verify PROT_READ | PROT_WRITE is allowed */
>  	p = check_mmap(filename, lineno, NULL, MFD_DEF_SIZE,
> diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> index 2705375..6329ac3 100644
> --- a/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> +++ b/testcases/kernel/syscalls/memfd_create/memfd_create_common.h
> @@ -43,13 +43,7 @@
>  	check_munmap(__FILE__, __LINE__, (p), (length))
>
>  #define CHECK_MFD_HAS_SEALS(fd, seals) \
> -	do { \
> -		if (SAFE_FCNTL((fd), F_GET_SEALS) != (seals)) { \
> -			tst_brk(TFAIL, "fd %d doesn't have expected seals", \
> -				(fd)); \
> -		} \
> -		tst_res(TPASS, "fd %d has expected seals", (fd)); \
> -	} while (0)
> +	check_mfd_has_seals(__FILE__, __LINE__, (fd), (seals));
>
>  #define CHECK_MFD_ADD_SEALS(fd, seals) \
>  	({int r = SAFE_FCNTL((fd), F_ADD_SEALS, (seals)); \
> @@ -92,7 +86,7 @@
>  #define CHECK_MFD_GROWABLE_BY_WRITE(fd) \
>  	check_mfd_growable_by_write(__FILE__, __LINE__, (fd))
>
> -#define CHECK_NON_GROWABLE_BY_WRITE(fd) \
> +#define CHECK_MFD_NON_GROWABLE_BY_WRITE(fd) \
>  	check_mfd_non_growable_by_write(__FILE__, __LINE__, (fd))
>
>  void assert_have_memfd_create(const char *filename, const int lineno);
> @@ -119,6 +113,8 @@ void check_mmap_fail(const char *file, const int lineno, void *addr,
>
>  void check_munmap(const char *file, const int lineno, void *p, size_t length);
>
> +void check_mfd_has_seals(const char *file, const int lineno, int fd, int seals);
> +
>  void check_mprotect(const char *file, const int lineno, void *addr,
>  		size_t length, int prot);
>
>

-- 
Regards,
     Jakub
