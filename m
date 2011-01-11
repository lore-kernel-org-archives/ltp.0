Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcRzm-0001Lc-Mu
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 00:21:54 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcRzl-0005wu-NY
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 00:21:54 +0000
Date: Mon, 10 Jan 2011 19:21:47 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <233343295.39412.1294705307001.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <783A1EB7-BF40-4188-BF63-81C2C43EAAAE@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] hugemmap05 issues
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>


> I applied your fixes but the test is still buggy in the following
> ways:
> 
> 1. It has to be run as root (otherwise it fails with EPERM opening the
> file).
That is true for lots of LTP tests. To get the most of our of tests, it
requests root privilege. We can even setup config scripts to warning people
about the non-root users. Again, what is the guideline here? We probably
don't want to add many code to each of the test that required root.

> 2. Even when the test is run as root it leaves around allocated
> hugepages, despite the fact that the temporary filesystem has been
> unmounted.
Would you please be elaborate the failure? I can't see why it would work
that way. The cleanup routine does this.

- restore nr_hugepages
- restore nr_overcommit_hugepages
- unlink && umount (mmap case)
- shmdt (shmget case)

Thanks.

CAI Qian

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
