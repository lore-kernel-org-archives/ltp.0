Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989FAC77B7A
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 09:16:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA6943CE6F4
	for <ltp@archiver.kernel.org>; Thu,  1 Jun 2023 11:16:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8F5C3CB9D7
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 11:16:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64B71600D59
 for <ltp@lists.linux.it>; Thu,  1 Jun 2023 11:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685610984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEyx5stYORLnNJvVz2LS9LHUMzQu4CSRAT+x8NR04uk=;
 b=D37+JrDxPLl/ld33CTe4TzEPCosm4WZXjXIOWPkV9Mw3sBu4BQ6B9l6elX8rr2EOFo96Ro
 t1/sIA3uooQ99yYsgxYxLp3Ek/UeOFLoDUyFXiV6ZuaolcFSRoUVFfNmVO5DW8HDJrmdNo
 kHv3pNGe6a4S6niHlBCTR8CdzIhMElY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-ezKfXQ5wPsG5GPoFDLw_Wg-1; Thu, 01 Jun 2023 05:16:19 -0400
X-MC-Unique: ezKfXQ5wPsG5GPoFDLw_Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 251BC8030D2;
 Thu,  1 Jun 2023 09:16:19 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C703C154D7;
 Thu,  1 Jun 2023 09:16:16 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  1 Jun 2023 17:16:14 +0800
Message-Id: <20230601091614.53228-1-liwang@redhat.com>
In-Reply-To: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
References: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] shmget02: reduce the shmmax test value in compat
 mode
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Manfred Spraul <manfred@colorfullife.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

As Arnd Bergmann pointed out that SHMMAX being defined as
(ULONG_MAX - (1UL << 24)), so the kernel would likely use
a large 64-bit value, while the 32-bit user space uses a
much smaller limit.

It finally results in ENOMEM failure:
  shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536)
                 expected EINVAL: ENOMEM (12)

With suggest by Manfred Spraul we could reduce the value
of '/proc/sys/kernel/shmmax' in compat mode and only test
the overflow behavior with default+1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
---

Notes:
    v1 --> v2
    	* remove the conditional compilation for 32bit

 testcases/kernel/syscalls/ipc/shmget/shmget02.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 7989ef33e..e053b98d2 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -56,7 +56,7 @@ static struct tcase {
 	{&shmkey1, SHM_SIZE, IPC_EXCL, 0, 0, ENOENT},
 	{&shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL, 0, 0, EEXIST},
 	{&shmkey1, SHMMIN - 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
-	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
+	{&shmkey1, 8192 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
 	{&shmkey, SHM_SIZE * 2, IPC_EXCL, 0, 0, EINVAL},
 	{&shmkey, SHM_SIZE, SHM_RD, 1, 0, EACCES},
 	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 1, EPERM},
@@ -149,4 +149,8 @@ static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
 	.hugepages = {TST_NO_HUGEPAGES},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TBROK},
+		{}
+	},
 };
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
