Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE73AC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:51:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33C513E7256
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:51:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02CB53E49EE
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:51:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F278A60090C
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:51:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98B347D668;
 Thu, 30 Jul 2026 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785405091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4qbGFTSGORhxkPamYq/BYImtcKDP4vPxf45XSh6F90=;
 b=IQOxiqKzYRchencaIwXw2/9n5RX70RaZpC0GRMhBnWfJtfkEiFwfCD4TB4XUbRLDPYbiaV
 qZCfKUyTn8DLHDU4pOh6Vx5sT7u3KZ1gmXqfglWP949o7aMhuUOY6kBhLmKrIJZ+yN8CEa
 Q+Javxbc+RaCjWngoIF17iU6g2QHiaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785405091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4qbGFTSGORhxkPamYq/BYImtcKDP4vPxf45XSh6F90=;
 b=BKizqR2UlJEjGpRjcYj/tCeUBDIorkSOJ4sg54guC9wF1+i2doOMJhrMw9d8doL4/bpevn
 2abpbE7H3bogW6Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="B/+xkh+O";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iU0IohEi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785405087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4qbGFTSGORhxkPamYq/BYImtcKDP4vPxf45XSh6F90=;
 b=B/+xkh+OcdCHEszFD/7WFJvnZmn4p4Ra4tW4Dj/KPgeHWymY7PL8eVXQ8dw6b+K07+lZBw
 uHVKlcYz+jDOShMQsUW9z2h2gTozgAP35ro/yptuZpkHvAaViq4ULL/19oFvgUS2BL0Urt
 4KYTznjvIuj0OxpljpRoaDpL3A1C2cU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785405087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4qbGFTSGORhxkPamYq/BYImtcKDP4vPxf45XSh6F90=;
 b=iU0IohEif9WrhzMMOqdc20IrAAXHWAj/8xNCDD4UD5Yon35IUbGbHmujqQn/CpNbxIC3PB
 NnQQyVaJJ8xiKjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7642D779CD;
 Thu, 30 Jul 2026 09:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n8+lG58ea2raCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Jul 2026 09:51:27 +0000
Date: Thu, 30 Jul 2026 11:51:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <li.wang@linux.dev>
Message-ID: <20260730095122.GA80062@pevik>
References: <20260730074120.180101-1-li.wang@linux.dev>
 <20260730074120.180101-2-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730074120.180101-2-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 98B347D668
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,suse.cz:replyto,suse.cz:email,suse.cz:dkim,hygon.cn:email];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Signed-off-by: Li Wang <liwang@hygon.cn>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/.mailmap b/.mailmap
> index d1e4419f0..35f54a937 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1,3 +1,4 @@
> +Li Wang <li.wang@linux.dev> <liwang@hygon.cn>

Acked-by: Petr Vorel <pvorel@suse.cz>

Congratulation to a new job :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
