Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PpqTD-0007tt-Iu
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 23:07:39 +0000
Date: Thu, 17 Feb 2011 00:27:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110216232710.GC20313@saboteur.suse.cz>
References: <4D595337.5070801@nokia.com>
	<20110214154030.GC426@saboteur.suse.cz>
	<20110214165816.GA3734@saboteur.suse.cz>
	<20110214175032.GA5716@saboteur.suse.cz>
	<20110214194108.GA8474@saboteur.suse.cz>
	<06C8093A-387B-40E4-A625-5E0C7AACC38D@gmail.com>
	<1E5B522887F7DD4CB1654389A51E3636D66A64@008-AM1MPN1-025.mgdnok.nokia.com>
	<AANLkTin=Q1uu-w_+V8tcGdY1E0nQex2qxtiy0hfjkBVq@mail.gmail.com>
	<4D5A5FB4.7010300@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D5A5FB4.7010300@nokia.com>
Subject: Re: [LTP] [PATCH] Fix the file permissions and other issues in
 "fs_perms" tests
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
To: maxin <john.maxin@nokia.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Cyril, could you please share the Linux kernel version and the some
> other details like name of the Linux distribution
> that you are using. I think that would help.

It seems to work on various openSuSE instances (2.6.31 for example) as
well as on gentoo with 2.6.37.

But unix/linux security model is full of special cases and even more fun
when things like securebits and capabilities comes to play.

Anyway, I'm planning to rewrite the test to rely on setuid() and
setgid() rather than on seteuid() and setegid(), which should be quite
deterministic.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
