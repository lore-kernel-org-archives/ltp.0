Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A80C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 08:09:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 442ED3CBC2B
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 09:09:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAD8B3CAFC9
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 09:09:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE825200207
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 09:08:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C197333CA6;
 Fri, 16 Dec 2022 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671178138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1doEWPEo134cD58m+NrlBWYQ02M/exN0L5CiMJ3r5Yw=;
 b=oWY82D8Bplk5/0xW/5F0x6hhtmwe4endVRHbGXXyxPzZdmWwdaBlb2KZVZEiWAZyDwKSfV
 ldJ3tq4YJm4Td7QxoE+qN/mMhPYZDFv2xBCRhQTe+r3EjH1knD9+XuNYlWD0QAMBm8W3zW
 mbe6UMSZVwg9/CiqWQ2xhDCqwMecGSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671178138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1doEWPEo134cD58m+NrlBWYQ02M/exN0L5CiMJ3r5Yw=;
 b=+4QN0jo9/1Glz6f3UHVl6y0YcWPmKdI/nAnhY7vjYsYdbk4W+Rwu1MLiPuLwZyjb5lEucL
 EwEiPCMmg0yKJYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A074D138FD;
 Fri, 16 Dec 2022 08:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tfKzJZonnGOlIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 08:08:58 +0000
Date: Fri, 16 Dec 2022 09:08:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Y5wnmJ3WgOix+ICa@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
 <Y5tp0K5QIZ74bnw7@pevik>
 <d7f4edfe75498d5d80bc55f2bb118fea34d9ad08.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7f4edfe75498d5d80bc55f2bb118fea34d9ad08.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, 2022-12-15 at 19:39 +0100, Petr Vorel wrote:
> > Hi Mimi,

> > I'm sorry, it took me long time to look into the issue.

> > > Only the ima_conditionals.sh and ima_policy.sh tests define policy
> > > rules based on fsuuid.  The other tests are still based on the builtin
> > > "ima_policy=tcb" rules.
> > Yes.

> < trimmed >

> > 4) running ima_violations.sh after ima_policy.sh no longer works, because
> > there is nothing new in /var/log/audit/audit.log. I don't know why, but
> > ima_violations.sh requires either the default ima_policy=tcb policy or policy
> > created by ima_policy.sh *without* fsuuid.

> Violations occur when a file in policy is already opened for read and
> is being opened for write, or the reverse.  After the builtin policy is
> replaced with the custom policy based on the UUID, running the
> violation test fails because the UUID is reset by the call to
> ima_setup().  So the file being opened doesn't match any policy rule.
Yes, I was just surprised that test ima_violations.sh really depends on
ima_policy=tcb or policy created by ima_policy.sh test.

This also means if somebody wants to test just ima_violations.sh,
he would need to have ima_policy=tcb. Dependency between IMA tests
is something LTP does not expect nor want.

Unfortunately due failures described above it'd be not good to accept this
patch.  But it's a very nice proof of concept how to use fsuuid, thank you.

> > FYI below is content of /var/log/audit/audit.log.

> > Also looking at things twice, fsuuid does not help testing much.
> > Because main blocker for testing is not the scope of the policy, but write once
> > policy - CONFIG_IMA_WRITE_POLICY not being set on distro kernels thus repeated
> > write of the policy will need reboot.

> Oh, I didn't realize this.  Fedora (and RHEL) enable
> CONFIG_IMA_WRITE_POLICY.
Yes, but this config is 'n' by default. I wonder: shouldn't it be 'y' by
default, so that people who does not care get it enabled? Or is it a security
concern to get it enabled during just on boot by systemd?

Even if it were 'y' by default, there still might be some distros/people who
disable it... This is the source of all complications.

> > Rebooting actually might be possible sooner or later with new runltp-ng from
> > Andrea [1] (the feature is not here yet, but will be sooner or later). runltp-ng
> > is close to upstream, there was first attempt [2].

> Let's try to avoid this solution as much as possible.
Sure, reboot is complication.

But you need to accept exact order of the tests. Or have detection,
but the detection does not work on disabled CONFIG_IMA_READ_POLICY
(which is the default when CONFIG_IMA_WRITE_POLICY is not set - again people can
have it unset). Actually ima_kexec.sh has broken detection - this gives TWARN
and TBROK (= failure) on disabled CONFIG_IMA_READ_POLICY:

		if [ "$policy_readable" != 1 ]; then
			tst_res TWARN "policy not readable, it might not contain required policy '$REQUIRED_POLICY'"
			res=TBROK
		fi
		tst_brk $res "unable to find a correct measurement"

Exact order is first test anything with ima_policy=tcb, then have custom policy.
Also, one should run tests with no IMA setup, then with ima_policy=tcb. Then
there are other unsupported/untested policies: ima_policy=secure_boot and
ima_policy=appraise_tcb, supporting them would obviously require reboot.

> > Other option would be to prepare policy which would be suitable for all tests,
> > with help of fsuuid.

> Ok, I'll look into this.
Thank you, very much appreciated!

> > But that has drawback:
> > Currently we use LTP API to mount directories on loop device after test has started.
> > These devices are temporary, e.g.
> > /tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt will be unmounted and
> > deleted after each test run. But for fsuuid we'd need to first permanently
> > mount the devices to get their UUID. Therefore there would have to be some
> > special setup script needed to be run for all tests. This has proven to be
> > problematic in the past. I'd have to extend the API to create something permanent.

> Instead of ima_setup() setting the UUID to a new different value, if
> additional rules cannot be written (require_policy_writable) the UUID
> could be set to the existing policy rules UUID.
Not sure if I understand you. FYI no mounted directory exists before test run,
nothing survives after test finishes.
Test is supposed to write *only* to it's temporary directory $TST_TMPDIR, which
is created by TST_NEEDS_TMPDIR=1 after test has started, this is the directory
which gets deleted.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
