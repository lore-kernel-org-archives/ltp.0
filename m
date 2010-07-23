Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OcF1G-0008Oj-CE
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 09:58:18 +0000
Date: Fri, 23 Jul 2010 12:13:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100723101338.GB19210@saboteur.suse.cz>
References: <20100722133111.GA30090@saboteur.suse.cz>
	<AANLkTimAD6agCAWt4g3R1V0jvAKvTMe7wgOvDZ7cCH8v@mail.gmail.com>
	<20100722181736.GA5936@saboteur.suse.cz>
	<AANLkTikTXuwc4hGrLRqkcoE12_6RMhNP7fW2oBLHafA0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikTXuwc4hGrLRqkcoE12_6RMhNP7fW2oBLHafA0@mail.gmail.com>
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
> >> 2. So you're saying that none of the pthread(5) functions provide
> >> useful diagnostics, even though the manpages claim they should (in
> >> many cases)? That seems like a bug with the pthreads implementation to
> >> me...
> >
> > Not at all, as far as I understand this they just return error as
> > integer value from function to indicate the error, most likely due to
> > problems with errno and race conditions as program runs in more threads,
> > so they are not touching errno that is later picked up by perror() call.
> > So you would get:
> >
> > "pthread_xxx_xxx() failed: Success"
> >
> > or any previous errno that was there instead of:
> >
> > "pthread_xxx_xxx() failed: Invalid value"
> >
> > I'm just saying that you should not use perror() for pthread functions
> > but rather use value returned from such function.
> 
>     Good point. We probably should save the errno, then quickly print
> out the resulting error.

That's what print_error() function in that patch does. ;)

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
