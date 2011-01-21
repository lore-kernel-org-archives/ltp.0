Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pg7ix-0004r6-VO
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 03:31:43 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1Pg7iw-0007C9-RT
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 03:31:43 +0000
Received: by wwi18 with SMTP id 18so1326223wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 19:31:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1295579994-23856-1-git-send-email-lmr@redhat.com>
References: <1295579994-23856-1-git-send-email-lmr@redhat.com>
Date: Thu, 20 Jan 2011 19:31:36 -0800
Message-ID: <AANLkTinwguHbG+JEi=nQXnnHOdT6Aa=aF8Fsp7dRmdCP@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] KSM test: Fix compilation
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
To: Lucas Meneghel Rodrigues <lmr@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 20, 2011 at 7:19 PM, Lucas Meneghel Rodrigues
<lmr@redhat.com> wrote:
> In the ksm Makefile, I noticed that the author used
> the generic_trunk_target.mk macro, instead of the
> generic_leaf_target.mk macro, leading to compilation
> failures. This patch fixes the problem.
>
> Signed-off-by: Lucas Meneghel Rodrigues <lmr@redhat.com>
> ---
> =A0testcases/kernel/mem/ksm/Makefile | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm=
/Makefile
> index 81509bf..9da67a8 100644
> --- a/testcases/kernel/mem/ksm/Makefile
> +++ b/testcases/kernel/mem/ksm/Makefile
> @@ -39,5 +39,5 @@ trunk-clean:: | lib-clean
> =A0lib-clean:: $(LIBDIR)
> =A0 =A0 =A0 =A0$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
>
> -include $(top_srcdir)/include/mk/generic_trunk_target.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> =A0include $(top_srcdir)/include/mk/testcases.mk

This is the fully correct way of doing this:

$ git diff testcases/kernel/mem/ksm/Makefile

diff --git a/testcases/kernel/mem/ksm/Makefile
b/testcases/kernel/mem/ksm/Makefile
index 81509bf..8138d70 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -18,12 +18,11 @@

 top_srcdir              ?=3D ../../../..

-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk

 LDLIBS                 +=3D $(NUMA_LIBS) -lmem
 LIBDIR                 :=3D ../lib
 LIB                    :=3D $(LIBDIR)/libmem.a
-FILTER_OUT_DIRS                :=3D $(LIBDIR)
 LDFLAGS                        +=3D -L$(LIBDIR)

 $(LIBDIR):
@@ -39,5 +38,4 @@ trunk-clean:: | lib-clean
 lib-clean:: $(LIBDIR)
        $(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean

-include $(top_srcdir)/include/mk/generic_trunk_target.mk
-include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk

    Granted, Cai should have used a Makefile.inc file and included it
from all of the Makefiles though that required this library if it was
indeed a portable library. Otherwise he should just move the source to
the test directory and compile / link the testcases with the
additional source file. There are examples hanging around the source
tree that do this (testcases/kernel/syscalls/... ), but I don't
remember where they are exactly.
Thanks,
-Garrett

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
