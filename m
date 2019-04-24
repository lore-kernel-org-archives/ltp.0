From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Apr 2019 22:19:51 +0200
Subject: [LTP] [PATCH v1] include/mk/env_post.mk: enable __ANDROID__
 definition for Android build
In-Reply-To: <edc171bb-7351-1069-5a80-8b5c67547fa5@google.com>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <20190424091444.GA23977@dell5510>
 <edc171bb-7351-1069-5a80-8b5c67547fa5@google.com>
Message-ID: <20190424201951.GA26076@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Steve, Zhengwang,

> Using Sandeep's instructions and with your latest merged fixes I was able to
> build unmodified upstream with the NDK. I just tried running one of the test
> binaries on my device to sanity check it.

> I put in an #error if __ANDROID__ is defined and it does look to be set by
> the NDK compiler. FWIW I am using Android API level 26, the minimum which
> provides hasmntopt. This gets configured in the "Set up ndk toolchains for
> autoconf" step Sandeep mentioned by setting the CC and CXX env vars
> appropriately.
Thanks for testing. IMHO this is a simple proof that this patch (-D__ANDROID__)
is not needed.

...
> >  In the case of cross-compilation, I think it still makes sense, since
> > we can use the same toolchain, such as clang,  and build parameters
> > (the specify the include headers and libs, etc) as AOSP.

> but it's not clear to me since you need to have bionic around anyway, and at
> that point, why not just use the Android toolchain?
No, you're right, that does not make sense.


> thanks,
> Steve

Kind regards,
Petr
