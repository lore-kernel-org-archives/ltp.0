Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC4C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787832297; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=lSb/NNLNDA7MeCyG3LEl3jizsyh1N++Pr1hfOLhXaJVk7TVMdHvw9aEkO2sIFyjnOOpP3
 b2MZlAnGJkcpvptVJ8cq/3LYq+VDtKI03oG/jsUOwtTiUJQYrPQd+Xz8NBo/c/Ja5C8D6Ky
 KfS3Js2ZQcmqsxv7V005NH8hvbIyNJ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB083D0F88
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 14:04:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30E2F3D74E4
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:23 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A2B6920093E
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:22 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so18802205e9.3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787832262; x=1788437062; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=F7Ag7Wr5GlFDbYKmXoMq2dNH2oG+vQOeSB5YFgT0zqs3cOCjCAavU9cLS/Wako2pKD
 +QkMDjtejyCpjTOSSc3USaiD3JfjgCbWzTneOvIPZuCyHPrjiEveRb+RF0okIIgnmpdT
 S3rWeV5wSYJhY2bf+9xvzpC5bXfjNVZEKIQ25+PkTI8cXgRwvkKi5W4r6onY4gYL0ONU
 rxQPYFJfm8Eo+ftWLqAUm23S+nSRJuBlaiVWUGGciRjsTO9JVVzCdOqRHHeSsAE7ZbKh
 ROj54Qa+i4zcLBSsebPNlwTncQK/5fyhwbwy0R4b1LpDaJsRzO9sYN7yCJmTyrYWyQ6g
 1EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832262; x=1788437062;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Yoe9xZGtA5B+lgPRxekjwtamKBm30GykjniJrn79BthfILn/DWu3yrRa2s0KQJTrSy
 rChBVf9NKmSgXIQRE04AYyC/4btErgy3ks8tQooiDXq4Q4WZHpr/G+iET2RtQs7X3jSD
 1P781M4eLLVrDe8NoSgxYjWwMSqhD0pmT+VW6WQTvJiwmLMRd5mJ1UeyOnC0LJZWIBIn
 jNZP5d/Nxdn9F6qEjIRaoRwsMsLR1DdvKezN9+xWsVFyeqA5IAygaG56jNXawhxL8M19
 fwCskwzmmlcDdSQmyYbuiTfLX3mVNpNYSej+RrC+v3cbgYWOV6cmrPBsHCDvurDZ1eB7
 tZcg==
X-Gm-Message-State: AFuF++ldJXUsvfLA6Nz1BdAhPkS8Gz9z9Wb8FQsT4gw5rEuYGyuP+1Ju
 P7T8l54W7x4pTJS66s0GT5ikQsh3vhJBqEiw05LgIQWVQMfmvaiJK0Hw5I/SOpd/EgL+Fw4XNkG
 DMD6BmCp1yA==
X-Gm-Gg: AR+sD12zIuZ0oMD65iygyFk+8N3jlHY7/nzpcKwnoAKVRitWF7l99yKMv0iP2rw3Ap2
 UC/aC2SpMKMxdt7VOCJahoPqbDa1N2yAsIRcZDcNWIqp040ntRCsDJSMqrHwCORmaPMqwSrUe3R
 ayES6ZqL4y2H6RMth7dWUFiMBsylDsHsG2ONH/FE3ziRUqMniBfR1ybMEdlAmmMB1sXFuajQoL5
 kH05L6m8cGXsihj8+wIxxPedBcfKA2fPSasn34lGW8xJiFE+hx5eeC8yHscqeiZBSelArJnxAuI
 J7tlAYKuSxYqSIMGSdoWmQu6aL6TtpPpj5GQvG/r8he2Tt2Z22anJLGNXlxhuqbKw6be4l+hpvq
 BHkZB+LUmQRR8NtCVWAHda7NOi2U7kL41OJnB4hmOEwYB/KBsJ0TRiYIh6S5wMTfjG+1rMFfvzl
 DiI+8e+USCtfLSOWN4vxU/5Uy3O6AYR7z7FMUoDAgk9Eqd564nGO1wc/IvmRe+Q62hUrMJ2bxOV
 EDfuzjLhMwVk7Vbqx5ICHCEcRgWT0Ol744FUw==
X-Received: by 2002:a05:600c:8b77:b0:499:8ff5:8ecc with SMTP id
 5b1f17b1804b1-499dc82fc0dmr193082745e9.15.1787832261887; 
 Thu, 27 Aug 2026 05:04:21 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm110355475e9.6.2026.08.27.05.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:04:21 -0700 (PDT)
Message-ID: <6a9027c5.2224c88b.1651a9.e6ff@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260827-convert_fallocate_suite-v5-2-650ab2acdac1@suse.com>
Date: Thu, 27 Aug 2026 12:04:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] fallocate02: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
