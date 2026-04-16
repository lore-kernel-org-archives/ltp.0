Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D482BF8A179
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:47:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93AD33E4ADA
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:47:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A508F3E2928
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:47:12 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 238BE1A00219
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:47:12 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d560ede296so938461985a.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776347231; x=1776952031; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tzxyw0AXDq5tr5IyX2h30aDtNO7ZNS4CZCFx5bA1EPM=;
 b=Ida/LRr7v1XPctKm7finrOMxAu8ixldtwk4LXadm7TfbhyuwcGhGycesaNX0BJ8+M2
 g8VFq3S9xaIONot42odqAP4V8kHj0ALyEfNIqfDz3r5DDh3CQCbG8UVbkZFc1ATdYD1E
 5BHCMLhqmk/JdM985h3zLNOYWVh14Vxu7CiGT0pQfEkN13dOQbTwCkRMOcEpqRRCWM11
 FfRxUYwlnG0gCN5NNgPamXPnKjkzmhO0QcMh2L9cfuhhfFGvEOk5bz/bOQbnkoep8jaK
 vl32+HYeCmlYNfc746Y5grVKnOXyk0fZVDvr+2uyftdeHj9NnSo//eiHZv5HIqoIXbMZ
 swEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347231; x=1776952031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tzxyw0AXDq5tr5IyX2h30aDtNO7ZNS4CZCFx5bA1EPM=;
 b=IdXEOvUaqaPuY0ft4QvG4N/YwOXQfnDtV2IbOqEQ1RjOdxyeqKXJREAxImP2dUPxFo
 zldAdk//r7gqr7UAoLvXaxMFn+H/4yUZXwVkxHOvMa+navLpQlpZ3g0W0rCUIMDOyNCN
 tDAapbF7s2dFKhePxKRn0d80gmx+MYDpFn4KQELTSPlhGmiaO5yp4nMUj7W236s4kzPV
 rnaDLJe0ARSAdAfihZ49AuuCWPVvu+Fvwul9bJw4DG5UjWHo426OvpvBif4Hm0vbUFS7
 gcdEafbL+Viw8hQrtJqap2yZDZh+Xvar9fZUqomVAuceSzbrc28WdFD9Ld1Aq33NLark
 o6UQ==
X-Gm-Message-State: AOJu0YxCVdDY53V/8SM483UFN4BH3UVZMf1p8TteiZxXn0OThBpUDBsK
 G7u+IGTMz7wBy2tkmblT8CY+8YHEVDJNwdESEUC2pfHAjJrLcOpv73ZC
X-Gm-Gg: AeBDieuHtYYAEb9FKWEWTqK5e2pO8HQ8+4ZTGCkgT4N1QjUTh637RvL/1TtX8i07e9D
 5V5ehnvVcEAgksMFellANYQHWY2FLpsV4rlwKhWDe8keHa3BBOwfFpW2MS+ZLmttU8zPL6rplWS
 VSSPMq1TznDYDZjT/6q82HcD+k8YIgPr1AXc5sY/pSz7n8YnBYMvvHNLG0CGdKebe9QxZwDVril
 i5ju/RjswNAL5RWuxsQ+5VzRxe5VqCQMAnnObtg+gW1CTr7FkYyl4RI+hjQRH8BIax+CqjeZERs
 sK9Rl/HoJWoUxaisIEcE2KKs2SKUMYMOOhTzlK///9UpRETeTrjhXkYMu1qs+myQzco7NV7M1BQ
 n08DqAObJXyd2SjGstbJo7tDuT4ZBHUMBYqWhcF3WW5qX5YdX4vzCZikBmWAkfE5GR3k3h8Bo4X
 LUq9/u+htTp4iGvo7arV8HsKlo+nBqXAvFDBCwtsCfs7xEiFWc4gqlgTVOTIlCrBQ+X/M4QX0Wc
 hsOHEceOiLqNjy2KIA2lne0bTMiqUdYc/XIWPWHDw==
X-Received: by 2002:a05:620a:7089:b0:8cf:d5f3:9a12 with SMTP id
 af79cd13be357-8ddcfca7a84mr3672354785a.52.1776347230855; 
 Thu, 16 Apr 2026 06:47:10 -0700 (PDT)
Received: from
 runnervm35a4x.i3bvc2db5o2uln5sftk5ylwv3b.ex.internal.cloudapp.net
 ([172.183.135.145]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4f2d037e7sm363781285a.35.2026.04.16.06.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:47:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu, 16 Apr 2026 13:47:08 +0000
Message-ID: <20260416134708.3953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416121638.11858-1-sachinp@linux.ibm.com>
References: <20260416121638.11858-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Add test for READV and WRITEV operations
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Thu, 16 Apr 2026 17:46:37 +0530, Sachin Sant wrote:
> io_uring: Add test for READV and WRITEV operations

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24513033939

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
