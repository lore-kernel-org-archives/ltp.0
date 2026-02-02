Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2898E7314E
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 10:14:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A7503CCEA0
	for <ltp@archiver.kernel.org>; Mon,  2 Feb 2026 11:14:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8AF43CC8D2
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 11:14:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 22359100067D
 for <ltp@lists.linux.it>; Mon,  2 Feb 2026 11:14:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D66693E702;
 Mon,  2 Feb 2026 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770027276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7MHBNoc6GmaCd06A9lwXaw6T21D9vFiQ9pnx/RJOXE=;
 b=WjaCoUZJ6z6AOy6UlJrHHWz8w3vRcOnejftm9j0UQ5BEUaM9cDbPgT+uZ/wdYl532w6aGX
 al3Y5Z6juiv7xrrnLWimYi91j+xGcVzKB/g6iHUf3hN3Lp0V9Yro4uvJZyM2uyoqIQbNgC
 LRDOj7DP4yU+TwQql3Hpw9wY+ex0K44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770027276;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7MHBNoc6GmaCd06A9lwXaw6T21D9vFiQ9pnx/RJOXE=;
 b=nWPLoBAKDvh+aqBPdINUu6jiSWG2kwRmZxoX+XZ+bTyR/kSvfvN9ZlqCkkZOmz0QIXFmgB
 yAYWTEHiRsjI4RBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770027275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7MHBNoc6GmaCd06A9lwXaw6T21D9vFiQ9pnx/RJOXE=;
 b=uNvLwgZkEWu3lYDDnUkUeeLTdfleo7F1+lA26GwkwShuQyUtNasa+tdXvdF7V5YMRDUVX6
 5fdmDfh4L/jYmLAttrTDE4o5iOyEZein7sI3YXwvez3Hj0ghNpSexFfJy5ADP3QARZT3rh
 1eoXAtCzB3r1qldZ3MiLeCeP1Kc4Ui4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770027275;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7MHBNoc6GmaCd06A9lwXaw6T21D9vFiQ9pnx/RJOXE=;
 b=/hfFoXUgdkldOPfpX2yaqMRtBZWJR/1jadQrQ49kiE/7LsLg3l/2v/q0QDaln1d4Fm32hc
 inHrsdVHjm4c9oDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A946A3EA62;
 Mon,  2 Feb 2026 10:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UyCaKAt5gGmcFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Feb 2026 10:14:35 +0000
Date: Mon, 2 Feb 2026 11:14:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260202101430.GA24157@pevik>
References: <20260202091801.68673-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260202091801.68673-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc/developers: document tst_/tse_/tso_ library
 namespaces
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

Hi Li,

> This helps contributors choose the correct layer when adding new library
> code and clarifies expectations around legacy components.

> Follow-up: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")
> Follow-up: 751df4fa64 ("include/old: rename legacy headers to tso_* namespace")
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/developers/ltp_library.rst | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

> diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
> index f76cbb75e..bb2677622 100644
> --- a/doc/developers/ltp_library.rst
> +++ b/doc/developers/ltp_library.rst
> @@ -15,6 +15,34 @@ for :doc:`writing tests <../developers/writing_tests>`
>  #. Do not add new API functions to the old API. Add new functions to
>     ``tst_.[ch]`` files.

> +Library naming and scope
> +------------------------
> +
> +To keep the library API easy to navigate and to make layering explicit, LTP
> +library components follow these naming rules:
> +
> +- **tst_**: Core LTP library API (located in ``lib/``).
nit: maybe also use :master: for lib/ to make it clickable?
> +
> +  - Stable, widely used interfaces intended for general consumption by tests.
> +  - New public APIs should normally live here (in ``tst_*.h`` / ``tst_*.c``).
> +
> +- **tse_**: Non-core / extended library code (located in ``libs/``).
nit: and here as well?

> +
> +  - Optional or specialized helpers that are not part of the core API.
> +  - May have narrower scope or fewer stability guarantees than ``tst_``.
> +  - Can be promoted to ``tst_`` later if it becomes broadly useful and stable.
> +
> +- **tso_**: Legacy / old library code.
> +
> +  - Kept for backward compatibility.
> +  - No new features should be added; only minimal fixes are acceptable (e.g. build fixes, correctness fixes, security fixes).
very nit: maybe split long line?

> +  - New code should not depend on ``tso_`` unless strictly necessary.
> +
> +**Notes:**

nit: I'd prefer the standard note (can be changed before merge):

.. note::

> +
> +- Prefer adding new code to ``tst_`` or ``tse_``; avoid introducing new ``tso_`` components.
> +- When adding a new public interface, document where it belongs (``tst_`` vs ``tse_``) and why.

LGTM, but I'd prefer more developers acked it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
