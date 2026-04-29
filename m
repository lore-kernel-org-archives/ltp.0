Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA36FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:33:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 890D03E2578
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:33:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA3913E289B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:33:29 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66AE460093D
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:33:29 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8f231f3b130so433253585a.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777448008; x=1778052808; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ1eNeemjpfn/Zby0D+Nw3Lacp5u0rWI6VmH6GrmxCw=;
 b=dqeEvQY0R8dZozOJyB03B6tnlRRzl1NMm3c/yd/kQJ5aOW7enctDo/8LJatGWv58VJ
 cAT6LTfaGDua3OZDq4tZI7LATmgV2rKC8y75e8zibOb7h8QZqE9C/jdXfO9ccMhbU2Hq
 377u3w5doKWwlcmvjIFimzDu5HPu+ZkY25B2FHHZUhpla11pzbz2Dmd77ZsnptKKwmBu
 O/emWbdjz3I+Y9TuorSDHZyBt5PargIRdKWTKnYdRM872qkBhkaN7vTW3NpJRJNuoXwF
 aUTcD5BqxkpfvvVJgFBbhVauEKkxU2L7y6FBlXAXW8MxykjKisuG1WD9uNIrOdrJKOWn
 lLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777448008; x=1778052808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQ1eNeemjpfn/Zby0D+Nw3Lacp5u0rWI6VmH6GrmxCw=;
 b=ksANMSmjhDY00wBMPpTOWd1UJGF0xKHJXc1MVRflqs++i2ml7LkYtQnodkSualJuyg
 BytNQZgCZnNzVxi4rLc1UtE5yF9VLgHj/94zsKvvd8m2tHNmRcm/de4HtVRQ7QgAWUpn
 vOAAPG+rC/OpQKCIIgy7gd+WzBI+Zl5SSCOBQGQk2OTBNO/T3FTxca523ndBcWziIlwv
 /jQDeeHLzsIulJF1p14QQMGgP4+dmHpmOLXrs/d4rLdBDdiC/cEd7EL1sszDUijzO2P/
 o0j90tvoCJpnfsJzPS5KdsF2w7wKgNAdWdstcWu2a6Ge4wpM7PTy9/uc2QG6JLR9zPLJ
 OkCw==
X-Gm-Message-State: AOJu0YxJmrwa2atYLLaymKppJ6wUtzGiZNdf2akGIMAAIw/mv9Pk1j0x
 GtAWZ/OGgvqFxycpuDjMR5T05EQ68rZlTQhhsrTwI4r3h0WDgg9rY1RrJo40IvqWOGI=
X-Gm-Gg: AeBDievt8HCBLlxt5fSXxqYdsdKZd1QWH+Cij4vwXir9Vk/7edpq/oVIXkIjqNgM+LX
 6tjkti9+Y961Q18PIApsFCVJOC8LLUZil9cT4bvz3cBWi7a4DhfVB+A56lpHTgwRyt0PD9mHm3k
 6hdsNnMo+lG9G2ctanumXdMvVPod+K0lCpvmKdAfwJo119+LkHl4/DndxqdeKZGS+UJM4UJWyGp
 iRtG/o+QVb5s5RDxEUF/U4JXaNyt2E4fSID4SOyhi2rzBIBoVZf+/mNL+D2CSL7yQqkyWfXb/oX
 dcfwesNr2OogySfIeCJ0Ccx/GqOLMfGVW5JLVBgVhY4lB+9F7CVMn8lMkILFrgbjb4Oy7B8Z1fm
 uLc7a7hspfxyssAHu+z1N30EW1rruTvbcT28A+7lx6TreeAeijRdwfBao/jCTeFwc28bCwMK6n2
 y0LK6kRi9TYS8KAuPM4kn8t9/BXnMF2uZKnuyoSkn0M86GkFz73F47gE+a7xeF9rGRoXy5vKtf2
 tQXlWtC/youhwDeULBQ4mPXdtBxH7fZakvtkgRDTD4ggvKcxmE=
X-Received: by 2002:a05:622a:588f:b0:50f:c2d5:3154 with SMTP id
 d75a77b69052e-51018a7ec1amr38184411cf.42.1777448008108; 
 Wed, 29 Apr 2026 00:33:28 -0700 (PDT)
Received: from
 runnervmeorf1.iyldqaevqpzuto5kdmxufowjjb.ex.internal.cloudapp.net
 ([64.236.134.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101acf99afsm11142421cf.12.2026.04.29.00.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:33:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: priyama2 <priyama2@linux.ibm.com>
Date: Wed, 29 Apr 2026 07:33:26 +0000
Message-ID: <20260429073327.3985-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430155241.897024-1-priyama2@linux.ibm.com>
References: <20260430155241.897024-1-priyama2@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/nvme: Add NVMe device discovery and
 identification test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Priya,

On 2026-04-30, priyama2 <priyama2@linux.ibm.com> wrote:
> [PATCH] testcases/nvme: Add NVMe device discovery and identification test

The subject prefix should match the actual directory path:
testcases/kernel/device-drivers/nvme:

The commit body only describes what the test does (restating the subject).
Please add a sentence explaining why the test is needed, e.g. what gap in
NVMe coverage this fills.

> +/*
> + * Copyright (c) 2024 IBM Corporation

New files added in 2026 must use 2026 as the copyright year.

[...]

> +SUBDIRS		:= acpi \
> +		   ...

testcases/kernel/device-drivers/Makefile has an explicit SUBDIRS list that
does not include nvme. The directory will not be built. Add nvme to the list.

[...]

> +static int nvme_device_found;
> +static char nvme_dev_name[256];

These statics are written in run() case 0 and read in cases 1-3 but are
never reset at the top of run(). With -i, stale values from a previous
iteration carry over. Reset them at the start of run().

[...]

> +	.needs_root = 1,

All operations here (reading /dev, /sys) are world-readable. Remove
.needs_root = 1.

[...]

> +		fp = fopen(class_path, "r");
> +		if (!fp)
> +			continue;
> +		...
> +		fclose(fp);

Use SAFE_FOPEN/SAFE_FCLOSE (include/tst_safe_stdio.h), or document why
the raw call with continue-on-failure is intentional.

[...]

> +	len = readlink(driver_path, driver_link, sizeof(driver_link) - 1);

Use SAFE_READLINK (include/tst_safe_macros.h).

Also missing:
- testcases/kernel/device-drivers/nvme/.gitignore entry for nvme01
- runtest/ entry for nvme01 (e.g. in runtest/drivers)

---
Note:

Our agent completed the review of the patch. The full review can be
found at: (not available)

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
