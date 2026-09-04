Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05E0C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788526341; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3OTT/Z+hGR1ZDz3LorV9onkTvD5sDu1jafhUbcVVfXU=;
 b=MJGWeBEnOYM13i767SpQkelEz+stLlCFtW45pCNkAs5t2x1MmK2cZAWfnTvE6zA6pxE34
 BBV19sUDKmFbddB1cBeg1JPvAVpnolbdZFogDMAggSLQPWUcnQI7xR5pP4hmJQd0JDHKh4k
 RgRXLYYpj7spNdvHRvjCvWw1jLAypDw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42F233E935B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:52:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E37553D86E3
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:52:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8D2181001137
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:52:00 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8445045e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788526320; x=1789131120; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=krOHpomjjuuw9hbXPe4XAMDa1FEaluGUSr4pVgjwF6Y=;
 b=OzZcHnhxEMX4bLdleLgtTrk5ksNDZN7mYZT86N/8eK/jtDC/gK7M8i9Eu21dtJK50r
 NU7lo8SRxl2j+H5PqYUlI2gRLpElOIGLeZojL755/lcSJLfBIrjanTgVTab5vAP4BOjR
 d5SS92qNT0SgsBE58A6dh0tb5EycLzgBNjj06snRJmPHZ27NhtIagdxoGGkO6YPn+ZwY
 UOwTQSfopBgYzrx8l1xfWYGIaPAW52S3XDytBcYP0Yk4FQ8styu+T1TT490mLyU8+vO5
 pLbOtwx076w4KbFdQNwfvkKMzH3Ng/NVyk1u/wIv9fCIvb98GZU1jerCC64DlyTkMsfp
 3F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526320; x=1789131120;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=krOHpomjjuuw9hbXPe4XAMDa1FEaluGUSr4pVgjwF6Y=;
 b=pU75wQSlcZkNtjE7Cr2bgnmHCdmadHXr3hSxnbqeLAiJMU4uJsA4gmZAGxz7wRdgfX
 W9YaEwcbXUmZsOY9Qip5BDY/OwtoJPsk8PlKdLnVJj3xZA8XhtzBbqHd53FO88Pe2kJS
 th9DGiCw+9Hm7VZBRxQn7YTsVf96L8ErDspuvR3Pz10XabFcNA3sfh9VVo6DisxXS5P4
 GpKIFqcCq0wDwhfkHU+SRyJ43rsxCROMzOUL9nR12JJYa/mpGvLUV2OleCC5xTzuDJ/G
 p8wjkCIG1uYUwThwuSKuELdZHGFBapQSMCepWZ9ppkQ5LhZa+WsbBddctQc0GkL+KxH8
 GxiA==
X-Gm-Message-State: AFuF++n0bhoN092c4Ki7LP2akVFKmT0ckQv2mjqrQwbbiatMHNELaU7u
 QEx82KuNhxggZkH/b2um2VcXzHyEgiDVrhRCcLG1VEczr6l7KB2QLpXShPHybuFiwo6aVC3aB4H
 wOGuAb+AGmQ==
X-Gm-Gg: AYBFou0BaAWNMm3U74LTp1vmnbbE1gLkAByu6pOUEeRrlLdETS0pOi54ZYKR7X4GOwN
 lTrbPkAgltmwzdDUb1CVi0gs25jqJiqXmg/r6U/ghXatHldHszkzLzAqxbSy4DT1XtTmxk1O8sq
 1oQ0oyIrlxCohKHHISPqBL8JMlaL+0aYlwhKlK1v0KnAAZiVG9itXdjlbwUQB1Y0pac4Ajs7QcL
 9GhGbE13P39h38BCY351Vm3ovcH65z61tlQOEFM8qQjn7q8XJZRakceHkEwqC/vfm/bS2fgrWw3
 uJqCEjnF//InpnyA8F11Nau6zvP2QzxnGFWqapVYPDgDqxo+BSuWuuQaBtChsOkITT1OoWxWYo0
 1q3L95QgnPFvNOH6xTCH14F38KNECU7AHxASMiDL34iEwPYs5QuzZGY/N5d8AkHFVpMFnd6+thM
 gX+tukhs5u8kN9g4vvSkd7cEIsQQNv4qDLgolrRjft6nCUH1PtvIomPTDr4SUemoMAYWaU/8FV5
 Y4+tFwX0g3btOhyCcAML0g=
X-Received: by 2002:a05:600c:4881:b0:49c:f13d:ffec with SMTP id
 5b1f17b1804b1-49cf13e05cemr76429195e9.16.1788526319904; 
 Fri, 04 Sep 2026 05:51:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm7301397f8f.12.2026.09.04.05.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:51:59 -0700 (PDT)
Message-ID: <6a9abeef.14e24f9c.2590a.fec3@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260813052853.22152-1-wegao@suse.com>
Date: Fri, 04 Sep 2026 12:51:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] fsconfig04: Check FSCONFIG_SET_PATH
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> +#define MNTPOINT	"mntpoint"

this is never used

> +#define LOOP_DEV_SIZE 10
> +#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
> +
> +static int fd = -1;
> +static char dev0[PATH_MAX];

the static dev0 buffer and strcpy() are redundant since tst_device->dev is
already available

> +static char dev1[PATH_MAX];
> +static char dev2[PATH_MAX];
> +
> +static char device_option_dev1[PATH_MAX + 16];
> +static char device_option_dev2[PATH_MAX + 16];
> +static const char *const mkfs_opts_journal_dev1[] = {"-F", "-J", device_option_dev1, NULL};
> +static const char *const mkfs_opts_journal_dev2[] = {"-F", "-J", device_option_dev2, NULL};
> +static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};

these static buffers and option arrays can be replaced with a small helper
function that formats -J device=%s locally, eliminating global mutable
state and setup() string formatting.

> +	if (found)
> +		tst_res(TPASS, "Device found in journal");
> +	else
> +		tst_res(TFAIL, "Device not found in journal");

the manual if/else result reporting can also be simplified with
TST_EXP_EXPR(found, ...)

> +
> +	pclose(tune2fs);
> +	SAFE_CLOSE(fd);

SAFE_CLOSE(fd) can be called immediately after FSCONFIG_CMD_CREATE,
freeing the kernel filesystem context before invoking tune2fs

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
