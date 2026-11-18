Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB1606A7C0
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=HvpwIgj/;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=THOB9aKJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795019626; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uI/3t2rRSQUkLxFttJN++aVvNHzp7BORL6PBjbwN0XE=;
 b=HvpwIgj/9EMYuRNL1W+J+gI5spgmqTsXrZnFUGo38l2UcOOj0Gos+i7YHFkAZm6J0Cm+8
 k/UGNtJEFDRfGzshkvk8RenNvNfifBkzS9gGKqnxh19NjljloLDHHRyxcIf1tsQ19+oeEAZ
 wwjGQKz3sWmY+bFJn/oGKnWn9hkG7jk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1B03EB2C1
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 17:33:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 678CB3EA01D
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 17:33:27 +0100 (CET)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 083AC140050D
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 17:33:26 +0100 (CET)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8b847ab3fd3so1281324b3a.2
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 08:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795019605; x=1795624405; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xFGMiEi5743VIyIs0pIlY0eHHUUEk3CGMiU9aPQgHJ0=;
 b=THOB9aKJapd88aCq5PLLn9qD7NDb61tjJXSMcC0SusPoBGjbcHVjgXyp+1gZ+6FFnt
 Bh6k069J6HqNQwN1VaOxr6sG8H7BkmZfApEUa42eVsbT1V6UYtExhMVhzx7uS1UHfQku
 KzvafKhnWWjk74pVqGUGrqyzC31z4R0kIN5punvG7WRBKyi1c9bUMjnK7iIign8OQYCG
 sGCjci5evzvBkTqxhAGmOdfABV4nJm6g/wGPKJ8szWGywUxyuMYroIa9LE8rPdGsg56L
 w1WxYkGyqjUJzwzJkhzwu0CS/lUKmOjZa/93VDZ0kaZXLs+n2CRir2Qfy72XS3ZnTjF/
 7nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795019605; x=1795624405;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFGMiEi5743VIyIs0pIlY0eHHUUEk3CGMiU9aPQgHJ0=;
 b=2of+8J0PUOr9l51rMO4LkCwL7eoBsQjVHTL+aASxDsxOf+1tS/oLU1nPomj/onLSJK
 B1kGk+1wJKneBu4FKN+9IxBAxTRLBIlmw+ILgy/PJA+PKHA+U1yv7nkKYyCU0fQ/BU7a
 pkvKBhiiYjOUnmLw8njaPTNwkTdITKDn/23XWddiMegeZHa0TDlKrIKrhLcfW3fSEDws
 hKw0BIfTjRXkRXSfkrcrqh4vk0cWGyd6RNhgEAVptr7pK5bKPDSjUoebcIA66j3lF255
 jtl0+Dggt5T3mj2J7TH1mVrqPl3z/gBMe2FKRdxRwEBlMmajRZ8S8jabmJc3A1Pfrls/
 ULiQ==
X-Gm-Message-State: APuU4Z9SiNr7Gen9fM0Zldpqh+1Q6R+EucEZU5kmu0cSnh5mz7wE2+wh
 QnMvbNlvgCrMrr7n3MgWAM7W2o8hKzEIQ+bx0UTnPlQz8oQpj7WMLsanbr36Dm5j6synJautk+g
 hdQqiIDeK5dLl1U7GcQ==
X-Received: from pfcoe8.prod.google.com ([2002:a05:6a00:cb08:b0:8c4:f2ec:cf28])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:84d:b0:8b5:9654:d331 with SMTP id
 d2e1a72fcca58-8c5cd38b79emr2902385b3a.0.1795019604995; 
 Wed, 18 Nov 2026 08:33:24 -0800 (PST)
Date: Wed, 18 Nov 2026 16:33:22 +0000
In-Reply-To: <20261118063445.2137150-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118063445.2137150-1-chihsheng@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118163322.3334900-1-chihsheng@google.com>
To: chrubis@suse.cz
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> This does not make any sense. Why haven't you simply added "none" to the
> sched_allowed array instead?

"none" is already in sched_allowed[] (line 35 before this patch).

The test fails because elv_iosched_show() prints "none\n" without brackets,
not "[none]\n". TST_SYSFS_ASSERT_CHOICE() requires one bracketed token, so
it fails with "0 selected tokens, expected exactly 1".

Regards,
Darren

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
