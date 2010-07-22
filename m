Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Oc067-000676-NS
	for ltp-list@lists.sourceforge.net; Thu, 22 Jul 2010 18:02:19 +0000
Date: Thu, 22 Jul 2010 20:17:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100722181736.GA5936@saboteur.suse.cz>
References: <20100722133111.GA30090@saboteur.suse.cz>
	<AANLkTimAD6agCAWt4g3R1V0jvAKvTMe7wgOvDZ7cCH8v@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimAD6agCAWt4g3R1V0jvAKvTMe7wgOvDZ7cCH8v@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix pthread_mutex_getprioceiling testcase
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
> 2. So you're saying that none of the pthread(5) functions provide
> useful diagnostics, even though the manpages claim they should (in
> many cases)? That seems like a bug with the pthreads implementation to
> me...

Not at all, as far as I understand this they just return error as
integer value from function to indicate the error, most likely due to
problems with errno and race conditions as program runs in more threads,
so they are not touching errno that is later picked up by perror() call.
So you would get:

"pthread_xxx_xxx() failed: Success"

or any previous errno that was there instead of:

"pthread_xxx_xxx() failed: Invalid value"

I'm just saying that you should not use perror() for pthread functions
but rather use value returned from such function.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
