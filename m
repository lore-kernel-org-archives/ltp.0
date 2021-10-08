Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D81FC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 14:14:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F13461039
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 14:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F13461039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47DB13CAA37
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 16:14:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E1F3C6C41
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 16:14:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8C1C1A0014C
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 16:14:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E024E22312;
 Fri,  8 Oct 2021 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633702458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tzUL5w8wyDBHBn1I948J57AOycO3bXN9FgGyqEYH44=;
 b=1t1IzgddKYoBHF8E27A47RTTkzkvASX5DNezypudVYoS67e+PMbv8o6p1KtpAjy/24zYCt
 oECUgbfgXnvcJmDHLf/Wuqy6AlMQ8y3PYzIUhDdhhwsRYyF7OIvjskrbUDM6/Lb9ZnC7U7
 hbgRq79JfmRZZHqOXhNm8G8ZCZ13jeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633702458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tzUL5w8wyDBHBn1I948J57AOycO3bXN9FgGyqEYH44=;
 b=rSfNot1GELnRMHrETUHU+chz0rfhXJtUpi6TAdB0Ptsf8ACq1tEHcsK5DSHwpZ7Ke1DSPg
 Om7BPRyudXnXnwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA4413F33;
 Fri,  8 Oct 2021 14:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KlYuMDpSYGFlAQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Oct 2021 14:14:18 +0000
Date: Fri, 8 Oct 2021 16:14:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YWBSXzdO/gaq9lS6@yuki>
References: <20210924092111.20012-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924092111.20012-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] msgrcv07: Check negative msg type filters
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
I guess that it would make more sense to add this to the msgrcv02.c as:

diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
index cfb7d7446..b305d1f92 100644
--- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
+++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
@@ -21,6 +21,8 @@
  *   msgflg and no message of the requested type existed on the message queue.
  */

+#define _GNU_SOURCE
+
 #include <string.h>
 #include <sys/wait.h>
 #include <sys/msg.h>
@@ -35,10 +37,12 @@ static int queue_id = -1;
 static int bad_id = -1;
 struct passwd *pw;

+#define MSGTYP 2
+
 static struct buf {
        long type;
        char mtext[MSGSIZE];
-} rcv_buf, snd_buf = {MSGTYPE, "hello"};
+} rcv_buf, snd_buf = {MSGTYP, "hello"};

 static struct tcase {
        int *id;
@@ -49,12 +53,14 @@ static struct tcase {
        int exp_user;
        int exp_err;
 } tcases[] = {
-       {&queue_id, &rcv_buf, 4, 1, 0, 0, E2BIG},
-       {&queue_id, &rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
-       {&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
-       {&bad_id, &rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
-       {&queue_id, &rcv_buf, -1, 1, 0, 0, EINVAL},
-       {&queue_id, &rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
+       {&queue_id, &rcv_buf, 4, MSGTYP, 0, 0, E2BIG},
+       {&queue_id, &rcv_buf, MSGSIZE, MSGTYP, 0, 1, EACCES},
+       {&queue_id, NULL, MSGSIZE, MSGTYP, 0, 0, EFAULT},
+       {&bad_id, &rcv_buf, MSGSIZE, MSGTYP, 0, 0, EINVAL},
+       {&queue_id, &rcv_buf, -1, MSGTYP, 0, 0, EINVAL},
+       {&queue_id, &rcv_buf, MSGSIZE, MSGTYP+1, IPC_NOWAIT, 0, ENOMSG},
+       {&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT, 0, ENOMSG},
+       {&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT | MSG_EXCEPT, 0, ENOMSG},
 };


What do you think?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
