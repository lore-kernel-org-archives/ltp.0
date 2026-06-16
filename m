Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A26FCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:13:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB6153E5992
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:13:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 202E13C19F0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:12:53 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD8781000A53
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:12:52 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-304f590dd91so4958407eec.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604771; x=1782209571; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCQibsWTte7iNSimjDE6HKuN9al5fGtWgATgSDzYlFw=;
 b=c4VDWbjOuv5yVSHKecnAf9JNoqag6AxUfFfcZunPPczp1BPBBJfOIOvrteSHyhdM0j
 0Ai+28HsDxyWXbGFOKqe0HPyLUxl78TAxo9XmZfDULG/kB96F9TOz7B3NAVsPVVXrUPR
 O9DP1GF488gRtZeuz/h2aYJlEkZy+43xW9aed4ZBRCdwg+suGx/cMbRqXQFC+QYJqxfL
 kb/QUUwzg4GyQokjfgMQqCSMUPSXDchgg9OKSrAZEfYuhz+Z+PcnbxcLQwKaasg2a9oM
 3adBL0NyKNSoCIx80PQbxXojLYL9SHiuj66KzvSMjy7JhYA1cW7UZG/qLcKYO11j1acv
 dU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604771; x=1782209571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gCQibsWTte7iNSimjDE6HKuN9al5fGtWgATgSDzYlFw=;
 b=qq0sL/0p4fE+Z93SbQYfM8VTAeNDwPr8fhxIURBqsFPD7dW99fPItN+R/bvzmRHQgq
 /QTYyzjrwIKMgSVbxHDNSD+AiSLCVjNaBcxQYjs+LKsnBjqVFwlvpgcklSlBh0rbOFNE
 JIgnCS7udoJpyBj6iDu0lff20yO72MLxpNrbTZCfTv/M/wg++l1h9+dMnT5TsbA43ybY
 DdS51ZHE+gGdGf1xd4emtP5ZVY6NjS/gUg1PCco/M+RePhrCHYBhWRDODtnUUnkkvXR/
 pD5DGkjEDkrIbZA3JykDCfLfKEbLJMNeO55QTOhwR80/riH3HQmZjcqet3Qp+B9+S4gP
 ZLhA==
X-Gm-Message-State: AOJu0Yz4gnpg0h5lQm9fnGQCKk70Gvv3Xr1+1wxGPCy5EdkqewjE2Dko
 93j4n522Y/aPCGPoETqswX4EEQl5MB56VjtyfP6j8gjd26owjYZ8BTdp
X-Gm-Gg: Acq92OEtkzOhFkBbiq/lWlq8h3/N3PcPmYkzHsFF/KJYkvxRhL3BUcnIFtL3dDncN/H
 P33fs8lWiqNjgMYb7lygYbsjhhNt1U6K9YDkHQG5wlLSuFFksB5D1QuHv0AIv6/4C709fHOQFPQ
 MOp7VCG0/REYr36949q7OC40DM/snaOFTz/rQn9akCkPJldXqcLRarWKM7oSC80ZUfOcTTyD7wI
 ujAvYh1pkFPgcZIF31Cd2novfj2dqFVe4ehcDO3ViLz2HGxGtzOPConMN05y1NlQwX/yu2A1oZ0
 vfbnvWjbs61gV5bnXRe5Xz24iYgyQnRJq94ATgofvqfyJt6g6VGaeDrRZRUbRTB2hsgsZKQnBWb
 CLT/+6dAPNo0GtUgq3W56PqgucpzUg8d46CCMzQn90liEMpacUQuvIwgvpHZMKuG0uL1GzpOXtw
 WRXj8WYq8wymbvRs1PO5K5QKQ47s/zklKQmUsw4BQyFh3wmzumvoL3hR3HUCejkKbV5wmbUM1Mx
 IblGqrvJtoRkfs+Sq1+iaEpRxUYbQPKPmHjGKVOgRCvNE9RCzxW
X-Received: by 2002:a05:7300:80cc:b0:307:91f5:8eee with SMTP id
 5a478bee46e88-30ba59ea7femr2120297eec.12.1781604771001; 
 Tue, 16 Jun 2026 03:12:51 -0700 (PDT)
Received: from
 runnervm1li68.dyirjykxpvjepimzttocctglgg.yx.internal.cloudapp.net
 ([172.215.223.213]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95342sm18885584eec.29.2026.06.16.03.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:12:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 16 Jun 2026 10:12:49 +0000
Message-ID: <20260616101249.3890-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616093119.8654-2-wegao@suse.com>
References: <20260616093119.8654-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] connect01: Convert to new API
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

Hi Wei,

On Tue, 16 Jun 2026, Wei Gao wrote:
> connect01: Convert to new API

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
