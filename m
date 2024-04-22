Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345E3C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 12:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713789678; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=fB5XUjseF6HsPWSGQW3RHAk0bZsAcoBrpGqplQm2mLk=;
 b=gu9XD7Z1FwmJeZjpZGjiZRKnTVK5QfTGsSq9UPJoVWQ27HToEOYa7sDKOv7OJ8aILSFRa
 qmjGejsyGjPUFbWdfnOdvi2CetMQCxFmFFXZ0FC1kkGrNGYHTfg+OryQY3lTqnIwoUp3Nhq
 sMHIm8D5JKZdlxdPVDIrdkQFz1AKc4E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF7183CFF22
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 14:41:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50B243C006F
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:40:57 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E0122000F0
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:40:56 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34b3ef55a86so416062f8f.0
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713789656; x=1714394456; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E2qYQfRKfM0j3THH8y3fx9EoXnifnJK96qTB2/s3Jc=;
 b=A/00KQKck2fHdtAIOAZaZBo4wzonKh8JAAQfabMPqVohzlD6HzAuPq5gtRZOoAh/67
 Rc6hY5v6o7NtYn8eNdVu7zBoo2nANK9dP5+ALRN5sYjkORRf8IKkuCmgjEFo5FmNOa5s
 ovsjMS+uu0ES2rb9cJdJWeuSNcY1tQDviEOeCp/T40/FuHXvel6xcnNAxHlD+Of7dNVm
 Tf+l3GXu8VFLyAyFCLCtGZHkY9TqnsXn5L6ur/c0Qv13oW1UhDtsdF721vCCtQkcCCmi
 a2dZ2F28Zc/bYeotbyZw1XYN9bvbs5WaMPzJxZKdoofyGMCUAsFmWx1fTAWvTGOQEQAt
 jmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713789656; x=1714394456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1E2qYQfRKfM0j3THH8y3fx9EoXnifnJK96qTB2/s3Jc=;
 b=BZhMsRQSFEFExZrKjc83GXIOD5z2VXLP4u91doCD1kAkjStC5p+/w6v+fKb/qautHd
 xd/feYLUkmf37Y43xlEi6GctMYb2nEYoQIpPkhEwpIQ9v8Q7a/IsC/NGYCL56GYrjVX3
 yZK3SQekf4lu+wsa648SRv/IOrv1iWRivks/G9I5FnU9WEWdx7mqjMVVInkGxhOwLkT6
 o9481u1LxBG8QjfJdFPipOxMn4EtO2f3pkvDFeJG7YXmua85+jWqU+LHbdZ3ALHpp3iT
 vJ32X41Q71U87+owXorrj+44Blx7UZVZer/WR08rCosT3+S+KUPGJqcDOzkxyh6gCgMY
 Sj7A==
X-Gm-Message-State: AOJu0YwhjfUoj8pvH+pHbwtxNA3LwhH6JJg04ELxN28o6j+BE52moIa5
 nkPnpA61DIT0Btg5TsgywxRtWBza2WwEQdi/L2UaZYLN5YrshTKXVws/oqALcaTytHgPqC8Of7k
 =
X-Google-Smtp-Source: AGHT+IFS5kMDw9h7sgzTCLtGRCFqPwv61BgxT7RapPwa1uIZicfeBunJxZz/s7a/N8tDZ0CS5MuPXA==
X-Received: by 2002:adf:a4c2:0:b0:341:d8a9:5b7d with SMTP id
 h2-20020adfa4c2000000b00341d8a95b7dmr5483864wrb.28.1713789655834; 
 Mon, 22 Apr 2024 05:40:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c4f8200b0041884b79b81sm16559374wmq.1.2024.04.22.05.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:40:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 22 Apr 2024 08:40:50 -0400
Message-Id: <20240422124050.3598-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240418071422.10221-1-wegao@suse.com>
References: <20240418071422.10221-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] swapping01.c: Add sleeps in the loop that dirties
 the memory
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

In our test env this case failed sporadically, we suspect swapout speed not fast enough
in some situation.

Detail info please check following comments;
https://bugzilla.suse.com/show_bug.cgi?id=1217850#c34

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index a0030a75f..79dd2b4d5 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -47,6 +47,7 @@
 #define COE_DELTA       1
 /* will try to alloc 1.3 * phy_mem */
 #define COE_SLIGHT_OVER 0.3
+#define MEM_SIZE 1024 * 1024
 
 static void init_meminfo(void);
 static void do_alloc(int allow_raise);
@@ -101,6 +102,13 @@ static void init_meminfo(void)
 				swap_free_init, mem_over_max);
 }
 
+static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
+	for (int i = 0; i < mem_count / 1024; i++) {
+		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
+		usleep(sleep_time_ms * 1000);
+	}
+}
+
 static void do_alloc(int allow_raise)
 {
 	long mem_count;
@@ -115,7 +123,7 @@ static void do_alloc(int allow_raise)
 	if (allow_raise == 1)
 		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = SAFE_MALLOC(mem_count * 1024);
-	memset(s, 1, mem_count * 1024);
+	memset_blocks(s, mem_count, 1);
 
 	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
 		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
