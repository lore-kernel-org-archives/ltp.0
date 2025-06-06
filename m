Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BB6C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749211066; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bxKaTR4Dl3PrOQwN5gI2thvMng/NNWXI5ZTEpomWIwg=;
 b=AircTL2wii6/bLpfBgkxhldJAD97uBLNAncn94UskrDd6v0DXitZVBVTpZNM37UKH/BlN
 7fqLuH+VXe8v2aSLQsV2fqu9TZVQstk/BH+LPH4HOgeEr0FnWI8BXb0cAKPLDLAPZCUoXSg
 BGStPnX5LgQuv/vVmtjEwtl2pkv505Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D153CA01B
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:57:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95FB53C8E88
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:57:24 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 951B31400258
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:57:23 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso300580766b.2
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 04:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749211043; x=1749815843; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IVTh8/v25a9nLxh1U9mnVT4y1dEa1CRxUSLdVirdVs=;
 b=cikklbRlHNehoEtBz6CjKQzkyWu1LbIDAAcAuYOxYcaC7nERKEOBCbRxv8Z1l36uAT
 u+WhvtZzOU1ky32rp2Xq73eam3+0Zs2WaCn+/BhIFf2q0I7ft+tMQUIpQW+uZenNs9OC
 t4f7MD0JXZOtZFY4wPGQSJdehtteZnrmB/cwk3nBV75q0NYIP8/r+QT5weLfUFFeitrI
 fJ2lW8x+22AMkK+eMoeUp5JbSB5XIxK/DQw5yLAjBzggJQe3OSbfRM0FCYpOgPBlV3G/
 txbtfkL/R6RmVoFKnG2gyKe+csiZG3VJs5Y6h+cYVgqAVbYPXp783PO88CukH6viEXBD
 CmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749211043; x=1749815843;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IVTh8/v25a9nLxh1U9mnVT4y1dEa1CRxUSLdVirdVs=;
 b=WaFAYd4YcrvnSa3B7ZAY9Q/GQerXLMfRdy1edS/FwDyCWBdaw7bChONMsHiLNbE2Ic
 HNWNVNvcPaIfpRcgrtDEuLhypR3nAU2iajHtoynEaWpPSU2at7OlZ9ho2FvR04hxJ0Ec
 jH0Tr/OCSznjUTAMyUFuErJREaYazvPBJrF6MDRDRnVobJ8Uep6dGazATG+KuwilgKL9
 7iomCzChJPN8ihMrVd1a+BfY7/obZp6nDJqqndcUEm0xjOvbyofzRN941Pov6Y7TKFgp
 Z5UVHNoyFfxcXctE3zkz+fUcuCvkfC7lTymYLgLfnP4MbXQK6V/041iyyMdtdT76fPCK
 R72g==
X-Gm-Message-State: AOJu0YxzIU9NRWG+awqY1nu6vJhpN//cnGJFwRfmKhftxDqF6S99hUlG
 DXpwM1KU4L3xgsBscpQNl9eeCb2AsNtYiMkQR2hxFX9/0AV3x24wQ4NrAN7ouyQAzsmQk16j4+B
 k5yfl
X-Gm-Gg: ASbGnctafSmTy2UlMdE/qn50JG3hnQ+bJy4tubrnPfBmOhzQrAit9Mt0vUy+JyzcMPC
 +lTDEoR2+TzNSyJbkiGZkyI6AiHCCG8yWbNgW1fvZSssf6+bAEeyA4Wx8C9YTEvNISX4a0Vuc2s
 DoTla1KlU+bxSGqbgroxnlkExUa+yJ+Rn8Ds/Gm9EMwG0/AYvkKZ+qapOerSzle6gJkT+dLp95m
 eC6AF6lwMcDIsf7c4U+CkWKHxVlEyOnxwXtAYcrDTXw81DiaTO1dEhZofi8Ba48R6dynzRxZpQ+
 vxssccAjZyp8NgOz9A2E1eT0FEETnJeZDGt+oBOWaQ1PSLC1
X-Google-Smtp-Source: AGHT+IHfiah8VERTUTbX0z/gibgGdprffbTiiUhJ0X7Dal6D27EvqLRCWGGlVIZAEZzhV+8/X5oHaA==
X-Received: by 2002:a05:6000:1a8d:b0:3a4:f7ae:77ca with SMTP id
 ffacd0b85a97d-3a5319b6a1cmr2833886f8f.3.1749211031537; 
 Fri, 06 Jun 2025 04:57:11 -0700 (PDT)
Received: from localhost ([189.99.236.12]) by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-530e640fb66sm960527e0c.36.2025.06.06.04.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 04:57:10 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 06 Jun 2025 08:57:07 -0300
Message-Id: <DAFFK4OBLBWY.3VACS2RP961A8@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-3-0b5cff90c21c@suse.com>
 <20250606114953.GE1289709@pevik>
In-Reply-To: <20250606114953.GE1289709@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/8] syscalls/mknod03: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri Jun 6, 2025 at 8:49 AM -03, Petr Vorel wrote:
> Hi Ricardo,
>
>>  testcases/kernel/syscalls/mknod/mknod03.c | 313 ++++--------------------------
>>  1 file changed, 39 insertions(+), 274 deletions(-)
>
>> diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
>> index 7ecadb5b37c3ab7eded90aa8a6d1e27f07236b1f..00a6133f7a15c1dd9c9e67ba08315f218f16d0d6 100644
>> --- a/testcases/kernel/syscalls/mknod/mknod03.c
>> +++ b/testcases/kernel/syscalls/mknod/mknod03.c
>> @@ -1,296 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
> nit: This should be v2+
>
> // SPDX-License-Identifier: GPL-2.0-or-later

Weird, I have that as a snippet but must have copied from another file
on that occasion.

>>  /*
>> - *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> - *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
> Because any later version.
>
> It can be changed before merging.
>
> Below is whole diff against the patchset I suggest.

+1

>
> Kind regards,
> Petr
>
> diff --git testcases/kernel/syscalls/mknod/mknod03.c testcases/kernel/syscalls/mknod/mknod03.c
> index 00a6133f7a..8cb9be9287 100644
> --- testcases/kernel/syscalls/mknod/mknod03.c
> +++ testcases/kernel/syscalls/mknod/mknod03.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines Corp., 2001
>   *	07/2001 Ported by Wayne Boyer
> diff --git testcases/kernel/syscalls/mknod/mknod04.c testcases/kernel/syscalls/mknod/mknod04.c
> index ceb9565b4d..d96cb27b95 100644
> --- testcases/kernel/syscalls/mknod/mknod04.c
> +++ testcases/kernel/syscalls/mknod/mknod04.c
> @@ -17,6 +17,7 @@
>  #include "tst_test.h"
>  
>  #define MODE_RWX 0777
> +#define MODE_FIFO (S_IFIFO | 0777)
>  #define MODE_SGID (S_ISGID | 0777)
>  
>  #define TEMP_DIR "testdir"
> @@ -29,7 +30,7 @@ static void run(void)
>  {
>  	struct stat buf;
>  
> -	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
> +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO, 0);
>  
>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, 0);
> diff --git testcases/kernel/syscalls/mknod/mknod05.c testcases/kernel/syscalls/mknod/mknod05.c
> index 4b7e957726..bfac9227b9 100644
> --- testcases/kernel/syscalls/mknod/mknod05.c
> +++ testcases/kernel/syscalls/mknod/mknod05.c
> @@ -7,8 +7,8 @@
>  
>  /*\
>   * Verify that mknod(2) succeeds when used to create a filesystem node with
> - * set group-ID bit set on a directory with set group-ID bit set. The node
> - * created should have set group-ID bit set and its gid should be equal to
> + * set-group-ID bit set on a directory with set-group-ID bit set. The node
> + * created should have set-group-ID bit set and its gid should be equal to
>   * that of its parent directory.
>   */
>  
> @@ -17,7 +17,7 @@
>  #include "tst_test.h"
>  
>  #define MODE_RWX 0777
> -#define MODE_SGID (S_ISGID | 0777)
> +#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)
>  
>  #define TEMP_DIR "testdir"
>  #define TEMP_NODE TEMP_DIR "/testnode"
> @@ -29,7 +29,7 @@ static void run(void)
>  {
>  	struct stat buf;
>  
> -	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
> +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO_SGID, 0);
>  
>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, S_ISGID);
> @@ -48,7 +48,7 @@ static void setup(void)
>  
>  	SAFE_MKDIR(TEMP_DIR, MODE_RWX);
>  	SAFE_CHOWN(TEMP_DIR, nobody_uid, free_gid);
> -	SAFE_CHMOD(TEMP_DIR, MODE_SGID);
> +	SAFE_CHMOD(TEMP_DIR, MODE_FIFO_SGID);
>  }
>  
>  static struct tst_test test = {


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
