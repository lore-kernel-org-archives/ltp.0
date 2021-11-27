Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36240C433F5
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 00:04:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8A23C8AA2
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 01:04:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9448C3C87CF
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:31 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DEAC060090B
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:30 +0100 (CET)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F34373F1BF
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637971469;
 bh=0ydUpvpouNSrfd8tvR8gMXRg8RwmnJaG+74V11ZnoJs=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=tCm9QfQ+pJwHCKXveoxu3PnAAiM88Dul3Y/oP5BqAveAr4OchgKd4Jzn3C6XtCd6s
 1cvckaZxI1xs1m8UnEX5hUDxT3lmS7ftb120omXBtx4+XXsPNm9MgxzrAtuyaSW9Ng
 JH/97i8j4Whkwar7elif4H4Q/8zfBX6QeMJb/WdblVklJso+jyQqXu3nMzC2V4FBnC
 TRtfhLPbk9FkUd0GqdB/ATTfEkRrZSbzgMdMUxPlzOPXHwACeBT9ZPbAe1OZ1l+NpP
 YGhX1ntf8Roklo1JEaEXyrNQs6ZsjemSMEQ3Q8txEAapc3KSOzlJmCk0vB4rnmdFYG
 ye4adhjyguAWQ==
Received: by mail-pl1-f200.google.com with SMTP id
 4-20020a170902c20400b0014381f710d5so4687292pll.11
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 16:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ydUpvpouNSrfd8tvR8gMXRg8RwmnJaG+74V11ZnoJs=;
 b=Wxv8exNL8DFW7Um5vutm8JQ1A0sEJ6EmD64ODAo8T0FLt2wjFobZniOefRlvT3AbwM
 eJ8p+MPSaKkVgROcIXAt7j5acuXmmtEUs9OsB1KvPzH4txtpY3wUiCXxF4zdDQzQPHp5
 7P+5yZDDaq+gkv1oSpzcOTKjsjqWJ1QW9PpR8ZKiXd7BP04JLviqsMExMrmhXcKnL0Mp
 3sQ+GsWcKfmClay5P1trMS/wtUNXvhwmOVdqJX1zaqnUCHaPnThNRV3uV+SAYcJ6VG0z
 FW+JYR1DddGqkYdsj0ssg9WP4GyhkKdzEoIYcHbqyWjdQSyf+NCnThW0MY7TYzRIBTsp
 JP2w==
X-Gm-Message-State: AOAM5317pTf9l/Qq36oI+FHqdrVHsolFmfL2yk7jFF65AiK25iqHWx+Y
 e+M07YaCmMt7PSQ8CYwXYRZE1uD9l+8FQur88gU5oL9b5ATW/3lCjdC3bb/sA9ere1CHlyx6vEM
 EpGi9XVpVSEvAXKWCF8nZfxmEQvLI
X-Received: by 2002:a05:6a00:1903:b0:47c:34c1:c6b6 with SMTP id
 y3-20020a056a00190300b0047c34c1c6b6mr23705943pfi.17.1637971467370; 
 Fri, 26 Nov 2021 16:04:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5cKiG6YTFAH43P9rPeoxPxJYN3OxvX8jZLKA49JhKrljoSa0IGeBi+SzCG+xmrY0YsD7w4w==
X-Received: by 2002:a05:6a00:1903:b0:47c:34c1:c6b6 with SMTP id
 y3-20020a056a00190300b0047c34c1c6b6mr23705884pfi.17.1637971466728; 
 Fri, 26 Nov 2021 16:04:26 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id d3sm8598125pfv.57.2021.11.26.16.04.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 16:04:26 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 26 Nov 2021 16:04:21 -0800
Message-Id: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Update cgroup_fj and memcg controller tests to
 work under cgroup2
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

These tests were only testing for controllers under cgroup1. Now that
many controllers are being mounted under cgroup2 by default, we should
update these tests to test things where they make sense and at least
report something when they don't.

Luke Nowakowski-Krijger (4):
  controllers/memcg: update stress test to work under cgroup2
  controllers/memcg: Skip functional tests when mounted under cgroup2
    hierarchy
  controllers/cgroup_fj: Update cgroup_fj_common to work under cgroup2
  controllers/cgroup_fj: Update cgroup_fj_function to work under cgroup2

 .../controllers/cgroup_fj/cgroup_fj_common.sh | 73 +++++++++++++------
 .../cgroup_fj/cgroup_fj_function.sh           | 38 +++++++++-
 .../controllers/memcg/functional/memcg_lib.sh |  8 ++
 .../memcg/stress/memcg_stress_test.sh         | 73 ++++++++++++++-----
 4 files changed, 148 insertions(+), 44 deletions(-)

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
