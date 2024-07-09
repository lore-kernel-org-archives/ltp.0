Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AFFC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 11:06:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A0933D3942
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 13:06:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37D213D3905
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:06:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5441D1400C6D
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 13:05:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFFB221B95;
 Tue,  9 Jul 2024 11:05:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3F81396E;
 Tue,  9 Jul 2024 11:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QbPFKJYZjWbmWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jul 2024 11:05:58 +0000
Date: Tue, 9 Jul 2024 13:05:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zo0ZiWT01NFENPaz@yuki>
References: <20240709103324.183993-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240709103324.183993-1-pvorel@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CFFB221B95
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test: Fix tests using device without
 .filesystems
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
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b49c248ae..6d258cd28 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1355,8 +1355,11 @@ static void do_setup(int argc, char *argv[])
>  
>  		tdev.fs_type = default_fs_type();
>  
> -		if (!tst_test->all_filesystems && count_fs_descs() == 1)
> -			prepare_device(&tst_test->filesystems[0]);
> +		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
> +			prepare_device(tst_test->filesystems ?
> +				       &tst_test->filesystems[0] :
> +				       &(struct tst_fs){.type = tdev.fs_type});

Another option would be to change prepare_device() so that it works fine
with NULL tst_fs pointer, then we could simply do:

	prepare_device(tst_test->filesystems);


And for that we would have to do something like this:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b49c248ae..ec6deea9b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1101,6 +1101,9 @@ static void prepare_device(struct tst_fs *fs)
 {
        const char *mnt_data;
        char buf[1024];
+       struct tst_fs dummy = {};
+
+       fs = fs ? &dummy : fs;
 
        const char *const extra[] = {fs->mkfs_size_opt, NULL};


> +		}
>  	}
>  
>  	if (tst_test->needs_overlay && !tst_test->mount_device)
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
