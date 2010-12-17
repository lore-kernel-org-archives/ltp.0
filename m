Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PTawQ-0005j3-6h
	for ltp-list@lists.sourceforge.net; Fri, 17 Dec 2010 14:05:50 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id CACCA8726A
	for <ltp-list@lists.sourceforge.net>;
	Fri, 17 Dec 2010 15:05:42 +0100 (CET)
Date: Fri, 17 Dec 2010 15:20:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101217142007.GA6682@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] sysconf(_SC_ASYNCHRONOUS_IO) != 200112L
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
To: ltp-list@lists.sourceforge.net

Hi!
Newer glibc returns 200809 as a result from sysconf(_SC_ASYNCHRONOUS_IO)
(the git commit was done on 26 Feb 2009) and the change seems to be
propagated into stable glibc versions (mine is 2.11.2-r3).

The problem is that nearly all aio testcases starts with

if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
	return PTS_UNRESOLVED;

So these tests are disabled with newer glibc.

However the changes between posix 200112 and 200908 seems to be minimal
(I haven't been able to find the full list of changes, but at least the
 testcases seems to work.)

My proposal is to do one of the following:

* remove these two lines to enable the tests

* change them to sysconf(_SC_ASYNCHRONOUS_IO) >= 200112L

(I would gladly prepare patch, once we agree on reasonable solution)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
