Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099CCCDE000
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782392024; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tTL6rCiUPUy3jvvlFPEMFQG0fPMmG9nbzy1zj/8WD70=;
 b=jxxTc4stu4yDknXRgejpfY0YS3x21ZiedONRfoAj5fo76hZ+CbwUp7BP9gtCIlhHyCVwm
 sJ+V6bqIGzs+5MEnoz1u71UWYMGSI/RbRG6Z5tSggnJ05t9uCStagBVTe2g1livnvxdelQ7
 V2SuI5LxMYkDETck0KFL/y3LEDuD8o0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 985CE3E4D8D
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 14:53:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F993C7154
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:53:24 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35013100048A
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 14:53:24 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-462342ac290so2673906f8f.2
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782392003; x=1782996803; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=prKpc8igA/sd2oglneBjZx4O2ygFPXnW4fRrVJ1hPRs=;
 b=JmGy4PmYWmL8bC63z3/CxNp9TM9eBoqxc9h8dJaQ0Baz3PVT6jr0zS0vqWyeFEf7G+
 m99eyiYTU1k4m7babr1T8nni0sfm1DEGa6D5KWhiowHj8oj2iQ8LiQTf1WFLIMsBT2Qn
 JSn6IQ2o0/iLVo3L1rp7xKqBdd1rswb5lv9ulgaBMFfTd6pSaDbcdKOLjeQe8bAistDh
 M1uFv3lkl784pR3ysEpjjf1cyLH7hUZIECOswyphcDRUSgbB63PdRQVvpAFgshjNTd5O
 ZdtrzkzPMcSF+7Dhs1bECegOudHGNhhzUiSirF0WR0T1VBTLOcJiEdtRHEFS+sIWCej/
 WeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392003; x=1782996803;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prKpc8igA/sd2oglneBjZx4O2ygFPXnW4fRrVJ1hPRs=;
 b=nmMVUWt97IurfOgP95bi+B/BAXvrqDvM1QW3sG1fytYAHaIk4LjxWK1owa0G5Jt7zm
 zOWP8KxkOaINdO550gTdEcjfcfKDi2inbTlyeFPhStX3sAWjVgJLRXGMIjt4wB2l7NXH
 4k9/ULfpf5scE/wMsGNzi31tpIBlABnY/jz8BZiRqNFwjCKTWMP7586Yp2vwnWS7tQ8N
 QbzFLJlLeRdy8fN6NJUnbnrkszt0GsgCHnLctUjnSmwgifuBwOIwb8F16jHd3K5i2mRn
 ORZuoCVdJc5KL4bYduOrIgwNaO65aImlP0ivkVg3AXxhkljF3GLpVftdDNdCuWdy8NiK
 /I4Q==
X-Gm-Message-State: AOJu0Yyy8POBSI/nH9ciAasa10q0BKzMCjHSDxFZbBufaViPVLFKbACe
 NSnbohESKewuV45PyrIFXKcrLJBfd07zAAI3XyX7i1DQv3Q1zWc/dNRXDmv/TLRgwybgqiVwF+X
 HBfztJWnzzw==
X-Gm-Gg: AfdE7cl1WjywBAsU5xwuMU7mXFej0tAtubjNXT0k12HBvWv8LQrW/E85qw6cOmSxXx2
 DlCFMOgC//7Iwk2yPRWzIsS5xhnKtdY8R5+nuqrLrvmpcDGGTGGdZrEQexe4wYELRM1l9AOYJDX
 EKBGp6DgDAk43yVjYW+rrgvYeAoV+xMJFd/5tvBi4IjyivF9/LKtylwO0rkDbwNWTDD6A4LKUbv
 NXwLl4EQr9I03XaJkd8oKNfbvvFdwJ58T1lVIan41NWLwHcsK6/HwhSkbrdVs7SqvpLTQ/dG77p
 0NNJcSFzZXXAQIYEvp7sFy+81tvpiSdmrp4+hxlFfC+YhK9sDBKI2KlwmCU9m8o0Dtu9a2/4wZP
 T2BPumLI9uvCqAh4tuOcAGgPfqX8sj8VwifrYxvBvMpta9QUkTbA7H17HbDjPEWUY/zK/o5KYEC
 1SJQFJvaYbgfpAfVdYh0nWr7y5hH9BmCY0xxsq96rTTqp1LI3UnghAaYaSzI/62Q==
X-Received: by 2002:a5d:6f1d:0:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-46dc1f79535mr3911891f8f.30.1782392003600; 
 Thu, 25 Jun 2026 05:53:23 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b734sm15809503f8f.30.2026.06.25.05.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 05:53:23 -0700 (PDT)
Message-ID: <6a3d24c3.d5b2c389.1eb8a2.4996@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-13-chrubis@suse.cz>
Date: Thu, 25 Jun 2026 12:53:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 12/13] mem: vma03: Rewrite to the new test library
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

Hi!

> +	if (TST_ABI != 32 || tst_kernel_bits() != 32)
> +		tst_brk(TCONF, "test is designed for 32-bit systems only");

I would use tst_test->needs_abi_bits, since there's no need to do this
check at the beginning of setup().

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
