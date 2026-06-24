Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA771CDB47C
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:20:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31EE53E5334
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:20:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6BF3E5377
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5D12200AC6
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEF4C713D7
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqCyMe03HXwg5/DX8p3cK3Vz5Ym8M+UqqJe/RdIrIgw=;
 b=IuAQ6QDs+8o7ubIIObRJ+xEXS8IXeG4+SzERtjWSafpjjt3AHxH0KQIm7yNX9acoSABVVb
 JAjy/ofiXM6gXN0d7vc6bmB6DEopzoXopMZKz/JqPAJEf1qDfbEob9aACpV3Pct5zfodtX
 tJG6lZKplU2uddjbHROvp91q9IjZpKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqCyMe03HXwg5/DX8p3cK3Vz5Ym8M+UqqJe/RdIrIgw=;
 b=rujgLMAdkwVDGrbygoicuvpoxkcag9pynBWiJADVM75X4zzhA3xODuMmakOJXCYFgJ4wGR
 eRA5JzLUDCb4b0Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqCyMe03HXwg5/DX8p3cK3Vz5Ym8M+UqqJe/RdIrIgw=;
 b=IuAQ6QDs+8o7ubIIObRJ+xEXS8IXeG4+SzERtjWSafpjjt3AHxH0KQIm7yNX9acoSABVVb
 JAjy/ofiXM6gXN0d7vc6bmB6DEopzoXopMZKz/JqPAJEf1qDfbEob9aACpV3Pct5zfodtX
 tJG6lZKplU2uddjbHROvp91q9IjZpKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqCyMe03HXwg5/DX8p3cK3Vz5Ym8M+UqqJe/RdIrIgw=;
 b=rujgLMAdkwVDGrbygoicuvpoxkcag9pynBWiJADVM75X4zzhA3xODuMmakOJXCYFgJ4wGR
 eRA5JzLUDCb4b0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC52779AF
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BiGWKAahO2pQAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:02 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:18:52 +0200
Message-ID: <20260624091900.4107041-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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

Unlike the C library the shell metadata parser does not process the
JSON, hence the tags are added manually.

Since we have just a few shell tests, automatic group discovery is not
worth the effort. If we get more shell tests we will need to rewrite the
shell metadata parser to load the JSON into a memory, modify it, and
then save it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/keyctl/keyctl01.sh | 3 +++
 testcases/kernel/mem/vma/vma05.sh     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 514b6b8bf..2b2244fae 100755
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -22,6 +22,9 @@
 #  "save_restore": [
 #   ["/proc/sys/kernel/keys/root_maxbytes", null, "TCONF"]
 #  ],
+#  "groups": [
+#   "keyctl", "cve", "regression"
+#  ],
 #  "tags": [
 #   ["linux-git", "38327424b40bcebe2de92d07312c89360ac9229a"],
 #   ["CVE", "2016-4470"]
diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index b9654e80c..497abf34f 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -34,6 +34,9 @@
 #       "cmd": "uname"
 #     }
 #   ],
+#  "groups": [
+#   "vsyscall", "regression"
+#  ],
 #  "save_restore": [
 #   ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
 #   ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
