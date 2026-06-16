Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F0ACD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BBD23E596E
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:39:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BD043C54DA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:39:23 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A79711A00938
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:39:22 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304fb780deaso4407155eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781599161; x=1782203961; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMIjq6n6lgFDfePBsgZDkc5Xu+K26CCvo0VdpuoDpW4=;
 b=poQnx4Frx9Wg1eY5j7MhgeQb/dWQEksWbvXDyZocmAS65toPHx+IJA8oHBWazA2T5w
 YwD/YU7NVCDC2cyxKzfwxd9AqeTg9437xeK+Jds+Y7b+52IFsxVDteVSeDaaxMcAE191
 DcHh0XYRxwVwd+8LMri5xp3UlenoXc8UFMohNUKGVMkN0vEsBFGgn53YEFfSHpX3wFlb
 HvTVKM+12FyWeMdrFeFP3hB6l+quEc9/271PsBGNTwTrn0U7DraalLnBMAEuHs50XofN
 dj+9x/gv7R1QTJS6JmSIUm3eFgu+ovMiyhPmACwTWjIqgxPWbODxUPjIBkhFZPb/q+Rz
 v4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599161; x=1782203961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wMIjq6n6lgFDfePBsgZDkc5Xu+K26CCvo0VdpuoDpW4=;
 b=i46TjfBuEINxRVEsomlu8w58KZIanO3RIGFXvgWBHRYI3CGfUnQumzov5BRIbSHaQ1
 V+U+HRIPiLSAPdoLVc/rq7XE/sLm3ks3aUEmOxw2WBiu3BgkNx6A2MoIQCFw2fQtxkYY
 JvA9HXT/6zHxskVmmGk/Rl/v11j4RHZs2BwWKYUJlLYWjF0kGtTkTWQCLpMlxRjNdksw
 6l+TdBXoD+YL4844L/CGir+vptVDMOOvuka2+8xfbYACek7Jxs1tZQ/YUaEGUDyv6kUL
 jh0mQHn9C8mb/H430a7yvQLP8kVSJcQFkZqE5ao9FTshpnhd4h1xV6gGeOmlQxTyIaVa
 I0Fg==
X-Gm-Message-State: AOJu0YzyWXLC6C2zPMG1C6zJW8j4DWSaWr6hRaP6XJZiLeSBc3R1TYed
 LJHS6j04Cll5/cB/VErG5Qgdpl2dppMPlm5Ou9LRqi74tm2ozES+rJan6U49fDSO
X-Gm-Gg: Acq92OFBLF+Xv/FMorP9ruNU4XFHexmohV6O77KzGe0mK4cEK4B59sZ69MZCcoeZlPC
 2pWFsgbyjCNGfyJ55MvRLsbsbzqm3kOGihYvzOqIsx46Z81E2ZZxMTlEKYcO62kV09VLEILGRWb
 P9ssm/vnn7QTwZSd0nFKiiuojmMiiB8YYGGg2Bf1vtHDlOU2I3PChL1mjsbMgWeMF0h+4EDFodf
 Qb1Ra+63K+J4NMGiFOJ/GP/NmGe18DHAI59e2HM1Yxr0QtOng7seF0u5phNkH+rYXC+pnBjgDoG
 qX5uk0wZD+Io5IIU//HwvsqkN+ue5vRSPr4OjvDWLj4jWlznzJrOAJ2s8cl8yzpoiDJaRPWrRbz
 E/YepyeXW+yEjeOCLyylsJ2CM4o+yFwFf/5O2P5HYSl/63kq1q1JuVnD1cr81pD6hpd7RX6mVRz
 gCeYWNNsaiUgKia34gJVdGslFjRgQsokvO96M+38M3oqUq6w9/7wv5ebpsev5LKRsOs5YmbyRAB
 S42gwn8XDLHRqmVp2QNuu70MzyVPkW8ql3YLzA=
X-Received: by 2002:a05:7300:1344:b0:304:e7c9:b528 with SMTP id
 5a478bee46e88-308200d33aemr8997041eec.30.1781599160935; 
 Tue, 16 Jun 2026 01:39:20 -0700 (PDT)
Received: from
 runnervm1li68.5hvwskf5bazufculj5v1cfhouc.yx.internal.cloudapp.net
 ([57.151.129.36]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0849sm20148755eec.7.2026.06.16.01.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:39:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Tue, 16 Jun 2026 08:39:19 +0000
Message-ID: <20260616083919.4273-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616045414.9081-2-sachinp@linux.ibm.com>
References: <20260616045414.9081-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

On Tue, 16 Jun 2026 10:24:07 +0530, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

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
