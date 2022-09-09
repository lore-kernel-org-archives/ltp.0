Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2121C6FA82
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 09:38:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7A43CAA1A
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:38:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE3143CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 11:38:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2296600F2F
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 11:38:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9749321E5B;
 Fri,  9 Sep 2022 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662716305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJwcTWCW2n0xhrGK02m7PwC4GhDB53ZDCIBGJBXuiH8=;
 b=UUlXuiBkaZnFH3DgcqqpejL1RWqYIGKZ91QbdCaTxBGkdJr+2eE94O4PyjxskhrzxG3kOB
 IZu4AzKIs342V7+GK7XU9KBcnnj7GjETeO7xqiB7xrD6OnhL6Q3uc+3REUCO8Pavd0jVFb
 Haypq4DuQNXHqdCpQhG5VEbd1pVktlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662716305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJwcTWCW2n0xhrGK02m7PwC4GhDB53ZDCIBGJBXuiH8=;
 b=of3kWvpmEgEOoVtZgWRQb9wzt1jZrt5OjoDtodwHThtitThXt4zaJDk8JN2buvNLVe/haV
 QWJsMH/2HVHanzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7766213A93;
 Fri,  9 Sep 2022 09:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +5ALHJEJG2PcZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Sep 2022 09:38:25 +0000
Date: Fri, 9 Sep 2022 11:40:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YxsKBI2256Ldmhpn@yuki>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902133710.1785-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/9] tst_supported_fs: Implement skip list
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> as it will be needed for $ALL_FILESYSTEMS shell implementation in the
> next commit. Pass tmpfs to LVM scripts (as it was required there),
> but allow to use zram01.sh with tmpfs as it works with it.
> 
> Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Note, I'm not sure if changes in this commit in tst_supported_fs.c will
> not be heavily rewritten due tracking minimal filesystem usage.
> 
>  testcases/lib/tst_supported_fs.c           | 56 +++++++++++++++++-----
>  testcases/misc/lvm/generate_lvm_runfile.sh |  2 +-
>  testcases/misc/lvm/prepare_lvm.sh          |  2 +-
>  3 files changed, 46 insertions(+), 14 deletions(-)
> 
> diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
> index 43eac194f..87be2b759 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -5,42 +5,74 @@
>   */
>  
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
>  
> +#define SKIP_DELIMITER ','
> +
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_fs.h"
>  
>  static void usage(void)
>  {
> -	fprintf(stderr, "Usage: tst_supported_fs [fs_type]\n");
> +	fprintf(stderr, "Usage: tst_supported_fs [-s skip_list] [fs_type]\n");
>  	fprintf(stderr, "   If fs_type is supported, return 0\n");
>  	fprintf(stderr, "   If fs_type isn't supported, return 1\n");
>  	fprintf(stderr, "   If fs_type isn't specified, print the list of supported filesystems\n");
>  	fprintf(stderr, "   fs_type - a specified filesystem type\n");
> +	fprintf(stderr, "   skip_list - filesystems to skip, delimiter: '%c'\n",
> +			SKIP_DELIMITER);
>  }
>  
>  int main(int argc, char *argv[])
>  {
> -	const char *skiplist[] = {"tmpfs", NULL};
>  	const char *const *filesystems;
> -	int i;
> +	int i, ret, cnt = 1;
> +	char **skiplist = NULL;
> +	char *fs;
>  
> -	if (argc > 2) {
> -		fprintf(stderr, "Can't specify multiple fs_type\n");
> -		usage();
> -		return 2;
> +	while ((ret = getopt(argc, argv, "hs:"))) {
> +		if (ret < 0)
> +			break;
> +
> +		switch (ret) {
> +		case '?':

No usage?

> +			return 1;
> +
> +		case 'h':
> +			usage();
> +			return 0;
> +
> +		case 's':
> +			fs = optarg;
> +			for (i = 0; fs[i]; i++) {
> +				if (optarg[i] == SKIP_DELIMITER)
> +					cnt++;
> +			}
> +			skiplist = malloc(++cnt * sizeof(char *));
> +			if (!skiplist) {
> +				fprintf(stderr, "malloc() failed\n");
> +				return 1;
> +			}
> +
> +			fs = optarg;
> +			for (i = 0; i < cnt; i++)
> +				skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
> +			break;

It may be a bit cleaner to put this part into a function i.e.

	skiplist = parse_skiplist(optarg);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
