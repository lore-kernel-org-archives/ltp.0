Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D386CC27C54
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717695605; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=aXF5s26L/tvK9crKJUnU3XCAXRA6gTnXJm4Q2Wzszig=;
 b=afSPyHwZEvB0vogKgNTHy2QMsU5fnLt2+8kCSLVjWIy08cXyCbHMf2nNqTtpGl3pohMR/
 LaWGU02pGm5hdbvTDhAYXlM9Y7HeY5+Zm4O5SGsl7Wcbz5Ag4d1WvV4lzO3HnTfL/6DHKQq
 bBZgSXBS1sQfDpugcM+CF+OrvFaREqE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 481E43D0A7D
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:40:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7AE73C04BB
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:43 +0200 (CEST)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDC601401701
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:39:42 +0200 (CEST)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-6cc288a7ee6so1735753a12.1
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717695581; x=1718300381; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tyWGy2xfiD0oR7mq4S4jVG1vHlW49mtP2/FequSwW3Y=;
 b=i9J2uqfkfC/k6XGh4W5d5IxNW+MTelRlwnJV8bJlUylbEo7CAviw1uitEHKwCFGPg+
 oiTZpZ59/ozfHYBIx1pokusJEkIblMEzX7XAl8VDwq7YVM6jXTSQ5NzjB9GDGsRUQYNx
 JiSi7Cfd6SAx02qacDYcoRQQz+RFd9qu/xgpyXpU5dCgsdPdHD8l+OZ5CL8QWEsbsQBf
 pHBBWV2jx3V/FMNf3TZXrd9GynSyZGCT9dsGEu7omJDpXAulQsZpG91QINbrE4GsuCjr
 z9mGMDHa2/gysRCTMkAwzc+Cr+IJx/COU3Eqvhgq1bablWBxcERv7l9oJZ48kxWZjwqw
 J8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717695581; x=1718300381;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tyWGy2xfiD0oR7mq4S4jVG1vHlW49mtP2/FequSwW3Y=;
 b=e9curX4qYoq8c6VSCZ2sBLsNhTArQ5Dhic7e8at5gXZRwLFpB2vxAQ47VzQAOkh7d5
 wi8rQIyZhd3BVoSscz+VyTPPwXGjZINqkM2Ci5lueF3dd/btfkBAnpxhgt/Ho3UQmKqT
 iPScy3YWvXj82JVv/FGPldazZrMwzsYSYa/0il3digI2MU0SQKdrAN/kZCpDYJB+UYXs
 /lArQ9cvrnXzoYNIUJ6J/5SUx5mq4sKPq0CP1ogDdI6eQevWqfUjhiIgP3ffNgWmAceC
 7JVxF3/Nv4hbk5mbmtQnlLuYRkULQH0iUklMQqwFMFdjzSKfV4Cggn+KJNf1/+ygMyx8
 OrBw==
X-Gm-Message-State: AOJu0YzpoeVhFsZ00QqsRlkeqiRzlpobku72rAVe2ZbLoM1MKKjzktRn
 E707y+TY4mz+1dQAMSR9wt9p1nt4diABeoq5MxVt7u3OjQiBh5o78V6rcZ2y0YUM5FvRF11aSdV
 iPahqzITMbQYlPv8x5AeqE7zs+Tt75mNt/WWn/moV6Imv+yRtJjYfvyDAIHWyJwlER7jeDlH0kD
 +Nv6Y4UtgIXkhDGkCPrq3F8wuWJK0=
X-Google-Smtp-Source: AGHT+IGXIJ0jaa/Fvqgj/IaduBUQwwJblIsZd7Ly7JBr2k3SD9230rfRF3Ig+LHG3Iyb3aaQD+5oMHkAGHo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e74e:b0:1f4:70e9:f732 with SMTP id
 d9443c01a7336-1f6d0248678mr228055ad.6.1717695580758; Thu, 06 Jun 2024
 10:39:40 -0700 (PDT)
Date: Thu,  6 Jun 2024 17:39:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606173933.1671989-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] sched/starvation: Choose from available cpus
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The starvation test was failing as a 32bit test for some arm
architectures where cpu 0 cpu 0 does not support 32bit applications.

v1: https://lore.kernel.org/ltp/20240605180536.1288027-1-edliaw@google.com/

v2: https://lore.kernel.org/ltp/20240606014022.1425928-1-edliaw@google.com/
Made these substitutions based on Wei's suggestions:
s/TST_EXP_POSITIVE/TST_EXP_PASS
s/TCONF/TBROK

v3:
Substituted test macros with check based on Petr's suggestions.
Split commit into two: one to fix the return code check on
sched_setaffinity.

Edward Liaw (1):
  sched/starvation: Fix sched_setaffinity return check

Edward Liaw via ltp (1):
  sched/starvation: Choose from available cpus

 .../kernel/sched/cfs-scheduler/starvation.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--
2.45.2.505.gda0bf45e8d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
