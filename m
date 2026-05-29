Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B615CD6E49
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 16:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 410833E76A4
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 18:31:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF8653C66B2
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:31:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59888200B71
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:31:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5038673A6;
 Fri, 29 May 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780072271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHh2ip1UfiTNW/2bfRF7My8g4TermFo560fXXYijVVQ=;
 b=iMm2JkUF8VA407Tq8osD99fUvgMg2ao2IHT6H0GhMhJIhlIbigTCQk9jcAd5ay2T5YU4Tn
 XbzWaUreZcTg6Z1vwvXpd+TEzIBhMRB72WyFzyc7AGtocSCQMBC7mEVuF54lgE+1f2QATI
 mvlPULWvt++gfJyfmvXLRL9cOaFalKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780072271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHh2ip1UfiTNW/2bfRF7My8g4TermFo560fXXYijVVQ=;
 b=NXr1VgZGOY7mNqwDpAcPPYjYCU8mNfXdQ6hDT52jf77ZoWN2bqLW+BCDRJW/kbv6WNJR1M
 pLG1tuDba9jJL/BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Or5ZlRu5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x4HffKho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780072269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHh2ip1UfiTNW/2bfRF7My8g4TermFo560fXXYijVVQ=;
 b=Or5ZlRu5l9oXj1KyO3TPUPNs7D6MarIx/TlnNYcZz18mJ5xjceGzfGR2AxJIidwpOo3bOk
 s3I2xdXB0toj2/I/eSqxalZANzdRACRzi4BJ8dpb98g94USCmla40iR+SKYpZyK5szO1FB
 mSuiTAOv5J8bVqWCoCjmYXlOwFD6jbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780072269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHh2ip1UfiTNW/2bfRF7My8g4TermFo560fXXYijVVQ=;
 b=x4HffKhoIp1uMd9eezNflY6aMMuWGUC0l3io/+LH4vydnT+G6gABv4hRsVmaQaXuYyU6Sy
 WPSxAdRam+gy/VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87687779A7;
 Fri, 29 May 2026 16:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPUyH02/GWqNeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 29 May 2026 16:31:09 +0000
Date: Fri, 29 May 2026 18:30:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260529163037.GB294659@pevik>
References: <20260528162920.914321-1-amir73il@gmail.com>
 <20260528162920.914321-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260528162920.914321-2-amir73il@gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C5038673A6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] fanotify13: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> The test case for FAN_DELETE_SELF deletes the objects created in
> do_setup() so we need to re-create them for the next iteration.

> This bring up a problem with ext2 and filesystem that do not support
> RENAME_EXCHANGE because overlayfs fails to re-create objects over a
> whiteout.

> It is generally not interesting to test overlayfs over such base fs,
> but for now, let just exclude this type of base fs from the delete
> self event test case.

> Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/20260527195056.337081-1-anonymemeow@gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

> Changes since v1:
> - Address LTP AI Reviewer comments

>  .../kernel/syscalls/fanotify/fanotify13.c     | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
> index 76d40eaf7..a00240a33 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> @@ -110,6 +110,7 @@ static int nofid_fd;
>  static int fanotify_fd;
>  static int at_handle_fid;
>  static int filesystem_mark_unsupported;
> +static int rename_exchange_unsupported;
>  static char events_buf[BUF_SIZE];
>  static struct event_t event_set[EVENT_MAX];

> @@ -191,6 +192,13 @@ static void do_test(unsigned int number)
>  		return;
>  	}

> +	if (tst_variant && (tc->mask & FAN_DELETE_SELF) &&
> +	    (!ovl_bind_mounted || rename_exchange_unsupported)) {
> +		/* The eviction of base fs inodes is defered due to overlay held reference */
> +		tst_res(TCONF, "overlayfs base fs cannot be watched for delete self events");
> +		return;
> +	}
> +
>  	if (filesystem_mark_unsupported && mark->flag != FAN_MARK_INODE) {
>  		FANOTIFY_MARK_FLAGS_ERR_MSG(mark, filesystem_mark_unsupported);
>  		return;
> @@ -212,11 +220,6 @@ static void do_test(unsigned int number)
>  			tst_res(TCONF, "overlayfs base fs cannot be watched with mount mark");
>  			goto out;
>  		}
> -		if (tc->mask & FAN_DELETE_SELF) {
> -			/* The eviction of base fs inodes is defered due to overlay held reference */
> -			tst_res(TCONF, "overlayfs base fs cannot be watched for delete self events");
> -			goto out;
> -		}
>  		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
>  	}

> @@ -340,10 +343,18 @@ static void do_test(unsigned int number)
>  			"Did not get an expected event (expected: %llx)",
>  			event_set[i].expected_mask);
>  	}
> +
> +	if (tc->mask & FAN_DELETE_SELF) {
> +		create_objects();
> +		get_object_stats();
> +	}
>  out:
>  	SAFE_CLOSE(fanotify_fd);
>  }

> +#define TST_VARIANT_OVL_LOWER (tst_variant & 1)
> +#define TST_VARIANT_OVL_WATCH (tst_variant > 2)
> +
>  static void do_setup(void)
>  {
>  	const char *mnt;
> @@ -371,10 +382,9 @@ static void do_setup(void)
>  		if (!ovl_mounted)
>  			return;

> -		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
> +		mnt = TST_VARIANT_OVL_LOWER ? OVL_LOWER : OVL_UPPER;
>  	} else {
>  		mnt = OVL_BASE_MNTPOINT;
> -
>  	}
>  	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, mnt);
>  	SAFE_MKDIR(MOUNT_PATH, 0755);
> @@ -386,7 +396,19 @@ static void do_setup(void)
>  	/* Create file and directory objects for testing on base fs */
>  	create_objects();

> -	if (tst_variant > 2) {
> +	/* RENAME_EXCHANGE is required for create over whiteout in overlayfs */
> +	if (TST_VARIANT_OVL_LOWER) {
> +		rename_exchange_unsupported = renameat2(AT_FDCWD, FILE_PATH_ONE,

LGTM, but renameat2() was added in Musl v1.2.6 (released just 2 months ago),
therefore it fails in our CI:

fanotify13.c:401:47: warning: implicit declaration of function 'renameat2'; did you mean 'renameat'? [-Wimplicit-function-declaration]
  401 |                 rename_exchange_unsupported = renameat2(AT_FDCWD, FILE_PATH_ONE,
      |                                               ^~~~~~~~~
      |                                               renameat

Could you please either use renameat() or use renameat2() as a raw syscall?

We even have it in testcases/kernel/syscalls/renameat2/renameat2.h, this
function should be moved to include/lapi/renameat2.h or include/lapi/stdio.h
(header which includes it). If I have time on Monday, I can do the cleanup and
fix it.

Kind regards,
Petr

> +							AT_FDCWD, FILE_PATH_TWO,
> +							RENAME_EXCHANGE) == -1 &&
> +					(errno == EOPNOTSUPP || errno == EINVAL);
> +		if (rename_exchange_unsupported) {
> +			tst_res(TCONF, "RENAME_EXCHANGE not supported on %s",
> +				tst_device->fs_type);
> +		}
> +	}
> +
> +	if (TST_VARIANT_OVL_WATCH) {
>  		/* Setup watches on overlayfs */
>  		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
>  		ovl_bind_mounted = 1;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
