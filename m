Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YXrcK-00069M-Tu
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 13:33:08 +0000
Date: Tue, 17 Mar 2015 14:32:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150317133216.GA28649@rei.suse.de>
References: <20150317070840.GA2801@issan.sis.pasteur.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150317070840.GA2801@issan.sis.pasteur.fr>
Subject: Re: [LTP] [PATCH] Fix unprivileged llseek01 behaviour
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Running llseek01 testcase as unprivileged user currently fails.
> 
> njoly@raya [syscalls/llseek]> ./llseek01
> llseek01    1  TPASS  :  Functionality of llseek() on tmp_file successful
> llseek01    2  TBROK  :  llseek01.c:223: Cannot reset max. file size using setrlimit
> llseek01    3  TBROK  :  llseek01.c:223: Remaining cases broken
> 
> This issue comes from cleanup function that tries to restore
> previously altered file size limit. But this fails as unprivileged
> because it cannot raise the hard limits.

Either we remove the restoration or add tst_require_root() to setup(),
I'm fine with either one. However this patch is incomplete because it
removes only the restoration part but leaves the then unused getrlimit()
that gets the original limit in setup, this should be removed (with the
global rlp_orig variable) as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
