Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E661C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BCD73C4E3F
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:18:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 959ED3C4C65
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:18:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7A3A68DEB3
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:18:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C94B92116B;
 Thu, 23 Jan 2025 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737652708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fljzE0AsCABuFS1MRkNGbwVZbNqr0KugjEAEksSu6g=;
 b=IG4GKqtJCYHQYaY7FPEn5EvE0EBsK8Y9dUuQ6DpPf5D0mSaJrHRwVQQvCNYa9L1gGDGa4y
 ugtSj6oxv2wiV0B13cpwZdin8GWuSXZERnY1SgB67Gh8lVy+HzcgBbRoB7TYink0UJP2P0
 eAEKnX0UcFth9j7uHcTcroBWB/63BBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737652708;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fljzE0AsCABuFS1MRkNGbwVZbNqr0KugjEAEksSu6g=;
 b=AYBl/v3l/HGlnR1oOWsIbrxrVF8NXrXdphE/kI5ge8WdUI8VOmp1tSN/4Eva8+arCDqkpi
 oyfyS4toEXEw94Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aqRtqg7u;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tQMAqfRA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737652707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fljzE0AsCABuFS1MRkNGbwVZbNqr0KugjEAEksSu6g=;
 b=aqRtqg7uo08Ix+NG/4paY/g6X9jn5gsFCfZ5NJOv7C3T7kTCrl8+sj0jD2WwgegMpq+jFf
 XZxzV1P94fyzHBIZ4cx1w3G+iCY+q2xgGz55UXAike3E/qsVuhhKqrBQYZA4F9I59e7kdq
 QpspzKW3g8GHztzT20YAbIcTJzXsdbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737652707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fljzE0AsCABuFS1MRkNGbwVZbNqr0KugjEAEksSu6g=;
 b=tQMAqfRAvJUsRUGTAJPh+tyXDHmt8z6QKu0R2RVtog7YymEuWssa+NRL0sif0/rcR2Du6K
 HB7jB4qPqo+ifLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D393136A1;
 Thu, 23 Jan 2025 17:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CeZ4IeN5kmdsAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Jan 2025 17:18:27 +0000
Date: Thu, 23 Jan 2025 18:18:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250123171826.GA125552@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122172440.506677-2-amir73il@gmail.com>
X-Rspamd-Queue-Id: C94B92116B
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify13: Verify that we did not get an
 extra event
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, all,

> For example, verify that we did not get an event on a directory object
> without requesting FAN_ONDIR.  Also, report a test failure if no events
> received at all instead of blocking on read of fanotify_fd.

> With this change, the test fails with overlayfs variants over btrfs,
> because the size of fid of overalyfs over btrfs is about 90 bytes and
> the events on the three objects do not all fit into a single 256 bytes
> buffer read. Increase the size of the events buffer to fix this failure.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify13.c     | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
> index 5cd857707..16fd99ba1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify13.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
> @@ -34,7 +34,7 @@
>  #include "fanotify.h"

>  #define PATH_LEN 128
> -#define BUF_SIZE 256
> +#define BUF_SIZE 1024
>  #define DIR_ONE "dir_one"
>  #define FILE_ONE "file_one"
>  #define FILE_TWO "file_two"
> @@ -130,10 +130,15 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
>  		SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
>  				   AT_FDCWD, objects[i].path);

> -		/* Setup the expected mask for each generated event */
> +		/*
> +		 * Setup the expected mask for each generated event.
> +		 * No events are expected on directory without FAN_ONDIR.
> +		 */
>  		event_set[i].expected_mask = tc->mask;
>  		if (!objects[i].is_dir)
>  			event_set[i].expected_mask &= ~FAN_ONDIR;
> +		else if (!(event_set[i].expected_mask & FAN_ONDIR))
> +			event_set[i].expected_mask = 0;
>  	}
>  	return 0;
>  }
> @@ -163,7 +168,8 @@ static void do_test(unsigned int number)
>  		return;
>  	}

> -	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
> +					 FAN_NONBLOCK, O_RDONLY);

>  	/*
>  	 * Place marks on a set of objects and setup the expected masks
> @@ -279,6 +285,16 @@ static void do_test(unsigned int number)
>  			FSID_VAL_MEMBER(event_fid->fsid, 1),
>  			*(unsigned long *) event_file_handle->f_handle);
>  	}
> +
> +	/*
> +	 * Verify that we did not get an extra event, for example, that we did
> +	 * not get an event on directory without FAN_ONDIR.
> +	 */
> +	if (event_set[i].expected_mask) {
> +		tst_res(TFAIL,
> +			"Did not get an expected event (expected: %llx)",
> +			event_set[i].expected_mask);

I verified that on openSUSE on x86_64 test properly fails with 6.12.9:
fanotify13.c:282: TFAIL: handle_bytes (0) returned in event does not equal to handle_bytes (24) returned in name_to_handle_at(2)

and works with 6.12.10. So far so good.

But when testing on other archs, 6.12.10 fails on aarch64 and ppc64le:

fanotify13.c:339: TFAIL: Did not get an expected event (expected: 200)

That's a different failure than on 6.12.9.

Any hint what could be wrong?

Kind regards,
Petr

> +	}
>  out:
>  	SAFE_CLOSE(fanotify_fd);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
