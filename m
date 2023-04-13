Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5CAC77B6C
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 09:21:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1086B3CC4CF
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 11:21:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D3E53CC3BC
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:21:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 691481400B7F
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:21:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E802A1FD63;
 Thu, 13 Apr 2023 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681377675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=utbtt6f/E49AIcIivOYeKISdG38SvlMYnvPuV/lEidM=;
 b=U80PLEhOCpJw6QcYHLKaYz+7p4pZEShx0+TKIxj+bAY8HO54+//+ieA2rghET5okV/lGyB
 IGnYKyz3uzlJWja90hWnstvHNFVYeup47J58gD21S+NrsZp++UAGI3seIv/xARUwmV3y6G
 l44JF4N+4372VKJdURyxOVE7pW0smBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681377675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=utbtt6f/E49AIcIivOYeKISdG38SvlMYnvPuV/lEidM=;
 b=ngqZ9NK2Q8n51aT9mbG1UeDBFh3RXWVa3D+j+nxDq4RXf42FplnpkzGLwUjvFZ/H7ICTtr
 lAgEXFkOjdOpmmCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3A6713421;
 Thu, 13 Apr 2023 09:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BkSTLovJN2SxLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Apr 2023 09:21:15 +0000
Date: Thu, 13 Apr 2023 11:22:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <ZDfJzRxVW4V7ctbc@yuki>
References: <20230413090753.883953-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230413090753.883953-1-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Hugetlb: Test to detect bug with freeing gigantic
 hugetlb pages
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
> +/*\
> + * [Description]
> + *
> + * Before kernel version 5.10-rc7, there was a bug that resulted in a "Bad Page
> + * State" error when freeing gigantic hugepages. This happened because the
> + * struct page entry compound_nr, which overlapped with page->mapping in the
> + * first tail page, was not cleared, causing the error. To ensure that this
> + * issue does not reoccur as struct page keeps changing and some fields are
> + * managed by folio, this test checks that freeing gigantic hugepages does not
> + * produce the above-mentioned error.
> + */
> +
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
> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 1);

I suppose this may still fail if there is not enough memory or the
memory is fragmented, right? I suppose that SAFE_FILE_PRINTF() will
cause TBROK here, right?

Maybe we should just use FILE_PRINTF() and ignore the errors.

> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", 0);


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
> +	char *hpage_size_str;
> +	unsigned long hpage_size;
> +
> +	dir = SAFE_OPENDIR(PATH_GIGANTIC_HUGEPAGE);
> +	while ((ent = SAFE_READDIR(dir)) != NULL) {
                                             ^
					     The != NULL is redundant

> +		if (strstr(ent->d_name, "hugepages-") != NULL) {
> +			hpage_size_str = ent->d_name + strlen("hugepages-");
> +			hpage_size = atoi(hpage_size_str) * 1024;

Can we just do:

	if ((sscanf(ent->d_name, "hugepages-%lu", &hpage_size) == 1) &&
	    is_hugetlb_gigantic(hpage_size * 1024)) {
		sprintf(...);
	}

> +			if (is_hugetlb_gigantic(hpage_size)) {
> +				sprintf(g_hpage_path, "%s/%s/%s",
> +						PATH_GIGANTIC_HUGEPAGE, ent->d_name, "nr_hugepages");
> +				break;
> +			}
> +		}
> +	}
> +	SAFE_CLOSEDIR(dir);

We should handle the case that there were no large hugepages found on
the system. On one of my machines:

# ls /sys/kernel/mm/hugepages/
hugepages-2048kB
#

I suppose:

	if (!g_hpage_path[0])
		tst_brk(TCONF, "Gigantic hugepages not supported");


> +	SAFE_FILE_LINES_SCANF(g_hpage_path, "%d", &org_g_hpages);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(g_hpage_path, "%d", org_g_hpages);
> +}
> +
> +static struct tst_test test = {
> +	.tags = (struct tst_tag[]) {
> +	    {"linux-git", "ba9c1201beaa"},
> +	    {"linux-git", "7118fc2906e9"},
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
