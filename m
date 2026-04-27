Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FEBFF8860
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777291213; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=a7Tib8Po7bPwFUe9m9ffXLqQFlLlB4e6n/hpmqEKC3E=;
 b=jguMAaunSeA7o2oJJkbr8BQAU6RQT564nhDeHqdJZretESX0X4VFzrFbI81AuwVZc3lQP
 B87LG0enY/FQIzGdPHbM0wTTlXuW8NMBdPZ+WRc+1yxzrX3ituksJgAnUmVNTopAIgLSIhB
 eW5haEcIqOdWYdQmPW0/ec8KGDIDmPk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C0273CA6DC
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 14:00:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 117F23C9F01
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 13:59:48 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D9E2600677
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 13:59:47 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so121629565e9.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777291187; x=1777895987; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jnWIDd/CFYkI32gQKxafBhQmLQUL4vE1nk8E0aaFlcI=;
 b=hCkI7OSLHFjtrgSpcLF9DSSgqgY2v5kTguZdZOowyJFsSeGFmI5zbATnjMwCUCCq3H
 faHWHZEB/I62x5WS23TxcT9ZE56DvOOXHHkDOgvgaX4tXGG0gHVvKrBWkQ68txbcrurl
 JYJ2kwhrhzl7NNuVpTj5l/DqcDwtWuPKZKYCPwmbQXwiyNmWvWwaDKareV/moK5gUDXx
 Z8xwfKP2Jx7964jWkZpWLbSLLSR0DkyLeRzuPdgmrlsSy26FNyi2Qs3zmYO9IoV1mfFe
 OnIpZzAhNhORrGtREafGf/eztwd8GFNRnG214s2Jjc7TeH22iQlzdYMhNS69aQgu9txi
 rs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291187; x=1777895987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnWIDd/CFYkI32gQKxafBhQmLQUL4vE1nk8E0aaFlcI=;
 b=XHN4fprXMsLnskwbP5jkxhts9GGQ/xoQLj/CmYEvq7+IG2Aupj1Bk5th63cxANNN9X
 VDNjZcbS1fGBpJ8fvLwA6EuslpGP3Ph6hXVoCofykHC8hevPHLF7zJc0TBdHhUubJ05o
 E2u2wC45DQbal0QVqe/5NxsFf1i+FVydPwPA2zMoB4PD9DZ/LNfNKKOjbYHnP0pTjgEi
 4SalaH/n/jdkq10Iujj0UQfoV6ctHpkmYhn7NJE24OVZpfmp4zyNv9h2nby0qCIJZZa8
 V2AJvv/9i4peQjynWXWyY7F9ZVCgtwvYSMQxFFB8uaAZIq4FAQEJpDWcqAXbxD/FaNQD
 VkAA==
X-Gm-Message-State: AOJu0YxIYEpwS4750OmFHFUM2Vgtj9DgjIdi4Jm2hAKpvrlm7li1hAfl
 6x5jUIEM8JM4M6rYxj4FQxnaXmV/JjDrSvHYrenyWQPj27XBGRYXLoxIUpbdLnaimYNf+JHT9l7
 U18Q=
X-Gm-Gg: AeBDievxX6J541l/q8OR81jD/DFEeBhFpaqjk2svi0LiLU05S/l9rYVopTn7o9/MaeN
 GBYgJ4myjuP6q7t0KpQ0fHnK/7aXwzlyQ6ZlUIkU1jKDJYPYaAtAiPni0uYFT9N11Hs82jCoYtB
 EuiSHJyKP8uM8FfEp6N1rQVcgFyQ7/ULbJvAanYXg1ZeR9N2p5Scz4JEAVG5wjz6f3049Ipxv3C
 TqSYx3XFqLq/iI7Y1jRSh7BSA/W6i8ZsIijbUsp/k3V4OVay31vSHqfdS43Uh+OyrM6DcL7KPHA
 Tmav93hjNnj6s1DCFvx6LqV72sUoFAzyNB4Z/rzPZatxTVyEXrh0n+i9+8vteYjTJFq17V8horO
 ZodaAOH4BgZcRBgwff6c3qVku3pPfMm0TT4ihNlaX99IZy/PdkckFw21OOpDwKfogTns0zA4z2d
 GCmLw6wlBeEDEnNoSSWzo6Hg==
X-Received: by 2002:a05:600c:1616:b0:489:1cd2:6106 with SMTP id
 5b1f17b1804b1-4891cd261f1mr271364635e9.6.1777291186737; 
 Mon, 27 Apr 2026 04:59:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488fc10777csm891148775e9.8.2026.04.27.04.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 04:59:46 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 27 Apr 2026 11:59:39 +0000
Message-ID: <20260427115941.31945-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap space
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

mmapstress06 is designed to stress the mfile_swap kernel primitive, which
manages shared anonymous memory. On architectures with large pages (like
64KB on ppc64le), the test's hardcoded request for 32769 pages results
in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
no swap space, the test will fails with following information:

mmapstress06: errno = 12; large mmap failed
for this test to run, it needs a mmap space of
32769 pages

The failure occurs because the 2GB request cannot be fulfilled within
the 2GB RAM limit without swap backing. Since the test specifically
intends to exercise swap-related logic (mfile_swap), it should be skipped
with TCONF when the system lacks swap space.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/mmapstress/mmapstress06.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 37b7edc84..54b5febbf 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -51,6 +51,8 @@ void ok_exit();
 
 #define ANON_GRAN_PAGES_MAX	(32U)
 
+#include "tst_memutils.h"
+
 extern time_t time(time_t *);
 extern char *ctime(const time_t *);
 extern int atoi(const char *);
@@ -74,6 +76,12 @@ int main(int argc, char *argv[])
 		(void)fprintf(stderr, "usage: %s sleep_time\n", argv[0]);
 		anyfail();
 	}
+
+	if (tst_available_swap() <= 0) {
+		tst_resm(TCONF, "Test requires swap space to exercise mfile_swap logic");
+		tst_exit();
+	}
+
 	(void)time(&t);
 //      (void)printf("%s: Started %s", argv[0], ctime(&t));  LTP Port
 	if (sbrk(pagesize - ((ulong) sbrk(0) & (pagesize - 1))) == (char *)-1) {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
