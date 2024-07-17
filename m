Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27236C3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:18:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B350C3D1AE8
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:18:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586D63D0C9E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:20 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2114206C4E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66D9A21A4D;
 Wed, 17 Jul 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZ8hkYT/hWbQSb5oTX03UBDXMc/+EgsBLlE2tUKUigg=;
 b=U93/Lv0TJzGYatyqWS7sKr+mNkJv9Mwml+5mL7vSfWuEeKQmGtvyVYPwHRgNuWajwWmcO9
 qu3F18XHRyeWW50WmrOKtOehlwidtEhaCmZYP/ek84qVmO6issynN9xHgXrdZbrpYLQtln
 MDsMJqF5nzrSCuISdjtZpx93LyEbyuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZ8hkYT/hWbQSb5oTX03UBDXMc/+EgsBLlE2tUKUigg=;
 b=L1BD0Iqk0vJ9jtTpK6D2fIYVI1viPoTZEzXg0HU6FT77l/Ps/tbAdijAM6frNimceHXiqt
 BMGMTWXWmMJCsSAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZ8hkYT/hWbQSb5oTX03UBDXMc/+EgsBLlE2tUKUigg=;
 b=U93/Lv0TJzGYatyqWS7sKr+mNkJv9Mwml+5mL7vSfWuEeKQmGtvyVYPwHRgNuWajwWmcO9
 qu3F18XHRyeWW50WmrOKtOehlwidtEhaCmZYP/ek84qVmO6issynN9xHgXrdZbrpYLQtln
 MDsMJqF5nzrSCuISdjtZpx93LyEbyuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZ8hkYT/hWbQSb5oTX03UBDXMc/+EgsBLlE2tUKUigg=;
 b=L1BD0Iqk0vJ9jtTpK6D2fIYVI1viPoTZEzXg0HU6FT77l/Ps/tbAdijAM6frNimceHXiqt
 BMGMTWXWmMJCsSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD18136E5;
 Wed, 17 Jul 2024 17:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPA9DZ78l2ZQOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:17:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 19:17:10 +0200
Message-ID: <20240717171713.687339-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717171713.687339-1-pvorel@suse.cz>
References: <20240717171713.687339-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [1.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] configure: Print info about KVM testsuite in
 summary
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

KVM testsuite cannot be disabled by user, it's disabled when missing
KVM linker script support. Yet it's useful to print this info in the
configure summary.

Fixes: 959146f954 ("configure: Check for KVM linker script support")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8f8003f53b..a8e40a5fc0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -430,10 +430,12 @@ AC_LINK_IFELSE([AC_LANG_PROGRAM()],
   [
     AC_MSG_RESULT([yes])
     AC_SUBST([WITH_KVM_TESTSUITE],["yes"])
+    have_kvm=yes
   ],
   [
     AC_MSG_RESULT([no])
     AC_SUBST([WITH_KVM_TESTSUITE],["no"])
+    have_kvm=no
   ])
 _AC_LANG_PREFIX[]FLAGS="$ltp_backup_flags"
 LDFLAGS="$ltp_backup_ldflags"
@@ -443,6 +445,7 @@ AC_OUTPUT
 cat << EOF
 
 TESTSUITES
+KVM testsuite: $have_kvm
 open posix testsuite: ${with_open_posix_testsuite:-no}
 realtime testsuite: ${with_realtime_testsuite:-no}
 TI-RPC testsuite: ${with_tirpc:-yes}
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
