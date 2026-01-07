Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC56CFD649
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767800023; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NkHqPM5//EqEHzQVK1iJU3klKPFWDvJcrXzzRedYLro=;
 b=graQhOzz9+bR1pThRKxTmS/Dlqz7VMd9V30Dh7Un2OxHdjmcTBB8mPYvmZCo1KCNnhpB3
 RY5O9/FEJOVYqie5D7ztRsj468XfFUMyPlQ4iKuLJg20PFYSaaR16WHEn7MUfo346PawL+v
 /ae7YlzeLmJEGyNbV9KiZgD32ZQmQ/c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECCFE3C30D8
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:33:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CCE33C2F29
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:33:18 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B313D600356
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:33:17 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso21273395e9.3
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767799997; x=1768404797; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ighZzaF82dt0X7aNsN6jVS0jyuS5ejN1RMtTXjeuCfQ=;
 b=hEbnJQGXKB4LJocGVWinuf1CrS2gzFgnNKel4qkws7h+FWf/v67kLYjARUvn+HqV7V
 vlmL+ES0msZkBseXtmRrnWmnuxREI0xPDVVFz3oqp+hlJOrmaLwrbvN0WpSGqc2vOx0T
 C4aD4KEid9bzpEYNpGDVHbYDNZkAJ7oTx2C84uf3PdeTljLBfXMRSLqgSj9TW1mf7ljy
 aW/Q48uplDCzSKZtOrR+jrU1mN/XQcJoTwvM9hSPwT96GutdKD3vKPTR3x9/Jf6zwH+g
 R8TL3AHwgzl/Uy3vNp5x1OK5QMWIAsuguQ2LW6vyhJTRHXidznNYO3K9RFscaZltuRbj
 tewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767799997; x=1768404797;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ighZzaF82dt0X7aNsN6jVS0jyuS5ejN1RMtTXjeuCfQ=;
 b=xCFb1T5v0Ed+l8fwCEU+KHqpJIxEsE05zH76Ia0ZEwL4DSPqXK9ueyk0KxfKMqVj88
 RmDO1KZNeXFRfK4T4WM7Z3yO5w3M7gpYHirbYYYBgLh2bxfr0d9YXeCWcPJt9jeBLvbO
 fmB4cd0gD0h+xvDqIFZkgC7OuVeaZMJvUpp7sKinl+T5agozZKTANNbk5Yo8cfTX2EI8
 dc8mjCC46Y/jR42DAkIzPPZZeRYy3ClOSOVemWb1JRW9bZkO+Pq6lP8ksQAb0fgjMoHL
 UtwAO3icgE9ZuXGWVZnOCgQXcOshkUab7n+B9L4jSAHlcyThl//WiX4Z6k2tETcP40x+
 PVZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiZirWWOkUY7PPAxKZNT87lFsx9wRkLUEimil0xW0f7SHNkGB8bts03CiVbQGmw8bvtkE=@lists.linux.it
X-Gm-Message-State: AOJu0YwHhugS719ahbeyvn3lYaWDEY5xtnFDkFSWzkx3iv/AReWmWUa2
 GBsr31JonnWzfBptkIP3CJlBYKf+1lefxZnVd/oLd0GGDXf19KC+XhjRAMRC5J3kL2G4lRwCt+D
 1+j0xzDs=
X-Gm-Gg: AY/fxX5PIchna5v66u8MPaUByA7+PpzXTx3UVvW23IVr8FiZ7mPyyx7wG2ayJPhmqLW
 jLkuQV1EHU/uCjn9YR3JNquBwWT+MdH2ksbgZuJRZwu5pAftm2Rim1d1EwYVs1GUhLOsl58fSnY
 F3ogq9ZyBL7O5JCPMQ/BlyL/O5ChL+elgPMh8eKKaocf7LD8x/ntJ0NZpF/6EuFs6XmxvMj3iP5
 8Orx8CKbv8N8ugNgB6dwE0e/bBjZ3czqct+K1ickhXe6Aq7aJAzy7GcQd/EdsbdKCQr2F8fzWSM
 PFSJojJ/XuXJ0eLKYfJVFuRt6f2v0/AsuN67PB0qiILQ9MSyO4B6GmQfs8VvAWM9KH9fPQYHibk
 KG4NdqjO0p8GlKxVU307s9IhXhyq2H6d/CYM5VPPK2MECEa0lL+KgzJAbWS98LcH5G3NUPcoVOP
 ltpRw28mJBKoL+xNJjwxZHIgU=
X-Google-Smtp-Source: AGHT+IHpx9npw3eEBthtBe8QtxbAPejIbfk2msZH7JsIXhyH9hEdPCLqdg67C47s5LlmBsNAZp2r8Q==
X-Received: by 2002:a05:600c:1394:b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-47d84b3467emr37959135e9.21.1767799997119; 
 Wed, 07 Jan 2026 07:33:17 -0800 (PST)
Received: from localhost ([88.128.90.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9afsm11894146f8f.24.2026.01.07.07.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 07:33:16 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 16:33:16 +0100
Message-Id: <DFIGSQWM5446.2ZFYG5FG4P9NT@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260107150714.783460-1-pvorel@suse.cz>
In-Reply-To: <20260107150714.783460-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Update linuxdoc to 20240924
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for upgrading. Feel free to merge.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
