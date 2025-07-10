Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE2C83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 00:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752108218; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Zsh0dedj1rxIbrA6KVRnSVP61Rj5J0xs/PH7Yn0xHfQ=;
 b=TPlZ1rhiXxWPnQFzf4MJykGAAbGV8ZlXPpy2Ha9W4WbSBERI7QB627y9T0FmiVYgaEx5Z
 P0zfmg3h+nV2qtNouigrfS3dGrx4N0Tv3tsIVY5DxC+P+KIJopmzL0ALfe+aXKVWn3JfQHK
 n9BQHNRh9Ze11BG4EmcQsrhCo0cuuJE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CCD93CAE5A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 02:43:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65ECE3C6DC7
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 02:43:17 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 002786EEEBA
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 02:43:15 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so295103f8f.1
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752108195; x=1752712995; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jm6hgQPsQU6fFkYZ2ePW8OV67mpp+UFVHWarrSLmEFE=;
 b=Rsy4G2UXUl8a0QwNgPZrNet8wWZ8eKeYMmWJuQs+Pk8uQR+Gm8dWTWoMSDIzBxKofT
 wiWzVtB/ecxBuXL1xq1I0lMLEmiefm6JODk5olWRR8TX4rJK3Fc60N57Uc9KuirU9+Ey
 /A49KltPHlspgbxTZBhZXfanWY7D1J8YRjkALNJlmT3IdA+KU50rLqpNdzevaSKuNDkz
 aXxQvEZM3Q93VKZuXOqCXwx59PeeCSKt33JFLSlEXiUaha451LnQ0wnRl3s7GS25EtCY
 qZ/tVbDQv0HddwEXYJC3FZ8lEqELGshMvEhw6W3TbOJog+jN4txb3Qj9/9/e/m07CDf0
 M02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752108195; x=1752712995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jm6hgQPsQU6fFkYZ2ePW8OV67mpp+UFVHWarrSLmEFE=;
 b=YEYd9nF6CNG27uoq6xFVeAUkDYrbUwXILfKQwwRT5WQBAf2meK8C7y5DdD+Hgxmaf9
 dbIMMxnROa/hu17Aif8BgbaM000ZIg9oIMx5Z9orVkRjCmsHoiUWsbTGfNsNu1tfCJPd
 Scql+RfxFBG/3eCbh+XNjzsz3HYvi8pVjrqI4EUEEsaemnD76OzOjx7nh2pCDmUQO8j6
 NonCiThUub5I8m5eR4XEpri9GCvMV03EMNbrhD4xYHJiPET6zsjOZMqIS/jBkTrnX4md
 GExGsj8uI9TP6RtYIlvSfh10QVa1r3XFYbdLO4+7rR2gF+8qr4UnWzoOgxmuS6Es6XAF
 sDuA==
X-Gm-Message-State: AOJu0YzHoipJ8/pBEElGaOmZh2vnsDMzuK6kEq9efB/bBA/ZGnctSblv
 WAJj05RROdBZumVszQSQOYIkvH+nOyDMXqggXzSUI4OItiYWW5k6ZDeryIuMVz9UjA==
X-Gm-Gg: ASbGncvdCNSmLFkQw42BrBdOAeXUM++wgFbSZUWi7bhpFp4HQQoMjHMA0O5bL4umLYx
 d9es5De2D360Lgzvmxl0n3hhDbb+UNZ3b8cvx2U2xJrWpA4ufYyxJOdcvbN61VTnAw/DuHUa81m
 ljyYEy5Lill/vk70yVDAiK0HqT9xnqEc5ZWJkVpHXe6odywWdepkpzawRKAXZObV1yStZDQ0n+Y
 NJk1sMf0OS9HyRv33teEr7PzpDssLZZVylnQCFnRnOs6Wxb75dTXfo9O/SiQD930N2vlrEYmlsA
 EhDpJ7n4SdyNDvMn8Hx3gX0w8uV82MNhTbnbn/yhaxsJr/oHnDB2jXe24SykNQ==
X-Google-Smtp-Source: AGHT+IGZsYpeMCWchRItLUuj4lWeD8wIGVg9EtBKPA5VTNb0dRW5JZk1HlqIXkWVQpb6hWxCkkeZdA==
X-Received: by 2002:a5d:44d1:0:b0:3a5:25e0:ab53 with SMTP id
 ffacd0b85a97d-3b5e86b2455mr430214f8f.32.1752108195285; 
 Wed, 09 Jul 2025 17:43:15 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de43352b5sm4169285ad.165.2025.07.09.17.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 17:43:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:42:35 -0400
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Message-ID: <aG-1OzeP-mB2MPq1@MiWiFi-CR6608-srv>
References: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250709151439.2840206-1-mike.tipton@oss.qualcomm.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] device-drivers/cpufreq_boost: Don't hardcode
 to CPU0
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

On Wed, Jul 09, 2025 at 08:14:39AM -0700, Mike Tipton wrote:
> Some systems don't support boost on every CPU, such as on many Qualcomm
> chipsets. And if boost isn't supported on CPU0, then the test will fail
> since there's no performance improvement.
> 
> Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> policy with boost enabled.
> 
> Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> ---
> Changes in v3:
> - Abort when no CPUs report supporting boost instead of assuming CPU0.
> - Link to v2: https://lore.kernel.org/ltp/20250630145128.1254269-1-mike.tipton@oss.qualcomm.com/
> 
> Changes in v2:
> - Use proper maxspeed buf size in snprintf.
> - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> 
>  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> index 67917b3fea25..17d89c0cc164 100644
> --- a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> +++ b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> @@ -55,10 +55,14 @@ static int id = -1;
>  
>  static int boost_value;
>  
> -const char governor[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_governor";
> +static int cpu;
> +
> +static const char _governor[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_governor";
> +static char governor[64];
>  static char governor_name[16];
>  
> -const char maxspeed[]	= SYSFS_CPU_DIR "cpu0/cpufreq/scaling_max_freq";
> +static const char _maxspeed[] = SYSFS_CPU_DIR "cpu%d/cpufreq/scaling_max_freq";
> +static char maxspeed[64];
>  
>  static void check_set_turbo(char *file, char *off)
>  {
> @@ -84,6 +88,40 @@ static void cleanup(void)
>  		FILE_PRINTF(governor, "%s", governor_name);
>  }
>  
> +static int find_boost_cpu(void)
> +{
> +	char buf[64];
> +	int fd, i;
> +
> +	/*
> +	 * The files we're looking for only exist for acpi_cpufreq. Continue
> +	 * assuming CPU0 for intel_pstate.
> +	 */
> +	if (!strcmp(cdrv[id].name, "intel_pstate"))
> +		return 0;
> +
> +	for (i = 0;; i++) {
> +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d", i);
> +		fd = open(buf, O_RDONLY);
> +		if (fd == -1)
> +			break;
> +
> +		close(fd);
> +
> +		snprintf(buf, sizeof(buf), SYSFS_CPU_DIR "cpu%d/cpufreq/boost", i);
> +		fd = open(buf, O_RDONLY);
> +		if (fd == -1)
> +			continue;
> +
> +		close(fd);
> +		tst_resm(TINFO, "found boost-capable CPU (CPU%d)", i);
> +		return i;
> +	}
> +
> +	tst_brkm(TCONF, NULL, "boost not supported by any CPUs");
> +	return 0;
I suppose we do not need above line since brkm will jump out of the test
directly.

Other parts LGTM, thanks for your patch.
Acked-by: Wei Gao <wegao@suse.com>

> +}
> +
>  static void setup(void)
>  {
>  	int fd;
> @@ -109,6 +147,10 @@ static void setup(void)
>  	tst_resm(TINFO, "found '%s' driver, sysfs knob '%s'",
>  		cdrv[id].name, cdrv[id].file);
>  
> +	cpu = find_boost_cpu();
> +	snprintf(governor, sizeof(governor), _governor, cpu);
> +	snprintf(maxspeed, sizeof(maxspeed), _maxspeed, cpu);
> +
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	SAFE_FILE_SCANF(NULL, cdrv[i].file, "%d", &boost_value);
> @@ -120,16 +162,16 @@ static void setup(void)
>  	if (!strcmp(cdrv[i].name, "intel_pstate") && boost_value == cdrv[i].off)
>  		check_set_turbo(cdrv[i].file, cdrv[i].off_str);
>  
> -	/* change cpu0 scaling governor */
> +	/* change cpu scaling governor */
>  	SAFE_FILE_SCANF(NULL, governor, "%s", governor_name);
>  	SAFE_FILE_PRINTF(cleanup, governor, "%s", "performance");
>  
> -	/* use only cpu0 */
> +	/* use only a single cpu */
>  	cpu_set_t set;
>  	CPU_ZERO(&set);
> -	CPU_SET(0, &set);
> +	CPU_SET(cpu, &set);
>  	if (sched_setaffinity(0, sizeof(cpu_set_t), &set) < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU0");
> +		tst_brkm(TBROK | TERRNO, cleanup, "failed to set CPU%d", cpu);
>  
>  	struct sched_param params;
>  	params.sched_priority = sched_get_priority_max(SCHED_FIFO);
> @@ -176,12 +218,12 @@ static void test_run(void)
>  	/* Enable boost */
>  	if (boost_value == cdrv[id].off)
>  		SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].on_str);
> -	tst_resm(TINFO, "load CPU0 with boost enabled");
> +	tst_resm(TINFO, "load CPU%d with boost enabled", cpu);
>  	boost_time = load_cpu(max_freq_khz);
>  
>  	/* Disable boost */
>  	SAFE_FILE_PRINTF(cleanup, cdrv[id].file, "%s", cdrv[id].off_str);
> -	tst_resm(TINFO, "load CPU0 with boost disabled");
> +	tst_resm(TINFO, "load CPU%d with boost disabled", cpu);
>  	boost_off_time = load_cpu(max_freq_khz);
>  
>  	boost_off_time *= .98;
> -- 
> 2.34.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
