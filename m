Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D05F41986
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776253622; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=sK/FgQ0bhZipZVTRD2RHExxvWRROdM8PLDn8RgUHS6Y=;
 b=Z1GNutgoeJY2AYQAmtD8/fsbyvMb/UwhgWcugiM3epm1tRhY4kKXOeu8W4a6kVk+l73Bp
 CDZ0zNZlxkMt1N8KiLcuoDKvYap+dxwExKSAAXb5Gl2J4VLpCODscYdJusoYlDYhDRTJP69
 kEerPIXdGPsTLDMCkkI8s063YwW3Lf0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EC493E5DB7
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:47:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F4DE3E2952
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:46:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CCEF600B75
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:46:37 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4888375f735so66257135e9.3
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776253596; x=1776858396; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7x4V+FDPrQO2wp6SvfTF/Jae1rotNUuBAzDKHNTz4BU=;
 b=G4XQteR8NEXCdvWUDmGYJmK8tGnyuKrTznKwaWqUBxYG9QtBP+mSUPTm9BFSvbT8sA
 3kjcHVLJ3Y/Ht6X9JrKLaSN6I3VtTOd5ssS7z5DOV9WDI0Tia/D/Z09ovln5dn3PMOVA
 pgTf3rjJvzXN/FibjTGmCz8CupbVvGUtJDCAG9xpz10DvUZp6GrSJamcIt5zyN3cVqNf
 2wYZSjsUWpPmrNLZQPMu+MRLXaGke5TfjLnUPSFuRXP3ZhBmLKWoHj3xRyMNwraguDQ5
 u3vSFACG4GlZu8w28vIgJtS1/m2I7EMaTfzN1y/kr9fwNrjzYi0GsPoVE6MDLrbJ8dmS
 kk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776253596; x=1776858396;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7x4V+FDPrQO2wp6SvfTF/Jae1rotNUuBAzDKHNTz4BU=;
 b=LPbvG+Gt4ZgGWq7Rr8v0Tw6IWzmWOsOysudDarVCcB+I2dMGxTBRR6HYMW5pM6rgxO
 SQzXff+DY/vsrPm4a6YnFPps+vxoEHfXaiNTZSys4tG5ObzpRSkgxh/TzPWDj+V9HLCG
 rRVPPtOFCm7VeqePX4H2jrGMn90pBOSGgZwFwdPy7JxLyS6wlzhQWjltXjdksbRLQuV1
 PasYhJPpOrpvJLfEKFCVGrFkT+u+jl6MHrO5lKvge4+7Kh9dOzec29Pk1gKmLFPikk0K
 6MIJiqhLJ4j4IkPQ+3YOmJn+03oZvs0YxiiHrfKf73QSvb+awYEmbK46m++m78M9MaEh
 4fJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++ounBbzisccyyRcGOTjnmwJjdNwPiwh8gNGl7yLk9uI3qRBcOQrb1XXYctCqhiuWvWUc=@lists.linux.it
X-Gm-Message-State: AOJu0YwvzMlnQtHjvaTK1Ajfyqu2GIKRlbjWLLEVftZ3VbceS/5oSv4z
 O/CbxActWSJasb+r7/q8HAoo6c4HXVpcFC9VEsRWVKJTPsoRZQe/r3qHjzy1ZVbN9KU=
X-Gm-Gg: AeBDieul3kglz6oAuodx5I1L2NuidHxjRBqLEqqb2EHbwuBOJpaMrM/jDt0Q+6do0S7
 m9OPyR1UsZAMPidwFLnUhAGf4TvQT3s28IfzvUbD/ws+qQgVZD+dYNQ7HdGKaz3wtFl006ArMPU
 9EqyKWWoIaeZZ0ckmSV2d+ls8ItF+Jq4T3l1YvUToc6cKRHNEn+J/sIDrdMgN3+jg4zMgQIoGzY
 J+iqeox8Hbh0MDwKCNN/vEHppc4qnZjdT4zQ3OOOXJwhPdIi0oUFkBARJxWQ6Hk0QFalRdVd9eV
 njznqCpzC6MyJBkgKTqTfUiKoOcHBm6oAJnXR0LA7qDi4ex8a70Hak0oCPMVkNk5XlgaCqdCXK8
 B3Up57ZMBmgiqZjmZWLAEHRwQ/qQdWkhvz+Gu9xbE6du/39XQ18/YzxPufKltwcBZ6FUANNiRUC
 iOJgj6GgVXE8iaf7WIrxgJoi61+mvp9TttxwXmlg4=
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488d67b8db8mr228577265e9.2.1776253596561; 
 Wed, 15 Apr 2026 04:46:36 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ecde5b26sm139587045e9.2.2026.04.15.04.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:46:36 -0700 (PDT)
Message-ID: <69df7a9c.050a0220.2dcf4b.026d@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260331200026.244979-1-japo@linux.ibm.com>
Date: Wed, 15 Apr 2026 11:46:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] editorconfig: add consistent formatting
 rules for LTP
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

Merged thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
