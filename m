Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D994C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:05:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 882503C7C16
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:05:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70C323C7B35
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:05:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA801633C42
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:05:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC2261F38F;
 Fri, 17 Jan 2025 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737101100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEXVzi3DZpXR6V0yD4wHYGivF5yya4ojrNPwjr7W+sA=;
 b=omqJctPxcex6yBWcRyHDwBAq5UjEsntZcLz5cmeuwKUR1RONmFpi6sBKNzrjS9Wk/FjUpr
 CN8Fj6oA5fJy2BMXeyJ2Ploz6npFoyPgsPdXgn5hODZbFxM1TMOaQrpmV/LLuDfVt8DTMx
 OjhWfR4OpMwvlaOveHRGCDhtOWwUGh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737101100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEXVzi3DZpXR6V0yD4wHYGivF5yya4ojrNPwjr7W+sA=;
 b=aMFGKjc4My6HG1P6dHd0myZxq8uHd2UT4EYAyCAqusXVjHYPx+r9zbT660/tmWNIfibmD/
 Z48WD4fZjzZEz8Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2oIiQSt6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hAQ88n+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737101099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEXVzi3DZpXR6V0yD4wHYGivF5yya4ojrNPwjr7W+sA=;
 b=2oIiQSt61w65Hq+MfS7uK8IW554tbjQZQvqdst2ibIre8MWc0o985m4hq6feO+ez2wPj3Z
 6b/w45ZdNdIs/D8MKmMlatw6iY5pjw9DFVrwnsthauZu++u5c5o0ekrtRg3ItIlDN3gFbN
 KeQV6mvQBAnEmMCt7dyzW8zL6gAxBPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737101099;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEXVzi3DZpXR6V0yD4wHYGivF5yya4ojrNPwjr7W+sA=;
 b=hAQ88n+Wm1GFdMElkaj4S0Tu1eN8tZvzvG7trPpCDMnPI8hcaOlEoQFhxncKtu/qwStPuT
 udJC75FQNZl/rpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3C3B139CB;
 Fri, 17 Jan 2025 08:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fyp1KisPimeWKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 08:04:59 +0000
Date: Fri, 17 Jan 2025 09:04:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20250117080454.GD729073@pevik>
References: <20250117071758.120366-1-liwang@redhat.com>
 <20250117073607.GA731427@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117073607.GA731427@pevik>
X-Rspamd-Queue-Id: CC2261F38F
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: add TST_NO_SLOW_KCONFIG_CHECK macro for
 testcase tools
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

Hi Li,

> Hi Li,

> > The macro TST_NO_SLOW_KCONFIG_CHECK is added to control whether
> > the tst_has_slow_kconfig() function (which presumably checks for
> > slow kernel configurations) should be executed.

> That was quick, thanks a lot!

> But unfortunately the patch does not help to avoid printing TINFO
> (tested on a fresh clone):

> # make && ./tst_ns_exec 14536 net,mnt sh -c " cat /proc/sys/net/ipv6/conf/ltp_ns_veth1/disable_ipv6"
> CC testcases/lib/tst_ns_exec
> make[1]: Nothing to be done for 'all'.
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
> 0

> Maybe it's because safe_clone() triggers it? Or what am I missing?

The problem why it does not work is that it uses lib/tst_test.o via
lib/libltp.a, which was compiled without TST_NO_SLOW_KCONFIG_CHECK.

IMHO We cannot easily solve this with preprocessor definition.

Kind regards,
Petr

> Kind regards,
> Petr

> > This allows test cases and tools to opt out of this additional
> > check, enabling more flexible and faster test execution in
> > certain scenarios.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
