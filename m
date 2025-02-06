Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7EEC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738808645; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=m/+GX9RxstZkm2t0Vd+FSKnplgZnPmtPaLr9ZOEdDIU=;
 b=hlEjWudoz+tj1ju893Onsi02GPmBBV9yeSGhY1ccdr1KDRI3fzZDCZBvPh+pBDA4D0oFD
 yYfNrcubWfbfSHx3ftzJb1Qy8gRgk64VG89nwC6vMxZCCsDQGPMOcAkLpW0VsCA/vMyUqtQ
 hIcAfYvunMvax64SWiiHbCDIoaic/1o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A089E3C813C
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 03:24:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9D53C813C
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 03:23:44 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5CC07625371
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 03:23:44 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso2405745e9.0
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 18:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738808623; x=1739413423; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hQWygH0fjmmjgblgQxgm5dL8RNOpSOgqgQNVfhak/6k=;
 b=UJVDpCaoWp3Z0ZSzIknDZgYhgRpeeh3OCwvWh4VJ2Lvb28ejW9/+g0+aJj9CHnHlwj
 5XRZuYpkvf76lmslSA2mqBwpkZHzPesnKTM88weBq+Xt/wNvp+nUaHmIcbpENMjqPFHO
 j+AUhFIoPu/KPb/AOKomw+zJHyelWWB8vx6aSRkpIOG9rL0yF4HnLClhlTdz8lNK4ksu
 CXQxBCiwPDhJEplAoGCEMl9J8K7RphzhILOfI0TF/gY8pjpIg3DqU+BGAJCSQcHZm8C+
 N190uEn/LDP460a38M/iRjhpeJGw3Kk5dkkafX3NEpRVual09L491gcwL/RRj4fzUB5T
 uPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738808623; x=1739413423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQWygH0fjmmjgblgQxgm5dL8RNOpSOgqgQNVfhak/6k=;
 b=A9sCcYElLRvFqxA/sZm1fqorw7Hp7BK8ylaln44HjbYfX63se2aJIyMe00zc6OBfJm
 VUlgOYUzhEIktES8adHwcsAITrwZ+N6tsfGdwyDAdBuTX/UmRrcaN91S3Ws4O4cdlily
 /7hpA4BAcYjtt/Gd0BUUPqfTLMHRTJnPkSc5qfZIVG/FRcLAUSleBrtboY3lA+O5teD9
 hlU+Ncl7ProLEZXosJ5KzWUSwcRbXGSQuhYp78r1PRoLOQTPeSdIrnbDWsAsTxOOtbja
 01Af/KWOz5ID3nS9DT71kOfxai2177H+aHg4Gs/gJIvJen6AC85WpcYWMJvIn9gKjsaZ
 5nXg==
X-Gm-Message-State: AOJu0YxdLLrTRoKlP2cGzjbYQS7smlk/Tv6pMrAs8UTGzdyQERTJSjjW
 x5Y4+3eNtx4ewQbsfnPLLyhfn6Nh4rPnRkELC0Pf/i59h1w9DQ/HLMIzh4y7+TZT7MeNmTE+ubW
 A7g==
X-Gm-Gg: ASbGncuxDxXTKhWmeibJF6QsW9zDrfrxVVyScpNcJlR3ArmsbE0Z5lFFT9mFWkx9OEH
 t6s7spz6u5mWI5o/Xy6VOVf3bVUw5c5TEXcBYFIcJLDmtM3mMHUKAIzU363jGSU3WGQgRGuODGT
 zKy63Utn131Qc4PF7jZ+b3qlmhZSkO75em5uAqLPC/CXUXlECRKBrOpMPGNKzaqPLwkx5zUcS22
 alewZE+VAGgAobVWclFKTofFlhTZ6EVY7F2jXRS67XLnekJQeeEs9WCmeLzZwPtKQgcBUSJpnMY
 AVw1
X-Google-Smtp-Source: AGHT+IF6GJSDMBZVY/Did4iT6LtNY0fQyMabRmyRM1ZoYf72xYwtCFO7K3OBPCvy2HEsJV2OtjGGIA==
X-Received: by 2002:a05:600c:3b87:b0:436:e8b4:3cde with SMTP id
 5b1f17b1804b1-4390d43ee1amr46804665e9.14.1738808623085; 
 Wed, 05 Feb 2025 18:23:43 -0800 (PST)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1d142sm397844f8f.5.2025.02.05.18.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 18:23:42 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  5 Feb 2025 21:23:27 -0500
Message-Id: <20250206022327.11821-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] hugemmap34: Disable -fstack-clash-protection
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
Suggested-by: Jan Stancek <jstancek@redhat.com>

Compiling hugemmap34 with CFLAGS='-fstack-clash-protection' causes
gcc to insert additional stack address validation checks during
alloca calls.  This results in kernel start allocate memory really,
eventually triggering an OOM.

Base Jan's suggestion, disable -fstack-clash-protection to allows
test to run on larger pool of systems

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
index 2d651b4aa..6e72e7009 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
@@ -8,4 +8,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
+CFLAGS_no_stack_prot := $(filter-out -fstack-clash-protection, $(CFLAGS))
+
 hugemmap06: CFLAGS+=-pthread
+hugemmap34: CFLAGS=$(CFLAGS_no_stack_prot)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
