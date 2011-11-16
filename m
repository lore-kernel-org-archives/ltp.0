Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RQg1W-0000RU-MN
	for ltp-list@lists.sourceforge.net; Wed, 16 Nov 2011 13:59:34 +0000
Date: Wed, 16 Nov 2011 15:06:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111116140611.GC27683@saboteur.suse.cz>
References: <e9647cdbda675e315776948ed7731ceb68757dd7.1321364606.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9647cdbda675e315776948ed7731ceb68757dd7.1321364606.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] safe_macros.h: fix warning
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> The following warning is given when compiling testcases with
> safe_macros.h included:
> 
> .../safe_macros.h:62: warning: ???struct rusage??? declared inside parameter list
> .../safe_macros.h:62: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> This patch does a quick fix to get rid of the warning.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
