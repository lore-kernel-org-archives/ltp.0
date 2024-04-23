Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A674EC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961369; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=nqaagS2Wl3i9yM93JcdIxbMSzaq/BE2s6+49mFb1TKA=;
 b=jWXewYAszeK2cef3RXaFEhM8k6eWwpOmSTvzY/F3D6JhALetYMYzxdcQHxkJZqbZnv/J9
 CbUiFTxdTu1zUwhlbTDb5oo8FDCj1jaXrlMc6L9HF8sdIvURMzlw9YBuI23h8WZGHNlfwpT
 Iaetywqf0yxKQlJ13X+SKKd1KT0oyZU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 293CC3D0036
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:22:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 516823CFA6F
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:28 +0200 (CEST)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 555502005D6
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:28 +0200 (CEST)
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1e3c2fbc920so2185335ad.0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913107; x=1714517907; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IBcDGjWKXokMjPsghOEAM9h/qxapVnoPg0MA16oLO+A=;
 b=fGRig12TDn62WF8GwQNjClz6Bb/oEK4EDXKeyqYnvUZXR3tZiy7X/+ZaLn7/oVrkRQ
 hsUGUqiq5ecFfuZCLQOTjitvEMM8D4A+Mvkvl4xe/5hA4wgJ1W34c5QQMHSrlwtjy5T9
 183og2eTFdInnokY6I891I65FbTgcRYapmrTssJszzq9S4OTGbDPOW7HgOn9GTe6OSGk
 0iYs8vUzj71bRY+fS708DH1TW+1GZ2tYK1kVjrWMpLipWOU5i36a7HphkLAmFUsV+nia
 m6J6RhcGMcCtJodIG2IT9gZNWcqiAShFl01Pbu0kMWJkYiNG+tsg4BFYNArkAMIio9Ei
 4BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913107; x=1714517907;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBcDGjWKXokMjPsghOEAM9h/qxapVnoPg0MA16oLO+A=;
 b=paHNSdQxIkydpH13wMueXf2Bkrd3h2cYv8d7mK/ottkr6wO5FDDz4ALqzlpXm48d3g
 LH/0axYPdbgKjoKOqk7d3zqtdwClzZvocUZGraPJMziWDgn2SuExGU8p20sTUg2P+e7n
 B3Aqv737c+toVuhz/F2xVCQfDuqa3W4Qi+wMTmBC3GhI3iDKQN5x+5FK/jUaUbR2CL0H
 npOHex3NFEVJiuHTkm7huK8wGJd2RF+hCX8IiVwz5gM7KWPGzALkkqBDhUp12I5F6J9F
 CjKbBpnShVg5XXxpZX/QetL0c1659lhJmLyBjrl4q2198mY9PlgxK1nJx1yojFc3AzME
 Df1Q==
X-Gm-Message-State: AOJu0Yz5Y/FKpU3wH4DTiMHUt6uZGlj3raWhe5OC16UA2PnrXD9knQoo
 ClKLqrzjVOHM/Bkf9Q9j0XF09fd+aFly+6aPX0Lkp++XgDC5lOxPWVw8YkMLvAExtY638IsCY9J
 krlMUyOBlLlqK1QBIYARCIbitBGlFabSvrMAfLkX6DfZFE29Isxv9a3X2oJarKiMOUktVAPVLuu
 jrZBJOBXSwm4XkB4d+Fw+ldqyF1UxCVm4=
X-Google-Smtp-Source: AGHT+IGpKjKTJQ2Ews2jKk4AIIorRKEpX8URIejrQPEyhkajXBx19wSSI4rf/7riRetx590XxJkNWVi1/DH1
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:8486:b0:1e5:56e8:7bbd with SMTP id
 c6-20020a170902848600b001e556e87bbdmr14288plo.1.1713913106142; Tue, 23 Apr
 2024 15:58:26 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:57:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-1-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 0/6] sched_football: Re-add crazy fans and other
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

Feedback would be appreciated!

thanks
-john

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>

John Stultz (6):
  sched_football: Drop use of sched_yeild()
  sched_football: Use atomic for ball
  sched_football: Re-add the crazy fans to interrupt everyone
  sched_football: Add a sleep before the game begins to get into steady
    state
  sched_football: Add prctrl calls to set thread comms
  sched_football: Add trace_marker messages if we're tracing

 .../func/sched_football/sched_football.c      | 94 +++++++++++++++----
 1 file changed, 78 insertions(+), 16 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
