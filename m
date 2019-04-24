From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Apr 2019 23:11:03 +0200
Subject: [LTP] [PATCH v2] include/mk/env_post.mk: enable __ANDROID__
 definition for Android build
In-Reply-To: <15aeaa52-eecc-e21a-eb86-d66cfe81928e@google.com>
References: <1556124939-7699-1-git-send-email-ruanzw@xiaopeng.com>
 <15aeaa52-eecc-e21a-eb86-d66cfe81928e@google.com>
Message-ID: <20190424211103.GB26076@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 4/24/19 9:55 AM, Zhengwang Ruan wrote:
> > The definition of __ANDROID__ has been widely used to compile android-specific
> > things (i.e. busybox [1] [2], dnsmasq [3]), so we expected NDK to automatically
> > pass it to help build LTP for android, but unfortunately it didn't (it is tested
> > with android-ndk-r19c). Currently, we have to manually specify -D__ANDROID__ in
> > configure step before launch 'make ANDROID=1' command, and this is suffering for
> > those who don't have good knowledge of LTP, so it is necessary to enable it if
> > built for android.

> Hi Zhengwang I mentioned in the other thread but just to get it here also,
> __ANDROID__ seems to be defined for me by the NDK. Could you try the steps
> Sandeep shared?

Using old way (getting standalone toolchain from NDK r19, using API 27
and define $AR, $CC, $LD, ... variables) confirms what Steve said [1]: -D__ANDROID__
is not defined on the command line (see below), but #error macro inside #ifdef
__ANDROID__ guard is proved that arm-linux-androideabi-gcc defines it.

Just for sure I tested the same using Sandeep's way (NDK r20-beta2, using
variables with API 26) [2], it behaves the same.
IMHO the patch is not needed.

BTW minimal Android API for LTP is 26 (API 24 complains for missing hasmntopt()).

> thanks,
> steve


Kind regards,
Petr

[1]
/opt/android-standalone-toolchain.api-27/bin/arm-linux-androideabi-gcc --sysroot=/opt/android-standalone-toolchain.api-27/sysroot -I/opt/android-standalone-toolchain.api-27/sysroot/usr/include -I/include -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -I. -DLTPLIB -Werror-implicit-function-declaration --sysroot=/opt/android-standalone-toolchain.api-27/sysroot -I/opt/android-standalone-toolchain.api-27/sysroot/usr/include -I/include -I../include -I../include -I../include/old/  -c -o tst_kernel.o tst_kernel.c

[2]
/opt/android-ndk-r20-beta2/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android26-clang -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -I. -DLTPLIB -Werror-implicit-function-declaration -D_FORTIFY_SOURCE=2 -I../include -I../include -I../include/old/  -c -o tst_resource.o tst_resource.c
