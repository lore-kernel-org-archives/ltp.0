Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NHcAV-0005OO-56
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 11:54:19 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NHcAO-00084r-Sv
	for ltp-list@lists.sourceforge.net; Mon, 07 Dec 2009 11:54:19 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB7BnIHc014614
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 06:49:18 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB7Bs7wd125322
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 06:54:07 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB7Bs7j9012635
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Dec 2009 06:54:07 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912041643.nB4GhMmX007322@e1.ny.us.ibm.com>
References: <200912041643.nB4GhMmX007322@e1.ny.us.ibm.com>
Date: Mon, 07 Dec 2009 17:23:59 +0530
Message-Id: <1260186839.6866.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix overreaching clean targets in Makefiles
	that	cleaned the readme files
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2009-12-04 at 17:31 +0100, Jiri Palecek wrote: 
> Hello,
> 
> the makefiles in some of the float tests contain the glob "[dr]*" in their clean targets. Unfortunately, this deletes not only the generated reference files, but also the readme files shipped in those directories. This patch fixes it by changing CLEAN_TARGETS to more specific patterns (that capture all generated files in all float tests, however).
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/misc/math/float/iperb/Makefile |    3 ++-
>  testcases/misc/math/float/trigo/Makefile |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/misc/math/float/iperb/Makefile b/testcases/misc/math/float/iperb/Makefile
> index e7a6774..6b538d1 100644
> --- a/testcases/misc/math/float/iperb/Makefile
> +++ b/testcases/misc/math/float/iperb/Makefile
> @@ -24,7 +24,8 @@ top_srcdir		?= ../../../../..
> 
>  include $(top_srcdir)/include/mk/env_pre.mk
> 
> -CLEAN_TARGETS		:= [dr]* *.ref*
> +CLEAN_TARGETS		:= [rd]*sin [rd]sinh [rd]*cos [rd]cosh [rd]*tan [rd]*tan2		\
> +[rd]tanh *.ref*
> 
>  LDLIBS			+= -lm
> 
> diff --git a/testcases/misc/math/float/trigo/Makefile b/testcases/misc/math/float/trigo/Makefile
> index c7390ff..4abf9f9 100644
> --- a/testcases/misc/math/float/trigo/Makefile
> +++ b/testcases/misc/math/float/trigo/Makefile
> @@ -24,7 +24,8 @@ top_srcdir		?= ../../../../..
> 
>  include $(top_srcdir)/include/mk/env_pre.mk
> 
> -CLEAN_TARGETS		:= [dr]*
> +CLEAN_TARGETS		:= [rd]*sin [rd]sinh [rd]*cos [rd]cosh [rd]*tan [rd]*tan2		\
> +[rd]tanh
> 
>  LDLIBS			+= -lm
> 


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
