Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UFpTf-0004PB-MF
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:28:35 +0000
Received: from mail-we0-f170.google.com ([74.125.82.170])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UFpTe-0004zq-Mf
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:28:35 +0000
Received: by mail-we0-f170.google.com with SMTP id z53so1246867wey.15
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Mar 2013 10:28:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201303131322.49014.vapier@gentoo.org>
References: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
	<201303131322.49014.vapier@gentoo.org>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Wed, 13 Mar 2013 17:28:08 +0000
Message-ID: <CAG2jQ8hr0paKFEs31uBrmdUNNCewhpZhk=+o6ocvy5X0eKFVbw@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2] ltp: Add support for Imagination Technologies
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

On 13 March 2013 17:22, Mike Frysinger <vapier@gentoo.org> wrote:
>>
>> -#if defined(__hppa__)
>> +#if defined(__hppa__) || (__metag__)
>
> you're missing "defined"
>

Looking a couple of lines above this I see the following:

#if defined (__s390__) || (__s390x__)

so I assumed this is the desired style for multiple "#if defined" constructs.

But if you want me to rewrite the patch so include the missing
"defined" let me know.

>>       ret = clone(fn, stack, clone_flags, arg);
>>  #elif defined(__ia64__)
>>       ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL, NULL);
>
> i wonder if we could make this into a runtime test.  like declare a buffer on
> the stack, then call alloca(), and compare the resulting pointers.
> -mike

If you ask me, I prefer the way it is now.

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
