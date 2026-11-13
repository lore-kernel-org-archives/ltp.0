Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9971606A8A3
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tv9kAM6F
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC03A3EAAB9
	for <ltp@archiver.kernel.org>; Sat, 14 Nov 2026 00:56:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7363EA08C
 for <ltp@lists.linux.it>; Sat, 14 Nov 2026 00:56:28 +0100 (CET)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E56D1A010D8
 for <ltp@lists.linux.it>; Sat, 14 Nov 2026 00:56:28 +0100 (CET)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7d2dbe5c4b0so430498137.0
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794614187; x=1795218987; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pLfATVpZi5fqtx4aAjZLiaHd+voCf3UZUER0ATI2AZw=;
 b=Tv9kAM6FLvZUzK8ZvyiZOkXkeV08FHe//cBg8DbjeE5o+2mxqRgVwjoWz7rngQxA6T
 PZ0oEfzZ450IGdDf2a5kIi8PW/hrPNf4rBpJVImFEJF3e3NnlUr4SffcdoMIMBlXu4px
 tyY/fpRM3TLPAoxfeZGlQYpFTyExS/ugy3/9ygBVPwaT07BZOVM9KoyhFnRbQVcLRLdm
 02iUYm1AwvdhWln1GACNLC5c5MdYVPO5iLMceTHNjsZLRdJgzMOziAugW+yR2+kKptq4
 01H1jed+R7tmK6VkiX2kEQWEwRoq4IwVW9xDEmY/+Q6oepDERkaHBG9DAARsTqkzJ1yh
 eojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794614187; x=1795218987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pLfATVpZi5fqtx4aAjZLiaHd+voCf3UZUER0ATI2AZw=;
 b=MPqxnF5cJLlpiQQJGm9FELQp/3utYOF3pBUqAd41mV47WqsB9Kpx7qrdizMMLLOiT/
 NfNkBXxF5VT1iJVLwNGoAKXq4KfyahroAcYpA8FrBxeDjW1P9Foz2cxXNrrl2I8im2cU
 9PnWn1pw/CPHtlnIAITEck2E8oxRag9nc+6ZYQ9A1jq1moKhGvZosrlpK99fxjzgXRPo
 2hm4mCH09y/pkbVlkGBk3X2IMa8EbUU0h6XmaCgIXfksSwYCwzKxyEf+A1vuGWOPUy/A
 2UAdo7SiC6yvPd0+HQmSuNznmvV/ij4VflJRfT53p4QiLqmWrFgAh7QHw8EbdivqpoBR
 zyOg==
X-Gm-Message-State: APuU4Z8bOLeoiv25m+gsNxzH+Xw2a0dyi0WZAo/udxlM6fOBmdmOtDA8
 XNny+pTXIUC931i+M+UojcVgXZUotOhX5dozC5Ev/zkzHRjDUnNDSqwK
X-Gm-Gg: AYBFou1pGC/YAX1oE7uldfZrJEb8W3yXO17WjvAs8ApvvCNlAcKFNGDSNW+7hS2zv5g
 sTjSaW8JcmzhwFghYN6tdUtvD3UumyNoZxyndJm59JYMPIPs3A8QchjHiprVxKk0eTHPiFk30cI
 VRkbhx7JgrnQA/8F3BqebVVbS26Gqe5N4aX/xK3q26wGaSDi18iR+3pgH2DQ67yg3bSJc6vrUE/
 3R0fDa1NZlYh/taWv5XhkcYSt4hrWxKQwPmO7PzP+WvZ2igJ9pEcv7SIIHHSRx2tTVabvpjVNFK
 7omHQGsoXT/o/slM1plsaeCMku7e7TJtaU2pncUkKtRigzkSXAgYgyydgNMzuRNWbDYeYrKr9Ax
 52gFor19WgcYz9CPmYGUFXtTexxgTOaQvwFtX+7wMyab3P0Vxx7ApKBoQFRg4hSghit1bwDWPnP
 OgmqbeIOTVa96xLd3E9EdG4ZuJURTInu4/v+xwQ2qkK0wDbPNF8fcB810egDef/0TtFkNN8smQq
 7oFzIiD7WLZJeWR7k/acseadLnHXUuz2XgJPxwJuglsUIrzhZel4pD43VMukyAcytsfuWb45cFp
 igvtgacsxTOj4LM+RBW8YFD6Dt8cow9mB3ax0eE6zPy/DuWyVw6jgPoJtpe91ZxktDmZDcsUeZw
 JKUjc7CXeLWj4ElCP+NTSJ2IUOUM3FonGSoWjoPEon8XxO8tXIx4fEOIeVg==
X-Received: by 2002:a05:6102:c01:b0:7c3:3890:6076 with SMTP id
 ada2fe7eead31-7d64d70315bmr1395321137.6.1794614187049; 
 Fri, 13 Nov 2026 15:56:27 -0800 (PST)
Received: from
 runnervmccnms.vtwfcobqnrpehcguhibagk3mca.vx.internal.cloudapp.net
 ([4.229.37.3]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99c8428c7fcsm2340688241.9.2026.11.13.15.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 15:56:26 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri, 13 Nov 2026 23:56:25 +0000
Message-ID: <20261113235625.3848-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113225411.3757447-1-wakel@google.com>
References: <20261113225411.3757447-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sys_leds01: Fix max_brightness range check on 32-bit
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

Hi Wake,

On Fri Nov 13 22:54:11 2026 +0000, Wake Liu wrote:
> sys_leds01: Fix max_brightness range check on 32-bit

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
