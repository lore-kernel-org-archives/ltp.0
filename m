Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52B1C76196
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 06:27:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12A8A3CC839
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 08:27:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8F93CA847
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 08:27:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A81591000525
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 08:27:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D02751FE01;
 Tue, 11 Apr 2023 06:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681194435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzHxKyZ6M/s4eZeusYqyF9YxbbzpKZq0Rit/jVqgDHE=;
 b=nzSYffpf/IlPMJxS18LRHeXmS+LCd97wj3evHu3/5DVgvOwNr9Xh9mYoXDHYd+yqOmSMe9
 O2jl29DfrxgO2d5mg7daUcmZTgUBVuhDiy4QiBYwFaiYw9ZWdNPsjoXurESrzlBZa861fV
 bPN9ofmuMEJ1nLIEvFY9mUqjl89TAWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681194435;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzHxKyZ6M/s4eZeusYqyF9YxbbzpKZq0Rit/jVqgDHE=;
 b=k7LDW88S0nVSSh41DXKIxDgjK5DW8cY9QRCoRF7XWDrUlq5m0LePeR12euHp0MOR/yM0ti
 /dDP4osU3uPuJWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B754913519;
 Tue, 11 Apr 2023 06:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VWZiK8P9NGRgSwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Apr 2023 06:27:15 +0000
Date: Tue, 11 Apr 2023 08:27:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230411062721.GA1737346@pevik>
References: <1681092133-28614-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681092133-28614-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fcntl06: Remove R_GETLK/R_SETLK test case
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> linux never implement R_GETLK/R_SETLK facility, so this case
> is useless.

> A twenty years old email[1] also mentioned that we should remove
> this case but leave a bad gap number.

> R_GETLK/R_SETLK facility only exists in the IRIXones.

> IRIX says this pair of arguments are for use by NFS lockd and really
> doesn't go into much detail.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Fixes:#1029
> [1]https://sourceforge.net/p/ltp/mailman/message/7574937/
...
> --- a/testcases/kernel/syscalls/fcntl/fcntl06.c
> +++ /dev/null
...

- #define F_RGETLK 10                /* kludge code */
Kernel and glibc/musl does not define F_RGETLK (it's from here),
and I haven't find find any flag with value 10 in libc include/fcntl.h).

Commit from 2003 4cf809678 ("*** empty log message ***")
removed struct flock tl;, therefore it does not compile with
-DLINUX_FILE_REGION_LOCK.
With fixed code it shows fcntl() always return -1 and errno EINVAL.

=> looks to be safe to remove the test.

Kind regards,
Petr

> -#ifdef LINUX_FILE_REGION_LOCK
> -	if (fcntl(fd, F_RGETLK, &tl) == -1) {
> -		if (errno == EINVAL)
> -			tst_brkm(TCONF, cleanup,
> -				 "fcntl remote locking feature not implemented in "
> -				 "the kernel");
> -		else {
> -			/*
> -			 * FIXME (garrcoop): having it always pass on
> -			 * non-EINVAL is a bad test.
> -			 */
> -			tst_resm(TPASS, "fcntl on file failed");
> -		}
> -	}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
