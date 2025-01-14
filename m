Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56695E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736893625; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=PIt0Cu1W6x/cXsTPkCrHEh9v3e8mrSE7fABpiDpephk=;
 b=j8afpXOsHjzSFv/UDMiy0ziSe1P4MC8nFTuUbMcMkiwLDELrEKHJXWEbfGGiPgTAk4+Ot
 SarUpNvDBpDmxtkfrJatl/THdLFNYFjsidcN+Qn3qOzXC16flR615vcfM51wnGjku59/wry
 kag7NTnDi6b/DeLaW09sOPN1UDHIVzY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC4BE3C7B2F
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 23:27:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FDA3C7999
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:42 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6BC55142557D
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:41 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so10194874a12.1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736893600; x=1737498400;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JqYfguUYua3H9Xesu7nyJOM7IqriVeWOij6MvvKFUVU=;
 b=U9wuK9dMz8MMxy+nvyTC7vBcO4Pos4SMFCZh/7fPkxeH2xVdllsOP0sYKkIhjCp3mW
 Ma23jQwvqpVKerTx7zv3VaRg/OVikWxXxYynX/PEQ7BSlqf/Yh6Gfxu5+jQhYoeCh11n
 cLc5BTZX+F7sZoXUTFpEZKNc8SEP884IZER/Wl7VxMnSXZHXRtFUYgnwZaXQQYc+soqz
 8hb+x8KdW+VZoAh+Nnu2DK1Sm7mNm/TDlE7dfXiRNsC51pXoDf4mzIGiU7iRlc9gWsPW
 6h2lzdBWVnIAkmP5mKOoh+xhuzxeUvjsc83QHIXTuTWeZkzVrbbgeT+0+Qg2IOeKonso
 uhlA==
X-Gm-Message-State: AOJu0YxC31V9/aIJRTquSAAUImlClP7qhAtiAUFjmIfuVN5InqDzf2sN
 z1FtYsCFSghy2nUiDVYbbaA/bxeUY/4sHxSYon8VhEuE8jX4w5J8LtQsxUimr6qHljFywhpFx/X
 d
X-Gm-Gg: ASbGnctka4JLf22F+vIE0EctZ2ON5XFegJddpSz7Z5A5nC1xOlCPlr3UIbFcckwlceR
 blcpsMy9p+0IxKrZIFbqTHKL7SRTgOWtsgO/Q3zpAjzFgMvUc5Dx3WVFQu/UTLvfXh4E+eF2Zm0
 L+rkz+aZS4D+QVeI1/vJ+iLxzA0gr4gc/n6S0GJG3QJKai3vpLkJgIXgII9IAhj14zJCAe9jzX5
 HVpCn0VgJOHRybyOULqYO0BvHoQS4tOHQa18Xq8Zg==
X-Google-Smtp-Source: AGHT+IEbjGX3YBx3K8HDYVe9dfAhdm8/aq4MwrgcsnM6M6Tsz4VWmBavu7yYFN9v8o6aI3xXvxvc7w==
X-Received: by 2002:a17:907:2d94:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-ab2ab6a8e01mr2607821766b.5.1736893600506; 
 Tue, 14 Jan 2025 14:26:40 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f037692f48sm4459094b6e.23.2025.01.14.14.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 14:26:39 -0800 (PST)
Date: Tue, 14 Jan 2025 19:26:30 -0300
Message-Id: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJbkhmcC/x3MQQqEMAyF4atI1hZacUbxKuIibeOYhVUSEaF4d
 +ssP3jvz6AkTApDlUHoZOUtFbi6grBg+pHhWAyNbT7WudaELZ0k70wNfu3cdTb20Tsoj11o5ut
 fG6dij0rGC6awvI0V9SCB+34A9ZZwKXYAAAA=
X-Change-ID: 20250114-conversions-a60f770d8db1
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=rbm@suse.com;
 h=from:subject:message-id; bh=XLu542nRWASLjMFB4ig/SBo+cnONA7CvaEGUwQAE5RI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhuSbp2SkH3DUUAJEEIel9bb8EyRLA6zeXX+cW
 WxWtVqsU3OJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4bkmwAKCRDJC4p8Y4ZY
 psgYD/4mQBeAP+kV9f8iFl6rTvT/XyCnGEeQGy1gJQHZ3iDCQ+25moPjPaSMwf0B5Y2tH7rEXtB
 x8l2WD35bsaWamGaqyQUXGjEeoJSM245axztntpfSGnJwO3R2RfUNNSP34KZLmKCfidmYLYFBid
 vuMHemmwh9vG1CYsEb4zGpLtdYv80X0oZfDDjSufG9khkZsetwJ/deFLGVZumnTdwIOwEf8Ct6+
 fOcTRUSRRDaukJIf+dR7a7QcjjDp/YwC2UIsFhXqcjWsIpdH4DbsPWoOzyyi4IH/89FL5Fz/vOi
 LeS4y5FQH8Z8PHnv6hpNqMAIvIeMgdIKA+oz770pJ8USt+iOt2FOCayDT2oBWmcK/gHR57HLPAo
 Rf2JNwUZP44HAJpX8EveKCS2MWEx+DjPUKoROvirNOwtpz0WVygVDX83OoI3hdNrQqKITGqIFVX
 6nKDQqDmaDaq2kwObbrdkgH85k0oc1q/0Z+yTm5H4xqd40HHuvN3+wFlPD5BERTCRpcbnpaifcF
 jwg6F0ICa4fe4d8ldE2h0IOQUnz4ZUfmxHHrnUvfrWYh0ONMtEDRMXPosNBQKs7Z4J9CBLwKjfW
 kUK341PI0FZGiZDkofpaQ8MEHWKm8OH42QQ9jyRzaoBnU0wjGbDAMzXqoIotHZjO0Sd5L4vYoRM
 yA1h46Z/OhHpmBQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] syscalls/mmap: Refactor a few tests to the new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patchset refactor a few mmap tests that are still in the old API. I
left mmap11 alone because it seems to be disabled [1]. For mmap03, I added
x86_64 and parsed CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS after doing some
manual tests in my host and seeing that behavior should be expected in
modern systems.

[1]: https://github.com/linux-test-project/ltp/blob/master/runtest/syscalls#L835

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Ricardo B. Marliere (3):
      mmap001: Convert to new API
      mmap03: Convert to new API
      mmap10: Convert to new API

 testcases/kernel/syscalls/mmap/mmap001.c | 206 ++++++-----------------
 testcases/kernel/syscalls/mmap/mmap03.c  | 274 +++++++++++--------------------
 testcases/kernel/syscalls/mmap/mmap10.c  | 198 ++++++++--------------
 3 files changed, 214 insertions(+), 464 deletions(-)
---
base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
change-id: 20250114-conversions-a60f770d8db1

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
