Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E56C77B75
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 14:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4909E3CB687
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 16:56:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E90BB3CB37F
 for <ltp@lists.linux.it>; Fri,  5 May 2023 16:56:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0739F1A00ECD
 for <ltp@lists.linux.it>; Fri,  5 May 2023 16:56:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6B54229CF
 for <ltp@lists.linux.it>; Fri,  5 May 2023 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683298586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5JIZ8vaLJ7X1hk6NcV5ZEK+nW7WLpVgA9cmwnC/6V0=;
 b=Q0hXornaRy6tweodz0Ql3pyxacoPVU8TKMedkCB+AWL9ZgZzRgx6y9XFGP2qUK+NBX3nfD
 U9tsYSFHMwGj19xcrcOp7BRQSlZOuvOHJcDvJ/CvqyfqNOjMTWrR7UILNAGMdkNqpv1KMz
 sClcYVeTWX1NFAuVpO1uRCKkNL26YM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683298586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5JIZ8vaLJ7X1hk6NcV5ZEK+nW7WLpVgA9cmwnC/6V0=;
 b=FYgB91wvqDdRDzuutosSC9Y6qjBtiRXx8uuJk0q7kEAkZoEWmp28YqdDXGfCgZ6A3qP4X3
 20npdb5CYuis3QCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C805C139F8
 for <ltp@lists.linux.it>; Fri,  5 May 2023 14:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QEATMBoZVWTXAQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 05 May 2023 14:56:26 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 May 2023 16:56:25 +0200
Message-Id: <20230505145626.2537-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230505145626.2537-1-mdoucha@suse.cz>
References: <20230505145626.2537-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ipc/semget05: Set dynamic run time
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The semget() syscall can be slow on some archs so too high default
system limit may cause timeouts. Set dynamic run time based on
semaphore limit.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I've originally tried to create an IPC namespace and set low custom limit
but IPC namespaces don't allow unprivileged users to reconfigure them
like the network namespaces do. This is the second best solution.

 testcases/kernel/syscalls/ipc/semget/semget05.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index d6810c11b..dd9a6285d 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -42,6 +42,9 @@ static void setup(void)
 		used_cnt);
 	SAFE_FILE_SCANF("/proc/sys/kernel/sem", "%*d %*d %*d %d", &maxsems);
 
+	/* Prevent timeout due to high semaphore array limit */
+	tst_set_max_runtime(maxsems / 200);
+
 	sem_id_arr = SAFE_MALLOC((maxsems - used_cnt) * sizeof(int));
 	for (num = 0; num < maxsems - used_cnt; num++) {
 		res = semget(semkey + num, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
