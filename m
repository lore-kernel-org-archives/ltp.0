Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D06C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E630E3C58A4
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:11:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6193C053B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:10:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 843AA600057
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:10:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE7C4219EF;
 Tue, 27 May 2025 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748344250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMMl/wtKIvtM2YUDtD+C8MkWuIfNBFaf5cvqO4wyt78=;
 b=GwqRAhWtFEJDekIWLG8n67qMyHr0gmJJCdgT7205zGLHq04u36EwfUC1pMYZFqwHB+Tx0O
 FjxRIIlHZp0mmM7h1YXQRsuROLM63IMZYqx50PXzvw1IdE7f5XsDHjJbGEjNC27O3ys0j9
 0bNRzjKiOzoECLnTKQRalEiUOiytGKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748344250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMMl/wtKIvtM2YUDtD+C8MkWuIfNBFaf5cvqO4wyt78=;
 b=BXb/kkEPHgebZB0zPOwc4iwlYPxFzWYVtBkvxyvSa62VNOoPfHd5+hR4lnoOrggj+5nODQ
 CrHorI0Eqer8l3AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748344250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMMl/wtKIvtM2YUDtD+C8MkWuIfNBFaf5cvqO4wyt78=;
 b=GwqRAhWtFEJDekIWLG8n67qMyHr0gmJJCdgT7205zGLHq04u36EwfUC1pMYZFqwHB+Tx0O
 FjxRIIlHZp0mmM7h1YXQRsuROLM63IMZYqx50PXzvw1IdE7f5XsDHjJbGEjNC27O3ys0j9
 0bNRzjKiOzoECLnTKQRalEiUOiytGKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748344250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MMMl/wtKIvtM2YUDtD+C8MkWuIfNBFaf5cvqO4wyt78=;
 b=BXb/kkEPHgebZB0zPOwc4iwlYPxFzWYVtBkvxyvSa62VNOoPfHd5+hR4lnoOrggj+5nODQ
 CrHorI0Eqer8l3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 959601388B;
 Tue, 27 May 2025 11:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l9huI7qdNWhgewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 May 2025 11:10:50 +0000
Date: Tue, 27 May 2025 13:10:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250527111041.GB181666@pevik>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; REPLY(-4.00)[];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hello All,

> After reviewing some LTP HTML test reports, I noticed that the ten tests
> alone take nearly 20 minutes to complete. For example:

> --------------------
> bind06           300.15s

This uses fuzzy sync, I wonder if it could be speedup. I guess better longer run
than break the test.

> msgstress01      180.44s
> fsx22            170.47s
> pty07            150.04s
> pty06            150.02s
> gf18             121.09s
> gf17             120.82s
> gf16             120.13s
> dirtyc0w_shmem   120.11s
> setsockopt07      76.47s

> In total, running the full ltp-lite suite currently takes ~1h20m, which is a bit
> long for CI or pre-merge validation pipelines.

What is ltp-lite? Is it your internal CI for LTP? bind06 is in cve and syscalls
runtest files.

> I'm wondering whether all these .runtime values are truly necessary to reproduce
> the intended issues (e.g., race conditions, fuzzing, sync timing issues).
> Or if we could:
>  - Set a lower threshold for .runtime on general-purpose stress/fuzz tests

I'd be careful for fuzzy sync.

>  - Introduce a runtime _policy_ for different environments (e.g., fast
> CI vs. full weekly runs)

Or filter out the long running tests if the purpose is just to test LTP itself
instead of the product?

> It might be beneficial to revisit the .runtime values of long-running tests and
> set a minimal yet effective duration that balances reproducibility with resource
> efficiency. This could help save time and free up test resources earlier.

Maybe Martin still have VM's which can trigger the problem to experiment, but
runtime probably differs across architectures and available resources (number of
CPU or memory).

Kind regards,
Petr

> Any thoughts/comments would be appreciated.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
