Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UGtsy-0000vd-LV
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 16:23:08 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UGtsw-000443-Mk
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 16:23:08 +0000
Received: by mail-wi0-f179.google.com with SMTP id ez12so1413244wid.6
	for <ltp-list@lists.sourceforge.net>;
	Sat, 16 Mar 2013 09:23:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201303161143.04543.vapier@gentoo.org>
References: <1363280151-10623-1-git-send-email-markos.chandras@gmail.com>
	<201303161143.04543.vapier@gentoo.org>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Sat, 16 Mar 2013 16:22:40 +0000
Message-ID: <CAG2jQ8jF8-EhZZGzxcxiqXE9tmysCDVOONUsJ0m3K1KtpGsc7Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp: Add support for Imagination Technologies
	Meta
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 16 March 2013 15:43, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 14 March 2013 12:55:51 Markos Chandras wrote:
>> This patch adds support for Imagination's Meta architecture.
>> The Meta Linux kernel port will be included in the Linux Kernel
>> v3.9. The Meta stack grows upwards so we need to add the appropriate
>> __metag__ macro to the ltp_clone function. Also fix the #if/def
>> macro for s390x.
>
> merged, thanks
> -mike

Thanks Mike

-- 
Regards,
Markos Chandras

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
