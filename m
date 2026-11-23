Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C76606A31A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yiXNyPEQ;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXX0veV2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yiXNyPEQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cXX0veV2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF0CC3EAF9B
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A46C3EA995
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 17:23:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1517E200969
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 17:23:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E251D220A3
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795451007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl8QeT8e5GPzHIajWbRIe5Uzr9ml9eysPmNaY9cNuy0=;
 b=yiXNyPEQXXkmlr9bhYKBUbC2q6MriywZ97irhyCbOJmQMlhzWnt5aRgprXTisSgvS2L0GJ
 02mCv74vwj4fN5YWCVJLsA+SVEaWy3e8MMuTezIJ+t8Fe2t3ekf6V268bfekNLvouwaKSn
 9nndIq5dxIsfXHD3xPpzXvyVyIbW7kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795451007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl8QeT8e5GPzHIajWbRIe5Uzr9ml9eysPmNaY9cNuy0=;
 b=cXX0veV2d5ZuRHPV16H0qjn4vyzkt2cy4OOK0sTHCTidRT+qeQCtS9ynIEJ6mYE6omld+D
 HZ9A86Wu1WZC7WDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795451007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl8QeT8e5GPzHIajWbRIe5Uzr9ml9eysPmNaY9cNuy0=;
 b=yiXNyPEQXXkmlr9bhYKBUbC2q6MriywZ97irhyCbOJmQMlhzWnt5aRgprXTisSgvS2L0GJ
 02mCv74vwj4fN5YWCVJLsA+SVEaWy3e8MMuTezIJ+t8Fe2t3ekf6V268bfekNLvouwaKSn
 9nndIq5dxIsfXHD3xPpzXvyVyIbW7kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795451007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tl8QeT8e5GPzHIajWbRIe5Uzr9ml9eysPmNaY9cNuy0=;
 b=cXX0veV2d5ZuRHPV16H0qjn4vyzkt2cy4OOK0sTHCTidRT+qeQCtS9ynIEJ6mYE6omld+D
 HZ9A86Wu1WZC7WDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC9B013505
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KVZ9J39oBGvaUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:23:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 23 Nov 2026 17:23:57 +0100
Message-ID: <20261123162357.256048-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123162357.256048-1-chrubis@suse.cz>
References: <20261123162357.256048-1-chrubis@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] tools/apicmds: Remove tst_ncpus_max
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The tst_ncpus_max shell command has no users left in the tree, remove
it.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 tools/apicmds/.gitignore  | 1 -
 tools/apicmds/Makefile    | 2 +-
 tools/apicmds/ltpapicmd.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index 375e7e9b8..9402108e4 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -3,6 +3,5 @@ tst_brkm
 tst_exit
 tst_ncpus
 tst_ncpus_conf
-tst_ncpus_max
 tst_res
 tst_resm
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index b240a8958..b6c010bec 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -27,7 +27,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit \
-			     res resm ncpus ncpus_conf ncpus_max)
+			     res resm ncpus ncpus_conf)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 9725d2e41..0826d9071 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -258,8 +258,6 @@ int main(int argc, char *argv[])
 		printf("%li\n", tst_ncpus());
 	} else if (strcmp(cmd_name, "tst_ncpus_conf") == 0) {
 		printf("%li\n", tst_ncpus_conf());
-	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
-		printf("%li\n", tst_ncpus_max());
 	}
 
 	exit(0);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
