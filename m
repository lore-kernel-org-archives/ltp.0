Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1CC28B25
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 22:58:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14FAF3CA182
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 23:58:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66E883C9BE9
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 23:58:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=jacob.martin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CB721A004B1
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 23:58:09 +0100 (CET)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEC903FCC5
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741388287;
 bh=DthZczQCezXsKD9zBwe5Cuc5cRjGwL1h8ZKUCS3/0bU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=PeOZfD6vxqRs9QOmC8CVopfAn+eJc4Jwy73vWjKWWFJsE0CErJYaVRro3BVJ2AIMN
 l4BAzjDR4HRaerEDC6C6Ry6y0+fzCBP3WiKCiP2qWYeqFaH0ZZt59IZEM1Tzv6ij8R
 KSW4FnPueMNWIB7qiDBtTeVu9XnGp1d6/s9NAAZBjShlHoX9OvPYu0fEsGPAQ50A+s
 370tjxHLqD9ypxCAFvWCjF3pPsg9RhN04lYXHQgCj/V6FEhmKhhKZpaA0Mg5HyFZfQ
 JEwj9W4u7VcRT5iLf9JUGY/epU3fx//MQ1v+YFVbDDu9r4jQjBNlr6tO0f9nsa8tx1
 RyDunNBKDqvZA==
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e8c4f5f477so40990136d6.3
 for <ltp@lists.linux.it>; Fri, 07 Mar 2025 14:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741388286; x=1741993086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DthZczQCezXsKD9zBwe5Cuc5cRjGwL1h8ZKUCS3/0bU=;
 b=WLDUYSDZ3oCFJbIFfFYTHfDFuZyMns5/b/uROpG07TXFR2UgWWRq3fQUdS5VRPyZWT
 ok7LqyXfK5n7mR6RfZV7f2ys0jmBSHy3heSyOuEC/hCbJ8lQs1VuBcZjimMfL9dgkxRu
 /KNFwmdQqx0o7jcoPpKxgeRuWFJ5OicPvURX1G8PY0aRFAtkuiyIGbUQQ9LTfu25sfDP
 HSu4hSGDX9VMBTDrtWamgaNNsUcStxUFr0PtMkrZMPR4ukuJG22Vv89KCRNtcfkWHIpa
 WCdX6EXu/RN2XOhzCMh00r0nfnyUkjElAS4g8y2XdW/vtM+fbMARodgbKac1UxyDPWBp
 iojQ==
X-Gm-Message-State: AOJu0YyZKltFGaNj4qKTtax0xbvHPDN7PkfvhPIcHoIV2xOTbgNdXXRG
 q3MElenoJPjYc9xYdDfPaskJ1eTBD+kGq+/HA4V/P7sS77CHa5TGgFX1ULjX6b8YfAQFtTlSd9f
 gB04rPpt4ziOe3z7Gg0FlOTZqG4kCjNr4dNZrMKfQHwX4nuoOmoWT6yJeFs1zB3USTGL3EB7f
X-Gm-Gg: ASbGncsqChLYv4ENUxzilAp3UFEXiPv7oUkluvCECRZe/SRrkUxh4lO6eDgKYAq8wa5
 7cdIgl9E0Kzy0WyPHJfhhtJcDQKkth2HfqfwiM3RVnHen9KjTjFpao7vYstmcV6UK0gTlahAbgi
 ORKcyRG7kl3gCg88FoY5P6SAn6vfTunjWeoAAFqYg985TwI6vL/aGjiNz3pc+NL+uNF5M1stZML
 QBLlz+m0tUXyixfNWcJWU8lb+8h5+gIXFTGvq7iwiJtp5sEzuOjqiCjf7kKRknmEu0JL1D75nOi
 0lEJBfhKFA7kdEdsOlyqkwg=
X-Received: by 2002:a05:6214:500f:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6e9005ebd75mr74632906d6.15.1741388285756; 
 Fri, 07 Mar 2025 14:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTiSEZeQ1Mju81INm+rCmE3ErUST8oo8BIujlKtrX5EtGTFt7GLoo0rIB1TyJ6nW8rXJT4pg==
X-Received: by 2002:a05:6214:500f:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6e9005ebd75mr74632686d6.15.1741388285509; 
 Fri, 07 Mar 2025 14:58:05 -0800 (PST)
Received: from localhost ([2601:441:8201:e8ff:9eef:76fd:782:3b7c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f70a2dc8sm24457926d6.63.2025.03.07.14.58.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 14:58:05 -0800 (PST)
From: Jacob Martin <jacob.martin@canonical.com>
To: ltp@lists.linux.it
Date: Fri,  7 Mar 2025 16:58:04 -0600
Message-ID: <20250307225804.380166-1-jacob.martin@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cpuset_memory_testset.sh: Give SIGUSR1 handler time
 to run before changing target mapping node in tests 12 and 13
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory test occasionally fails on test12 and test13. Both
intend to map anonymous memory on NUMA node 1, then swap to node 0 and
map more anonymous memory, verifying that memory was mapped to the
correct nodes along the way. On some high performance and high core
count x86 instances we observed 0 would be written to cpuset.mems before
the mapping program receives and handles SIGUSR1, causing the mapping
program to map on node 0 instead of the expected node 1, and thus
resulting in a test failure.

 cpuset_memory 1 TINFO: CPUs are numbered continuously starting at 0 (0-223)
 cpuset_memory 1 TINFO: Nodes are numbered continuously starting at 0 (0-1)
 cpuset_memory 1 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 3 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 5 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 7 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 9 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 11 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 13 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 15 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 17 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 19 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 21 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 23 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 25 TFAIL: allocate memory on the Node#0(Expect: Node#1).
 cpuset_memory 27 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 29 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 31 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 33 TPASS: Cpuset memory allocation test succeeded.
 cpuset_memory 35 TPASS: Cpuset memory allocation test succeeded.
 INFO: ltp-pan reported some tests FAIL

This is resolved by adding a 1 second delay between sending the first
SIGUSR1 signal and setting cpuset.mems to 0, which gives the SIGUSR1
handler time to complete and map to node 1, before switching to node 0.

Fixes: 70259d6e7
Signed-off-by: Jacob Martin <jacob.martin@canonical.com>
---
 .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index c1e7cea8f..04d7cc877 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -383,7 +383,7 @@ talk2memory_test_for_case_12_13()
 	sleep 1
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
-
+	sleep 1
 	echo 0 > "$2/cpuset.mems" || return 1
 	sleep 1
 	/bin/kill -s SIGUSR1 $1
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
