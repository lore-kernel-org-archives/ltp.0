Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TvUKG-0007mK-0u
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:50:48 +0000
Date: Wed, 16 Jan 2013 15:51:01 +0100
From: chrubis@suse.cz
Message-ID: <20130116145101.GC6699@rei>
References: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
	<50F6B2EF.70007@linux.vnet.ibm.com>
	<CA+icZUVRe5yzkkcO3_Lvvkmr53pZ9HmS40GgDGqd3GFdJkLqNA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUVRe5yzkkcO3_Lvvkmr53pZ9HmS40GgDGqd3GFdJkLqNA@mail.gmail.com>
Subject: Re: [LTP] Spelling "succeded" VS. "succeeded"
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> as said I am knew to LTP.
> 
> Such a typo makes grepping for special search-patterns difficult.
> I was searching for real failures by sorting out "expected" and
> "succeeded" lines.
> Even this is a trivial fix for you - it helped here :-).
> 
> Not sure what you are expecting from me.
> Might be I flood ltp-results ML with the results of my Linux-Next kernels.
> Unsure if this helps people or not.
> 
> Personally, I don't like the outputs of results...
> Especially start/end tags should include the (file)name of the testcase.
> But I had no deeper look into the results and only run the "lite" test-script.

Well the whole part of LTP that is used to run testcases is outdated and
messy. I've tried to start discussion about possible rewrite/replacement:

http://sourceforge.net/mailarchive/message.php?msg_id=30192380

But so far nothing has been done.

> Looking into the README file I see I am missing some kernel-configs to
> be enabled.
> Not sure if I really what to dig that deep into LTP.

That most likely means that some tests would return unsupported rather
than success/fail.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
