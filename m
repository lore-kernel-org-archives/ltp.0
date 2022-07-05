Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F070C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 07:54:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39B053CA17A
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 09:53:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2239B3C649E
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 09:53:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8020A600356
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 09:53:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AF4401F9C5;
 Tue,  5 Jul 2022 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657007626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTYg/E88x4Xm7xHUpVvR4O7VO+6yfULg4qPUJkubiq8=;
 b=ckhrwbNZA/1woZt0ckXhjXssvgROl1kGElVAG+euTnNZQS89NOt2JGq6pLS3r6IlohlL+n
 ghgtI8a/5xFJ69JXPr4yDmyOZPA0HTt9Zeo/ok2/jZfJ7qgN7jIVCPfnOCT9OHwVSfm+l6
 axSvHq8Wg1Dn0HSv/ZDL1n17vwYIsgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657007626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTYg/E88x4Xm7xHUpVvR4O7VO+6yfULg4qPUJkubiq8=;
 b=7/LdQEWbgDKeXkL40mwcXMyRbNMJ60iM2pVFm6J7Fx5uqh/n+Hg7GOlrG0sksj3w7BYQFl
 b0PqbRg5gd0gnfBQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5F3E82C141;
 Tue,  5 Jul 2022 07:53:46 +0000 (UTC)
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de> <87czekrseu.fsf@suse.de>
 <874jzwrrvg.fsf@suse.de>
 <b33360f5-96ba-f7c3-9e86-f7966c260eb9@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 05 Jul 2022 08:37:11 +0100
In-reply-to: <b33360f5-96ba-f7c3-9e86-f7966c260eb9@jv-coder.de>
Message-ID: <87zghoq9km.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix: Setup autoconf and fix
 installation layout
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Richard,
>
> Am 7/5/2022 um 8:28 AM schrieb Richard Palethorpe:
>> 
>> Richard Palethorpe <rpalethorpe@suse.de> writes:
>> 
>>> Hello Joerg,
>>>
>>> Joerg Vehlow <lkml@jv-coder.de> writes:
>>>
>>>> From: Joerg Vehlow <joerg.vehlow@aox.de>
>>>>
>>>> This allows installation of the tests to a different directory
>>>> than directly under $prefix.
>>>>
>>>> Before the layout was:
>>>> $prefix/bin/{run-*,t0,run-tests.h,Makefile}
>>>> $prefix/conformance
>>>> $prefix/functional
>>>> $prefix/stress
>>>>
>>>> with prefix being /opt/openposix_testsuite on linux and
>>>> /usr/local/openposix_testsuite on other systems
>>>> OR the value of the env-var $prefix.
>>>>
>>>> With this change, the prefix defaults to /opt/openposix_testsuite
>>>> and can be changed the usual way using configure (./configure ---prefix=foo)
>>>> Additionally the path of the tests below $prefix can be changed, using
>>>> configure --with-open-posix-testdir=<foo>. This allows clean installation as
>>>> part of ltp:
>>>>
>>>> $prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
>>>> $prefix/$testdir/bin/{run-tests.sh,t0}
>>>> $prefix/$testdir/conformance
>>>> $prefix/$testdir/functional
>>>> $prefix/$testdir/stress
>> 
>> Sorry I don't see the need for this. I can't find the RFC where you may
>> have explained it, however it should be written here anyway I think.
>
> here is the RFC in the mailing list archive:
> https://lists.linux.it/pipermail/ltp/2022-June/029188.html
>
> Joerg

OK, so things are being installed twice and it is generally a
mess. This looks like a good cleanup.

However this really needs to be explained in the patchset. There
needs to be a clear description of where things have moved from and
to. In particular what someone needs to do if this breaks their test
runner scripts. This can then be copied into the LTP release notes.

BTW IIRC we generate runtest files for the open posix tests and the test
runner handles them almost like normal LTP tests. We don't use any of
those scripts either.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
