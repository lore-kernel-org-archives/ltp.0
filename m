Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED2CCFA13
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 00:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762475499; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=wvWmNsbVZfuLLSlyLGguIC8KWBqC0SgQAvwz3cQD1uU=;
 b=Lc+txLj33Vxt7GigHnAQ+PXo1avnHb+myRKPQa1uDe6PAj8cKsmYNjiWX8dRWHtN4SjLB
 WULrQm+zt5Boz+bM/Pvre0guMt6ndyeHB/+FUQ/wjuo7w325WieAjVbjHnP0wCEbWg4wVQc
 sdxBtOQSCa0Mf2HxZQaWn0XG1gYiFH0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F57E3CED5B
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 01:31:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 771CD3C6EAC
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:51 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8814A14010EF
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 01:30:50 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-641458f71ffso57337a12.3
 for <ltp@lists.linux.it>; Thu, 06 Nov 2025 16:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762475450; x=1763080250; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VODoYlZ+VnXjNzrxPOxrQoV4Ehcrlg7pX0YQE4uVgZ4=;
 b=aZ7Fdz3hC7hLQuYUhfzFEZksqcEf7aYHhDASqHOWI4xH1HqZoT24XtZc5uRPa83MWv
 SuAOMUIwG4VpCxEQowGNvOCkXrNrLNf/ob0NsStOQcUIOOgLI79ekPhA7I/JBKAUvsq0
 Jor9eWNnkyuKxwdF1GOunXatfEJnuOYMtsP6KiOz2yfQcoFluqKOwpOE3efTeR6AVbeV
 9mUISJ85gTtVokQrhWGWbPvQeENppnhA2unQh016nGiYKcPdDGCqPDZ5YFJKvZ6sc75h
 wu4HDdpA7Nl3Zbo0LW+ytVikxKVDJn8fr4TikPTpIeIeWtdpuSr5Kiy0X5p70YqSJU/T
 FEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762475450; x=1763080250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VODoYlZ+VnXjNzrxPOxrQoV4Ehcrlg7pX0YQE4uVgZ4=;
 b=XC++aNAezvpIY2EgyHxHs3EhIrBlHFcbsqQ5Gej4jX/L1FAJBoT1Wfx+qs+E6j89qG
 EGOSwJxTLUR07+j7BSRZx8P180qxrJF0eJKVDhS8rAaiudkajpqzKocxTHOhw8wjfc2I
 0jeqbqH4bdI70Gkiu3RInGfH71KipMMMjsnFTtaQ7yycaWfT+pbPBdL9hGqcxNecEGAL
 tg73AGavcTbt7dnxotKKWtC6Hvq+SFLUAKspHKe0X6hZ86ORvGORtW+v/GAH79kjf07f
 ARcMFCpFd2lO2zVWq2sUhANb1paVnKY56Yfe8nwETitlj5oPR6gh3uI+lJmvY/pgZb7v
 vFFg==
X-Gm-Message-State: AOJu0YzhzV51rTwbVh5EYBLIM5DWPH42L6MobCMqAaIrwEiMC3nYOMZy
 /DVCUbpbwmE0voarJs71GgfXYcYSY5JGrBvgcjYsYtR30NaaIvBj7y+P2o82Z4r8qtgRp5WxjsJ
 TRLY=
X-Gm-Gg: ASbGncs5LQdFPctJQSjA9trkbV6T7EV8ANV1ErBdMFPfzZHBUSKAvHXZuZVBtqwTbk5
 DV5nNKgYY4vetRco6w1X5CQkOOXsmLliSS9SumbXWCIx7dLsaI+vbhSeDCdiGY5zZL3d70SQZNi
 1uh0Xa65IyPXoA8fBq03YWTZHoYYgmcT8Z2TtTlQhRs0jBDEa2//ZD3xVPw7PKVFs+NKOnahDFx
 dtU+jv2mqWqoP0AMDNYkghPABw/4Lo/PQK7qpoGMFMjO4q+iTyWGAAjE/Fb/fkaZDnv9TnNmr4X
 xI1TH2J7qF8qIDvSoDCG0H/YlixQaC0DR0kS59mzf0+9WErMW5Ob9utptWOzoJxT2e8cOCoiUmO
 O7av2UR+tWJ+tuX/05RW7QOYGBMS9h4SwsFz0MiRuoR5IQXdV/egnHJLa8sxEiEdmlxiZbdcZMW
 0=
X-Google-Smtp-Source: AGHT+IExap+dHuqodwSPYGYuIGPXX32xT58ZfJaFNMwrxkUeqWFHNlRz5rx1vGdw3IZ/CS/Jn6uLVg==
X-Received: by 2002:a17:907:60cc:b0:b72:5f93:2959 with SMTP id
 a640c23a62f3a-b72c0ad3420mr126634966b.17.1762475449696; 
 Thu, 06 Nov 2025 16:30:49 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bfa11271sm84066566b.66.2025.11.06.16.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 16:30:49 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri,  7 Nov 2025 00:30:24 +0000
Message-ID: <20251107003041.28929-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107003041.28929-1-wegao@suse.com>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] tst_cmd.c: Check brk_nosupp when tst_get_path
 failed
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixes: 257394e4e3 ("Filter mkfs version in tst_fs")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 lib/tst_cmd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 2faf7c743..716029c9b 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -265,8 +265,14 @@ bool tst_check_cmd(const char *cmd, const int brk_nosupp)
 	version_token = strtok_r(NULL, " ", &next);
 	str = strtok_r(NULL, " ", &next);
 
-	if (tst_get_path(cmd_token, path, sizeof(path)))
-		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+	if (tst_get_path(cmd_token, path, sizeof(path))) {
+		if (brk_nosupp) {
+			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+		} else {
+			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
+			return 1;
+		}
+	}
 
 	if (!op_token)
 		return true;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
