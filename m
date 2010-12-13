Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PS4WW-00083K-UY
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:16:48 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS4WV-0006Wi-KH
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 09:16:48 +0000
Received: by wyb40 with SMTP id 40so5563603wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Dec 2010 01:16:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D058241.7040603@cn.fujitsu.com>
References: <4D058241.7040603@cn.fujitsu.com>
Date: Mon, 13 Dec 2010 01:16:41 -0800
Message-ID: <AANLkTim_ExzOr2G-NnzLWB=b14zj8s5c1pYjsZEkine7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About Community discussion
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sun, Dec 12, 2010 at 6:17 PM, Gui Jianfeng
<guijianfeng@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> I'm sorry to bother you. My team is trying to make LTP more stable and
> make openposix testsuite less bugs. We'd like to continue to contribute
> to it. But I found you stop replying our mail for a long time. I'm not
> sure whether you have received these mails. Or whether you have some
> concerns? If yes, please let me know. :)

Hi Gui,
    What concerns me isn't the fact that people are `finding
problems', it's the analysis and the quality of the patches provided
back which are problematic. Some of the analysis is spot on, some is
way off the mark, and other analysis is incomplete; furthermore some
of the patches fed back are hacky or unmaintainable. Add to that the
fact that I'm not getting paid for this work and it no longer really
aligns with my current job charter, I've been neglecting this in favor
of more critical items in my life.
    That being said, it still puzzles me why other folks attached to
the project have been largely silent over the past couple months or
years (in particular the official maintainers), as I would figure that
they would have a vested interest in insuring that the changes being
committed to the project are consistent and/or high quality.
    I will look at the open_posix_testsuite items again tonight and
will make a best effort at fixing things. I may not get as much done
as people like, but I'm being more conservative to avoid missteps and
incorrect commits.
Thanks,
-Garrett

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
