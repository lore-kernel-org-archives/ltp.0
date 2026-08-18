Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F88C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787045727; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=fRYqRfKA1v3L9TBuRoaTMFZOdlf4eAvOk+nIShbC8wvmrDUpg1HG9IUqWvIS3ju+fuj5x
 NpmF5U8IxJ7U0Y73SZOR/Crh2S4IiaQ62hcsq4PpG3p27LqzQI3VSjjHz99QBNsqfDptBL6
 SHtqIKyzoqKaYgqIXZKC8xRcTtoE2ok=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EB8C3CC0A7
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 11:35:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A78D3C0224
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0F6B2002AD
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:06 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so35822985e9.2
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787045706; x=1787650506; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=OwNGzbsMLB1g7DbEsGWCk09ewRWs0as6f6eEHRRg5NDMdK2GKhqdW7Qizz1JG0UXIA
 Baxp0hKFIkpLNmzENhqvNFe6i4X+NqFack5TiYlxdf5hbf7WDsqXj5+LIZRvPy6TWJB0
 NTc3Lb4lwqofRT3p953isY4MaLdbevHh/kYpbNdEqgHHv4TD1JfxCI0THTcs2RYO9YmV
 5oLXP3/WgNycJmiDT8/xJS0A1F6OP3UVchQ2BMjDL3q1nsANjOBARyOeF+gODKCrW1NS
 +HkFzFEwJ3UFa8AWU0M0gvc8eJcpaAJFfaSk3/k8/fHlg/8t2t83sLFG1taHopfQu1R6
 znjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045706; x=1787650506;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fp7kc8Q0RRSR5xjjYxJIqDtu5A8Oan/nsQCMEuF9DpdQG67eDoY+h05f5XsNhwNyUr
 MKgDXJyn9e/GGi+Y04NSEUAoBQ+rsOJibDyXhZJAHGg1LEzrFQ5eiGaKT2JYOsE1iADv
 yBjWVEMn7kM/f8MX++SIiSgp8GDMZAgoS9/UZOdNTNPlF9oulooCakp6MFWWgQqC5pMr
 blBAoOOMHTBhRytTRMJ9cfLxWzEtuOoA1mDn8AMPzJgy4r/WE1Tqe0L6ncQVwmoy2i5P
 ETCq94NuvsQPUB05j2SZT2vQlrHSSBAtEU/17ru2gCmRxvyDRoF2Mvzi2lYzMJvUSV0M
 OnKQ==
X-Gm-Message-State: AOJu0YxZ1ew4NtSCVA2L3HPEJdeSaIRw5A0PAIBLLhy2Hwo8WQnGw4KZ
 R6buGmqu2B+0x+cJTQb1O/kjlaYBu+3dya3cDhl35JMby4xmwMMDOWVc1k+JpJVcoxo=
X-Gm-Gg: AR+sD10KGlGBnDBAwjxwSy7c5tR5PfjkV99NpKlaQgJrZhWigjRU2TkiSo09Lic9PUC
 AUWUsZeGnYiD0qVLgRF97kWGvZsNKj0vt9X5Qb7xcT9AYqqjnw+gTqN8q4NaUcfjV6CbjWuueK6
 +InHS6Mo5uPt4VA/OYnnoLwA5aIcJg0MgbOmlb4QZ7YgdcpoW2vFvw4pmmCbW/r3FGPyx+YBF/P
 R/vOkIrTXbu9AkDnxzSYOfeO8Z0iHAT6DfY89naNRRYfwbDj4HD29b6wO2AkbO7lxn8ahjEM26B
 7i609/OG/ZXyF/MhpWqeBXo/d1difZPj/8NwW4mrBDEknTi58kOoq3IwFc3EQEJqEkeyw2RcHmB
 jTZ5tlx/WvsY1oYRu0xJ0J+wXAvtla9t27YwbMtQGqrHJdYFvfDp6ok0qbF/n5QOSuXD2Rrx1v8
 LFo44N3VAFKIrpKQddw7fowwXRPhgtS8xZIX0o5Udbe86BwOLZHQhwEKZrUSlIkR/JAoNfFM8=
X-Received: by 2002:a05:600c:1908:b0:499:841c:2016 with SMTP id
 5b1f17b1804b1-4999fa6a973mr88572615e9.0.1787045706115; 
 Tue, 18 Aug 2026 02:35:06 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10999932f8f.9.2026.08.18.02.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 02:35:05 -0700 (PDT)
Message-ID: <6a842749.53cb9477.b26da.6409@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260814124943.36853-4-mdoucha@suse.cz>
Date: Tue, 18 Aug 2026 09:35:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] file_attr02: Simplify device mounting
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
