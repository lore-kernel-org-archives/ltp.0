Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E77C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 09:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A4D53D2143
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 11:18:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D0ED3D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:18:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76C2660018E
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:18:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C72A225C7;
 Wed, 14 Aug 2024 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723627116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CzXY5r7Spnd+aGIPibvHYS2wtnZmPiWxflklJUSIYdc=;
 b=zrPJPyVoXgOI40Z0Y21a7byIPJrRg/hPlPVLvS5YfrQfA8RnvJw2VYsuXEQM7Pkeq27QwM
 /7fpYEPNQuJucuioC48jIluDdI/X3uzWol9g617sJh7Jt6zZ72daRLUjkQEGJj9SfFe/4+
 TCN5nbdGDLcz0BEUJfWdLYIL891+fUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723627116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CzXY5r7Spnd+aGIPibvHYS2wtnZmPiWxflklJUSIYdc=;
 b=tl41PfoulTWkrNHfWmfhkuOmdAkQAvUw4klmUkwb93U6q70ezerrBlORc/8d4V36ttAlhR
 TefVGflUdCFgOEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723627116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CzXY5r7Spnd+aGIPibvHYS2wtnZmPiWxflklJUSIYdc=;
 b=zrPJPyVoXgOI40Z0Y21a7byIPJrRg/hPlPVLvS5YfrQfA8RnvJw2VYsuXEQM7Pkeq27QwM
 /7fpYEPNQuJucuioC48jIluDdI/X3uzWol9g617sJh7Jt6zZ72daRLUjkQEGJj9SfFe/4+
 TCN5nbdGDLcz0BEUJfWdLYIL891+fUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723627116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CzXY5r7Spnd+aGIPibvHYS2wtnZmPiWxflklJUSIYdc=;
 b=tl41PfoulTWkrNHfWmfhkuOmdAkQAvUw4klmUkwb93U6q70ezerrBlORc/8d4V36ttAlhR
 TefVGflUdCFgOEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC1DC13B21;
 Wed, 14 Aug 2024 09:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jTUuKCZ0vGYZbgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 14 Aug 2024 09:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Aug 2024 11:08:48 +0200
MIME-Version: 1.0
Message-Id: <20240814-landlock_remove_doc_stats-v1-1-b5821d0bb3de@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723626534; l=947;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=iOpzi2ZAZCRx7CYGLhq9A89WLpSuRNk0Hvdje9JdMdU=;
 b=Vr1b5vbnkCXrwuvawQ6jyGNyuYFRrtrW20ZZXh2osJbZYpG3JzTWhfePUtgodX6SLctIfumJp
 UAfIRhjVlcdBUoSBi3ttKtub2RvW8J1MMGmZ1+FjB+8eEj1i9osl1yU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH RESEND] Remove landlock from coverage stats
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

Following syscalls can be removed from the documentation coverage
statistics since we they are tested inside landlock testing suite:

- landlock_create_ruleset
- landlock_add_rule
- landlock_restrict_self

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index ac1220450..425f72257 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -88,6 +88,9 @@ def generate_syscalls_stats(_):
         'getpmsg',
         'putmsg',
         'putpmsg',
+        'landlock_create_ruleset',
+        'landlock_add_rule',
+        'landlock_restrict_self',
     ]
 
     # populate with not implemented, reserved, unmaintained syscalls defined

---
base-commit: 12588eee7bd3160d2492944be26aa69cb3d7cf6d
change-id: 20240814-landlock_remove_doc_stats-ea86b5538d50

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
