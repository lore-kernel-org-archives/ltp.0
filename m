Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C39AC433EF
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 14:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAA383C9536
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 15:43:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42FDA3C03FE
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:43:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 517221000EB7
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 15:43:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C0721F3A8;
 Thu, 13 Jan 2022 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642085027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NbVGs/OHGr2oUBrakHa0r6mb2oRkqWurHCIQZMLizpk=;
 b=eAyBPZ5DCK3xesStnzqyb6kU6N5m+XF/PA/KyMiWsCIsHO3qp0s1GHTUL8nGNmBePX2Uak
 Z3QZTncmm5aS0bgzEqPtyprfqCkY5l0ZAbCSeOQhAqsuDsmVNHMe0VUku5Xo0leGlvS+ur
 e2bqRD18cxT4unxL4PR04X5Yro5wx/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642085027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NbVGs/OHGr2oUBrakHa0r6mb2oRkqWurHCIQZMLizpk=;
 b=tUQYxxuxyqse4zl7IBtj/5QfcItGlqGCCga2VTd+kDcUN8Xwa9t1mnvZlj7dk/QXlBEx0f
 Bq+ziumpfh0oKODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7759113DD1;
 Thu, 13 Jan 2022 14:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fneTG6M64GFHBAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jan 2022 14:43:47 +0000
Date: Thu, 13 Jan 2022 15:45:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YeA7BQvnZ12c/QjT@yuki>
References: <1641973691-22981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641973691-22981-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641973691-22981-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/3] syscalls/quotactl: Make use of
 TST_EXP_PASS_SILENT and TST_EXP_FAIL
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
>  } tcases[] = {
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir1, EACCES, 0},
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir2, ENOENT, 0},
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EBUSY, 1},
> -	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1},
> -	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, usrpath, EINVAL, 0},
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, ENOTBLK, 0},
> -	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, ESRCH, 0},
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, usrpath, ESRCH, 0},
> -	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, usrpath, ESRCH, 0},
> -	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1},
> -	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EPERM, 0},
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir1, EACCES, 0,
> +	"EACCES when cmd is Q_QUOTAON and addr existed but not a regular file"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, testdir2, ENOENT, 0,
> +	"ENOENT when the file specified by special or addr does not exist"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EBUSY, 1,
> +	"EBUSY when cmd is Q_QUOTAON and another Q_QUOTAON had already been performed"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &fmt_id, NULL, EFAULT, 1,
> +	"EFAULT when addr or special is invalid"},
> +
> +	{QCMD(OPTION_INVALID, USRQUOTA), &fmt_id, usrpath, EINVAL, 0,
> +	"EINVAL when cmd or type is invalid"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, ENOTBLK, 0,
> +	"ENOTBLK when special is not a block device"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dq, ESRCH, 0,
> +	"ESRCH when no disk quota is found for the indicated user and quotas "
> +	"have not been turned on for this fs"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_invalid, usrpath, ESRCH, 0,
> +	"ESRCH when cmd is Q_QUOTAON, but the quota format was not found"},
> +
> +	{QCMD(Q_GETNEXTQUOTA, USRQUOTA), &test_invalid, usrpath, ESRCH, 0,
> +	"ESRCH when cmd is Q_GETNEXTQUOTA, but there is no ID greater than or "
> +	"equal to id that has an active quota"},
> +
> +	{QCMD(Q_SETQUOTA, USRQUOTA), &test_id, &set_dqmax, ERANGE, 1,
> +	"ERANGE when cmd is Q_SETQUOTA, but the specified limits are out of "
> +	"the range allowed by the quota format"},
> +
> +	{QCMD(Q_QUOTAON, USRQUOTA), &fmt_id, usrpath, EPERM, 0,
> +	"EPERM when the caller lacked the required privilege (CAP_SYS_ADMIN) "
> +	"for the specified operation"},

These descriptions could be a bit shorter and still have the same amount
of information, for instance the last one could be shortened to just:

"EPERM when caller lacks required privilege (CAP_SYS_ADMIN)"

or

"ESRCH for Q_GETNEXTQUOTA but the id was last one"

or

"ESRCH for Q_GETNEXTQUOTA but no quota found for the user or quotas are off"

Ideally all the messages should fit into a single line less than 80
characters...


Other than that this is a nice cleanup, with the messages shortened:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
