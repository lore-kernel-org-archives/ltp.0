Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Ngxem-00065D-VV
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 09:54:20 +0000
Date: Mon, 15 Feb 2010 10:55:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100215095532.GB19525@saboteur.suse.cz>
References: <20100205172438.GA2333@saboteur.suse.cz>
	<364299f41002051125x3fe2446dx2d67e5e4f687274f@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002051125x3fe2446dx2d67e5e4f687274f@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix buffer overflow in sem_getvalue tests
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Attached patch fixes possible buffer oveflow in sem_getvalue tests (the buffer
> > overflow happens when getpid() returns number that couldn't fit into buffer)
> > and also cleans coding style.
> 
> 1. Why 64?
> 2. It should be #define'd and/or sizeof should be used in snprintf
> because they're fixed array buffers...
> 

Just because I'm still not used to sizeof(array) (and had a little time for
creating this patch) will resend cleaner version soon.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
