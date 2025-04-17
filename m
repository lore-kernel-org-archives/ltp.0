Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B0C369B2
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 11:19:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5945A3CBA11
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 13:19:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A7C3CB124
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 13:19:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96979600BEF
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 13:19:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9023A1F391;
 Thu, 17 Apr 2025 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744888770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4ig/TFnzopwG51HDNHdItjyMrK/x+wUBQ9aiuS81ZM=;
 b=VvZ9A8ylRd8AnitJAktZQeKNjqmd1UAUlkMDBzeZIe+Y/j7V62AZ7KD/MiGh3Q08JutnGE
 qe7v0cq4q+++RdIhaAj+aOcGPc9iGqgpdKBs2eGgy7jkqSfbvXrF1fqbNCcERvtHWf/bd8
 MGe76r2l9+XGG/Sfvk8FNrUyyxDi3HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744888770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4ig/TFnzopwG51HDNHdItjyMrK/x+wUBQ9aiuS81ZM=;
 b=PKxLnpo6/M7Xq8Gca4qMPaA2EcP1oqJIC4ngdewQdbHgR4PnijKg5YE31ZY19035w42mtV
 N+6LEQw3H+w3dCDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ag2o27Mq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s5VjrnYP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744888769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4ig/TFnzopwG51HDNHdItjyMrK/x+wUBQ9aiuS81ZM=;
 b=ag2o27MqyqeMzzSnK398BzBRAnkoiZiOjUVdw+UdNWOIa8cPAHJWj8qgps5T2R+QMgaomO
 16NK5tWS9oTlIZNar4llEZdoPnT5OYgrzeas4L0JfmG0vDg51tggTed3wS1wi6l+Fmvhlx
 2Z/D6wikGsH8kqV6N2QAprdtJbhqDts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744888769;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4ig/TFnzopwG51HDNHdItjyMrK/x+wUBQ9aiuS81ZM=;
 b=s5VjrnYPSJAXKxJQkZdvwAiCvDCSdZt/RNA754r8MOOTlWXz3no2Ic4Ph8jMh70dtp8oW5
 fzcD1qbEr9c/PdAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825651388F;
 Thu, 17 Apr 2025 11:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iD9xH8HjAGjWGQAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 17 Apr 2025 11:19:29 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Jan Stancek <jstancek@redhat.com>
Date: Thu, 17 Apr 2025 13:19:29 +0200
Message-ID: <5020998.31r3eYUQgx@thinkpad>
In-Reply-To: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
References: <a2bdb9dc2d4160f11751053c4c047bb302d0c1a1.1744880683.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9023A1F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt10: handle explicit disallow
 of disconnect
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

Hi,

Tested-by: Avinesh Kumar <akumar@suse.de>


tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_setnqWwDi as tmpdir (tmpfs filesystem)
tst_test.c:1903: TINFO: LTP version: 20250130
tst_test.c:1907: TINFO: Tested kernel: 6.15.0-rc2-1.g2e8a181-default #1 SMP PREEMPT_DYNAMIC Sun Apr 13 20:38:27 UTC 2025 (2e8a181) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1720: TINFO: Overall timeout per run is 0h 02m 00s
setsockopt10.c:98: TINFO: child: Listen for tcp1 connection
setsockopt10.c:135: TINFO: parent: Connect for tcp0 connection
setsockopt10.c:147: TINFO: parent: Disconnect by setting unspec address
setsockopt10.c:151: TPASS: parent: tls disallows disconnect: EOPNOTSUPP (95)
setsockopt10.c:112: TINFO: child: connect for tcp2 connection
setsockopt10.c:116: TINFO: child: could not connect to tcp1: ECONNREFUSED (111)

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0


On Thursday, April 17, 2025 11:05:29 AM CEST Jan Stancek via ltp wrote:
> Since commit 5071a1e606b3 ("net: tls: explicitly disallow disconnect") in
> 6.15 kernel, disconnect is now explicitly disallowed.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/setsockopt/setsockopt10.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt10.c b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> index e52c6cd9338f..f955f4e83a44 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt10.c
> @@ -145,7 +145,16 @@ static void run(void)
>  	TST_CHECKPOINT_WAKE(1);
>  
>  	tst_res(TINFO, "parent: Disconnect by setting unspec address");
> -	SAFE_CONNECT(tcp1_sk, &unspec_addr, sizeof(unspec_addr));
> +	TEST(connect(tcp1_sk, &unspec_addr, sizeof(unspec_addr)));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_res(TPASS | TTERRNO, "parent: tls disallows disconnect");
> +		else
> +			tst_res(TFAIL | TTERRNO, "parent: unexpected errno from connect");
> +		TST_CHECKPOINT_WAKE(2);
> +		tst_reap_children();
> +		return;
> +	}
>  	SAFE_BIND(tcp1_sk, (struct sockaddr *)&tcp1_addr, sizeof(tcp1_addr));
>  
>  	TEST(listen(tcp1_sk, 1));
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
