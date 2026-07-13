Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5D2C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 18:49:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CDF33E2C46
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 20:49:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD8333E2C46
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 20:48:45 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19AC160020A
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 20:48:45 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso81809a91.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783968523; x=1784573323; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YYz++BXtdiTyhzWqu3prjv946Y1ML3fzn5eyxv2clFo=;
 b=BDudcbA8VVACFqr5l/h22Hbh6rpc5WaeO33z938Tq++Ej/Q504PDisimfb3+zL08nM
 L/8gpe/WB3ljZUjkKc0xWRVlNF72sc7ymH+0s5p3qHhBEYGBuy/CwigI+BJmwK5BVDTE
 zk9IHZ8gQtbypJ1QJQRRQErrLGa4OQoUceYpk0So/1diDThlZX5I3QQjqb3rKjx3zLnZ
 noMisnXo/uXjoUqUz8mbt6OxSVBwS2b/ibKryreINpxivpK/k4/+AJTvY1axET1n1f4h
 qe0cjpipYS8gKZeNsJi86ssZna8W1nPya62+9VVn+syBombzjr88cHao7XImsXZnBfZW
 g0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783968523; x=1784573323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YYz++BXtdiTyhzWqu3prjv946Y1ML3fzn5eyxv2clFo=;
 b=Ip3DXkM8iLj8rFN5/PcLLIDB+TGCh8ijW05fv4OsVODxQehHxD2vq9uV8ZnHoH0Rtf
 5Sh7ZdDraz3SguPAuYoZRqIsqMVjpKAJelKnqZHxzS7gZkms49Ik3j3eyBhS6EF6RF2J
 7LIP25RJc71IOiuT/DEGuq9Rv6w05fT+dW/sQ0ymIUApP4tNvTFlkiB9Fn5HVl4Exk21
 +1j59fbCw4iccto3hxUnYWw3F/D6LATeCzWwzEXSsF7Ft5a/nttilaIQmpbAXe3KWImb
 MxGHW7GjJC64wo12bngyzZhMCsU7EgJ7y4LaOZlB1IL1yQk/Z+ZPRAw1eDBr8DktaYQF
 a8NQ==
X-Gm-Message-State: AOJu0YzXAdXHZ1W8/aYnaAVPl7hxSLSJXUBEBGrbhzNHmF5Q3ZxS3qa7
 lCkCa7kcrjUvjHfGg+qCWWj9p5PzizOqnHiN3cLUT8sjJf4ATy3ifaK1
X-Gm-Gg: AfdE7cnksNjxSf2QdMbuGWZIq5U/BahHxyPk+kQSYVfETXjx8FfFsx122iNs1yk3r+F
 n1+ADHSbYTxbfA/VPnpEk+h1AB6WcexmaGtf+cHRjEa5xaf3fjculsIKUAWnKnzPeZ7WsfTY1uZ
 N3VKZzXQfd6uhdlSd4WbDuWZSiBV0UEHL0i1hYj9tblWJtRafGAtiTi0jBF2qiQeujt6yvLxlf2
 Jg/gPHqN0kCUi0Mosjmr+TNAkHUQSNXlg9zaEbQSUYikK/YBaoqTf52nmlI+9zpl0lW3zzdK1Kz
 03aDCmFFqpR8gVRtGzrszEKG1soX5YPNlc+t3IdKOpx7RWWQ6IKLsEEtuXMjMIkBeCXjEsIX0G7
 LrD+3OdxN4w31VIXQ8wYypYZTUa8UhJKtj8/titW5SBl24VJRgFY/HHSgivOZX9+ht3nBu081D0
 KLf74DCiYdw8/0o0wwk9E5WmwrIU6VXeqVZAibhNLmj7U/SVSaqRwaszKpdw02roaAZ3JnZwQ1j
 8LjjRd3xSE+lDGVs/10lk5cRu75BInXte6fO0Z+
X-Received: by 2002:a17:90b:5545:b0:36b:944b:fd81 with SMTP id
 98e67ed59e1d1-38dc74d0274mr9828284a91.4.1783968523298; 
 Mon, 13 Jul 2026 11:48:43 -0700 (PDT)
Received: from
 runnervm5mmn9.at0emeruyl3enbehgqhfxq0whg.phxx.internal.cloudapp.net
 ([57.154.5.245]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117462f5c7sm78739720eec.0.2026.07.13.11.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:48:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Mon, 13 Jul 2026 18:48:42 +0000
Message-ID: <20260713184842.3796-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713170129.1177772-1-sbertram@redhat.com>
References: <20260713170129.1177772-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pipe13: Scale child reap window with LTP_TIMEOUT_MUL
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

Hi Stephen,

On Mon, Jul 13 2026 13:01:28 -0400, Stephen Bertram wrote:
> pipe13: Scale child reap window with LTP_TIMEOUT_MUL

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
