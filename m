Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365D5CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 14:28:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE013E5977
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 16:28:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B9413E5973
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 16:28:08 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BFD001000D4C
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 16:28:07 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-13721dfd471so5068270c88.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781620086; x=1782224886; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yvLMh0TvaijQ1T9GKZpCT8kngR78wy5AF9ptkoD7/Q=;
 b=mZqIbxmrWullRrg/yFyMdBMBit48KNMbr48e9X/ps3OMnwVczbqoh1WI0Ov1KMHHBA
 b9Lo1zf/8fFtp4XT9v+k5Bxl2UnPPgluIhPFHdLJXg1qV4w/n+/IeQoJ0G/cegQ09YTh
 YmPlJSoCiLpIHbQxx9TLzgrK0bKFYEq3uNh5I9fmqU/NxrZrMJkOENsMzP1i7OtDNYiS
 sOkGNgD9fwRlBhqIirU4K3iIeWTf+vuVfsW2duGobLWtq6wj43RLhisYvAGqxyRP0Hbg
 Rd+lVn4/ndZ+2m9V3AboQN5W/psnh4Ap4uk5fm9vcVgDd4zFOz6dsQavWgQtInKYYPR/
 WhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620086; x=1782224886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yvLMh0TvaijQ1T9GKZpCT8kngR78wy5AF9ptkoD7/Q=;
 b=YgZu5ucE0ajErNnWAQxstUCu5JE352LHzztM8yD5rXTFP9XZ5N7axn874P5HF/eY6Q
 NnO6JrcbwmagMiJJWLABM57+ZSoM30QioMwo5NMU+OZeqkHU2oOv6Djmoi6bwNczugcZ
 4Ich/8ZnMz5afT5Vq3yjy41Q4s0tCcslNa/UD9J9gk3FhL/e2du1teTXWS1TWUIu4KLY
 hff6P2YHU4wbFb2kzyL+zgOGDBk9q+rlFLGf9s07tdetJ1622fOUYI8H8Xhc0GAOvV6w
 4mJhf8smg165ZQVSM7cWPJyDN1lljlg6eEhhvNFhA/cNkgUulV1RPP+GP+cf3uwxuN7y
 WFPQ==
X-Gm-Message-State: AOJu0Ywf1VxXQndTPMehuAWv29IbA/UBAg68k0WKV4HP9GzOyVMPzqrW
 mgmdI8htAjfs5j/t6xjXOchAP/gOWI+ziMr96kmNzglca1H+kpHvFhm2
X-Gm-Gg: Acq92OGN50Be6VosvSOFJWucH909E/tbqoFwuuWC47GCkFbEPuh4lflr8ecM1ePijTm
 UzmQtqUHuZVo+k5OU24zvV+1+kzClIz33/OYwryDkV8jF0guwZvoEeZRWAcpJiUZdB2ms8WjGB8
 6fxxFpLVV86q7ZeFQehfuN4qwLRLNvQqn0M1B8FrVtSpPTczXQsAHJo11LofMFO13CEfDUunxib
 ooYP0yFr2iQFcuOt0JCt+KAUkacDnadnXDq93kRsy5Cqas7+vuPNm1F98JdkWIXE+1Jv2mMaTdG
 sooAURdinND+5EQaGdQ0hhXfLR7VX+21izxEbhy6AYcpZcnaIuV1brosILafIvCki7CT7/AvlVb
 1bVLws+W3L8eno95YWK8O7a41/s/b39Q92+3QJXoGSTLKAQHSoAbPMPf/jpGAToewzJY4qLiIEz
 4r2NTUHYx6nfOsEniZEyURxUzD3pJ423ylKxQ9yZKoefaO4CgUACj0ZfZRTzUsGA8b1dr8t2RVz
 iYP/kEpzRmxq7WWSGf0KgEu2mljsbIXEtJfNPllPg==
X-Received: by 2002:a05:7300:54d:b0:304:885f:2db0 with SMTP id
 5a478bee46e88-3093b84e75amr8542926eec.20.1781620085934; 
 Tue, 16 Jun 2026 07:28:05 -0700 (PDT)
Received: from
 runnervm1li68.k0fqir3wapjuvfruimbbgb1dae.phxx.internal.cloudapp.net
 ([20.171.51.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5fefecsm19214388eec.13.2026.06.16.07.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:28:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue, 16 Jun 2026 14:28:04 +0000
Message-ID: <20260616142804.3943-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616114204.5636-2-piotr.kubaj@intel.com>
References: <20260616114204.5636-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rfim: add new test for verifying RFIM sysfs interface
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

Hi Piotr,

On Tue, 16 Jun 2026, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

> /*\
>  * Validate presence and permissions of RFIM attributes.
>  * The test checks first validity of general RFIM attributes,
>  * and then checks either DLVR or FIVR, depending on hardware.
>  */

The test sets .needs_root = 1 but the doc comment does not explain
why root is required. Other tests in the same directory document
this (e.g. "The test needs root because reading /dev/cpu/N/msr
needs CAP_SYS_RAWIO / root."). Could a line be added explaining
that root is needed for write-access checks on sysfs attributes?

> } else if (!stat(RFIM_ROOT"/fivr", &stats)) {
> 	if (S_ISDIR(stats.st_mode))
> 		variant = RFIM_FIVR;
> 	else
> 		tst_brk(TBROK, "%s exists but is not a directory", RFIM_ROOT"/fivr");
> } else
> 	tst_brk(TCONF, "Neither %s nor %s exists", RFIM_ROOT"/dlvr", RFIM_ROOT"/fivr");

The first two branches of this if/else-if/else chain use braces but
the final else does not. Kernel coding style requires braces on all
branches when any branch needs them.

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
