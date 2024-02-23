Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F7C54E49
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 10:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7821C3CF774
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 11:15:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 730C73CC976
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 11:15:35 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B93961011F45
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 11:15:34 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 750BF1FBDE;
 Fri, 23 Feb 2024 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708683331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7eLUaWMvCiAC8pFysOOBF3SnH6CZ0HEELMlH+ra8V0=;
 b=PAxZb0zsyTLh/J8F1ahmh0ZR5nz3AEVfkL5wt13JIRCKAcUlc1HJA5aQXFXjd5GQKLfs5M
 8XjFO0h4zNfCxIyw5e71xSmYpe7CI+wyEaJrAFn2JAltcxbr0S7aJjh3/PXLirJYn7zaUU
 DoKLbvdzjwBjzTZeVfHci7ISe7KhkvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708683331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7eLUaWMvCiAC8pFysOOBF3SnH6CZ0HEELMlH+ra8V0=;
 b=IeyDUCKTGUqjpBxuJU07ND0lpthbdnx9uECL5wvMqUe5Y9ocvp6Lvy6tmceyn9PmEfU73x
 VctKyJuLSIQpmyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708683331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7eLUaWMvCiAC8pFysOOBF3SnH6CZ0HEELMlH+ra8V0=;
 b=PAxZb0zsyTLh/J8F1ahmh0ZR5nz3AEVfkL5wt13JIRCKAcUlc1HJA5aQXFXjd5GQKLfs5M
 8XjFO0h4zNfCxIyw5e71xSmYpe7CI+wyEaJrAFn2JAltcxbr0S7aJjh3/PXLirJYn7zaUU
 DoKLbvdzjwBjzTZeVfHci7ISe7KhkvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708683331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7eLUaWMvCiAC8pFysOOBF3SnH6CZ0HEELMlH+ra8V0=;
 b=IeyDUCKTGUqjpBxuJU07ND0lpthbdnx9uECL5wvMqUe5Y9ocvp6Lvy6tmceyn9PmEfU73x
 VctKyJuLSIQpmyDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BBA113419;
 Fri, 23 Feb 2024 10:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /PKEEUNw2GW9TAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 10:15:31 +0000
Date: Fri, 23 Feb 2024 11:15:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20240223101530.GF1423688@pevik>
References: <20240220074218.13487-1-xuyang2018.jy@fujitsu.com>
 <20240220074218.13487-4-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220074218.13487-4-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.14 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.84)[99.32%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/7] swaponoff.h: Remove useless header
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
