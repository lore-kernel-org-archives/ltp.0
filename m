Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A541CA0EC0
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 09:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9BEC3CB05D
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 11:34:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EAAA3C18F9
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 11:34:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BDCCE10007F5
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 11:34:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B605933718;
 Mon, 11 Aug 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E48A13A55;
 Mon, 11 Aug 2025 09:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ICZeJhW5mWgBfAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Aug 2025 09:34:13 +0000
Date: Mon, 11 Aug 2025 11:35:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <aJm5SBOaRoe1e0PB@yuki.lan>
References: <aJYBSmcQpbHUvOqW@stanley.mountain>
 <CAEemH2cBH+usbwMsHnDW=QM-qDKOCg2wp063O=1gtrRdqNFpug@mail.gmail.com>
 <aJmj6kmNvgzbd1Zi@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJmj6kmNvgzbd1Zi@stanley.mountain>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B605933718
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03.c is broken for 32bit compat mode
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
Cc: ltp@lists.linux.it, Theodore Grey <theodore.grey@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> To be honest, the correct thing with regards to shmall is to cap it at
> INT_MAX in the kernel as well.  I didn't want to suggest this because it
> was Friday afternoon.  Reporting whatever is in the low 32bits is sort
> of random.  But that would make it even more tricky to handle in LTP.

We have tst_is_compat_mode() helper that returns true if we are running
in 32bit compatibility mode. So I suppose that we need a flag for the
TST_ASSERT_ULONG() that would tell it to do a saturated comparsion:

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a3291c37f..5e33b3a2c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -16,6 +16,7 @@
 static void verify_ipcinfo(void)
 {
        struct shminfo info;
+       int flag = 0;

        TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));

@@ -30,9 +31,12 @@ static void verify_ipcinfo(void)
        else
                tst_res(TPASS, "shmmin = 1");

-       TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
-       TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
-       TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+       if (tst_is_compat_mode())
+               flag = TST_ASSERT_ULONG_SATURATED;
+
+       TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax, flag);
+       TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni, flag);
+       TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall, flag);
 }

And the TST_ASSERT_ULONG() would read the syfs file as unsigned long
long and if the saturated flag is present cap it at ULONG_MAX.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
