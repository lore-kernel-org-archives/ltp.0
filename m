Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ECDC25B74
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 11:33:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F22E3D01C1
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 13:33:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC70A3D00E1
 for <ltp@lists.linux.it>; Fri, 24 May 2024 13:33:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7432E603463
 for <ltp@lists.linux.it>; Fri, 24 May 2024 13:33:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A40521D6D;
 Fri, 24 May 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59F7B13A80;
 Fri, 24 May 2024 11:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7wvdFPh6UGaGeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 24 May 2024 11:33:12 +0000
Date: Fri, 24 May 2024 13:33:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZlB6-BvuMMVfhr_t@yuki>
References: <20240523155932.26393-1-chrubis@suse.cz>
 <233cf26a-3b1a-47db-90a4-764a95601699@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <233cf26a-3b1a-47db-90a4-764a95601699@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6A40521D6D
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/msgstress01: Fix off by one in array
 access
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
> I'd at least add a check that size == data.len + 1.

Which is not true actually because we always send a 100 bytes of data
regardless the message size, which is probably another oversight.

So let's keep the test as it is for now and I will do more work on it
after the release.

To fix this we would have to do at least, but I do not want to change
the test at this point just before the release:

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index b6a64cf4f..f0da595cd 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -109,7 +109,7 @@ static void writer(const int id, const int pos)
        int iter = num_iterations;

        while (--iter >= 0 && !(*stop)) {
-               int size = msgsnd(id, &buff->msg, 100, IPC_NOWAIT);
+               int size = msgsnd(id, &buff->msg, buff->msg.data.len + 1, IPC_NOWAIT);

                if (size < 0) {
                        if (errno == EAGAIN) {
@@ -160,6 +160,15 @@ static void reader(const int id, const int pos)
                        return;
                }

+               if (msg_recv.data.len + 1 != size) {
+                       tst_res(TFAIL,
+                               "Wrong message size have %i expected %i",
+                               size, msg_recv.data.len+1);
+                       *stop = 1;
+                       *fail = 1;
+                       return;
+               }
+
                for (int i = 0; i < msg_recv.data.len; i++) {
                        if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
                                tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
