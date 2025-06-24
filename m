Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F0C77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750747257; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HyI8ErnjJwhS6KJWNcxxzieVeYz3q3+0V4Mag12AHFo=;
 b=AQSQNGgFbgMf6TFwsU010Uu5sjXWgQ0jOsZnP+OAw5/prPmsmFfNQv3aGofKRgFkZwoKS
 ASZIqgED0eaozXAxGoz12N5wwGvOtn39RDJXFXIym6BPSO27ZeU3R/WEQ/3k+DvucRwSP3y
 Bz0ozlV5/SDhL4/ssAoqEssQD9mmfwk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 825513CCAAE
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 08:40:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5A5A3C0E42
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 08:40:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 755B3600D0B
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 08:40:35 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453608ed113so43226595e9.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750747235; x=1751352035; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C1vYEEWaMf505Z5HJFo+In+GKZxKmJoILAGPKf3XeJ8=;
 b=aiyfzLE8ONWCKdtEkMCXhnQckhS1EAMDDh3o9mQ/p4COygHzKVJ66rj5KnIDPYBWY7
 QH8sLUBOxz7ToodxctNaLauZLQuavB7xoyGY7088R6Yj0/7Q9p0EX+KvmyiTCg4iN2WY
 uTdlSlCqAzVXkAAc1V6tv3DpMvVCO73kSCXBgwGxXhWTX5Mmm20cSmm6ThpTjBjhhRhd
 mOeOIKF+W2Vwon4n4yef4NJJiqUPA6ZUNVCC/mLCJkE1mQd5AGXlwf8OyzFbKBxLyowt
 cXgvoHC2eRJoLl3/iQDtLJi02A3J0PFUQPUzRA+WMm2LGoCSs04XDYPwyCLGVxxNUzQD
 WWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750747235; x=1751352035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1vYEEWaMf505Z5HJFo+In+GKZxKmJoILAGPKf3XeJ8=;
 b=BjKmF+p/KOfeMnfKGK00ProIAsWW+/CIU1O1SZaFzOaRYNHc49rAKT+9Y8eV9tpTK+
 buftxKU8fv+0uNQPX+3MEC9TxGqChEdL9aX4S6pNuvzpw+kCWE8aXT/DRkzH1u9Y8KSW
 QUzluhGgIikJ8EHsGoUmSXIo1GUUD5bOJdZRJ1Y6YRa7iw0Rv/QkoeE9sEaiLg0nXyXJ
 Q0ZQuKyiBIu8bZMiLtY2B4p3TqOwKjG7xE6vb1rdVr3B6Z9O6Ilk4WQIAe9DFUG/z+PS
 acFcA6pKTci3JBlUGGqgwY6Odwp1xM6GnS/t9YJjSN/3jknMwqmeUrZSTHtVJLuZcBey
 LH3A==
X-Gm-Message-State: AOJu0YxxMZstWsh1hzI0yZc/zFwNXdkvo6xnevsa5v2Xfu0UBm+b/j8V
 DemBVQf9CtCPE5cRanZpFwPPOz98klNzIOV69uMk00hI1l+BF/YCbQWaqyWDoAJzYw==
X-Gm-Gg: ASbGncsJk4D7/jMb2DZs1314MtgWsn2KpjiazUBVMg/+VmNcJ/Ox8iJ/+m6oTKI0Nar
 mgjQSX3m23276i8KD1+EQdaSX8bCybnvTtwpmbggC4JfwbuRmrXGl0988We8Lw7afAQJRoxGbIV
 rouuHLeM3NzJ5QMcYcg5m9ZvOxFHgW5GKBVG+dk7p0EmiN62BwjmYVUcG0r0qSetrzv6AbW88u8
 nyiiKXtjP9062ZZnPbTps7mrARBG9TWxmegQI4NW9GmKKxTGd+OsyYq7JJ75gQXmUKBV8e4HzQV
 w5sH/qC9dzmkx2vYXw3SUFVh3hD+F8uIhXsOpD3LqUJ0BHEMK0WF7JbcGItztRcr270ioyZ2
X-Google-Smtp-Source: AGHT+IEGVXc5sHj/ttSEM+8nh6GF/7xlmll00JkJegFxmpwduuX9FfKPQYLInGVTspJa6aG1yx+aRg==
X-Received: by 2002:a05:6000:2709:b0:3a4:dc32:6cbb with SMTP id
 ffacd0b85a97d-3a6d130710emr8609213f8f.31.1750747234721; 
 Mon, 23 Jun 2025 23:40:34 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f126cc0asm9639126a12.76.2025.06.23.23.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 23:40:34 -0700 (PDT)
Date: Tue, 24 Jun 2025 14:40:04 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
References: <20250623140210.32347-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250623140210.32347-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 23, 2025 at 10:02:10PM +0800, Li Wang via ltp wrote:
> When LTP_RUNTIME_MUL is set to a value < 1.0 (commonly in CI or fast test
> modes), the effective runtime of tests may be scaled down too aggressively.
> For some tests especially those relying on probabilistic triggers or sampling
> (e.g., fuzzy sync, CVE stress loops, long fault injection), this can result in
> too few iterations or missed conditions, leading to unreliable results.
> 
> This patch introduces a new field: .min_runtime;
> 
> If set, this specifies the minimum allowed runtime (in seconds) after applying
> the LTP_RUNTIME_MUL scaling factor. The final runtime is calculated as:
> 
>   MAX(runtime * LTP_RUNTIME_MUL, min_runtime)
> 
> If min_runtime is not set, a default minimum of 1 second is enforced.
> 
> This approach replaces the need for special flags such as
> TST_NO_FRAC_RUNTIME_MUL and provides a more systematic, flexible solution.
> 
> The following tests are updated to set .min_runtime:
>   - preadv203
>   - cve-2016-7117
>   - tst_fuzzy_sync01
>   - tst_fuzzy_sync02
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Ian Wienand <iwienand@redhat.com>
> ---
> 
> Notes:
>     v1 --> v2:
>     	* replace the .flags by a new min_runtime filed
>     	* set 1 second as the default minimal runtime regardless
>     	  LTP_RUNTIME_MUL value
> 
>  include/tst_test.h                            |  9 +++++++++
>  lib/newlib_tests/tst_fuzzy_sync01.c           |  2 +-
>  lib/newlib_tests/tst_fuzzy_sync02.c           |  2 +-
>  lib/tst_test.c                                | 11 +++++++++--
>  testcases/cve/cve-2016-7117.c                 |  2 +-
>  testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
>  6 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 6fd8cbae3..9c21c1728 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -460,6 +460,14 @@ struct tst_fs {
>   *           (e.g., TIMEOUT_MUL), ensuring consistent test duration across
>   *           different environments (e.g., debug vs. stock kernels).
>   *
> + * @min_runtime: Optional lower bound (in seconds) applied after runtime is
> + *           scaled by LTP_RUNTIME_MUL. If the scaled runtime is smaller
> + *           than this value, it will be clamped up to min_runtime.
> + *           This is useful for tests that require a minimum execution
> + *           time to gather sufficient samples or trigger events (e.g.,
> + *           probabilistic or fuzzy synchronization tests).
> + *           If not set, a default minimum of 1 second is enforced.
Base your logic once .min_runtime is set then .runtime value effectively becomes irrelevant.
So i guess we need mention it in above description?
> + *
>   * @setup: Setup callback is called once at the start of the test in order to
>   *         prepare the test environment.
>   *
> @@ -584,6 +592,7 @@ struct tst_fs {
>  
>  	int timeout;
>  	int runtime;
> +	int min_runtime;
>  
>  	void (*setup)(void);
>  	void (*cleanup)(void);
> diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
> index b1390f460..16f30de57 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync01.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync01.c
> @@ -246,5 +246,5 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.runtime = 150,
> +	.min_runtime = 150,
>  };
> diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
> index bc079f6ff..3b0fb8a9b 100644
> --- a/lib/newlib_tests/tst_fuzzy_sync02.c
> +++ b/lib/newlib_tests/tst_fuzzy_sync02.c
> @@ -223,5 +223,5 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.runtime = 150,
> +	.min_runtime = 150,
>  };
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 495e022f7..75a78be9a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -627,10 +627,14 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
>  static int multiply_runtime(unsigned int runtime)
>  {
>  	static float runtime_mul = -1;
> +	int min_runtime = 1;
> +
> +	if (tst_test->min_runtime)
> +		min_runtime = MAX(1, tst_test->min_runtime);
>  
>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
>  
> -	return runtime * runtime_mul;
> +	return MAX(runtime * runtime_mul, min_runtime);
>  }
>  
>  static struct option {
> @@ -662,7 +666,7 @@ static void print_help(void)
>  	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
>  	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
>  	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> -	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >=1)\n");
> +	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >0)\n");
>  	fprintf(stderr, "LTP_VIRT_OVERRIDE        Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
>  	fprintf(stderr, "TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
>  	fprintf(stderr, "\n");
> @@ -1996,6 +2000,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  	uname(&uval);
>  	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>  
> +	if (tst_test->min_runtime)
> +		tst_test->runtime =tst_test->min_runtime;
> +
>  	if (tst_test->runtime)
>  		context->runtime = multiply_runtime(tst_test->runtime);
>  
> diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
> index dbec2b28b..8c488f447 100644
> --- a/testcases/cve/cve-2016-7117.c
> +++ b/testcases/cve/cve-2016-7117.c
> @@ -151,7 +151,7 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> -	.runtime = 60,
> +	.min_runtime = 60,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "34b88a68f26a"},
>  		{"CVE", "2016-7117"},
> diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
> index 72a35d3ab..472543e5c 100644
> --- a/testcases/kernel/syscalls/preadv2/preadv203.c
> +++ b/testcases/kernel/syscalls/preadv2/preadv203.c
> @@ -278,6 +278,6 @@ static struct tst_test test = {
>  	.mntpoint = MNTPOINT,
>  	.mount_device = 1,
>  	.all_filesystems = 1,
> -	.runtime = 60,
> +	.min_runtime = 60,
>  	.needs_root = 1,
>  };
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
