Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9B7C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750069678; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=XhCr283YsljAocObeiO1bDjEsGIZHQcTIV7BIBMdGy8=;
 b=Z2kyEGuoDsJwlwXP1RvTAzcl9KAEVeUCrgFwtp23w6KB2sNBjMnJ6iMFh5OOioRzsf4fF
 yfyjh9U/3cPaZ7QUdW/NDQgKqvBGhIkYrDB8jDdIJzx1hpCoq+meBgAzJB4pwiJOZnbQGTj
 mjc1hCwmSh+14Hl7hACEv/iLPCnyJig=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E350A3CC025
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 12:27:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFAD73CC041
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C57B91400C77
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 12:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750069593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcIoDX9W+baALInWmVl1X+0BXBa8u3HL8C67JdBnskw=;
 b=RCveTOaywS6vFlgrPxRGqtSXBWkKoZ4BXhNpM7LOhfx4J5jsLEce70eGmeamgG4mrxLhwU
 bJuGm5NInjsSObAJxNPbGcsjQTnBxBRYEd9nRpLCsT7gYVunkdIbh9W2QIXKPPBxqYUJuU
 xeRtsAUZak+sK/+SfZeEnNwZjECnjsY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-vpptmEN0MyGDfcLl8mcSug-1; Mon,
 16 Jun 2025 06:26:31 -0400
X-MC-Unique: vpptmEN0MyGDfcLl8mcSug-1
X-Mimecast-MFC-AGG-ID: vpptmEN0MyGDfcLl8mcSug_1750069590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE0EF18089B4; Mon, 16 Jun 2025 10:26:30 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40886195608F; Mon, 16 Jun 2025 10:26:28 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 16 Jun 2025 18:26:19 +0800
Message-ID: <20250616102619.54254-4-liwang@redhat.com>
In-Reply-To: <20250616102619.54254-1-liwang@redhat.com>
References: <20250616102619.54254-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 540u581ecKIoQjqROQo3FZfFS_VUpyASt9oWyjYHYqg_1750069590
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] tst_checkpoint: Detect and reinit shell or C
 style checkpoint file
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add support to distinguish whether the checkpoint file pointed to by
$LTP_IPC_PATH was initialized by a shell-based or C-based test case.
This ensures the correct reinit is used based on the file format.

To avoids errors when crossing between shell and C checkpoints.

  # ./shell_test05
  shell_test05.c:14: TINFO: Waiting for shell to sleep on checkpoint!
  shell_test05.c:18: TINFO: Waking shell child!
  shell_test_checkpoint.sh:7: TINFO: Waiting for a checkpoint 0
  (null)      1  TBROK  :  tst_checkpoint.c:113: Set test.needs_checkpoints = 1
  (null)      2  TBROK  :  tst_checkpoint.c:113: Remaining cases broken
  shell_test_checkpoint.sh:9: TPASS: Continuing after checkpoint
  shell_test05.c:20: TBROK: tst_checkpoint_wake(0, 1, 10000) failed: ETIMEDOUT (110)
  tst_test.c:1864: TINFO: Killed the leftover descendant processes

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/tst_checkpoint.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
index 35a0c0dfa..55ded7e7d 100644
--- a/testcases/lib/tst_checkpoint.c
+++ b/testcases/lib/tst_checkpoint.c
@@ -40,6 +40,37 @@ static int get_val(const char *name, const char *arg, unsigned int *val)
 	return 0;
 }
 
+static int is_shell_checkpoint_file(void)
+{
+	int fd;
+	char magic_buf[4];
+	const char *path = getenv("LTP_IPC_PATH");
+
+	if (!path)
+		tst_brk(TBROK, "LTP_IPC_PATH is not set");
+
+	fd = SAFE_OPEN(path, O_RDONLY);
+	SAFE_READ(1, fd, magic_buf, 4);
+	SAFE_CLOSE(fd);
+
+	if (!memcmp(magic_buf, "LTPM", 4)) {
+		tst_res(TINFO, "Detected Shell checkpoint file (magic = LTPM)");
+		return 1;
+	} else {
+		uint32_t magic_val;
+		memcpy(&magic_val, magic_buf, sizeof(uint32_t));
+
+		if (magic_val == 0x4C54504D) {
+			tst_res(TINFO, "Detected C checkpoint file (magic = 0x4C54504D)");
+			return 0;
+		}
+
+		tst_brk(TBROK, "Unrecognized checkpoint file magic: 0x%08X", magic_val);
+	}
+
+	return -1;
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned int id, timeout, nr_wake;
@@ -78,7 +109,11 @@ int main(int argc, char *argv[])
 		goto help;
 	}
 
-	tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
+	/* Re-init checkpoint file based on its format (Shell or C) */
+	if (is_shell_checkpoint_file())
+		tst_checkpoint_reinit(__FILE__, __LINE__, NULL);
+	else
+		tst_reinit();
 
 	if (type == 0)
 		ret = tst_checkpoint_wait(id, timeout);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
