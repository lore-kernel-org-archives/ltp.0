Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DF2C5DF88
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 06:55:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE323C4B6D
	for <ltp@archiver.kernel.org>; Fri, 21 Aug 2026 08:55:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E23743C2220
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:54:59 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 604EA140018B
 for <ltp@lists.linux.it>; Fri, 21 Aug 2026 08:54:58 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cabfb70501so1702455ad.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787295296; x=1787900096; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbh4URYBvi6fNwO2p4PD/4/6b84Ybwpp0wgUuzXeHnM=;
 b=OH8dpqgYgtoefBKw3813BQ9kVCEVuvMFWsHIIBsOPpz2D7mREmr5fawspiwgN4bMJq
 SG6f47x0lzbEsp7pT4wKcqLau6umSpD8S7iFYZFnXdPl+zdLH/h4QMvPjrYmZvv4Livc
 R4pkif+InDz2jxi1iS+/uywURHLefg9a+ZEL2ijd6+RwVdohHPBlCj3sqrUXfA5jAI30
 FUjjMBx5ICT6F2quFNjP2eh0iSOoupNrgXK9OJRbJh8ZMZuojlhxqYBM9SH5SvCW3OYV
 Zit//5O72lAdq82qD+SFLHFHh2Xw6mWrCoAZic+X+8Uw75mCSQVuSrNoRIcSTFxeYyoQ
 Vf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787295296; x=1787900096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbh4URYBvi6fNwO2p4PD/4/6b84Ybwpp0wgUuzXeHnM=;
 b=dQhIdlPfJKecOM+6aKugGg7xKqTfJge1Ne6vca/9YaWGHqEwxIMweTlk6dHEHCwRxP
 lMen7YErBNugbADmB+u4JoZbxVp+OTxI2t7w+oF6XJZZ57f1HGK6Ppy6fItTzipTHIC6
 XZN9SK6Phom5MHvSoq3Fk/GvqJOv9xvmjyIGmUESrTASQEIoZbn0WXwtLPPKrFBeWpGY
 W0TcCt0TKz13rnPoKY+fSpLAbIoF8+iB36/v7HmnB79EXQBVR5vcwPQ9Qv4iRXpw6Sdh
 XKHSvzsQOP+GKbxXL4tQQcB40sQO4bJnoSp1LvYFKsn3KZTtOB0t+zw9zZISenF5gZU1
 s9ZQ==
X-Gm-Message-State: AOJu0YzGp5THWCvC3R7AtbRS8uodHQFLC5VdxxrolE05Jb1BBklGSRIJ
 DOg32oLLsbdl93p6QEmJFQcrc8S85vj4sl090OEdoAUskn6zfllYcCMF
X-Gm-Gg: AR+sD10L2LmOeUT5jww813g69G39T+ukoZ5bCbc1NngVdNLhk+syffkRLfIVMrUrRwE
 bkbuVsYGp4pXc9iAYfYHGQ5HfmR87iKIE70jmc6w4H1SIKkruMRniY7y2KZemEFtrVbJed5ZtdK
 DT+xFmBtjCmK8JEpByWQNEqWGymVPxoxG/eKhUrxx9NLF0m0qfhGMZc22/E8LZBfGDWu0ItKK2y
 8UKIZhBDjTDoSl3x8o7l14ymXCbE+v9Z5sZiqBN2ifhFlLez+vQdGkO/qeBNhQrddXezMkZCvQG
 c9X6rg0zJKNH1ONM0kv8FcKiA7OtZjq+JhuWD0Lwc4fG+gEBTiaBKP4VhqCmiHT/xDKYDB30Wrw
 IiZJpT9ZvfmFi8S0sMtnVoB8vKkFnywtepD18jYDha3tjEfO0Fy3eb5SY3WZsZnampFXl6PDBOf
 gKp+Dl9xuanlVKELbA8aX/2itHci6BE2xHobSZlgY76ECaiwKiic4o1indTjGIJGG8TriuDynWM
 v7gpsnSBfR1pBnwbZaFJZsAaNH6ceETJCB7k5C+ZvCMHNDPOU5AM581lAFyzQPkbjpg6dl/sQ==
X-Received: by 2002:a05:6a20:2450:b0:3cc:a18c:b6d1 with SMTP id
 adf61e73a8af0-3cd3013c9f8mr7750486637.17.1787295296475; 
 Thu, 20 Aug 2026 23:54:56 -0700 (PDT)
Received: from
 runnervm76f27.mmyymna3gsrefchfnzjluokthe.dx.internal.cloudapp.net
 ([68.220.63.0]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf13f4bdsm24566508eec.20.2026.08.20.23.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 23:54:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Fri, 21 Aug 2026 06:54:54 +0000
Message-ID: <20260821065454.8805-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821055341.2079284-1-cyyang772@andestech.com>
References: <20260821055341.2079284-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] starvation: honor -t instead of calibrating
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

Hi Victor,

On Fri, Aug 21, 2026, Victor Cheng-Yen Yang wrote:
> starvation: honor -t instead of calibrating

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
