Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F9ACDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 07:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC03A3CEDCD
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 09:47:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 103F93C84BD
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 09:46:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 40C961BBB469
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 09:46:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EFE1A21A8C;
 Thu, 19 Oct 2023 07:46:55 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7B72A2C497;
 Thu, 19 Oct 2023 07:46:55 +0000 (UTC)
References: <20231016184408.879977-1-pvorel@suse.cz>
 <87r0lswdep.fsf@suse.de> <20231019072208.GB33886@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Oct 2023 08:34:02 +0100
Organization: Linux Private Site
In-reply-to: <20231019072208.GB33886@pevik>
Message-ID: <87il73vytu.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.77 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-0.02)[51.99%]
X-Rspamd-Queue-Id: EFE1A21A8C
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 0/7] Remove scsi testsuite + various
 testscripts
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, all,
>
> thanks for your review, merged.
>
>> Hello,
>
>> Petr Vorel <pvorel@suse.cz> writes:
>
>> > Hi,
>
>> > cleanup of 2 old scsi testsuites and some of legacy testscripts.
>> > IMHO the testsuites are not worth of fixing.
>
>> Very good. My only suggestion is to leave a tombstone in the
>> documentation (or github issues) any time we delete something big and
>> the thing it was supposed to test still should be tested.
>
> I understand the need of missing coverage, preferably over github issue
> (we document missing coverage over github issues already).
>
> I wonder what should be noted in this case. These test scripts attempted to test:
> * autofs (run other tests on autofs actually)
> * BIO (we still have testcases/kernel/device-drivers/tbio/)
> * sysfs (but we have at least some sysfs tests)
> * SCSI (I suppose these will be better handled elsewhere - xfstests have
>   scsi_debug file, mention scsi in some generic and xfs specific tests)
> * device mapper tests (there is something ruby based:
> https://github.com/jthornber/device-mapper-test-suite from Joe Thornber from Red
> Hat)
>
>> Something like "There was a testsuite called X, it appeared to do
>> Y, but we had to remove it because of Z".
>
>> It could be useful when answering questions about test feasability and
>> for SEO.
>
> I'm not sure if this 20 years old code deserves this description (but feel free
> to write it if you think so). But identifying missing coverage is of course
> important. Maybe we could have a special wiki page which would link missing
> coverage issues [1], but also highlight the most important ones (big subsystem
> missing) and also point out what we consider being tested elsewhere or what
> would be hard to test with LTP thus should be tested elsewhere.

I suppose if the test suite did not do anything interesting, then it's
not useful.

>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/labels/missing%20coverage


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
