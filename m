Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58535FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DA693CA6DC
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:31:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9850F3CA6DC
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:31:12 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E29571A00987
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:31:11 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8ef45a6d9dfso910786985a.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777447871; x=1778052671; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL5bCIgaCzbmBeJ+ejQk7cdTOKhucoR4Vk+zes26zXA=;
 b=IHMfhKvrvKvu1hOdfkNIVNqIIUhsi7hNqv4nQlC97Cg3jIHum5jyuNHH49wlAf8xN0
 jIWcAep9wGxSz8wwcRlHYrnSIixyMZp445GLYr1dd0M6wGej9ic7/HcUL+MuWAhMfhrY
 I+HaCKTD8TIZq5X4QWxjQKlLPlN7FwxSZxeZ5X63aQ7csREVm//rbWQQNjv532ypv+58
 uhsSBxnOFsfcVU7PTp+6r7jGI6zyPX8Bx0VE4D5SX4xap9Ki09JfBDTWJd8cI1n+DQbQ
 oNZ7NKnmT2Bejgrsf/oCZpHpOMgyNyHW+B+LCKx6IgQKmMcfLknkMWIHTZrSZUvYGAwG
 Nc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777447871; x=1778052671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fL5bCIgaCzbmBeJ+ejQk7cdTOKhucoR4Vk+zes26zXA=;
 b=LhGf1kp5TayNxjb+0docbyk6lvFVP4bCA/wWqcm1gLlHH+pUyN37IzNgoFRRyN3UUx
 xRQIrSfXt/M9TnyIgMXSXAOROQk9PVUNpa76sz8xF9fsxXlI7/k7EcWWTKzwR/IyASb9
 TOk4efFt8kkUjY6X6e/7udhegkRFgOYjAyrlVVoU0MooSWEix3KeuEw0c55tBahp3cEO
 Mu2nujT4YFKJCYHxMmLWTXn8w00NUPucrHeAkxXvjWtgd9925CGa1GXLXATtbUFM0/UA
 Tf+yfIw8wpc+4db1lQy48VXhVwFOJMqEQmQFYumLYfQXui0gALnIRzw0DgGgffeKFwhq
 v6HA==
X-Gm-Message-State: AOJu0YzLffY1quBNgCe90mVKxHUQ51lTB7sf3xx4odgg+jzK8TgmAbBm
 hJ47N8g9ZZ2yqEEpo/GTu3SrA3Z2ygvWfwcxCYwBgFgS4cIO60uQZ4+V
X-Gm-Gg: AeBDietGm48Ub7OipOZSbzqZWAbNIjJccasMxgajFAHrWIDsXXvS0aaIpMsZZNbM5nw
 ibVI9frlCkX5prIvkop35KnrpXzcbOTSUmKwJpIB2P/b+yer+KBW226zllu5IJqMkGBoiRNGvQg
 7UJ2g0MQsqXx3sEpjx4r3XrHvWrbyKK/Viu1XDQwtESCn7Q4/jQyooPU+afw2fZNdRN3ylHAsQj
 3QoQt360o31k0Pyei32xBNglTxAp8T0lKfoaFxksMWBnK//0IK08vqjN/wK2lGqnIbICT/R4fRU
 EZZ7OvPoNArzMCf7J4NQooy9i60pm7XCwmacjBfaCPPzgkIs+PxEsas+aXBXD21g493g73P5gwi
 htBlm1vgw8/KMLb1rVJvBTwuJQ+lwZ7Qm8KxZxY3n3/ZZ654Lk4+k7FK2v80ErfWPXdctNfgubX
 LvagLsKgTFgiPEiwnU0LHlPRoYJstgWA61KG1ufuaccc3o5V63Sw+dy90Y4y133rugAxAmFAw4X
 ACJpB1LslhmLQ/r6+Z762v36DD0iqtO39Xtu7gvQbzwt71ATkY=
X-Received: by 2002:a05:620a:40d6:b0:8cd:b7bc:5184 with SMTP id
 af79cd13be357-8f7d6f3fa84mr840606185a.8.1777447870637; 
 Wed, 29 Apr 2026 00:31:10 -0700 (PDT)
Received: from
 runnervmeorf1.3xinleeka1zelpky03zrhmkzma.bx.internal.cloudapp.net
 ([48.217.140.229]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f940051f74sm110258085a.38.2026.04.29.00.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:31:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 29 Apr 2026 07:31:09 +0000
Message-ID: <20260429073109.3901-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429064011.3200745-1-wakel@google.com>
References: <20260429064011.3200745-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/userfaultfd: Handle ENOSYS in SAFE_USERFAULTFD
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

Hi Wake,

On Wed, 29 Apr 2026 14:40:10 +0800, Wake Liu wrote:
> lapi/userfaultfd: Handle ENOSYS in SAFE_USERFAULTFD

> +		if (errno == ENOSYS) {
> +			tst_brk_(file, lineno, TCONF | TERRNO,
> +				"userfaultfd() is not supported by this kernel");
> +		}

The fix is correct, but since this is a bug fix, please add a Fixes:
tag pointing to the commit that introduced SAFE_USERFAULTFD without
ENOSYS handling.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
