Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC14C48BF6
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 12:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 036AC3CEC0C
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 13:43:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A02133CCEB3
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 13:43:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABF822009D7
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 13:43:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D926E608A4;
 Sun,  3 Mar 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709469784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrjADutE84EoVKbQp7Jan6pIOqQ2Ut/4mWo2VYAYig0=;
 b=wpdDqHYfH8qkRKzrio0OX2r/bV3ZAtY/TvNCJRaIie2AJM6lMAIeOJsVPzpAeAWI5KgTqa
 eHjzL9UeUCPEpeXDFJzb8m5sbpe1Dxwps9yGMQAvlcehN+R1nIDL+eK9vWPfFypO7wkeRU
 leDz6GRfH+PrvRDcDncNU1sy4Fcnv3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709469784;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrjADutE84EoVKbQp7Jan6pIOqQ2Ut/4mWo2VYAYig0=;
 b=zS/Ju+7dmma4LIwcSsur/Z0wTp4Ru9kr0PZNUUAsRxAMPc/aKXwiL/SnGG/pEc5VW4QqPa
 1HX/n37MhgPaVVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709469783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrjADutE84EoVKbQp7Jan6pIOqQ2Ut/4mWo2VYAYig0=;
 b=wHf/T2yXDjUdvBrCfOmI9KNyKgVPluwRvhIb08QxM3FF15YvVumKvEVXKZztpPXkYWg9lo
 Yxv7/BFkc7gXlWvbnHetm792lfXLdyHHW3mmC8J3x1QRozHrlo47lRj0XTBh4MqCvttpCX
 1tlAZfFaE6gAbPpWNL2Z5jAoTwThC3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709469783;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RrjADutE84EoVKbQp7Jan6pIOqQ2Ut/4mWo2VYAYig0=;
 b=KxvvhXLYeFbZynxsXasgdNo7O9bQyoHcIhn1tVlOFFLIe6T91WzhASBMJkxTox5Ki8zedw
 N3fWtWc4sByB0CDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B1E2F133B5;
 Sun,  3 Mar 2024 12:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id VICLKVdw5GVsMgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sun, 03 Mar 2024 12:43:03 +0000
Date: Sun, 3 Mar 2024 13:42:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240303124258.GA1837748@pevik>
References: <20240301102347.3035546-1-liwang@redhat.com>
 <ZeRG+KzmNHaokn5Q@wegao.87.41.165>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZeRG+KzmNHaokn5Q@wegao.87.41.165>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wHf/T2yX";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KxvvhXLY
X-Spamd-Result: default: False [0.12 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.37)[77.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D926E608A4
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_dir_mk: set the umask to '0' before
 creating the subdir
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

Hi Li, Wei,

...
> > Notes:
> >     Hi Wei, can you help confirm if this patch works for you?

> @Li I have tested your patch and it can work.
> @Li @Petr Thanks for your patch and comments, i suppose this patch can be merged.

I added Wei's RBT and TBT and merged.
Thank to you both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
