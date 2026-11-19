Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F527606A324
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=jU72wmOg;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ZW9cmXC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795087800; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ltx+CqUgBW+RmxzvSJcCwiHoqz4JP/77s7NAn62yPiY=;
 b=jU72wmOg8mAN6o5WhZL2JKNiy+6EvN3RreoVR+Y94MIsi96ieGpbM6oAwqJ2rlQXtx4k/
 MEwA55gBwHktRv+OkumY5TXg248Fq/8HVnVj4mOKtwuSKWG73mFlmasTCsref9gcu/99mYe
 kgFS/E1w5lLABj42nzR23oy3n64Amrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6AF3C6FF8
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 12:30:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADFC73E9FF7
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:29:40 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B06451400C60
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:29:39 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so19023635e9.1
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795087779; x=1795692579; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=US0mZbWQT/GCk8ZvWAyd4rVP4GKVy1pWQBveg2h7heM=;
 b=ZW9cmXC6r4YlxPrxwNexr3NTQJ5oIzqm0tAR6fOfH8jMgob574O2qpLVog5IWLK9vz
 2dYQDJbQclkReAVSuhossoQAPMLtrUFAQtYyj1bXbvpfsy+6L0fTwo8abItkkPxwUH6D
 XT8T3zGn3zQ9wNPuut+l8+1sQYKRepn/RuCw6P+NIECsm6kWTrEacWE8HXyjtEqv6UwU
 95mTEp1a1CS+4zSwC2JMnR1i1uYBUMLBHgWC22s3G63C9Rv5FqYSOwSNdA30YcQuB+5P
 GpFNJpRCj+I08ISH1sZUovbiHZgd6eX4lHAloq/k6u+XEFfFVOsymYfig1YK4lgr/hSN
 B3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087779; x=1795692579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=US0mZbWQT/GCk8ZvWAyd4rVP4GKVy1pWQBveg2h7heM=;
 b=KLsCEi7C/uUMXUH8eR+HTlw0j+p7x85Ynwj9/x4cLnoUWldS4PQCxWvi6W+VRMmlU3
 /oPW6ubjhb2DkWGlLylLSA7I63Sk3PVZs0SR1yC1Xkd0Re8js2Vo/5Tq1C+C7cpv+htF
 uiF9quV8gtQVDLYFWm7v9h+sXxUb2pGual5wekOdqnClCg2FKE1eSwLpZyGkT4+641iD
 AJ3pzIBdWYpuQVF0uI1qk2MV/ydQFHpuoqo+I4dfzmjpnOLvsHaxrbko54zy2gBRGSiC
 Zg2upiJ94+NtzfeQbR9XNf7BVugZFMg4AaBJXUlNCYdj2l3VGjVv6rxDsfsQVCzFnNvg
 jE5w==
X-Gm-Message-State: APuU4Z9QCAtVMnadlK0goiWDcynblxKUhSM01mQjJZu4EJAEHCGcMeDj
 vAG6Hzk/iukuaLCRk895R+ZyIFQLRh4qVuWkZJLAiNr51HkfO4CdLCEOuuJ7oOnQR0czW4dnR0j
 +3rTrHA==
X-Gm-Gg: AYBFou0mz1ISwLvchWUvZxu6Kl0YbpON/1rhnId+KgO0qTHaKnaaD15k/KKXZqWcR96
 CwImnEykd6sW+NO0VDisZN3QA5vL8MWDaifCsrgKX5ZQ46CXv4+imZ9CBTnjY72EwSh6LCJnZhl
 m6nDvouy/TLg9G5kMfGATQXXicPdRNOvxWE80jHmYuh6fhjcMcvVYNutbMLvELVeZP1vRV/8ExP
 PDHNjB6fD7H4XIa+elmXuxrVUMavkUnSj8t1M9Vwpw6NYoN68mkiOrcgt9QVrVP6XbJdYxRh4LO
 cIwD4DoGSX58DUBTnUA+9CWuuLaQz8p5RMBsvlzfOk6X8CV4z+XaRzcOlSnpt8okNxM2n8Se6/y
 x0kK4ayKy65ckH+ZNBebTEFKDi1q44Qm4khFLrVOgaVTFISG2BWtk7uX1I26FLfbc7JbprH8nby
 cN2U0qH4J9b2T8Ix3WgJ7HzDQUmlkzYvJWNTtgyr6Dn7cyjFoKHJYrtvt+tK+I6phwowGLT8Vsr
 roU4hAKsVEX6lccw69nyr3WNbSlSqQ/PqSaQK7tgETq5ZUhMA5VGJLaxfw2RWY/DrjE/iADQKEJ
 FfbkaolNdU1EN8/isuZ2eSOUJIuqsofF3qZMO8bbABQAqu2UuOddT1Sd7wr8/vngEINuBbQZeb9
 IYCsa9r3/qEHJ+A+KfynNdtIHthB2Li2MuA==
X-Received: by 2002:a05:600c:8b46:b0:4bb:7bee:5496 with SMTP id
 5b1f17b1804b1-4bb7da12a56mr113465125e9.13.1795087779043; 
 Thu, 19 Nov 2026 03:29:39 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb84dfe7b1sm30627515e9.1.2026.11.19.03.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:29:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 19 Nov 2026 11:29:29 +0000
Message-ID: <20261119112938.22522-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] irqbalance01: Set min_cpus to 4
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

On 2-CPU VMs, irqbalance01 frequently fails (~60% failure rate over 50
test runs) because irqbalance does not observe IRQ migration on quiet or
initially balanced systems.

Allocating 4 vCPUs achieves a 100% pass rate over 50 test runs. Raise
min_cpus to 4 so the test reports TCONF instead of a false failure on
systems with fewer CPUs.

The failure and pass rates above are based on openSUSE Tumbleweed test
results.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/irq/irqbalance01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/irq/irqbalance01.c b/testcases/kernel/irq/irqbalance01.c
index d142c79ec..7290130fd 100644
--- a/testcases/kernel/irq/irqbalance01.c
+++ b/testcases/kernel/irq/irqbalance01.c
@@ -327,5 +327,5 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.min_cpus = 2,
+	.min_cpus = 4,
 };
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
