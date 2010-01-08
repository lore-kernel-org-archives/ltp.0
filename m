Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1NTDYg-0007fj-Vq
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 12:03:14 +0000
Received: from maroilles.sis.pasteur.fr ([157.99.64.223]
	helo=mail-interne3.pasteur.fr)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NTDYe-0004N9-CX
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 12:03:13 +0000
Date: Fri, 8 Jan 2010 12:25:34 +0100
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100108112534.GA333981@medusa.sis.pasteur.fr>
References: <4B46D5F0.3090801@teldevice.co.jp>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B46D5F0.3090801@teldevice.co.jp>
Subject: Re: [LTP] LTP installation  configure Error
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
To: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 08, 2010 at 03:51:28PM +0900, TED ITC Agarwal Ashish wrote:
> Hello All
> 
> I am novice for the LTP, just last week i heard something LTP
> and feel curious about it so started searching and installations.
> 
> "./configure " generates Error to me as written below.
> 
> configure: error: Couldn't find functional copy of quota v2 - are you running 2.4.x?

Hi,

I do see the same with an old 2006.0 Gentoo base (actually in a
chroot) ... I worked around it by making it a warning instead of an
error.

IMHO, lacking some features should not prevent building/running LTP.


Index: m4/ltp-quota.m4
===================================================================
RCS file: /cvsroot/ltp/ltp/m4/ltp-quota.m4,v
retrieving revision 1.4
diff -u -p -r1.4 ltp-quota.m4
--- m4/ltp-quota.m4	20 Dec 2009 00:36:35 -0000	1.4
+++ m4/ltp-quota.m4	8 Jan 2010 11:24:14 -0000
@@ -37,7 +37,7 @@ dnl}],[has_24_quotactl="yes"],
 #include <unistd.h>],[
 int main(void) {
 	return quotactl(Q_GETINFO, (const char *)NULL, geteuid(), (caddr_t)NULL);
-}],[has_quotav2="yes"],[AC_MSG_ERROR([Couldn't find functional copy of quota v2 - are you running 2.4.x?])])
+}],[has_quotav2="yes"],[AC_MSG_WARN([Couldn't find functional copy of quota v2 - are you running 2.4.x?])])
 dnl if test "x$has_24_quotactl" = "xyes"; then
 dnl	AC_DEFINE(HAS_24_QUOTACTL,1,[Define to 1 if you have the 2.4.x version of quotactl, e.g. require linux/quota.h instead of sys/quota.h])
 dnl elif test "x$has_new_26_quotactl" = "xyes"; then

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
