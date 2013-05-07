Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UZh7U-0001fe-11
	for ltp-list@lists.sourceforge.net; Tue, 07 May 2013 12:35:48 +0000
Date: Tue, 7 May 2013 14:36:49 +0200
From: chrubis@suse.cz
Message-ID: <20130507123648.GA29725@rei.suse.cz>
References: <5183B105.8030106@oracle.com> <20130506122421.GD4388@rei>
	<5187DCBC.6090103@oracle.com> <5187DEA2.8020004@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5187DEA2.8020004@oracle.com>
Subject: Re: [LTP] [PATCH v2] Fix retval parameter to pthread_join()
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
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The retval parameter to pthread_join() is a pointer to a pointer. There
> are several instances where a pointer to int is being passed instead.
> This can result in a bus error on sparc64 when the pointer is not
> aligned on a 64-bit boundary. Of course, it's a potential problem on
> any 64-bit platform.
> 
> Also removed an unnecessary malloc & free from mmstress.c

Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
