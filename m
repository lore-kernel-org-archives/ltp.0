Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C62CF58F4
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 08:59:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E2BE3C2FBF
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 10:59:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81E1D3C020C
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 10:59:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7987205CFE
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 10:59:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0B341F801;
 Fri, 20 Sep 2024 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726822756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dBqQKvGHZ2nNHRw15sldfuW7Mv7YbRbwbFQhfRHXPY=;
 b=Sn77kvDz8bzI9fKmgprXu40b4i0kXnl08+v8D1CCQPQamr1GoNw95nPhXFXow8S9yKwkCd
 z4Fpkv0hyMEmwbd6D4BhMtyvU0L7l1UGbwqxdFJ5RmeTWA5KWRPupGUHxEvlgCtCbqJTk/
 8Cts2rQ2hNBktBNZFn+biL7Md+IjvSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726822756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dBqQKvGHZ2nNHRw15sldfuW7Mv7YbRbwbFQhfRHXPY=;
 b=eqBs+Wy/p/+YgAija1i1p0wD+witpmpN0vRYqoz5YuXPqS+e/wzGXcAqldA2vQsB1Y9dPB
 TvFEix/CJ8tzMkAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726822756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dBqQKvGHZ2nNHRw15sldfuW7Mv7YbRbwbFQhfRHXPY=;
 b=Sn77kvDz8bzI9fKmgprXu40b4i0kXnl08+v8D1CCQPQamr1GoNw95nPhXFXow8S9yKwkCd
 z4Fpkv0hyMEmwbd6D4BhMtyvU0L7l1UGbwqxdFJ5RmeTWA5KWRPupGUHxEvlgCtCbqJTk/
 8Cts2rQ2hNBktBNZFn+biL7Md+IjvSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726822756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6dBqQKvGHZ2nNHRw15sldfuW7Mv7YbRbwbFQhfRHXPY=;
 b=eqBs+Wy/p/+YgAija1i1p0wD+witpmpN0vRYqoz5YuXPqS+e/wzGXcAqldA2vQsB1Y9dPB
 TvFEix/CJ8tzMkAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB4413AA7;
 Fri, 20 Sep 2024 08:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mo6ZJWQ57WYQagAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Sep 2024 08:59:16 +0000
Date: Fri, 20 Sep 2024 10:58:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Haifeng Xu <haifeng.xu@shopee.com>
Message-ID: <Zu05HskauxnYheRd@yuki.lan>
References: <20240920083036.87291-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240920083036.87291-1-haifeng.xu@shopee.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ht_affinity.c: fix ht_affinity test failure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The type of cpumask pointer used in set_affinity() is unsigned long, but
> ht_affinity used a unsigned int pointer. When kernel copy cpumask from
> user-space pointer, the high 32bit of cpumask is a random value. So the
> process can't be bind to the cpu specified by users.

Good catch, however it would be better if we used sizeof on the mask
instead of sizeof(unsigned long) in the sched_setaffinity() as well:

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
index f6e9f2745..3c2fe1bf1 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
@@ -67,7 +67,7 @@ int HT_SetAffinity(void)
                tst_resm(TINFO, "Set test process affinity.");
                printf("mask: %x\n", mask);

-               sched_setaffinity(pid, sizeof(unsigned long), &mask);
+               sched_setaffinity(pid, sizeof(mask), &mask);

                for (j = 0; j < 10; j++) {
                        for (k = 0; k < 10; k++) {
@@ -95,7 +95,7 @@ int HT_SetAffinity(void)
                tst_resm(TINFO, "Set test process affinity.");
                printf("mask: %x\n", mask);

-               sched_setaffinity(pid, sizeof(unsigned long), &mask);
+               sched_setaffinity(pid, sizeof(mask), &mask);

                for (j = 0; j < 10; j++) {
                        for (k = 0; k < 10; k++) {



Most of the code does that already which makes it impossible to pass
different size than the actual size.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
