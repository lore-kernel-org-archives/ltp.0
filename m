Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6832CFF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777460344; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=q9dFuKnVTXwQBTdgH4aZitCTMTI0tZ9OeArcJzHqPkDA486hSDyr/EKr9346PtJXdEcQ7
 /1BP5Qkkr0glYNG0jUUJH/acu8socsTNm0QRBWtm9Ega+maXbMSQpp4ziIspLU6KkddmK8B
 pXFHKR+FrtEN/1IPBEpldIxJoyaoDcA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25F513E49C6
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:59:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E4A73C634F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:58:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E3A802009F3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:58:40 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso113861985e9.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777460320; x=1778065120; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RKsqJKfs2AZhMK5u7oB4jgw5BETdSHIgtau189YpOh5qyk8MlyF3k6gzCWiCaE8sFg
 XZYKdzi1N5gdVFsKDDIpGiC8yCUHclv6tysAWIGx2iP4KRzOlnLkN4Lu4MD9+F9bGar0
 kNbFcMFBw+ssO6ko99eaQnnAmXG0inGyFjltaJKztt3muc9S8LBATt8ZnEhmvM2XimTZ
 DwT4VjpY1q21CU5QQYrA162xH0WPNslsmX75nohyao7dNNWMP83mJc6g4RmXTcR35hLz
 l9gzp/qnIXHmFjpDlk1OVmhMgdRlozeHMY+yE1671lCujl/Q5r/0pvhHjx/MfJQjYnqU
 HCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777460320; x=1778065120;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TM9j36s0oarzqAn6as6M88Y2kIQarizQ4KU/y1iiYNmJldpfT+xBf3uqw4+jIRA2Y9
 2T8EmDIyNawfqiRn8TnxLuVyjulIjpeBYqRLutu+qOBg6ywYxoCQndSclTMBb8bPOOsf
 8HLqMIFoa1TfZAPlXiVOFNkmEAKuY8QynRI0fDtshcQLWU13vjS1VDKqJjCTrQpzFBY/
 zloAnVWLPpcbzcRJEguAH+EH3yE4vyamPyyWHTV1K2Qu+OfXUFeNLIOJ772n4RueGnY2
 O10P/obQC6Lo40Vf5jsL1ruYRTfSuKQGGOpYF47gfV1RSMkXTcwIJ2SoAzDUdzfIAFcd
 ujQg==
X-Gm-Message-State: AOJu0YwAmFdT8OL/l86aY4k+c3otCHAGYZFeQ/x+iRP01pm2JGiau/fE
 mg21Fp7DfNNxnWChz4oZiDzmBJ9PpeSENIVm7CGVhml2q4ZcrKW/ukTmi/axXZqae1k=
X-Gm-Gg: AeBDieunCI8S4mG2n6JrCl/hl0g5uO3lGDT62mohdBubJbLyxwCaxgvhrzUaMlZ/7DX
 19+OYHuACHnyXFDsXNL9Qc2oHjCgVVG/7xsK3txQjnZiUPo9SaMlFil7CQfFl4qsO+cmOhcaAot
 QXDcnKNfrQ1T2uog/sKdLYVon91qd4fMwz2Ck3gW4Bbypd/HIFpehXT155Ji0+/O3hcxC26oIuR
 7fLnGr13T9ZuZK4rpx0U/ILlnR73Xb2HOlsS29QXXO8YZFLMyz+hGZD28ZoGoHAKWP5Yjwn47Qt
 2vGuzu1jugf2IVNHyy5UMuyLjxygn3NvxNtFQKOH3ythAK5T+/bIRhUt66YMZwL7zcSMFYY6e0i
 wuX1TSxheoXuaNJLk7JATYvOPGVdecgEBhUIUutmzw1Lsc0k0vGBvXH3G77yMJxOsSWbKa19Nrg
 bMoczEEL2xVGr2iRPgvObCQIhGPKtxs2UENk0WBOHK1Aq2a6WdxA==
X-Received: by 2002:a05:600c:8b2f:b0:48a:58ae:9933 with SMTP id
 5b1f17b1804b1-48a77b1990dmr109236835e9.18.1777460320217; 
 Wed, 29 Apr 2026 03:58:40 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c5c740fsm41522875e9.12.2026.04.29.03.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 03:58:39 -0700 (PDT)
Message-ID: <69f1e45f.050a0220.8824.263d@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260429105644.986278-1-pvorel@suse.cz>
Date: Wed, 29 Apr 2026 10:58:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
