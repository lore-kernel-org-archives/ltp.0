Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03385C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 15:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4698A3C926C
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7889E3C1925
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:26:24 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9A9AD61D990
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 16:26:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 80A3C1F7B5;
 Wed,  5 Feb 2025 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738769182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGBJY17yQaec6mlZBnRwFrZdVymA4/wEui9p4KrlUis=;
 b=x1RM3n5S3fxCTJoh0ODBENWn0xCInJCAz5PrZajvShsQ66AHpA1Cu3Np4si9u7gVzndHNo
 h4cyd9TPV24xKxYKwF8y8lnBbx2zNzUyqqd4lNxDYWMiqkUbqZ2HJ+kwHOAVz5pE9pf6KN
 GjJ3e14Z9amIo3BL6YUkUCCZU0O5qGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738769182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGBJY17yQaec6mlZBnRwFrZdVymA4/wEui9p4KrlUis=;
 b=CgDwfZjxG2+muAFNkjkXdIASceN1uiYr0SdCJ/GY91JFJKV1Y0t4iKOb2NUNuIymH8PAX5
 JdIiFdhTF2CkgpAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x1RM3n5S;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CgDwfZjx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738769182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGBJY17yQaec6mlZBnRwFrZdVymA4/wEui9p4KrlUis=;
 b=x1RM3n5S3fxCTJoh0ODBENWn0xCInJCAz5PrZajvShsQ66AHpA1Cu3Np4si9u7gVzndHNo
 h4cyd9TPV24xKxYKwF8y8lnBbx2zNzUyqqd4lNxDYWMiqkUbqZ2HJ+kwHOAVz5pE9pf6KN
 GjJ3e14Z9amIo3BL6YUkUCCZU0O5qGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738769182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGBJY17yQaec6mlZBnRwFrZdVymA4/wEui9p4KrlUis=;
 b=CgDwfZjxG2+muAFNkjkXdIASceN1uiYr0SdCJ/GY91JFJKV1Y0t4iKOb2NUNuIymH8PAX5
 JdIiFdhTF2CkgpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CF4F139D8;
 Wed,  5 Feb 2025 15:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l60yGR6Do2efIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 05 Feb 2025 15:26:22 +0000
Date: Wed, 5 Feb 2025 16:26:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z6ODH83RmqUtEDxv@yuki.lan>
References: <20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250205-doc_tests_list-v3-1-b60649cdea6a@suse.com>
X-Rspamd-Queue-Id: 80A3C1F7B5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] doc: add tests catalog page
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
> +        # timeout information
> +        timeout = conf.get('timeout', None)
> +        if timeout:
> +            text.extend([
> +                '',
> +                f'Test timeout to {timeout} seconds.',
                                  ^
				  is
> +                ''
> +            ])
> +        else:
> +            text.extend([
> +                '',
> +                f'Test timeout defaults to {timeout_def} seconds.',
> +                ''
> +            ])

Maybe it would make sense to add runtime here as well since it's
logically connected to the timeout.

Otherwise:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
