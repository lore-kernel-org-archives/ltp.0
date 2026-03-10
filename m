Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1761CFD2D79
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773148854; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=fY+BAXUaEYXi4B5KR5XO5exJ7ixSdrhcpcxPIHi+B+E=;
 b=c30TmIX1oZB4ai1HkFhugMMgfqQtKGM/S9a1bz+xhVswaBqHtPR8VZFSdDIw1dztDXCWP
 UCYey4OqVG3IcUJzbOZRuTyu0VOgfj1e2604so6NSXOdERBhsLQUtipOCIueI2+ZaqwK/cC
 D+shYBQupvvFua3QVg2qDTMFzPq+FOU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553243E57F4
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 14:20:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C9ED3E23C4
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:20:32 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B1A6600708
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:20:31 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso17916035e9.2
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773148831; x=1773753631; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PkMUuXLSHZiAlqNPHcxwaLpQ3V8RihO0kPGiGIJPDCQ=;
 b=ORhwhPpKX3K2UmwYwJSdMy92DaM4aJA3zfE1SoEiUKsMasLQ72juG0f4Rl1bTBWjGa
 lgrb5RV8E6Ux83JYkLWaVai37aPgc0W64UHo2TDlU8avDq2KBJQvSxwJkUElQdkjX4Jb
 TDgS9zAHTRdl14usd4WeeYgagraLd4HDoTFvtO8TAWcAz3QoUEI8uzjuRDsw+zK2laLX
 OBXTk6UzMijku/tPyxHSeSu/+7Px3DysERDs037SKrcvq5vila5hraThuVcVgDfTNdfv
 22gWzM5W7qZ3gfM48/Bhw/nL0+bdoFGtSPDUrP+JdvSCvHXN2V5pTK7MAyDm8hcRxH4j
 PwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773148831; x=1773753631;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkMUuXLSHZiAlqNPHcxwaLpQ3V8RihO0kPGiGIJPDCQ=;
 b=HJqJr2T43bVAwTWF3cvZ6HAqssNfw3XmEGWmenpqGUpULQPLp1r6RgWVVQ3PpOFGX9
 OfELVU81QkBMQiisYJqn78OaBNf10TMplD76x8xiUozOgBJpS63nPkMZ1uQLIbll9gu1
 8tkDSmpv787/oVjjGaPwrmVepId9K3gHkwFSNvu4wFyNGtmCetwS6Qc/Wx34NkV7K2cP
 jxBj1HhAS8H/HIlk93cAjMVd9GlfrO29AF7q8X6kyRqEB+t8aZXk8JwPYtIsmGSUsSU+
 uwQaGuONaeRQDMZ3pX6rEI8PSlE2nehLlwQagW+nJ7LUGhz7fp9DCkdQFDfHYBmVd9We
 R7pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzIE02ubJIcjualzM4hKY4UpWfWEezmon7defwZWKmgxdBOf3DSoOqXHPc9z0hpfaEWk=@lists.linux.it
X-Gm-Message-State: AOJu0YzZsd6ZSiZ3sjxzMlsJoLDhNhXPQ5jn75drl/VDAXzBGmWIgTGI
 959bdFisn52Rw0PEU4iQVGJcO6b26ghzk+FWiC8s8zCc2QSiod4I0DIa8Abv/tQYJxk=
X-Gm-Gg: ATEYQzyzEALZidWkxadwmVAOu0zowt47YbyQ+8yCwjImWig1wnt0VLgeGm7l1ZrZWIw
 7/vdUoYf1vfON24YeAHNz1We7JrBccX6Ja/qSJPC6bHpCzSTnhWueuPrkVVkr4YngWjpYrQh9eL
 RVi4FAiXmmD+oEX7dRfYxHRuX5KXk2wr8WUjhNgBegPYVfmYqsav1h9E4jcP2Wt59aVIqezjLro
 dUEA+fZL2Fe3vtcbQ13NBDnZ1O/S5LanCNc3YGUpxreUTRErWXsWoOWcLBV4xilap1drdblnZ2G
 kAPZnpT0kCvqFeL2wedeaSUtf/EX9v/zFI0qvROiU7J++sp6+D9y0owDrnTqft6zbrR5uSrhhTY
 3Qz4ev62xHHHyPIgpfvYryP9tYOrLd6jpc/23ch2wyl1yvqW1pUqPkDSSFbmmorWZmWLnNEdAO6
 EHjsSoFvjLLMzJFdFqt4YPOL399kDArRx0ruhdQrpy
X-Received: by 2002:a05:600c:35d2:b0:485:3ca4:4eee with SMTP id
 5b1f17b1804b1-4853ca45255mr107191155e9.34.1773148830799; 
 Tue, 10 Mar 2026 06:20:30 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba5bsm34390055f8f.22.2026.03.10.06.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 06:20:30 -0700 (PDT)
Message-ID: <69b01a9e.5d0a0220.3ae565.57aa@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>,
 "Linux Test Project" <ltp@lists.linux.it>
In-Reply-To: <20260309-fork_refactoring-v3-0-8a645d7e00db@suse.com>
Date: Tue, 10 Mar 2026 13:20:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/3] Refactor tests which are verifying
 fork/vfork functionalities
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks for the review!
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
