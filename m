Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJl1Y-0000Jo-Vx
	for ltp-list@lists.sourceforge.net; Thu, 04 Oct 2012 12:59:32 +0000
Date: Thu, 4 Oct 2012 15:00:02 +0200
From: chrubis@suse.cz
Message-ID: <20121004130002.GA18130@saboteur.suse.cz>
References: <1344032944-27019-1-git-send-email-vlee@twitter.com>
	<501F20F5.3060301@cn.fujitsu.com>
	<CAKixpbjzpzLBLuUL3rf=9ujuPC7s89DmBLehfEmHoEk4iAjjsA@mail.gmail.com>
	<50206AB5.7040701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50206AB5.7040701@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ltp_signal.h: Remove inline keyword from
 handler_h.
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I saw that "Change add to a static inline function. 
> This is usually the right solution if only one translation
> unit needs to use the function. static inline functions are
> always resolved within the translation unit, so you won't have
> to add a non-inline definition of the function elsewhere in your program."
> 
> So, why not just change it to "static inline" to resolve this?

Interestingly enough, the function is passed via pointer so compiler
couldn't inline it at all, I wonder why there was the inline in the
first place...

I've removed the inline added static and confirmed that it builds with
clang 3.1 on x86_64.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
