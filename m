Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB30AC46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 09:48:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883983CB588
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:48:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 412053C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:48:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B3851400142
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 10:48:18 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6B40E4E500;
 Tue, 10 Jan 2023 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673344097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCiYuPKM+AK/CPyI4w07CdwX0Xk4JnNxLNu0dEd7V+0=;
 b=gjeuSRNaCjazKQDncA/4MIB8JP3PLS5Yvk6jCWrzg747grjuI72IHy9zfoseLPV/A6/sAP
 KLSMJ2+8QBqMX/RTW0Yi3GqLN35xxrLgDpo6fFlzO/61Omsl5la2FX9aaIwcdpIKbwo9K0
 WRNdBDVHwnxiS3VDMr0aWG5ab6sQSg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673344097;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCiYuPKM+AK/CPyI4w07CdwX0Xk4JnNxLNu0dEd7V+0=;
 b=YeIg6Dw3HIY9g9xbmgLIaEz59lfEVjPsqJhB7DgOQfpGDoApEsQxLVq8yb4cQAksPvP0Ku
 i5L/wvptKvMdtKDQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1C4A72C141;
 Tue, 10 Jan 2023 09:48:17 +0000 (UTC)
References: <20230103124505.6611-1-pvorel@suse.cz>
 <CAEemH2c69cKYLFzivuCRNnpxB8sco-9LRhL8_EYw0i+Srp71CA@mail.gmail.com>
 <Y7VCssq333Y5QgPt@pevik>
 <CAEemH2e3Ob-faePkzSyjhRqHYx_96VwB0_by+tV2S=vPPFz9kw@mail.gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 10 Jan 2023 09:48:08 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2e3Ob-faePkzSyjhRqHYx_96VwB0_by+tV2S=vPPFz9kw@mail.gmail.com>
Message-ID: <87h6wyiuu7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] configure.ac: Require 2.64
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
Cc: Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

Li Wang <liwang@redhat.com> writes:

> Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li,
>>
>> > Hi Petr,
>>
>> > I see other places also used 2.61, do you think we need to correct them
>> as
>> > well?
>> > (e.g. open-posix and realtime)
>>
>> > $ git grep AC_PREREQ
>> > configure.ac:AC_PREREQ(2.61)
>> > testcases/open_posix_testsuite/configure.ac:AC_PREREQ(2.61)
>> > testcases/realtime/configure.ac:AC_PREREQ(2.61)
>>
>> Sure, I could do that, but these independent projects actually work with
>> older
>> version, that's why I didn't do that.
>>
>
> Ok, as long as we build it internally of LTP, that is required because
> we have to check the configuration at top-level and then go into the
> subproject. It will use the upper version first.
>
>
>>
>> FYI realtime will go away, once I find time to port relevant tests to
>> rt_tests
>> and openposix could one day become in separate git.
>>
>
> If so, that older version will be tolerated. Thanks!
>
> For both:
> Reviewed-by: Li Wang <liwang@redhat.com>
>
> -- 
> Regards,
> Li Wang


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
