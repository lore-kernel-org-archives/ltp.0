Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288FCC47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 16:01:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691B33CE32C
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 17:01:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA8FA3C88E1
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:01:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 17DC314016ED
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 17:01:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F18422201D;
 Wed, 17 Jan 2024 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705507285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6LQT3EAX10Xbl98egXwyCPpiHM9+YKBkqXHI5d0xKg=;
 b=3NA7NVG7SNjHjaIOqj+uNGy4H/WnpxHb4JlcHRCQyW2lEw0sspNx/Xu92BUmOaP/rNKCvG
 Cg/jVEPzSS7kW7M+IwtY05qoFwI6yPG7uON3f0CU31sV7oAQEEe5tmvzCDG8jVvM54h+uN
 2KvC5bJGPSydFRTFYcf0jkHvzgCdIH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705507285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6LQT3EAX10Xbl98egXwyCPpiHM9+YKBkqXHI5d0xKg=;
 b=FHUpMPMBMm4XsqDk1RmHn9RD3UuZ5kbqtP0mrzhkQGvqkkiJniNyN2V3AONBNgme5t5uBi
 pBE+chWFYO9asXDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705507284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6LQT3EAX10Xbl98egXwyCPpiHM9+YKBkqXHI5d0xKg=;
 b=CMOUoH71QSm3v+LC7eNSdtfrGmJnHEU1oZJ3hBM9k+dQkFiVSPz5kBakFMJNGuKiZHajqm
 /epzAGuxKvn4W+GDzo6sJI9+DE24LhFpSGCFNpZ1oHg++4jJf12HKi6K31346fydlJ8mTK
 AUbA2SGnvQVAv8fYZb94Uv5vi9rxxVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705507284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6LQT3EAX10Xbl98egXwyCPpiHM9+YKBkqXHI5d0xKg=;
 b=tiL1z4T1ifkxYncFZ+q7Z9T+MtxpRu9Vy3upIBlRcS7R9BAps+eX8u6RBQXW2EpaiuiWuf
 umriTPR9ih1KdECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD1FE13751;
 Wed, 17 Jan 2024 16:01:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fQn+NNT5p2WZJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jan 2024 16:01:24 +0000
Date: Wed, 17 Jan 2024 17:01:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zaf53YElGwHq04Sl@yuki>
References: <20240111150553.1923767-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240111150553.1923767-1-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CMOUoH71;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tiL1z4T1
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F18422201D
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] safe_macros: Fix bcachefs failure old kernel
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I'm sorry, although man bcachefs(8) mentions fusemount, I haven't
> figured out how to mount filesystem. Am I missing something?
> 
> Also, maybe for the start I would prefer to to test just kernel
> functionality (no fuse).
 
So this means that mount.bcasefs does exist, but the mount() fails? That
sounds like something wasn't wired up properly.

> Kind regards,
> Petr
> 
>  lib/tst_supported_fs_types.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 369836717..21765c370 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -96,6 +96,11 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)
>  
>  	SAFE_RMDIR(template);
>  
> +	if (!strcmp(fs_type, "bcachefs") && tst_kvercmp(6, 7, 0) < 0) {
> +		tst_res(TINFO, "bcachefs skipped on kernel < 6.7");
> +		return TST_FS_UNSUPPORTED;
> +	}

I would rather turn this into a FUSE specific blacklist without a kernel
version, since bcachefs got into the kernel I do not think the fuse
version would be useful for testhing at all, so what about:

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 369836717..4110c826e 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -33,6 +33,11 @@ static const char *const fs_type_whitelist[] = {
        NULL
 };

+static const cahr *const fs_type_fuse_blacklist[] = {
+       "bcachefs",
+       NULL,
+};
+
 static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];

 static int has_mkfs(const char *fs_type)
@@ -96,6 +101,11 @@ static enum tst_fs_impl has_kernel_support(const char *fs_type)

        SAFE_RMDIR(template);

+       if (tst_fs_in_skiplist(fs_type, tst_fs_type_fuse_blacklist)) {
+               tst_res("Skipping %s because of FUSE blacklist", fs_type);
+               return TST_FS_UNSUPPORTED;
+       }
+
        /* Is FUSE supported by kernel? */
        if (fuse_supported == -1) {
                ret = open("/dev/fuse", O_RDWR);


>  	/* Is FUSE supported by kernel? */
>  	if (fuse_supported == -1) {
>  		ret = open("/dev/fuse", O_RDWR);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
