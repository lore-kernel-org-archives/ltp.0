Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6E0F9D0E7
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776185513; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=41nFBq71M5yr7h5pBtyZQPK1BVuYtFP+a4t5iAmww4g=;
 b=DrONfsfw9go628bwp4ma5Tu81U4JQwqTOLLkqd5AKaK9657/MB/Ei/sp58oRv8z0Y/mnn
 x+pZMjzK1Q/wlE8lgRfRsS+fPYywA3vSDc21KEjP0VMXi/nwBntt2o+PcmeyXedCIFUAC8W
 OncJ7mntOs+ldmEI6VE9H/ayKu7VmGY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A8CA3E5DFE
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 18:51:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F31B33E5DCA
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:51:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 681D31A0081F
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776185487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=11KTou324v0RBr/8mkrCAe7qCAN1uMNT7toQfl3hgdM=;
 b=NeG4jIY+yhfXMEF8gn2LElkc1bY7EjhSc1nzOQoDu/Q0iexYlp7c8uZIsKPkWL7pfWspft
 9/PIUD/BFZecse9IjxSUvqIRJKEXZrwRR5dFZ41k2Xs0ZSvtwebHPbwldAtLX0OMrCoRU6
 qy8DFHyxuug5Q0dFJpSVVk+ogRpOicY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-kBO_KxzyMOmZWFZW1by9Lg-1; Tue, 14 Apr 2026 12:51:26 -0400
X-MC-Unique: kBO_KxzyMOmZWFZW1by9Lg-1
X-Mimecast-MFC-AGG-ID: kBO_KxzyMOmZWFZW1by9Lg_1776185486
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ac566014e0so156943206d6.2
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776185486; x=1776790286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11KTou324v0RBr/8mkrCAe7qCAN1uMNT7toQfl3hgdM=;
 b=ZeYq9t2U7TQXqBISc1tp+Q42Y/jgBahMJRDBm4Qv1MUhsVOznMubmHf8kxxapCJcIO
 MY1bTfEBzK4NfOfVihNvpYBQpLzKuLWJi9BYmKQOog9nwWPUwWkqI0u9HWspZ+UsuOHu
 sqOUHEtWtWce82UBd9klkVekvqi12IqF57d6xWPjBhJlSrQdF0ZvYJWCFqyV+s+q5ehT
 HipgCc3OXUy4+La2nySV22CMJZt/ovS4J3AOrkkOj9qJtrVjPqoN1l+TjuTm90VeQFqo
 17hzm/veDr2tBMFhKPxQ3eV+X33JNHOuYiKwlFfKu9FJpah7VWgROSaDfAbKfH9El59j
 PbbA==
X-Gm-Message-State: AOJu0Ywgz8iksWvsRX8AxBrhtFESGsKKdpZxIsXeh6YPPmLzvVOxUAAK
 ghVoXopOXyfCQ7K87MQX3cV6UsZAAVpVVQx2THzWekPMk89b6+yUr5UoZbBIB65AcH940MqmhzW
 8/gJO1WyjdaNOPKHCs9peyaXxkQmluVoKeeXduTu0szXFMFSdZy59zpaCWGj4ohkACZ3KPr6i9s
 eWij8yCh0rzeX9O8MEHyh1pYV4S6nCALxp/BF2Ezk=
X-Gm-Gg: AeBDiet2Q2PLCN+B7YTQb0LlBSY10Nw6blG7xokh/7wXzcEA5g8cHDvOi1fEsLXeJmJ
 +/HJU/o2jH/L6krh/mTc6jxuaYZl7t+sv4slvMoqYZRAfXh4izmPOoaX7XncO4aE3NkMS8qDz9/
 Er3esq1W07KYHdJGxnCTGwS1PSz2dRGh1pYUMMPTyrn3Xs1oGgK6RKREDqWZcpAG5R+XNgUF+CM
 7XJhqcsNHE/K/R8vj2Nlh4DDqvnX6hpzMtc4b2LCdYzRVm8LaSMKKqtR+gm07g3bY+ZompvFpFQ
 FquxQHt1XMRYbR+4irNKrF+LTBQHfgRVPkNDI4ajZdDEissU76FnHMj6v2O7nPZEuDNuCQIXl9w
 46nKg05Cs80smpTm1GCTkmp+7XerEMKoNiUGSOHE/R3PmXyQ=
X-Received: by 2002:a05:6214:2422:b0:8ac:a8df:639b with SMTP id
 6a1803df08f44-8aca8df6733mr166185236d6.39.1776185485620; 
 Tue, 14 Apr 2026 09:51:25 -0700 (PDT)
X-Received: by 2002:a05:6214:2422:b0:8ac:a8df:639b with SMTP id
 6a1803df08f44-8aca8df6733mr166184396d6.39.1776185484933; 
 Tue, 14 Apr 2026 09:51:24 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84c495a5sm124834816d6.30.2026.04.14.09.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:51:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 14 Apr 2026 12:51:14 -0400
Message-ID: <20260414165117.843270-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K0ncNNVqPgUooKWUUXfBcsknIiUPPpRylKuH0NajpE4_1776185486
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] semctl: use IPC_PRIVATE to minimize interference.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This update solves previous issues when tests were
run in parallel with multiple workers in tmt.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/ipc/semctl/semctl03.c | 5 +----
 testcases/kernel/syscalls/ipc/semctl/semctl05.c | 6 +-----
 testcases/kernel/syscalls/ipc/semctl/semctl07.c | 3 +--
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index 5a11b95ef..dc11d0823 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -84,14 +84,11 @@ static void verify_semctl(unsigned int n)
 
 static void setup(void)
 {
-	static key_t semkey;
 	struct test_variants *tv = &variants[tst_variant];
 
 	tst_res(TINFO, "Testing variant: %s", tv->desc);
 
-	semkey = GETIPCKEY();
-
-	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 
 	bad_ptr = tst_get_bad_addr(NULL);
 }
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 985c1f039..f1ab69f59 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -45,11 +45,7 @@ static void verify_semctl(unsigned int n)
 
 static void setup(void)
 {
-	static key_t semkey;
-
-	semkey = GETIPCKEY();
-
-	sem_id = SAFE_SEMGET(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
+	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 1b03f0ab2..a0b5f4928 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -130,10 +130,9 @@ static void verify_semctl(void)
 
 static void setup(void)
 {
-	key_t key = GETIPCKEY();
 	nsems = 1;
 
-	semid = SAFE_SEMGET(key, nsems, SEM_RA | IPC_CREAT);
+	semid = SAFE_SEMGET(IPC_PRIVATE, nsems, SEM_RA | IPC_CREAT);
 }
 
 static void cleanup(void)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
