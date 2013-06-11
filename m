Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1UmKzF-0004kD-DL
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 09:35:33 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UmKzE-0006S0-LB
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 09:35:33 +0000
Message-ID: <51B6EF41.5090702@oracle.com>
Date: Tue, 11 Jun 2013 13:34:57 +0400
From: alexey.kodanev@oracle.com
MIME-Version: 1.0
References: <1370528507-15313-1-git-send-email-alexey.kodanev@oracle.com>
	<201306102131.04281.vapier@gentoo.org>
In-Reply-To: <201306102131.04281.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] configure: add configure checks to compile kernel
 modules
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


On 06/11/2013 05:31 AM, Mike Frysinger wrote:
> On Thursday 06 June 2013 10:21:47 Alexey Kodanev wrote:
>
> you've apparently deleted the phrase "either version 2 of the License, or (at
> your option) any later version.".  i have no idea why you would do such a
> thing, but it's obviously not desirable.  apparently this isn't the first time
> as i see you've done it in at least 0e335dbed65afb79eab5b30e8d49d8066f165316.
>
> please send a patch to fix your previous commits, and fix this one as well.  or
> i'm afraid we'll have to revert.
>
Sure, I will fix it.
> defaulting like this won't work.  you need to check $cross_compiling is set to
> yes in order to default to `uname -r`.
>
> seems like it'd be simpler to just do:
> 	AC_ARG_WITH([linux-version], [AC_HELP_STRING(...)],,
> 		AS_IF([test "$cross_compiling" != no],
> 			[with_linux_version=`uname -r`]))
> 	LINUX_VERSION=$with_linux_version
> 	AC_SUBST(LINUX_VERSION)
>
May be defaulting it to `uname -r` when $cross_compiling is set to no?

Thanks,
Alexey

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
