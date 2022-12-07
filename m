Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098E2C352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 16:14:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 017573CC144
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 17:14:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2BCC3CC0C1
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 17:14:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6354A600737
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 17:14:20 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A621D21F53;
 Wed,  7 Dec 2022 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670429659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crgmPkKG1lS7fn9MWfgGHALFaSd3hqtOFceh5Q0BUPQ=;
 b=itJzluyNsrxU7b807YKJAx3957V1VKSLtKGiqPY59AJarrnIuxK/lHdvtW1TsYhhPECEbe
 DeWRpdm0z7AtEkjgNO1FszaxzstoK1m2n+MG8zn4bOdXVDNXS7Jq3Xl2thR+a124VHLSaA
 bPslZHFq08Myn3fHLyDTppGC94rLhsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670429659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crgmPkKG1lS7fn9MWfgGHALFaSd3hqtOFceh5Q0BUPQ=;
 b=kYL9YIRhLUAv+N7gf2lmmSuJRA9cqrLooXYoOitwJ29xVnGML75zNVseTfxnMeLBFYe4Cn
 1B38EJp10TvuM/Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 78C1F136B4;
 Wed,  7 Dec 2022 16:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id og/1Gdu7kGM5TAAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Wed, 07 Dec 2022 16:14:19 +0000
Date: Wed, 7 Dec 2022 17:15:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Xinkuan Yan <lucky33newman@gmail.com>
Message-ID: <Y5C8KLaOi2U00Xwu@yuki>
References: <CAFQkDybMFX16dSaW+eZ0rC7TAwD5O7RnCkSuTS-ka9zZwKjC6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFQkDybMFX16dSaW+eZ0rC7TAwD5O7RnCkSuTS-ka9zZwKjC6Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] About those realtime tests.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Green hand here to ask a question about thost realtime tests, I mean, tests
> under this folder:
> 
> /opt/ltp/testcases/realtime/func
> 
> I surely knew that those tests could be started with 'run_auto.sh', and
> most of them provide reports with PASS or FAIL.
> 
> The question for me is that is it possible to use the script file 'runltp'
> to start those tests?
> 
> I have read the doc ltp-run-files.txt but I did not quite get to it.
> 
> Any guidance is appreciated!

I do not think that writing realtime tests runtest file is an easy task.

First of all there is a profile/default that has harcoded constants that
worked once for someone running the testsuite, but that is supposed to
be tweaked. There are no good values for these constants, these have to
be tailored to a machine and usecase. Moreover some of these tests does
not even interpret the results and just return measurements, these can't
be integrated into a runtest file at all.

Secondly runtest files are suppose to have one test per entry, so you
would have to pick up how binaries are executed in run_auto.sh files in
the func/*/ directories and use the default values from the default
profile in the cases. And that only works for the subset of tests that
does report pass/fail status in the exit value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
