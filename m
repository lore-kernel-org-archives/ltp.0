Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF4AC41535
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 13:08:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99A8E3CF2FB
	for <ltp@archiver.kernel.org>; Tue, 19 Dec 2023 14:08:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 616593CA76F
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 14:08:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 45ADD1A0BC55
 for <ltp@lists.linux.it>; Tue, 19 Dec 2023 14:08:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D798B21EF6;
 Tue, 19 Dec 2023 13:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702991284;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gl7VdkjQ4ThAaszNb6Q/bpS4uwjwXLLe3wtDW+5euzQ=;
 b=JldwIE5QGUiMQg+Zgfg2m2q4lB4CfDJOmGA8avuggx6nWzWQHjSDLWCVFdezvilGCqdG24
 byBxLUAgu089Hm7iUsTi3W5+8pRjz6REhvpnkdM1WuJnhdIL4r6PfafBUYSMWDGn3Eob2c
 jX2T6BYcvdVabpsJmSFhkOgp3qeTJqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702991284;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gl7VdkjQ4ThAaszNb6Q/bpS4uwjwXLLe3wtDW+5euzQ=;
 b=V5evf/937o3vlS4ptBjbrznSpjUc2mwmxvFrGYn4MHBHinKIalRIyJ+QPn2zx2BLxuL6FM
 cq/drcuS8emMI2Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702991283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gl7VdkjQ4ThAaszNb6Q/bpS4uwjwXLLe3wtDW+5euzQ=;
 b=RuAr4hY79ItRaEQhIi0tM9EXvP06cvhCvkcb1bgorDinZBXND+8cMlTRXbXCNmuuQlYIkC
 cZfbG63yhF8MdHWnordmVa/i2aanBuZvhpqbRUt98L6Ueo+enjCBHzhGkUrL4Pe0e2yDuK
 0X3fevbBXIdENhF/qWP1JkbL4WRcFqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702991283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gl7VdkjQ4ThAaszNb6Q/bpS4uwjwXLLe3wtDW+5euzQ=;
 b=Kv3dXLswh7JJYiHmKKHgSRLzVGu41lNNRwZ7pMbPCUKE4SXN/3tGIN3sQGPT+UgsdXrfbQ
 wUjB5PZDWxvqwPAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B13613B9B;
 Tue, 19 Dec 2023 13:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2DfIILOVgWVBZwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 19 Dec 2023 13:08:03 +0000
Date: Tue, 19 Dec 2023 14:08:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Martin Doucha <mdoucha@suse.cz>,
 Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20231219130801.GA341613@pevik>
References: <20231219123709.339435-1-pvorel@suse.cz>
 <20231219124942.GA340080@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231219124942.GA340080@pevik>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[bell-sw.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[20.51%];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RuAr4hY7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Kv3dXLsw
X-Rspamd-Queue-Id: D798B21EF6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Cc: Alexey Kodanev <akodanev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

[ Cc Alexey, see
https://lore.kernel.org/ltp/20231219123709.339435-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20231219123709.339435-1-pvorel@suse.cz/
]

> > Performance failures in tests which use tst_netload_compare() (tests in
> > runtest/net.features) can hide a real error (e.g. test fails due missing
> > required kernel module). Best solution would be to have feature tests
> > (likely written in C API) and performance tests (the current ones).

> > But until it happens, just disable performance failure by default,
> > print TINFO message instead unless TST_NET_FEATURES_TEST_PERFORMANCE=1
> > environment variable is set.

> NOTE: why is this enabled by default? IMHO it's more important to have feature
> tests than performance tests often failing and thus hiding feature test.
> Even introducing some LTP_TIMEOUT_MUL like variable would not help in case SUT
> performance differs (sometimes SUTs are ok, other time slow due QEMU host which
> runs SUTs is overbooked).

I knew there is some variable for performance tuning of network feature
tests: VIRT_PERF_THRESHOLD_MIN. But again, if the performance of the QEMU host
varies, the value must be set too high, which can hide the failure on broken
system which is idle. IMHO these tests should be run 2x - just feature tests
then with properly VIRT_PERF_THRESHOLD_MIN.

And, also VIRT_PERF_THRESHOLD_MIN is used only in virt_lib.sh, but
tst_netload_compare() which can fail due performance is used also in other
tests, e.g. sctp01.sh. That's why I think it's better to disable performance by
default.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
