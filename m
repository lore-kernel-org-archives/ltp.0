Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAC4C433FE
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 15:16:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EC103C6D41
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:16:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203693C688D
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:16:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4251C2001CE
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:16:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D63021EDC;
 Wed, 16 Nov 2022 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668611762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jd/Diq87IpbFcekj6pqJ0xkyUmuKLluQJ/P3rWG+F3o=;
 b=gw1Wof2RlmJDzES5D9suVj/9UVugfVV9PL/XbrYM56NLwkXBWue9RVb0/Xm1rLIbjaWy0V
 R8SCar0mbCklWKMSQiBtEoqTiK0bUqOWzDQ/2UppcYH7D53YxPyCe/25hKDbsqq6b0C2aW
 3Acy8/MmfvJ28x7PVp0ZnqcfmRqXDuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668611762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jd/Diq87IpbFcekj6pqJ0xkyUmuKLluQJ/P3rWG+F3o=;
 b=U892rI2yqizrr3HF2s67d2vGOhjGkRH9RP3O0zJgtYAdg7iO+j8Rhih6FoR4UH6lMJOrCm
 8V8gEhPQAd8eQcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61C4413480;
 Wed, 16 Nov 2022 15:16:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id J0tCFrL+dGMQagAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Nov 2022 15:16:02 +0000
Date: Wed, 16 Nov 2022 16:17:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y3T/BmR+XIgWvClD@yuki>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-2-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116112516.261535-2-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/7] Hugetlb: Add new argument flags in
 tst_creat_unlinked
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Some test requires custom flags for file opened by tst_creat_unlinked
> along with O_CREAT|O_EXCL|O_RDWR. This patch creates support to pass
> custom flags in tst_creat_unlinked.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  include/tst_test.h                            |  2 +-
>  lib/tst_test.c                                | 19 ++++++++++++++-----
>  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
>  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
>  .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
>  5 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index acf2421de..a62515bfe 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -365,7 +365,7 @@ void tst_set_max_runtime(int max_runtime);
>   * Create and open a random file inside the given dir path.
>   * It unlinks the file after opening and return file descriptor.
>   */
> -int tst_creat_unlinked(const char *path);
> +int tst_creat_unlinked(const char *path, int flags);
>  
>  /*
>   * Returns path to the test temporary directory in a newly allocated buffer.
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b225ba082..d17b15ee8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1027,18 +1027,27 @@ static void prepare_and_mount_hugetlb_fs(void)
>  	mntpoint_mounted = 1;
>  }
>  
> -int tst_creat_unlinked(const char *path)
> +int tst_creat_unlinked(const char *path, int flags)
>  {
>  	char template[PATH_MAX];
> +	int len, c, range;
>  	int fd;
> +	int start[3] = {'0', 'a', 'A'};
>  
>  	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
>  			path, tid);
> +	len = strlen(template) - 1;
> +
> +	srand(time(NULL));
> +	while (template[len] == 'X') {
> +		c = rand() % 3;
> +		range = start[c] == '0' ? 10 : 26;
> +		c = start[c] + (rand() % range);
> +		template[len--] = (char)c;
> +	}
>  
> -	fd = mkstemp(template);
> -	if (fd < 0)
> -		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
> -
> +	flags |= O_CREAT|O_EXCL|O_RDWR;
> +	fd = SAFE_OPEN(template, flags);

I wonder if it would be easier to add the O_DIRECT flag with F_GETFL and
F_SETFL fcntl(), but I guess that this is fine as it is.

The only potential problem I see is that setting the random seed may
interfere with anything that would print what seed has been used for
random data in order to be able to reproduce the same random sequence if
needed. So maybe I wouldn't attempt to set the seed in this function at
all.

>  	SAFE_UNLINK(template);
>  	return fd;
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> index bd0fb440a..3122d5b9d 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -113,7 +113,7 @@ cleanup:
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> index ce40e7b69..f66b331dc 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -118,7 +118,7 @@ static void run_test(unsigned int test_type)
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> index 1008395a4..ceb0f64a1 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> @@ -60,7 +60,7 @@ static void run_test(void)
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
