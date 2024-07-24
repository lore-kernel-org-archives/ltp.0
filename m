Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13723C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A10363D1C35
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 17:14:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492CE3D0FA8
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:14:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 881491401192
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 17:14:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CD04218EE;
 Wed, 24 Jul 2024 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721834081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTIMWIMwzsbkJS9SHYhWar1wuz1fc68Q+TcXt1O1rqI=;
 b=WunNcYXMMNpHj6KaB5US+f3LnAWPzYbinybebFTLp4LN3q0UhJBKHLXQ9uD6FAlfzf0Np8
 9B1jESeCF8YtvHIt8g1Zw6OTlt763c6TKO+j3AsC92MJsxw7Ph95ogHqiMXx+3LxjYe4Yu
 10x24JDKUK+x5y6MMtVrXDiQFwV+jWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721834081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTIMWIMwzsbkJS9SHYhWar1wuz1fc68Q+TcXt1O1rqI=;
 b=Ka3CV3Xyp4tETYCGTVURHvyHbu24gIpAR5iqFaA6clcEJSIVpvSEEUAtOkuXV0WOBAoIw5
 H87neomX/91XMqDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721834081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTIMWIMwzsbkJS9SHYhWar1wuz1fc68Q+TcXt1O1rqI=;
 b=WunNcYXMMNpHj6KaB5US+f3LnAWPzYbinybebFTLp4LN3q0UhJBKHLXQ9uD6FAlfzf0Np8
 9B1jESeCF8YtvHIt8g1Zw6OTlt763c6TKO+j3AsC92MJsxw7Ph95ogHqiMXx+3LxjYe4Yu
 10x24JDKUK+x5y6MMtVrXDiQFwV+jWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721834081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTIMWIMwzsbkJS9SHYhWar1wuz1fc68Q+TcXt1O1rqI=;
 b=Ka3CV3Xyp4tETYCGTVURHvyHbu24gIpAR5iqFaA6clcEJSIVpvSEEUAtOkuXV0WOBAoIw5
 H87neomX/91XMqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F27B31324F;
 Wed, 24 Jul 2024 15:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /AgeOmAaoWbJMwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jul 2024 15:14:40 +0000
Date: Wed, 24 Jul 2024 17:14:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <ZqEaRwixo1dHiBEC@yuki>
References: <20240724130553.126252-1-fstornio@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240724130553.126252-1-fstornio@redhat.com>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mlock05: add log details about the success/failure
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
Cc: f.storniolo95@gmail.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In some testing environments, such as those related to safety
> critical requirements, more detailed logs are needed when
> the executed test passes or fails.
> This format already exists in other LTP tests, such as
> kernel/security/kallsyms/kallsyms.c

What exactly are the requirements? It would make more sense to improve
the TST_EXP_EQ_LU() macro to print the additional information instead...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
