Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77406C46CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 14:48:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67DD03CDB25
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 15:48:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97A953C94EA
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:48:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81FB11400B90
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:48:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70F071F8AF;
 Wed, 27 Dec 2023 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703688521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sj/dq5MsZlbPisC2sTzXKpwbW+uCo5OrDlLZDfO00tE=;
 b=ee7/ZHsyZrgkEk2xwej31G+vLwNcAsV79bnw5/vFQoZTpUAyS7ohDBG3PPvDJ7aAJjH5W9
 CfdAC8HvwS4eZeImTy3V4BFpnPUU8rICL30vNhJmiAdoSr/oxjRHwtWMndIowYIjS2U9hX
 32d9nVZbk7uIBdHNPrskXa6quW/Eja0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703688521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sj/dq5MsZlbPisC2sTzXKpwbW+uCo5OrDlLZDfO00tE=;
 b=OtMe6c/Q+sNlfogAGN4CsxLBZHn1B8M4U+4tFVxYqeEsVSBNDzQSQ/0xHBDH8nys5gVgri
 tgKJQYTdFVrw6eCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703688521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sj/dq5MsZlbPisC2sTzXKpwbW+uCo5OrDlLZDfO00tE=;
 b=ee7/ZHsyZrgkEk2xwej31G+vLwNcAsV79bnw5/vFQoZTpUAyS7ohDBG3PPvDJ7aAJjH5W9
 CfdAC8HvwS4eZeImTy3V4BFpnPUU8rICL30vNhJmiAdoSr/oxjRHwtWMndIowYIjS2U9hX
 32d9nVZbk7uIBdHNPrskXa6quW/Eja0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703688521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sj/dq5MsZlbPisC2sTzXKpwbW+uCo5OrDlLZDfO00tE=;
 b=OtMe6c/Q+sNlfogAGN4CsxLBZHn1B8M4U+4tFVxYqeEsVSBNDzQSQ/0xHBDH8nys5gVgri
 tgKJQYTdFVrw6eCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5118613281;
 Wed, 27 Dec 2023 14:48:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g7zzEkk5jGVPMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 Dec 2023 14:48:41 +0000
Date: Wed, 27 Dec 2023 15:48:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231227144839.GB757946@pevik>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227132144.GA740736@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ee7/ZHsy";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="OtMe6c/Q"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 70F071F8AF
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

Hi Li, Cyril,

...
> > +static inline void
> > +tst_getcwd(char *buf, size_t size, int exp_err, int exp_err2)
> And here as well: this should be on single line.
> > +{
> > +	switch (tst_variant) {
> Please, do not use switch for 2 variants, if is much readable in this case.
> > +	case 0:
> > +		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
> > +		break;
> > +	case 1:
> > +#ifdef __GLIBC__

> #1084 [1] reported problem on MUSL only. Your original patch [2] to fix #1084
> skipped only 2 of tests, which used NULL buffer. Why now skip everything? Please
> skip only these two and put comment about musl and #1084 to be obvious why you
> do that. You could also add note to the git commit message. Not documenting this
> will raise questions in the future.

> Also, looking that into bionic [3], it's compatible with glibc and uclibc{,-ng}
> (I'll verify it with Edward Liaw from Google), thus I would check like in
> run(unsigned int n):

> static void run(unsigned int n)
> {
> 	struct t_case *tc = &tcases[n];

> 	/* https://github.com/linux-test-project/ltp/issues/1084 */
> #if !defined(__GLIBC__) && !defined(__ANDROID__)
> 	if (tst_variant && !tc->buf) {
> 		tst_res(TCONF, "NULL buffer test skipped on MUSL due different implementation");
> 		return;
> 	}
> #endif

@Li @Cyril: are you ok to test libc getcwd() wrapper implementations on NULL
buffer in getcwd01.c? Or we just skip NULL buffer test on all libc?
I would be ok to test it, because change in the implementation can influence
lots of user space software, although glibc or any other libc can obviously
change it's behavior.

Kind regards,
Petr

> 	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err2);
> }

> Or we could skip NULL buffer test on all libc.

> [1] https://github.com/linux-test-project/ltp/issues/1084
> [2] https://lore.kernel.org/ltp/20230928010808.15862-1-wegao@suse.com/
> [3] https://android.googlesource.com/platform/bionic.git/+/refs/tags/android-14.0.0_r18/libc/bionic/getcwd.cpp
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
