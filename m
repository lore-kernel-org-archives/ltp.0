From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 19 Apr 2019 23:49:03 +0800
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190417170651.GA26229@x230>
References: <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
 <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
 <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
 <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
 <20190412194809.GE124555@google.com>
 <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
 <20190417163923.GG124555@google.com> <20190417170651.GA26229@x230>
Message-ID: <aafe58ce-e74d-b350-4e91-445683c120fc@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Sandeep, Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Wed, 17 Apr 2019 19:06:51 +0200
To: Sandeep Patil
Cc: Zhengwang Ruan, Ltp, Steve Muckle
Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable 
__ANDROID__ definition for Android build
> Hi Sandeep,
>
>>> Have you tried to build out-of-aosp? :-)
>> Yes, I did that now and ran into a build error with pread02 pasted at the
>> end of this email.
>> This was much easier than I thought and I think I can start sending trivial
>> fixes as I go. Here's what I did.
>> 1. Download the ndk20 beta from - https://developer.android.com/ndk/downloads
>> 2. Set up ndk toolchains for autoconf as shown in
>>     https://developer.android.com/ndk/guides/other_build_systems#autoconf
> Thanks for a hint. I was using standalone toolchain [1], created with NKD r19,
> but see according a doc that it was deprecated even for r19.
>
> [1] https://developer.android.com/ndk/guides/standalone_toolchain
>
>> 3. In LTP, do
>>     $ ./configure --host x86_64-linux-android --prefix=<preferred install location>
>>     $ make ANDROID=1
> I'm also passing these flags to CFLAGS, but it might not be necessary:
>   --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${ANDROID_PREFIX}/include
>
> for arm host I use:
> --host arm-linux-androideabi
>
> and also define CROSS_COMPILE + other variables:
> export CROSS_COMPILE=$TOOLCHAIN_ROOT/bin/arm-linux-androideabi-
> export AR=${CROSS_COMPILE}ar
> export AS=${CROSS_COMPILE}as
> export NM=${CROSS_COMPILE}nm
> export CC=${CROSS_COMPILE}gcc
> export LD=${CROSS_COMPILE}ld
> export RANLIB=${CROSS_COMPILE}ranlib
>
> Only CROSS_COMPILE should be needed as, others are in
> include/mk/config.mk.default, but my toolchain setup does not detect them
> (include/mk/config.mk does not have cross-compile versions)
>
>> Please let me know if this doesn't sound right? It seems a lot easier than
>> the steps pasted earlier.
>> - ssp
>
>> ======================
>> /usr/local/google/home/sspatil/bin/android-ndk-r20-beta2/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android28-clang -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -Werror-implicit-function-declaration -D_FORTIFY_SOURCE=2 -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv -I/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv/../utils -I../../../../include -I../../../../include -I../../../../include/old/   -L../../../../lib -L../../../../lib/android_libpthread -L../../../../lib/android_librt  preadv02.c   -lltp -o preadv02
>> preadv02.c:89:7: error: implicit declaration of function 'preadv' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>>          TEST(preadv(*tc->fd, tc->name, tc->count, tc->offset));
>>               ^
> I bump into the same problem
>
> + this one:
> pwritev02.c:85:7: error: implicit declaration of function 'pwritev' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>          TEST(pwritev(*tc->fd, tc->name, tc->count, tc->offset));
>
> So for the build is needed to comment out HAVE_PREADV and HAVE_PWRITEV
> definitions in include/config.h.
>
> I don't know why autotools fails preadv and pwritev detection with AC_CHECK_FUNCS.
> I considered it as problem of my setup, but maybe it's an autotools bug.

I also encountered this issue, but I temporarily walked around it by 
applying the following patch.

==================

$ git diff testcases/
diff --git a/testcases/commands/ldd/datafiles/Makefile 
b/testcases/commands/ldd/datafiles/Makefile
index d8bcf5c..74fbe50 100644
--- a/testcases/commands/ldd/datafiles/Makefile
+++ b/testcases/commands/ldd/datafiles/Makefile
@@ -30,7 +30,7 @@ CLEAN_TARGETS         += *.obj $(LDD_SO_FILES)
         $(CC) $(CFLAGS) -shared -o $@ $^

  lddfile.out: main.o $(LDD_SO_FILES)
-       $(CC) $(CFLAGS) -O -o $@ $?
+       $(CC) $(CFLAGS) $(LDFLAGS) -O -o $@ $?

  INSTALL_DIR            := testcases/data/ldd01

diff --git a/testcases/kernel/syscalls/Makefile 
b/testcases/kernel/syscalls/Makefile
index 45a00cf..27c2e7a 100644
--- a/testcases/kernel/syscalls/Makefile
+++ b/testcases/kernel/syscalls/Makefile
@@ -43,6 +43,8 @@ FILTER_OUT_DIRS       += \
         sched_getaffinity sched_setaffinity sendmsg setgroups setns 
sighold \
         sigrelse sigsuspend sigtimedwait sigwait sigwaitinfo stime \
         setdomainname sethostname symlinkat ulimit ustat vfork vhangup 
vmsplice
+
+FILTER_OUT_DIRS += preadv pwritev
  endif

==========

Then I can accomplish compiling LTP with android-ndk-r19c, and my 
configure as below.

==============

$ export NDK_TOOL_DIR=/path/to/android-ndk-r19c

$ ./configure --prefix=/tmp/ltp 
CC=${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/bin/clang 
AR=${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar 
CFLAGS="-isystem ${NDK_TOOL_DIR}/sysroot/usr/include -I 
/media/Workspace/Softwares/Linux/toolschain/ndk/android-ndk-r19c/sysroot/usr/include 
-I 
/media/Workspace/Softwares/Linux/toolschain/ndk/android-ndk-r19c/sysroot/usr/include/aarch64-linux-android 
-D__ANDROID__ -fmessage-length=0 -W -Wall -Wno-unused -Winit-self 
-Wpointer-arith -no-canonical-prefixes -DNDEBUG -UDEBUG -fno-exceptions 
-Wno-multichar -O2 -g -fno-strict-aliasing 
-fdebug-prefix-map=/proc/self/cwd= 
-D__compiler_offsetof=__builtin_offsetof -Werror=int-conversion 
-Wno-reserved-id-macro -Wno-format-pedantic 
-Wno-unused-command-line-argument -fcolor-diagnostics 
-Wno-expansion-to-defined -Wno-zero-as-null-pointer-constant 
-ffunction-sections -fdata-sections -fno-short-enums -funwind-tables 
-fstack-protector-strong -Wa,--noexecstack -D_FORTIFY_SOURCE=2 
-Wstrict-aliasing=2 -Werror=return-type -Werror=non-virtual-dtor 
-Werror=address -Werror=sequence-point -Werror=date-time 
-Werror=format-security -nostdlibinc -march=armv8-a  -target 
aarch64-linux-android 
-B${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/bin -std=gnu99 
-Wall -fPIE -D_USING_LIBCXX -Werror=int-to-pointer-cast 
-Werror=pointer-to-int-cast -Werror=address-of-temporary 
-Werror=return-type -Wno-tautological-constant-compare 
-Wno-null-pointer-arithmetic -Wno-enum-compare -Wno-enum-compare-switch 
-MD -nostdlib -pthread" --host=aarch64-linux-gnu LDFLAGS="-nostdlib 
-Wl,-dynamic-linker,/system/bin/linker64 -Wl,--gc-sections 
-Wl,-z,nocopyreloc 
-Wl,-rpath-link=${BUILD_PROJ_DIR}/out/target/product/e28/obj/lib 
${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28/crtbegin_dynamic.o 
-Wl,--whole-archive  -Wl,--no-whole-archive 
${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/8.0.2/lib/linux/libclang_rt.ubsan_minimal-aarch64-android.a 
${NDK_TOOL_DIR}/sysroot/usr/lib/aarch64-linux-android/libcompiler_rt-extras.a 
${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/aarch64-linux-android/lib64/libatomic.a 
${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/lib/gcc/aarch64-linux-android/4.9.x/libgcc.a 
-Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now -Wl,--build-id=md5 
-Wl,--warn-shared-textrel -Wl,--fatal-warnings 
-Wl,--no-undefined-version -Wl,-m,aarch64_elf64_le_vec 
-Wl,--hash-style=gnu -fuse-ld=gold -Wl,--icf=safe 
-Wl,--exclude-libs,libclang_rt.ubsan_minimal-aarch64-android.a 
-Wl,--no-undefined 
-B${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/bin 
-L${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28 
-lc++ -lc -lm -ldl 
${NDK_TOOL_DIR}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/aarch64-linux-android/28/crtend_android.o 
-target aarch64-linux-android"

$ make ANDROID=1


Regards,

Zhengwang

>> 1 error generated.
>> <builtin>: recipe for target 'preadv02' failed
>> make[4]: *** [preadv02] Error 1
>> make[4]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls/preadv'
>> ../../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel/syscalls'
>> ../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases/kernel'
>> ../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory '/usr/local/google/home/sspatil/dev/ssd2/ltp/testcases'
>> Makefile:111: recipe for target 'testcases-all' failed
>> make: *** [testcases-all] Error 2
>
> Kind regards,
> Petr
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190419/91ba37d3/attachment.html>
