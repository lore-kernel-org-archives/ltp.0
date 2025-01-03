Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA094E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 19:03:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C583C0FB4
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 20:03:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77D8B3C0E25
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 20:03:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B2691BD1704
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 20:03:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2A2B1F37C;
 Fri,  3 Jan 2025 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735930986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBWhC7PnxnpzZvviRFqmt3UWdCVHBk+R++5W+UFc/+4=;
 b=S+AhPMXEKh5jgZxhB080zRWIb+658YL3XFa3pi5mRVyneSUC2KGWmG8u0n3ysliCamQvzP
 F+QpaJFmgymaszC3j6sJRVLsq83/P/6Y5b8Tcapwds8sH3FPwsTC11nWuYFGsspJ/OTNZ/
 EtAo3cy4L71eOgXsXstDxY/FYhP4nkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735930986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBWhC7PnxnpzZvviRFqmt3UWdCVHBk+R++5W+UFc/+4=;
 b=VU0dswyMVzleZgTqUqDxwqnsBaOcq76olGe8wxEw5i0PcZDYgLznqpeT/+Hf5AlTuxxWUI
 KYHtW/o8kJnpwyDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gCQlH3xh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XT1VmpIz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735930985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBWhC7PnxnpzZvviRFqmt3UWdCVHBk+R++5W+UFc/+4=;
 b=gCQlH3xhXk70d/xeNf242uO/TfIAca9cSZbLAPdCSNcW1z/V0OhqQHtD508IXE2+dH0NPH
 hcYctbLz4FEyGhx5cG/YUyZsNOGghfTk6yzzAHaIN8moMcWflas9mJmTcMwaI3AUwUL3t3
 XHYDjFaqLyH8Jh3OTl+aEkUiRlLZxxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735930985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBWhC7PnxnpzZvviRFqmt3UWdCVHBk+R++5W+UFc/+4=;
 b=XT1VmpIzMHkQNvRGTzn5Sx5Sr9vJF0E3rQp3lsp/AAYSyonruyAYrTDXHScz+NBbd1k3Ph
 QeimEjZ6arKcQiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B23313418;
 Fri,  3 Jan 2025 19:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e9WHHGk0eGeFIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 19:03:05 +0000
Date: Fri, 3 Jan 2025 20:02:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250103190259.GA223253@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-7-pvorel@suse.cz>
 <35af7de88f6961817a9df23c55104d20c32d2680.camel@linux.ibm.com>
 <20241231122340.GE36475@pevik>
 <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0746bfae90306d45079f6f3e2f7a1d55e0ad79f.camel@linux.ibm.com>
X-Rspamd-Queue-Id: E2A2B1F37C
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] IMA: Add example policy for
 ima_violations.sh
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, 2024-12-31 at 13:23 +0100, Petr Vorel wrote:
> > Hi Mimi,

> > > Hi Petr,

> > > On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > >  .../integrity/ima/datafiles/ima_violations/violations.policy     | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy

> > > > diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > > > new file mode 100644
> > > > index 0000000000..5734c7617f
> > > > --- /dev/null
> > > > +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_violations/violations.policy
> > > > @@ -0,0 +1 @@
> > > > +func=FILE_CHECK

> > > "[PATCH v2 1/8] IMA: Add TCB policy as an example for ima_measurements.sh"
> > > contains two rules to measure files opened by root on file open.

> > > measure func=FILE_CHECK mask=^MAY_READ euid=0
> > > measure func=FILE_CHECK mask=^MAY_READ uid=0

> > > If the 'tcb' or equivalent policy is loaded, there is no need to load another
> > > policy rule. 

> > I guess I'll move check for builtin policy loaded via kernel command line
> > parameter also to ima_setup.sh to avoid loading example policy when there is a
> > required builtin policy loaded.


> Between the builtin and arch specific policies, most of the rules are already
> defined.  The exception is measuring the boot command line.  Perhaps we should
> update the arch specific policy to include it with the other kexec rules.

> The arch specific policy may include the rule that requires the IMA policy to be
> signed.

> > I also wonder what is a common approach - don't
> > try to load custom example policy when there is builtin policy loaded?

> How about first checking if the rule exists when there is a builtin or
> equivalent custom policy loaded, before loading the example test policy?


> > My goal was to allow more broad IMA testing based on different setup:

> Very good.

> > * running tests with ima_policy=tcb builtin policy (current approach). Many
> > tests will be skipped due missing required policy content.

> Ok.  Remember even with "ima_policy=tcb" specified on the boot command line, the
> results will differ depending on whether the arch specific policy is loaded.

> > * running tests without any builtin policy + load a custom policy + reboot via
> > LTP_IMA_LOAD_POLICY=1 (this patchset), but this should be probably be done only
> > if required (or even none) builtin policy is loaded.

> Good.  The first patch introduces the equivalent custom policy to
> "ima_policy=tcb".  By "load a custom policy" are you referring to this policy or
> a specific policy test rule?

I refer to this policy. Maybe better would be "policy content required by the test"
or "test example policy".

My point is to allow testing without forcing ima_policy=tcb setup (some tooling
might not allow easily to add kernel cmdline parameters). Also, mixing test
example policy with ima_policy=tcb may result a different measurements, right?

If the above assumption is correct I would like to have testing *with*
ima_policy=tcb without loading any test example policy and *without*
ima_policy=tcb but loading test example policy via LTP_IMA_LOAD_POLICY=1.

> > * Ideally not require CONFIG_IMA_READ_POLICY=y as some distros does not have it
> > (but then it is hard to detect whether failures are real bugs or just false
> > positives due not having a proper policy). Maybe convert TBROK/TFAIL to TCONF if

I'm sorry, I was wrong here, I meant to ask: convert TFAIL to either TBROK or TCONF,
e.g. my patch [1].

> > policy content is required but cannot be read due CONFIG_IMA_READ_POLICY (and
> > custom policy with proper content was not loaded).

> Probably the latter option of converting from TBROK/TFAIL to TCONF is
> preferable.  Why fail a test without knowing it will fail.

Because on distros without CONFIG_IMA_READ_POLICY=y we never get notified about
the failure (maybe kernel is broken when it fails but nobody notices TCONF).
But although there is a slight difference between TFAIL and TBROK [2], I agree
that TCONF is probably the best (nobody wants to deal with false positives),
which is handled in my patch [1].

But instead of this I'll try for all tests which require to have certain policy
content (currently all but ima_conditionals.sh): if LTP_IMA_LOAD_POLICY=1 set
try to load example policy even policy content cannot be checked (TCONF when
policy fails to be loaded or if LTP_IMA_LOAD_POLICY not set).

Kind regards,
Petr

> > But you may have an idea what is more useful (brings more test coverage).

> There are two main problems:
> - Not being able to read the policy.
> - Only being able to load a signed policy.

> I think between your above ordering and a new test to see if the policy needs to
> be signed, it's the best we can do for now.

> As mentioned in my 2/8 response, a new package containing pre-defined custom
> policies that are signed by the distro would resolve the latter problem.


> Thanks,

> Mimi

[1] https://patchwork.ozlabs.org/project/ltp/patch/20241213222014.1580991-9-pvorel@suse.cz/
[2] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-res-flags-constants

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
