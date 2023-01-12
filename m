Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EA1C54EBC
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 10:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605B43CCA65
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 11:27:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3D823CB53A
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 11:27:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14649600D0D
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 11:27:16 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 04CF43FB60;
 Thu, 12 Jan 2023 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673519236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiPWCE3y8xjKaK0H/DJkij3fizFaduWe7GG7Uuy1+us=;
 b=PtQw0m0gN7Q6oYrQIM4YnWkTHeboD/o5UUDoNprUSBSetXi8Ro6C26Zis3mAaWw+Np7M4B
 cQ77hiM1UAheR4U6kjVhjX9MXkeXdi82KvqTqii9fxxSfPvrLox89aXWXYBVbvuPAhvWSD
 1dUS2NIdyoX3IHbLNGqEXM7xhbpHMUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673519236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FiPWCE3y8xjKaK0H/DJkij3fizFaduWe7GG7Uuy1+us=;
 b=imh+/mLtmA8w7Tfcc6EdnI9cPlgALmzuk3WinsVohai5YtCBGPDtr7yN6HheFPDZtFgu3S
 X5qjVyojFabhdnCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4EBB82C141;
 Thu, 12 Jan 2023 10:27:15 +0000 (UTC)
References: <20230103124505.6611-1-pvorel@suse.cz>
 <20230103124505.6611-2-pvorel@suse.cz> <87lemaivkv.fsf@suse.de>
 <Y72O1pYaHt6u1FvN@pevik>
 <80dd5d72-33ca-5294-6e3a-d5d8f2652b91@owlfolio.org>
 <Y73Gt6ePQzujriA6@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Jan 2023 10:21:58 +0000
Organization: Linux Private Site
In-reply-to: <Y73Gt6ePQzujriA6@pevik>
Message-ID: <87y1q8hwu5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] configure.ac: Update AC_PROG_AR related
 comment
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: rpalethorpe@suse.de
Cc: Zack Weinberg <zack@owlfolio.org>, Mike Frysinger <vapier@gentoo.org>,
 autoconf@gnu.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Zack,
>
> thank you for all your comments, highly appreciated!
>
>> On 2023-01-10 4:25 AM, Richard Palethorpe wrote:
>> > > >   AC_PROG_CC
>> > > > -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
>> > > > -# 2.62.
>> > > > +# autoconf >= v2.72a
>
>> > > This reads like we need the def for autoconf => v2.72a. How about
>> > You're right.  I probably thought this is defined since v2.72a,
>> > thus not needed.
>
>> Please don't use 'v2.72a' in any commentary or tests.  That version doesn't
>> exist yet and may never exist; if it does, it will be a short-lived beta
>> test release of v2.72 that we don't want people to depend on.
>> (Autoconf uses a very old version numbering convention in which beta tests
>> for release X.Y are labeled X.Ya, X.Yb, X.Yc, etc.)
>
>> Officially, AC_PROG_AR will be available as of version 2.72, and that's what
>> you should reference in commentary.
>
> I understood v2.72a similarly as kernel -rc1 gained new version.
> But sure, makes perfect sense to use final version in the comment.
>
>> > Also it looks like that redefinition is not a problem thus
>> > not wrapping with m4_ifndef([AC_PROG_AR].
>
>> Autoconf will let you do that, but it's bad practice.  What if version 2.73
>> makes AC_PROG_AR expand to something other than
>> AC_CHECK_TOOL(AR, ar, :) ? You'd be overwriting whatever bug fix that was.
>
>> I suggest something like
>
>> # AC_PROG_AR was added in autoconf 2.72.
>> m4_ifndef([AC_PROG_AR],
>>   [AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])])
>
>> > NOTE: missing 'ar' don't fail configure (isn't the check useless
>> > then?)
>
>> We don't know what you need `ar` for; it might not be appropriate to fail
>> the build if it's missing.  You can do
>
>> AC_PROG_AR
>> AS_IF([test x$AR = x:],
>>   [AC_MSG_FAILURE([no usable "ar" program detected])])
>
>> if you want to fail the build.
>
> @Richie @Li, we obviously need ar for libs/, I'd be for this.
> I also have look how other check works.

Sure, also I'll set this to "changes requested" in Patchwork.

>
> Kind regards,
> Petr
>
>> zw


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
