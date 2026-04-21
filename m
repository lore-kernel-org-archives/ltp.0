Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D721AF8FA90
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:05:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 373503E53DC
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 19:05:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D59473C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:05:31 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E5BD200933
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:05:31 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2e221a71e19so4230929eec.0
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776791130; x=1777395930; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9A1fs49MLcfbnGjB8ezSO7Sz+WXUUIlMfn2Q+WmIfA=;
 b=FYvf5j7Nw1OvDhMyRxxlHh+yVZG0Hb0ygCQgkqu2LRKGITAmUAa+t84PzeskGdk8U6
 ZrQK2bhVX47Cnjth9AlFi/RfrRTD5uAszPMWUC2ci9w+x1Lt5J1SFepwHoTXPiiDtcpa
 lDpDo+8+a6EnA/M9+/cEYwlVvBXmzffhP1CgMyI/+ARIjnWuk0j/h+7x+5lrQ/h15/jb
 zvdTSITU0TGzs3F5fdK6YixAwdYdNvvbXcCYflf3YDjCTQijpATvkQi0zjAqeh6Fe9df
 QdwyL0Ba3LA7hHUmJUNI0lRHqTvLcPqMzU9urJRAMxYIJyf5GUFAJNT0UrA/M9sdf2F+
 HMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776791130; x=1777395930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V9A1fs49MLcfbnGjB8ezSO7Sz+WXUUIlMfn2Q+WmIfA=;
 b=YupHzq4rtB0bQhJ2NDMPRSwOWjEfnYNciwWCUeLLEer47AZyivXPRlzJV0m97GO8Cj
 SuLJUBgnQrQZoJ8M5RWOSGbFqQMiu3J54tHubmzKtr3FXRhpORt/ceeO7JNjfM4bWh4A
 WMGrGFO36/I7UeEQjKrwwK2EfOGjPPlA2Gc2KRLBidwZ95M59cLCqS6cEd3wiFCGMDKY
 YB6RbwZnwLX0tpNYiR42YHe1lOlp897fWFpzBQfHwPHK/y/etttPOmrvcxgi2v6G8d1q
 KpklQ73X1Jxhj6hAwIN//hcaami8PRMgU4qRKSIKQYJqnSjAT785KsYOxGKiMtcCHUy5
 hVdw==
X-Gm-Message-State: AOJu0YwkShjsa7bxAcxG0hWMYMONdNtfu+TPAyeW1G7+n+rAeq9LllLv
 k5cGRxX5ePbka/zJFLbNbGP50V/+MzQhU5rCsRD8onYzJHv5a3NQkUzx7saNy24XYPQxBA==
X-Gm-Gg: AeBDievpkCUvmYjHDTVUcgWyWDWsreOpcXadRGQGuuT+08ch+LdHOeq1TnMzMSUCYQi
 Ux67mi4G605TEMozyVqJObBs6q0yEvBIUPSnbqfPpuC75445ReaHAlsCEri3VJy9rEiHMX7MwBc
 aSNx7OISnx/+VHd37N0/LZ41fu2YFDpb7X4MMeh9P6wRNDyXQNl9kSZAYGhqfJkd06mbZdwspZ7
 CVzdslJhLRHZhEycL23YqvP7DQlsYVtVjawVSUADtYnGCgfEN2dUXjwtfau8gZkWhL/5NFNr8bC
 NqLsfVibDoplqYgCTUNo9JMrBlt9ZJI5PnFRu4JWHt3q+b76lMlQIqnvOCnm/8WuYGngMc3COzQ
 hHnLEe+5P/GnB2EZYOyawgGKNdGhhM+yMggimoDkENQxIVnI1H3LqWVeOLuDLelXM0KolrEdukp
 J/wfusGtSITmIPfq1BzA2+DBUfwVvkGHXiZl7V0FiCWy7RjlyFCRFZS3PT0/b5MUV5hDpc8+FWM
 UnjN4NleuIsnMIoiNTRvQnZ9sLVCbkiVDZ2NMJH3O5652SiHw==
X-Received: by 2002:a05:7300:214f:b0:2de:2f38:a7d6 with SMTP id
 5a478bee46e88-2e479c0424dmr9638946eec.13.1776791128178; 
 Tue, 21 Apr 2026 10:05:28 -0700 (PDT)
Received: from
 runnervmeorf1.ds5r5dszg3eenmbmpnlugfotxe.yx.internal.cloudapp.net
 ([128.24.163.34]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53a4a8018sm24596354eec.8.2026.04.21.10.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:05:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Tue, 21 Apr 2026 17:05:26 +0000
Message-ID: <20260421170526.3848-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421160828.4483-1-always.starving0@gmail.com>
References: <20260421160828.4483-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] include/lapi: add leaf Makefile
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

Hi Jinseok,

On Wed, 22 Apr 2026, Jinseok Kim wrote:
> include/lapi: add leaf Makefile
>
> Convert include/Makefile to use generic_trunk_target.mk and
> add minimal leaf Makefile in include/lapi.

The commit body describes what the patch does but not why. Please add a
sentence stating the problem, e.g.: "include/lapi/ had no Makefile of
its own, so include/ was incorrectly treated as a leaf node and headers
under lapi/ were not installed."

[...]

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24735550612

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
