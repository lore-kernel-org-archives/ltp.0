Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C45606A337
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gGZNRcH6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D50F03E9FB9
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 11:34:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F7E83E91FB
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 11:34:36 +0100 (CET)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35F3A2000FB
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 11:34:36 +0100 (CET)
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-3b411059cd2so226317a91.1
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795170874; x=1795775674; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5HWr/HicT4v1s5nR1XuUcO91ZuKIszFafKyvklXJD24=;
 b=gGZNRcH61g2p9QIjxra4mjR0pHX/fh5T0M4w83DXP6jHdakrCqaT3iYm7NEZwGU5Yl
 L2Kt5mp2MQkjJqrZj0IYQWB15KjnIvMYJ+d0T/KkMXxu4d4oybGnJyt4pwctdfvE+aJ9
 N5VvPwBsPYJ0+QWBpP/z3xdW5MeAsxh/hv9E6sibkOYm/VKCUNfmj3DqD5VqDMOSKeii
 B1ffnS6IvYCfs3ffvSMcy86CaZXcNXRZiy4mgaV3Wymawc+OARSrOi7RVaAhT6GZi0YY
 M3z+gO2SQUsL0Zhl8v+YKXKfJphuhHjOoPWOznta+rUc5KCxAWCqtGRkRd/vGhfvX37w
 kRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795170874; x=1795775674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5HWr/HicT4v1s5nR1XuUcO91ZuKIszFafKyvklXJD24=;
 b=VuzDElhyDcgjfaQQu3AivB/5vPit1b/1kCXyo+2uRrXNDAF13Qs+N4RNA/zAVqgwKA
 t331OpqUWvpv/wLyVyz6koH03DPQjnlr9G6SurwuTUKEGAIReWpRU/KORBE5ClQ2igsT
 Eglq+EJwdbEexBGjxC9rAbsqJ4lKfx8mhY6UsjTmXB8l5GBvOUjNNbfBqz7rpBbSjtSc
 5vRKamlFncGekukvw2qqzcCCdfe+0iR9+P0qC0atrmgbNJlYKKg1Or6VnzBZS+tT1jSl
 IA4QvpTl1n8H2kUF2LwGXp2mPHKQio+trmSYP1GGU3TjnVuj5fKSWf5xEe5uAy7Ng7ct
 bxgw==
X-Gm-Message-State: APuU4Z851pCjpdtvLShqUltVY5yO0D2gjAGuPxV2g/oWZhAyS/bvsVcM
 VFIxd3ZrXX37LCSlKzHXqrrsPGHmg+HhNVdyhQeudwjkcZH4wHoq9Qzo5rfkaZjd
X-Gm-Gg: AZFdTZdorW/1b5Xm9g1g5PN0e2BV2aC9S42coxMFPyZFHd6r29qCpRLlfwC0oOWcr+A
 mL0co3WBt5P6K4cI4KvrQs4DApYh77RbItsaa6dq/VD6GKoMFSO9q8kJ9jGEVR6tEwKgShRvMfn
 AXqv6+79d4mmUNe/xOY5qlN5h7yMu36TDYOuIf+loYjYMoUkShyNGJHrn9kLQbpTT8/kfnQAXS2
 +CZoahrWEtecZcgGoL1GSkcnuKUWjuNx7aaZqixbvrbSuf2zZBAS5AQ05N/dzmXrUZCQtCYTB+7
 wc530gs5N9SdqAa36YbGA5TqLUg49dxzRYcXdIVgjZNAbu4qNg2zxy0R9bEyBzzzP/TmL6J4WDH
 ZLPSe8+g6+1MPFVa9pGaoVGjj3sbdrwO60nwzJsQMrdl/l7cgCcVnoKX8K7QNrtJdTvyI30Vphg
 kDT3mPaXDYAtGQmT2YHJy6fQpmIHC1wlFoHS6QjKI4asAqiksAYfhLsFIKSzTrTgVJiINZeOtyn
 ClIu5cWkmv+d50m+s4IKF/slf1Wt5LHKW7inruIgWi9JbN9VMoBXiGZ8JRzulWBVZRB+kihhkAu
 IKQcjyNGWBPKaYADs7uLfi0VIeoca88+1leu/ivoxWDiMkRiWj3glsxVOXXdP6Dx7NGi3gteoI6
 Y8h9we0uJvBSiuYl/ZXkipJwpVpjQuiklVFDjD/5httz1ftLAnHVyy2N7YfGJ389j
X-Received: by 2002:a17:90a:e70c:b0:3ac:96a3:77d5 with SMTP id
 98e67ed59e1d1-3b41caea948mr1943769a91.36.1795170874349; 
 Fri, 20 Nov 2026 02:34:34 -0800 (PST)
Received: from ip-10-0-143-163.us-west-2.compute.internal
 (ec2-3-42-157-140.us-west-2.compute.amazonaws.com. [3.42.157.140])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea7c29sm1082078a12.1.2026.11.20.02.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:34:34 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Hubert Mazur <hmazur@google.com>
Date: Fri, 20 Nov 2026 10:34:33 +0000
Message-ID: <20261120103433.3857-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120093444.609481-1-hmazur@google.com>
References: <20261120093444.609481-1-hmazur@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_cpu_topology02: Drop upper bound on core_id
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

Hi Hubert,

On Fri Nov 20 09:34:44 2026 +0000, Hubert Mazur wrote:
> sys_cpu_topology02: Drop upper bound on core_id

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
