Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WQKoc-0001t4-0x
	for ltp-list@lists.sourceforge.net; Wed, 19 Mar 2014 18:02:10 +0000
Date: Wed, 19 Mar 2014 19:01:47 +0100
From: chrubis@suse.cz
Message-ID: <20140319180146.GB27687@rei.Home>
References: <87r46seayt.fsf@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r46seayt.fsf@redhat.com>
Subject: Re: [LTP] [PATCH v3] syscalls/fork: add new case fork14
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
To: Madper Xie <cxie@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> This testcase is a reproducer for https://lkml.org/lkml/2012/4/24/328.[1]
> Modified from Siddhesh Poyarekar's testcase posted on above link.
> Since vma length in dup_mmap is calculated and stored in a unsigned
> int, which is insufficient and hence overflows for very large maps
> (beyond 16TB). Once overflow occurred, the fork after mmaped memory >
> 16TB will succeed incorrectly.
> 
>     This case will run following loop:
>              + mmap one (more) GB memory
>              + fork and check return value.
>     When mmaped more than 16 * 1024 GB, it will check if fork still fail.
>     Expected result: Fork failed even if mmaped memory > 16 * 1024 GB
> 
> The issue has been fixed by:
>   commit 7edc8b0ac16cbaed7cb4ea4c6b95ce98d2997e84
>   Author: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
>     mm/fork: fix overflow in vma length when copying mmap on clone

I've added an .gitignore record for the fork13 binary, removed the set
but not used addr variable and pushed the test.

I've also checked that the test indeed fails on older kernels.

Thanks.

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
