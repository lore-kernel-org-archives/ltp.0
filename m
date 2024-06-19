Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DB9C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 07:47:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44D4A3D0DA9
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 09:47:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 983403D0D99
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:47:06 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BC82C6023E2
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 09:47:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 747851F804;
 Wed, 19 Jun 2024 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718783224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MM1iugd8w79JCzPPBwKJPlHbBy3O7tMAh9Dfmkw8B7g=;
 b=sE1OpRU+IZB8xuuu7lxX4oHAxfst9oBlMJclAIiT0CFUTz0vJVRbh3xabuwWIrj/4yqyMe
 Cxu/pmFIMVT76pKgk42Y7Y6Cxpr+KWpxpARwSGSKbnTkSJ9bN2hc+LUeIhSmuVy7Xki8t2
 AgMkkuwVNgYr9STuSBm+k1CyjJoFwQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718783224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MM1iugd8w79JCzPPBwKJPlHbBy3O7tMAh9Dfmkw8B7g=;
 b=etSjCktR+qkGXrZa1bPcUGy5pk6B0UYQXKcInMGIUTOED4zkM7rfJ9kjVoxxdeve2661R1
 FS2KHZLsHUIeCoDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718783224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MM1iugd8w79JCzPPBwKJPlHbBy3O7tMAh9Dfmkw8B7g=;
 b=sE1OpRU+IZB8xuuu7lxX4oHAxfst9oBlMJclAIiT0CFUTz0vJVRbh3xabuwWIrj/4yqyMe
 Cxu/pmFIMVT76pKgk42Y7Y6Cxpr+KWpxpARwSGSKbnTkSJ9bN2hc+LUeIhSmuVy7Xki8t2
 AgMkkuwVNgYr9STuSBm+k1CyjJoFwQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718783224;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MM1iugd8w79JCzPPBwKJPlHbBy3O7tMAh9Dfmkw8B7g=;
 b=etSjCktR+qkGXrZa1bPcUGy5pk6B0UYQXKcInMGIUTOED4zkM7rfJ9kjVoxxdeve2661R1
 FS2KHZLsHUIeCoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59AAD13AC3;
 Wed, 19 Jun 2024 07:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pWS2FPiMcmYgDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 07:47:04 +0000
Date: Wed, 19 Jun 2024 09:47:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240619074703.GA410266@pevik>
References: <20240619073345.326108-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240619073345.326108-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Avoid buffer overflow when parsing
 /proc/cmdline
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

> When the test is run with a kernel booting with many parameters, the
> buffer size is often not large enough to store the complete command
> line. This results in a buffer overflow and the test complains with
> the following message:

>   tst_kconfig.c:609: TWARN: Buffer overflowed while parsing /proc/cmdline

Thanks for the fix!

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: 180834982 ("kconfig: add funtion to parse /proc/cmdline")

NOTE tst_kconfig_read() has char line[128], also struct tst_kcmdline_var member
has this length. The longest line on some on my systems is 109, it's still OK,
hopefully it stays :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
