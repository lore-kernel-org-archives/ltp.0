Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30DC77B72
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 10:01:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47F513CC148
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 12:01:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0523C03AE
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 12:01:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7B6E1A0068D
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 12:01:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDFDF1F38D;
 Mon, 17 Apr 2023 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681725696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUs9FKIXMTbm1BT1HEfnW7WqlR4ThdORhSxNpbUhJO0=;
 b=bCPAgmUuFUfXLG6ROcT1jI7CbF4LDmuFv3kZqvHVHtu7ugXNZXrK3qApOcwNFtac2P0l6K
 Wm5XldttHDvnN98mrOxNNysJQiSEryH/gsxC9EWUiytMmAVD12ci0+4zlgc7VFkeH7znRR
 Ha124elY+RRV1Gs0QYRy197PJGA0vgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681725696;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUs9FKIXMTbm1BT1HEfnW7WqlR4ThdORhSxNpbUhJO0=;
 b=podYTPTdgQ2spTAglobFep+ooskfNmI1Ihzm3ynEyEtG0WuX+oABBybcX2zSqgGt2ghXLp
 7kQYrC7M4FrJj3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C99491390E;
 Mon, 17 Apr 2023 10:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ARTIMAAZPWStdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 17 Apr 2023 10:01:36 +0000
Date: Mon, 17 Apr 2023 12:02:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <ZD0ZQOfKScJwZuVD@yuki>
References: <20230413122045.904933-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230413122045.904933-1-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Hugetlb: Test to detect bug with freeing
 gigantic hugetlb pages
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
Cc: piyushs@linux.ibm.com, aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com,
 geetika@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#define _GNU_SOURCE
> +#include <dirent.h>
> +
> +#include <stdio.h>
> +
> +#include "hugetlb.h"
> +
> +#define PATH_GIGANTIC_HUGEPAGE "/sys/kernel/mm/hugepages"
> +#define GIGANTIC_MIN_ORDER 10
> +
> +static int org_g_hpages;
> +static char g_hpage_path[4096];
> +
> +static void run_test(void)
> +{
> +	if (FILE_PRINTF(g_hpage_path, "%d", 1))
> +		tst_brk(TCONF, "Can't update the gigantic hugepages.");
> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);
> +
> +	if (tst_taint_check())
> +		tst_res(TFAIL, "Freeing Gigantic pages resulted in Bad Page State bug.");
> +	else
> +		tst_res(TPASS, "Successfully freed the gigantic hugepages");
> +}
> +
> +static void setup(void)
> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	unsigned long hpage_size;
> +
> +	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
                                 ^
				 This is very minor, but there is
				 nothing gigantic about the path, that's
				 just sysfs hugepates directory, so I
				 suppose that it should be just
				 PATH_HUGEPAGE

> +	while ((ent = SAFE_READDIR(dir))) {
> +		if (strstr(ent->d_name, "hugepages-") != NULL) {

Isn't the strstr() here reduntant?

I as far as I can tell if the line in sscanf() will not match the call
will simply return 0.

> +			if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
> +				is_hugetlb_gigantic(hpage_size * 1024)) {
> +				sprintf(g_hpage_path, "%s/%s/%s", PATH_GIGANTIC_HUGEPAGE,
> +						ent->d_name, "nr_hugepages");
> +				break;
> +			}
> +		}
> +	}
> +	if (!g_hpage_path[0])
> +		tst_brk(TCONF, "Gigantic hugepages not supported");
> +
> +	SAFE_CLOSEDIR(dir);
> +	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (g_hpage_path[0])
> +		SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +	    {"linux-git", "ba9c1201beaa"},
> +	    {"linux-git", "7118fc2906e9"},
                            ^
			    This has appears to be wrong. Shouldn't the
			    last digit be 2 instead of 9?
> +	    {}
> +	},
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run_test,
> +	.taint_check = TST_TAINT_B,
> +};
> diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> index 241dab708..34fe08c24 100644
> --- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> +++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
> @@ -39,6 +39,12 @@
>  # endif
>  #endif
>  
> +/* Check if hugetlb page is gigantic */
> +static inline int is_hugetlb_gigantic(unsigned long hpage_size)
> +{
> +	return (hpage_size / getpagesize()) >> 11;
> +}
> +
>  /*
>   * to get the lower nine permission bits
>   * from shmid_ds.ipc_perm.mode
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
