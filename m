Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE77C5DF81
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 446193CCBD5
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 21:30:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5703CC6AC
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 21:29:59 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 19346100045A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 21:29:59 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c8dd6cd77so636741cf.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787081398; x=1787686198; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=24jD8DxAPFN+VwGAMk28VgL3Rjf499b1ntjEcmCtUg4=;
 b=SHvOn5WOHtU67nc1mb7OLtTyUj+Upgokdz5ianHpxByJu3y1OSd2v8f9Vgl+43j+iQ
 QUMp2Pdyct64uk4xSoTwH/Ux4Tmm/azxRyboaJOvr2KDDTL4uK2FDtMRiCULAObONtq+
 g0xFuvUataEJzt6EQxC3wVTf5Y0FW6+KOqNlUBqKJAIM7p5bppVQG9SzRqWvqowfVYh+
 xUrJ4WVSiRM9883DFroIS2cDYWLGEclKNANNmnFUs7DPbxy/9GZn6jRELe02rS2HtGxb
 k4hHVr27WVlM2FxtsDkCwM4UXEg9KwR6BGxIi0TrZcs3Adp6PCx32Qb7G4CpHEgVAVFp
 OvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081398; x=1787686198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=24jD8DxAPFN+VwGAMk28VgL3Rjf499b1ntjEcmCtUg4=;
 b=tLseQUhr7LmbcrzFpZ2ZB8khggjzUCI0pzHJ50LpY6nYC0gEyTa4aGg8DGCSIvuZDL
 6FqZiGynRbQ8OcxYsRT548DK9C9nmft0z7oiD+ejXYh13D81THFxIAI32W6IWdCj0RWt
 IiO89wuSKIJTI1o8uaVbLEHvSUMRkvp4HCPULrXXPuoXZNdSzbPDFl/TZHFgVwgdauV9
 ntw/VicBZup44GJoxPRprQ1Bz/1q2vWOjNZdrkO50ieG+qsQfp2fPuTLvrFpM4OV3khN
 MyrnauaS3w//hv+ZZHvcmtEsz3DqvZ03DSw62RLZ7hiQHHLw+R8nxRQmYjQ2BFZyE3QB
 7wAw==
X-Gm-Message-State: AOJu0Yzge52sV/YR4tWE87acrT1f2DSi6oJZ04XPPyuYav8tQCaiWejm
 FtrR+nGvBjRTSupfeI9tHefdMRWz6X0W6CdWjOJjThg945c7b6seuG5f
X-Gm-Gg: AR+sD12BWKQwyxyXSdL6YyXfS0KldhLZ4enm6E+/6TZTKiaAyL5tFEYqfkzcHAVVXiH
 kC6ONhMbNJ4a7JaAM+NjnA57B2E7R6bf41E9yies0aZUEOR9M02iBwKhlRwLmuyFYvq2r5gmbmU
 CLCMMvN8BbtGMrEyxHOAnlGiX+k5xEP5o7jKVKNezPX8wydYfSuhzD4H7DsubcLMOmZXXBlXEkE
 OZEOTUdXLTfiPLmAXHWMA4yc/BbuXV9ZKKa20yJDqxxXDuzDRKsS26jQVqeKO3g8EKx0AS1RYT2
 jCIpxH3X6hd2WoWfsr+VTQABwFEHSIwH4TfqWMSnOkdEmiWGsdoE2+BsXdpwzS2PN9KGktAFEOP
 mEMz6d/CY5r3ltn/nZTTY+TT8ngzqBmcINI+Rk4o/Y3XKIiJrcieUMeK9AKAP676OXuyhP+dl3P
 GXq+U8VT3hS29S2tb/+ujOViG61iSmwlvdA7yYBNwomHhouZBDjQXydFY/U6unPn5tSlmdLXL8W
 xIT41uY98ysHeR1M35JoNkTZrxUPAk78gQROgrLC1IjjGsOxcVpWt6LH9V+aXSDwbRoRIWLDSZr
 BJwqmKiX1w==
X-Received: by 2002:ac8:7fc3:0:b0:52d:d0ec:1ba0 with SMTP id
 d75a77b69052e-52dd32c09e0mr3501641cf.41.1787081397746; 
 Tue, 18 Aug 2026 12:29:57 -0700 (PDT)
Received: from
 runnervmzvulz.2bspblquhdguzhmaom1zbf3x0d.bx.internal.cloudapp.net
 ([52.188.87.73]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db612c2bfsm46297121cf.11.2026.08.18.12.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:29:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Tue, 18 Aug 2026 19:29:56 +0000
Message-ID: <20260818192956.8788-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818131800.42931-1-samir@linux.ibm.com>
References: <20260818131800.42931-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/hugetlb: use SAFE_SHMGET() and fix checkpatch
 warnings in hugeshmget
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

Hi Samir,

On Tue, Aug 18, 2026, Samir Mulani wrote:
> mem/hugetlb: use SAFE_SHMGET() and fix checkpatch warnings in hugeshmget

> +	shm_id_1 = SAFE_SHMGET(shmkey, shm_size,
> +			      SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);

> -		tst_res(TFAIL | TTERRNO, "shmget failed unexpectedly "
> -				"- expect errno=ENOSPC, got");
> +		tst_res(TFAIL | TTERRNO,
> +			"shmget failed unexpectedly - expect errno=ENOSPC, got");

Severity: medium

Could the checkpatch-only changes be moved to a separate patch? The
SAFE_SHMGET() conversion is a behavioral API cleanup, while hugeshmget03
contains only independent message-formatting changes. LTP requires each
patch to contain one logical change.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
