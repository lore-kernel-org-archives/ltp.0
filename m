Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E54C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A397A3CFFAB
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:37:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11983CE65E
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:37:05 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2607620096E
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:37:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6320A5BF67;
 Wed, 20 Mar 2024 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710952623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDT7khuydn291OXZAl8f26Gla44Ln3vWJ1Pp4meCGVM=;
 b=iPJItEwTGiIcePfaVtecTIMST294AZ5/atNG2Yw7kaKRG56OUSgcCOWcxxFZdRxUwUCUsc
 fJ2kIo8FJBiY+AogE8MDWl3A5YBYb9WdMUKpBoowq1MiUWnp6jaWifajxMlPUd3UAhKivY
 H8YoJWyEgaf0+cLjTbBYIr3L/3eAxJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710952623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDT7khuydn291OXZAl8f26Gla44Ln3vWJ1Pp4meCGVM=;
 b=9Hy0MaC/fFL6tINe2XAbWwBFHoOHKiWPBuzySzRMMq1ijZNH0mzqxPsDkVZOZbTsMd2JCl
 gYjjQbkbsVEGoZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710952623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDT7khuydn291OXZAl8f26Gla44Ln3vWJ1Pp4meCGVM=;
 b=iPJItEwTGiIcePfaVtecTIMST294AZ5/atNG2Yw7kaKRG56OUSgcCOWcxxFZdRxUwUCUsc
 fJ2kIo8FJBiY+AogE8MDWl3A5YBYb9WdMUKpBoowq1MiUWnp6jaWifajxMlPUd3UAhKivY
 H8YoJWyEgaf0+cLjTbBYIr3L/3eAxJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710952623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDT7khuydn291OXZAl8f26Gla44Ln3vWJ1Pp4meCGVM=;
 b=9Hy0MaC/fFL6tINe2XAbWwBFHoOHKiWPBuzySzRMMq1ijZNH0mzqxPsDkVZOZbTsMd2JCl
 gYjjQbkbsVEGoZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C3C4136D6;
 Wed, 20 Mar 2024 16:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K3IgB68Q+2WfawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 16:37:03 +0000
Date: Wed, 20 Mar 2024 17:37:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <20240320163701.GB496781@pevik>
References: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
 <20240314101344.4000544-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240314101344.4000544-1-ruansy.fnst@fujitsu.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iPJItEwT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9Hy0MaC/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.93 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.22)[72.10%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 6320A5BF67
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getxattr01: Convert to new API
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

Hi,

> -/*
> +/*\
> + * [Description]
> + *
>   * Basic tests for getxattr(2) and make sure getxattr(2) handles error
>   * conditions correctly.
>   *

> @@ -31,112 +15,53 @@
>   *    getxattr(2) should return -1 and set errno to ENODATA
>   * 2. Buffer size is smaller than attribute value size,
>   *    getxattr(2) should return -1 and set errno to ERANGE
> - * 3. Get attribute, getxattr(2) should succeed
> - * 4. Verify the attribute got by getxattr(2) is same as the value we set
> + * 3. Get attribute, getxattr(2) should succeed, and the attribute got by
> + *    getxattr(2) should be same as the value we set
>   */

 * There are 4 test cases:
Without space here the list will not be formatted correctly :(.
Currently it's needed to add it.
 * 1. Get an non-existing attribute,
 *    getxattr(2) should return -1 and set errno to ENODATA
 * 2. Buffer size is smaller than attribute value size,
 *    getxattr(2) should return -1 and set errno to ERANGE
 * 3. Get attribute, getxattr(2) should succeed, and the attribute got by
 *    getxattr(2) should be same as the value we set

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
