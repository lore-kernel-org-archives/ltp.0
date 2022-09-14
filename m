Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67485ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 042F83CABD5
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:10:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D88D93CABC2
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:10:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 043CB1000553
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:10:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34D723379A;
 Wed, 14 Sep 2022 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663146630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azkrPlYtjInykXvTuCARN2n2jKLmOoW1PJqC85bHhGE=;
 b=Fvxtvi8MaVbx9y/3h1Ad4UdnFANP55Jeyx6mjQh9sa3CFrT/a0YQ3CzoMIdACAjrYIu0pl
 EHqUky5+fh6wFZ7DsR/2XRveTujcMTLFeqeuGUOAa7ljWg/1lUa3F3IzRCrnDAWK1VubKk
 6EZuYQAzSlNWdrHkgQzDva7Q2eanBCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663146630;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azkrPlYtjInykXvTuCARN2n2jKLmOoW1PJqC85bHhGE=;
 b=Z1akt5qw5FHdwmya6pQg2Hp05EMrUriJLdHvVcPH+6IFo0esAdxjVCqOliJcgehQuvnHcL
 COO+sgANW36hPnCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 233A813494;
 Wed, 14 Sep 2022 09:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qiqTB4aaIWNgIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 09:10:30 +0000
Date: Wed, 14 Sep 2022 11:12:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyGa+5St+RQGdEd2@yuki>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913151907.26763-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add tst_validate_children() helper function
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
> The function waits for given number of child processes and validates
> that they have all exited without error.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_test.h |  8 ++++++++
>  lib/tst_res.c      | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index ac52f268c..69e649651 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -362,6 +362,14 @@ void tst_set_max_runtime(int max_runtime);
>   */
>  char *tst_get_tmpdir(void);
>  
> +/*
> + * Validates exit status of child processes
> + */
> +int tst_validate_children_(const char *file, const int lineno,
> +	unsigned int count);
> +#define tst_validate_children(child_count) \
> +	tst_validate_children_(__FILE__, __LINE__, (child_count))
> +
>  #ifndef TST_NO_DEFAULT_MAIN
>  
>  static struct tst_test test;
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index e0896eb05..cac7484e7 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -613,3 +613,40 @@ void tst_require_root(void)
>  	if (geteuid() != 0)
>  		tst_brkm(TCONF, NULL, "Test needs to be run as root");
>  }
> +
> +int tst_validate_children_(const char *file, const int lineno,
> +	unsigned int count)
> +{
> +	unsigned int i;
> +	int status;
> +
> +	for (i = 0; i < count; i++) {
> +		SAFE_WAITPID(NULL, -1, &status, 0);
> +
> +		if (WIFSIGNALED(status)) {
> +			tst_res_(file, lineno, TFAIL,
> +				"Child killed by signal %d %s",
> +				WTERMSIG(status), tst_strsig(WTERMSIG(status)));
> +			return 1;
> +		}
> +
> +		if (WCOREDUMP(status)) {
> +			tst_res_(file, lineno, TFAIL, "Child crashed");
> +			return 1;
> +		}

WCOREDUMP() is subset of WIFSIGNALED() and as such it will be never
triggered here.

> +		if (!WIFEXITED(status)) {
> +			tst_res_(file, lineno, TFAIL,
> +				"Unexpected child status");
> +			return 1;
> +		}
> +
> +		if (WEXITSTATUS(status)) {
> +			tst_res_(file, lineno, TFAIL, "Child returned error %d",
> +				WEXITSTATUS(status));
> +			return 1;
> +		}

And we do have tst_strstatus() that actually does all of this so why not
just:

	SAFE_WAITPID(NULL, -1, &status, 0);

	if (!WIFEXITED(status) || WEXITSTATUS(status)) {
		tst_res_(file, lineno, TFAIL, "Child %s", tst_strstatus(status);
		return 1;
	}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
