From: Sandeep Patil <sspatil@android.com>
Date: Thu, 11 Apr 2019 09:27:24 -0700
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190410141615.GA10303@x230>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230>
Message-ID: <20190411162724.GC124555@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Apr 10, 2019 at 04:16:15PM +0200, Petr Vorel wrote:
> Hi Sandeep, Steve,
> 
> > Could anyone help me to review this patch? This is useful to cross-compile ltp for Android without specifying '-D__ANDROID__' in configure step.
> 
> > Thanks!
> > Zhengwang
> 
> 
> > ------------------------------------------------------------------
> > 发件人：Zhengwang Ruan <ruanzw@xiaopeng.com>
> > 发送时间：2019年4月9日(星期二) 12:05
> > 收件人：ltp <ltp@lists.linux.it>
> > 抄　送：Zhengwang Ruan <ruanzw@xiaopeng.com>
> > 主　题：[PATCH v1] include/mk/env_post.mk: enable __ANDROID__ definition for Android build
> 
> > Enable the __ANDROID__ definition by default for Android build, otherwise we
> > should manually enable it by configure command.
> 
> > Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
> > ---
> >  include/mk/env_post.mk | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> > index 913bdf5..7953e0a 100644
> > --- a/include/mk/env_post.mk
> > +++ b/include/mk/env_post.mk
> > @@ -44,7 +44,7 @@ endif
> >  ifeq ($(ANDROID),1)
> >  # There are many undeclared functions, it's best not to accidentally overlook
> >  # them.
> > -CFLAGS    += -Werror-implicit-function-declaration
> > +CFLAGS    += -Werror-implicit-function-declaration -D__ANDROID__
> Would adding __ANDROID__ definition help building LTP with distro
> cross-compiler? (i.e. no NDK, no inside AOSP tree)?
> I guess so and therefore, I'd be for this change.
> I see some projects added it as well (busybox [1] [2], dnsmasq [3]).
> BTW: where is defined for AOSP and NDK?

I think I've used __ANDROID__ and __BIONIC__ in the past for android-specific
things.  Honestly, I haven't tried to build for Android outside of AOSP tree
yet. I am happy to test this if you tell me how? (sorry for that.)

Steve will also be back by 4/15 and he would know this more than I do.
So,  Ideally, if we can wait for him it will be great. In the mean time, I
can test..

FWIW, I want to be able to do this as well. I know its a lot of pain to have
to checkout 100s of gigabytes of AOSP tree in order to build LTP for Android
right now. So, let me know how I can test and compare.

<snip>


- ssp
