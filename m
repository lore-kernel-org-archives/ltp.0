Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6100BC35FF4
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 08:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB67B3C2DDF
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 10:43:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F433C0BBD
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:43:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8A77200AEC
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:43:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 235AF1FFC6;
 Tue, 17 Sep 2024 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726562606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMAsrSL0RAkmGWEAtouLeaRTdCX/+PigP2qt3bGHtbA=;
 b=axekZ0AYZ+wCtGIqavZwPFE3GjHYV+7Mks0gOWkE9fMFNPEBw2NYD8/mlaBNXy9dth6rLo
 F/Juw/B9H9jtG3wWMMTqJm/kjIzI8l9UYNclrLWvBnczi+OOddOBx9Yv2aXjiGyM8MvyTN
 Oi2WzNPlqjgtZC9h4odrxXlaFsKh3Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726562606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMAsrSL0RAkmGWEAtouLeaRTdCX/+PigP2qt3bGHtbA=;
 b=RVWVuxy1k0mmMj321bBRzEAuslDtIVfazHiJiCyJsZiLG2zZdzoz/AgUd+cAWhhDxuTCB3
 5McWZVdX3b/2a/Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726562605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMAsrSL0RAkmGWEAtouLeaRTdCX/+PigP2qt3bGHtbA=;
 b=DLS9brmU2Eam3HqX+t/wFmME5AMG/6bs8nKbsWuxHO8C6V+jzHpLRuPUozxbYaqSb8PAFX
 JsXGnlAQzPBwT5xLR5wYTnfN7Oj9RWWO2kRcIQJol4iRrQ4gebPMCOtvb0pPZeMO/5MWYq
 TVR7CEQ+6hCwgs8+TGFMC67HFM0WvZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726562605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMAsrSL0RAkmGWEAtouLeaRTdCX/+PigP2qt3bGHtbA=;
 b=Pg/e+XpZP5fe2jfjYLsywqVwRh6rOa5LUDL5RgGO+ZUOZMHb4CtOyrb7c50zKlFCvCogPr
 5NIZMwabD3sckVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A22E139CE;
 Tue, 17 Sep 2024 08:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TBNYAS1B6WbGVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 08:43:25 +0000
Date: Tue, 17 Sep 2024 10:42:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZulA6coWZZqvMQ3K@yuki.lan>
References: <20240524085617.32303-1-wegao@suse.com>
 <20240529115828.28396-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240529115828.28396-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] chmod09.c: Block mode changes of symlinks
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
> +/*\
> + * [Description]
> + *
> + * Test for kernel commit
> + * 5d1f903f75a8 ("attr: block mode changes of symlinks")

I've added this to the tst_test tags as well and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
