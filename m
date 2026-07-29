Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ECCC54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 08:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83BF73E527F
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 10:43:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71B763E138C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 10:42:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2C35600A78
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 10:42:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 785147C941;
 Wed, 29 Jul 2026 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785314566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adhvdFjAc0uXvTL3wfjT59KPuBNYzlS/YpGCeTYA8oY=;
 b=jmHaEjmZv9H2fbptm0Ln6ShwbfS2lCPiw8HGV5CzGwR8jXMFNidGO91+Vv5+grinFrRobp
 NAN1CgzAzxUTZBK8FYDBr98xzmFPGO0W3Bkm3NZxwo1VQbIYzAw23qjSUsZR9UcYPiIDSY
 URZKAlUzaNeeLFQAfRXnCPm8z2owC5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785314566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adhvdFjAc0uXvTL3wfjT59KPuBNYzlS/YpGCeTYA8oY=;
 b=p8onESKUn5WXOs0BL2jNoe5Q5xRk6qQGMhTtZomguMBSLjRg3Z2NIKBoWwpvaRx0f6Wij6
 BD5pr6QVOlqrKQBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hpW6otB5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c0sY54vQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785314562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adhvdFjAc0uXvTL3wfjT59KPuBNYzlS/YpGCeTYA8oY=;
 b=hpW6otB5lZ1/KXvK5aTJIM+coLJvSOraeHz76HN+XVPB+OMph5oo95cTmxN4SmPdiVG1Sn
 YaEXNNxad1QHrA4eZnQxryZzSXiTK0OS8UXur3M9VMMSWijjPnXY9OS04ovZSJeyrW7SjA
 1bhhTawg/WefgKmwGQxNBfzL56sLLQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785314562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=adhvdFjAc0uXvTL3wfjT59KPuBNYzlS/YpGCeTYA8oY=;
 b=c0sY54vQ9zxuudGjnpigUKpNqGTTga95FcPBk6AZAkeS/VLgPcaIl5VVMW0Xq9DNhHSydz
 lWQwQnSFbBv1hUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50168779A1;
 Wed, 29 Jul 2026 08:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id agGrEgK9aWomXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 08:42:42 +0000
Date: Wed, 29 Jul 2026 10:42:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260729084236.GA16391@pevik>
References: <6a68b46f.f3563870.c8a40.1a2b@mx.google.com>
 <6a6994e9.6ab3636b.1b6ed.7916@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6994e9.6ab3636b.1b6ed.7916@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 785147C941
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,suse.cz];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test
 on v7.2+
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
Cc: linuxtestproject.agent@gmail.com, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > This observation is correct. If v7.2+ enabled only pidfd + tid combination
> > for fanotify, we should not skip pidfd + fid. The 1/5 patch needs to be
> > updated to use a per tcase TCONF.

> I think I missed Amir comment in here:
> https://lore.kernel.org/ltp/CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com/

Good catch.

> Hence, if it's correct, we should then provide a better TINFO message,
> or to skip test entirely for v7.2+, explaining inside the test
> description why this is needed.

From Amir's comment I understand whole test should be skipped.
I'll send a patch adding .max_kver to tst_test struct (needed already for at
least 2 tests) + reuse it here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
