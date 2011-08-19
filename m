Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QuMvh-0004vH-En
	for ltp-list@lists.sourceforge.net; Fri, 19 Aug 2011 11:08:01 +0000
Date: Fri, 19 Aug 2011 13:12:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110819111240.GA24503@saboteur.suse.cz>
References: <1313743491-13887-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1313743491-13887-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] sigqueue:9-1:make the running user to nobody to
 avoid test fail
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> According to the Linux kernel code, we know that the sigqueue is
> allocated and queue the signal to it's list by the system call
> rt_sigqueueinfo(2) which called by sigqueue(3) in this test code.
> Meanwhile, if the signal is queued, it increase the user's sigpending
> field. Then if it going to queue another signal, it read the rlimit of
> the sigpending from the task's signal->rlim[] member and compare with
> the user's current sigpending number.
> So, it's the issue. The user who is running this code may have other
> pending signals before this, and actually it does.

Clever, that may actually work, however there may be two problems:

* I'm not sure if existence of user nobody is granted by POSIX
* There may be some system daemons running under user nobody

Perhaps we need to create a fresh user before the testing has started.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
