Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PGY8u-0002xg-Fk
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 14:28:48 +0000
Date: Thu, 11 Nov 2010 15:39:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101111143952.GA24599@saboteur.suse.cz>
References: <4CDB5E53.6070604@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4CDB5E53.6070604@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH 0/2]aio_suspend may be interrupted by
 completion signal.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> aio_suspend may be interrupted by IO request's completion signal, so we
> should use aio_error instead signal hander to check whether this request
> has complete.

This seems reasonable, as in the original code any aio_read could send
the signal that could interrupt aio_suspend (and even completion of the
aio request we are waiting for could interrupt it with signal).

And as I quick looked at the code and there is more to fix:

Bugs:

* relying on write() writing the whole buffer

* not checking malloc() return value


Conding style issues:

* bunch of useless pointer cast

* spaces between function names and () (all free (..), malloc (...) ...)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
