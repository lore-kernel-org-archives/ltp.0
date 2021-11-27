Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3520C433F5
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A07603C6AA0
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:59:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DF8B3C0148
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 13:16:20 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6A4F41A00905
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 13:16:20 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id x6so49831976edr.5
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 04:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+nj9jV2lQMIXZZJdB5d8+PoIN12sERoMrCMPTZV6n8g=;
 b=gfsLq+XwROqrV57TRhWf0xs3e4UPGZCKJsC1m7o4SFAPG2l29k1QgwWz2i5t/W50b5
 d24itI1dgYClTTiDDebDwlNjNmV221HVAwuKGgRuyLBIEkvL3/Tb01HRthdWAkrxgt2p
 IRUMYIS0nzPZsIzZm3L+82zIpJFFuCvnmjwjCLSdbQf5pqCkBPgIMvNcxzpWkVx4U9w7
 kVvTt68J5Ne+YJ7vyJAKaXGPoUI7RCRdWVMwtexeZuytBt+bJOdBk7f2Z9/o5eMlBAtm
 bgKQ8PpMr43c5AVkbH5HW6j8WxGX4h4kcgAwQgITTBgTyosbJ3qjxk4stnhDbTBaxxWt
 PaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+nj9jV2lQMIXZZJdB5d8+PoIN12sERoMrCMPTZV6n8g=;
 b=H/Ok8lOsFN+PnjQOGC97CntaEJFAsMxZqQ008nS9s96rzsqOs7q48e5gJt8yvvP217
 XMlaV5CAND1ZDbdXRlsQXaxsVJ0+ySNz/Ke19qSAVbEg/0Lmdb8EQi4HSsiTxBOATbum
 6dBIaKcrv8WSsrJ+gtbXm9MPZL0kIW9mNdthIALmsFHTW5PGFhjkHcqEaKIXcUxe9DbT
 ASqxeVRPpTMJs0O8r8eW3L4Y76gzuPc7csY1jI9C9o9fCSYVToE65EsqfZM686UunWC6
 oO8MFmIoALtgziGHq3PBNRqlJBOlRdLqFd32IFTKYlTJfAAN6GJEPkcUBwK8Ph9OTu6p
 WQ1Q==
X-Gm-Message-State: AOAM531x5pYabVAbTtarStW/p7vmdAkMmJyFWNNo2NvoKUMTFJzmbUaq
 dDHaB5e7xnHqHHoC6pHoXRjg1JWtFMh4+A==
X-Google-Smtp-Source: ABdhPJxpq0omGNa429utt6YZo+N7GbfrtKeP0322Vq7yKYfLxebBFO1XaO4FGiJUxu431JvC5wvYYw==
X-Received: by 2002:a17:907:72c7:: with SMTP id
 du7mr46171783ejc.424.1638015379680; 
 Sat, 27 Nov 2021 04:16:19 -0800 (PST)
Received: from sagi.lan ([2a0d:6fc0:228:b100:d1db:6ddc:e3d7:8c4f])
 by smtp.googlemail.com with ESMTPSA id m15sm5469776edl.22.2021.11.27.04.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Nov 2021 04:16:19 -0800 (PST)
From: Sagi Nakash <saginakash@gmail.com>
To: 
Date: Sat, 27 Nov 2021 14:16:09 +0200
Message-Id: <20211127121609.26837-1-saginakash@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:58:40 +0100
Subject: [LTP] [RFC PATCH] ltp-pan: Report failure if testcases failed to run
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
Cc: Sagi Nakash <saginakash@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In case a test fails to run in run_child() for some reason (signaled via
SIGTERM/SIGTOP, execve() failure, etc.), runltp still reports success:
"INFO: ltp-pan reported all tests PASS".

Failed tests are reported via check_pids(), by checking their exit
status, yet it doesn't catch tests which weren't able to run at all.

exit_stat holds the exit status code: 0 in case of success in all tests,
otherwise, the number of failed tests.

Fix this by increasing exit_stat also when a test fails to run.

Signed-off-by: Sagi Nakash <saginakash@gmail.com>
---
 pan/ltp-pan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 0bdb51477..eff9a867d 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -551,6 +551,8 @@ int main(int argc, char **argv)
 				++num_active;
 			if ((cpid != -1 || sequential) && starts > 0)
 				--starts;
+			if (cpid == -1 && track_exit_stats)
+				exit_stat++;
 
 			if (sequential)
 				if (++c >= coll->cnt)
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
