Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18835ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 17:35:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3032E3C1879
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 19:35:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A54053C0BC0
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 19:35:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4E1A100052E
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 19:35:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B71C11F7D2
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725903331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AXrWi/MvBuTrc6NZmXQrwdnPxigNaaIEfAOwcMDZh+s=;
 b=qO2FweruQR0mMb1Bvdhpk4oViTfgRK9XjPpuERD8k+nXohQzeRNb6zhkG6qIYWTio3ZniG
 UeJ4v8yG42kYvvU2ZHcgr8efRme+QxHSdGR8CJBqIFkeMLSjoqfnSr2rucv0TBCwrSdzxP
 5c75KnrpLVlsK3HpHCkq7JNwiNVuAKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725903331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AXrWi/MvBuTrc6NZmXQrwdnPxigNaaIEfAOwcMDZh+s=;
 b=eivMrZvgbKk33TjSp18e0joaRt3/AFswxw72o8FAgxd/jowLc6x+Yh60/ZdBKpd9+pmvnH
 skHWOmAwTpRI/UAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725903331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AXrWi/MvBuTrc6NZmXQrwdnPxigNaaIEfAOwcMDZh+s=;
 b=qO2FweruQR0mMb1Bvdhpk4oViTfgRK9XjPpuERD8k+nXohQzeRNb6zhkG6qIYWTio3ZniG
 UeJ4v8yG42kYvvU2ZHcgr8efRme+QxHSdGR8CJBqIFkeMLSjoqfnSr2rucv0TBCwrSdzxP
 5c75KnrpLVlsK3HpHCkq7JNwiNVuAKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725903331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AXrWi/MvBuTrc6NZmXQrwdnPxigNaaIEfAOwcMDZh+s=;
 b=eivMrZvgbKk33TjSp18e0joaRt3/AFswxw72o8FAgxd/jowLc6x+Yh60/ZdBKpd9+pmvnH
 skHWOmAwTpRI/UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5FC913A3A
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 17:35:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WXLJJeMx32ZOTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 17:35:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 19:35:30 +0200
MIME-Version: 1.0
Message-Id: <20240909-landlock_whitelist-v1-1-60c54aa9526d@suse.com>
X-B4-Tracking: v=1; b=H4sIAOIx32YC/x3MQQqAIBBA0avErBM0bDFdJSJEpxwSC40KpLsnL
 d/i/wKZElOGoSmQ6OLMe6xQbQPWm7iSYFcNney0RIkimOjCbrf59nxS4HwKtaBF7I0ip6GGR6K
 Fn386Tu/7AbSDo1RkAAAA
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725903331; l=908;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=A9TN1Ij8bMq57o3kMBvTLNiFzl7gTdg2PHBF/SJUI3M=;
 b=8OgY0Pjcnp/G71vEQqp9VHdjm+ELZscPrCtdQh01zNrMHQTTYHINKkB4i+45mBohe7Bb/0RRm
 y1Us6l9Z26wDXJdOoeanz83lvGhMp7OcvxE7Mbr/JL2r59BqUxiYRDh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add landlock syscalls to whitelist in statistics
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

Landlock syscalls are currently tested in the landlock testing suite and
there's no reason to consider them untested, so they can be added to the
statistics whitelist.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index c0346388e..7a3e9ec9f 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -90,6 +90,9 @@ def generate_syscalls_stats(_):
         'seccomp',
         'semtimedop',
         'sethostname',
+        'landlock_create_ruleset',
+        'landlock_add_rule',
+        'landlock_restrict_self',
     ]
 
     # populate with not implemented, reserved, unmaintained syscalls defined

---
base-commit: d60bdcc7c7ac4be6624302b909e4d38367652dda
change-id: 20240909-landlock_whitelist-1f9c995a1ed4

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
