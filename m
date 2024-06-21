Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF34EC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 10:16:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CC3A3D0ECC
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 12:16:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D7033C0FCD
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 12:15:48 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79434600956
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 12:15:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 568671FB66;
 Fri, 21 Jun 2024 10:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718964946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRjaCpl+ShBTFUq8KLYDPHcYOV6iLflavNyaOA9RdwU=;
 b=vXQBBc0jV4zCJ8DHcWqIbISUKc4qS3Xw8cnT66j6iCJPEBHIbc91hLIjjof2BYf4Ha85MS
 guX/YwggbEEJ3y8roM5Pp8rPChEgNrnh5H2Ym3tLCr0Jg9Hb1Ok59KDc1VkO+07YyO5/oQ
 wfj+VWtdZSY9xSw3S4t8UK5muRCg7QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718964946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRjaCpl+ShBTFUq8KLYDPHcYOV6iLflavNyaOA9RdwU=;
 b=aCfYZcOsRDfbCzK6tCxCy0TdKKd8o1LGRPzC2pK0Lz7fzQTRIiEQUs8iLb+qAouz7d7QsE
 dYTDeVkhtvKuKoDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vXQBBc0j;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aCfYZcOs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718964946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRjaCpl+ShBTFUq8KLYDPHcYOV6iLflavNyaOA9RdwU=;
 b=vXQBBc0jV4zCJ8DHcWqIbISUKc4qS3Xw8cnT66j6iCJPEBHIbc91hLIjjof2BYf4Ha85MS
 guX/YwggbEEJ3y8roM5Pp8rPChEgNrnh5H2Ym3tLCr0Jg9Hb1Ok59KDc1VkO+07YyO5/oQ
 wfj+VWtdZSY9xSw3S4t8UK5muRCg7QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718964946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRjaCpl+ShBTFUq8KLYDPHcYOV6iLflavNyaOA9RdwU=;
 b=aCfYZcOsRDfbCzK6tCxCy0TdKKd8o1LGRPzC2pK0Lz7fzQTRIiEQUs8iLb+qAouz7d7QsE
 dYTDeVkhtvKuKoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E58613ABD;
 Fri, 21 Jun 2024 10:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8claDtJSdWZTUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jun 2024 10:15:46 +0000
Date: Fri, 21 Jun 2024 12:15:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZnVSxrE8ct9ZDNHg@yuki>
References: <20240620054958.554319-1-pvorel@suse.cz>
 <20240620054958.554319-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240620054958.554319-2-pvorel@suse.cz>
X-Rspamd-Queue-Id: 568671FB66
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lib: Create tst_tmpdir.h
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/include/tst_tmpdir.h b/include/tst_tmpdir.h
> new file mode 100644
> index 000000000..b4f95b666
> --- /dev/null
> +++ b/include/tst_tmpdir.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2020 Martin Doucha <mdoucha@suse.cz>
> + */
> +
> +#ifndef TST_TMPDIR_H__
> +#define TST_TMPDIR_H__
> +
> +/*
> + * Wipe the contents of given directory but keep the directory itself
> + */

This should ideally a proper documentation comment, but that can be done
in an follow up patch.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
