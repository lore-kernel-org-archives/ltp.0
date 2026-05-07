Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8803BCD343F
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778157643; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=YPdE8ls/eSjl/vPQYQ5U1cZ8R/l41aKrN1gXa913r5F3g89wRIjIQbIhlQ/4sQF2IWz0+
 uRK2wPXM0cRyV7exiBq/SxYlM5x4xFwdqAJ+7TIVSd7yPC9vUdtFj8wjO53g69LwJwFFVv3
 wz32VvE/QDkUmevNg348qBmNvydsiA0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8333CC6A7
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:40:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3651E3C1BE3
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:40:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A89CD140017C
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:40:19 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso6195615e9.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 05:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778157619; x=1778762419; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=AOOix3heHf9JcLZvDjo0TcLFfVwYEiM3ql6kmOubMnlPbKvkObh4eM/Rk3seKEzkix
 mtuy+E4AaNayzN5GuT1MO2cZjwD2EaZo/o/PvUbHrlABU8E1DR4RfQ7WTFn8BF6GNzWa
 6gc+1cPAIcNGmb1u66OZtppCalDX2OFK4barf84fFOfLhF1sGMu9SLqQXZn96O2qKSTl
 yDHhdPzOgHUFazJSJ/LwcU6ZYoNnmIMm9Q7z5U5wGnT9ZizwPy9Zqc4BV7J/yF6aJ77k
 14RrIciOE/w6qfohcH3t3gOCs8GmiOzPQTPhpopZ6Rmrd/NNsgWYxgif92UbEjIpjS9g
 yGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778157619; x=1778762419;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=BalmflFok6fGTopV+BdXgY1Vmh4VNZnfBInVXAb8bsyxPdtriJ14JD3vAGdSbL/ljo
 WK2y2iT07Hul/p6QZjCiYERj8jqTurwBPTrL65eaGFZv8kIZjObFkds3k27zNEsKkF1w
 IRB85sFkMbK2BY5GG2GYORHhhft8yuBVZbtfeFuoTo4O1As2XM0B3P56VWlIs4QdD2kO
 HDJGGBSET0HXdaESyZWTlpBtp+BjRF+3EcBKSlLjuXZgFtMY66xx56Wr6g3XCzNvgtld
 ssxsH95v7oPT0VrlDOact1hugNLy53HWRbaQUW5aR+5HxhlohhSIsYFoR783gnY2NlK0
 58Wg==
X-Gm-Message-State: AOJu0YxbVjtYX+9i0+KrAL1iuy4ReDmO23sLNnMFgVCc0Bx33LLFvsZq
 ayJSMOIyqgz4sPZnpPCFcSEYrloe3J1CXGhUL9zwmycpdHcOuLbqx4WTuysjBHH0Z6A=
X-Gm-Gg: AeBDieux3vxMoNGCGW7kGbO5JNPIvt6I6nagMrMiSL1V7P0T159jGKDt91+uMIEz/tX
 CtGhU09oZGJ2MGCeMtbeHuVbSGisDlfdstdcUZxpX+eSr7O8+KU9IBH19iPMOuTcqj0QXabe1Ss
 S71/mAC6AAvLe4AeKzZVSmNPBx5u1ZoRc/gWUTG8uBjuobcaH19XI+wwyahzW34bC/SHevS8/Xn
 sAUkNoKRB3rXnZdeWsfUdukYrq64ChbpOJCS4AUWiYbl9sI7GZVxaqz4ECVJ7F8c8E6xLd6j4sf
 wT/Veo6x75MSRfx7w9OWX43MZ1XtKnTYRsMv+ReYDXgGAl22CNJRq9SjmYvS4LaOsj6F1vIi7bY
 5uVE/5NJ+LrySuDTtYW1BeAkTOp37qZe+JayQkA1Crw875UNz5T4frD4OT0tJaTKVRv9/ARjG+9
 orGgYhljmtC98dOeM7VeztWuYqklhlGfC3NWO2GgzVOZ5XIAXe7pepq6SQwB/aJg==
X-Received: by 2002:a05:600c:354b:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48e51f32a7amr129989345e9.17.1778157618743; 
 Thu, 07 May 2026 05:40:18 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53891163sm134204415e9.2.2026.05.07.05.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:40:18 -0700 (PDT)
Message-ID: <69fc8832.050a0220.1adb4f.60f0@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260507122858.19670-1-rbranco@suse.de>
Date: Thu, 07 May 2026 12:40:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] userfaultfd: Add helper for checking UFFD
 feature support
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
