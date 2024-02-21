Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF28BC48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708505056; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=xQOhvltjKQc07pOLSqAOSdavz6ZtzF1RxS3R3rjtz6s=;
 b=rJ5bJVX/wbx6gR9hjr13PxMJO5bHgnojWN8QfLobgIMQv/iwK0sc0E3O2yCeyPDqsBaZY
 vDvDf6L7hjLCG6ABGnQSivE3NmpS/7Ztr191DP1teFh2DjX4R//Vdc3qeVA0hkO6khvaHhL
 ZnkReflSIw7vAJ4ub2Mt4qKBj7VF6Z8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D2273D0179
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 09:44:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9253D0155
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:43:22 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D5C320110F
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 09:43:21 +0100 (CET)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d228a132acso54965561fa.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 00:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708505000; x=1709109800; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVO3/vC4HtMoldrQshtrqdwAKU4tDlaQiqBvXum3Ur0=;
 b=KoFkS5M1FRG1IqP2vIP7OLt3ejuhTZif3OglovNFx/RoDvcKoAKLvU5I6icNFJ2ZRq
 nLDoedlCpfDLRl8ckhqed74WOrjhUK5/ZSTmSEdj0fqHYZXPHo6IIgE6t/H6FCev+dAF
 6RLjF7SgPumtCGdIpouTRnqD6v5/sH+uDmkwN/zxa+o6PGZ5VL/QV8O/2X5dKk/GQioD
 rEupBTi2bv3ukccN3T95qF3vQfOgWRofzJFk1kPye0EdWam5v1NswcfUhn06HRi4TlbP
 1tJj8QZZ2FzpfluWqUz4Y+SIMYbeMsEiqKDFAja++u29lqYUbyhcmyTNq+iECGhoRdJj
 GZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708505000; x=1709109800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVO3/vC4HtMoldrQshtrqdwAKU4tDlaQiqBvXum3Ur0=;
 b=rgOsBrHl+DnLeL99SShksYVPT8qEukRs//cQAoGgyp2TQsNJ9RpjCtdh59TWBHXmFU
 H9E4fQocc1A4lykeBkZuOfi9lrMmciAgLZu2NGwHdvxjM6CMb2TKFMASFCDTmQP7lvN9
 dK2b2lRxix5qbkMg++mlQ1xkvEoX/5mze3qC90odCYRuE4fCsIgjWyTraSijDf65Gl2R
 LI2CUZIzXuh2WJg+eRoet4f+aiVqZgcpzWhbv1lVAoAkla4PgDzX4zQt8trtx7qLieem
 d0nQXkd4S3lNyTyg/5vANFKgpnjxDVvSu/x6Kx0kGujIdyBUfFwqbH07UVVRQCwNN3Un
 fH/A==
X-Gm-Message-State: AOJu0YxvDPDxfGZFpCdxHQPM+fKoS4oFSd3ph5i8LwiItugPd++ElbRG
 Px6vRZLvMozy2W/DnaP3J11f+uK/AGWOAtpyIjfaneWfCbxc4TUr/mP7IShrv4HZSjjQs0eCCW8
 =
X-Google-Smtp-Source: AGHT+IH+XzIid/HlQ5I/19swSA6FXT9+zZiC5gFi/dRqUsfVmhfOWqVYb+YrN12afOiJG9n4hkC/qg==
X-Received: by 2002:a2e:9e94:0:b0:2d2:3f09:ca3e with SMTP id
 f20-20020a2e9e94000000b002d23f09ca3emr4129321ljk.50.1708505000226; 
 Wed, 21 Feb 2024 00:43:20 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 n3-20020aa79843000000b006e319d8c752sm7787487pfq.150.2024.02.21.00.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 00:43:19 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 03:42:56 -0500
Message-Id: <20240221084256.32661-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221084256.32661-1-wegao@suse.com>
References: <20240221071635.17239-1-wegao@suse.com>
 <20240221084256.32661-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] statx07.c: set umask to 0
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

When system's default umask is 0077, this will trigger issues.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx07.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 4dbf83e18..227c33c96 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -116,6 +116,8 @@ static void setup(void)
 	int ret;
 	char server_path[BUFF_SIZE];
 
+	umask(0);
+
 	cwd = tst_get_tmpdir();
 
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
