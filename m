Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDBC43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 05:15:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 168813C96A5
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 07:15:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A77923C2651
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 07:14:49 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E771C1A003ED
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 07:14:48 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-92e7632b193so149498285a.2
 for <ltp@lists.linux.it>; Sun, 05 Jul 2026 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783314888; x=1783919688; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AT3vBPKn3q1Y2xvp8ehzPqKYghBKB8ikx/UM38F49A0=;
 b=F4Mpb71Kb7VtfsX6/BL55Fd8f4LDnyv4TfWmzIODL3qH0UFo+NxRN5+ZNwgAgAC/Vd
 iJzL2EFa3POLMKBRKJYrw055GsimxLOuu4gqVtwJS9I1uj1lfeqKcTCAALwZBDkQSSon
 Z0bEc/39ABE3820cLJwZTNNb2Pzh34DKTIB5dt3mx2upzDjpB2qqiqhFP/QiYelPeJQk
 S9rOSEmFiyBG32o95MHRIcY/f95rA+86BCKwIVLUJflzESf7I8E/txv9LJQi3Mm5QKEg
 yq8/LJNnnNTQE7cuUHwAIPhHa6jBlE/QFk1Tq5CngvYr7wGS/L2EVYZfGELfS0eQWTtH
 whMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783314888; x=1783919688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AT3vBPKn3q1Y2xvp8ehzPqKYghBKB8ikx/UM38F49A0=;
 b=i4gLT3T3bpIUR19ZeNQGZ+Ujhes3rhbHND1LpueJudWYwVHII3alQok0pbF23Q42eG
 EhLAMejap8B5QwIJg935mAFGFHHXttZ1K6bL29JEcfwWTBx/q7/e/eMa5+gl6VjRswLA
 xCQxFrOXYgdoHIMMgS0y6dr86bMokyYGQjkLSCfnS5V59LNWf3KL7sa6AGnnGLYs2aAy
 266WRmwIpBTAL/88GrH5egzynXsMHeo/6hSs7ZhsIoR+tTiCZbU2TB/Srl9le5BJ2Z12
 tzaTGhQhAwlX8Y8Qm1kg6g6gH+PWf0nJFVAqoNjFdeQWS0SCu5WajcbVXa8ZZ4BW7cO/
 KeyQ==
X-Gm-Message-State: AOJu0YzRBjwaDrHAM7YP3hKee54rg7SaXRzHwj0mFVsJ3PHVwqFZisPd
 N5VzTTd2JHAB2dioN5zXxEy9g+pwgjySOG8Eqc/VkWawdFvXDM8P1uce
X-Gm-Gg: AfdE7cnYcpCmdFGpU7D6XrUf91y4jGhGL9E8vgJ2KCoG0A/Jzzet39kyhsXOb6MYQU/
 x+rWR5W1LeKSSchs6rGtmXL6TAdxzIqo7Ki+fNb6TMpZWv5PQv8C+nHWAmXVwHQN6jKhXcgLGNt
 lygz+E299mTxERRO6qa9KI2CM1MSK4vugrK/yNZ6jf2B8CdXQ1js/p8D2WMBgwiHyAGg2fllC3X
 4COLTm4I81rsuBPB8V/BDgSKoPNEozDZs/lOGSOKRwdazSVvVb+q6LaTKo0Nkm2s9VSLjo9XNby
 rTpUQKvpLmQQPlxtFpEDaiOqCRy34UyzaG0vPZ/SXiGD7wm2+6oT+6GETVgF6rVhIVutLCPfZJO
 4qqlV/M6YJc+15h/bmRt99aPAmP7zjlecB70Pim1fpEM3DJ250rk3z6cwgp2EPxdTJ2VlrGwRr3
 Ylv62+k5CZRHcRY3PeIPSzXiZMvFtxlrYLrcRb1SQMqn3tXFWrRY7WEhCOOj/YhQcnAijUavXk2
 m7jtwpfC4fE2jRPMDqvcOKIHPtAAIskMP64TA==
X-Received: by 2002:a05:620a:4041:b0:916:10f6:77c3 with SMTP id
 af79cd13be357-92e9a3af101mr1083459285a.28.1783314887602; 
 Sun, 05 Jul 2026 22:14:47 -0700 (PDT)
Received: from
 runnervmkkn4f.mdtce0mt4ome5kzwfyfkzdq1na.bx.internal.cloudapp.net
 ([74.235.90.83]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90c926ebsm858154885a.31.2026.07.05.22.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 22:14:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ivan Hu <ivan.hu@canonical.com>
Date: Mon,  6 Jul 2026 05:14:46 +0000
Message-ID: <20260706051446.3966-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706013720.450291-1-ivan.hu@canonical.com>
References: <20260706013720.450291-1-ivan.hu@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock04: Skip variants unsupported by the running
 Landlock ABI
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

Hi Ivan,

On Mon, 6 Jul 2026 09:37:19 +0800, Ivan Hu wrote:
> landlock04: Skip variants unsupported by the running Landlock ABI

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
