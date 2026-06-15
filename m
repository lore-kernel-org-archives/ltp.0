Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59673CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 09:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781514268; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=x71quhaQvUhmb4geaiY5mfScq9nnft4ce5gEORGX2jg=;
 b=DQoGnSHuii3wL0+sQtBZoCaG+AGzi2BjrpZpfX2LLG3amfdbPwp0PdHYOzfK3cBAmzdB9
 JLoNBSgEWT2wX4si3ZewWK8+c8LJKWTkW/2469xwoPvVhNyMghy0QlSbPQF/PrJ12EN+SKd
 8wfFlCXz+dfg6uQ5mJ6IOMar4mOpebc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5A783E5B4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:04:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E6F93E2B0B
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:04:08 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46A321400332
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:04:08 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso1549647f8f.2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781514248; x=1782119048; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zGqZdlOyRx+G2hzlxFRlOnyTyQKyIi9PH2orOlZhIRk=;
 b=AhrGN5p00vDnReDY0EBrFtFoFf5+cetsXmR9ItXYFFbcqRE7yJwbfThXvMOD5JpnnS
 0eerfBGiVtv7oRJfxhbyvSCrZE6LozyjK8WrkozIHHwURRQ0I03njc4Q8lmaz5rfDhpW
 jJCxsdTsfFAVxy7LEItkkcJiAXrqFkXhzlf3CaL6S1uhqYDbEutTNDNHJALlEmCQ6JeE
 xXLfu/JnKSZuEWeQ7J3yKz4oQ8fmyna3CcGB37WyJI5TMkZRLqNCc5e4eLL12Pj/mYkb
 acdsYYm3AwZf0dphaOT0l40G65w4RZgZc7WyomuZLsfI2NX0gtAeP2mYmbztZMOj+jMV
 ue+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514248; x=1782119048;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGqZdlOyRx+G2hzlxFRlOnyTyQKyIi9PH2orOlZhIRk=;
 b=H6PN7oSQWabJn5zaeYlhhF9il8M4WYtpC8LT3JWsg6xpXH7xiBsyServZGVgHVq2Y2
 rMNLEB/RNH2X3tcxLRB1BZWc18pohOsrgCOWYRXG+2psV9OLSwuAD0+IW4Rr7kxNp1lf
 qIB/4B/EJVfWwibATzN6B5x+DEfVFJdA1JKGTuVb3sgcC3TeB+MIUwTLnhP96QCfgVh/
 NLt0Rffj8PJMXD4h42cP9rREAS6NRXobL0pKCtR62x3Fkt1BHzntVIYNq2f6FlgT7MPj
 dqxLnIRckukORI08kLXZvAVn/obPklHMxdzbV8RRw2qN95wmpVfEGNaSJ9Gi2d/T7h6/
 Vn1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ98zCV0FK5zyLmdLZ0evJa1OFY3ueI4/9VbVokjIcEH1zYTWAuvKXP4GAeuHF7BDpZDg2w=@lists.linux.it
X-Gm-Message-State: AOJu0YxJ6eg8Kx8fOwL2dh3jWoQ7JFQrAPcs2iGiZ/KJsalc9WKq8WvU
 Gl3akmtLizIMn8+HOl40uayBFDTkT7rcNuBjCSVgBSY36HRi1piGfSlZTFrcBtNE0TcJ09O42Yt
 np3YGUtjKfw==
X-Gm-Gg: Acq92OHMZe0zuVBPnO2OThACojrtd/b2BDs8gFHM1Xp12MVgTwP9o13hv1oeT2ttiEK
 KDq27AKNVN6AlrJjb9oKSyLCuTbUy7kiQQBaaLAgni3L2ENI4SV2CXGXrY7Q0sO0otwS1NKimQ5
 RWOy4ASDTq+vdL0/OToUKQ0N9WydmRUOMtoptSOWriAUshf/AwZszOWMB0c+ZpBCmDhDNqxzehv
 akp8IsawY4UCk197a0fIdQHdBApufqgIxdZszP33/8TZit6Xc2bHfOnej/qhTb+XtIPfX86ynSx
 vQA/C2B3Gc1/t3jkdTeL47ty/AusSVIEy+wSKg0Kl7gL1LrzxRINOgmegicq68k1QD1QB5GcWV2
 RBrNxj76MaNYude2Jno3giLvK9sZ9GhEX8KYvh8qBT9B2yFn35wDnJZKwZ6+RyH5EetEbZ+3Xvg
 EeieP53Z9xW3MA3UnVUn9BnA66uRXqvbJT7b2ecAlUDyk820WB32jY0rkCIqUiM2OOUxTl0RCl2
 5fvTKWrJZErL0MoR+WnHdiDnI1JLAPiI6U=
X-Received: by 2002:a05:6000:1787:b0:45e:73b3:4515 with SMTP id
 ffacd0b85a97d-46074b87912mr12629152f8f.35.1781514247470; 
 Mon, 15 Jun 2026 02:04:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm28863918f8f.26.2026.06.15.02.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 02:04:07 -0700 (PDT)
Message-ID: <6a2fc007.05603459.3d8ad6.7d03@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260615083322.4126-1-linuxtestproject.agent@gmail.com>
Date: Mon, 15 Jun 2026 09:04:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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

Hi Sachin,

> 
> The errno check for EOPNOTSUPP happens after acl_free() and
> cleanup_testfile(). cleanup_testfile() calls unlink() internally,
> and POSIX does not guarantee that errno is preserved after a
> successful syscall. If unlink() clobbers errno, the EOPNOTSUPP
> check silently fails and the test reports TBROK instead of TCONF.
> 
> test_chmod_acl() in the same file checks errno first:
> 
>     if (acl_set_file(...) < 0) {
>         if (errno == EOPNOTSUPP) {
>             acl_free(acl);
>             cleanup_testfile();
>             tst_brk(TCONF | TERRNO, ...);
>         }
>         acl_free(acl);
>         cleanup_testfile();
>         tst_brk(TBROK | TERRNO, ...);
>     }
> 
> Could test_chown_acl() use the same pattern?

This is correct, but it's also true that TERRNO is printing
errno with its description, so the example is wrong. If any
syscall after acl_set_file() will fail, we will print the errno
of rmdir() or unlink().

You need to save the errno using TEST().

Also, please don't define SAFE_* macros inside the tests, their
are part of the core library and they should not be defined out
of it. Instead, use inline functions.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
