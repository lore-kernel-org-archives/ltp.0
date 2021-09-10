Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A1C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 07:33:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C6B61153
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 07:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37C6B61153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 957573C21B8
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 09:33:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57BBA3C210F
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 09:33:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2FED6021E5
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 09:33:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 951F92224B;
 Fri, 10 Sep 2021 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631259207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4qyQ/7BG1TnU+IxQhJuIDF+njuM0HBdCGgeE9nQGkt0=;
 b=xIZNzejKPAteZ+XD/fSvMw/qmZUw8JhyeeDpvQ2CG13LBWnInOlA5bsCXmgw36X7TcgQ0+
 hZciwoiqHOSAq19oCOyLZhNZEt74OuWiY8XIdTXqbEIzhlUV+19L0s7TpiISeOsekceRM8
 M6FN/iND0LquJ+XXLb1j0OdDnTSEIJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631259207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4qyQ/7BG1TnU+IxQhJuIDF+njuM0HBdCGgeE9nQGkt0=;
 b=/y2pjDRtNCKBOuSWS8TKe6WQ1ZcRfe4BTWrlOfr/AJXAKM8nvoVnQ+OvzdnVczzCTejEV/
 Uk6YQzdQAqb4IiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38A5F13D1D;
 Fri, 10 Sep 2021 07:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d1kWC0cKO2HQNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 07:33:27 +0000
Date: Fri, 10 Sep 2021 09:33:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YTsKRfSj7lAxKfQH@pevik>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com> <YTpswsqlDS5tI7NC@pevik>
 <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Message-ID: <20210910073325.VKy5_HAa-59KEpMrHcpDyWZat2ZvPh24rkRB2HwJMhE@z>

Hi Alex,

> On Thu, 9 Sep 2021 22:21:22 +0200
> Petr Vorel <pvorel@suse.cz> wrote:

> > > Requires "ima: add gid support".
> > I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
> > versions. Thus there should be some check to prevent old kernels failing.
> > You could certainly wrap new things with if tst_kvcmp. If there is a chance new
> > functionality can be detected, we prefer it because various features are
> > sometimes backported to enterprise distros' kernels.

> > Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
> > although for IMA tests I usually kept everything in a single file.

> I'll add a tst_kvcmp check under the assumption that this feature will
> be added before Linux 5.15.
+1. Please let me know when you manage to get this mainlined (merged into Mimi's
tree is enough), we should also add the commit hash of this feature.

> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > > @@ -8,6 +8,7 @@

> > >  TST_NEEDS_CMDS="awk cut sed"
> > You should add sudo:

> > TST_NEEDS_CMDS="awk cut sed sudo"

> Will do.
+1

> > >  TST_SETUP="setup"
> > > +TST_CLEANUP="cleanup"
> > >  TST_CNT=3
> > >  TST_NEEDS_DEVICE=1

> > > @@ -20,6 +21,13 @@ setup()
> > >  	TEST_FILE="$PWD/test.txt"
> > >  	POLICY="$IMA_DIR/policy"
> > >  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> > > +
> > > +	cat $IMA_POLICY > policy-original
> > This might not work if CONFIG_IMA_READ_POLICY is not set. There is
> > check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

> It looks like CONFIG_IMA_WRITE_POLICY only makes it possible to add new
> rules at runtime, not remove them, so the cleanup code didn't actually
> work. I'll remove it.

FYI I have on my TODO list loading policy before testing [1].

> > > +}
> > > +
> > > +cleanup()
> > > +{
> > > +	cat policy-original > $IMA_POLICY
> > Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
> > And this is very likely not to be set.

> The new tests require the policy to be writable. I'll move the
> check_policy_writable function from ima_policy.sh to ima_setup.sh and
> use it in ima_measurements.sh as well.

+1.

FYI there is IMA specific README.md [2], in case anything needs to be updated.

> Thanks for the feedback,
yw. Thanks for taking care about testing!

Kind regards,
Petr

> -Alex

[1] https://github.com/linux-test-project/ltp/issues/720
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/security/integrity/ima/README.md

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
