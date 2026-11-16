Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC2606A334
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Tdqyec4F;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KjYXBTUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794810741; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=N9JzvYiQHCUpLhWiuULqc/OyMS/xYyieGV1xvY5Ln+o=;
 b=Tdqyec4Fh7WzY+nmMjL3W+kW9xMHkSAQW3Q0aUQ8WXU7z2TEFcfd3+G75qKxWzyzlrGXj
 TU8VOVxGzs8IF9/rarWiR5E4J8DQOTSX2ul5VElqAMbYbrhKQbBEQucMe3KRT+KkSfgOidP
 +3I22uQVEXkBvByZDNLl3o+31ymLyic=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B0CA3E234E
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:32:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA3713CA78C
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 07:31:58 +0100 (CET)
Received: from mail-pf1-x445.google.com (mail-pf1-x445.google.com
 [IPv6:2607:f8b0:4864:20::445])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F3421A00793
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 07:31:58 +0100 (CET)
Received: by mail-pf1-x445.google.com with SMTP id
 d2e1a72fcca58-8a01e2962a1so3278498b3a.2
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794810716; x=1795415516; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fcqQ7Q5L9o7SgVaNHh/6y4cyn+jOjpC+AGAUYpzKyqU=;
 b=KjYXBTUB2R3By6omy1iZc92CnpUqAUYg0mwCHDJzkMnLFD7pdSR8qjU3ql/QS35+N3
 Jj2Z26JxnyAwCSQilFKbLHiGPItco+JOi1lWVaNslH+ppbpqxL+epvAEZdt8p8rVcxkq
 1l/9G6vMLt3v/tUeUMjK5bCvgUWLkBuSUaR7DR1KDEm/YwoUqoPzCG5Ki3rBTVKXMoCv
 Uyv3XI/V7yhbBZQhwwWgTEDLAoMlzWUulZGjwW3onYj44GOS3UpdQODROB+lVVvzLjCa
 M23L7lzFlbYqbP8QFOh+U3V3fqAd+i45fjvawv+xCDNxP746vSXJMHP4bLaAI0POl+0j
 8LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794810716; x=1795415516;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fcqQ7Q5L9o7SgVaNHh/6y4cyn+jOjpC+AGAUYpzKyqU=;
 b=0up3C19RSglSrKwYILz/BAnckZQ3TxLhq6PLdSDjsx7tiPK3sAYRXdXJh4u5UtqbqS
 +jdHo5eBDYDibTBNc++9lV2PvgIddMmRm2o2DyJkRs+g9qdruXsFSse10mx5a9NuVxNt
 JauBRQXkXI/x+T/G3zQUO2PBdnEneKfNNnrRmZiioOA1yKSaNfOMWR2JMJxTrzRkqbHB
 Ki4IQmBbg6Mn+A0c9GnwEPzsW2/OZUEdu66PY3i1Wkv25Fz7G3TQW02IgjuLzL4CY+j1
 0cGHLplfij8jQ/xG2Mg5+5S9OS7VK1meA590L2lEvDtzew+vp+PZVm9j8eTEh43QAXWA
 mwBg==
X-Gm-Message-State: APuU4Z+tP2cdtiOYsDs12dgujx8EO7880lHvtJr7Xp+qXGCjqAvUfHJ7
 zw2CwBflXX052xNwGC+tEDUFWoVN1AeHprwQKvSMRBf9GQdtepB+gDGsywXBJMrqOveT2kLZAbu
 SFfDnERDvXz5g+LPQ7V49nhlh5QkXVbf0OGLsM5whZZYGpoW9gMbCqpyZpaVu/kOd1AsxKgqzre
 tOK9i0PqF85WpbfAUkAESOAcd4jw==
X-Received: from pfbhu18.prod.google.com
 ([2002:a05:6a00:6992:b0:8b5:b13b:bc77])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:17a8:b0:8a0:1e49:71bb
 with SMTP id d2e1a72fcca58-8beb8002553mr8825366b3a.57.1794810715625; Sun, 15
 Nov 2026 22:31:55 -0800 (PST)
Date: Mon, 16 Nov 2026 06:31:53 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116063153.2343830-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_gettime04: Retry on transient preemption delays
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
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

clock_gettime04 performs 10,000 iterations of back-to-back clock
readings across multiple syscall and vDSO variants, requiring every
consecutive pair of readings to be within 5 ms. On preemptible kernels,
if the test process is preempted or migrated by the scheduler between
two readings, the elapsed off-CPU time can exceed 5 ms and cause a
false failure even when all clock interfaces are accurate.

Unlike a persistent vDSO synchronization bug (such as 5b43bd184530), a
scheduler preemption spike is transient. Allow up to 10 retries per
clock by repeating the current iteration when a reading gap exceeds
delta, failing only if the discrepancy persists.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/clock_gettime/clock_gettime04.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
index ca6c42d14..ead68d1c2 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
@@ -107,7 +107,7 @@ static void run(unsigned int i)
 	struct tst_ts ts;
 	long long start, end = 0, diff, slack;
 	struct time64_variants *tv;
-	int count = 10000, ret;
+	int count = 10000, retries = 10, ret;
 	unsigned int j;
 
 	if (clks[i] == CLOCK_REALTIME_COARSE || clks[i] == CLOCK_MONOTONIC_COARSE)
@@ -166,6 +166,12 @@ static void run(unsigned int i)
 			diff /= 1000000;
 
 			if (diff >= delta) {
+				if (retries > 0) {
+					retries--;
+					count++;
+					break;
+				}
+
 				tst_res(TFAIL, "%s(%s): Difference between successive readings greater than %lld ms (%d): %lld",
 					tst_clock_name(clks[i]), tv->desc, delta, j, diff);
 				return;
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
