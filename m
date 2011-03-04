Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvXh1-00027v-Qh
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:17:27 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvXh1-0006qn-1a
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:17:27 +0000
Received: by wyb38 with SMTP id 38so2606307wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 08:17:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D710C76.40900@redhat.com>
References: <4D662E3A.1050802@cn.fujitsu.com>
	<AANLkTim+d5gTwh84n2s79f2s+TmZD7AMuK65iQAfQ9yw@mail.gmail.com>
	<4D6AF509.7000302@cn.fujitsu.com>
	<AANLkTinfLc-WM3vkV7WWFNxdAjFMEz1LiHT9CqA5+fih@mail.gmail.com>
	<4D710C76.40900@redhat.com>
Date: Fri, 4 Mar 2011 08:17:20 -0800
Message-ID: <AANLkTinEEo_hPbZzKVa-LgEp_Qyx9zcNJ6OO0Lyy6rXQ@mail.gmail.com>
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Mar 4, 2011 at 7:59 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 03/04/2011 06:13 PM, Garrett Cooper wrote:
>> I've committed a more extensive patch. Please test it out and let me
>> know how it goes -- thanks!
>> -Garrett
>
> Hi Garrett, compile error occurs in this patch, here is a fix.

Sorry for the error -- thanks.
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
