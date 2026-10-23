Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129A606A326
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bKxhlFkf
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 050873E2550
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 14:35:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 208DC3D25F8
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:46 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6FFAA1A01974
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 14:34:46 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa046a99c6so198421a12.2
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758886; x=1793363686; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xuhacqqS+/NCTaqpntAc8N4PHd57yuuqKo6hfOs1c80=;
 b=bKxhlFkfMOVbc/A9U2r1DGD1d6xCPHxv7C8ltarNFAAMgSfrvnw4EaD9Y8OlS+odz9
 mqezDqz6Qm9tXufCYstzA21hdl39vGEy67GOkLSd76pBVV+XFr9xSaII7VRKb6Wl1epN
 uXduKUuVNnCaIQ2Y8MYjuHIlmOfMM1awE6B/pEL/htY5PKh8IwO2JOZQflJ8LIJ8Aab7
 BWI6DzcFmkceyfxNPLToWxBUKpksaMBK4RlM/DDGvCNLzrhG3u/n3UdKmGgz3NbemEj2
 MJaX7djZVIxagtRBadeT1oXBLdwXU4p+8lz0Ow7HFOnkG6nZw/MFTLIB1W8KsGPGYRRM
 t/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758886; x=1793363686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xuhacqqS+/NCTaqpntAc8N4PHd57yuuqKo6hfOs1c80=;
 b=1DUWq2houdxzKLErM8zp8VG5TpkQGBl6PqK6SriT91/Ld+fnreFGvpDasdK3doyBFx
 dUjEyGdE28neVlIav1KBbauSLRzbydzCQITJieTpB93AxeMUMgCvhEha+AU7+ddpG2vD
 RF/dM82iR+y6gJjOrVXrl/XPIzeSp4uimipAi3MuBfc5+5+XtCykDZT98gh6ivTNCVjH
 RbXwbZ8pZpplKbendHxiTRrjl3IXEiBzkeXCgJXlUcRRmmDwGQqvZ/R+AoE2VDTy45S2
 tFFZRc7FKyObTD3pkj+oqaZFtyXtAXvtDiODbfV07uPLRyWE+F5ZPrfkKT4e6HmToYM1
 BfHQ==
X-Gm-Message-State: AFq9FYKCCsUb6to/xXFLHRo0x7p1r3XrQBbgGVSqrpbto6waKEt8vGMR
 IeYFbsdMOwEx7rg7df51RY2/SHGMpV5tvEQBOyheneHpoDsJQuiZda0pJftzNDTnZQQgQWcBSDd
 BYUBO
X-Gm-Gg: AYBFou0S6umoZc5ac5K30JpEXed8Ivc1Kpf8Ccx+wjh+flhQLydciFMQ31SXPZ/UlIW
 Iy9kJ3tBxto2C21l6Mj99v6Rmn01K+bHc7xJkMw0+NngUI/wMj4nLJuqwug7MbSA2SZuOgbY72Y
 0QfAYSy1SA0J6G7njz2YjRAT55W4heZsFvJZE9cZgP20usL4ABZd9Vr1O4okwqMfaE6b6YQbBVP
 5AAgDS3yFGZsotMbbMCM5Knymf4jNekwaX+iZe8s8LyBJUWX9BLhq9FDCJ4xgr1Q7LfmbWXuRkA
 hpWRNbjOuJnOwwTNv9qksWRziyg7kT2cgIP4oL8rJfPdiWltxwsifuUMr7Vxixd06zapWLxEMqT
 eVT3kNU6lWpffVZUkT7vtglEnyX8XB5BK1c1Do3hykN5GKoKnmzzzQ5CJZP9c4GNZrvvU3vJzp/
 WpP5S4LFL1DaxxImJqSDeqbnE4+EszYezeou41/CZ8Ciit3jva4+KWhMUHtczgyzdtz1IqSp/V5
 8BD2UEBmUI0YqUD4C7I4JSyPsWAPI5jk6o1UUWEZ66DleM37GR2aCsZX3+11lfRpjFwkQAIhVJ5
 +5SStE1oWT7CNoBpMX65/mbypUt0UIo7U8Nw
X-Received: by 2002:a05:6402:a207:10b0:6b1:bc2e:5d52 with SMTP id
 4fb4d7f45d1cf-6b432c0ead1mr3704575a12.3.1792758885666; 
 Fri, 23 Oct 2026 05:34:45 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b432c96badsm1007381a12.14.2026.10.23.05.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 05:34:45 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Fri, 23 Oct 2026 14:34:34 +0200
Message-ID: <20261023123436.1274448-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] openposix: Run the Open POSIX tests with kirk
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

Tested with kirk on arm64 in QEMU: 1735 tests, 1 failure
(pthread_rwlock_unlock_3-1).

Cheers,
Anders

Anders Roxell (2):
  openposix: Install the .args files
  openposix: Add runtest files for kirk

 testcases/open_posix_testsuite/Makefile       | 13 ++++++++-
 testcases/open_posix_testsuite/bin/Makefile   |  6 +++-
 .../open_posix_testsuite/bin/openposix_run.sh | 29 +++++++++++++++++++
 .../include/mk/config.mk.in                   |  3 ++
 .../scripts/generate-makefiles.sh             |  1 +
 .../scripts/generate-runtest.sh               | 29 +++++++++++++++++++
 6 files changed, 79 insertions(+), 2 deletions(-)
 create mode 100755 testcases/open_posix_testsuite/bin/openposix_run.sh
 create mode 100755 testcases/open_posix_testsuite/scripts/generate-runtest.sh

--
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
