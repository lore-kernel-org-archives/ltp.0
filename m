Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1MgIDp-0005og-JG
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:07:29 +0000
Received: from munster3.sis.pasteur.fr ([157.99.64.214])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MgIDo-0000V4-Bd
	for Ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 13:07:29 +0000
Date: Wed, 26 Aug 2009 15:07:17 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20090826130717.GA50086@medusa.sis.pasteur.fr>
References: <alpine.LRH.2.00.0908261443220.25669@vixen.sonytel.be>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0908261443220.25669@vixen.sonytel.be>
Subject: Re: [LTP] undefined macro: _m4_divert_diversion
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Test Project <Ltp-list@lists.sourceforge.net>

On Wed, Aug 26, 2009 at 02:57:10PM +0200, Geert Uytterhoeven wrote:
> When trying to autoconfigure current LTP on YDL, I get:
> 
>     # make autotools 
>     touch config.mk
>     aclocal -I m4
>     m4/ltp-unshare.m4:2: error: m4_defn: undefined macro: _m4_divert_diversion
>     m4/ltp-unshare.m4:2: the top level
>     autom4te: /usr/local/bin/m4 failed with exit status: 1
>     aclocal: autom4te failed with exit status: 1
>     make: *** [aclocal.m4] Error 1
>     #
[...]

This is a quoting problem ... The following patch should fix it.

Index: m4/ltp-unshare.m4
===================================================================
RCS file: /cvsroot/ltp/ltp/m4/ltp-unshare.m4,v
retrieving revision 1.1
diff -u -p -r1.1 ltp-unshare.m4
--- m4/ltp-unshare.m4	25 Aug 2009 07:37:46 -0000	1.1
+++ m4/ltp-unshare.m4	26 Aug 2009 13:04:03 -0000
@@ -1,2 +1,2 @@
 AC_DEFUN([LTP_CHECK_SYSCALL_UNSHARE],
-AC_CHECK_FUNCS_ONCE(unshare))
+[AC_CHECK_FUNCS_ONCE([unshare])])

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
