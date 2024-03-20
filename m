Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69ABC54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 12:11:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C20803CFBF2
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 13:11:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AA103CE66B
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 13:11:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19B8F20A6BB
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 13:11:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 086182115F;
 Wed, 20 Mar 2024 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710936673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvlSDw13DB187ZtGPvd66HUj3Cdf9xzwiTwh3WjdzGM=;
 b=ZE697yvIIrnxUw+4Txyy+42L+jIcGjXAlIJrukYEkJzFsDD/8whFANNvgEjF46a6Am0ecs
 S+BoRthczh89uThO7rJtNjPKpaEZl0wStoxnmC7TijvotrDQSxG+wt445nZ/LaEz4AbAut
 lEF+6FHWRPWffXQB8sz7my2qJi4Cewc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710936673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvlSDw13DB187ZtGPvd66HUj3Cdf9xzwiTwh3WjdzGM=;
 b=6tKy3tHkM6JzEnmoV+6yODb1FR4IBJCT4bzdWTVXy9/CW6NZan0SB1Vhap2JUUAHKOTrfM
 k43x30b6bAukuzCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710936673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvlSDw13DB187ZtGPvd66HUj3Cdf9xzwiTwh3WjdzGM=;
 b=ZE697yvIIrnxUw+4Txyy+42L+jIcGjXAlIJrukYEkJzFsDD/8whFANNvgEjF46a6Am0ecs
 S+BoRthczh89uThO7rJtNjPKpaEZl0wStoxnmC7TijvotrDQSxG+wt445nZ/LaEz4AbAut
 lEF+6FHWRPWffXQB8sz7my2qJi4Cewc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710936673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvlSDw13DB187ZtGPvd66HUj3Cdf9xzwiTwh3WjdzGM=;
 b=6tKy3tHkM6JzEnmoV+6yODb1FR4IBJCT4bzdWTVXy9/CW6NZan0SB1Vhap2JUUAHKOTrfM
 k43x30b6bAukuzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EED65136D6;
 Wed, 20 Mar 2024 12:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TRZHOmDS+mVeDwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 12:11:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A15F2A07D6; Wed, 20 Mar 2024 13:11:08 +0100 (CET)
Date: Wed, 20 Mar 2024 13:11:08 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240320121108.5fqgjdinkrhzkuz5@quack3>
References: <20240320063218.449072-1-pvorel@suse.cz>
 <20240320063218.449072-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320063218.449072-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,linux.ibm.com,suse.cz,redhat.com,gmail.com]; 
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: fix anonymous pipe testcases
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
Cc: Jan Kara <jack@suse.cz>, Mete Durlu <meted@linux.ibm.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 20-03-24 07:32:17, Petr Vorel wrote:
> From: Mete Durlu <meted@linux.ibm.com>
> 
> When SElinux is in enforcing state and SEpolicies disallow anonymous
> pipe usage with fanotify_mark(), related fanotify14 testcases fail with
> EACCES instead of EINVAL. Accept both errnos when SElinux is in
> enforcing state to correctly evaluate test results.
> 
> Replace TST_EXP_FD_OR_FAIL with TST_EXP_FAIL when testing
> fanotify_mark() as it returns -1 on failure and 0 on success not a file
> descriptor.
> 
> Co-developed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Hi,
> 
> this is a replacement of Mete's v2 fanotify14: fix anonymous pipe testcases:
> https://lore.kernel.org/ltp/20240312120829.178305-2-meted@linux.ibm.com/
> 
> Kind regards,
> Petr
> 
>  .../kernel/syscalls/fanotify/fanotify14.c     | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index d02d81495..b554af22a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -30,6 +30,7 @@
>  
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
> +#include "tst_selinux.h"
>  
>  #define MNTPOINT "mntpoint"
>  #define FILE1 MNTPOINT"/file1"
> @@ -47,6 +48,7 @@ static int pipes[2] = {-1, -1};
>  static int fanotify_fd;
>  static int ignore_mark_unsupported;
>  static int filesystem_mark_unsupported;
> +static int se_enforcing;
>  static unsigned int supported_init_flags;
>  
>  struct test_case_flags_t {
> @@ -283,9 +285,18 @@ static void do_test(unsigned int number)
>  
>  	tst_res(TINFO, "Testing %s with %s",
>  		tc->mark.desc, tc->mask.desc);
> -	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> -					 tc->mask.flags, dirfd, path),
> -					 tc->expected_errno);
> +
> +	if (tc->pfd && se_enforcing) {
> +		const int exp_errs[] = {tc->expected_errno, EACCES};
> +
> +		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +				 tc->mask.flags, dirfd, path),
> +				 exp_errs);
> +	} else {
> +		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> +						 tc->mask.flags, dirfd, path),
> +						 tc->expected_errno);
> +	}
>  
>  	/*
>  	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
> @@ -334,6 +345,8 @@ static void do_setup(void)
>  	SAFE_FILE_PRINTF(FILE1, "0");
>  	/* Create anonymous pipes to place marks on */
>  	SAFE_PIPE2(pipes, O_CLOEXEC);
> +
> +	se_enforcing = tst_selinux_enforcing();
>  }
>  
>  static void do_cleanup(void)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
