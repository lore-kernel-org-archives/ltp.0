From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 12 Apr 2019 11:09:39 +0800
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190411162724.GC124555@google.com>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
Message-ID: <eb79e974-e094-8305-99f2-92709065d7ff@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


-------- Original Message --------
From: Sandeep Patil
Sent: Thu, 11 Apr 2019 09:27:24 -0700
To: Petr Vorel
Cc: Ltp
Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk: enable 
__ANDROID__ definition for Android b uild
> On Wed, Apr 10, 2019 at 04:16:15PM +0200, Petr Vorel wrote:
>> Hi Sandeep, Steve,
>>
>>> Could anyone help me to review this patch? This is useful to cross-compile ltp for Android without specifying '-D__ANDROID__' in configure step.
>>> Thanks!
>>> Zhengwang
>>
>>> ------------------------------------------------------------------
>>> 发件人：Zhengwang Ruan <ruanzw@xiaopeng.com>
>>> 发送时间：2019年4月9日(星期二) 12:05
>>> 收件人：ltp <ltp@lists.linux.it>
>>> 抄　送：Zhengwang Ruan <ruanzw@xiaopeng.com>
>>> 主　题：[PATCH v1] include/mk/env_post.mk: enable __ANDROID__ definition for Android build
>>> Enable the __ANDROID__ definition by default for Android build, otherwise we
>>> should manually enable it by configure command.
>>> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
>>> ---
>>>   include/mk/env_post.mk | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
>>> index 913bdf5..7953e0a 100644
>>> --- a/include/mk/env_post.mk
>>> +++ b/include/mk/env_post.mk
>>> @@ -44,7 +44,7 @@ endif
>>>   ifeq ($(ANDROID),1)
>>>   # There are many undeclared functions, it's best not to accidentally overlook
>>>   # them.
>>> -CFLAGS    += -Werror-implicit-function-declaration
>>> +CFLAGS    += -Werror-implicit-function-declaration -D__ANDROID__
>> Would adding __ANDROID__ definition help building LTP with distro
>> cross-compiler? (i.e. no NDK, no inside AOSP tree)?
>> I guess so and therefore, I'd be for this change.
>> I see some projects added it as well (busybox [1] [2], dnsmasq [3]).
>> BTW: where is defined for AOSP and NDK?
> I think I've used __ANDROID__ and __BIONIC__ in the past for android-specific
> things.  Honestly, I haven't tried to build for Android outside of AOSP tree
> yet. I am happy to test this if you tell me how? (sorry for that.)

Hi Sandeep,


You can try the steps below to make a build outside AOSP. In my case, it 
works fine.

$ autoreconf --install

$ ./configure --prefix=/tmp/ltp 
CC=${BUILD_PROJ_DIR}/prebuilts/clang/host/linux-x86/clang-4691093/bin/clang 
AR=${BUILD_PROJ_DIR}/prebuilts/clang/host/linux-x86/clang-4691093/bin/llvm-ar 
CFLAGS="-I ${BUILD_PROJ_DIR}/libnativehelper/include_jni -I 
${BUILD_PROJ_DIR}/system/core/include -I 
${BUILD_PROJ_DIR}/system/media/audio/include -I 
${BUILD_PROJ_DIR}/hardware/libhardware/include -I 
${BUILD_PROJ_DIR}/hardware/libhardware_legacy/include -I 
${BUILD_PROJ_DIR}/hardware/ril/include -I 
${BUILD_PROJ_DIR}/libnativehelper/include -I 
${BUILD_PROJ_DIR}/frameworks/native/include -I 
${BUILD_PROJ_DIR}/frameworks/native/opengl/include -I 
${BUILD_PROJ_DIR}/frameworks/av/include -isystem 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/include 
-isystem ${BUILD_PROJ_DIR}/bionic/libc/include -isystem 
${BUILD_PROJ_DIR}/bionic/libc/kernel/uapi -isystem 
${BUILD_PROJ_DIR}/bionic/libc/kernel/uapi/asm-arm64 -isystem 
${BUILD_PROJ_DIR}/bionic/libc/kernel/android/scsi -isystem 
${BUILD_PROJ_DIR}/bionic/libc/kernel/android/uapi -target 
aarch64-linux-android 
-B${BUILD_PROJ_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin 
-pthread -nostdlib -D__ANDROID__" --host=aarch64-linux-gnu 
LDFLAGS="-nostdlib -Wl,-dynamic-linker,/system/bin/linker64 
-Wl,--gc-sections -Wl,-z,nocopyreloc 
-Wl,-rpath-link=${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/lib 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/lib/crtbegin_dynamic.o 
-Wl,--whole-archive  -Wl,--no-whole-archive 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/STATIC_LIBRARIES/libclang_rt.ubsan_minimal-aarch64-android_intermediates/libclang_rt.ubsan_minimal-aarch64-android.a 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/STATIC_LIBRARIES/libcompiler_rt-extras_intermediates/libcompiler_rt-extras.a 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/STATIC_LIBRARIES/libatomic_intermediates/libatomic.a 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/STATIC_LIBRARIES/libgcc_intermediates/libgcc.a 
-Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now -Wl,--build-id=md5 
-Wl,--warn-shared-textrel -Wl,--fatal-warnings 
-Wl,--no-undefined-version -Wl,-m,aarch64_elf64_le_vec 
-Wl,--hash-style=gnu -fuse-ld=gold -Wl,--icf=safe 
-Wl,--exclude-libs,libclang_rt.ubsan_minimal-aarch64-android.a 
-Wl,--no-undefined 
-B${BUILD_PROJ_DIR}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/aarch64-linux-android/bin 
-L${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/lib -lc++ -lc 
-lm -ldl 
${BUILD_PROJ_DIR}/out/target/product/${PRODUCT_NAME}/obj/lib/crtend_android.o"

$ make ANDROID=1


BTW,  ${BUILD_PROJ_DIR} refers to the path of your AOSP project, and 
${PRODUCT_NAME} refers to the product nickname inside your organization. 
you need to export these two variables before launch the above configure.


But unfortunately, you will encounter other build errors, especially 
those caused by -Werror-implicit-function-declaration. But I think it 
should be enough to tell the deference between __ANDROID__ and ANDROID.


Good luck! :-)

Zhengwang

>
> Steve will also be back by 4/15 and he would know this more than I do.
> So,  Ideally, if we can wait for him it will be great. In the mean time, I
> can test..
>
> FWIW, I want to be able to do this as well. I know its a lot of pain to have
> to checkout 100s of gigabytes of AOSP tree in order to build LTP for Android
> right now. So, let me know how I can test and compare.
>
> <snip>
>
>
> - ssp
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/ccb40a26/attachment.html>
