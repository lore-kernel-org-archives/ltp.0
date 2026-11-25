Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8563C606A31E
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UkCXWoyz
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B02643EA95F
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 22:09:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853FD3E9149
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:37 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C3807200A08
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 22:09:36 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c50692e6c0aso100653666b.3
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795640976; x=1796245776; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pvlKi9bGUBDxvK3FA8unbMieQ9TzqC6CPiWeZedQdik=;
 b=UkCXWoyzRLxhzkwZbjrDGeP0PiQUr82V3sHVJChqsYf1iSSWKCjqZZXRh5t2jC5anO
 bQS/icd54whvX4cH7tjvnoLbBxTxk8aUJmCfKGvFxHq+e9gWGBM41MMLFd0qvVfnNmVN
 fylgupt9CcNMVcHli3jqJbpzMo7rTiiaI8LT2YKXuUYJMCZjIH3HWxR0zwl/mvbHkda9
 Zb7ALKwdzpUPu5o63ey0jgjN2DavpN0c/6TTAmXpGnh6NplBBjWNlc8w+JiYSK8zXbfD
 r7ZRZ3Hl4QwsQ1gyexYHs0UeZvHttB3rjJuZueqVbzeBgg9X0T4XXoIvyuUdyg28dHgT
 YxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795640976; x=1796245776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pvlKi9bGUBDxvK3FA8unbMieQ9TzqC6CPiWeZedQdik=;
 b=dQMpGGmuGXASxddq9a7QNMfPBgqafYMH7LQDIdqdvctK5xI5KlJVx+LEBD+uGoie76
 TKh07U6Ie0hRdfBRw6XFK7YOoXqNWkLgLTAyWFCcddDZiDBNRj20ubxKGPVnIm/DwJUo
 kWpMIHC3A6Hzz8J+qIFATJT3FxtZn+3h2wfrvYugTxSRzNKFd9YhtOohlkSSCtWV7IXT
 jXp35giZtK27eK1/K+mhfKEG1LkJ5wONYBBfCc3B+97F6LPpJfwBUoJcYr2VqOZ96rGN
 c+RnQS+s9N9TvFOKJMN7ZPozICSkQOEEWqy6dL36Vky8Gi119X48zBdT9pJoe+I024kM
 vRZg==
X-Gm-Message-State: APuU4Z9PK6gw9ewgkIeaezYKD8RTmm3hCzs9wUuTTfIQ90WRv6UpkRb3
 gLrma+O1SCseFik7pLDXMyA6h4mzlEedg7DLiavXRNhFdHc2djRmNIzXqmu36f3kDY3qKEzFruW
 93MCZ
X-Gm-Gg: AZFdTZf3e58/nQb8F+ynK93okqPaJTyEXtoQqN785VafsIS7DkRoIvCBIYZ18D+kUa7
 JNQcf4mCoeeZpdU6Onpw6W1au+bJOi9aaZa6DlADcDrvb/3hP6qkWVDiCefI25ZyeOcY3J7F/q+
 ODfXFKG0GvErwf3mFJBQ4rZQRDZkSD+mX9g5MxGHnxPYCtVdi4ZQYJGQj6z/mLavFN0Pd1kgpZH
 hmoWWVfG7D659mtNJGTlb7ni4zcGk/bxzd649JZzF+rpzuArgdjFO057+SNPu/PRx3E+PpElvd1
 aPWD6hh0m+CckDHpZOqPxOoXe1dgeL+2iZMSw2co3A1H3tFJ5kmcmIBoqEk8kLiUnzVkqiqSv8n
 bmpRiyQ2iNmKDqkjsVMEj4X8/8dl6v8gJYNnUwNibK2KDQUjW4tl273fhq5GV6I1j0PW7N71czP
 ZZ8VaBMN7+OJ7BJOS/Hd0Aox5RxUplcohiOuGcIg1ZKjJameDVnLY/zTlKgsYLScDjN/FCyDiRg
 raIDp/loa+325VP22pk2KNbojUAP/M6zYmGp5tGiyrrn38VNyYEJEUfiMIaFh0fXR94Sis6TRyy
 NQ3JK5l5nL6/CJMkpID/0eaukvtFUncXSZblq+37M94aL9boSNpdFk/Qx67x/XlH
X-Received: by 2002:a17:907:9017:b0:c2e:8801:9139 with SMTP id
 a640c23a62f3a-c513a39d096mr1248718966b.1.1795640976059; 
 Wed, 25 Nov 2026 13:09:36 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6841asm703529766b.24.2026.11.25.13.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 13:09:35 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Wed, 25 Nov 2026 22:09:29 +0100
Message-ID: <20261125210933.2913177-1-anders.roxell@linaro.org>
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
Subject: [LTP] [PATCH v3 0/4] openposix: Run the Open POSIX tests with kirk
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
run them.

Patch 1 and 2 make the two mqueues_multi_send_rev tests use one thread
by default and remove the .args files. Patch 3 rebuilds run.sh when
the Makefile changes. Patch 4 generates runtest/openposix-* at install
time. Each line calls a small wrapper that maps the Open POSIX exit
codes to the LTP ones.

Changes in v3:
- Drop "openposix: Install the .args files". Instead use one thread by
  default in multi_send_rev_1 and multi_send_rev_2, and remove the
  .args files and the code in run-tests.sh that reads them. (Petr)
- The runtest files do not read .args files any more.
- New patch: rebuild run.sh when the Makefile changes.

Changes in v2:
- Take the list of tests from the installed run.sh files. v1 used all
  the files in DESTDIR, so it picked up old tests left from an earlier
  install, like pthread_detach_1-2. (LTP AI Reviewer)

This does not cover a removed test directory: its old run.sh stays in
DESTDIR, so its tests are still listed.

openposix_run.sh does not use t0 like run-tests.sh does. So a hung test
is stopped by the kirk timeout and not after 300 seconds. The kirk
default is 1h for one test and also 1h for the whole suite.

I ran all three runtest files with kirk on qemu-arm64, with a 6.18.54
kernel and a Debian forky rootfs. 1735 tests ran in about 17 minutes:
1694 pass, 40 TCONF and 1 fail (pthread_rwlock_unlock_3-1). The
mqueues_multi_send_rev tests pass with the default of one thread.

v2: https://lore.kernel.org/ltp/20261104225051.402911-1-anders.roxell@linaro.org/
v1: https://lore.kernel.org/ltp/20261023123436.1274448-1-anders.roxell@linaro.org/

Cheers,
Anders

Anders Roxell (4):
  openposix: mqueues: Use one thread by default
  openposix: Remove the .args files
  openposix: Rebuild run.sh when the Makefile changes
  openposix: Add runtest files for kirk

 testcases/open_posix_testsuite/Makefile       | 11 +++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 +++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 +++++++++++++++
 .../open_posix_testsuite/bin/run-tests.sh     |  2 +-
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-makefiles.sh             |  2 +-
 .../scripts/generate-runtest.sh               | 35 +++++++++++++++++++
 .../mqueues/mqueues_multi_send_rev_1.args     |  1 -
 .../mqueues/mqueues_multi_send_rev_2.args     |  1 -
 .../stress/mqueues/multi_send_rev_1.c         |  8 +++--
 .../stress/mqueues/multi_send_rev_2.c         |  8 +++--
 11 files changed, 94 insertions(+), 12 deletions(-)
 create mode 100755 testcases/open_posix_testsuite/bin/openposix_run.sh
 create mode 100755 testcases/open_posix_testsuite/scripts/generate-runtest.sh
 delete mode 100644 testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args
 delete mode 100644 testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
