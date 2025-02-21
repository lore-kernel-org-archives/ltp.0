Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131BFC021B3
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740128146; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=tGNbKT16Z/WPqN07igVPPCM5dxN83MLfUrlJOzK8Cyw=;
 b=BDmtCc5/R5ZYqPp2uqS5au52kCokwDbSTUmTNudve6rw0VCu40THnapZ7rTy1jo7YtRrr
 T1QR8gpnBqH0ZVasiMHhE9am8+bSCVrwLv5rYLIpKl1cichis9p+N+ajkRLmb7ak3PdfMGG
 s+vaZ3auCaD68Tz7PE646Zdh0QxIXT4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68E223C8153
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 09:55:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 233A63C0463
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:55:23 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE3491BD56E8
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:55:22 +0100 (CET)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5461f2ca386so1533973e87.1
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740128122; x=1740732922; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mxep2TIc1Qv+XCaPkiqvsbfUatWld9hJdRnR0lM5d9o=;
 b=IaM9T8h2yDnjWFTAmlpCKTfH9AgJl+hr8MlsxJddTe/IKEMkyozHxN64yJyDM/x0tJ
 fL6tezzkYXuDDX9E3VQUxl0bvMyon3V4bcZiDatTzqAQcwzPxbZJlOOF0FeuwpNIk0Uv
 xSifHOt7JIDwxud8O96S0uc6/20RkGjnyNIQmiVGjigCvV+zhROklU0awK0LgxFNRs1l
 3iu35irqBy+uELVpPhnkQzrNV4lijIcH7UW43jYgqZICAnmDuFzeVHLjXqxwDvcbs5rS
 q3Yc1BeaEsgoVrK4xrTFix9kREBRrIYYx2fmTa+MfNjg5E5OEWb2U+1eh5KRMftLsrVA
 AI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740128122; x=1740732922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mxep2TIc1Qv+XCaPkiqvsbfUatWld9hJdRnR0lM5d9o=;
 b=OdTnOiaKyvpOXcuBnA5UPDp/OxjTPWTD2TCFktXIsZnjxMhhjHSpHztuqsbJQLTxuz
 gh8xh501p2tDmgNtJh1ZgN2n59WgsDrSs/IamvlYCJnhxduEWdo3vPyj1LRn7/hWGmP6
 GAT/k2HNAeCVmJIyy9mBosO+LAYgq4ynDKa9PpuUcnQHqzYz2/9ukkBl7h4i4rz8tQZ2
 odb5G9QBpHemy2BxmOacF5MepL5RDyAVMN1HbXYVsNEM8NBXQApyViCo6omkpAowr81a
 6LnpScqMI7GE7dYFIdnvfnSldiKffUFf9GHaPGdtKUo7hej9ybl8aytCkVXgs6WY5Ymw
 EDWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc/wtAeNvuxSjPXWRGFtFNmX+HszH5Fmn0jVKUrgN1919GAM1dtIEoZbdczuBCusSfOdc=@lists.linux.it
X-Gm-Message-State: AOJu0Yyq5ZxoGctZsXpCLBCkaPG0nQm+tyQOEPUvb2OsDLQdcGB8X3ML
 viZIJ6Bdi21P5ABZuXVsO6lvyOTYuvlHQ1m/vWIDgqaVArQV+UIbdgOoi4fTWFHa2CHLTyPYa6d
 jk2E=
X-Gm-Gg: ASbGnct2Zy5AzOiTyrVwL3uS4gIs/gK1DpB9Y0PbGfnv2BGNrUFBJi6xyHWqDTjWr35
 ILPCWt/l08E0YIB4DqOmpgXAc3Q0tc6aMcylpIDo2N/gOsfAx6jOK/uFcsA3GcFejPjBrmosaiH
 yKOiv2uBWHolR3pAdG1ebFxk09+fHJxf/ZGyzojgG5CTUeT851qjLjVnvM1shJ2czfOwoM04lQy
 p51NeeRCwslN5dtvNzysbe3vkrASgiJvDqjlbMPgqf6tpBOHVQAJkPqZXc0XuTrY4tQtxZtrpeO
 +PxX1uWbj4zPzrACDWNGtgclz3QEGPO7KMEgze3gXpPo0JrLafVnBbp+mmDjiWX7yRMcf1tG4R0
 K7Agq8P1G
X-Google-Smtp-Source: AGHT+IHTi98wEIajw+l7dS0RWOFendBDK8CKkN6ZdYZ4cejWtlv3ckrRkZjhy06Y97cesPf316nq0Q==
X-Received: by 2002:a05:6512:3e14:b0:545:576:cbca with SMTP id
 2adb3069b0e04-5483912fcd7mr659652e87.8.1740128121992; 
 Fri, 21 Feb 2025 00:55:21 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5452f5cd1fesm2079854e87.238.2025.02.21.00.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 00:55:21 -0800 (PST)
Message-ID: <366aaadf-e189-461c-8249-a9b1d46cff55@suse.com>
Date: Fri, 21 Feb 2025 09:55:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: YouZhi Zhao <zhaoyouzhi@uniontech.com>, ltp@lists.linux.it
References: <B8632D9169E22850+20240902061218.39040-1-zhaoyouzhi@uniontech.com>
Content-Language: en-US
In-Reply-To: <B8632D9169E22850+20240902061218.39040-1-zhaoyouzhi@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fspick:add coverage for fspick01.c
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

This test is meant to test fspick() syscall, but this patch is actually 
adding one more check for fsconfig(FSCONFIG_SET_FLAG), which is probably 
the reason why this should be done inside an another test under fsconfig 
testing suite. For this reason, the patch will be rejected.

Best regards,
Andrea Cervesato

On 9/2/24 08:12, YouZhi Zhao wrote:
> expand the test items after setting FSCONFIG_CMD_RECONFIGURE to include re-fetching the mount point attributes and verifying whether the file system is set to read-only.
>
> Signed-off-by: Youzhi Zhao <zhaoyouzhi@uniontech.com>
> ---
>   testcases/kernel/syscalls/fspick/fspick01.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
> index d3309a912..7aabb1d9e 100644
> --- a/testcases/kernel/syscalls/fspick/fspick01.c
> +++ b/testcases/kernel/syscalls/fspick/fspick01.c
> @@ -6,6 +6,8 @@
>    */
>   #include "tst_test.h"
>   #include "lapi/fsmount.h"
> +#include <sys/statvfs.h>
> +
>
>   #define MNTPOINT		"mntpoint"
>   #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
> @@ -39,7 +41,7 @@ static void run(unsigned int n)
>
>   	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
>   	if (TST_RET == -1) {
> -		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
> +		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) ro failed");
>   		goto out;
>   	}
>
> @@ -48,7 +50,19 @@ static void run(unsigned int n)
>   		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
>   		goto out;
>   	}
> -
> +
> +	struct statvfs buf;
> +    	if (statvfs(MNTPOINT, &buf) == -1) {
> +        	tst_res(TFAIL | TTERRNO, "statvfs() failed");
> +        	return -1;
> +    	}
> +    	if(buf.f_flag & ST_RDONLY)
> +	{
> +		tst_res(TPASS, "%s: fspick() and reconfigure succeeded, filesystem is read-only", tc->name);
> +	}else
> +	{
> +		tst_res(TFAIL, "%s: Filesystem is not read-only after reconfigure", tc->name);
> +	}
>   	tst_res(TPASS, "%s: fspick() passed", tc->name);
>
>   out:
> --
> 2.43.0
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
