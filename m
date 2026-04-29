Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6D0FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777473361; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fbgcwT0ejsn+jafZDwceiXxRDgE21CyTPHZe/5UDAjo=;
 b=qxZbIBL5w3AIH0EV0gFnyjaDpHgxjfkDSxgeUwgq/I10aJHSfnRc4YzuiaxtTYanUBeoe
 cVT9nq3mdmVfryGsSR3KeTj3uqXLDKbF59Idm6gVoq+51hILUFrF9bQGNktbL/zd9HgUiW/
 1sidnJGeR9z/AmZtRHpEt+qumHYlK80=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBB8D3E2D49
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:36:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 214523E210C
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:35:38 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C23A01000A22
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:35:37 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483487335c2so125017625e9.2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777473337; x=1778078137; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oORVkby8atM599Tn+VVr7exg3h8ruHemku7I+Eqrc9s=;
 b=eNxzTUGqLFtW0alR7seOVQgaTsMJmgzWK0fbtwxq2ISkJxdC3+bR2y8bhmDZboSwxb
 UVQ29mSFUNfy0fp+xMleZ0b24ICmVskvr+T5zF0oJXugshQd9XqklV2Yl7U0HFgjIsea
 M/wqSxvqMj5/R6hVD61BFfvZh4aZ5Uvz6vIwKaZuEAH4NUwokpobVPjPuJu+LjlEjNEl
 Z8U2JpnfiGNvlrBbRAUIMXLsN1d3dTbeXIJfIdL1oZtsqkWhVB8qRXAOzInB2bDBPX+5
 qV6jYRT41XCISlF05GaRut+mc2lQp0hN/9WyYkWgsK64YgQZ5kiLN1Cw9aGqb2YHYfH6
 kRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473337; x=1778078137;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oORVkby8atM599Tn+VVr7exg3h8ruHemku7I+Eqrc9s=;
 b=hZNIqCFro8+hlUWUeQBN+a5oRQp6GtAn1149d6Exqkwq1VOvPqHbMiYXWniai7SaIF
 atwZwcGFm5SWN1MoYfIAnCAk6Oo5wPIVwxurFoH2i+/m7o16yZFD2dEcdCGlRM3djm8W
 EhwUJgXPS5ieVXsPNDMl/bTkVH19fkZuMG+7UeSZGie+PNb4Spj8CFdYdT+wOCkH5nte
 OP7soYm0ty2xKcLVHUbG6AI0DUt+QruWuVbCREaus7V5ex10pJhR1x2pnly6YUKcE7dq
 pA4QbaOXzJs7C02w8ijGY676sWvkhDB7XyDF2LryPU9PGQWL8bPtbfPT+xL2hFQk8pBq
 2qbg==
X-Gm-Message-State: AOJu0YwGyi0ugKLihXKu4b+PHCv3ooABKcTLtpLcqVi9nb9QoZ93BJPw
 p0/ldFBGSRXU2pHngCBPOKC+fAzNrDe/G9R9L3muaOdhdF+oM8Snjb9jau5l/FVtMj7vJCFFCLJ
 nLyJ86jUAnA==
X-Gm-Gg: AeBDievAPVSjs0GhlshHwAOQE8nxMYcu1BNChc1l2NBNExLLGLuyt9rePtoBSUMqV7M
 2nOycHEQl46NWBZO0A0yPKGIoJONOn/4WIKeGbXLb2Z08Jf33XFw/AG0R2t9SglGpEcLQLwctyt
 qXnUrvC7R4KgdEaCjKWu5fN2RYwnY7XRU0Pe+NnLq24cg8OGAuLOfJSwOcn/ovltv8HooEm7Dz6
 J6ccafxLEMVe/IkAlntdtamP4DEiTQoOd1Ks7TMZLqMJc3o6yz++jFjzi9XBftYiz7LEFVu0yJM
 sDfz/YLbNdjqLLi4E8ROvhQqWSfSYcjeNswrMTT1HzMKbdL1xa/iORPeUx4wuCXJ9vvlGf4ICyI
 n39seGx4vcB1Fh6eKmbDtzjAg0zo6isDUYsJkUYuV749Neej4hFOJjaS9xY/raxbHyE7qoCbcuL
 YjeMOQb6W+nPXkXhkAmjpKwSBE6iI3w+Fk50QezkuDMpMJ+mQDEw==
X-Received: by 2002:a05:600c:a405:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48a77ae0456mr100868145e9.5.1777473336918; 
 Wed, 29 Apr 2026 07:35:36 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c2fb999sm29532265e9.6.2026.04.29.07.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:35:36 -0700 (PDT)
Message-ID: <69f21738.050a0220.2bd76b.a4dd@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260411094742.219667-2-rbranco@suse.de>
Date: Wed, 29 Apr 2026 14:35:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

for some reasons we didn't receive the email from the review
agent, probably because agent was still work-in-progress when
we received your email. Please take a look at:

https://github.com/linux-test-project/ltp-agent/actions/runs/24280634858/job/70901877922

it spotted a couple of issues.

regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
