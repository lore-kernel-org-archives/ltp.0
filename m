Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F6C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:41:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A3A33D019F
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 17:41:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDF9A3D0154
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:41:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C962A602BD8
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:41:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B28E2290E;
 Thu, 23 May 2024 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716478875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJMlhhbh2hDRX+G4KskRHUvBPxY+9+DUHtlOQ6TCTTo=;
 b=NTPKAOLlP6MxQEET+pRMvCSnqjm4W6ozgWIIraLWBBOKg2wIWnAPnOqm8YyZvjWM5xDswZ
 9Za/dOoOdAQy+xb1K+zoyL6chzL0ThyJsdCOjbDjuqoRzHbcP0+8iMGCzanL3zWq1pv6/1
 26BZJa2YA4wc/2EaRAV/SrybZxY4TBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716478875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJMlhhbh2hDRX+G4KskRHUvBPxY+9+DUHtlOQ6TCTTo=;
 b=Y6ZFAVfg9poAoCzg6Aq0OX+/pXmoPX55RaRm9K5rFkN676k/TXM8fKknnbbbqb2zytvCJi
 KorSDH8j3OaA9UAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716478875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJMlhhbh2hDRX+G4KskRHUvBPxY+9+DUHtlOQ6TCTTo=;
 b=NTPKAOLlP6MxQEET+pRMvCSnqjm4W6ozgWIIraLWBBOKg2wIWnAPnOqm8YyZvjWM5xDswZ
 9Za/dOoOdAQy+xb1K+zoyL6chzL0ThyJsdCOjbDjuqoRzHbcP0+8iMGCzanL3zWq1pv6/1
 26BZJa2YA4wc/2EaRAV/SrybZxY4TBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716478875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJMlhhbh2hDRX+G4KskRHUvBPxY+9+DUHtlOQ6TCTTo=;
 b=Y6ZFAVfg9poAoCzg6Aq0OX+/pXmoPX55RaRm9K5rFkN676k/TXM8fKknnbbbqb2zytvCJi
 KorSDH8j3OaA9UAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FD9B13A6C;
 Thu, 23 May 2024 15:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YSZfCptjT2YZEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 May 2024 15:41:15 +0000
Date: Thu, 23 May 2024 17:41:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240523154113.GB18111@pevik>
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523133132.13978-3-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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

Hi,

BTW I have found problem on Alpine:

tst_pid.c:84: TINFO: Cannot read session user limits from '/sys/fs/cgroup/user.slice/user-1000.slice/pids.max'
tst_pid.c:84: TINFO: Cannot read session user limits from '/sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max'
msgstress01.c:269: TINFO: Available messages slots: 5530
msgstress01.c:164: TFAIL: Received wrong data at index 99: ffffffa3 != 19

It looks to me it's not related to using busybox init system (e.g. IMHO not
related to the Cannot read session user limits, but I can be wrong).
Anyway, this is for sure not a blocker for the release (and probably wait for
LTP musl users).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
