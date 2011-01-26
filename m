Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PhzKb-0004j4-D4
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 06:58:17 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PhzKa-0004Gm-Gd
	for ltp-list@lists.sourceforge.net; Wed, 26 Jan 2011 06:58:17 +0000
Received: by wyb40 with SMTP id 40so616225wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Jan 2011 22:58:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3FC51B.3080306@cn.fujitsu.com>
References: <4D3FC51B.3080306@cn.fujitsu.com>
Date: Tue, 25 Jan 2011 22:58:09 -0800
Message-ID: <AANLkTin52dVdOUf0K25Sma2NrGLmet9aK7tbUmg3fKds@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix Makefile of testcase/kernel/mem/ksm/
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 25, 2011 at 10:54 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrot=
e:
> There is not any directory at testcase/kernel/mem/ksm/,
> so replace generic_trunk_target.mk by generic_leaf_target.mk
>
> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> ---
> =A0testcases/kernel/mem/ksm/Makefile | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm=
/Makefile
> index 81509bf..22190f1 100644
> --- a/testcases/kernel/mem/ksm/Makefile
> +++ b/testcases/kernel/mem/ksm/Makefile
> @@ -39,5 +39,5 @@ trunk-clean:: | lib-clean
> =A0lib-clean:: $(LIBDIR)
> =A0 =A0 =A0 =A0$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
>
> -include $(top_srcdir)/include/mk/generic_trunk_target.mk
> =A0include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

    Forgot about that Makefile that Cai submitted. How about this instead?
Thanks,
-Garrett

diff --git a/testcases/kernel/mem/ksm/Makefile
b/testcases/kernel/mem/ksm/Makefile
index 81509bf..fdff5fc 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -18,7 +18,7 @@

 top_srcdir              ?=3D ../../../..

-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk

 LDLIBS                 +=3D $(NUMA_LIBS) -lmem
 LIBDIR                 :=3D ../lib
@@ -39,5 +39,4 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
        $(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean

-include $(top_srcdir)/include/mk/generic_trunk_target.mk
-include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk

---------------------------------------------------------------------------=
---
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires =

February 28th, so secure your free ArcSight Logger TODAY! =

http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
