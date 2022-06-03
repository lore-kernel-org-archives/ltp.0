Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C57C43334
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 09:24:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0F8E3C88A1
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 11:24:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019623C3030
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 11:24:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19CC8600CC8
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 11:24:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5727021B60;
 Fri,  3 Jun 2022 09:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654248240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1hjQrMenZEdt71o5kDb1CG+3Uy3/hau2j50umaIIvs=;
 b=fe10zNodJTR+M0ePDMEf/8MmgxNLjVno7Se3zcF8XM38YLFH9vIAoRZ6pHPnzqZ31IpcBf
 VyixryjJCv/9tHq+AyTvT3cz9fir1/6LXfKhFqJP7YslFl2G6KasTyw21UP8sJXTPcKu1w
 UpZg3/30mKIXMlA4QTvc4Ev2sRVUDLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654248240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1hjQrMenZEdt71o5kDb1CG+3Uy3/hau2j50umaIIvs=;
 b=byTlNLodr8uPlxD3GAHibPjq2lW86O76C/AXKMJlRTxGO4pa7BooTRpH5qhDWPqUsMdIzO
 fxNs2B3phlPZ7CBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CE0C13AA2;
 Fri,  3 Jun 2022 09:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eOlNDjDTmWLZBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Jun 2022 09:24:00 +0000
Date: Fri, 3 Jun 2022 11:26:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YpnTsNWuDoKV2KiZ@yuki>
References: <20220325125445.11984-1-andrea.cervesato@suse.de>
 <20220325125445.11984-8-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325125445.11984-8-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 07/10] Rewrite shmem_2nstest.c using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with a few changes, thanks.

I did rearrange the code to make it a bit simpler and removed some
useless code.

Full diff:

diff --git a/testcases/kernel/containers/sysvipc/shmem_2nstest.c b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
index e6c1a16fa..ea3de94bd 100644
--- a/testcases/kernel/containers/sysvipc/shmem_2nstest.c
+++ b/testcases/kernel/containers/sysvipc/shmem_2nstest.c
@@ -40,36 +40,28 @@
 static char *str_op;
 static int use_clone;
 
-/*
- * check_shmem1() does not read -- it writes to check_shmem2() when it's done.
- */
 static int check_shmem1(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	SAFE_SHMGET(TESTKEY, 100, IPC_CREAT);
+	int id;
+
+	id = SAFE_SHMGET(TESTKEY, 100, IPC_CREAT);
 
 	tst_res(TINFO, "container1: able to create shared mem segment");
 
-	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE_AND_WAIT(0);
+
+	SAFE_SHMCTL(id, IPC_RMID, NULL);
 
 	return 0;
 }
 
-/*
- * check_shmem2() reads from check_shmem1() and writes to main() when it's done.
- */
 static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int id;
-
 	TST_CHECKPOINT_WAIT(0);
 
 	TEST(shmget(TESTKEY, 100, 0));
 
 	if (TST_RET < 0) {
-		SAFE_SHMGET(TESTKEY, 100, IPC_CREAT);
-
-		tst_res(TINFO, "container2: able to allocate shmem seg with the same key");
-
 		if (use_clone == T_NONE)
 			tst_res(TFAIL, "Plain cloned process didn't find shmem segment");
 		else
@@ -81,8 +73,7 @@ static int check_shmem2(LTP_ATTRIBUTE_UNUSED void *vtest)
 			tst_res(TFAIL, "%s: in namespace2 found the shmem segment created in namespace1", str_op);
 	}
 
-	id = SAFE_SHMGET(TESTKEY, 100, 0);
-	SAFE_SHMCTL(id, IPC_RMID, NULL);
+	TST_CHECKPOINT_WAKE(0);
 
 	return 0;
 }

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
