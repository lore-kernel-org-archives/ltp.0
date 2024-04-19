Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109EEC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 13:40:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F3143CFD87
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 15:40:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C345A3CFD6F
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:40:11 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8136101544C
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 15:40:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04C195C31E;
 Fri, 19 Apr 2024 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713534009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieRYYWh6zP/MBkarp1bcHbWcc7V62qkIBBPbCaXajiM=;
 b=rsp2pbZ2OsCjr0McBrbR1pbd0sbwNqllhopu+deiQ37sbfNPBUAKB+KMy8k+6I6zWZ0sv8
 xuFKvsKJxbrRUM2Z9cH2dmMmRT3RnWOBH97DX1c5p/OsPwuRATqzoAR/nkSfU9y6Gjrnbr
 lqspJYhkz4glHXzWAgUXEL3Qv332Scs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713534009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieRYYWh6zP/MBkarp1bcHbWcc7V62qkIBBPbCaXajiM=;
 b=1LlrTNI8TTLLWEMDLt14THyUFtK33auma0kZ5G3FOJUuQgakPuy66fjXG6XYfQfkzP6mIE
 3NnK5x6TQcRlXTBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713534009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieRYYWh6zP/MBkarp1bcHbWcc7V62qkIBBPbCaXajiM=;
 b=rsp2pbZ2OsCjr0McBrbR1pbd0sbwNqllhopu+deiQ37sbfNPBUAKB+KMy8k+6I6zWZ0sv8
 xuFKvsKJxbrRUM2Z9cH2dmMmRT3RnWOBH97DX1c5p/OsPwuRATqzoAR/nkSfU9y6Gjrnbr
 lqspJYhkz4glHXzWAgUXEL3Qv332Scs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713534009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ieRYYWh6zP/MBkarp1bcHbWcc7V62qkIBBPbCaXajiM=;
 b=1LlrTNI8TTLLWEMDLt14THyUFtK33auma0kZ5G3FOJUuQgakPuy66fjXG6XYfQfkzP6mIE
 3NnK5x6TQcRlXTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB63E136CF;
 Fri, 19 Apr 2024 13:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UawVNDh0ImZgWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Apr 2024 13:40:08 +0000
Date: Fri, 19 Apr 2024 15:39:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
Message-ID: <ZiJ0CkYTHgk3FhRP@yuki>
References: <70e4ec51-fc24-4e56-a7b3-58aec44643de@gmail.com>
 <20240115133400.2431-1-subramanya.swamy.linux@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240115133400.2431-1-subramanya.swamy.linux@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] read_all :catch alignment faults while reading
 sys entries seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc
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
> ---
>  testcases/kernel/fs/read_all/read_all.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
> index ddc48edd8..e87f47979 100644
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -251,17 +251,11 @@ static void read_test(const int worker, const char *const path)
>  	worker_heartbeat(worker);
>  	/*
>  	 * This could catch any alignment faults while reading sys entries
> -	 * seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc so reading 1024 bytes
> -	 * in chunks of 8 bytes 128 times
> +	 * seen in commit :1bbc21785b7336619fb6a67f1fff5afdaf229acc

The commit id should go into tags.

>  	 */
>  	char check_buf[7];
> -	unsigned int i;
>  
> -	for (i = 0; i < 128; i++) {
> -		count = read(fd, check_buf, sizeof(check_buf));
> -		if (count == 0 || count < 0)
> -			break;
> -	}
> +	count = pread(fd, check_buf, sizeof(check_buf), 1);
>  
>  	count = pread(fd, buf, sizeof(buf) - 1, 0);
>  	elapsed = worker_elapsed(worker);

This is a patch on a top of a patch that does not apply...


What about this change? That should enough to trigger the problem:

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 266678ea7..86fc6fb61 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -228,6 +228,7 @@ static int worker_ttl(const int worker)
 static void read_test(const int worker, const char *const path)
 {
        char buf[BUFFER_SIZE];
+       char odd_buff[7];
        int fd;
        ssize_t count;
        const pid_t pid = workers[worker].pid;
@@ -250,6 +251,8 @@ static void read_test(const int worker, const char *const path)
 
        worker_heartbeat(worker);
        count = read(fd, buf, sizeof(buf) - 1);
+       /* read at odd offset triggers bug fixed by 1bbc21785b73 */
+       pread(fd, odd_buf, sizeof(odd_buf), 1);
        elapsed = worker_elapsed(worker);
 
        if (count > 0 && verbose) {
@@ -714,4 +717,8 @@ static struct tst_test test = {
        .test_all = run,
        .forks_child = 1,
        .max_runtime = 100,
+       .tags = (const struct tst_tag[]) {
+               {"linux-git", "1bbc21785b73"},
+               {}
+       }
 };


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
