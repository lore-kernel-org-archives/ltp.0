Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmlFr-0001Iu-IS
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 14:42:59 +0000
Date: Tue, 20 May 2014 16:42:46 +0200
From: chrubis@suse.cz
Message-ID: <20140520144246.GA30023@rei.suse.cz>
References: <20140513113904.GA12144@rei>
	<1400588683-16001-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400588683-16001-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC PATCH] A draft of the rt_sigaction syscall wrapper.
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I think that instead of an addition of "the common syscall preparation" to a define,
> it would be better to implement a wrapper to the rt_sigaction syscall.
> 
> Like this one. 
> 
> Its basis is a combination of glibc implementations of sigaction() for different
> platforms. But it also accepts '-1' for act, oact to check EFAULT errno code 
> (glibc implementation doesn't handle such a situtation).
> 
> How do you think where the best place is to put this wrapper implementation?

Given that the testcases are statically linked with the test library
anyway the easiest solution would be include/lapi/rt_sigaction.h.

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
