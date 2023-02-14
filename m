Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935B5C05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 13:37:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EDD93CC91C
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 14:37:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F017D3CBF50
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 14:37:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6CFE410006AE
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 14:37:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F30C21FF5;
 Tue, 14 Feb 2023 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676381836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RurUXhWKHTK1mwzCAfD3Wmzcr2D6p0HJtGHrV7OJB38=;
 b=j2kavgXOQaPpIjh5wSlKtsCldyM+tAe01JwGFuPQfUDTqYvHuMjeQSn6/f614UkdhjZylT
 d0Jbai7grjWK1QHJxVT5ZUCxG8yuPYjm1EJcSLJGj0NhBYZCshOzsSY0bXjnWG6RlxcRgw
 hFHAbUdNQfQIw1Xp/0zJk0571yPJyrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676381836;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RurUXhWKHTK1mwzCAfD3Wmzcr2D6p0HJtGHrV7OJB38=;
 b=jOz5FGsCcCNnlK1EM2UZaN150AdLmLMMHKCOsVV9Bumjtu8js8BKVrptA3seEvgiKP/9pt
 wNdblJ16dYZuolDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66E29138E3;
 Tue, 14 Feb 2023 13:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MOHOF4yO62OMOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Feb 2023 13:37:16 +0000
Date: Tue, 14 Feb 2023 14:37:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Message-ID: <Y+uOimkvJ76Q8diX@pevik>
References: <20230214122509.2957225-1-ycliang@andestech.com>
 <20230214122509.2957225-2-ycliang@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230214122509.2957225-2-ycliang@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 2/2] lib/tst_pid.c: Increase PIDS_RESERVED to avoid
 fork failure.
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

Hi Leo,

> After Adjusting how we count used pid, we increase
> the number of PIDS_RESERVED to void fork failure.
nit: in this case I'd actually keep changes in single commit
(otherwise first commit alone would break tests),

Kind regards,
Petr

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1 -> v2
> * Split into two patches
> ---
>  lib/tst_pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> index a282f8cc9..7582e4828 100644
> --- a/lib/tst_pid.c
> +++ b/lib/tst_pid.c
> @@ -36,7 +36,7 @@
>  #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
>  #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
>  /* Leave some available processes for the OS */
> -#define PIDS_RESERVE 50
> +#define PIDS_RESERVE 200

>  pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
>  {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
