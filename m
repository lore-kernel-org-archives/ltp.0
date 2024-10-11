Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314F2D2447B
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 07:02:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547AD3C5530
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 09:02:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4E73C04EF
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 09:01:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9847011F0131
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 09:01:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A97F81F829;
 Fri, 11 Oct 2024 07:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728630111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoNokx9ks/ogfbAy2XQ69WPPQfHFIWnhQxAp91k0VFs=;
 b=KA/0u3Mg9nlXUeVS5gDPh2cd7J6bGF13GgejayPxfZrjWqCgaw1NRnJbEe7j1Yp254SN4t
 NwtG0vm9z7fhJ1moknpgIPW10bQoXC0bz/KMl3wJmqzrNlr23vheLErJZOGJxVJ9wWK5OZ
 qNiUQ95NvHQPgLgY1KkcRhBpTp2dKFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728630111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoNokx9ks/ogfbAy2XQ69WPPQfHFIWnhQxAp91k0VFs=;
 b=vqchcwlK5st5C4mp1onilbkGWVDETxTRIgLuPMdRB9CtICgafwkLEI/I/wGJl/H6lUyPB9
 cNF2TLBNDJb4jTDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728630111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoNokx9ks/ogfbAy2XQ69WPPQfHFIWnhQxAp91k0VFs=;
 b=KA/0u3Mg9nlXUeVS5gDPh2cd7J6bGF13GgejayPxfZrjWqCgaw1NRnJbEe7j1Yp254SN4t
 NwtG0vm9z7fhJ1moknpgIPW10bQoXC0bz/KMl3wJmqzrNlr23vheLErJZOGJxVJ9wWK5OZ
 qNiUQ95NvHQPgLgY1KkcRhBpTp2dKFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728630111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoNokx9ks/ogfbAy2XQ69WPPQfHFIWnhQxAp91k0VFs=;
 b=vqchcwlK5st5C4mp1onilbkGWVDETxTRIgLuPMdRB9CtICgafwkLEI/I/wGJl/H6lUyPB9
 cNF2TLBNDJb4jTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B66D1370C;
 Fri, 11 Oct 2024 07:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WLncIF/NCGe4fQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Oct 2024 07:01:51 +0000
Date: Fri, 11 Oct 2024 09:01:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZwjNOmz1i8dpKmS8@rei.lan>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
 <20241009-ioctl_ficlone01_fix-v5-1-943238be9923@suse.com>
 <ZwfUcY7ShiepjJ7J@yuki.lan> <ZwfV_f89AbQpQX-l@yuki.lan>
 <09db9e97-da63-43b2-835d-daab733a3e4a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09db9e97-da63-43b2-835d-daab733a3e4a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Filter mkfs version in tst_fs
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
> If it's ok for you, I will push all patches with your patch included and 
> Reviewed-by tag in the last one.

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
