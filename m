Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8550CD8CAC
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780991721; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lXyMlvt7v8pTHa3GYkXytNBAsGo11j+HnRD3o0bknCc=;
 b=NO6CoCqgZFAyx0Nxt7UBWShZ5iXugJBG7MNgKfKDpfoTMPxvwXXWwAywXickAz3CnZlc8
 /N9/xljXueX8LYz4N7uAcVOZgXul0U5zQToycK+s2bYIgWJ/R5PVDgDni/mAOpa68+0m6jG
 PzQxzLX6TQqhFtzH0sYRK+QvZ7mfdL0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BED663E2B44
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28AEC3C6F7C
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 09:55:02 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5EA831001263
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 09:55:01 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490d1e54b3bso15074005e9.1
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780991701; x=1781596501; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jufv9IVcbPOTPj2sfoog1olThZKFTRAsJjMG4J8kYFE=;
 b=DJ5s4W9XNBnbmPUUH6OGuc5hats1RvHFdLErUbrFavIpl289080kU5GtKZuzdAM2+F
 4t+WbTntyZfybMGeuHFvMy2/+2mBx0hFn3MTElLOmVMh+MNeuZU3+aSS2CVRZ/Sa/KyQ
 /gmNZymdb7brKho/gbK+JtqB7brNKbK8yelrKL6cOUaWvVkEyWnyQ8RxoGdg94W39MFy
 X1bkEXU3NqwQAfBggdc7+wnTUn2nyAaPI2vBvl/jsX60gjMcUiHAsIelTwO5U3LM2RZf
 mSamLvWnNfZ/fYj2a56N5hATby8jwXde4PkyWlcqs1kRyh4nfy/kvLI7hRSYqxqXgEIP
 VGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780991701; x=1781596501;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jufv9IVcbPOTPj2sfoog1olThZKFTRAsJjMG4J8kYFE=;
 b=mPZipDUev2Xb/ePIe0hNipgYAscM06MBMYZa26gfvuD3TS/vgIsPGyayDE6KmkPGDa
 Pi5K3PYhVA3OMOTbqLlvBrN6MHJQRqEpnCjAsO9wNdoug+9wu5+QxRe81tbo4oJi/bjw
 hstF3FJfX4oruxkH7jNN+5V+wazVFjIH1fFr9zEDX65NKksPud+j8IBBFQktlCPAz23j
 24PvJAbhBP255PMuASSwGz+aC/ocCMfpxkDIaBiQySS4xeHkCK60E6Sdfm8WYGvP1As4
 BZmpycAc5EAVhJ1fvac0fn/h4iSHD+T1FYn0jGCPbGz3cdMyoOfu33nZbToTfI2n14mG
 6qSQ==
X-Gm-Message-State: AOJu0Yw9q86DV/nnxr4f+ut11LYj2xefbYfmIarnUlMYw10LspZ0B5wp
 IBilDly0pVXfHxeYjJdwOdDhGz4mdU/7ayQa5q97zz05KgXDN8bsOxJD4mmI16SY4Xs=
X-Gm-Gg: Acq92OHuxy5fJ+XFXILAfsitNIrWOk+xwrrmAQTOxVszPsApq7LV48X5PNUnStgAUrS
 W9A5VlaRYXHT5LeCpoGAfc9HYbTOauIIQym4cMrNaNnAnZy2WG3zQg27Gal/Wf7kFOf42fIjw/5
 VPvowd4hHb6yyGoeZAFKf0ps3rdP4ofW5VhaX6mm/K6h9J+r9EIGlnObrwT1y0kynXLgI8W77BD
 UNjSYmoxjWGJ/gCOz6OhRUkFLNe2YAVJKCcGRz10Dy7PI8htqanYynE7+slRpgBVEFdJkJN5xSI
 QU2WgVNpThsZo6l7h6LhbvhsQnaGucqj4r7UIy9qb9ozl7BxnqphZ8/bBNx6Zq3edrux1Ah/AJA
 u2OTYOFK6Je/xcrbXvVZFJODVlvJHlOprNSjglINWdtGpBwzdqrhs7yyOmAoX7Kpxc0+PV3nqUY
 H4aJJe0UwIeKRCnM8l5xSNL1O+v5m/iGzSnsIQJG+0uNTt1MaEiDdN6X371DggLFY1KFhrwMXV/
 Z6+DC+EtA5rvLPdOS9GczaqYxZziHSmfjBVOyM2cGt1VA==
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id
 5b1f17b1804b1-490c25c20e0mr294181995e9.24.1780991700578; 
 Tue, 09 Jun 2026 00:55:00 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d60a7csm42297065e9.2.2026.06.09.00.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:55:00 -0700 (PDT)
Message-ID: <6a27c6d4.e3606774.7bf52.3c44@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260420102339.729745-1-pavrampu@linux.ibm.com>
Date: Tue, 09 Jun 2026 07:54:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix hugeshmat05 test failure on lpar with 1GB
 hugepages.
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

> +	tst_res(TINFO, "Page size: %ld bytes", page_size);
> +	tst_res(TINFO, "Hugepage size: %ld bytes (%ld MB)",
> +		hpage_size, hpage_size / (1024 * 1024));
>  }

[...]

>  
> -void shm_test(int size)
> +void shm_test(long size)
>  {
>  	int shmid;
>  	char *shmaddr;
> @@ -56,7 +60,7 @@ void shm_test(int size)
>  	}
>  
>  	shmaddr[0] = 1;
> -	tst_res(TINFO, "allocated %d huge bytes", size);
> +	tst_res(TINFO, "allocated %ld huge bytes", size);
>  
>  	if (shmdt((const void *)shmaddr) != 0) {
>  		shmctl(shmid, IPC_RMID, NULL);
> @@ -69,13 +73,23 @@ void shm_test(int size)
>  static void test_hugeshmat(void)
>  {
>  	unsigned int i;
> +	long multiplier;
> +	long tst_sizes[4];
> +
> +	/*
> +	 * For large hugepage sizes (e.g., 1GB), use N/2 multiplier to avoid
> +	 * excessive memory requirements (4GB for N=4 with 1GB pages) while
> +	 * still testing alignment boundary conditions with multiple pages.
> +	 */
> +	if (hpage_size >= 1024 * 1024 * 1024)
> +		multiplier = N / 2;
> +	else
> +		multiplier = N;
>  
> -	const int tst_sizes[] = {
> -		N * hpage_size - page_size,
> -		N * hpage_size - page_size - 1,
> -		hpage_size,
> -		hpage_size + 1
> -	};
> +	tst_sizes[0] = multiplier * hpage_size - page_size;
> +	tst_sizes[1] = multiplier * hpage_size - page_size - 1;
> +	tst_sizes[2] = hpage_size;
> +	tst_sizes[3] = hpage_size + 1;
>  

Are you still working on this patch? If yes, please update it according
to the agent review, before sending a v2. Also, in LTP we have TST_KB,
TST_MB, TST_GB, so you can avoid using `1024 * 1024 ..` format.

Please rebase to master and send a new version, I will move this patch
into Changes Requested before proceeding to the proper review.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
