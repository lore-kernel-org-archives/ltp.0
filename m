Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1511CD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 13:40:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F67C3C71E0
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:40:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B0353C71E0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 15:39:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3EEA510008F4
 for <ltp@lists.linux.it>; Tue, 26 May 2026 15:39:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0F9267295;
 Tue, 26 May 2026 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779802780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OaEYSnW8bYrzTfrDodU+cAjaXhy/cIJ3kLus1tQ3u4=;
 b=nca6h3gd12FDyF6IVtJMamyFI3JamgaGvRtoFQSoHDTtbmKd8q2xZcOU172m1b3NiBeOwj
 epGOmr6lIq09WvNj+SRwmZM0gEKEef4G3a2ptnxxPXOA0xE13Rof12hyYmxbBNwyVUz/gV
 veNOF48BW6M5thGenY2Hj4o18r5nVpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779802780;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OaEYSnW8bYrzTfrDodU+cAjaXhy/cIJ3kLus1tQ3u4=;
 b=ChHOVs7kSUDxrE474lI4H811KL90q1s0zPfwE00+8LTgJmo+fTv7D7Lv6ZHcz9yRS+UTVg
 ibhMRbSAZuF4zYCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779802779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OaEYSnW8bYrzTfrDodU+cAjaXhy/cIJ3kLus1tQ3u4=;
 b=hZUZ4fQy7FxBQ1dYXVpCd3asnK2eAOQ7dTlHGzsFthIX+iMme0MmifdFvMzg6dEICqK8+6
 EEeb3IAkTmhTL41eUBqAkcj7WzTWOCARe5rGswtCPLIwqEvk3drzdEpU+st5d8FgUj5boA
 dBsEReo7d2iKoz9Tbev4l/+kKVzA45Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779802779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5OaEYSnW8bYrzTfrDodU+cAjaXhy/cIJ3kLus1tQ3u4=;
 b=Zv1L4Z/5o7mEt6kS+DHLU6SPEzYht1Y2XWEvUa5O0qgtWwPm/pR72CAOnat+znN37isSjn
 a/bbsBDFwVEJDlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E6105A225;
 Tue, 26 May 2026 13:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nfBpApuiFWpsfQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 26 May 2026 13:39:39 +0000
Date: Tue, 26 May 2026 15:39:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260526133922.GB215060@pevik>
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526083406.357092-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] safe_macros: Add SAFE_READ_ANY_EAGAIN
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

Hi Cyril,

...
> +/* supported values for safe_read() len_strict parameter */
Could we have kerneldoc (ok to fix before merge).

/**
 * enum safe_read_opts - supported values for safe_read() len_strict parameter */
 *
 * @SAFE_READ_ANY: no length strictness, short reads are ok.
 * @SAFE_READ_ALL: strict length, short reads trigger :c:enum:`TBROK <tst_res_flags>`.
 * @SAFE_READ_ANY_EAGAIN: converts EAGAIN to read that returns 0.
 */

Otherwise LGTM, thanks for spotting the error.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +enum safe_read_opts {
> +	/* no length strictness, short reads are ok */
> +	SAFE_READ_ANY = 0,
> +
> +	/* strict length, short reads trigger TBROK */
> +	SAFE_READ_ALL = 1,
> +
> +	/* converts EAGAIN to read that returns 0 */
> +	SAFE_READ_ANY_EAGAIN = 2,
> +};
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
