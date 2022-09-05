Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DA6ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 16:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C98053CA948
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 18:04:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4D3E3C0367
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 18:04:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F4851000937
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 18:04:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8186D1FA34;
 Mon,  5 Sep 2022 16:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662393883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nb3+atyPKVt3fm8N6c2bofSmG1aPa3kSNV11nlzVgy0=;
 b=DiKcUfg3o9Hm+CH/MPKkdvPYuxiEz+cPD6mUd8T6sKsJrlPd0juBvw4J3HSMmpazIb3Mep
 i1S7jrm/YUVu+wC5zftVSb16ElgiuDyqlZEQU/ZFbzi1elzonxGThlpYl8x9v+l1tG2+Bn
 BU9QNSh6sVPGS94Vi+HV075b3DHirxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662393883;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nb3+atyPKVt3fm8N6c2bofSmG1aPa3kSNV11nlzVgy0=;
 b=QsCp3xNJOsrGL8CHQjEqH8pWlgGo0NblsyY44tpvuHH2loCNW80OdQz3hkpdUZXkL2y0Lj
 3ixOr226nPDKegCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41101139C7;
 Mon,  5 Sep 2022 16:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSBTDhseFmN+agAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 16:04:43 +0000
Date: Mon, 5 Sep 2022 18:04:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxYeGclGHpSay6ZN@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220905154239.2652169-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220905154239.2652169-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] syscalls/fanotify09: Add test cases for
 FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index 0eb83e2f8..e40916c08 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -73,12 +73,14 @@ static char event_buf[EVENT_BUF_LEN];
>  static int mount_created;

>  static int fan_report_dfid_unsupported;
> +static int ignore_mark_unsupported;

>  static struct tcase {
>  	const char *tname;
>  	struct fanotify_mark_type mark;
>  	unsigned int ondir;
>  	unsigned int ignore;
> +	unsigned int ignore_flags;
>  	unsigned int report_name;
>  	const char *close_nowrite;
>  	int nevents;
> @@ -88,7 +90,7 @@ static struct tcase {
>  		"Events on non-dir child with both parent and mount marks",
>  		INIT_FANOTIFY_MARK_TYPE(MOUNT),
>  		0,
> -		0,
> +		0, 0,
>  		0,
>  		DIR_NAME,
>  		1, 0,

nit: as number of struct grow, it'd help readability to omit members with 0:
		.tname = "Events on non-dir child with both parent and mount marks",
		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
		.close_nowrite = DIR_NAME,
		.nevents = 1,

This is obviously non-blocker of this patch, if you agree it can be done any
time later.

Also I fixed make check warnings some time ago (i.e. checkpatch.pl), but they
got back. I might find a time to fix them (we appreciate you look after the
test, thus don't want to bother you with these tiny details).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
