Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9372CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 305623CB4C1
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:26:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEDE93C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:25:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B84116168D8
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:25:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B31C21B28;
 Tue, 12 Aug 2025 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754997952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUWu+gKcdx64GfH4sVMArMdVtlqMNHDJztGn2aDxVMw=;
 b=r4TXADMz3KXM3UcImWAxerUfVsR0n4zO02q/JidZm4LyqTCaFaLpWPE+6+Nk0TDcuk8olS
 rM1Bmz/12VvpOh6dWOF1B9xcB6wcQa8s10jbSAE9db/qCVsZmRc7mXeYI3G2s+MSBnFyv3
 Sxet7sAop4zjr6sqxGHmRRIDWuRG/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754997952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUWu+gKcdx64GfH4sVMArMdVtlqMNHDJztGn2aDxVMw=;
 b=uMvG7z4StW9QMOjBchNX/tOsVxM0o4Oo+HqYcy6lwPdsHLyB7hlLylmJvwoOM1W04fPGQb
 AeR5zbK+QRbQBOBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754997952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUWu+gKcdx64GfH4sVMArMdVtlqMNHDJztGn2aDxVMw=;
 b=r4TXADMz3KXM3UcImWAxerUfVsR0n4zO02q/JidZm4LyqTCaFaLpWPE+6+Nk0TDcuk8olS
 rM1Bmz/12VvpOh6dWOF1B9xcB6wcQa8s10jbSAE9db/qCVsZmRc7mXeYI3G2s+MSBnFyv3
 Sxet7sAop4zjr6sqxGHmRRIDWuRG/NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754997952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUWu+gKcdx64GfH4sVMArMdVtlqMNHDJztGn2aDxVMw=;
 b=uMvG7z4StW9QMOjBchNX/tOsVxM0o4Oo+HqYcy6lwPdsHLyB7hlLylmJvwoOM1W04fPGQb
 AeR5zbK+QRbQBOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2DC2136C7;
 Tue, 12 Aug 2025 11:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +nO+Nb8km2j5GQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 11:25:51 +0000
Date: Tue, 12 Aug 2025 13:25:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250812112546.GA843668@pevik>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812105127.GB835467@pevik>
 <8a13181b-5fbc-4a10-9904-24fd26cb1ebe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a13181b-5fbc-4a10-9904-24fd26cb1ebe@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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

Hi Andrea,

...
> > > +		const char *msg = "We are able to read out-of-band data from normal stream";
> > > +
> > > +		if (dummy == 'A') {
> > > +			tst_res(TFAIL, "%s", msg);
> > > +		} else {
> > > +			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
> > > +				msg, dummy);
> > > +		}
> > > +
> > > +		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> > FYI: on vulnerable kernel with SELinux I get (nothing to be fixed):
> > cve-2025-38236.c:48: TINFO: Receive data from normal stream
> > cve-2025-38236.c:60: TFAIL: We are able to read out-of-band data from normal stream
> > cve-2025-38236.c:66: TBROK: recv(3, 0x4391d8, 1, 1) failed: EFAULT (14)
> Maybe we can verify at the beginning is SELinux is enabled. I don't know...

I would not do that. I'm not sure if SELinux mitigates the problem (IMHO not)
and on fixed kernel (also with SELinux) recv() works:

cve-2025-38236.c:53: TPASS: Can't read out-of-band data from normal stream

It's just a note that it's different. Fortunately there is also TFAIL,
thus it's obvious kernel is vulnerable.

And again, there is the trap with LSM modules: what about the others? At least
AppArmor (still widely used, although less than SELinux).

Tested-by: Petr Vorel <pvorel@suse.cz>

> > > +
> > > +		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
> > > +	}
> > > +}
> > > +
> > > +static void setup(void)
> > > +{
> > > +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
> > > +	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
> > > +		 &sock_timeout, sizeof(struct timeval));
> > > +}
> > Why is struct timeval needed? I haven't found that in
> > https://project-zero.issues.chromium.org/issues/423023990
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32ca245464e1

> > and test works as a verifier without it. If really not needed please remove it
> > before merge.
> We need to set a timeout for recv(), otherwise it will stuck on systems
> which are not bugged.

Indeed.

...
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.needs_kconfigs = (const char *[]) {
> > > +		"CONFIG_AF_UNIX_OOB=y",
> > Although this is true I wonder if we should limit the reproducer to this.
> > If one day config silently renames / is removed (but OOB kept) the reproducer
> > will be lost.
> That's valid in general, I can remove it but I don't know if it makes much
> sense, considering that feature something which is nowadays disabled in many
> systems due to this bug.

Fair enough. More important is that MSG_OOB most certainly require
CONFIG_AF_UNIX_OOB, so it's probably correct to have it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
