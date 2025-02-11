Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4F9C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 17:27:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE6733C998C
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 18:27:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1127A3C995D
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 18:27:06 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5EF014465AF
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 18:27:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0BBA207DA;
 Tue, 11 Feb 2025 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739294420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMzP3UgJk6a6Vm2t2prvONcya68xl7JGEP1vtbnPyvw=;
 b=iuwuUGHw4Lqs47mvFDt3zWbyv+Sbeu0JZiiwaXfeSBWLD9dkpDRjvWg3+Pu2BBmMr14Ayo
 cF89EzcG9PpxTCrwlGdSqlp9pZ7/ROEXrhM4vFt0Du1JDfIffHwLJMC/mqqTt2ZkH7/aSG
 f8FuUOZx7GsIz1II6oGNGcqCA6NFEIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739294420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMzP3UgJk6a6Vm2t2prvONcya68xl7JGEP1vtbnPyvw=;
 b=fGp7icrHHvO7/ALPlXwB9vMvCnN58QXBwhdZYSAmHipTfORiqd9OWfglhgmqzc8gzSxU0W
 TVas8x94BRNgb5AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iuwuUGHw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fGp7icrH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739294420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMzP3UgJk6a6Vm2t2prvONcya68xl7JGEP1vtbnPyvw=;
 b=iuwuUGHw4Lqs47mvFDt3zWbyv+Sbeu0JZiiwaXfeSBWLD9dkpDRjvWg3+Pu2BBmMr14Ayo
 cF89EzcG9PpxTCrwlGdSqlp9pZ7/ROEXrhM4vFt0Du1JDfIffHwLJMC/mqqTt2ZkH7/aSG
 f8FuUOZx7GsIz1II6oGNGcqCA6NFEIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739294420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMzP3UgJk6a6Vm2t2prvONcya68xl7JGEP1vtbnPyvw=;
 b=fGp7icrHHvO7/ALPlXwB9vMvCnN58QXBwhdZYSAmHipTfORiqd9OWfglhgmqzc8gzSxU0W
 TVas8x94BRNgb5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88F9413782;
 Tue, 11 Feb 2025 17:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FpQxINSGq2c2CgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 17:20:20 +0000
Date: Tue, 11 Feb 2025 18:20:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250211172019.GA1906142@pevik>
References: <20250211032457.7396-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211032457.7396-1-liwang@redhat.com>
X-Rspamd-Queue-Id: B0BBA207DA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx07: Skip test if NFS server is never enabled
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
Cc: Martin Doucha <martin.doucha@suse.com>, Yongcheng Yang <yoyang@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

> The statx07 test requires an active NFS server, as it relies on
> exportfs, which reads from '/var/lib/nfs/etab'. By default, etab
> file does not exist unless the NFS server is started at least once
> (since new version nfs-utils-2.5.4-32.el9).

> This causing the test to fail when etab is missing:

>   tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
>   tst_buffers.c:57: TINFO: Test is using guarded buffers
>   exportfs: can't open /var/lib/nfs/etab for reading
>   statx07.c:136: TBROK: failed to exportfs

> This patch adds a check using access("/var/lib/nfs/etab", F_OK)
> before running the test. If the file does not exist, the test
> is skipped (TCONF) instead of failing, preventing misleading
> test failures.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Yongcheng Yang <yoyang@redhat.com>
> ---
>  testcases/kernel/syscalls/statx/statx07.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index 968174330..bc8e6fd65 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -115,6 +115,9 @@ static void setup(void)
>  	int ret;
>  	char server_path[BUFF_SIZE];

> +	if (access("/var/lib/nfs/etab", F_OK) < 0)
> +		tst_brk(TCONF, "nfs-server might not set up");

On Tumbleweed with nfs-client-2.8.1-44.2.x86_64:

# systemctl stop nfs-server.service
# ./statx07
...
tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
...
statx07.c:141: TCONF: nfs server not set up?: EOPNOTSUPP (95)

$ ls -la /var/lib/nfs/etab

The same behavior is on older systems (I checked SLE15-SP4 with 5.14 based
kernel and nfs-client-2.1.1).

There is a working detection. I wonder what is different on the system you test.
OTOH fortunately this patch would not break SLES/openSUSE (it would just not
help to detect), therefore I'm not against it.

Kind regards,
Petr

> +
>  	mode_t old_umask = umask(0);

>  	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
