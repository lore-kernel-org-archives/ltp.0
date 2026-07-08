Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37126C43602
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:29:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E3E53E5CED
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 17:29:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A7323E1A22
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:28:51 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A37541A00701
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 17:28:50 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 af79cd13be357-92eb1058f3cso18887185a.1
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524529; x=1784129329; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uaO0uavY3Q51UqvJLbrJGdsHLX5vEHSeu/ZeMovDx3A=;
 b=RSauYgJQaAhC95BxQ+dvS8+ZQci+edjryNDA7w4NzDewdVQU1+8V8Q7mr3Bqn7syH8
 0GKYJpf8bi9f0RXBeRbBWXYW+LAcqT3+WTx/JRaT0/JWEGi7WCY5j+aFasISShSgjPhR
 zagfbMbddm1v1XpFSfNa7Hw1nmobJCWvoSrwTYyU4FGD8UIZwBYRCQ8mCbLpxBURQBJB
 fLaPn/oIWJw93Clm/HIa+Zi9dFgoT2qgNAdUhGvXPmU2GkR+PQr96ptLbU2g9uC+8lTt
 ocUrya8VU542J7V7LJNEN8t3RrNI4HKcDFjSzjp38TJuSmYPbYd8/0In8jAATH53y5QB
 rHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524529; x=1784129329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uaO0uavY3Q51UqvJLbrJGdsHLX5vEHSeu/ZeMovDx3A=;
 b=aBDMaIiJTu4fJdERh8b5xXCHNULGNBD4Qslcv7vrXXrEKmdOaG3Vg2PEAQ2IEmJspX
 cqAzrYCyzf+qqRU/3MceSLIkWqlkQbV66kPaLPBAx/Aa9vqNnHbspWGGmlZ8jvqx6ZpX
 i7WE1WPVWFq7Dst/gA/nwsJxSmHh7lG+1X/THePFvLB3FVK39zZfKE0yoiTzWq+xCzf8
 wIHkJrzujkO2b/+fOgvbI958O0gbohDI24GMk6v2yYgOzJ0YbSnwvQZ/R0kEi4RtxwXp
 qNsGwYLQ2dgzLnHRE27z+pA+lrMBbRGSJvCHdhUBVh+5P+3CLOQWkoSfWgT1N8/1nqBh
 PYQA==
X-Gm-Message-State: AOJu0YzUHN2JC8U5J2oRPkJyk8ys6ZvzRltfPNlBDuhMHAHrp+s7RLs9
 uyhN2BnxF0Qfgl2/X5TxQY03+7Vz5jJNHuJWt4ObRJF9qA2MEYaaQ2Lvv+byek1/
X-Gm-Gg: AfdE7cmcTWTNrLIh7uIKZ7XLHpLxkFSpQW1UvuL8PA0/TNylnvmDzRAzfeR1J/LXveA
 k5KTj+JxptehLhX26C3EPq2x9/K31kj/Dz3CMAjoWU/CQemyXECUOg0h1ZhR7f0t3zSnOdduv9u
 raV3EadNLHkn1P/TIvNr8I6H22bZ5Ol57A4ssD6t6/s+gXpioYtuPQ8/tMsfmUoATGbw8J8AXmv
 5GDbcTDvCEE8hTHz3ZjZEZcagwUqHZBVX0SRvj0lZweK7lllG8S5ztE0nodZXVqOQRnFeZOvWcZ
 O1+e88x63HzXIsjIb2C5S0WUIIjT9XdaGFTIOt8GcVjQAWCuek+YWV5iOV38LTg0XBM7PQ7UNu4
 EDUFhPUq9lhtWb78jDpJ22UaE3qXjmC179GzV+eprR7SWbLjiBEvjn8LNno0ydhfmGakNM2zSgg
 yCBzyBc5RmCkBDi103MyyxydGlYpEGxFSbLzsM86dykcQE8FDAlPznzpTQkj4Ooi2o9BB7Yg8S+
 K42RQsa64dgdkQS1M+JICazfju1S51Il4U2lFqK7g==
X-Received: by 2002:a05:620a:4589:b0:92e:59b0:df09 with SMTP id
 af79cd13be357-92ecf5beea0mr276525985a.7.1783524529054; 
 Wed, 08 Jul 2026 08:28:49 -0700 (PDT)
Received: from
 runnervmkkn4f.i3bvc2db5o2uln5sftk5ylwv3b.ex.internal.cloudapp.net
 ([172.183.135.144]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90c92662sm1389613185a.30.2026.07.08.08.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:28:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed,  8 Jul 2026 15:28:47 +0000
Message-ID: <20260708152847.3953-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708143934.118490-2-piotr.kubaj@intel.com>
References: <20260708143934.118490-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rfim: add new test for verifying RFIM sysfs interface
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

Hi Piotr,

On Wed, 08 Jul 2026 16:39:34 +0200, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

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
