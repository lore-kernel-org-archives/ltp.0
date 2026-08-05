Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D652BC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:49:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1359C3E90B8
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:49:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211B03E4A27
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:48:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F11E10000D8
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:48:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 222CF7F273;
 Wed,  5 Aug 2026 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785944932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty/iohTcvNOb+CwHElA/mv1SnuAGjjMont9ay4wYnck=;
 b=m+YuKfWoT6gm2nlMtd6DS68aNBkrEz+BABkGgL8Cys5E2v6JebyX3fI3ctCaeyv7Y33DeC
 C/yAiyaEbCU85lwfUirbFDEfaxb+cim012p2qoku6pe5i/3yutyxw9bNx48Oirf974a+A2
 0IdRTAtUIr4ps91npJyoobNMaCspSjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785944932;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty/iohTcvNOb+CwHElA/mv1SnuAGjjMont9ay4wYnck=;
 b=c5XZIro0l12/dITCaUNJwimU4LKNzlZtl2+HVgTE2PBN5BbCjeOY4BzqqEhswuxncWRyc8
 6QImAzVpW4nS1XBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nvL7jNG6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HMSGAe6a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785944928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty/iohTcvNOb+CwHElA/mv1SnuAGjjMont9ay4wYnck=;
 b=nvL7jNG6wwAaPYnB1cYo9QlfaQTGF1MnLTFl58dFckNGzV3Nc+GioEFtpj8qBa+vZKIaQK
 WD+Ox+YIz7qSHsf/CVofjhrAd6HtD0nV90btSJ306ws4dmW3NUIygbD49VG6ygYJxzQpKO
 mFNrL0XBC0RxkN6qjiWLlJhHXWnuhnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785944928;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty/iohTcvNOb+CwHElA/mv1SnuAGjjMont9ay4wYnck=;
 b=HMSGAe6aspCl6lXnD8KOsV+xHdusLN+S41u7rTFc0pBVTZvrR3xLzT8GyEVUb4Lj0fc1jJ
 4ngRl9zaXxqy91BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1FEE779C2;
 Wed,  5 Aug 2026 15:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3ma6MV9bc2ofPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:48:47 +0000
Date: Wed, 5 Aug 2026 17:48:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260805154846.GC649402@pevik>
References: <20260805145213.3066-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805145213.3066-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 222CF7F273
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok Kim,

> +static void run(void)
> +{
> +	check_available_governors();
> +	check_current_driver();
> +	check_current_governor();
> +	check_current_governor_ro();
please instead of this and .test_all use a test struct, the way we use in
basically any test, see e.g.
testcases/kernel/syscalls/mbind/mbind01.c
testcases/kernel/syscalls/bind/bind01.c

then you'll use:
    .tcnt = ARRAY_SIZE(tcase),
    .test = do_test

Kind regards,
Petr

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
