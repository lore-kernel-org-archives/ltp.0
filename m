Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9AFC2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359629; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=pt4oxhOYHq+roh4fcPrvZrwU9SLk0wwiGb0lQQR+I30=;
 b=YSatm5uyrT8iwAeBaIDXOSTUM5HgtCn0IH1hz98L23YZ6cYD0UHqz78+ffxg0o/738QMS
 PPYOXKiD9ULDaYAIdumof2Lt7rk1Yurbrd2nWqCavPwmCc6Q2r0elv4l2+B91qsGBocZj9g
 blqw4lPevMhTA7qvniBp6+m6DttDZbA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59A773D1124
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:53:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8183A3C13C2
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:54 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 53A36207A1D
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:54 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-62d032a07a9so130009197b3.2
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359573; x=1719964373; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6rUeoyw6De79UbaVsSkcPAc2s0bQpp/qhH5Vzw9W/Uc=;
 b=RFQR7ybKp2CzYjAxUcNEuC6zUoA6BP6YSoOSkzl6LlERMQI2euV+zYTPbxE7dnfiqU
 1jXwTnx7EES343nGHgVpX3WJ/vJTZusKSlCDAQ7wvVSIHkz19QwvTs/Cp1XiVAKI+JX5
 69Z/Ss0RJH60U3hpLpn1UutavgpjWvGWimZWVGDpGUO1xtvnpW/AONZpinGttfrunjDU
 ZGFfTWj9jtSi9hExYPSm3elEDwT2qgQ/u8s8BM7eG3v7hiML4KH7WU7J0tkpHGpz+o6J
 kWgz/x+D04bjKaPwSlbKGOdOYNmrVA7hMLLlZiaq3Kd75+Al5c1grSndIc/bL+ZGOpXP
 LoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359573; x=1719964373;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6rUeoyw6De79UbaVsSkcPAc2s0bQpp/qhH5Vzw9W/Uc=;
 b=hc8sl+IT369tyrMTAtwzSoImdFQiQwBUI6W+dXhwtXmJl84fcO6KGyC7szsRQDHXTU
 jBPFjkExNF1nFUJVinOg6R+ztaNY7vsOSBBL7mbEmETlxfmr3N8KCTzw2zm55EiBXPD+
 exyD5iFGRN+qLSGB/BXVPjELYISSOVnkumcg8ZcWJfVe+hSXCgxP+R65a0XTZu2ntuhC
 YzxW17CYvWv1madLlWL16MRzvlOwkt9TOSubRxY9sEc2zfiC/Ijzttc12PlHSkf7nizo
 w5Cok55CeVmnqhYbLRGIC/LXCC0IL9aXAyU8mGllgJoJfHY1GO3R+4fY6oiUSW/gQWzV
 8KKQ==
X-Gm-Message-State: AOJu0YyGc8Olsx4FM90PWruUL3uOj25H1RMRtqsIUmEvHq/o7ukgj957
 e7bqwcjpoufJCM+Y8JRsyykqJ5+DOJW1X0gJY7UKAlQJVWaYZNI1UnwjA7Uv3iIe3o/HjN0f3wK
 KMCKVjXuO5EW7VdPZTb5GV66IqJm+c5JRlDyh/YgjcpIw1QzCnL5eFQ+kYyvE3oR81YzqxMW+U0
 DHIS3AHrNDfQeBlAmBNDqB1b9CRu4IR3E=
X-Google-Smtp-Source: AGHT+IH6AsZf0Z4nUPiQxNm9fCSt+O9m3Nsh+vwZ0GTyH85Zo/0k/xRlHsFk17SSS4KY5GI3/xVlxhYDSNEq
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:a94:b0:62d:fbf:920a with SMTP id
 00721157ae682-643ad6bc2d7mr1336927b3.10.1719359572531; Tue, 25 Jun 2024
 16:52:52 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-1-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] sched_football: Re-add crazy fans and other
 cleanups
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Just the other day (~18 years ago), I had implemented the
sched_football test to validate the RT scheduling invariant that
we always run the top NR_CPU priority tasks at any time.

That early version of the test included crazy fans, which
disrupted the scheduling of the defensive threads. This was
later removed from the test, likely due to occasional failures
seen with it.

Recently, in testing the behavior of a scheduler patch I was
working on I started tinkering with this test again, and found
when I re-added the crazy fans, I could reproduce an actual
scheduling problem with the vanilla kernel.

So I wanted to submit these changes to re-add the crazy fans
along with some other cleanups and improvements to make it
easier to use with tracing, so that the test can be used by
others to reproduce this problem.

New in v2 (thank you for the feedback!):
* Rework to use tst_atomic* methods instead of atomic_t
  suggested by Cyril
* Remove unused variables
* Drop changelog comment as suggested by Cyril
* Rework to use tst_atomic_* functions as suggested by Cyril
* Rework to use tst_timespec* functions as suggested by Cyril
* Pulled trace marker writing out into librttest helper functions
  as suggested by Cyril

thanks
-john

Cc: kernel-team@android.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>


John Stultz (6):
  sched_football: Drop use of sched_yeild()
  sched_football: Use atomic operations for ball
  sched_football: Re-add the crazy fans to interrupt everyone
  sched_football: Add a sleep before the game begins to get into steady
    state
  sched_football: Add prctrl calls to set thread comms
  sched_football: Add trace_marker messages if we're tracing

 .../func/sched_football/sched_football.c      | 95 +++++++++++++++----
 testcases/realtime/include/librttest.h        | 13 +++
 testcases/realtime/lib/librttest.c            | 32 +++++++
 3 files changed, 119 insertions(+), 21 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
