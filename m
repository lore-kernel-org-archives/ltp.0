Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PzTBR-00042R-Ea
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 12:17:05 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PzTBQ-0006tN-Dd
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 12:17:05 +0000
Received: by wwj40 with SMTP id 40so625195wwj.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Mar 2011 05:16:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D7B4202.1020302@cn.fujitsu.com>
References: <4D7B4202.1020302@cn.fujitsu.com>
Date: Tue, 15 Mar 2011 05:16:58 -0700
Message-ID: <AANLkTi=LjJFgpUAKpbaBVzrfFzXYQxhUbNGQea5C=Hq9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ftest06.c: fix error of the child process need
	exit
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Sat, Mar 12, 2011 at 1:50 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
>
> The child process should exit after invoking dotest().

Committed -- thanks.
-Garrett

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
