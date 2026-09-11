Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBF9C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789110998; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7LtPVzSQHcICpNl4jj1nduJSYHi8qSya+FsCbzAPg8g=;
 b=WpPAjn/YZHl337iga8yYztV6/2qyBH8KG8Wk1UTcmYt+18amZRhQ79Nnx0mZq6TdBGSok
 Xjdcor7GTtXNevBrOscp6+In4q5ERbyM6x91ms9Ro9E3sdOnSu3E3rtZ86IYdfAg+4JWCGr
 rWU7R4p6vwt17u4HqKplsi66IXodYrc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B14A33E6063
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:16:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D80D3C876A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:16:16 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5502F600716
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:16:16 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cc9f581c4so1813025e9.0
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789110976; x=1789715776; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Aq8rJpT2eFiil5w4R+EKikjOOFE4FBMw+iuGSci5/+M=;
 b=KSmWKKQsmuIzV0fdGcspkNcDyHjsWcMLLPEPK2I7nZ2jKu0WlMIe1CrVdZZxy0qwyU
 Cx5Bm0M4fwfpiO85a+m4avNhRwSISaerjiQvvMoc10xkV3ZgEfG1h08g/IFXJWxKQ/tn
 QW5eruHoGc9jKguCQ/eT7SIHD027PG2h4G4ScoJsATZvM7jGSeqlLAd6ziqV4i7S5Yk8
 YUN5Fs6vqeJid2tDB6RNH0/j/dsdWPlRPo0DcL6w7H+b3enMFYKiJ7mIUjpjGVqHz1hQ
 6N0biDWy3MS0SwYqCA7jumiwOAydVyS8nE/9/sW8CtXOIMViqhIgov7jcwkKXCOGfpdX
 1Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789110976; x=1789715776;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Aq8rJpT2eFiil5w4R+EKikjOOFE4FBMw+iuGSci5/+M=;
 b=Dp1buV9IDugVSUFib4YA/oCZ0f5I38B5ZXPje29qmPHHvZqV44ZUg1a3xrRe0Zko63
 HLIy892XFB1eO/mbXtJnwdSsAYHhscA3Ec1LcgAat949lbBK6U+RJuLj4HzrSCxbUW97
 OsqxrDqqHPdn+9lz2GCCC8FOpyC6NN150mN1gblE0ebzGK8upb0v7Oi11gEB5NtcLy4f
 o3Ejb7XoKKqN4a5kvaKKYxUehTotQr/1rq8rHjPgHyMvGJNRsmwGq2x2fJyw1iOtIM5o
 2+5glQJtDao7GXOKlsETOsti7KsrGyrlUTjGMCXTNWFJlKZEEqDQbmpQmLYfoZ+hVWio
 3+7g==
X-Gm-Message-State: AFuF++mXKP3BhgZzONhwS6CmUr1PDcC5IQkrtrRcEu3xNe8NNf+R+t44
 RWr+943NjkTBpm7ibr8E+G7JfC7+bjTu+feiYAGyAbqf4b2JqnfiDeacSxIdOferWPU=
X-Gm-Gg: AYBFou1vKip8HAHU+DEnHeQS2TxfxykU6TcKdt5SarpkmlnrL1mW4SfIXbgSwFf9seH
 cupPIA8PgOpMy8UtdF2et/WodexridqH/NSkrXtuBhjTs67uirCGqYyDySFkuhYCbieHSOr3AlJ
 QkTAfH9qUGt4Idvp325e4DiXgy8W6trFBD/c4VXpuyOiR16DC2HeDQ7w171xXKhU9WE2L4jJC15
 ZK8USF9jB95cBXEsb14lqFmzyPuqFP+qlmW3t/dO23q6coPHvC4LnNlr5Xho+TfA5GjEHOwHIHA
 Hm/Fm50z7u5OGh8/S+bsZMFtWVntXsg39RKvQD875vX/LUCZv2/noZO20MFnArGSRJjqIXlRY0b
 St+AnsQAbXYyDmRYJ3QMhRveWVRQbhsyH8CYomIxq9chYG3vB0pj2vI1p9B8vIOyVgSv3LiR1b5
 C3rnHBZA7N5f9EFERz7R39HKAMEk7BUyDCftDNubmVZtLtje9nQ95Gj9BkhwGiudIJGYB+YtV1b
 ACdtbOZ9YimIW3VJbgubQRQPSJfmK3LWVI8znKxDvAtvCKgEQCfkuh7zJGOq4AqacVK+PWQx28w
 kP0OOw==
X-Received: by 2002:a05:600c:4584:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49e60f5afbcmr33911285e9.3.1789110975569; 
 Fri, 11 Sep 2026 00:16:15 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a7a686sm34318995e9.1.2026.09.11.00.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 00:16:15 -0700 (PDT)
Message-ID: <6aa3aabf.e9131222.139c87.9650@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
Date: Fri, 11 Sep 2026 07:16:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

Changed tst_brk(TWARN, ..) with tst_res(TWARN, ..)

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
