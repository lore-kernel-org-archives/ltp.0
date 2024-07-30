Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B2EC3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 08:49:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 436273D1D88
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 10:49:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D48633D112F
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:49:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0487204733
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:49:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD2931F7EC;
 Tue, 30 Jul 2024 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwYnaVlsdSsb5qSop2VKmtOEM9x4H39gOVVRwZ9EUjw=;
 b=jxu5g3p/OHGIL31C7S2LPHV1FMtBaHCT9OAW1+htFBiwrn5QRlT/PrCRRmIpzurW3GyZ/Y
 q5hyCXuOOJsS3MzWvG5XRSnnhrbLVE54POqQW7nBiWvLH8bj4wSJD96SItWz78/gxAMjhm
 r49iJ2oP5+/zJLICErtnZD59oNmW4gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwYnaVlsdSsb5qSop2VKmtOEM9x4H39gOVVRwZ9EUjw=;
 b=yFWnLmEHZkq0HAk///e1BfD3rtE9lNkEMRrcUyTL/UJXjAwZ0WnSiRGfUhR3Sg98EaOedg
 oi0a5YGkc5YztVDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwYnaVlsdSsb5qSop2VKmtOEM9x4H39gOVVRwZ9EUjw=;
 b=jxu5g3p/OHGIL31C7S2LPHV1FMtBaHCT9OAW1+htFBiwrn5QRlT/PrCRRmIpzurW3GyZ/Y
 q5hyCXuOOJsS3MzWvG5XRSnnhrbLVE54POqQW7nBiWvLH8bj4wSJD96SItWz78/gxAMjhm
 r49iJ2oP5+/zJLICErtnZD59oNmW4gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329364;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwYnaVlsdSsb5qSop2VKmtOEM9x4H39gOVVRwZ9EUjw=;
 b=yFWnLmEHZkq0HAk///e1BfD3rtE9lNkEMRrcUyTL/UJXjAwZ0WnSiRGfUhR3Sg98EaOedg
 oi0a5YGkc5YztVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DD4C13983;
 Tue, 30 Jul 2024 08:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MsLsIRSpqGZbCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 08:49:24 +0000
Date: Tue, 30 Jul 2024 10:49:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240730084924.GC1327610@pevik>
References: <20240722145443.19104-1-chrubis@suse.cz>
 <20240729205112.GA1287954@pevik> <ZqiRaf0bPloFV3LI@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqiRaf0bPloFV3LI@yuki>
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi!
> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_starv8seE as tmpdir (tmpfs filesystem)
> > tst_test.c:1806: TINFO: LTP version: 20240524
> > tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> > starvation.c:71: TINFO: Setting affinity to CPU 0
> > tst_test.c:1658: TINFO: Updating max runtime to 0h 04m 00s
> > tst_test.c:1650: TINFO: Timeout per run is 0h 04m 30s
> > starvation.c:117: TPASS: wait_for_pid(child_pid) passed

> > => test runs ~ 13s - 19s on aarch64, ppc64le and x86_64. Therefore not sure if
> > 04m max runtime is good.

OK, now testing with your patchset :)
https://github.com/pevik/ltp/commit/0392e5142c5e8cb1d38dec9916a9f0118cf27afe

All tests are on KVM.

* aarch64 6.10.1-1-default (8s)
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
starvation.c:52: TINFO: CPU did 120000000 loops in 42654us
tst_test.c:1658: TINFO: Updating max runtime to 0h 00m 42s
tst_test.c:1650: TINFO: Timeout per run is 0h 01m 12s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* ppc64le 6.10.1-1-default (9s)
...
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
starvation.c:52: TINFO: CPU did 120000000 loops in 98081us
tst_test.c:1658: TINFO: Updating max runtime to 0h 01m 38s
=> FYI HERE IS DIFFERENCE over 1 min
tst_test.c:1650: TINFO: Timeout per run is 0h 02m 08s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* x86_64 6.10.1-1-default (10s)
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
starvation.c:52: TINFO: CPU did 120000000 loops in 41908us
tst_test.c:1658: TINFO: Updating max runtime to 0h 00m 41s
tst_test.c:1650: TINFO: Timeout per run is 0h 01m 11s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

Some SLES
* s390x 6.4 (6s)
starvation.c:52: TINFO: CPU did 120000000 loops in 53599us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 53s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 23s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* s390x 6.4 (6s)
starvation.c:52: TINFO: CPU did 120000000 loops in 53599us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 53s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 23s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* x86_64 5.14.21 (5s)
starvation.c:52: TINFO: CPU did 120000000 loops in 75176us
tst_test.c:1659: TINFO: Updating max runtime to 0h 01m 15s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 45s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* aarch64 5.14.21 (9s)
starvation.c:52: TINFO: CPU did 120000000 loops in 42404us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 42s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 12s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* ppc64le 5.14.21 (16s)
starvation.c:52: TINFO: CPU did 120000000 loops in 147223us
tst_test.c:1659: TINFO: Updating max runtime to 0h 02m 27s
tst_test.c:1652: TINFO: Timeout per run is 0h 02m 57s
=> FYI HERE IS DIFFERENCE 2 min
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* aarch64 5.3.18 (8s)
starvation.c:52: TINFO: CPU did 120000000 loops in 42382us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 42s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 12s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* ppc64le 5.3.18 (50s)
starvation.c:52: TINFO: CPU did 120000000 loops in 140564us
tst_test.c:1659: TINFO: Updating max runtime to 0h 02m 20s
tst_test.c:1652: TINFO: Timeout per run is 0h 02m 50s
=> FYI HERE IS DIFFERENCE 2 min
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* aarch64 4.12.14 (12s)
starvation.c:52: TINFO: CPU did 120000000 loops in 55491us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 55s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 25s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* ppc64le 4.12.14 (1m 9s FYI HIGHEST RUNTIME)
starvation.c:52: TINFO: CPU did 120000000 loops in 147102us
tst_test.c:1659: TINFO: Updating max runtime to 0h 02m 27s
tst_test.c:1652: TINFO: Timeout per run is 0h 02m 57s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* s390x 4.12.14 (5s)
starvation.c:52: TINFO: CPU did 120000000 loops in 49973us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 49s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 19s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

* x86_64 4.4.180 (10s)
starvation.c:52: TINFO: CPU did 120000000 loops in 37042us
tst_test.c:1659: TINFO: Updating max runtime to 0h 00m 37s
tst_test.c:1652: TINFO: Timeout per run is 0h 01m 07s
starvation.c:150: TPASS: Haven't reproduced scheduller starvation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
