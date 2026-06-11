Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D2ACD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6671B3CB3C2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 16:39:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BE053C5E6E
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:39:17 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39ED414004F1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 16:39:17 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30807ba471bso1639668eec.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781188755; x=1781793555; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJtv2th82m70csPYbRuWKynRoOpd3+4yEqQyqxVYfkA=;
 b=ZUpvFW6aM12dU1YlFnX1P1hp6Nn0rqo6UPhEi3jblNJEpXbQkoX4xygc/T0dRKrMi+
 txvY/Fp5wGPYw9yqhhsvTS19HGneg9hGFQy6qlhugh/NFoIXynw3Efk1Qm5bbdRoPhJS
 rGG8lrIKWiAtdzVdxC35R8PPlzkXF7o5di2Ie0X+A7Z7k6WXqnRiZ5kM3F602OalAank
 iK7AMF5OB1NFlNoywEG57U/98jzYsVlYTAhIXHb6F2bB9cIOp3mbWyLJisT4y3hrneuP
 CrqgMH2hAdFSpWxkB7S7gDGAk2+ZCigOBNP3161ylU/4bXhcMWmM4GVZoWRX+tGQ6WDf
 Y9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781188755; x=1781793555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dJtv2th82m70csPYbRuWKynRoOpd3+4yEqQyqxVYfkA=;
 b=itGa0N51nqAcoRVsDnJyQ4w9zkueglhLMb1sZ0LnQcV8T6nuoM3ApQ7E1106nTdLg+
 fib+AjNt6VndE25rNJVuK+WoBxS8BucXtJVZxfdlbJs6sanFvFc5v3cO83ab4BVRUSJA
 OSG7B228/JxlV5/Z/tcsEdReBnVu1wYaEtj/AaB2UhXA5E/i+7wH/GEnK+9lUtoyxybI
 K+slJlwP+/4QoOq85K/F5x3bu+dJNkaJAqvd85qTu6fa8Zjr7RoiwtH2B/HpYG+PWUD0
 frlYhqX+hi7V1FqljaxZq7NMZGpr6oJd5qOsXqLWWUsU7kPgt6P1FSRg9aTjxmNKuiW/
 PDFQ==
X-Gm-Message-State: AOJu0YxofV+8tKZ6Pxtsv8JRuhrtlqnQ4PcYomppok9xuAJK1g3+E+NI
 BRZhFJ4OxBfthmBO8zD5ScAED5RSZc8+1oJdZijmKX8hMcQGLo9I6Jdt
X-Gm-Gg: Acq92OH3GOxpXrwAjs+4ray6SJhiVbp3LLNkc3fSE8CAGXfHQ4LylQ+Nlzs6hHhgXep
 RiLeGtOIUAqJZCh1B6pC5HhpHRtLdUx7D7ZwiZKyJaaOwFX++xq2hkNvjszSar2mpQTegQPUp8p
 xNL3jlguh4mI2Z1fEfza6f0fz2/zc7gVCz9L7qYL1pgJZUDkcUecNllv9ibUV8ZhdC+GNcstj/k
 K3EHz5Wc76K5pYPXlJMRqBalXtXLkwOFW1HCQWqupvTLdjKhgd7vN+YAnoRcO+USvB+H3IAId7q
 bVEvunM3/oHKzWjwTE5fbHkkRu6u/zTf/DU94bOR8UHzjxjIzy4Gtl1KVEycuYaIWc3p8MhS03y
 Hy9WyFYdhHcYrFpoHapojbKmfOgAmI0Nz8Zxua8ntyasCsFbVQNP+nKUoDX/LKnAe+2d5MULkoA
 u3nbv7on3RV7fmqxtU32170OxwsNJTedrwqoAscbSDHh8PXrgA28sDJaG3f17BNnczIuzXBVbOR
 jMx+ZokBQdSQvOtgJpBB3YrahNzQtG8b+NDEH3uO4vfcfBjdQ==
X-Received: by 2002:a05:7301:9c83:b0:304:cd60:b6a6 with SMTP id
 5a478bee46e88-30804d103c0mr2324089eec.30.1781188755421; 
 Thu, 11 Jun 2026 07:39:15 -0700 (PDT)
Received: from
 runnervm1li68.bt11mvw3wg3ehegaaaz51qhype.dx.internal.cloudapp.net
 ([68.220.59.120]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806c2f0acsm2912753eec.1.2026.06.11.07.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:39:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 14:39:13 +0000
Message-ID: <20260611143913.4091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
References: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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

On Thu, 11 Jun 2026 16:03:15 +0200, Andrea Cervesato wrote:
> clone11: skip CLONE_NEWCGROUP on kernels < 4.6

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
