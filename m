Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PATyx-0005fX-W2
	for ltp-list@lists.sourceforge.net; Mon, 25 Oct 2010 20:49:27 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DBA9194393
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Oct 2010 22:49:19 +0200 (CEST)
Date: Mon, 25 Oct 2010 22:59:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101025205915.GD3003@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] aio_error/3-1.c
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
I've been reading POSIX documentation for some time now and even reading
glibc source code and the result is that aio_error/3-1.c doesn't test
anyting and should be removed.

The test is trying to assert EINVAL from aio_error accordingly to:

http://www.opengroup.org/onlinepubs/009695399/functions/aio_error.html

...

The aio_error() function may fail if:

	[EINVAL]
            The aiocbp argument does not refer to an asynchronous
	    operation whose return status has not yet been retrieved.

...


As far as I understand this, it's says you may get EINVAL if you call
aio_error() on finished aiocb second (and more) times.

This is implemented on linux as "return aiocb->__error_code" so IMHO
there is no way to test this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
