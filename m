Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0729606A31A
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WqyTiDfW
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DCFC3EB48D
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:50:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55DA63E20E6
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:50:01 +0200 (CEST)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED5331000465
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:50:00 +0200 (CEST)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-366469e3569so348971eec.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792507799; x=1793112599; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbfZtsu1NiqtoJ0h/sj2O7OyqqrMgBPg71C36zOomlI=;
 b=WqyTiDfWYaAWzCWsBrODulvsi/T998p+CqLW7yDQ+707OI1xIY3zS2BpmLkHKuSL7P
 ygiRRyaj8kkjjJBIQ/dHldPjW5Pz/fRbN+rt183T/BoaDStiBpfvY24kSS5L0rtTXsA4
 IypCYWm9G9u1tkaGt7ZFZLmz9Br0N4B3IoyBjYGflICl7tkc9v3G2bRK/AEqipTO6pxy
 V1YSfqQd3poBXFJhTB7PvGUIrJ7wrh2afVYFPWF3RyjKokBt9aqtwJ1JRFRK4rWIB7Y6
 pwiKib1AbwN6gD7CyFU4VjmI3PRKddKDNsMNjuQ6h2RO3//a4vKFBp9DPoW9HzVvBeth
 BpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507799; x=1793112599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qbfZtsu1NiqtoJ0h/sj2O7OyqqrMgBPg71C36zOomlI=;
 b=ygdWl39fdJ0bApG/AOZJJkyLrNFu9PLpuieQDNN0Yo+4yXUjjqcdSxRS9d/syS8mOe
 GNlx5ThYlxtZ3Kfbd8J1g/4iOZQVGkzhwga9M381Opyt41O7z/0anfMLgb0obqvsdCWi
 Vt0prWAEiipdxttiEK3lVI1avJifGdK0RzLQzMdj0CzUt2/QHSA8GPnXAugFPMmcx7IE
 GjQq0b2UUGNFS5K+krMM8EgtB+0+t/0YEcPV+AAFgslyJKZ+EgfsWVTkSKQvMaNjVbFj
 3e08a7Zznm8k//a+Ka/VE0B4Knm4ZdvjMFoZ866RZE3qpYjSnN6qz6GJ4VWsFolOplj8
 7ADg==
X-Gm-Message-State: AFq9FYJnAyLeIucFFyo5fYD5ODO6py/5p4rSo7gHhu7tMKRR/45ftHpK
 lySAfR4C+JY9qiUFa59TJ72cl/S1ClVnEnePOanCtC3LE9EMRJboToLU
X-Gm-Gg: AYBFou3bb8mbs3MNGnfL72RwX+zGM1FzbIoHEAM7+o7wS3HTbM6FfkwptOX9+PVa+/3
 rEqGCxERB6eZYGKbRqem0B94WhETt2Odn92vqYa//aRFfomOyQsEnYPiuI0KtN52XhPzzzJQGNk
 gQAuhKP6339b9e8sMRJeedZwHpGC0IbgbuuWit4wxuxy1VfuRG5sQLcZ+MAiDLjMj27iSThXlhx
 r5eksbxf3o2VCmF0BezLWmgJswoV5IoShMKpEnGDrw2m0lXRnLX/4I7eznBoT/t3RDyonLODHV3
 LiMttwcJM24VcIIHOzIf3qkAUTsRYhFuDDUEemmCvveBCRpbLbKq7NJw9HyZqy69POskVX/tkYk
 AAW8E//Nrr2+v1PxTwpfmeQi9aYcVfmjANC0yHj4q3ylm5PC35ISE0+EY+tIkcufgCTJbKt1a6c
 lryhX6S98p2205Zr5azPqG+B1ydedD+hEJhaKomZ4gcPpAY0F7V/bjUbjtOD/wGDXBl2oQqU9kC
 sQVssQHOekQasY14rSXvBmFZbwYhld5b4t4/awUVqVooYrIz3PMNeK0hi2UZ2UZp1mqtoJoZ8gq
 fQWeFHjx53uv/kmLjqfdmp2g
X-Received: by 2002:a05:7300:7a99:b0:358:f678:46b6 with SMTP id
 5a478bee46e88-361a2343165mr16368697eec.22.1792507798921; 
 Tue, 20 Oct 2026 07:49:58 -0700 (PDT)
Received: from
 runnervmxehtw.kjntne4dm0buthbq1dof10awsa.phxx.internal.cloudapp.net
 ([172.182.243.65]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm44717743eec.17.2026.10.20.07.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:49:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 14:49:56 +0000
Message-ID: <20261020144956.6124-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-build_system_optimize-v1-1-744f9fa88908@suse.com>
References: <20261020-build_system_optimize-v1-1-744f9fa88908@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build: Parallelize subdirectory recursion in
 generic_trunk_target
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On 20 Oct 2026, Andrea Cervesato wrote:
> build: Parallelize subdirectory recursion in generic_trunk_target

> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> +syscalls-all mem-all: lib-all

Medium: running make -j8 directly in testcases/kernel/syscalls or
testcases/kernel/mem bypasses this parent dependency, allowing sibling
leaves to rebuild the same missing libkerntest.a concurrently.
This races object/archive writes and can cause intermittent link failures.
Build shared prerequisites once at these subtree entry points before
launching their children.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
