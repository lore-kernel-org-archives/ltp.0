Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFAA6083621
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXOdka+X
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8813CE28E
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 12:35:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609B93CA9F9
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 12:35:02 +0100 (CET)
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 09DBB600463
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 12:35:02 +0100 (CET)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-85f1800532dso254629a34.1
 for <ltp@lists.linux.it>; Fri, 06 Nov 2026 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793964900; x=1794569700; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8R7oBOkc0Px6JUnOB8jcDkHnRkgHWvFiL0JAUXlIdms=;
 b=zXOdka+X6lvrhJHkaS2A5fZWRXfjltROpPquGYM1jSHd00Xgxpbbx+huBLB8DbvNjI
 cGmp+dEZCM//b7kaSWqPhal2c+3dLNVwEWkuwaOiwP8iy7G5VladzzL0HCBW/FZAkwOj
 xFRCJkF09M5eqa1NHt/XTr3vHIHbSwBRWjkz9HMlpaHZOU/w3mPpLUIxvKH6T8ZT0sRI
 x5CAnpvUGT1C4TfUUlhUQRjiqqqlCuD56UqjN3bnVdNtIw7SBXDfE18PxVeN5EzRNZGg
 Yqjp0cXsMnZRtM9uqc+Z6lTYtxGIE3bH5eEQvJ8q9kmc0AxOg3ukSpWKT+5NKMuJdukv
 5axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964900; x=1794569700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8R7oBOkc0Px6JUnOB8jcDkHnRkgHWvFiL0JAUXlIdms=;
 b=CwKTc/j7ga52CgmpG8obcpl3m5qv1KmdR8H901QZwJ5+x86t2GFelCUfcXx9yEZ4MX
 TTHagabWnlKONpBkZ77wSykG0iTKM8YR4WAq3/DINwJ7Hz++nrJBrNHpiAB8Mk+ApHcd
 4ySYU4ofd/tXS5gxkrWNg8GoXiG/QESaE2MuNS/MhRg2XO0zhMW45Hohps2ei6zZf3qt
 F9mRSBYEL1GbvO+t4tTP3ZT3huBDcCZHA+PF1MAWNxKKMmAdkG/Nh2R6ewh0GN30PpiE
 pwKOAmhqSXwo1xoo6SYyCcpgF8iWr0UWB4eVJydCPJE+DBURqoAZI9C1rQ1WNn6YAUgc
 zKpQ==
X-Gm-Message-State: APuU4Z9m2KkikGE6y68l6krjD99riOp0QPPri2p5phx/kbNlmnKMRkcm
 FliEebrhQChLjO9hzRMJj+cfGiZIgzVXVJjCfsyx0bQhTlnZtpHJxw4x
X-Gm-Gg: AYBFou3EFTA6LGtV45rvFcNOJX93iOO+iJsAavAMgE16QNHS+fifykFlc6fDzjTeU0a
 87pnbKG+62lzJBjmYLXY8Mx7x3htneTU0Pvm2J8iAo+74IzUfWcSWmvet1hCMB7egbHCGJkHxpM
 AsYDB7uZTSkgw47nPO4LI3xqk1CkkuHK8hJhIci6B95tW/Z31eTdYBTYAR8a4CTyfKD9oDGkjh0
 XtGKYc4YjnP8F9UfedgGNThphpfH6nGFLEwnsBEGFljAprBlHnSuoAQ9t1I3G3bnA+zS4ROVWio
 86DRwmyYmvhZUnkA8JQ8yYhUFOiv25z5kbLB7gikBWT0IrLIx/453+Q5J02q3sETKp7zdRb+3/i
 JugA/ukXrjqcuk86UPpIbDbm5lfYl/M7Z0l+So7TrkRw7z2mGk7OsV2PhQDVRxp3IEAi3BcIZ6F
 RgBvz0jRHUL2gJOd8+6mL/Xo7YlVIwG6Eg897nu3PwjiT64uNiwGbhIlRG6hG1tSmTvzCG2bc0h
 9u9ydlWiKG89thTY6zvHdJGz6gXc834EJmEu9+tvR1yEsVzb22JIi8JcIcoaKiILNE1l+h7+dQO
 uMgLkXoLyjo4tSXOfst5ojU18CYRZ1XHcI0oicKy8WO4xG7iP08GuSoJCXUD/ufbwXulAP3NX4a
 WpvwyRrA6FuomMmPTA6c3Sa9vj7L3urShaJLE3ojfbg==
X-Received: by 2002:a05:6830:4c0d:b0:81e:1262:6536 with SMTP id
 46e09a7af769-85f1d0269fdmr2066815a34.15.1793964900590; 
 Fri, 06 Nov 2026 03:35:00 -0800 (PST)
Received: from
 runnervmwuk1x.letglsdgelwune0gz5ahsjpokc.jx.internal.cloudapp.net
 ([40.74.209.166]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dbb2956sm1645928a34.7.2026.11.06.03.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:35:00 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Xuewen Wang <wangxuewen_ky@163.com>
Date: Fri,  6 Nov 2026 11:34:58 +0000
Message-ID: <20261106113459.4176-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106032929.63222-1-wangxuewen_ky@163.com>
References: <20261106032929.63222-1-wangxuewen_ky@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/cachestat05: Add test for permission checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xuewen,

On Fri Nov 6 11:29:29 2026 +0800, Xuewen Wang <wangxuewen@kylinos.cn> wrote:
> syscalls/cachestat05: Add test for permission checks

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
