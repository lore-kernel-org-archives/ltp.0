Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5BBCD8CAB
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BC4B3E6F94
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:37:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B3F3C9A7C
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 17AF860005C
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:37:07 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2366674f8f.3
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780929426; x=1781534226; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/IFgwpE6BJNZrcIHFwGiwSm9GVCxdtOgQKoeRFqq5FU=;
 b=Ld/ZKoHnhNekAe38IfuUVea/tmwSIEgHoa6mqhWAuOgL5sjCjAV/G437/B6aevcVK9
 bqH2fRa15TblV+7cttLmAZX+ZAJ+VObo3KqQu/AuTIB3+g+kD29s3JZGzyhVDGgeFhjG
 9+XR0sca36Xm2BZIsz80IJi8qYIEaKy81g4EZck9guTG0mWhMdqFMoOnE1cmRZce0jXu
 Tsdlsg3FN+mgJiN5wZbDEfDAvvi3iQKxd640XW0BHmdHZn5Ip1Jzykok6bmTGKAig3S1
 rNAy2jyfh7f2NIXtuQGeHYQo4BMZBophnt+SKi9q9bQXS0Rp+Q7FY032ix3Rd+IOIJlp
 Q2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780929426; x=1781534226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IFgwpE6BJNZrcIHFwGiwSm9GVCxdtOgQKoeRFqq5FU=;
 b=BppKlFe/07SIZGbM05SfAfaqonzM5jeicj8QC+yVTDVCCDBsk2MX/uTblzMK30chkS
 QirP9ZFrzKjmpcx/9tBjtbqvT5qTRadHzOqO0Wi/HuYnoMuWsLVWz788DGoJ9tjLJ14d
 EQeC7PQVuSrTaanjZZMt6605bRKV+ZCyVAV7F4OXgs5a6pR03xNl1RRWGdEfVHsrCK1g
 WKwg02xbIiwZEOqu2k0FdKNEGAX4O61unH+pyaepm0Q9e1ssDfrrtgW0pmMOiymZK5NN
 URXDi7zkVI0pmW0x6hzR7D5qqE7QhMGHtyLZQX13/LZFaaIxObBkzh3uI2h3jqTSVvWz
 xO5Q==
X-Gm-Message-State: AOJu0YwJhohz01NOb/+bcES5J6RHAH5CpV7pZBOyvR5JJ5xpkJbJ5FGw
 kDV85AdK2zaXFuZdllLaYAMf8QnyaWvcyjAfmEHfhT4CRmcl9BZH/qk5OdOAgQ==
X-Gm-Gg: Acq92OFlwmxgQhuxQ6ZqHU3zRj3SB6KA57RUeznvV+JHMExA8gyXiUmdwQXDyxnp64w
 lS72M9V1U9uO2QfUxEyc/AN0VMOG8QxcTO76iHR+FG0HD1dtgP0FwsIHOkQasx1iLnQwr9SWeA3
 24RR15SgXRiGjadPW61c6wYJzZ2dnqMrDEAnWI6gufCACn+7vRo26O9o9dXfrjX+b2UwjyB6qao
 eId16W0bHyqxtANvFVA5tZxB790u9iEoBhb8sCJMq5WP3Or3A0jcFzC6xGjKZqMcwxIPB99veBi
 ifiZ2in6Llgl61A5z6HkbbhpWL1A0gFtleWvYJOwUhk2klwcAjK9TIuV46eu0J6vRAxogUy8EiG
 M73BHEtqU3ohTBygfdDVozyqm2DfAr+5B4IeTx5RL/B7v/hD7bCGaP8/nSDvOEYd2sVZfHWl54L
 77+0WMyrHvwAcVWady8r/RwK5JkEB/xj0K9wbxiopcaECKPRFTLTa2x+1/WMkwEzo5x3VzedKaf
 je9DgGU
X-Received: by 2002:a5d:44c5:0:b0:45e:f188:393d with SMTP id
 ffacd0b85a97d-4603061b1bemr17746996f8f.29.1780929426257; 
 Mon, 08 Jun 2026 07:37:06 -0700 (PDT)
Received: from localhost.suse.org ([37.109.163.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f34413csm52180854f8f.21.2026.06.08.07.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:37:05 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Mon,  8 Jun 2026 16:36:49 +0200
Message-ID: <20260608143652.6356-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] io_uring: Fix user_data misuse and align helpers
 with liburing API
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The existing io_uring_common.h helpers had a fundamental correctness bug:
user_data was set to the opcode value. user_data is returned verbatim in the
CQE and is the only mechanism for correlating a completion back to its
submission - setting it to the opcode is meaningless.

Another problem was that the old helpers coupled submission and completion
into a single call, making it impossible to submit multiple SQEs before
waiting. The fix is to separate the two concerns - which is exactly what
liburing does. Modelling the new helpers after liburing's API is therefore
the natural choice: io_uring_get_sqe(), io_uring_prep_rw(),
io_uring_prep_read/write/readv/writev(), io_uring_sqe_set_data64(),
io_uring_submit(), io_uring_wait_cqe(), io_uring_cqe_seen(). The caller is
now responsible for setting user_data explicitly at the call site.

An open question worth discussing: why model after liburing rather than take
it as a direct dependency? liburing is well-tested, so we might use it directly.

This series takes the conservative path - a small self-contained wrapper in
a header - to keep LTP free of the external dependency. If the consensus is
that liburing should be a proper LTP dependency, these helpers could be
removed in favour of linking against it directly otherwise we shall
review those and make them good enough to merge, so the io)uring tests
are funcationally correct.

Patches:
  1/3 - Redesign io_uring_common.h helpers
  2/3 - Update io_uring01 to use new helpers
  3/3 - Update io_uring03 to use new helpers

Sebastian Chlad (3):
  io_uring: Redesign common helpers to follow liburing API conventions
  io_uring01: Update to use new io_uring_common.h helpers
  io_uring03: Update to use new io_uring_common.h helpers

 .../kernel/syscalls/io_uring/io_uring01.c     |  64 +++---
 .../kernel/syscalls/io_uring/io_uring03.c     |  77 +++++--
 .../syscalls/io_uring/io_uring_common.h       | 193 ++++++++----------
 3 files changed, 171 insertions(+), 163 deletions(-)


base-commit: 2ec3ac0f96fd3d80f1f44630ec8e399e4ab1f51c
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
