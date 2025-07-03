Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C8C77B7C
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751504475; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LPJt+6oVkKi8zOgVozhphrV1cWHHs+YvwgGEX9wL09U=;
 b=MZd+yw5wVn91kMIIKImnf4hMUnf6WZNbcH5nGox6uNvgCi9BgB3Hl7Kp4AiElHL1jwLz8
 pPTOB9R16fzxLNG5fH7OME0Rl6+CQKcJNoXt2yvWJMlh9cqfFhn9Ch9lap+ta89fB8kjuMA
 qIWqDOi9yY7MNTzrQrN7qaRoUAEGtA8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17A833C918A
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 03:01:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F3583C7679
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 03:00:52 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D74A46001F4
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 03:00:50 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3071211f8f.3
 for <ltp@lists.linux.it>; Wed, 02 Jul 2025 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751504450; x=1752109250; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xpmPs5NlAyVaD1C571Bq58KClktvsPQDawh23kU3bl4=;
 b=NwFrfn9fHGHilKiG66/Hd8TwkeH1jH5hXE/KA5yR8Y7tF0Q1kz9JfqKjuH4a3cK5c1
 QM1n/Wo5Dj8AnMmo0QJw43eMmZDDmyTiGU9b+36Z59/RePmRS/c4sS0FHeY1enJtoeEG
 1DriwakOR9UmLLeZrQYG4yXZJFKPpKFFA698uz53kdmaM3iD1FSK4LvMA6IZiHWPG66P
 lDuxA3vXTFggpwmBNkAzqzaFV+LiHoowlJLMPkOLbD8u5P0eTTs2xGld5ic1VQup6tAw
 PHbRQXQnSrE9TuEhQpFY+pwxf/gTuqGFkrsq1+1wFMoHMf5zWpvq6RH9CxPGy8ZE4I4R
 3lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751504450; x=1752109250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpmPs5NlAyVaD1C571Bq58KClktvsPQDawh23kU3bl4=;
 b=tMEXTs3PVme4gPjwIjA7+OeCjUQUcG27XX5UWR/gsWvk+qBIrLePWOjrxR3OxO/yw+
 qtuCvYXEePTW/L4oQaeKy/YNoDxheOLIAzeLllIzP2PkOvGp50mTqFQmWk3L4r9tu4xH
 TS1vBmXU8nMw6dmY8BcRlDD6BZ0IbSZRZfJzV7Ge9taZzMJxtgp9TRTR9g4VXSI52X/Q
 n2FFXEYKKx/AadQNyuV8UcfillnxqgZb4ARGgeutAtHTCvnRvRloE4VHtsNULt3443xE
 g4ngSuW1X/VyNvmRAm4YL+NKlcVDJ5Q8AJ29tS5x+7V+bCOXkJHZVcdCaIfw5tFnthHu
 mZQA==
X-Gm-Message-State: AOJu0Ywz/hpyFRVFraIHmTIc9HiE1AD9uBwq7V9YXrwO/UbN92YJBRIV
 ccXvtjw8IKkZMKOvi11+G3lV9r4iPVAzp4/xL5tA1k+it/BT6idLvPZki86v/AW8nX8spX5PZ91
 gALg=
X-Gm-Gg: ASbGnctbaGnmxmiKRfSNcPh33GbPr0pNiCNSDshb1k3z0dG469xen/UxKPQrRF6xnem
 fCKz/4QUmRvCztM4BBc9KzwoJt+17ascO/EW/0tuh+i6H9DR15ehVRgdUpsenl4I2IPXv++BeRr
 /EKvt51/Zi7Hy8RlEsvsPNWFIFtZDmifxAiuE0DCKy1EQ+jJbsxSyhiCyRFFQRFR2QmCxA7OtlK
 f/ESU3muRvN1xNjPEdbNK5+LHkyUqLgT8nomhNTnvFbUwn4t65rJZgAJU8q4L20XjjXdpvlT4sF
 5PtCfYTEKElnNlttzCDuY0TM+oLkj3CTd8cAIKh0w68VypveU9Z9PwW17lsRGw==
X-Google-Smtp-Source: AGHT+IGjJlBg/X3Ng1JbnbgdngQivSC8OBd1/Ja7lFcXkys9FThLf5qEp8hcLcBD1g9og2I9GXh8Tg==
X-Received: by 2002:a05:6000:178c:b0:3a4:f918:9db9 with SMTP id
 ffacd0b85a97d-3b32db89402mr903680f8f.32.1751504450189; 
 Wed, 02 Jul 2025 18:00:50 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31a9cc4a419sm854088a91.9.2025.07.02.18.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 18:00:49 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:00:13 -0400
To: Mike Tipton <mike.tipton@oss.qualcomm.com>
Message-ID: <aGZ-3eoDE-XDTTPs@MiWiFi-CR6608-srv>
References: <20250630145128.1254269-1-mike.tipton@oss.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630145128.1254269-1-mike.tipton@oss.qualcomm.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] device-drivers/cpufreq_boost: Don't hardcode
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

On Mon, Jun 30, 2025 at 07:51:28AM -0700, Mike Tipton via ltp wrote:
> Some systems don't support boost on every CPU, such as on many Qualcomm
> chipsets. And if boost isn't supported on CPU0, then the test will fail
> since there's no performance improvement.
> 
> Instead of hardcoding CPU0, find the first CPU that belongs to a cpufreq
> policy with boost enabled.
> 
> Signed-off-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> ---
> Changes in v2:
> - Use proper maxspeed buf size in snprintf.
> - Link to v1: https://lore.kernel.org/ltp/20250626194707.3053036-1-mike.tipton@oss.qualcomm.com/
> 
>  .../device-drivers/cpufreq/cpufreq_boost.c    | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c b/testcases/kernel/device-drivers/cpufreq/cpufreq_boost.c
> index 67917b3fea25..bbb5f602de4b 100644
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
> +	tst_resm(TINFO, "didn't find boost-capable CPU (assuming CPU0)");
> +	return 0;

If not find any boost-capable CPU, i suppose we need give TCONF "not
support" message? Correct me if any misunderstanding. Thanks.

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
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
