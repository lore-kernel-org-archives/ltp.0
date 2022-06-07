Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1EC433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 08:30:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B97A73C9188
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 10:30:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FD953C0895
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 00:18:31 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 832AB1000950
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 00:18:30 +0200 (CEST)
Received: by mail-pj1-x102e.google.com with SMTP id e24so16918223pjt.0
 for <ltp@lists.linux.it>; Tue, 07 Jun 2022 15:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QjWhYAIck0B+prMafRHntt3bLismQ6kOqKOMO119oY=;
 b=QpG9YI+p8wys8iMNroCwiNn3PWH+m96gVTFF/8cijC+HWOhATNx5A50YzpMenJHXdZ
 Tc0MOgArFY7BsESVZdgnHMpWt2TaeOnQ0Z4cQb6RLe5GEqJ0Tf0xkwmBRP/v1RnT9M5o
 7VLsm745KaiwNOzwVNihfBPFTua9dakzCDT8Kf71+R1F4X8C/qNxqXzOuUZc1/ZGsdko
 od0hfivqrEXRtRN4BI3eup8OVdOPmtQNeI2Djk/vnBeeE3sixBj+djMAaapMM2nCm4J6
 OtUaY1ij6w0uKVwjqHDbtG0u07d7Ygf9Vr0Ir8bsEQ0bGNKp2NJV0WPRdwMyDH7vamve
 xeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QjWhYAIck0B+prMafRHntt3bLismQ6kOqKOMO119oY=;
 b=BST5P5+jBby+NvfoY7omE+LmmyYw+lj2HA4qoUPeOmxbzPgnJBLnnpEcH0rBrNaYdE
 OVC9DhqfyR8JsiLCCLemOIsBsTUFNtdNlYzHv4yw8jahXccj7gWetMili49SxYV1ePfm
 4C4o1OID6i6sbv8Zem9dIw2fjr1CzpFx3zoRJKH5ZqRZQnhkzVAdCL/No4Frcv6whsjq
 RBPuRJjFJx5uh3oXcHjbgXZ6bLORFnfKgtVGbngqqU2O3gqebxrTwlRoMOlziBXNv0DO
 C2PhIiKexYgwtP1ZZ8/IN5vKEfQBXKEqF9QNnPjGJKIWxOgsHlfuT2z81jj1irUQNf12
 vuBQ==
X-Gm-Message-State: AOAM532ff6l5VXuk7IoARwOYkYLxPbReiD441YARXGZ8YBPB53UJ25NV
 3W5xR3jox70vxqUmowRd7JZQ538jaSc=
X-Google-Smtp-Source: ABdhPJygBovanCIc4m5pLbO6dVxl7WzcEK56j/E0oJhhL25YYqjN6+0c0ZprrxYmDoTV8Z9O34YDfw==
X-Received: by 2002:a17:902:bb90:b0:156:2c05:b34f with SMTP id
 m16-20020a170902bb9000b001562c05b34fmr31554045pls.53.1654640308246; 
 Tue, 07 Jun 2022 15:18:28 -0700 (PDT)
Received: from ubuntu.localdomain (nat61-196.net.kcls.org. [206.188.61.196])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a17090331c900b0016796cdd802sm1985048ple.19.2022.06.07.15.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 15:18:27 -0700 (PDT)
From: shatur.linux@gmail.com
X-Google-Original-From: sturlapati@vmware.com
To: ltp@lists.linux.it
Date: Tue,  7 Jun 2022 15:18:16 -0700
Message-Id: <20220607221816.50955-1-sturlapati@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Jun 2022 10:30:07 +0200
Subject: [LTP] [PATCH] run-posix-option-group-test.sh: Log and exit if one
 attempts to run tests without compiling
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
Cc: shatur.linux@gmail.com, sturlapati@vmware.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Sharan Turlapati <sturlapati@vmware.com>

Currently, run-posix-option-group-test.sh erroneously
logs "***Tests Completed***" when no test has actually run if the script is invoked
to run without actually compiling the tests.

Check if the .run-test files actually exist before attempting to run them.
If not found, log a message indicating the problem and suggest to check if
the tests were compiled. Exit the script without attempting to run other
tests.

Signed-off-by: Sharan Turlapati <sturlapati@vmware.com>
---
 .../bin/run-posix-option-group-test.sh              | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
index 0d4c9bd80..56773f0f0 100755
--- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
+++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
@@ -22,9 +22,16 @@ EOF
 
 run_option_group_tests()
 {
-	for test_script in $(find $1 -name '*.run-test' | sort); do
-		(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
-	done
+	list_of_tests=`find $1 -name '*.run-test' | sort`
+	if [[ -n $list_of_tests ]]
+	then
+		for test_script in $list_of_tests; do
+			(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
+		done
+	else
+		echo ".run-test files not found under $1. Were the tests compiled?"
+		exit 1
+	fi
 }
 
 case $1 in
-- 
2.19.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
