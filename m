Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB8ECA5FAC
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:51:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D8873EA036
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:51:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F0093CD10F
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:51:01 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0FE4060076F
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:51:01 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-53321db7e06so23546431cf.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704260; x=1791309060; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/WwjcsT3BDYzZYoeL67E7E7N07auaND0Oc9kswwZWnM=;
 b=GzJB+hll5oQHURHUttO/nEGk5IIK8herI+PBcJ3Q0vw63XXELiYU1UcMeDZlkOtthK
 LR7wGZ2PUC/m2P02EATikAT8cre8v1H7wM9g0p8QGMCqMrNEv7Ibu55TpAE9m5KgOcFs
 I6+wgXmq/M4nTYKVW2UYNDRTad/2GuadYZPNJqcKjjS0ecwaRGk1xa1JsF+5v0co/bSU
 cn8KSR0nr7TbDRhN/EBl/XV4yihNYqSywNfU73hPjPn2KxZJbJxDNIHkoPIKRcutWLwc
 BsMHJUAV3J4u00oO6ev5nb++JlarbSp2QuL3+crmZWQiYWOiz3lh7pgxWi/DTnEKMraF
 Wq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704260; x=1791309060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/WwjcsT3BDYzZYoeL67E7E7N07auaND0Oc9kswwZWnM=;
 b=O4HYV5VhmbeWy+01dg5o3hEVj+kZiseR4dhlA6SrQcrA7YxV+qzkPczeTizMHzgadu
 3gZAvFGp2f0+2v1DKK9O7/g7oSXU2CxbBzZFo1YC1nlEITwA+4Q6+oY7YBY1MAgRm4Bm
 tviy+tckig+WBFiL19gkOH4D7aNkjWd/Zj93NmQZzz/mn7YVNTh52WO2AdjykcJCkkb/
 v65c+Hu30UfPU55UJUHn8HM9UZ4HbB+VScNLlrNmhDyH5tBxwrC+U/e7o+6SfBZn2k+f
 ZNTJIftnc/ohfTOK9QLuZ3lc1tPKmNimJdM5IgBOpllXH4SP/K4A+GFKQdQAAwmJGEXe
 BBzA==
X-Gm-Message-State: AFuF++lh5cwsoG31MebirImqU8wGcwKti6NzNqlALDbQy68q19Q8d0DM
 z2b/9bUN+gmAnqiEgdN8NNh5yjdo9VCwTS1m3lE2NZktDkVrQAh0Jw1g3DLjSRLM
X-Gm-Gg: AYBFou0hA786dH2rS3ZO0ZXWYP2kZXcDsrht9xy91uUNZgo3qoqS7KkFfrCTaVqTLPe
 ES7JjTf3N0GZ7eTNtWVJ/MQmDdO76MqEud+ki2cuD8Kck/wwnhprROhRTVH1LWDaJ46hT94YKwj
 +8TsB/0RHlgaSRPVj5KniVNOgVZylT5GzRemAIiURys5kOf4ks06wapxTjhWnoKK3AXkkIkU27/
 r6Ogaez3w1HeuPkZUHKXXUP/ssqyUwpkp04skaWs352t8Uk4JvMfXwJB4wLWjy42WksM3gtttuM
 oNLEjSxWgXOn3WxjTmZWgmlxije8FEF5OrYZiZW7+hurxNiBvReEbqqvYmoC0tu6MzFNPKD0wHA
 LUl4LI/6D2FCKSFoYI9qtEl+dxy8h0FWSVF20+9ylmh94JnpurVufpHajpgln2Bf388L8m+D5/y
 3kI+jYwQY0U3DIODM+61v/5eMdpuFnOCH9EZPRQ3uzNcoWi2hy66bCk1o/K/j2uc6BQJo5euCC/
 8FhOvMK1unM9QRjBn9SDqGqsIlc9KdoqUhlwznPPvxTaPUZhQUZtrntMtBvgkfOJg+Nhfk5Fe0I
 WOHb1W7Ym0o5Eg==
X-Received: by 2002:a05:6214:3d03:b0:913:efc3:6ffc with SMTP id
 6a1803df08f44-9142f746f61mr279500046d6.22.1790704259516; 
 Tue, 29 Sep 2026 10:50:59 -0700 (PDT)
Received: from
 runnervmtr4k5.pqd2vc5ezuwebdrj0bejnwn4rf.bx.internal.cloudapp.net
 ([172.174.118.102]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9179864a367sm1081766d6.5.2026.09.29.10.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:50:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Sep 2026 17:50:58 +0000
Message-ID: <20260929175058.8697-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com>
References: <20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Handle empty saved configuration values
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

Hi Andrea,

On Tue Sep 29 16:15:19 2026 +0200, Andrea Cervesato wrote:
> lib: Handle empty saved configuration values

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
