Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A51AD35179
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 12:08:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 998E93E5C18
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 14:08:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7DB03D8E72
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 14:08:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0A2671A0099E
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 14:08:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B6D05BD5F;
 Wed,  1 Apr 2026 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775045306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRttmPMdHJyD0uL4D4LzVnGLSnYKbUwtyab7+zujOc=;
 b=r0I9rh9Ggmq5nj5ezmQn1YzF0jAlhY+R9c5qRrV1CFHo8gQhMUzVE1qXWmRb+/+MmieHc9
 ZdxAt5vPqh+R0P5yRsJ1ub+i2K4YhpVBK0+kI/N+s0i1G6EkxA54gT67zysl+RS5Ql/dvu
 kK13qV9NF58AysmVBoe91kSGz1ddctM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775045306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRttmPMdHJyD0uL4D4LzVnGLSnYKbUwtyab7+zujOc=;
 b=C6NbUCaGK43GluBrUSNe2deGRgEXwk6YYvwCPIxaon3mpNnz459eq6nA6tyr+wQi7c4WLC
 OE+lOKmCY22nwHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775045306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRttmPMdHJyD0uL4D4LzVnGLSnYKbUwtyab7+zujOc=;
 b=r0I9rh9Ggmq5nj5ezmQn1YzF0jAlhY+R9c5qRrV1CFHo8gQhMUzVE1qXWmRb+/+MmieHc9
 ZdxAt5vPqh+R0P5yRsJ1ub+i2K4YhpVBK0+kI/N+s0i1G6EkxA54gT67zysl+RS5Ql/dvu
 kK13qV9NF58AysmVBoe91kSGz1ddctM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775045306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpRttmPMdHJyD0uL4D4LzVnGLSnYKbUwtyab7+zujOc=;
 b=C6NbUCaGK43GluBrUSNe2deGRgEXwk6YYvwCPIxaon3mpNnz459eq6nA6tyr+wQi7c4WLC
 OE+lOKmCY22nwHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A52C4A0B0;
 Wed,  1 Apr 2026 12:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eFYAELoKzWnSbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 01 Apr 2026 12:08:26 +0000
Date: Wed, 1 Apr 2026 14:08:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260401120824.GB126168@pevik>
References: <20260330-kirk_4-1-0-v1-1-bc4fd68edaf1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260330-kirk_4-1-0-v1-1-bc4fd68edaf1@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: upgrade version to 4.1.0
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> - ltp: support network tests configurations by @acerv in #95
> - ltp: Remove unused PASSWD, RUSER variables by @pevik in #96
> - monitor: fix mismatch between event and its name
> - minor fixes and code stabilization

FYI I dared to merge this.

Kind regards,
Petr

> Link: https://github.com/linux-test-project/kirk/releases/tag/v4.1.0
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  tools/kirk/kirk-src | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
> index 6b0f87c6df90b87a8c32648c94169a83b4e58024..7d4234c4305ab8b7b4ec27e911798b5e7f65ef88 160000
> --- a/tools/kirk/kirk-src
> +++ b/tools/kirk/kirk-src
> @@ -1 +1 @@
> -Subproject commit 6b0f87c6df90b87a8c32648c94169a83b4e58024
> +Subproject commit 7d4234c4305ab8b7b4ec27e911798b5e7f65ef88


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
