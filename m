Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B48BECAAD8
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 15:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53073CADB0
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 17:16:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2F233CA756
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:15:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3667602746
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:15:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C08F01F891;
 Fri, 23 Sep 2022 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663946153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2EyhLPboHtBQgXcvS0ZrzJZwfgnaW/v1NebdhJRxqU=;
 b=hX1hsDUSOiFJ7sbje39dc5il0ysHTwIYkxYLknWw1OqM+uOW1k8CciS9h+GR0M/4EJjmYb
 DfENAu4pdkk2ce57upLc2j6h42QmzGogHNDU6S9UDbXa4Eb+9yVWKsjHEvLdLij072dDRu
 4Mu8dUiVdZ2pEpw9nUUG1qRFU+2IKD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663946153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2EyhLPboHtBQgXcvS0ZrzJZwfgnaW/v1NebdhJRxqU=;
 b=SoM/67xTTev99dZT9rlLteIWSf3fIUJaHe37FKLa5VPaBO/rqa3mE4iIb3EPO4uf3kd43X
 KgOYzewP6GBsG9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD77813AA5;
 Fri, 23 Sep 2022 15:15:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Byy1KanNLWNCOAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 23 Sep 2022 15:15:53 +0000
Date: Fri, 23 Sep 2022 17:17:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yy3OHtHNt9heYZef@yuki>
References: <20220921155006.13360-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220921155006.13360-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Implement tst_supported_fs feature suggested by pvorel in his patch:
> tst_test.sh: Fix filesystem support detection
> 
> Although the tst_fs_type_name() functions could use some improvements,
> e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get properly
> skipped and vfat is missing from the list of known filesystems.
> 
>  testcases/lib/tst_supported_fs.c | 49 ++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
> index 70d4d38c7..5873d0ba1 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -32,9 +32,13 @@ static void usage(void)
>  	fprintf(stderr, "tst_supported_fs -s skip_list fs_type\n");
>  	fprintf(stderr, "   if fs_type is in skip_list, return 1 otherwise return 0\n\n");
>  
> +	fprintf(stderr, "tst_supported_fs -s skip_list -d path\n");
> +	fprintf(stderr, "   if filesystem mounted on path is in skip_list, return 1 otherwise return 0\n\n");
> +
>  	fprintf(stderr, "fs_type - a specified filesystem type\n");
>  	fprintf(stderr, "skip_list - filesystems to skip, delimiter: '%c'\n",
>  			SKIP_DELIMITER);
> +	fprintf(stderr, "path - any valid file or directory\n");
>  }
>  
>  static char **parse_skiplist(char *fs)
> @@ -62,10 +66,11 @@ static char **parse_skiplist(char *fs)
>  int main(int argc, char *argv[])
>  {
>  	const char *const *filesystems;
> +	const char *fsname = NULL;
>  	int i, ret;
>  	char **skiplist = NULL;
>  
> -	while ((ret = getopt(argc, argv, "hs:"))) {
> +	while ((ret = getopt(argc, argv, "hs:d:"))) {
                                          ^
					  It's customary to sort these
					  in alphabetical order.

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
