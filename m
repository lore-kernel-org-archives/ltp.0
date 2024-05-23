Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E265BC25B7C
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:56:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EF5A3D01AB
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 17:56:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AEC13D01A3
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:55:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 42FD660011E
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:55:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACB132293E
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479754; h=from:from:reply-to:date:date:message-id:message-id:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1Qq1LJa5pog0mycEIAC0K/4V0nlHpZV+ltp1T6pwgQ=;
 b=KQ9/yGo7brNK559dvTFmVwczPkWDk3OL/lGXCtICSuxFA1DgCwRJ0bpTqnEW43JJyA1zA3
 xRRaIzKiN0y9e66keWoOMtnwqnzp2HZbEBV2pWirXpMkozgbvTy5i8NNkDN3jjIECGoGZK
 jJH+f2gYqEwMufqWuK7SwGOFhVgdL0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479754;
 h=from:from:reply-to:date:date:message-id:message-id:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1Qq1LJa5pog0mycEIAC0K/4V0nlHpZV+ltp1T6pwgQ=;
 b=i3OLqfCC1mwdTtKXUwEhy/2v1ezOw0FgXm6pgfdfrbdSvFM+OY8WWYXv9T6QM0L+mzYWtm
 yLKixPqGlRBK3IAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="KQ9/yGo7";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i3OLqfCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479754; h=from:from:reply-to:date:date:message-id:message-id:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1Qq1LJa5pog0mycEIAC0K/4V0nlHpZV+ltp1T6pwgQ=;
 b=KQ9/yGo7brNK559dvTFmVwczPkWDk3OL/lGXCtICSuxFA1DgCwRJ0bpTqnEW43JJyA1zA3
 xRRaIzKiN0y9e66keWoOMtnwqnzp2HZbEBV2pWirXpMkozgbvTy5i8NNkDN3jjIECGoGZK
 jJH+f2gYqEwMufqWuK7SwGOFhVgdL0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479754;
 h=from:from:reply-to:date:date:message-id:message-id:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s1Qq1LJa5pog0mycEIAC0K/4V0nlHpZV+ltp1T6pwgQ=;
 b=i3OLqfCC1mwdTtKXUwEhy/2v1ezOw0FgXm6pgfdfrbdSvFM+OY8WWYXv9T6QM0L+mzYWtm
 yLKixPqGlRBK3IAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8052113A6C
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qZRBHgpnT2ZeIwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:55:54 +0000
Date: Thu, 23 May 2024 17:55:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it
Message-ID: <Zk9nAjk6uqaN45HK@yuki>
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
 <20240523154113.GB18111@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523154113.GB18111@pevik>
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MISSING_TO(2.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ACB132293E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> BTW I have found problem on Alpine:
> 
> tst_pid.c:84: TINFO: Cannot read session user limits from '/sys/fs/cgroup/user.slice/user-1000.slice/pids.max'
> tst_pid.c:84: TINFO: Cannot read session user limits from '/sys/fs/cgroup/pids/user.slice/user-1000.slice/pids.max'
> msgstress01.c:269: TINFO: Available messages slots: 5530
> msgstress01.c:164: TFAIL: Received wrong data at index 99: ffffffa3 != 19
> 
> It looks to me it's not related to using busybox init system (e.g. IMHO not
> related to the Cannot read session user limits, but I can be wrong).
> Anyway, this is for sure not a blocker for the release (and probably wait for
> LTP musl users).

So looks like we are using wrong message size for the message buffer.

We are using size returned from the msgrcv() that returns the size of
the payload but the payload looks like:

struct {
	char len;
	char pbytes[99];
} data;

This means that the size returned from msgrcv() is one more byte longer
than the pbytes array.

Quick fix would be:

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 5c84957b3..b0d945a11 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -131,7 +131,7 @@ static void reader(const int id, const int pos)
                        return;
                }

-               for (int i = 0; i < size; i++) {
+               for (int i = 0; i < msg_recv.data.len; i++) {
                        if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
                                tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
                                        msg_recv.data.pbytes[i],


Better fix would remove the len from the sysv_msg structure and use the
size only, but I would go for the easy fix before the release and
do cleanup later on. I will send a proper patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
