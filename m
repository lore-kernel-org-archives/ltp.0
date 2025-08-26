Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CECA0FE7
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 13:21:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5633C3CB852
	for <ltp@archiver.kernel.org>; Tue, 26 Aug 2025 15:21:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4013C2A7B
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FC0320009B
 for <ltp@lists.linux.it>; Tue, 26 Aug 2025 15:20:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D02CC2119D;
 Tue, 26 Aug 2025 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT5Rxc4dlq9IOVi2xYCUuLdMBnYbcht9OtRKVxlHcdk=;
 b=vG6G8KuREBJClXprsKnkfSJmL5RmpmQncC3o5riawP7WszFQC4jyabnUm7Hfxhvk22Ns5c
 7Bsb0XynlyBRAmbgXJDu6NiHmJDlKrLYMR+q23sMuZ4zs6pJF9BGzfVK4gJM4Ttce+kTVq
 XtCRPsEbQlmjMzKCE89vPdpLd7nRNpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT5Rxc4dlq9IOVi2xYCUuLdMBnYbcht9OtRKVxlHcdk=;
 b=cDCX/SfJ4vNOsQk4zAVc8E97se4Tvn4Ku/ArmZ1Pzfs6gxdDqJS1j4DcfUp+JFeJrX1kqe
 gJZeD1zj1KmdPeBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EC3Skmwf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9uqUMUYu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756214441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT5Rxc4dlq9IOVi2xYCUuLdMBnYbcht9OtRKVxlHcdk=;
 b=EC3SkmwfeSWRTlPlL/VYLWQtUvPBmVP7fIBXdWR86lINiH7Xl2Z+uoXcmgd1gfiiJECnNs
 BPG3WqOX981NUJ2G8OaIGD+N2ASZC8zrZQWHlGhao2mItGpR1TnKv74jVBTeRVkwiRWz7V
 V+XEZJOfX8UzKSOlvnj28HMCAk3O0P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756214441;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WT5Rxc4dlq9IOVi2xYCUuLdMBnYbcht9OtRKVxlHcdk=;
 b=9uqUMUYuoOV3QHXtxzMAEYZrW7O7T40xx5KjRYrjnCoH++mIK2T6xm+/bPnyz38I30Jmo7
 K0gXGoIAcrussRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97CCB13A31;
 Tue, 26 Aug 2025 13:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QNv3Hqm0rWhMLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 26 Aug 2025 13:20:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 26 Aug 2025 15:20:38 +0200
MIME-Version: 1.0
Message-Id: <20250826-upgrade_tools-v1-1-1e9d8d4c5e2f@suse.com>
References: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
In-Reply-To: <20250826-upgrade_tools-v1-0-1e9d8d4c5e2f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756214440; l=457;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=VY5sVQ3Ni2/t6wnyQD3Yl/2fEPB/Mv8DScYIoecTkx0=;
 b=4wMJzmhhYzl0MCQt/8Brd7U/6/l7uPuXeeNN2/M3yelNM3FdRYERDzPhjBdEd0S8Fwr7KiQHF
 XYszC18sNQjDmgnaorT2iSCR/dEHCDT9miIcwA0NtkXxUTcNdviXGWh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D02CC2119D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] kirk: version 2.2.2
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index a2d43e302171ff62a717ec25eebbc0b6f8a3fe3e..20b1870b964c9b8b83aa0a9cc860a5bbd146559c 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit a2d43e302171ff62a717ec25eebbc0b6f8a3fe3e
+Subproject commit 20b1870b964c9b8b83aa0a9cc860a5bbd146559c

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
