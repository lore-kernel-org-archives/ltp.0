Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XK6Vs-0008UE-89
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 14:05:20 +0000
Date: Wed, 20 Aug 2014 16:04:16 +0200
From: chrubis@suse.cz
Message-ID: <20140820140416.GA23235@rei>
References: <98fd8c728c27239472b635ea5e61ee69c3685a16.1408524328.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98fd8c728c27239472b635ea5e61ee69c3685a16.1408524328.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] timerfd_settime01: initialise itimerspec new_value
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
> Before kernel validates that fd is valid, it checks itimerspec struct
> with timespec_valid(). This struct is currently not initialised in test,
> which can cause failures, for example:
> 
> timerfd_settime01    1  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
>                         failed unexpectedly; expected: 9 - Bad file
>                         descriptor: TEST_ERRNO=EINVAL(22): Invalid argument
> timerfd_settime01    2  TFAIL  :  timerfd_settime01.c:121: timerfd_settime()
>                         failed unexpectedly; expected: 14 - Bad address:
>                         TEST_ERRNO=EINVAL(22): Invalid argument
> 
> Fix this by giving fields in this struct some deterministic values
> (zero in this patch).

I've reproduced the failure and tested the fix.

Tested and acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
