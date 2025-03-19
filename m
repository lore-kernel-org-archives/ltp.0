Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0033FC35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:28:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616863CADFD
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:28:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A7313CADD5
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:50 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7819E200206
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:49 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso48797885e9.2
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742412469; x=1743017269; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKWz+2OTBoy+UotcCvMGTAQoFflkJt7hIMMBPoD88ls=;
 b=ig5bn2LHCTJdGu3BolFCSVeqESr6juNbvDW/FEB+sA/KiD7G4Sb5hvbnvYCqjF39nh
 qC75MvrGfa+sCiYlKF5NsVFNQX/jPh8eNXJXotWEp0KZCj7CLNKDF2Fno9fNyeNy0mmn
 iuQ35/hakGpE1vKvazYnYdzGvuLOaQCS5XBzexFh8fmMoHpEKvOG3cbmBzpWpC7UOYMn
 fktNTZ/RCv8vmLUx2YxSSwdK9kdCfMaSqAkpZz5j+xRZUKgaq0CWl0hB7ZVp+/6Hx/ZP
 U9Z00SLVZ9zKuEsX9Z/2d5dINpd2+vEDurh11oNPupmvuJ0idghNj0JkGE+1uyP7NY91
 30Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412469; x=1743017269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKWz+2OTBoy+UotcCvMGTAQoFflkJt7hIMMBPoD88ls=;
 b=O1DeM/KriLIVlwDhgnZx/z6PQSpYtfDYyqxRj9+y4Iz1XEarWmaw3F5G4XmTaq+Bgj
 1FYfrdq64L5/rla9C9Ft3pMvngc405e8RtMP+B7rVg5MRl1M/qdJYxXv94sGFCZduhFk
 kOM7RklQA0qvpkoDn8sAnqq/AgX1jKq3t4mwfHyW3cbZUI6G+aW7VGLVyoLBXz4021pX
 sNN7za7Kk7KkGrySQ47Dk3okK695jla/fJKqZrvFME9brS5qJbzUJXiRvngJMr5ahcqz
 h2lImhqGDcxswnPY6m4hhBDtrca7ge72vxl5ij9hc7fIB3WWoN9NhLVE4s1pkBIUWxjt
 60Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDKPwQdhB08ylTlumQNiSBBTK27LHxfIlhEuuJN3Aq7B23nDnU+8uKBYxCmmAE5Aez9sM=@lists.linux.it
X-Gm-Message-State: AOJu0Yz5xrB+QGyDJdp8XIH4zSrcrTOmCPsW6C8iotpY20XaqN+9d/8h
 YDkIt9/uV1RckJ0VYeRiXfWG+bUwxT1IIbss2zTeH+M+nEaETilu93NGMKlX
X-Gm-Gg: ASbGnctpQE4W95sgukyOID8LaIddMLiwrQfoCmQ5xyHKCMO0QXTzIn0UHn2DUfQzJo9
 wzdAycCs/nzKOHLoEiDp6zkWbfOikC3ebvQA3HdvVpIXML6S4gZGbQ8B/fxLaxMevxFLHJsWggW
 aKfsKOj+xmOx7tJUhCxuVUG4Axo9MGluLFyepT/Njs1QnpPZMFS/pMyZZYHc/QJONQer23jdoZs
 HXv3UuDQcgW95uQNwd43HS2NX6vmc3jcye7vC1YC67irrkP1V4RCSCwtOgtrzdxoluSk4MFKsS7
 8EY+15nHer/h81a59ZDJHEbZEQMAcvt893Aiuh4jju8+gWLGfuanNDHlfRBmBBBFBG4hwyRQFyG
 udbXn2YacEMeWx0gJyrWGCCSE3WrUxBFImpUasekfZg==
X-Google-Smtp-Source: AGHT+IHLJ5Ba0KRcK6c/Zpd1bFt0F7SvnZFNQvCsOA1RaWjX/nJFleepH/aXe516Stm00UlXC5f2Pg==
X-Received: by 2002:a05:600c:1f83:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43d437a9783mr43583095e9.12.1742412468337; 
 Wed, 19 Mar 2025 12:27:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453225bsm26531585e9.7.2025.03.19.12.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:27:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Mar 2025 20:27:40 +0100
Message-Id: <20250319192742.999506-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192742.999506-1-amir73il@gmail.com>
References: <20250319192742.999506-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] fanotify24: remove redundant event_count field
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

treat the event-set as a null terminated array.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify24.c     | 31 +++++++++----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index 8a448ea50..539f74137 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -60,13 +60,12 @@ static struct tcase {
 	const char *tname;
 	struct fanotify_mark_type mark;
 	unsigned long long mask;
-	int event_count;
 	struct event event_set[EVENT_SET_MAX];
 } tcases[] = {
 	{
 		"inode mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
@@ -77,7 +76,7 @@ static struct tcase {
 	{
 		"inode mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
@@ -87,7 +86,7 @@ static struct tcase {
 	{
 		"mount mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
-		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
@@ -98,7 +97,7 @@ static struct tcase {
 	{
 		"mount mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
-		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
@@ -108,7 +107,7 @@ static struct tcase {
 	{
 		"filesystem mark, FAN_OPEN_PERM | FAN_PRE_ACCESS events",
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
-		FAN_OPEN_PERM | FAN_PRE_ACCESS, 4,
+		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
@@ -119,7 +118,7 @@ static struct tcase {
 	{
 		"filesystem mark, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
-		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 3,
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
@@ -129,7 +128,7 @@ static struct tcase {
 	{
 		"parent watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(PARENT),
-		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD, 3,
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD,
 		{
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY},
@@ -139,14 +138,14 @@ static struct tcase {
 	{
 		"parent not watching children, FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(PARENT),
-		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM, 0,
+		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
 		}
 	},
 	{
 		"inode mark, FAN_PRE_ACCESS event allowed",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_PRE_ACCESS, 1,
+		FAN_PRE_ACCESS,
 		{
 			/* This allows multiple FAN_PRE_ACCESS events */
 			{FAN_PRE_ACCESS, FAN_ALLOW},
@@ -225,7 +224,7 @@ static void generate_events(struct tcase *tc)
 	 */
 	if (!exp_errno) {
 		fd = SAFE_OPEN(FILE_EXEC_PATH, O_RDWR);
-		if (!tc->event_count)
+		if (!tc->event_set[0].mask)
 			exp_errno = ETXTBSY;
 	}
 
@@ -335,10 +334,10 @@ static void test_fanotify(unsigned int n)
 	/*
 	 * Process events
 	 *
-	 * tc->count + 1 is to let read() wait for child process to exit
-	 * and to accomodate for extra access events
+	 * even if we do not expect another event, let read() wait for child
+	 * process to exit and accomodate for multiple access events
 	 */
-	while (test_num < tc->event_count + 1 && fd_notify != -1) {
+	while (test_num < EVENT_SET_MAX && fd_notify != -1) {
 		struct fanotify_event_metadata *event;
 
 		if (i == len) {
@@ -363,7 +362,7 @@ static void test_fanotify(unsigned int n)
 		 * generate an unknown number of access permission events if they
 		 * are allowed.
 		 */
-		if (test_num > 0 && test_num == tc->event_count &&
+		if (test_num > 0 && !event_set[test_num].mask &&
 		    event_set[test_num-1].response == FAN_ALLOW)
 			test_num--;
 
@@ -418,7 +417,7 @@ static void test_fanotify(unsigned int n)
 		test_num++;
 	}
 
-	for (; test_num < tc->event_count; test_num++) {
+	for (; event_set[test_num].mask && test_num < EVENT_SET_MAX; test_num++) {
 		tst_res(TFAIL, "didn't get event: mask=%llx",
 			event_set[test_num].mask);
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
