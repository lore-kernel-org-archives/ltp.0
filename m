Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8980C6FD1F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:21:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7102C3CFFB0
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:21:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224823CFBF6
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA53E1A01212
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D14E8347BD;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1WEH6W7DaIMMXJgWeJcuG2UmYCLVfehrB49rzcPzvM=;
 b=KzPr0/rCdr5FZ+Od6QsyIKYnpdUbppiN/gjnQjBDYGdTqDAz6HCRuf78Gg7GI6F0TtQSrl
 P+qwqBGYnY063lZtvC9BtL5Fz3tnMmmpho61OBbNyTLY2+BtGA90PdY02RcpaJoSWsjjpt
 AHbNHWCITulF0MNXbkUhmnoYG94/Vik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1WEH6W7DaIMMXJgWeJcuG2UmYCLVfehrB49rzcPzvM=;
 b=tUQdIxvpY+/Zl3Oc4I6AAHcGuncac4gFr3HkhDPH0k0Z4bXUn6bGVr+kZJO/SKrtNEpWGH
 q1TV7A77QjN760Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1WEH6W7DaIMMXJgWeJcuG2UmYCLVfehrB49rzcPzvM=;
 b=mhjCJJWW+/DE41OIxpsT/DqzhUFjKYx1dFVXzBcYobcS3ZCa98p6knwTgFbj/pmi5NcPAZ
 xYWMjtDpaEBicIv3lTqIoofH6J3LH4075+N1AWxE4BLgL3k41PPQg9bS6NSeD8ZQ+N/yD7
 CWTHN1YhwDCZadS1LPyaaH3uWE+KMbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1WEH6W7DaIMMXJgWeJcuG2UmYCLVfehrB49rzcPzvM=;
 b=IuKx2FtLoyHunuE44d+Htdsou3APjZMCqOkQ6CBSiFoYOlVhRGACpKUi3zLsuF1a7QOKVD
 PVZAl0zuMumH5DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB8961397F;
 Wed, 20 Mar 2024 16:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oD58LN4M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:51 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-7-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mhjCJJWW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IuKx2FtL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[22.09%]
X-Rspamd-Queue-Id: D14E8347BD
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/10] Refactor LTP library guidelines documentation
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

The LTP library guidelines documentation has been refactored,
simplifying the overall structure, cleaning up the make check error
messages which were moved into the test writing guidelines.
---
 doc_new/developers/ltp_library.rst | 42 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/doc_new/developers/ltp_library.rst b/doc_new/developers/ltp_library.rst
index b780b6870..85b69c11c 100644
--- a/doc_new/developers/ltp_library.rst
+++ b/doc_new/developers/ltp_library.rst
@@ -1,4 +1,42 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
-LTP Library development
-=======================
+LTP Library guidelines
+======================
+
+General Rules
+-------------
+
+When we extend library API, we need to apply the same general rules that we use
+when writing tests, plus:
+
+#. LTP library tests must go inside ``lib/newlib_tests`` directory
+#. LTP documentation has to be updated according to API changes
+
+Shell API
+---------
+
+API source code is in ``tst_test.sh``, ``tst_security.sh`` and ``tst_net.sh``
+(all in ``testcases/lib`` directory).
+
+Changes in the shell API should not introduce uncommon dependencies
+(use basic commands installed everywhere by default).
+
+Shell libraries
+~~~~~~~~~~~~~~~
+
+Aside from shell API libraries in ``testcases/lib``, it's worth putting
+common code for a group of tests into a shell library. The filename
+should end with ``_lib.sh`` and the library should load ``tst_test.sh`` or
+``tst_net.sh``.
+
+Shell libraries should have conditional expansion for ``TST_SETUP`` or
+``TST_CLEANUP``, to avoid surprises when test specific setup/cleanup function is
+redefined by shell library.
+
+.. code-block:: bash
+
+    # ipsec_lib.sh
+    # SPDX-License-Identifier: GPL-2.0-or-later
+    TST_SETUP="${TST_SETUP:-ipsec_lib_setup}"
+    ...
+    . tst_test.sh

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
