Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvS1A-0005PT-Ih
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:13:52 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvS19-0006YQ-LF
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 10:13:52 +0000
Received: by wwb29 with SMTP id 29so2715482wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 02:13:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D6AF509.7000302@cn.fujitsu.com>
References: <4D662E3A.1050802@cn.fujitsu.com>
	<AANLkTim+d5gTwh84n2s79f2s+TmZD7AMuK65iQAfQ9yw@mail.gmail.com>
	<4D6AF509.7000302@cn.fujitsu.com>
Date: Fri, 4 Mar 2011 02:13:45 -0800
Message-ID: <AANLkTinfLc-WM3vkV7WWFNxdAjFMEz1LiHT9CqA5+fih@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] The parent process need exit of waitpid11.c,
 waitpid12.c, waitpid13.c
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

On Sun, Feb 27, 2011 at 5:06 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Garrett Cooper said the following on 2011-2-25 0:46:
>>> There are two processes in cases, and the test need run from child process,
>>> so parent process should exit after invoking cleanup().
>>
>> Looks fine. I'll commit it tonight if no one else beats me to it.
>> Thanks,
>
> Garrett,
>
> Would you commit the patch?

I've committed a more extensive patch. Please test it out and let me
know how it goes -- thanks!
-Garrett

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
