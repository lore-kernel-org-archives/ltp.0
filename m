From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Apr 2019 19:06:51 +0200
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190417163923.GG124555@google.com>
References: <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
 <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
 <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
 <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
 <20190412194809.GE124555@google.com>
 <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
 <20190417163923.GG124555@google.com>
Message-ID: <20190417170651.GA26229@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

> > Have you tried to build out-of-aosp? :-)

> Yes, I did that now and ran into a build error with pread02 pasted at the
> end of this email.

> This was much easier than I thought and I think I can start sending trivial
> fixes as I go. Here's what I did.

> 1. Download the ndk20 beta from - https://developer.android.com/ndk/downloads
> 2. Set up ndk toolchains for autoconf as shown in
>    https://developer.android.com/ndk/guides/other_build_systems#autoconf
Thanks for a hint. I was using standalone toolchain [1], created with NKD r19,
but see according a doc that it was deprecated even for r19.

[1] https://developer.android.com/ndk/guides/standalone_toolchain

> 3. In LTP, do
>    $ ./configure --host x86_64-linux-android --prefix=<preferred install location>
>    $ make ANDROID=1

I'm also passing these flags to CFLAGS, but it might not be necessary:
 --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${ANDROID_PREFIX}/include

for arm host I use:
--host arm-linux-androideabi

and also define CROSS_COMPILE + other variables:
export CROSS_COMPILE=$TOOLCHAIN_ROOT/bin/arm-linux-androideabi-
export AR=${CROSS_COMPILE}ar
export AS=${CROSS_COMPILE}as
export NM=${CROSS_COMPILE}nm
export CC=${CROSS_COMPILE}gcc
export LD=${CROSS_COMPILE}ld
export RANLIB=${CROSS_COMPILE}ranlib

Only CROSS_COMPILE should be needed as, others are in
include/mk/config.mk.default, but my toolchain setup does not detect them
(include/mk/config.mk does not have cross-compile versions)

> Please let me know if this doesn't sound right? It seems a lot easier than
> the steps pasted earlier.

> - ssp


> ======================

> /usr/local/google/home/sspatil/bin/android-ndk-r20-beta2/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android28-clang -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -Werror-implicit-function-declaration -D_FORTIFY_SOURCE=2 -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv/../utils -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib -L../../../../lib/android_libpthread -L../../../../lib/android_librt  preadv02.c   -lltp -o preadv02
> preadv02.c:89:7: error: implicit declaration of function 'preadv' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>         TEST(preadv(*tc->fd, tc->name, tc->count, tc->offset));
>              ^
I bump into the same problem

+ this one:
pwritev02.c:85:7: error: implicit declaration of function 'pwritev' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
        TEST(pwritev(*tc->fd, tc->name, tc->count, tc->offset));

So for the build is needed to comment out HAVE_PREADV and HAVE_PWRITEV
definitions in include/config.h.

I don't know why autotools fails preadv and pwritev detection with AC_CHECK_FUNCS.
I considered it as problem of my setup, but maybe it's an autotools bug.

> 1 error generated.
> <builtin>: recipe for target 'preadv02' failed
> make[4]: *** [preadv02] Error 1
> make[4]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv'
> ../../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
> make[3]: *** [all] Error 2
> make[3]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls'
> ../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
> make[2]: *** [all] Error 2
> make[2]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel'
> ../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases'
> Makefile:111: recipe for target 'testcases-all' failed
> make: *** [testcases-all] Error 2


Kind regards,
Petr
