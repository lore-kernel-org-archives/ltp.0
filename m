Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C02E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 04:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FF183C1BD1
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 05:56:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522ED3C185A
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:44 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E60A1BBBB91
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736398541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jrbn3dB+GmYcz7cNFUI5lgkCnojAgBTSRBBxhxZQUiM=;
 b=RU2SxKl5jGfenC/vssoOzS3WpE5P3brwWJec06jmBrnX+EJUyDHrSpuGnUvTUjq1mlBqf2
 90hUHSsOQ/1Ny81NyNk3VLCxozB31gik3cby2y2WEmuMoabx4kgPV9Xi+Q2iTdldW2Hnf9
 LSYB4VSEdYToeffYBkQw9yXBEJPC3Dw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Dvo4UABUOmuYCCH0AQjxbA-1; Wed,
 08 Jan 2025 23:55:39 -0500
X-MC-Unique: Dvo4UABUOmuYCCH0AQjxbA-1
X-Mimecast-MFC-AGG-ID: Dvo4UABUOmuYCCH0AQjxbA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A6FD1956083
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:39 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E66B019560AA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 12:55:28 +0800
Message-ID: <20250109045532.43017-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XW7PgJtA54OskupljW9bggGCZKoY8sI8lJZq6GTJf38_1736398539
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Refine overall timeout and runtime management
 in LTP
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

This patch series introduces a restructured approach to managing
timeouts and runtime limits in the LTP framework. The changes aim to
simplify timeout handling, improve clarity, and provide better
separation between the phases of a test (setup, execution, and cleanup).

The main updates include refining the description and usage of .timeout,
deprecating TST_UNLIMITED_RUNTIME, and introducing the tst_set_timeout()
function. Additionally, test cases that previously relied on .max_runtime
have been updated to adopt the revised logic, either by moving to .timeout
directly or transitioning to .runtime depending on their behavior.

The series ends with an update to the set_mempolicy01 test, demonstrating
the use of tst_set_timeout() to determine an upper bound for its execution.

CI job: https://github.com/wangli5665/ltp/actions/runs/12683826906/

Major changes V1 to V2:

  * Refined the description of .timeout usage and its relationship with .runtime.

  * Moved .max_runtime to .timeout directly for tests where runtime is not explicitly used.

  * Transitioned .max_runtime to .runtime for tests that call tst_remaining_runtime()
    or use the fuzzy_sync library.

  * Added the tst_set_timeout() function to allow test cases to set the overall
    timeout dynamically, particularly useful for tests that aim to determine
    upper execution bounds.

  * Updated set_mempolicy01 to make use of tst_set_timeout().


Li Wang (3):
  lib: redefine the overall timeout logic of test
  lib: add tst_set_timeout for reset entire timeout
  set_mempolicy01: make use of tst_set_timeout

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
