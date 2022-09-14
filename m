Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB544ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:43:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31FE03CABFA
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:43:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B241D3C1C21
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:43:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B0E851001172
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:43:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FE06336BB;
 Wed, 14 Sep 2022 09:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezYbpt9jQXkd9XMECgVunRlEixmmFnjmm+p8e+SiGXQ=;
 b=niEF6SuWNXH3xm4FCUXg+aaflDB4dFMV8J5phTFWEJQ3i7/G5X/dfASPYWT/x5NRZ556Tg
 qN7xqgUr3uI8xb3Yf4h50sM7lOdKBJZFHRpWCHwM7yeEsWQ3ES0RdqM9vB2Cpx+SzMwlM3
 E9JT5jxy6vTa5pKxnuwNm/gSePSNe0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezYbpt9jQXkd9XMECgVunRlEixmmFnjmm+p8e+SiGXQ=;
 b=isgFk67B8w7jxEI1tnII3SeeX+sdJ+p9fG2AwKuP8hhCi3lXJbe3MQWzJo6xKTT4KFjf/K
 Ncw2thPMOj8YiTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E1C7134B3;
 Wed, 14 Sep 2022 09:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9zTCIT2iIWMCMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 09:43:25 +0000
Date: Wed, 14 Sep 2022 11:45:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <YyGisrbDIgVa/0QA@yuki>
References: <20220913202839.1807979-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220913202839.1807979-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  	SAFE_SYSINFO(&info);
>  	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128L * 1024 * 1024);
> -	safety = MAX(safety, min_free);
> +	safety = MAX(safety, (size_t)min_free);
>  	safety /= info.mem_unit;

We can define the min_free to be size_t from the start as:

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 0d20bb17c..6fc9f6a93 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -20,11 +20,11 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 {
        size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
        unsigned long long freeram;
-       unsigned long min_free;
+       size_t min_free;
        void **map_blocks;
        struct sysinfo info;

-       SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%lu", &min_free);
+       SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%zu", &min_free);
        min_free *= 1024;
        /* Apply a margin because we cannot get below "min" watermark */
        min_free += min_free / 10;


>  	if (info.freeswap > safety)
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
> index c16b50a6d..f425c223d 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress01.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
> @@ -310,7 +310,7 @@ int main(int argc, char *argv[])
>  		anyfail();
>  	}
>  	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
> -		write_cnt = MIN(pagesize, bytes_left);
> +		write_cnt = MIN(pagesize, (int)bytes_left);
>  		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
>  			if (c == -1) {
>  				perror("write error");
> diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapstress10.c
> index 28b4f1e91..53f02c1f6 100644
> --- a/testcases/kernel/mem/mmapstress/mmapstress10.c
> +++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
> @@ -360,7 +360,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
> -		write_cnt = MIN(pagesize, bytes_left);
> +		write_cnt = MIN(pagesize, (int)bytes_left);
>  		if ((c = write(fd, (char *)buf, write_cnt)) != write_cnt) {
>  			if (c == -1) {
>  				perror("write error");
> diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> index 20151ebb0..7fe8fe14c 100644
> --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -248,9 +248,9 @@ static void calculate_total_batch_size(void)
>  	SAFE_SYSINFO(&info);
>  
>  	/* see linux source mm/mm_init.c mm_compute_batch() (This is in pages) */
> -	long batch_size = MAX(ncpus * 2,
> -	                      MAX(32,
> -	                          MIN(INT32_MAX,
> +	long batch_size = MAX(ncpus * 2L,
> +	                      MAX(32L,
> +	                          MIN((long)INT32_MAX,
>  	                              (long)(info.totalram / pagesize) / ncpus / 256
>  	                          )
>  	                      )
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
> index de9b4ea00..da445d442 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect02.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
> @@ -77,7 +77,7 @@ int main(int ac, char **av)
>  
>  		do {
>  
> -			bytes_to_write = MIN(strlen(buf), num_bytes);
> +			bytes_to_write = MIN((unsigned int)strlen(buf), num_bytes);

Again we can define the num_bytes to be size_t from the start.


The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
