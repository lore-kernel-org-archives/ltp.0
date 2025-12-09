Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11E9D3B992
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4013CAEA8
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 20:53:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCD6F3CA1ED
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:53:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A1771000617
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:53:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D61355BEBA;
 Tue,  9 Dec 2025 19:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765310015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3UsBbOjwYMCMrJA5smWheTKPI1Vfj7YDa2/4vO2zhE=;
 b=uP77WNiZrBpHQ52JqEPeLYiC0/Rm5HWQa9mMl1bK3/pg9Ykl9sMwdev1DAmvrTJGPn9cdZ
 fhoatbs3cADDQ5zM2lgRgQ9MYuIuHZQHMjJ5JjFVYdQ+h4mm6L8g7RrceU3T/2ZyIb8jGT
 cuCi9ZexobOXS92eZ9Iher3BXntZixc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765310015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3UsBbOjwYMCMrJA5smWheTKPI1Vfj7YDa2/4vO2zhE=;
 b=i6Z5kuJOu4JxMRaEtC1s8HuAv9jwPxGau3Kq61tjBu9RzHsr5HuDVYZHuPSP8WN1YUvaOT
 P0UzggcvxDcqv8Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765310014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3UsBbOjwYMCMrJA5smWheTKPI1Vfj7YDa2/4vO2zhE=;
 b=n+GKgq41/a9SYzrSWmltu3hxX6LpER++KIv/tTOz5dh6VJM7Efmu2mV9kk1NzcBOg+F2Kc
 7Tu5+1kBeASVhqS1WEl31O0HZXeQi/M9zO/AkOMziIqQ2NyWw8JiXGPmqvPiSprwtdTwiz
 kuvFgbERofwnZ+BDvXTaQgjetjfTHvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765310014;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3UsBbOjwYMCMrJA5smWheTKPI1Vfj7YDa2/4vO2zhE=;
 b=8ShugDiU5jKGy2dxGEdPQL40TOpIH9TNEV027xRugzLu4N0qzS1D7KvbHYq8DZbLfmYQVw
 inys7/moIb8dLdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D6753EA63;
 Tue,  9 Dec 2025 19:53:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DaYqHD5+OGl5ewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 19:53:34 +0000
Date: Tue, 9 Dec 2025 20:53:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: simplemessager@163.com
Message-ID: <20251209195328.GB24146@pevik>
References: <20251208150542.704006-1-pvorel@suse.cz>
 <20251209124041.216542-1-simplemessager@163.com>
 <20251209124041.216542-2-simplemessager@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209124041.216542-2-simplemessager@163.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[163.com]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[163.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,ozlabs.org:url];
 TO_DN_NONE(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

This replaces my previous attempt:
https://patchwork.ozlabs.org/project/ltp/patch/20251208150542.704006-2-pvorel@suse.cz/
https://lore.kernel.org/ltp/20251208150542.704006-2-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
