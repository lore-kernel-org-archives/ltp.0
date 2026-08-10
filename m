Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFFDC5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 17:03:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 690DD3D066D
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 19:03:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D55F03CF68D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:03:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22CC2600673
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:03:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C22980DE2;
 Mon, 10 Aug 2026 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786381398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HP9xtQC5UDG4tH59N52j/DEDAPg6V9ei1SXdwp5vAHs=;
 b=3SXaQ49MgNNsCDfYRHBBJjzK8ieDOQG6G0VtOzRcPB9aNa32+nVLyukbECjseWJhk4rcYj
 lxk13698aofaTqH0naZuei4BPiER6Ug0WcZx7X1V/GLcOGKUkoYXenaek5YV1PkebNlnnF
 zVzNN4sy3CqXF7yzNevK/e7Pn4lD8S4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786381398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HP9xtQC5UDG4tH59N52j/DEDAPg6V9ei1SXdwp5vAHs=;
 b=pWaYCZvskP8uH7N4pO+3ekO3C4ba8l4e5GALsMg0QR/77tLecrugnY/g4z7xFbU0CqaMHT
 u2O2Oo+vYwi404AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786381394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HP9xtQC5UDG4tH59N52j/DEDAPg6V9ei1SXdwp5vAHs=;
 b=sYBzKxntTHq7/OJrg2pCHNTPTUgSjB1KVjVARrTqFVJwiFcW7kr/e5JNFiOkQbF1a4ND0S
 azi/Cn0w/T9q0Q5jiXK9YEeOmYyJj+g0q9sNSA2BTfvkKjJ2g6dCgRJpn11YmFtJvuXPn+
 pb4ism6cPSebbmbboNFpCd/RGpyVBy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786381394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HP9xtQC5UDG4tH59N52j/DEDAPg6V9ei1SXdwp5vAHs=;
 b=rio5Cbns0WB1/GdQ1PnTRqy1+5rDxeuKif8/XQ4noMb6qliLpfKkj2H8cy7qCJ1SwF+ZN8
 TDsRtAVnNMRXjABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E76F779B2;
 Mon, 10 Aug 2026 17:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HgCRAlIEemouaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 17:03:14 +0000
Date: Mon, 10 Aug 2026 19:03:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260810170312.GB1049677@pevik>
References: <20260810160048.1040517-2-pvorel@suse.cz>
 <20260810165728.3981-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810165728.3981-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kvercmp: Factor out error handling
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

Hi all,

> Hi Petr,

> On Mon, Aug 10, 2026, Petr Vorel wrote:
> > [PATCH 1/7] tst_kvercmp: Factor out error handling

> --- [PATCH 2/7] ---

> > This is a preparation for struct tst_test max_kver member in the next
> > commit.

> Could this avoid referring to the next patch so that the commit message is
> self-contained? For example, it could say that the rename makes room for a
> corresponding maximum kernel-version check.

I would not really bother with it.

> --- [PATCH 3/7] ---

> > NOTE: Mainline release is sufficient on any stable release (test with
> > .min_kver = "7.1" runs also on kernel 7.1.5). Stable releases are
> > compared as expected.

> Should this say ".max_kver" instead? This paragraph documents the new maximum
> version semantics, and the corresponding header uses max_kver.

Yes, I need to amend the commit message before merging.

> --- [PATCH 6/7] ---

> > static struct tst_test test = {
> > 	.setup = do_setup,
> > +	.max_kver = "7.1",
> > 	.test = do_test,

> Could the changed PIDFD/TID expectation be handled without skipping the whole
> test on 7.2? The second case,
> FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME, is still a valid
> success case in the 7.2 fanotify_init() implementation, and no other LTP test
> uses that exact combination. The newly supported PIDFD/TID combination is not
> exercised elsewhere either.

No, kernel maintainers are ok with it as changing the test would be a bit complicated
(and I've been mentioning this on every version).

> --- [PATCH 7/7] ---

> > + * Basic test to test that .min_kver and .max_kver can be used together.
> > + * Test should TCONF or TPASS.

> Could this test use bounds that make TPASS deterministic? runtest.sh accepts
> both TPASS and TCONF, so a regression that always rejects tests whenever both
> fields are set still leaves this self-test green. On kernels newer than 7.2,
> the callback is not exercised at all.

Well, last time I had old version and it asked for 7.2. Anyway, this was exactly
the reason why I had 5.0 last time. I can change to whatever version somebody
suggests, maybe going back to 5.0 would be good.

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
