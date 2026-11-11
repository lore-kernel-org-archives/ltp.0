Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFF606AC8E
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=mvYjSAD+;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Zn+vpMsD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794377939; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=CCd29FOtbkkYzXagEPlIIfPxq3+lgZs/0CT0/IKKjDM=;
 b=mvYjSAD+D0U9eZhhlLTMW91uQh1nlQrToP7SLATjzQL8tcHR7SE+0daZrgTitLRs819T7
 wMv0yEZUCrNHMJx5DkoD4JQNPsyMHytYLDGTADk68xMsHsYTyGT8+piiQyzXQ/sBA4++o6Y
 R3CONKPDa3cGfBIc87c+l7gOKlzcB2Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 804523E4AD2
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 07:18:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D8F03CA9FE
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 07:18:39 +0100 (CET)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com
 [IPv6:2607:f8b0:4864:20::448])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5FCCD2009B3
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 07:18:36 +0100 (CET)
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8a05a4396d2so2330980b3a.0
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794377914; x=1794982714; darn=lists.linux.it;
 h=content-type:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KFEwyEgcQeaEurB2UMFy+K2vqJuKxM4Nk4s1+OfaHw8=;
 b=Zn+vpMsD+rUzPzjWKjUsLFys9bIUOx0hfZxMUu1pqkRR5A3aPS5y+69PmKr4OBH5aZ
 7NJioABl3jcUhvpzodYyXTP5VS3tUAhdZRVrUHAOBakRjnKzYYUTwAt7VEXoo88YdifE
 Z80lg3pxyHFJVKnvbObYMKnnViGKIpi6whLiXdjFBGfrzqFvZIVx/mLxZ1LKJDJowOao
 uHRnxyI5ceQ210lBEl2xpJxe1+AFKJkOUiELBpAc8kAnmtd1tUKndksmLJ8ynC+QUga5
 kshdTj0t2hOIyJd1CIA2Zq/xnELqW/9M2GlWr7UM+JG/Zyr5p0fdbQNWs/3rl/uGta7A
 A9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377914; x=1794982714;
 h=content-type:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFEwyEgcQeaEurB2UMFy+K2vqJuKxM4Nk4s1+OfaHw8=;
 b=aqtOLy+fcDQqIVnYaG7HVzLqedidZ2ykqpyXRU3DrJRuFsKxQvAcgO4SjyhDdyqy9f
 mkvVrrxpbEITFWoY2MR1g5Mvk9LgCx7KbxQYrAZPJlu7mDtbhdDupDNVkxVEEU4kaqAk
 96O2+CsvfsyQWE01K1bsmrjxY+t20mp0265VLNqAmw+fNNO305vPO0qNSb9RxdbsxCUP
 SbgMTsxDPyO/Jh2E7WufBIogB0zGsPi7uPDBEDDVoPnFc8895Z3+omEMkGJ6tf0fjauJ
 uHoYDIPOpNvAw5MWCp6mXYUZQxpttlhxG9D8wWQjMW+wmKa7WOUk5OOb5W2sODm2hsZM
 72Vw==
X-Gm-Message-State: APuU4Z+9SJgXAyNMTvjYBDvEUX7fClSMDhQSa70OYt4seaTkq2kwRT+L
 ZNTYAoFyFQ74jALHA9QCNqOGxDv7Lt5l25Zj8O5AvYKFHC1JwlgvtevXRpbfILcmh9aXlB7+7IT
 xEDCIvv9iZL4rX+UPv1i+lTHU5METYEQhaapW1MN73BImxzu+SYMGnviPbj7ynHc0bT58bzaf4Q
 /AF5ZCxx/Q2AJlKs6d0tRYHQwQ7A==
X-Received: from pfje2.prod.google.com ([2002:a05:6a00:c2:b0:8b6:bd4f:bca9])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a11f:b0:3e2:701d:7e7d
 with SMTP id adf61e73a8af0-3f3000bdb56mr1765996637.67.1794377912802; Tue, 10
 Nov 2026 22:18:32 -0800 (PST)
Date: Wed, 11 Nov 2026 06:18:30 +0000
In-Reply-To: <20261110112100.1594353-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110112100.1594353-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111061830.3910749-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tse_swap: Fill swapfile with zeroes on exFAT
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Please drop this patch. As the review pointed out, the swapon() failure
on preallocated exFAT swapfiles is a kernel regression fixed in
v7.4-rc1 by commit 4483ab85d1e0 ("exfat: map allocated extents for
swap activation"), so LTP should keep reporting it on kernels without
that fix.

Sorry for the noise.

Thanks,
Wake

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
