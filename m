Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NXqjZ-0007rl-1e
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 06:41:37 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NXqjW-0008GL-JJ
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 06:41:36 +0000
Received: by pzk37 with SMTP id 37so1889970pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Jan 2010 22:41:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca9a4e$5daaed50$1900c7f0$@co.jp>
References: <000701ca998a$51aed7b0$f50c8710$@co.jp>
	<364299f41001200525v31721544t521c73aceaa4b515@mail.gmail.com>
	<000001ca9a4e$5daaed50$1900c7f0$@co.jp>
Date: Wed, 20 Jan 2010 22:41:27 -0800
Message-ID: <364299f41001202241u324d0298l605f8bb7122bda19@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] 2010-01-20 cvs build failed
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 20, 2010 at 8:01 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Garrett,
>
>
>>Solved. Typo that I didn't pick up earlier..
>
> I succeeded to build in RHEL5.4 system with 2010-01-21 cvs.
>
>>You have to use make all when compiling `all' with make instead of just
> specifying `make' with 3.81 because make 3.80 doesn't have a concept of
> default goals/targets.
>
> Thank you for your advice.
> It was my mistake.
> I succeeded to build in RHEL4.8 system by using "make3.80"!
> Great!
>
>
> Thank you--

    Np -- sometimes it takes a while to get to a proper solution, but
once there is one and it's set in stone, it's done :).
Cheers,
-Garrett

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
