Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB9CD729E9
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 16:19:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38CCE3DC1BB
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 17:19:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDB913DBE8B
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 17:19:41 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22F7A228F31
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 17:19:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2D6321178;
 Fri, 29 Nov 2024 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732897179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfy5g40GH9+U+9FlmFhWQuFRt9lumm5bYadD4cV3ICQ=;
 b=HUoIrcXzFPeV2lFTQh1DrhlSIxDeRs+fvr3IJQp3YWMZzXfUV56xpCPM2YQq9fO19tm663
 uSEYwNVIjHHe4aEpKC+cRHetCmCK3+eYlY2PYaR+YhyDah9llks2XFDPOGq2nf/1JkLq7C
 OkmFbE24flABmjIGUWFo9Xdu735VBJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732897179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfy5g40GH9+U+9FlmFhWQuFRt9lumm5bYadD4cV3ICQ=;
 b=mA8wW3mSiiuQeFw+59yOq2pZM5M5WMLFmt12U0rVTVc/GvDWUh1LytLoUOGYYY9aZrULYF
 zdHI2OHW4xL/YPDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HUoIrcXz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mA8wW3mS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732897179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfy5g40GH9+U+9FlmFhWQuFRt9lumm5bYadD4cV3ICQ=;
 b=HUoIrcXzFPeV2lFTQh1DrhlSIxDeRs+fvr3IJQp3YWMZzXfUV56xpCPM2YQq9fO19tm663
 uSEYwNVIjHHe4aEpKC+cRHetCmCK3+eYlY2PYaR+YhyDah9llks2XFDPOGq2nf/1JkLq7C
 OkmFbE24flABmjIGUWFo9Xdu735VBJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732897179;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfy5g40GH9+U+9FlmFhWQuFRt9lumm5bYadD4cV3ICQ=;
 b=mA8wW3mSiiuQeFw+59yOq2pZM5M5WMLFmt12U0rVTVc/GvDWUh1LytLoUOGYYY9aZrULYF
 zdHI2OHW4xL/YPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1F43133F3;
 Fri, 29 Nov 2024 16:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v4slK5vpSWfBVwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 29 Nov 2024 16:19:39 +0000
Date: Fri, 29 Nov 2024 17:19:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: YouZhi Zhao <zhaoyouzhi@uniontech.com>
Message-ID: <Z0npoHIBPCnx0dYw@yuki.lan>
References: <027453D6AD3FFC61+20240830071101.754457-1-zhaoyouzhi@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <027453D6AD3FFC61+20240830071101.754457-1-zhaoyouzhi@uniontech.com>
X-Rspamd-Queue-Id: C2D6321178
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsmount: add coverage for fsmount01.c
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
> +static void verify_mount_readonly(void)
> +{
> +        int fd;
> +
> +        fd = open(TEST_FILE, O_WRONLY | O_CREAT, 0644);
> +        if (fd == -1) {
> +                if (errno == EROFS) {
> +                        tst_res(TPASS, "MOUNT_ATTR_RDONLY verified: Cannot create file, filesystem is read-only.");
> +                } else {
> +                        tst_res(TFAIL | TTERRNO, "Failed to create file for unknown reason.");
> +                }
> +        } else {
> +                tst_res(TFAIL, "MOUNT_ATTR_RDONLY verification failed: File created on supposed read-only filesystem.");
> +                close(fd);
> +                unlink(TEST_FILE);
> +        }

This could be just single TST_EXP_FAIL().

> +}
> +
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> @@ -81,10 +100,14 @@ static void run(unsigned int n)
>  		return;
>  	}
> 
> -	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
> -		SAFE_UMOUNT(MNTPOINT);
> -		tst_res(TPASS, "%s: fsmount() passed", tc->name);
> -	}
> +        if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
> +                if (tc->attrs & MOUNT_ATTR_RDONLY) {
> +                        verify_mount_readonly();
> +                } else {
> +                        tst_res(TPASS, "%s: fsmount() passed", tc->name);
> +                }
> +                SAFE_UMOUNT(MNTPOINT);
> +        }

Instead of this hackery we can add a pointer to a verify function to the
struct tcase and execute the function if it was set. Then we can
possibly implement the verify function for more flags. E.g. expect that
mknod() fails on FS mounted with NODEV.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
