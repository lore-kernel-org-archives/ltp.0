Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB392C41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 12:50:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905633CF30B
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 13:50:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C32E3CD832
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 13:49:50 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0596B1400FA5
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 13:49:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A9201FD54;
 Tue, 19 Dec 2023 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702990188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8i3Q9Y06RSM1sMHXMM2xFD7Sj861shGCoWh9aHSUjzM=;
 b=2uAnl+I7dUCYFavXXapu3iwGBgnbjYg8UNUvl/zlMMiyzyfGjbi+rg+Jby4QIcSIzurlHk
 41yG9Lvusd8q2kdm3vc6CFmsXShmflYQ1XXm8NIGFjDGYvWi/KJ0RNkk6rtS/Ko0E7+zcN
 H44AkI281fRSrMGBIIBiHS/1a8dn3Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702990188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8i3Q9Y06RSM1sMHXMM2xFD7Sj861shGCoWh9aHSUjzM=;
 b=aYqDlfNcP84B/COMQ6CeAgAf5s6uTnEFvbH4Lba5XfRwopKAkfwwVCwlzqyo8Tg8JVuFsE
 X07TnjBrpbi7XzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702990188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8i3Q9Y06RSM1sMHXMM2xFD7Sj861shGCoWh9aHSUjzM=;
 b=2uAnl+I7dUCYFavXXapu3iwGBgnbjYg8UNUvl/zlMMiyzyfGjbi+rg+Jby4QIcSIzurlHk
 41yG9Lvusd8q2kdm3vc6CFmsXShmflYQ1XXm8NIGFjDGYvWi/KJ0RNkk6rtS/Ko0E7+zcN
 H44AkI281fRSrMGBIIBiHS/1a8dn3Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702990188;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8i3Q9Y06RSM1sMHXMM2xFD7Sj861shGCoWh9aHSUjzM=;
 b=aYqDlfNcP84B/COMQ6CeAgAf5s6uTnEFvbH4Lba5XfRwopKAkfwwVCwlzqyo8Tg8JVuFsE
 X07TnjBrpbi7XzCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3617B13BF1;
 Tue, 19 Dec 2023 12:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id NCBfC2yRgWUtYwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 19 Dec 2023 12:49:48 +0000
Date: Tue, 19 Dec 2023 13:49:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20231219124942.GA340080@pevik>
References: <20231219123709.339435-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231219123709.339435-1-pvorel@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.12%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2uAnl+I7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aYqDlfNc
X-Rspamd-Queue-Id: 7A9201FD54
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] net: tst_netload_compare(): Ignore
 performance failures
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Performance failures in tests which use tst_netload_compare() (tests in
> runtest/net.features) can hide a real error (e.g. test fails due missing
> required kernel module). Best solution would be to have feature tests
> (likely written in C API) and performance tests (the current ones).

> But until it happens, just disable performance failure by default,
> print TINFO message instead unless TST_NET_FEATURES_TEST_PERFORMANCE=1
> environment variable is set.

NOTE: why is this enabled by default? IMHO it's more important to have feature
tests than performance tests often failing and thus hiding feature test.
Even introducing some LTP_TIMEOUT_MUL like variable would not help in case SUT
performance differs (sometimes SUTs are ok, other time slow due QEMU host which
runs SUTs is overbooked).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
