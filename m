Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A782DC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788507339; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kvYBWcqmMR6zNhpbTGvpQh3eFYAGHSEH8hJfm2OLjlY=;
 b=WKRA8RiDnbpKYyACS42MHlID75mQb4ALzGnwEhTECLAMkdTmwMJCKI31VtZL9IbIzeZVo
 RIhH2dBWso0XvKLJTgV1lDkMgAw8Wr7PSHHCbLiuAdd/PEEYQAg26E7Py7ya5cUmTy4GSv5
 6Wb+7I9BGfSyYrDZA7fu1DK59mHjlxc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7ED23E9370
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:35:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3AFF3CE9EB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:35:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48623200DCC
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:35:19 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so432992f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788507318; x=1789112118; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bTFacvnrAewRX25usihWdIJHYt79ATrsK8HVBgztRc0=;
 b=DaKB4S6Tv6DZA2V29zCxkQQHhDGtAzuJ8lHBG0jhX2Dha/KoLzgJR2qQyuBD5XvbT1
 OnqAS+rXZ+7eO0xktlIKpZhPFKv1byb3YID63cQrVuFrzFDdiZ3kuaEznTiXyAQsChYO
 /x9PNlmQmSXvmx09ESH8AvY9CQAfaUC3+GuwDf7N8ARHHDXawpMUaqX9cfoIbNwIWSqV
 aX9k8xUhOP5fwC9DPLDdq29sePG9ju9SEsrDL5Y9u0O2I+pRgsGa7B/mjmkGBEdh0y7Y
 SWNmnLXjH+2KzdySAwpNqS9PouEzR11c02x2TLNy9HriXqMyqOpy7SEVfcB7gRk2AmBH
 Me1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788507318; x=1789112118;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bTFacvnrAewRX25usihWdIJHYt79ATrsK8HVBgztRc0=;
 b=S/MGr4+hG1ciyPsm637iogT5IsSeYIVXS7+F1O8EW/9S190ssUu4mbqW6RGWkF5lMB
 7X1lAR13AHylI1NLQiNwPUQXWvPUqTY4iDYG2roZBcmCy37Q8XYr91YLYdDJF/8TcL3N
 mY0iDUZlIaGJu2X4PF/EdaUA1j2g96ozJN3goDuO82czLxLOneh+LM2ZW6xNePvh8ZKv
 fS7Q2ypdfJSQaIiN5Fr8XzcFjE9i2h1e3AZZ5/rFY490L5+fBzdWxcWw9DqMheUFXfsC
 1BPHfooiXP+sg+fKkRwWdz8jByx3/VSHE+84vbmgP4RXlBmNGRbbzhFJEn153sD8iEZs
 dwBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQVpYKUlX+x5wjn6I6L4WEIWMry3kLU3wrglIPKjOE5pEf4s3DPRABFSoWFt2zHN2V4ow=@lists.linux.it
X-Gm-Message-State: AFuF++lgkDw7ePdLuYPtYAbdGJO1xcgM2M1I1Q66UOKXyjH/ddRFy3lW
 spWR+K3ModPrOSHmxJIPBedgu06XdvbhXQd7yhyqj91Pu3JSK3ERpGJWJwWlZwMRFCI=
X-Gm-Gg: AYBFou1G24UJg1hTsfvpInMipscTKW7IeN+Qa3zpZzK63YAaw9GQAwhefhgPF1HcKhv
 pQnX+WgVDHBcwsM1ug5OZ7ZR4BgUMtAw9YzisfF0pUVpfthHvIbCzpvU0ief4940cvsulpJHREc
 xyT8OwJRMiJTPICgA9AG7SUV4zCuX6770wDUFyEbgBHTLtU+D6L2sW+lc9exWnkkWPKLPPjiIJO
 kWosMkjQQJba2CQ8u8K6U51887fRiZxxq0iOn924uX1/CXHMfC495ok0z5pIGUgwnm0gBPSUE9C
 DQiM/LkaeWqyyWBAKIIB+b3u582X86ouTpNoRdMvuFA6MBf/2zYxxpkJkfTvW3kFWyFI/8PQMA8
 +9DpCmsetwSmYxwFP0maVtFrkBUHTehqzlq9xppHKQM9LhxRHvyTNJapJB/takmW/KMW+k+jJsb
 z2NkvFRjcRJZ9NoVwRM40vxWX+gjYWdBo/czSdwB+gmefhDICy0QUsmDTeGZSLh9qEyUwf3sPce
 GvSHn0lwzJU
X-Received: by 2002:a05:6000:4a1a:b0:485:8c17:976c with SMTP id
 ffacd0b85a97d-4858c17994cmr1245965f8f.46.1788507318452; 
 Fri, 04 Sep 2026 00:35:18 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm4231342f8f.26.2026.09.04.00.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:35:18 -0700 (PDT)
Message-ID: <6a9a74b6.a294b636.15b91e.ba8d@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260903160411.9148-1-linuxtestproject.agent@gmail.com>
Date: Fri, 04 Sep 2026 07:35:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_setattr01: Convert to new API
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

> --- [PATCH 4/5] ---
> 
> > +#ifndef PR_SET_MM_MAP
> > +# define PR_SET_MM_MAP	14
> > +#endif
> 
> PR_SET_MM_MAP_SIZE is listed in the commit message but is not defined here.
> Add its UAPI value, 15, alongside PR_SET_MM_MAP.

Valid.

> 
> --- [PATCH 5/5] ---
> 
> > +	map.start_code = map.start_data = map.end_data =
> > +	map.start_brk = map.brk = map.start_stack = map.arg_start =
> > +	map.arg_end = map.env_start = map.env_end = (uint64_t)(uintptr_t)&map;
> 
> PR_SET_MM_MAP copies these values into current->mm, so this sets the process
> break to a stack address before the test starts. Preserve the real break with
> sbrk(0), as waiter_fn() does, and supply valid current values for the other
> memory-map fields.
> 

Valid.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
