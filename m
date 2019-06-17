From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Jun 2019 17:44:13 -0400 (EDT)
Subject: [LTP] [PATCH v2 3/3] testcase: get rid of compiling errors
In-Reply-To: <20190615042048.29839-3-liwang@redhat.com>
References: <20190615042048.29839-1-liwang@redhat.com>
 <20190615042048.29839-3-liwang@redhat.com>
Message-ID: <1243296203.28755912.1560807853881.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  configure.ac             | 1 +
>  testcases/cve/meltdown.c | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 5ecc92781..521f56541 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -58,6 +58,7 @@ AC_CHECK_HEADERS([ \
>      sys/shm.h \
>      sys/ustat.h \
>      sys/xattr.h \
> +    emmintrin.h \
>  ])
>  
>  AC_CHECK_FUNCS([ \
> diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
> index 72c9ec907..bc649b893 100644
> --- a/testcases/cve/meltdown.c
> +++ b/testcases/cve/meltdown.c
> @@ -29,6 +29,7 @@
>  #include <ctype.h>
>  #include <sys/utsname.h>
>  
> +#ifdef HAVE_EMMINTRIN_H
>  #include <emmintrin.h>
>  
>  #include "libtsc.h"
> @@ -387,3 +388,7 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.min_kver = "2.6.32"
>  };
> +
> +#else /* HAVE_EMMINTRIN_H */
> +	TST_TEST_TCONF("<emmintrin.h> is not supported");
> +#endif

This seems more complicated to me than original - extra autoconf check, extra ifdef.

I can see how tst_on_arch() would be useful. Test is valid on all arches,
but needs different input/constants/code/etc.

What is the motivation for tst_test.arch? Is it to have some annotation in tst_test struct?

> --
> 2.20.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
