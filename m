Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0C1C4828F
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 22:46:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE4063CF4EF
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 23:46:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024613CC33D
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:45:56 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6D51B1000CD7
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:45:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9358A1F836;
 Fri,  9 Feb 2024 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707518755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTLSk3AwcTkX7M99TlpnJNB+Z+by5Gs88gTSxkeOdkk=;
 b=Ujwqv4YjNujbObzY6DwrkYj0lxsLe9EomrzoaInCkcWB/seTXKeG0GFmYWBD1OaSnbwZbd
 JYeXs2A2FKOMKvHPV44h/vNcNLZOAH/kAfQUWQwbf5DVFlULFvjOwcFqVI3Om/HrIPLMm3
 nHdGHuw4jI+BIsk407I5vq4JwiNv3ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707518755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTLSk3AwcTkX7M99TlpnJNB+Z+by5Gs88gTSxkeOdkk=;
 b=VrnFn+51lO1CQHUKlxQPeHn2fqO+8FoBWA76D2hZou9/Xx5F2FENfdOywjV/dv61Tu58Zu
 UMVObvzyyPRaHGDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707518755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTLSk3AwcTkX7M99TlpnJNB+Z+by5Gs88gTSxkeOdkk=;
 b=Ujwqv4YjNujbObzY6DwrkYj0lxsLe9EomrzoaInCkcWB/seTXKeG0GFmYWBD1OaSnbwZbd
 JYeXs2A2FKOMKvHPV44h/vNcNLZOAH/kAfQUWQwbf5DVFlULFvjOwcFqVI3Om/HrIPLMm3
 nHdGHuw4jI+BIsk407I5vq4JwiNv3ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707518755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTLSk3AwcTkX7M99TlpnJNB+Z+by5Gs88gTSxkeOdkk=;
 b=VrnFn+51lO1CQHUKlxQPeHn2fqO+8FoBWA76D2hZou9/Xx5F2FENfdOywjV/dv61Tu58Zu
 UMVObvzyyPRaHGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E62D13353;
 Fri,  9 Feb 2024 22:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5V8qCiOrxmUgeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 22:45:55 +0000
Date: Fri, 9 Feb 2024 23:45:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240209224549.GB371480@pevik>
References: <20240208100517.1974-1-xuyang2018.jy@fujitsu.com>
 <20240208100517.1974-6-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240208100517.1974-6-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.39 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-0.998]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.90)[99.55%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 6/7] syscalls/swapon03: Simply this case
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

Hi Yang Xu,

This fails on TMPDIR on btrfs on all tested filesystems:
...
swapon03.c:61: TFAIL: swapon(filename, 0) failed: EPERM (1)
swapon03.c:70: TINFO: Successfully created 23 swapfiles
swapon03.c:138: TPASS: swapon(mntpoint/testswap, 0) : EPERM (1)
...
Summary:
passed   8
failed   8
broken   0
skipped  2
warnings 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
