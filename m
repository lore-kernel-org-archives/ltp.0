Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ROrc9-0005od-Tp
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 13:57:53 +0000
Date: Fri, 11 Nov 2011 15:04:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111111140404.GA13045@saboteur.suse.cz>
References: <4EB29B17.7090607@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EB29B17.7090607@redhat.com>
Subject: Re: [LTP] [PATCH] memcg_function_test: do a warmup before actual
 test
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Commited thanks.

> What happens now is:
> spawn process
> [NEW] signal it with SIGUSR1 (alloc)
> [NEW] signal it with SIGUSR1 (free)

Doing malloc() and/or free() from signal handler is simply wrong and
will lead to memory corruptions or deadlocks someday. Here it may work
most of the time as you aren't doing anything in the main program loop,
but still correct way of doing this is to create pipe and sleep on the
file decriptor.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
