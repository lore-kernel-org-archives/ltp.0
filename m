Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C989606A32C
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ic2Qywkh
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35763CD628
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 23:51:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22E343CC88F
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:56 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E5612000C2
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:50:55 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b547eacb53so213086a12.3
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793832655; x=1794437455; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJk3vkTCmdQ4sOM7qLNjdu+C9PJaLqWPSr+jA2Bz7yI=;
 b=ic2QywkhC/6NnaS3ftn2DQArlcbI5HppP8GlnHYA8NNmkiLnsNRuPnZaPbR3KrEqaO
 N5KavV4GWlHKKvNJvMt/4zeccVJVEWo7hSfJKAKVUTbkHXT/gy8IgKyehV+lxSKw4SQE
 opnkKHWDGN1JWs0vKBssxnBUIAIi1EiXXf49QEC74/HjBr5h9OzP/o8q6e81J2GQaZaX
 7/apt+ewoAnaRU0CBFR1dnTPC4ghcq0rO/yNcdQvPFJ8NybSw8qP6PYqmyHW5b6FAnrW
 CR1UTy+7Q7uPOQUMNn+iAqJJ5S/Ofq1qeHBpl3LheofBh3k+Odg8MSb8hgHHOFSIhMkO
 7cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832655; x=1794437455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJk3vkTCmdQ4sOM7qLNjdu+C9PJaLqWPSr+jA2Bz7yI=;
 b=hr3COLrLIoh1l21IkfxPLqoaFtWpPqO+NICluNLb29pUlz8BilDC+Tyv0zh5Vs0UfC
 LOa6Ba0i6fIN2ZUolq9XDnxNat1LCGEfi2eIse0VygWm0FbDhmjZYqdMyN54EFF6tiRP
 jCFox5Nbu79BJpvKDGCjdgI6WmcAjE5a+4jpTFlluK5IMxcHc5e8c0KeIuCNB+m7O+Tl
 O0fZqWjykcZKd6lSCJwzd0aW60vQwPq6NSrhUcHHucUse5ZUlNpbA7v9xG/wUXXpRrMj
 OcuG/nYBET5aJXuSrBwpv/OaS6JWQuifrNkR8W6WE3+z2/MAeKleUBHG+Fh/+4I7ag1S
 VcHA==
X-Gm-Message-State: APuU4Z/36sb7uepEliYjGiRHPSW4U+6799tfVy8nNKyJffAqmAzqMnMV
 3Dzrz8T/6NMVsYmQCOfEdaqjE68nit7jJ35tTVydTopFjEQNSLc5jS4DKfn/EgPQz7yy9cDD15J
 Iz0uN
X-Gm-Gg: AYBFou04isX0TKsw4dthHmW/bsCUYSzoEb5g0XhzjmN11XxApX53ZcEI7awnt0/FpD+
 atL23KRwhtGScpApj+tejSkounJsEzDNhuY2zlbOVHEoxXfcyJaQ0jESmTSrURY8yhwtfP9jQvG
 YDBWI31PFmqB9Ez2o2ZLM9SBPySaczYM/GmqlXEnjbAcRxpx9RCP5X29z/Z2VYlQTRHrJ4RJR/B
 PmF+FcIbzWgxcP4m9QhFo2oesuBi5C7S1DFKJAZYp8I97wqVIjfQ0kNMJdjtghm6y/vJukAVxJU
 g0Bo+uVWCcFKU8gLg1vxqzm7TpkLnRHOeMv3vpCoRFaj8B6AQxNdtx6nLEkNMSuO80Qv+QMe8b4
 f186LY1eFaav40GjU+rHZIJ6bkuYJZgOMvPjsaMcobWlLT5ASbN/ypWKE0Al8QUQznt5VUR3k0C
 HAkNXKagyfs5t11j0EnPVp1MhXaRq/igUAL/k96rv4M/xRZpY45QNZ1zmnWkfDiula/PxW6cDez
 Npu/WfwUfYI/NwKnrSs6JChWfkLWhfPQ5OWj4lTcaa3hgKmRQ5uAww4cCGYbd6Mr1LFQI5XxdOZ
 N8DehnCKtMmFqy5Z1j19MuCBN6Dsv7gc8tNz63KHKchhEX7WAXb8MeenMhs9VUkQ
X-Received: by 2002:a17:906:f806:b0:c46:ae89:cd3c with SMTP id
 a640c23a62f3a-c4ca7936928mr1537317266b.1.1793832654626; 
 Wed, 04 Nov 2026 14:50:54 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e48db4bsm115477766b.73.2026.11.04.14.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:50:54 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed,  4 Nov 2026 23:50:49 +0100
Message-ID: <20261104225051.402911-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] openposix: Run the Open POSIX tests with kirk
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

There are no runtest files for the Open POSIX tests, so kirk can not
run them. Patch 1 installs the missing .args files.

Patch 2 generates runtest/openposix-* at install time. Each line calls
a small wrapper that maps the Open POSIX exit codes to the LTP ones.

Changes in v2:
- Take the list of tests from the installed run.sh files. v1 used all
  the files in DESTDIR, so it picked up old tests left from an earlier
  install, like pthread_detach_1-2. (LTP AI Reviewer)

This does not cover a removed test directory: its old run.sh stays in
DESTDIR, so its tests are still listed.

Tested on arm64. I cross built the series and ran make install into a
DESTDIR with an old pthread_detach_1-2.run-test in it. The runtest
files have 1735 tests, and pthread_detach_1-2 is not one of them.

Then I ran them with kirk in QEMU (tuxrun), and 2 of the 1735 tests
fail. pthread_rwlock_unlock_3-1 fails like in v1. fork_7-1 is
unresolved because the rootfs has no gencat.

v1: https://lore.kernel.org/ltp/20261023123436.1274448-1-anders.roxell@linaro.org/

Cheers,
Anders

Anders Roxell (2):
  openposix: Install the .args files
  openposix: Add runtest files for kirk

 testcases/open_posix_testsuite/Makefile       | 11 +++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 ++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 ++++++++++++++
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-makefiles.sh             |  1 +
 .../scripts/generate-runtest.sh               | 38 +++++++++++++++++++
 6 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100755 testcases/open_posix_testsuite/bin/openposix_run.sh
 create mode 100755 testcases/open_posix_testsuite/scripts/generate-runtest.sh

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
