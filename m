Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQuPE-0000p3-8R
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 09:06:52 +0000
Date: Thu, 26 Feb 2015 10:06:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150226090612.GB12353@rei.suse.de>
References: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1424800340-10357-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] containers: semctl replaced with semop in
 sysvipc/sem_comm.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> semctl call replaced with semop call for setting up semaphores initial
> values because semctl needs non-standard type (not in sys/sem.h).

Looks like this patch accidentally reverts:

commit aabb8340f63ed31afe995fd97795e542dc68b93c
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Wed Feb 4 14:37:03 2015 +0100

    Include usctest.h in test.h

and

commit 9f136a48c6205362cd8d35c726491ca93cb16514
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue Feb 17 17:16:09 2015 +0100

    lib: Rewrite checkpoint synchronization

Can you please fix that and resend.

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
