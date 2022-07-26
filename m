Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B312C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:14:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14C703C1D21
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:14:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F1543C0EF2
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:08 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F1F01A003F1
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:07 +0200 (CEST)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 170603F143
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873647;
 bh=/4QBePYw+HB6dnuTkaiGoKS1ntvZ+0QaYpzbVg81Dp8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=YchYvcRF+V2dzpcHGyAbBv4wSDBjZ4snivedzQ4CZIxoVFVl6A+y8VuhoWyYySffx
 XPaiiO+F5q4MN9WjrZl2qbWDFjjkI/g1d6Ifv3HdCW8os/VfJ4fQzhgmj4260MFGmx
 mO1qWPje8FCE04AfzbvoKztF5XzWUA3mQIs+/WhZN5Axsam8xXjWwwjR5grMYuOXZb
 APWRpjQOYpyYQkyF4/SIzeKUwmov3nSOvE58Wps49R+nDnC/pUWc75cMjXqcHegvhb
 A30g1BKW2qKYySdyvI2tI+EPvxKMgB7ocw6X+6GKoBkgWozvDSWuYIfw6wS181tPck
 rT7cU0KPJ4U5Q==
Received: by mail-pj1-f70.google.com with SMTP id
 g8-20020a17090a3c8800b001f2103a43d9so124326pjc.6
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc;
 bh=/4QBePYw+HB6dnuTkaiGoKS1ntvZ+0QaYpzbVg81Dp8=;
 b=m0yvAZOOQy0v4FsiR8PobDWbtqUiSq3VMQdRcX/rgIwLePtvZ5XaTfC6XBax2Mkt+C
 I5NUleMehjuMNcyxKVMDoRWWV++O0mIvRMfUSyi1NLnZz7moBj1/U1QfoVYt6RSPNwH6
 brjhBQRTPhLrpHqWJapycrRDErrHX5VUQ2hziLnDseK4LgWj9v7wwKAb8LWdtvQDOXzz
 TD9odh8/oqVrSOIrlkBYcUzBZCvZkupO/IzR+my5fwbLHdOUP9j2xicnCA7Nqnc+Xkvw
 MGjpL9MMp6+XA9pz4CtJzI+mURjEHaY5iOaGQD0ItXQWuNPcJ5CVqtPpI+ytz6u7qCo6
 Djlw==
X-Gm-Message-State: AJIora8EY48BP2gYvMcp0A0/vTF1Pkusw69AcuoSP81521etpZ8Ov8I+
 ghxtcQQtc00cMrtYHkuRSO/imAz3YJpLf4Le6NDmg5nNzNDDOkEp3XBXGUsWLJG6rh/9IBrTTCy
 aE6KU2vhnxmbHplA8VCkCmoVqehGu
X-Received: by 2002:a63:fc14:0:b0:419:d6c0:c79e with SMTP id
 j20-20020a63fc14000000b00419d6c0c79emr16465590pgi.493.1658873645440; 
 Tue, 26 Jul 2022 15:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u92DhiTAgN9DdPQ4ZHavVrsKpz94G5MBb7r8UiZ3B1x/3WufqnV2vttpx3ntKu5+RH49OkhQ==
X-Received: by 2002:a63:fc14:0:b0:419:d6c0:c79e with SMTP id
 j20-20020a63fc14000000b00419d6c0c79emr16465573pgi.493.1658873645133; 
 Tue, 26 Jul 2022 15:14:05 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:04 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:16 -0700
Message-Id: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 00/10] Expand cgroup_lib shell library
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

Update the remaining tests and shell library expansion after review.

Rebased off of accepted tst_cgroup changes in previous patchset version.

Luke Nowakowski-Krijger (10):
  testcases/lib: Implement tst_cgctl binary
  controllers: Expand cgroup_lib shell library
  controllers: Update cgroup_fj_* to use newer cgroup lib and test lib
  controllers: Update memcg_control_test to newer test lib and cgroup
    lib
  controllers: Update memcg/regression/* to new test and cgroup lib
  controllers: Update memcg_stress_test to use newer cgroup lib
  controllers: update memcg/functional to use newer cgroup lib
  controllers: Update pids.sh to use newer cgroup lib
  controllers: update cpuset_regression_test.sh to use newer cgroup lib
  controllers: update cgroup_regression_test to use newer cgroup lib

 .../cgroup/cgroup_regression_test.sh          |  31 +--
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 115 +++-------
 .../cgroup_fj/cgroup_fj_function.sh           | 173 ++++++++-------
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +--
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 171 ++++++++-------
 testcases/kernel/controllers/cgroup_lib.sh    | 137 ++++++++++--
 .../cpuset/cpuset_regression_test.sh          |  26 +--
 .../controllers/memcg/control/mem_process.c   |  28 +--
 .../memcg/control/memcg_control_test.sh       | 149 ++++---------
 .../memcg/functional/memcg_force_empty.sh     |   2 +-
 .../controllers/memcg/functional/memcg_lib.sh |  54 ++---
 .../memcg/regression/memcg_regression_test.sh | 203 +++++++++---------
 .../memcg/regression/memcg_test_1.c           |  40 ++--
 .../memcg/regression/memcg_test_2.c           |  24 +--
 .../memcg/regression/memcg_test_3.c           |  37 ++--
 .../memcg/regression/memcg_test_4.c           |  24 +--
 .../memcg/regression/memcg_test_4.sh          |  50 ++---
 .../memcg/stress/memcg_stress_test.sh         |  32 ++-
 testcases/kernel/controllers/pids/pids.sh     |  67 +-----
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_cgctl.c                     |  87 ++++++++
 21 files changed, 690 insertions(+), 786 deletions(-)
 create mode 100644 testcases/lib/tst_cgctl.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
