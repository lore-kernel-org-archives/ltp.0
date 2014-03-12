Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNltO-0000qY-U8
	for ltp-list@lists.sourceforge.net; Wed, 12 Mar 2014 16:20:30 +0000
Date: Wed, 12 Mar 2014 17:20:12 +0100
From: chrubis@suse.cz
Message-ID: <20140312162012.GA20551@rei.Home>
References: <1391607438-529-1-git-send-email-alexey.kodanev@oracle.com>
	<20140311165448.GA11407@rei> <532024B6.9080603@oracle.com>
	<20140312104505.GA13689@rei.Home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140312104505.GA13689@rei.Home>
Subject: Re: [LTP] [PATCH] device-drivers/rcu: add wrapper script for
 rcutorture test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I've noticed this too a few days ago.
> 
> I will fix these problems and add push it into LTP git and update
> test-writing-guidelines.

I've fixed one more thing (masked out the TINFO, TCONF and TRETR out of
the test return value as the C library does) and updated the
test-writing-guidelines.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
