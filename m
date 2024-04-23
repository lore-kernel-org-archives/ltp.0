Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F317FC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961486; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8bMvnHztokcm9BgxC2+IBKG69j/7F0mM3Cs/n9TMcVI=;
 b=Cxfl8WshwyC8Ye/INaBIGR8kiAbjoy/6VJoyLc+HZet1mtLEMU5Fsi9Tqd9zhg4iHjYul
 zJfnonKzlXYhYN4EMv5bMB3LilRz4V0rebyRPOW+MwUR4lVbGp9MiejHzttnZoG2MVktvhh
 BUD3qgEmVMGd9op84+u9Nz87n7M+HQ0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70B313CFFDC
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:24:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC3C93CFFC1
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:35 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 690CD1000901
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:35 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1e5e5fa31dbso66955955ad.0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913114; x=1714517914; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=2q841j9kye5YbA40IICyAAzsc+SoEdMrxrOnpu+k/aU=;
 b=fmr2tB5xAcbrUAQRqyGyykCrNiqhuyXbBzQdRWVwz9ZKVRdBdoCl9hFnDEJI8h2b9/
 1YMjVXi0OatguJcrd7PsObdSwGKpx1A241TIIL0pvmU8QU7xPMLL0bYWnQruV8NGG56W
 TYDtNbG66qteuU7LMIggQoWWg1KJW7/zEu/KU6WGCEbiJ/4G2OzbnnfjUHYa9TF4THTj
 sc8HwAYFs57KqrEwM0iEhmbCv4AlzRrGKg8HM7uMYDgJzrzItvDw7nHfqyzuqLPK9F1D
 jCr2N3mgqOivIbFJLLyaewK3Q53i/7yo+ShWq3Dh2zIagLbiqTtQ9zP+BL+JgC+/LYDc
 Xkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913114; x=1714517914;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2q841j9kye5YbA40IICyAAzsc+SoEdMrxrOnpu+k/aU=;
 b=LrEJJXJYoMCknIdzjFhW6N7eJT4R6+h5MUcFA2Gj/NCZ546l//A5EL8j19RtGe8V74
 yw09wAYNFxBoVfDL8brEgZTOmmU32k3Wx9ChabKy9dDSSYM72q0Iz619UqRa9DLn+XSF
 xy71jZrJmcUMZNqVI+dl5czk+DDwy/Z/3thXeo2adCgnxAOBdzb/R2Aycve8mMQYgwfR
 EQHM+xI+XMLhOy/oC+9kvQ6x4GVER231awM7xWOgendnctYobVJczZ0BATWyRzH7Dfm0
 ZCE/veUaQ/QDXB/Ov+0GtHgWynFVqoq5+SEVOxuBkMBdz8aQbwrzDgTRVAumtBxE4z0V
 Lkbw==
X-Gm-Message-State: AOJu0YwtXnqbvbdNjtHgOl3aFVEx0UTupsbPvb5iouWmuM97h5Tk/CxW
 sjYQoaST72kzXO4OaiDkLV6G/X+4r+9Ar8Pu5av264PHBrZsXBU/eArqNQL5k4UuaeK+l30aD3P
 t/MxcQkzndUQq/8EVX5hJPjOuDKH36mtkf8PA0z3esw1XhevHKECk+PA+zeNnGSgY+9OWmaVS0j
 II9O0RVt8WWe9CWrwWTPhvSg5FR8KPdos=
X-Google-Smtp-Source: AGHT+IGWkvu/8gdmvMWtQsPQxD+Kw2cxagGFp31dfPhKPSkKREHgj1/ERv6jddh6X8SgPPEo+raes2uSithv
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:903:2290:b0:1e4:881f:bed1 with SMTP id
 b16-20020a170903229000b001e4881fbed1mr11379plh.7.1713913113666; Tue, 23 Apr
 2024 15:58:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:58:01 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-5-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 4/6] sched_football: Add a sleep before the game
 begins to get into steady state
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

Before we begin the game, lets give a little extra time for any
odd initial placement to get sorted before we start testing the
RT scheduling invariant.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index ed3c5cadf..7686ce3e6 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -246,6 +246,8 @@ int main(int argc, char *argv[])
 	while (atomic_get(&players_ready) < players_per_team * 4)
 		usleep(100);
 
+	/* let things get into steady state */
+	sleep(2);
 	/* Ok, everyone is on the field, bring out the ref */
 	printf("Starting referee thread\n");
 	result = referee(game_length);
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
