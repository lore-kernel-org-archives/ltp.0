Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75967C624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518623; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=P5N/LngPhcF+6+9QuKbnzQlxbG9HO/RWY9N/WYhVzr3dcp5eMiJbKOjgUOaXioC0cfApl
 qhjXs+jxTS6s6bpTBe+sReLqf0nawiyD+SzIi/60clw/bg86HO3a5yFLLMd2BE4PFWJhJyN
 /5rtyZ5L5cHlXxDNDgzbt8Nwqnw/5jc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710433E975D
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:43:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89CED3E4B98
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:43:23 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDF2E1A006AC
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:43:22 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so534125f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518602; x=1789123402; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BSkCGegvNu6QOxkd5jZil0C5nP24XqEYrSbDUwIvZvbv9dHfVGTT6vRkrupQGtXjix
 rDfLChQO2vW2q6FD9gxReRn+1rm82yEFUVaaBjDxwmlpSqzsJw6CrmFvRSkXMtR1gR6u
 Ci60TO+vXKTWZL/9hWtdkbi/2rvUP9XSh7cdPqu6f3hawlfXn0cDX7W73EeR8Wuqety5
 6zPIpcLf+XwPvAyiN/nDtoME27d1ZcP7x6YUlCiCFMI1rrL+9N3mMBYNyexCVil1Xw29
 lmkQtxZooIc4APuZwhlYT/VJdwVkanlBq6y/GbL8K0PJ9FU1Ejx7nJohWI1KYS1001Ix
 8ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518602; x=1789123402;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=KYIL4ww5tVEs8O4zmupNi0AHQH/OdP4yKLMkJUGJnJIaG2Ud9p3jZMRpS+wdAd6WPn
 PBPqByozVJYm9VwDTVXcC2KxZrggXNt9SOr0ToE9eAUDQzUuOhmMaUt7T6zr59U9Cri0
 ZQL3ANizyJGfdXGJLl0ZKljhK8K4DeOsUb/8oTgilzPfcMRgsFkPO4JNf7x4dL559V3K
 gpdB9nxS86Cmcc0Q6q06TEBXOhFgZMuwCu8fikgD0zWYj8sanbKJ+hxBAcTm/+RiIWwY
 73Hhr9V5oP65gaqysaWkZactfj6P6YUP8LIfkOAXyXjUm7dc5zRFm7EydXy9rmADc8s0
 OthA==
X-Gm-Message-State: AFuF++kdin7hQxRtcrvsKe/23L0rmCs+43S2T90guKBqzEmLaA9IAhTR
 y5vpyGoJFI+Q1Ufy+/nvOEePnGsysPAtFBhscMH1ZFWK9kzDVu8ZQ2bd7eVVR3myFzM=
X-Gm-Gg: AYBFou11oVoJTjSTKhU/2bHLK6P71Rg5oyJsAGPXn7cxr8SoRPBhnGpH7vgOi+1UGjI
 Hlul3vr+sR3EVcgtnF5Ir4u5/hky1OO19VdKry9yeS3Ijh1wDkxcTT1f4S3vtfziaVD+ieKg3Pb
 W83/8235dDs43F2KL+OI4kqK6dn0qJ6sZ3pcajj4qOoYcd/HJWVqBtA+EyEKGX+sYF4aAryQEAw
 zJVGmg46dw6pkQJxqCFlkUhpSM2j7YQWuC/2l2Ap44zqpSGzOoG76dMSMh1uxEO/sH8SjQrrSd4
 hKQNVWtc1wknrrHtxs4Ym45ziKI7jxIxfll1gDWSwV7cK/Zcswk6e0GhpJBvk7TTi2V3XjipvHr
 0jgzDI6XGAxf6bcsidVgGtHuG44DuTV1DlfgHJpC2zhw3wOlu3bIgd2ULpwIGz981TONbtAgRWk
 tRWeD4QdOQZEDRpxmlc5HXQV9EEAQEgo32eT0tx30noBQqQARzyuq5JuSTZ3FlEaw9993dCycGD
 auexXli7be4FZLqGww1wlU=
X-Received: by 2002:a05:6000:1843:b0:485:8c17:975f with SMTP id
 ffacd0b85a97d-4858c1798damr2419431f8f.33.1788518602216; 
 Fri, 04 Sep 2026 03:43:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm5021618f8f.31.2026.09.04.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:43:21 -0700 (PDT)
Message-ID: <6a9aa0c9.c69142e7.327fff.df7c@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260902025816.3915-1-wegao@suse.com>
Date: Fri, 04 Sep 2026 10:43:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Use memory.high in cgroup v2 to
 start swapping early
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
