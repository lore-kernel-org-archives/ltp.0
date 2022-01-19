Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144DC433EF
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 10:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E2543C96B0
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 11:55:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9DD3C950B
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 11:55:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77B736000FC
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 11:55:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 554C41F37E;
 Wed, 19 Jan 2022 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642589735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeGGlNViijQEZE9tYqeTmGyYIBI2fe3ZclferngjlJg=;
 b=zicmOUbV8k/z+lDmi54FoMI/KUYXHkkryFvHv6OjINPobBotmVi4SY6IVJGKvpJerhwE/H
 wyCmTj2m1xZyXk+rwH24syKk38ma/oRnIhoekAsGodqW1P2LoQPLdv9OpkjpOJCnPl7J2+
 iEuGgoEO0nWaBwfz6HogrxuVlH56y40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642589735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FeGGlNViijQEZE9tYqeTmGyYIBI2fe3ZclferngjlJg=;
 b=N8N50UXJlYdyZ2z03uLf/unhgO1sLJWawfVBth8VJiLIASlxziBi5KZz7bvyDQzBoAkmxX
 A9aZutzx0Eod8JAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D6EA13B3D;
 Wed, 19 Jan 2022 10:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AIilCSfu52GYVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 10:55:35 +0000
Date: Wed, 19 Jan 2022 11:55:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YefuJcfsDpuYeQ3X@pevik>
References: <20220118170243.22496-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220118170243.22496-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Rewrite statx04 test
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

Hi Martin,

> statx04 is supposed verify that inode attribute support in statx() matches
> what should actually be implemented. However, we already have functional tests
> for this in statx08 and lack a test of the stx_attribute_mask field which
> reports inode attribute support to userspace.

> Rewrite the test to drop the duplicate code and add the missing coverage.

LGTM, thanks! BTW you'd deserve your (or SUSE) copyright for this change :).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
>   * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
>   * three other flags.

I'd maybe add "known-fail" for xfs, as user hit this when running -s.
Maybe document like this also btrfs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
