Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96997C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 08:30:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 799A83C9179
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 10:30:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 680DF3C0895
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 00:09:14 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9F54600949
 for <ltp@lists.linux.it>; Wed,  8 Jun 2022 00:09:13 +0200 (CEST)
Received: by mail-pf1-x431.google.com with SMTP id c196so16708746pfb.1
 for <ltp@lists.linux.it>; Tue, 07 Jun 2022 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QjWhYAIck0B+prMafRHntt3bLismQ6kOqKOMO119oY=;
 b=P3uqCBCP3vl74plVRIMe3vomhE+kevTLvtbnTjVPWJstfLqsHc9oZFlA5CLCfh0ker
 buHeIyV2+uWljEUYoy3ojnj+bL72cg7t8XzcmCYHn5YJjqqfmIl4X5OKTEuxAA4z3z8y
 k77ON7eNjhlTeLAjVVzMjRkNkCB1Kx3vcwN9nrb+amVWWNrusvxw1I3SuMQcmqaldR2J
 p20nBW1bN1+i4TjC5mymcvmuLrkM5PkLw0JacO2ckGjpv2L/ddNFPzQ7LuqNnGbSPBlF
 2Nkvut7iJVbS53hq+az9/8jPyYBqDHjevGOEfN56fOEI7EE4SSYRBOrPjDMHsIWuCU1n
 j5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1QjWhYAIck0B+prMafRHntt3bLismQ6kOqKOMO119oY=;
 b=ai7Kf+/qVlJIQv2gZpf20ZelQUDjFZoJqyBXwF8MO0ilOgnJvc/Jjblcr6O64CJ9al
 Ot5s17umbhsRLSR4vavxl97VxVhbxZugLTuyyDqbTVgfFrnhTOSBhx4ZmJrUxd3Tr7s2
 LPbQpZ7E9/cZcntOw+PsIlaYi6VM1RqkUZWNMmb3s2DszIlOyqQEiXLF6ajM6blxI6J6
 ZSZx3y1bd/AB0/NBT4YR0TyyYrzALZVlJ0FEkP0E6NXxrowjzULmAqmycrt1p0He04ES
 tzvhebNWd+tSGeFbMhPL1eOwYn0hO4N8meiTLS0B/nXUwS9MarKc7s6jNZovfN5bTLDE
 IuLw==
X-Gm-Message-State: AOAM530QryN1DZh+id4PuNyfqApnci1Ta7eetbh8ut6RzadMT6JC2JYi
 c/K4AJK9AxsiD3pKBP43E+apk07Y0P8=
X-Google-Smtp-Source: ABdhPJzcXP/Y5crXVTr+ZFUi7YsKUWCLseRwQQGb6kqWzeIUvxHTy7r0FR70yCjghzTK4sNH/X3zgA==
X-Received: by 2002:a65:6d16:0:b0:3c1:b056:5f5a with SMTP id
 bf22-20020a656d16000000b003c1b0565f5amr27048626pgb.469.1654639751558; 
 Tue, 07 Jun 2022 15:09:11 -0700 (PDT)
Received: from ubuntu.localdomain (nat61-196.net.kcls.org. [206.188.61.196])
 by smtp.gmail.com with ESMTPSA id
 bb7-20020a170902bc8700b001624dab05edsm13067099plb.8.2022.06.07.15.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jun 2022 15:09:10 -0700 (PDT)
From: shatur.linux@gmail.com
X-Google-Original-From: sturlapati@vmware.com
To: ltp@lists.linux.it
Date: Tue,  7 Jun 2022 15:08:53 -0700
Message-Id: <20220607220853.50868-1-sturlapati@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
