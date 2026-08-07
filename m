Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88865C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 00:01:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783223E715C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 02:01:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32EF53C73AF
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 02:01:17 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3B3420092E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 02:01:16 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-38f25802c19so1011265a91.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786060875; x=1786665675; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ogq0Xmc5tjuhH3Lal4imGb5hPu0yxdUIRQERHFu2NpM=;
 b=Ud18FBZxwpm/k2z1NDFBZ1y6YRkHKARzk4src/nA/71xwu+5mqmigR2youg5SbBQnx
 QyeibB6jxb7+RBv1teLaa0kMVZGR4r5IpI8bWuF1tXahOChAx4BxFdp1F9qesMdLpMVf
 +Uin6t33Eu30mH/u0dXGynddLgTx92ZzD+ea2G3EFnAKpCjnqBatywF9JcuRcYRwxrPk
 xnDTl+QfYNAg7WFT1j1EzKu1REAQ6Hbu597iXc2XVIS24U1WUPh6r3y/6vlWRaL7V49p
 +Sw2VXVOddASHPUj/l9QSkSuNqZoCMArhTFGLXyo3mAm5gXHBmUEYryKbU/BEUX+HpK5
 aALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786060875; x=1786665675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ogq0Xmc5tjuhH3Lal4imGb5hPu0yxdUIRQERHFu2NpM=;
 b=W7cMteBCcYyJqYA+IF2m+VuxgKNaiseSriOg6l82N68brYIkUp6jhO2ZHvRwCURoO8
 +0Ei07StVE06IWrxEc48W77kX8reTQEAaMpoce6/ygJA27DPB9fraCb92e+WLTAlrkjJ
 ExLBFXgWwI8T0ChKeOEYMijJnqdo5A/0HPEPvfRBR3onHXMoKZvPoxT71TIdcbqEBnez
 H46zbqbS/BYRByJ1kpn/Z+B8Cy9j7zzigBAcUzyOdzHyvKI4Gmt4zJ5rl1uNoulN5G38
 +SQbczxSja7IecEGDgUEwG5RWRW/mFfMEttYgbbpxrW7kQ95VGIcpv2kATWbZFuYFTD2
 nsuA==
X-Gm-Message-State: AOJu0YxCaf6gMzx3MlBIfIdmEJNjFgUQj7YEBTYsWChOYTPACOSws1ea
 mk6O64Gv1cSqJzmf6l/gU7PH2/pLxFZjvuyoRJ3OKs5LiLVPQ4y1F5YH
X-Gm-Gg: AR+sD12LKlUc0vgZgmAOZjOJ59W7REaniCBPR/rbLdOTBlJdwTvE/veARpZfBW7L/XX
 ODvrSH2SK7/qOZrjqsD8sE8X1+zIm++e8Bfadlj+EGFYSvv7fvI93+WkF2h3txPZCqKNWpMtn1G
 zDJLW/0qPgQCkSRd0Y1jP1enu2EcWB4XqVoWHenyY/XDZIzlT3qSKc6Nq/tsQgSV4NTDaai88VA
 a1/74IYD8057TQirWO09ypNc4M+mlaBQQX+Utq1qkAkmxZ0uu9nrN5oAoTKdCKlRc98VaunfWPu
 xVeLq6goilfRm9lMRD6IaoD8bF0tf8myqVbZ6jxcRgmG7rfBh2VBtJaC6WF3HDEkNoqIsmNz7ZJ
 p8P/wskICW7iC2c3e/xgAwqsCQC8yhg/ShI9RiISJCPSFhw7vE3OuZIOaOvHJBo8iz8/oQ5Hrso
 znqab4QK1So27++SjozdzBc0tlDC4HAtJ8Xy3GMeqpwzRvfxb9dvu7aOLB9FSuzoAKKOVcmU5YF
 sSUPG93phHzmkULE/5M1oibiVgPgyKzvVyke01kvkowff2aol35vFsBEovG/XhAD9qWNyQbzBVT
 U+o=
X-Received: by 2002:a05:6a21:7116:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3cb85ecb5f7mr24360275637.24.1786060874955; 
 Thu, 06 Aug 2026 17:01:14 -0700 (PDT)
Received: from
 runnervmvrwv9.1ppwslhfxpluja0rganc10hrpe.phxx.internal.cloudapp.net
 ([20.171.23.181]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb883d9sm296785eec.15.2026.08.06.17.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 17:01:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri,  7 Aug 2026 00:01:13 +0000
Message-ID: <20260807000113.8784-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806231423.17724-1-wegao@suse.com>
References: <20260806231423.17724-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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

On Thu, 6 Aug 2026, Wei Gao wrote:
> min_free_kbytes: Handle transient memory drops in check_monitor

> 			for (i = 0; i < 200; i++) {
> 				usleep(10000);
> 				memfree = SAFE_READ_MEMINFO("MemFree:");
> 				if (memfree < min_memfree)
> 					min_memfree = memfree;
>
> 				if (memfree >= tune)
> 					break;
> 			}

Could min_free_kbytes be reread during this loop, or could the monitor be
synchronized with each test case? test_tune() can install the next value while
this loop still compares MemFree with the previous value. This can report a
failure for a value that is no longer configured, or accept recovery to an old
lower value after a higher value has been installed.

> 			for (i = 0; i < 200; i++) {
> 				usleep(10000);

Could this use exponential-backoff polling instead? A fixed usleep() loop uses
timed waits to synchronize with asynchronous reclaim, which the LTP
synchronization rules prohibit.

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
