Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UGBVB-0004vl-Kh
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:59:37 +0000
Received: from mail-wi0-f182.google.com ([209.85.212.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UGBV8-0003mV-8i
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:59:37 +0000
Received: by mail-wi0-f182.google.com with SMTP id hi18so2026667wib.3
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Mar 2013 09:59:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201303141252.53822.vapier@gentoo.org>
References: <1363183494-20392-1-git-send-email-markos.chandras@gmail.com>
	<201303131322.49014.vapier@gentoo.org>
	<CAG2jQ8hr0paKFEs31uBrmdUNNCewhpZhk=+o6ocvy5X0eKFVbw@mail.gmail.com>
	<201303141252.53822.vapier@gentoo.org>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Thu, 14 Mar 2013 16:59:08 +0000
Message-ID: <CAG2jQ8icKz_3LrKApzhE09vz1YeLZ-tCXu338DeDcaZeLbnTaQ@mail.gmail.com>
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

On 14 March 2013 16:52, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 13 March 2013 13:28:08 Markos Chandras wrote:
>> On 13 March 2013 17:22, Mike Frysinger wrote:
>> >> -#if defined(__hppa__)
>> >> +#if defined(__hppa__) || (__metag__)
>> >
>> > you're missing "defined"
>>
>> Looking a couple of lines above this I see the following:
>>
>> #if defined (__s390__) || (__s390x__)
>>
>> so I assumed this is the desired style for multiple "#if defined"
>> constructs.
>
> nope, that's a bug too

Ok I will fix that too in v2

>
>> >>       ret = clone(fn, stack, clone_flags, arg);
>> >>
>> >>  #elif defined(__ia64__)
>> >>
>> >>       ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
>> >>       NULL);
>> >
>> > i wonder if we could make this into a runtime test.  like declare a
>> > buffer on the stack, then call alloca(), and compare the resulting
>> > pointers.
>>
>> If you ask me, I prefer the way it is now.
>
> the advantage is that the next random person to grow their stock in the
> opposite direction won't have to update this hard coded list.  and if it was
> written this way earlier, you wouldn't be here right now either ;).
>
> not saying you must do this ... fix the defined checks and we can merge that
> -mike

Ok but we rarely need to touch this list (how often do you see
explicit #if/defs for new arches in LTP, especially with the stack
growing upwards?). But sure, making this check during runtime would
also be nice.

Patch v2 sent.

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
