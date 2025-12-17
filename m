Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CBDD65C69
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 15:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DF1B3D040A
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 16:47:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23F53D03CC
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 16:46:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3BE96008FD
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 16:46:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31DA633686;
 Wed, 17 Dec 2025 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765986397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
 b=a+i2JoLztiFCJaRiuUl29R7w7UelOmIePq5WagRmkt2XRgf9Gsuw89AImDkj2FDY0RkVQK
 T9TRFkjzKrgEIWi3d3Fquz3/j0mT6PfAlK0dIGNRw1hRWa76eRyTrcA82wHGeGCO1QnU5I
 0f30mW1Xm4BnSRJo+Rr5mswnUuF9Gww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765986397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
 b=JgsRy1M2r3o3ROCqqCPNZKTdryRXCLsFMm76xQQh8qbVg5WCY4EJiESLiJfSCS9IUmasVv
 nOtphHpIWOfWstDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KT8gk5mA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ATQNsNPp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765986396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
 b=KT8gk5mA/bfhPQ059BU8oZYJdbdYiA0bEvoXJzzwgsob8EdMZL5/yMBfjHCt6PRcJ9C6b8
 5GHYyyDOwrl0O1gO238n5lWMjeK9KfIAXwmPf2rOWQKyFrxmmXXDWc6NvYyQkKagqyrooX
 DiYrTTMD9GaB+CcDZeikhBhdVoHHBBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765986396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMZ2O2fyT/znNNwgOvA9pVOn615YNM2PB2mf71SiOBI=;
 b=ATQNsNPpcobfkQy2gXDi8BinwbqcAkAelK1tefZnGUY97Si6XLaAQKxQDewEDeAn+x+dHu
 SQYkJm3oFIDZXGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 207333EA63;
 Wed, 17 Dec 2025 15:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dDw2BVzQQmmmVAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Dec 2025 15:46:36 +0000
Date: Wed, 17 Dec 2025 16:47:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aULQlhbHltLTbdG4@yuki.lan>
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209185557.20598-3-pvorel@suse.cz>
X-Rspamd-Queue-Id: 31DA633686
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] tst_test.sh: Add TST_USR_{G, U}ID variables
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Add TST_USR_{G,U}ID variables with the default values from tst_runas.c.
> 
> These can be used as a default values for tests which use tst_runas and
> need to know UID/GID for other commands.
> 
> It will be used in LTP IMA tests.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_runas.c | 1 +
>  testcases/lib/tst_test.sh | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/tst_runas.c b/testcases/lib/tst_runas.c
> index e8d5d8dd9d..e937828273 100644
> --- a/testcases/lib/tst_runas.c
> +++ b/testcases/lib/tst_runas.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
>   */
>  
> +/* update also tst_test.sh */
>  #define LTP_USR_UID 65534
>  #define LTP_USR_GID 65534
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 4be10a4f94..26e6a86dcb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -17,6 +17,10 @@ export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
>  export TST_LIB_LOADED=1
>  
> +# see testcases/lib/tst_runas.c
> +export TST_USR_UID="${LTP_USR_UID:-65534}"
> +export TST_USR_GID="${LTP_USR_GID:-65534}"

Do we need this? We already have the default values in the C code...

>  . tst_ansi_color.sh
>  . tst_security.sh
>  
> @@ -689,7 +693,7 @@ tst_run()
>  			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
>  			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
>  			SKIP_FILESYSTEMS|SKIP_IN_LOCKDOWN|SKIP_IN_SECUREBOOT);;
> -			DEVICE_SIZE);;
> +			DEVICE_SIZE|USR_UID|USR_GID);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
>  		done
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
