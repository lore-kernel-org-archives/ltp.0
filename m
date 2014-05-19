Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmMUG-0003Rf-0y
	for ltp-list@lists.sourceforge.net; Mon, 19 May 2014 12:16:12 +0000
Date: Mon, 19 May 2014 14:15:53 +0200
From: chrubis@suse.cz
Message-ID: <20140519121553.GA4334@rei>
References: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397731818-26430-2-git-send-email-gux.fnst@cn.fujitsu.com>
	<20140515121430.GC23965@rei.Home> <53756E7A.6070009@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53756E7A.6070009@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] rmdir/rmdir02.c: add ELOOP,
 EROFS and EBUSY error value tests
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
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > I've removed the EUID changes for all because these has no effect on the
> > test behavior (at least I haven't figured out why they are needed).
> 
> I tested with the UEID is aimed to prove the system call can be executed 
> right with a normal user account, to provide a more overall testcase.

I've looked at the testcase again, and it seems to me that there would
be no difference on the results of these testcases (IMHO they would
still hit the same check in the rmdir() syscall in kernel both under
privileged and unprivileged user). Did I miss somethink?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
