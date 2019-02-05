From: Steve Muckle <smuckle@google.com>
Date: Tue, 5 Feb 2019 15:40:12 -0800
Subject: [LTP] [PATCH 0/3] Build android fixes
In-Reply-To: <20190205012252.GA11738@dell5510>
References: <20190130112826.7157-1-petr.vorel@gmail.com>
 <56309f29-d63c-2975-eb2c-1294f55e37e8@google.com> <20190202172245.GA979@x230>
 <20190204192004.GB222456@google.com> <20190205012252.GA11738@dell5510>
Message-ID: <b38804a5-27aa-ec79-ba0e-69c07d2dc5af@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 02/04/2019 05:22 PM, Petr Vorel wrote:
> BTW which compiler option allows you to ignore missing <string.h> and
> <strings.h> ?

The AOSP build is providing the bionic headers (which include string.h 
and strings.h) to LTP. Here's a full build command for a single LTP 
test, note the instances of bionic/libc/include:

[745/781] PWD=/proc/self/cwd 
prebuilts/clang/host/linux-x86/clang-r346389c/bin/clang -c 
-Wno-null-pointer-arithmetic -Wno-null-dereference 
-Iexternal/ltp/android/include -Iexternal/ltp/include 
-Iexternal/ltp/include/old -Iexternal/ltp 
-Werror=implicit-function-declaration -DANDROID -fmessage-length=0 -W 
-Wall -Wno-unused -Winit-self -Wpointer-arith -no-canonical-prefixes 
-DNDEBUG -UDEBUG -fno-exceptions -Wno-multichar -O2 -g 
-fno-strict-aliasing -fdebug-prefix-map=/proc/self/cwd= 
-D__compiler_offsetof=__builtin_offsetof -Wimplicit-fallthrough 
-Werror=int-conversion -Wno-reserved-id-macro -Wno-format-pedantic 
-Wno-unused-command-line-argument -fcolor-diagnostics 
-Wno-zero-as-null-pointer-constant -Wno-sign-compare 
-Wno-defaulted-function-deleted -ffunction-sections -fdata-sections 
-fno-short-enums -funwind-tables -fstack-protector-strong 
-Wa,--noexecstack -D_FORTIFY_SOURCE=2 -Wstrict-aliasing=2 
-Werror=return-type -Werror=non-virtual-dtor -Werror=address 
-Werror=sequence-point -Werror=date-time -Werror=format-security 
-nostdlibinc -march=armv8-a  -Iexternal/libcap/libcap/include 
-Iexternal/selinux/libselinux/include -Isystem/core/libasyncio/include 
-Iexternal/libcxx/include -Iexternal/libcxxabi/include 
-Ibionic/libc/include -D__LIBC_API__=10000 -D__LIBM_API__=10000 
-D__LIBDL_API__=10000 
-Iout/soong/.intermediates/external/ltp/ltp_syscalls_h/gen 
-Isystem/core/include -Isystem/media/audio/include 
-Ihardware/libhardware/include -Ihardware/libhardware_legacy/include 
-Ihardware/ril/include -Iframeworks/native/include 
-Iframeworks/native/opengl/include -Iframeworks/av/include -isystem 
bionic/libc/include -isystem bionic/libc/kernel/uapi -isystem 
bionic/libc/kernel/uapi/asm-arm64 -isystem 
bionic/libc/kernel/android/scsi -isystem bionic/libc/kernel/android/uapi 
-Ilibnativehelper/include_jni -include bionic-compat.h -Wall -Werror 
-Wno-error=absolute-value -Wno-error=undefined-internal 
-Wno-error=uninitialized -Wno-error=user-defined-warnings 
-Wno-constant-conversion -Wno-deprecated -Wno-duplicate-decl-specifier 
-Wno-empty-body -Wno-format -Wno-gnu-designator 
-Wno-implicit-function-declaration 
-Wno-incompatible-pointer-types-discards-qualifiers 
-Wno-knr-promoted-parameter -Wno-macro-redefined -Wno-missing-braces 
-Wno-missing-field-initializers -Wno-parentheses-equality 
-Wno-pointer-arith -Wno-pointer-sign -Wno-sign-compare 
-Wno-tautological-compare -Wno-unneeded-internal-declaration 
-Wno-unused-function -Wno-unused-parameter -Wno-unused-variable 
-D_FORTIFY_SOURCE=2 -target aarch64-linux-android 
-Bprebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin 
-fPIE -D_USING_LIBCXX -std=gnu99  -Werror=int-to-pointer-cast 
-Werror=pointer-to-int-cast -Werror=address-of-temporary 
-Werror=return-type -Wno-tautological-constant-compare 
-Wno-tautological-type-limit-compare 
-Wno-tautological-unsigned-enum-zero-compare 
-Wno-tautological-unsigned-zero-compare -Wno-enum-compare 
-Wno-enum-compare-switch -Wno-c++98-compat-extra-semi 
-Wno-return-std-move-in-c++11 -MD -MF 
out/soong/.intermediates/external/ltp/ltp_ustat01/android_arm64_armv8-a_core/obj/external/ltp/testcases/kernel/syscalls/ustat/ustat01.o.d 
-o 
out/soong/.intermediates/external/ltp/ltp_ustat01/android_arm64_armv8-a_core/obj/external/ltp/testcases/kernel/syscalls/ustat/ustat01.o 
external/ltp/testcases/kernel/syscalls/ustat/ustat01.c

cheers,
steve
