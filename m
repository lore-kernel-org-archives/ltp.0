Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB83D78321
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:59:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0C0A3C0E0F
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:59:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67B603DD2F5
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:59:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C56FE2187A2
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 14:59:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7601F444;
 Mon,  2 Dec 2024 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
 b=JV/19aWzZZK2hczwTFG/XvFTBpcW08BjmLlV/0wpgl4528yNzS0HcFXzowQgwr3zeLrQuj
 bmTOIIcYA5FZv4xhndn+Yr2y2K6tOsuyT7QYLdU97LicUxCDFdP+N7NwPNj0jaEJdmd982
 dW+VAXiSHS+K7IBjZkR/9OnOrdJdedU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
 b=wvxVqZzvLttAe1vFOSwOtUBqYpmFrZJu7UZUF6Q4u7F/IdLOwtyAuX4Ee1xZ4hJ70IisYc
 4nRVM9NQIHDWUmAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JV/19aWz";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wvxVqZzv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733147965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
 b=JV/19aWzZZK2hczwTFG/XvFTBpcW08BjmLlV/0wpgl4528yNzS0HcFXzowQgwr3zeLrQuj
 bmTOIIcYA5FZv4xhndn+Yr2y2K6tOsuyT7QYLdU97LicUxCDFdP+N7NwPNj0jaEJdmd982
 dW+VAXiSHS+K7IBjZkR/9OnOrdJdedU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733147965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0BkgzYNYxQpPld+PO7MTw3f/5O7xgSxmea3rclKdaiQ=;
 b=wvxVqZzvLttAe1vFOSwOtUBqYpmFrZJu7UZUF6Q4u7F/IdLOwtyAuX4Ee1xZ4hJ70IisYc
 4nRVM9NQIHDWUmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D00B13A31;
 Mon,  2 Dec 2024 13:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FAgIBj29TWdoFQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Dec 2024 13:59:25 +0000
Date: Mon, 2 Dec 2024 14:59:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <Z029S0wgjrsv9qHL@yuki.lan>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z02337yqxrfeZxIn@yuki.lan>
X-Rspamd-Queue-Id: 2C7601F444
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The code to skip filesystems in the case of all filesystems is in the
> run_tcase_per_fs() function:
> 
> static int run_tcases_per_fs(void)
> {
>         int ret = 0;
>         unsigned int i;
>         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
> 
> The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> function which filters out them.

Perhaps you mean that the skiplist does not work with .all_filesystems
_and_ the LTP_SINGLE_FS_TYPE environment variable?

I guess that we need:

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19..49b1d7205 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

        if (only_fs) {
                tst_res(TINFO, "WARNING: testing only %s", only_fs);
+
+               if (tst_fs_in_skiplist(only_fs, skiplist))
+                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
+
                if (tst_fs_is_supported(only_fs))
                        fs_types[0] = only_fs;
                return fs_types;


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
