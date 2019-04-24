From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Apr 2019 11:14:44 +0200
Subject: [LTP] [PATCH v1] include/mk/env_post.mk: enable __ANDROID__
 definition for Android build
In-Reply-To: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <20190424091444.GA23977@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve, Sandeep,

> Enable the __ANDROID__ definition by default for Android build, otherwise we
> should manually enable it by configure command.

> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
> ---
>  include/mk/env_post.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> index 913bdf5..7953e0a 100644
> --- a/include/mk/env_post.mk
> +++ b/include/mk/env_post.mk
> @@ -44,7 +44,7 @@ endif
>  ifeq ($(ANDROID),1)
>  # There are many undeclared functions, it's best not to accidentally overlook
>  # them.
> -CFLAGS				+= -Werror-implicit-function-declaration
> +CFLAGS				+= -Werror-implicit-function-declaration -D__ANDROID__

>  LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
>  LDFLAGS				+= -L$(top_builddir)/lib/android_librt

Please, when you have time, can you please have a look into this?

IMHO the question is whether code guarded by __ANDROID__ (lib/tst_kernel.c,
rt_tgsigqueueinfo01.c, etc.) works as expected in NDK build (as in aosp you use
definitions in Android.bp anyway).

According to [1] -D__ANDROID__ is defined by toolchain (I understand it by both
aosp build and builds using NDK), so it shouldn't be needed.

Not sure if it makes sense to build for android with non android toolchain (i.e.
no aosp nor NDK, use generic arm cross compile toolchain or standard gcc/clang
in case of intel platform). If yes, than this patch would be useful, as generic
toolchain obviously don't define __ANDROID__.

Kind regards,
Petr

[1] https://groups.google.com/forum/#!topic/android-ndk/cf9_f1SLXls
