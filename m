Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E24C5AC67
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 15:31:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6433E6F80
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:31:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51EDD3E6F2D
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:31:03 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBBC660013C
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:31:02 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so553151a91.1
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786203061; x=1786807861; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5a8VluP2+pYvBnpfj5GDuMYi+soOXxol8GXwzIDcUFM=;
 b=frmaxi3QS0PxtkLLTNPrzUkA0SN1IcqmisexTpgNSQpDi9fd7qOxMr2RISI7O3M/Bx
 GqZ5aLI1cWVsUv5/R4HfKGdH/ItUpW5WdPLZ9yPn25KAGQjrC8a7Ftxt6uO4MlNpzM4a
 LRsYc/AVFJ1jE1GiIxzMDwPcMbre2Zmve7m7To3pIL/CfeFWNi5PRK53dmYms3pcYn/N
 z09jUD2J86VWf42lqkcEyw+YmEEhg11EXllDOAPxgksK5EjoE1D0bHw5nBXAim3SpeVx
 C0kr4JEcwT8pqkdBWGnPjIYYvlFPmDjCvC16NlyeCe2asMk3ir3TcvNTp4FpdanRClzy
 1cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786203061; x=1786807861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5a8VluP2+pYvBnpfj5GDuMYi+soOXxol8GXwzIDcUFM=;
 b=abOk3XNGgvW+G6rcSPBr6XKnd/6Izb7gySao7pAKtUNtzi1F/GhAJ/mQZ96Slz7im2
 3KBx7WlUFE7jL+/oX08jsJ/6MXE0jE/Tazvt622Oo5srEzNEpG9sWIwY0Y+lHi783sbB
 cAKwXPCtUEpKJAKNdjQ4lORwDqvsO61OoyYMtlaEyIF6v6poCI5NerN/lSGejLJCyMUH
 3gpdRAJX8PYj35sVQFl4SSKGWC8qEWK2reHgcCnff9tkOX2rmvII4xklW2nbIWYr8+5E
 ThnQbC480UgSvLVwf+1Up4zzClq8TMeWIpjSC9BYdKsznCWvXciElwORmXKvuhXehcFb
 TABQ==
X-Gm-Message-State: AOJu0Yx80chKdk/B6SZIYKWY5aasJHoDGwZCyPe8lHS/7hNe/otxbIWm
 gGn4clMAZ3TzGw8kz0DsTKRRYm/vNkTa1e3GsIgX5fWbOSNazUEWQjSj
X-Gm-Gg: AR+sD11OuU/fztC12Ee0NHDbundL2O3NRrTvB0m030YxkkKLuHwkWS5XSf4q5H8b2YU
 HztQasfN4wqnPjeEEHoFhonh59KBorBgwdfEjunKOcDV37bx05MVCRyIPznxZY/YbV5ohDaWxv4
 +Z4XKezJSEJCwqSThd6QYvgVgNL+T+Tu9vD7vlRN1/KQ5tzqbQdmdx6m200W/7RATn9sfuLkOS4
 jxES5r6O5q6sQBTGaEvGwGoUCPuthtp9wSITeOn91RfPzMpfT75QiA7zF25EKnJuPSkWnDAGlHw
 MGtPo13wQvJP+s/hckQUb6OXbuHrU7XzEjcS1cE517LFtMnF/fv5EhgfkBnvMu30cKqMJbXG37l
 sndQq5bwcmQgZHnOivvkXWI5hngYN9ann07h5viSEYp8dZSPOVfJanY+/VSD7FLiITcF83we0Pp
 1tWW1eu4jpesuSsAdR+CxeGz6wAoQNYGcoLkG9IVSohvAVh6He4zsRE3dcePeqeULZme0gIdBG7
 GRfPv6Hc1LLPhhkkiAuyVKfR7nQR40xqKMXG8GLX9Ux+D7DtSJ92e0yFJT362eb0VzspJw4jiea
 E/k=
X-Received: by 2002:a17:90b:38d2:b0:38e:2f21:3bb5 with SMTP id
 98e67ed59e1d1-3926237cd78mr12701927a91.21.1786203061035; 
 Sat, 08 Aug 2026 08:31:01 -0700 (PDT)
Received: from
 runnervmvrwv9.ggcgsnmn1rhu1i1wx0rcebqqvc.dx.internal.cloudapp.net
 ([172.184.214.224]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a754dsm19154199eec.11.2026.08.08.08.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:31:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sat,  8 Aug 2026 15:30:58 +0000
Message-ID: <20260808153058.4043-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808150238.1526150-1-pavrampu@linux.ibm.com>
References: <20260808150238.1526150-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap41: Migrate ptrace-write-hugepage from
 libhugetlbfs
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

Hi Pavithra,

On Sat, 08 Aug 2026, Pavithra wrote:
> hugemmap/hugemmap41: Migrate ptrace-write-hugepage from libhugetlbfs

> +#define CONST	0xdeadbeefL
> [...]
> +	TST_EXP_EQ_LI(TST_RET, CONST);

Could this comparison preserve unsigned-long semantics? On 32-bit targets,
CONST is an unsigned long, while PTRACE_PEEKDATA returns the same bit pattern
as a negative signed long. TST_EXP_EQ_LI() converts them separately to signed
long long, producing -559038737 and 3735928559, so every successful peek is
reported as TFAIL.

> +/hugetlb/hugemmap/hugemmap41

Could this entry be placed in a .gitignore under
testcases/kernel/mem/hugetlb/hugemmap/? New test binaries should be ignored
in their own test directory rather than in a parent .gitignore.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
