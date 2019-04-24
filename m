From: Steve Muckle <smuckle@google.com>
Date: Wed, 24 Apr 2019 12:23:01 -0700
Subject: [LTP] [PATCH v1] include/mk/env_post.mk: enable __ANDROID__
 definition for Android build
In-Reply-To: <20190424091444.GA23977@dell5510>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <20190424091444.GA23977@dell5510>
Message-ID: <edc171bb-7351-1069-5a80-8b5c67547fa5@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Zhengwang,

On 4/24/19 2:14 AM, Petr Vorel wrote:
> Hi Steve, Sandeep,
> 
...
> 
> Please, when you have time, can you please have a look into this?
> 
> IMHO the question is whether code guarded by __ANDROID__ (lib/tst_kernel.c,
> rt_tgsigqueueinfo01.c, etc.) works as expected in NDK build (as in aosp you use
> definitions in Android.bp anyway).
> 
> According to [1] -D__ANDROID__ is defined by toolchain (I understand it by both
> aosp build and builds using NDK), so it shouldn't be needed.

Using Sandeep's instructions and with your latest merged fixes I was 
able to build unmodified upstream with the NDK. I just tried running one 
of the test binaries on my device to sanity check it.

I put in an #error if __ANDROID__ is defined and it does look to be set 
by the NDK compiler. FWIW I am using Android API level 26, the minimum 
which provides hasmntopt. This gets configured in the "Set up ndk 
toolchains for autoconf" step Sandeep mentioned by setting the CC and 
CXX env vars appropriately.

Zhengwang can you try the steps Sandeep mentioned (with the API level 
tweak I mentioned above)?

> Not sure if it makes sense to build for android with non android toolchain (i.e.
> no aosp nor NDK, use generic arm cross compile toolchain or standard gcc/clang
> in case of intel platform). If yes, than this patch would be useful, as generic
> toolchain obviously don't define __ANDROID__.

Zhengwang had said

 >  In the case of cross-compilation, I think it still makes sense, since
 > we can use the same toolchain, such as clang,  and build parameters
 > (the specify the include headers and libs, etc) as AOSP.

but it's not clear to me since you need to have bionic around anyway, 
and at that point, why not just use the Android toolchain?


thanks,
Steve
