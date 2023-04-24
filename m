Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B74C7618E
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 09:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0593CBCEB
	for <ltp@archiver.kernel.org>; Mon, 24 Apr 2023 11:28:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05CE3CB303
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 11:28:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B6821400332
 for <ltp@lists.linux.it>; Mon, 24 Apr 2023 11:28:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47B301FD7D;
 Mon, 24 Apr 2023 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682328512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj5HdzLY++stIu3wnPhE8FIPPxkonOmH7/pdBJLRHdk=;
 b=uMl+cIsAx+ZdVrn6draThoKAAQG1J0ojOanCrcJg91e27iuXcxkx+4W9Now8IixjjeZzfE
 rokKOBCeCctnEy9XAge/+Fw3uu4AFE5RozfNxqjq4PsTyR/JcvPEDQ1FBCqyQFlXubMx4D
 MejtJxJ/YzLIsCblBYWulVK5mlZdu2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682328512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rj5HdzLY++stIu3wnPhE8FIPPxkonOmH7/pdBJLRHdk=;
 b=0gHvNHq61oApZ4HIXlYnUGe9pC6Xkam2HbErAIFIgdWvvbmeFQVlCAa7W0ssknqst8F2co
 3mRo/wisWvTmd/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 346D513780;
 Mon, 24 Apr 2023 09:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3uGKDMBLRmR3DAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 24 Apr 2023 09:28:32 +0000
Date: Mon, 24 Apr 2023 11:29:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Hao Zeng <zenghao@kylinos.cn>
Message-ID: <ZEZMAPIUD09kgciI@yuki>
References: <20230423022702.3486141-1-zenghao@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230423022702.3486141-1-zenghao@kylinos.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fs/doio:Use the snprintf function to prevent
 buffer overflow
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
> Use the snprintf function instead of sprintf in the write_log.c file
> 
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> ---
>  testcases/kernel/fs/doio/write_log.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/fs/doio/write_log.c b/testcases/kernel/fs/doio/write_log.c
> index e8ef9c7cb..44e6fd165 100644
> --- a/testcases/kernel/fs/doio/write_log.c
> +++ b/testcases/kernel/fs/doio/write_log.c
> @@ -141,7 +141,7 @@ int wlog_open(struct wlog_file *wfile, int trunc, int mode)
>  
>  	oflags = O_RDWR;
>  	if ((wfile->w_rfd = open(wfile->w_file, oflags)) == -1) {
> -		sprintf(Wlog_Error_String,
> +		snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
>  			"Could not open write log - open(%s, %#o) failed:  %s\n",
>  			wfile->w_file, oflags, strerror(errno));
>  		close(wfile->w_afd);

There is one more sprintf() in the wlong_open() you have missed, can you
please fix that one as well?

Also with new enough GCC I'm still getting warnings about possible
truncation, looking at the Wlog_Error_String size it would make sense to
bump the buffer size to something as 2048.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
