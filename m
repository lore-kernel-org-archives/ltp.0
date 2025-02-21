Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C077C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:39:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF4A93C8EE9
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:39:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EF813C0549
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:39:33 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20A30140BE78
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:39:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54F55211C4;
 Fri, 21 Feb 2025 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0tHownZeSXFaRl8jOf0lzeWS4LT0msCd0ENnMsqXOw=;
 b=ca0P44Ka93+ewXZQCgcE8ed8mS5Jus/HWrcoCZzf/3QeZs3hTFB9MwAXuW+tMiBVz80/AS
 qGFx0WOwqR7D+VZsCPwH+BCPRWbIiWHadvbizb4A/ch9KAMJGKuVafEDxs/s4wnxMmSVyH
 MGJxHScsLSmAqOAOa94EjzRONcz/bkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0tHownZeSXFaRl8jOf0lzeWS4LT0msCd0ENnMsqXOw=;
 b=0xKjoUjvrBFpNeinWvXpaJHEwViYEPYW0R795GqL2RB//CIO06Gp54JCtGZZng0GFFhdGv
 6J4pegnYub9TYLBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ca0P44Ka;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0xKjoUjv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740134369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0tHownZeSXFaRl8jOf0lzeWS4LT0msCd0ENnMsqXOw=;
 b=ca0P44Ka93+ewXZQCgcE8ed8mS5Jus/HWrcoCZzf/3QeZs3hTFB9MwAXuW+tMiBVz80/AS
 qGFx0WOwqR7D+VZsCPwH+BCPRWbIiWHadvbizb4A/ch9KAMJGKuVafEDxs/s4wnxMmSVyH
 MGJxHScsLSmAqOAOa94EjzRONcz/bkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740134369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0tHownZeSXFaRl8jOf0lzeWS4LT0msCd0ENnMsqXOw=;
 b=0xKjoUjvrBFpNeinWvXpaJHEwViYEPYW0R795GqL2RB//CIO06Gp54JCtGZZng0GFFhdGv
 6J4pegnYub9TYLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43C8C13806;
 Fri, 21 Feb 2025 10:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2IvRD+FXuGdpPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Feb 2025 10:39:29 +0000
Date: Fri, 21 Feb 2025 11:39:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <ricardo@marliere.net>
Message-ID: <Z7hX6iJN6hDSUgUZ@yuki.lan>
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
 <20250218-conversions-pause-v2-2-8c72960fe1ec@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250218-conversions-pause-v2-2-8c72960fe1ec@suse.com>
X-Rspamd-Queue-Id: 54F55211C4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] syscalls/pause02: Refactor into new API
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
Cc: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
This is the same as pause01.c there is no point in having two tests that
do the same.

So rather than rewriting this test we should add a check to the
pause01.c that the process resumed after the signal. Which should be as
easy as:

diff --git a/testcases/kernel/syscalls/pause/pause01.c b/testcases/kernel/syscalls/pause/pause01.c
index adce0ddcf..74a7e514e 100644
--- a/testcases/kernel/syscalls/pause/pause01.c
+++ b/testcases/kernel/syscalls/pause/pause01.c
@@ -20,6 +20,8 @@ static void do_child(void)
        SAFE_SIGNAL(SIGINT, sig_handler);
        TST_EXP_FAIL(pause(), EINTR);
        TST_CHECKPOINT_WAKE(0);
+
+       tst_res(TPASS, "Process resumed from pause()");
 }


And it would also make sense to add more coverage to pause01 in a
subsequent patch. Currently it tests only a single signal, we should
iterate over all signals instead (minus the SIGKILL that is covered by
pause03).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
