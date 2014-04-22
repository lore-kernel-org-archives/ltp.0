Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WcayC-0001Fi-BX
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 13:42:44 +0000
Date: Tue, 22 Apr 2014 15:41:50 +0200
From: chrubis@suse.cz
Message-ID: <20140422134150.GC3951@rei>
References: <20140416091527.40612b3c@mats-desktop>
	<1397669278-848-1-git-send-email-mats.liljegren@enea.com>
	<1397669278-848-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397669278-848-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH] Make SAFE_* calls more informative when failing
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The output has been "standardized" into the following format:
> <file>:<line>: <func>(<params>) <error message>
> 
> E.g.:
> test.c:130: chdir(mydir) failed
> 
> This will then be followed by the usual errno stuff if applicable.

I've also unified conding style for the file and fixed a minor things
(use octal instead of decimal for creat() mode, the symlink error
message said link() instead of symlink(), etc.) and pushed these an one
commit, thanks.

PS: I've also decided to print open() mode regardless if it's used or
    not, which is IMHO better than not printing it at all.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
