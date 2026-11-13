Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770D606A321
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=W4RdnWjo;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=QcUzNRKc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794543173; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qCLJzXNiBUu3kPUpyPAgKA4pcYg6pHARBvM0zVrPoXI=;
 b=W4RdnWjo65xxbQs0R6D8no7hmu/7d/4NJPiUR8w2iyNcLdhHtCi4kDLYYp3v9kQB01X+4
 Yzlrqqvr1t2BBzURpoePjFcgAEQ0v1Uj0exEDZFVGoRpmu02WjsGeE3IaLpXEER7I1xCTqQ
 lgK6GJYfKpf7lYauWg2VcORXli6q3/o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EC4A3EBC5E
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:12:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D93E3EB526
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:47 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB89F600A6F
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:46 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so2112705e9.1
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794543106; x=1795147906; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v/FdyncgoipjzsDXLSERwt/Woqd7ZoasLCzFYUmivCk=;
 b=QcUzNRKc8mhUku/riaB+GztabAYx7HV/1TJXMVhBxhbsBf3A0msz89yVoj3vFcbn3W
 u7Q2J7YdQJPmM/QCXzSOOjlsQMysunTVTMK2WKm0G+cX5hCuCDUbErnn0oIyc46VLL0E
 48Azic9nqHAHZnkXwCSnkuq7n13nLn0+sO2p11uwmwDErLCq43jhM73pXfLxfdXvOvz6
 hujhQvd1Ftj1H4zo+3Q506NuqTCdxQqV+PiXNzN4OAxS2lpSn5jL7JnPYVvaKGqatka4
 vVApHPSxO11RcDpOpFDTe+W2eMa0HyOzQesjry4lwQZtAmFGORwJR3Nrmj8s/7qSe5NU
 iWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543106; x=1795147906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v/FdyncgoipjzsDXLSERwt/Woqd7ZoasLCzFYUmivCk=;
 b=RAXrH0EzKDiLvAi5ZSSf+tW6Y59I62Um/4rgSzA3aKE6wa0Nrqo6i7ir6aUk3kFdNc
 XyyT2N/y8rUu6RLNJ4bBulycC0yWGJwQ5+kFlajkEkb6Dl3aGxQg1ZJoDziX9yqCHO65
 69x36d72VMBfMxy1MN1Pm3Di3GXKoxDYn1SP9cw2Hu21JIltB+xpo1Ip/PRGd7uesctb
 6ASephXj197cFPJm96le+GRTIZ46lvzcBZ/uDPv9ztoJ4xdLWOFV1bRwNS9wWCevl5uw
 quyBfha4LnWerhELYiK/kHfArIigWS7QS3jf5wE83DDsvvuLOTAexPN3+cwqzDtTK2pa
 t2cQ==
X-Gm-Message-State: APuU4Z92jm7NqJkLLXt7j+lAMo6uwjGwU6/SsmsikpbwF6WsGbVSOsbI
 b4+1ntLsN1ybPQ4dum+dsboUmp+krepCD+2V02cMfFkEhzweMw+T/b3pB0mg7L9fbv2otUn+qZy
 jpfpdxg==
X-Gm-Gg: AYBFou070WI+Z1+ekaGBsiJIdk5fPxMAVAfO4VogI+ntsIM/543/pYfTkDE8k5e8xVK
 YA2BahZtClaRSGmIcmezxRqbdqv5Tc5aSOcd9ovE6aElHf8fCNfPvXmtEKdipYrenP83ZmT4Ito
 fSD3MgfwFAoWRkC8qoiWko0nbecB9Bz4CFceTBcKUiaxaZr9v46QeWByC7NQQE2PU7H1Fd2ss7G
 g6VoXOv50dRPAdga5b0flBJ96Odo2wDuXMqr4//8gOQiRGiPBEOYG9sLIFURd94BNJVvUPUe7H7
 s8Jt87CxFDaV20feNwF7bZacLqn37Z8qa9k5QifqiH9e0BMMAR1AFwDSXVYyDYyh+v4kDN+3jUr
 e/wDkHa7rE62qDGkIziWq8sIHC9Ti6SjqSf5e3oklk1he5iOxRbNs2OyxJlGffHYObppXgRrE5H
 IEfxwrnLUsS9YD75ygV69Q3JSZw1itiAsMOE4sYcvRIonmtNU9m/snBtPA1pDz40Tg1BRZFtqnE
 1aZ9M3UfRUIe6vn4KAjU7BdpMLh7bQV2j42PsagOYcQTP7DRljy2QVV2OWbgRfow4pwrb4bXmYC
 8WLo967BWOvEB/3EFP/8ytKaKhIyO8eU9q2kGN2xGz3swDXDrdvu96RZMKzdiFXH+0+/BYncIFT
 xvZmk6kWaoygrBk6nechEts9wrTMCY6PPGQ==
X-Received: by 2002:a05:600c:870f:b0:4ba:495c:3798 with SMTP id
 5b1f17b1804b1-4bb55af1377mr23494115e9.35.1794543106186; 
 Thu, 12 Nov 2026 20:11:46 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb55a68c5asm28014025e9.1.2026.11.12.20.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:11:45 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 04:11:33 +0000
Message-ID: <20261113041136.17102-5-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113041136.17102-1-wegao@suse.com>
References: <20261113041136.17102-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] memcontrol03,
 memcontrol04: Bind test process to a single CPU
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On multi-CPU systems, memcontrol03 and memcontrol04 can intermittently
fail with over-reclaim of protected pagecache under trunk_B:

  memcontrol03.c:104: TINFO: Child 142113 in trunk_G: Allocating anon: 150994944
  memcontrol03.c:121: TPASS: Child 142113 exited
  memcontrol03.c:214: TPASS: Expect: (A/B memory.current=54394880) ~= 52428800
  ...
  memcontrol03.c:104: TINFO: Child 142114 in trunk_G: Allocating anon: 174063616
  memcontrol03.c:116: TPASS: Child 142114 killed by OOM
  memcontrol03.c:230: TFAIL: Expect: (A/B memory.current=43319296) ~= 52428800

In the kernel, per-CPU charge batching (MEMCG_CHARGE_BATCH = 64 pages)
caches charges in per-CPU memcg_stock. On multi-CPU systems (especially
with large page sizes like 64KB on ppc64le where each CPU caches up to
4MB), allocating memory across CPUs allows cached stock charges to
accumulate in ancestor trunk_A. Because trunk_A has memory.max = 200M,
this extra stock pressure forces the reclaimer to evict pagecache in
trunk_B down to ~35-43MB instead of the expected ~50MB.

Set .setup = tst_bind_to_current_cpu in both tests. Since child processes
inherit CPU affinity on fork(), this confines stock batching to a
single CPU across all test children, preventing multi-CPU stock
accumulation and ensuring reproducible reclaim behavior.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/memcg/memcontrol03.c | 2 ++
 testcases/kernel/controllers/memcg/memcontrol04.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
index 25b84c24e..73d1e7e04 100644
--- a/testcases/kernel/controllers/memcg/memcontrol03.c
+++ b/testcases/kernel/controllers/memcg/memcontrol03.c
@@ -243,6 +243,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	/* reduce per CPU stocks for more stable results */
+	.setup = tst_bind_to_current_cpu,
 	.cleanup = cleanup,
 	.test_all = test_memcg_min,
 	.mount_device = 1,
diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c b/testcases/kernel/controllers/memcg/memcontrol04.c
index f1e136df4..462782d6d 100644
--- a/testcases/kernel/controllers/memcg/memcontrol04.c
+++ b/testcases/kernel/controllers/memcg/memcontrol04.c
@@ -242,6 +242,8 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+	/* reduce per CPU stocks for more stable results */
+	.setup = tst_bind_to_current_cpu,
 	.cleanup = cleanup,
 	.test_all = test_memcg_low,
 	.mount_device = 1,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
