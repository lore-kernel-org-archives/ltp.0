Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A21BCCA471
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 09:50:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC2923CE145
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 11:49:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0033C7746
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 11:49:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 12F1F140026C
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 11:49:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6207B1F45B;
 Mon,  6 Oct 2025 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759744180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=APCL7CMhNo2A4NhtB8ODQYee4DmEGeNaa/MTn6Zn+PQ=;
 b=rb7YphKSki+EOA3fghyeDc9RzRq6iBp7D6Au5Odi2ZeHNSeQqoHGYaEH4MXB8htRVffK+p
 Xl6aAZGAHHRf9/KMcFU+Swjt78RhyheCB8NhX+TWpRRK25FRENXeJ2PrM/9VgwXNthR6VA
 TguZluo9yNXluRMN7ZQIcRb2TkONvt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759744180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=APCL7CMhNo2A4NhtB8ODQYee4DmEGeNaa/MTn6Zn+PQ=;
 b=fgxciojooFlPo5MOHnOAm2mYk/27sTE0I5QL087BjmZRqePkdnwI6yPoeumczXMVcW09jV
 vnTEu1thu+XlObCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rb7YphKS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fgxciojo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759744180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=APCL7CMhNo2A4NhtB8ODQYee4DmEGeNaa/MTn6Zn+PQ=;
 b=rb7YphKSki+EOA3fghyeDc9RzRq6iBp7D6Au5Odi2ZeHNSeQqoHGYaEH4MXB8htRVffK+p
 Xl6aAZGAHHRf9/KMcFU+Swjt78RhyheCB8NhX+TWpRRK25FRENXeJ2PrM/9VgwXNthR6VA
 TguZluo9yNXluRMN7ZQIcRb2TkONvt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759744180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=APCL7CMhNo2A4NhtB8ODQYee4DmEGeNaa/MTn6Zn+PQ=;
 b=fgxciojooFlPo5MOHnOAm2mYk/27sTE0I5QL087BjmZRqePkdnwI6yPoeumczXMVcW09jV
 vnTEu1thu+XlObCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 100C513700;
 Mon,  6 Oct 2025 09:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id St4+M7OQ42ioRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 06 Oct 2025 09:49:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Oct 2025 11:49:36 +0200
MIME-Version: 1.0
Message-Id: <20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com>
X-B4-Tracking: v=1; b=H4sIAK+Q42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMz3aLU3Pyy1PiS/JR83WQjy0RTC9NUiyQDQyWgjoKi1LTMCrBp0bG
 1tQDRx+dMXQAAAA==
X-Change-ID: 20251006-remove_todo-c29a585e8b01
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759744179; l=2184;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=nk0RaAutsGoaAVryCnzMtgJC54062QsURZo6RLwX/Ww=;
 b=TR61jBUo2/YxhDva0COmQjKt5jSUmR+UIFoiMNt7jyIbC2L9MAecLVtUN09Y3PjnTsebDPIks
 exzBt6+m0OFD3t4SxRc60YnteeeKFh/Wg4uzgFWIiFuQivgjWGCNK4W
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 6207B1F45B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Remove TODO
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

TODO file is not updated and it talks about goals we already reached via
new LTP documentation. In general, it contains generic and random topics
which none is updating anymore, so it's better to remove it in order to
create less confusion for new comers. If we really want to have a TODO
list, probably the best place would be doc/ folder.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 TODO | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/TODO b/TODO
deleted file mode 100644
index fe0a3ab9b..000000000
--- a/TODO
+++ /dev/null
@@ -1,39 +0,0 @@
-LTP TODO
---------
-
-
-Write more syscall tests
-~~~~~~~~~~~~~~~~~~~~~~~~
-
-Syscalls and new syscall flags are added to Linux kernel each development cycle
-and LTP still falls behind. Unfortunately there is no single place that would
-store comprehensive list of syscalls, but there are a few places to look at:
-
-One of the options would be looking at changes in man-pages git[1] in man2/
-directory to find out newly documented functionality.
-
-Another good source of information are kernel pages in LWN[2] weekly
-editions.
-
-Then there is linux-api mailing list[3] where changes in kernel userspace API
-should be discussed.
-
-[1] http://git.kernel.org/cgit/docs/man-pages/man-pages.git
-[2] http://lwn.net
-[3] http://dir.gmane.org/gmane.linux.kernel.api
-
-
-Rewrite old and add new controller testcases
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-We already started working on this with rewriting cgroup_fj testcases and
-newly added pids testcases. Have a look at testcases/kernel/controllers/.
-
-
-Shell tests cleanups
-~~~~~~~~~~~~~~~~~~~~
-
-There are numerous testcases written in shell that does not follow single style
-and use the broken-by-design binaries from tools/apicmds. These should be
-cleaned up and fixed to use the test.sh test library. These include most of
-tests in testcases/commands/ for example.

---
base-commit: d2550ffbbcfe163212cd7e9c132db65ae0fa06ed
change-id: 20251006-remove_todo-c29a585e8b01

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
