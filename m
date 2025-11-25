Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BC9D0E6E1
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 13:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F2A83CE672
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 14:27:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE23C3CD3F4
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 14:27:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C81F910009BD
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 14:27:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 329B25BD0D;
 Tue, 25 Nov 2025 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764077256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PwELkMxNOY3+vNMo0QJ0TyF0Kd0kbx1UtNs5sLW4ZU=;
 b=i/25uzQxuF5JkyGbH5DRLT+oidl7fMJXRTIZaMVqXsAgu9rrmy2BA/6Lq1hdCGOJGfdJCD
 yLARvzBRxPIfHMc8WhVrKB92ZFNx13aoQd5TMYtsdoyBwQyyo3hEa4dBQGPy6/cawRYrb+
 EtweQ+t2De9TbdGZaKDeaSKF8B5XCBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764077256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PwELkMxNOY3+vNMo0QJ0TyF0Kd0kbx1UtNs5sLW4ZU=;
 b=YXuZ9yyYG+u1WuQeLPOy8oHBxYQ5gF6mYcuxftHXo6tzET8a1rpraVTowL4STdHSl5RkuQ
 1lTkbID22O0qMaAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764077256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PwELkMxNOY3+vNMo0QJ0TyF0Kd0kbx1UtNs5sLW4ZU=;
 b=i/25uzQxuF5JkyGbH5DRLT+oidl7fMJXRTIZaMVqXsAgu9rrmy2BA/6Lq1hdCGOJGfdJCD
 yLARvzBRxPIfHMc8WhVrKB92ZFNx13aoQd5TMYtsdoyBwQyyo3hEa4dBQGPy6/cawRYrb+
 EtweQ+t2De9TbdGZaKDeaSKF8B5XCBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764077256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PwELkMxNOY3+vNMo0QJ0TyF0Kd0kbx1UtNs5sLW4ZU=;
 b=YXuZ9yyYG+u1WuQeLPOy8oHBxYQ5gF6mYcuxftHXo6tzET8a1rpraVTowL4STdHSl5RkuQ
 1lTkbID22O0qMaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 174AD3EA63;
 Tue, 25 Nov 2025 13:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x8faBMiuJWkjKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Nov 2025 13:27:36 +0000
Date: Tue, 25 Nov 2025 14:27:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251125132730.GA168252@pevik>
References: <20251125122210.11316-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251125122210.11316-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] CI: do not checkout submodules
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

> This was originally added so that kirk installation is tested. The
> problem is that this brings random failures when git.kernel.org timeouts
> when we are checking out submodules that are not needed for the build
> and neither for the installation.

> Unfortunatelly there is no support for selective submodule installation
> in github checkout action. There is an issue and pull request hanging:

> https://github.com/actions/checkout/pull/1866
> https://github.com/actions/checkout/issues/1969

> It looks like if we wanted to checkout only kirk submodule we would have
> to install git and run all the commands ourselves in the CI, which I
> would like to avoid. Hence this commit removes the submodules checkout
> from the CI, with that we sacrifice kirk installation testing but avoid
> random failures.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

I'm ok with it.
nit: I'd mention it is actually a revert of 9cde2740cc.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> ---
>  .github/workflows/ci-docker-build.yml | 2 --
>  1 file changed, 2 deletions(-)

> diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
> index f7c779f63..09eb8bb6d 100644
> --- a/.github/workflows/ci-docker-build.yml
> +++ b/.github/workflows/ci-docker-build.yml
> @@ -125,8 +125,6 @@ jobs:

>      - name: Git checkout
>        uses: actions/checkout@v1
> -      with:
> -        submodules: 'true'

>      - name: Install additional packages
>        run: |

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
