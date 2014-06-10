Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WuP9a-0001T3-6H
	for ltp-list@lists.sourceforge.net; Tue, 10 Jun 2014 16:44:06 +0000
Date: Tue, 10 Jun 2014 18:43:56 +0200
From: chrubis@suse.cz
Message-ID: <20140610164356.GA20465@rei.Home>
References: <1402412380-3810-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402412380-3810-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH v2] syscalls/fstatfs02: Using temporary file
 description to test the syscall
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> It is not expected to use stdout as the file description to test the
> system call fstatfs().Using ltp temporary file instead.

Pushed, thanks.

Note that I've also added a testcase into the fstatfs01 that ensures
that fstatfs() works with pipe() file descriptors.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
