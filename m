Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Sa4rS-0002Gy-DS
	for ltp-list@lists.sourceforge.net; Thu, 31 May 2012 12:52:18 +0000
Date: Thu, 31 May 2012 14:50:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120531125029.GA3926@saboteur.suse.cz>
References: <CAGH67wR4WAyLTm1CN-nV3hSt_qZ5OGq3ZnqgL2yJ3wX_SyOY7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wR4WAyLTm1CN-nV3hSt_qZ5OGq3ZnqgL2yJ3wX_SyOY7Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix clock_settime/4-2
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> 1. The threshold was too low; setting it to 10 seconds and adding an
>    overlap of 5 seconds ensures that the SIGALRM handler fires.

I do not agree with this part. The system time is set four seconds after
the created timer expiration time and because of that the signal hanlder
must be called immediately after that change (unless machine is under
heavy load, of course).

Looking at the code more closely, I'm not sure if it's a good idea to
mix sleep() (which may be implemented via SIGALRM) and timers that cause
SIGALRM too. The POSIX seems to say that it's not specified if signal
handler will be called in such case, only the interruption of sleep() is
guaranteed. 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
