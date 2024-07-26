Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE71C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:56:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 421B43D1C10
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 11:56:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66FDA3D1AC1
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:56:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A25510028A3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 11:56:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91C241F894;
 Fri, 26 Jul 2024 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721987759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVJKZTAGnic7JpX88GFefzGp7PwxxOv2mk211QurP+I=;
 b=ZzPrQeuuFIzSdxbtedGqd1KLiTUePAEFQcmsy5ovn10PU4L2CF1wZNbYJVKHpR9ovJdgMG
 ndTBwMvS/izfmL1Not8QTLChrMq009M0gAat+GJ0xx9xskhOFdlixFhKNuviOzth2NqB/u
 cUgk3qIVhsQU/6PfzU5CgUJ5jb+EZA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721987759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVJKZTAGnic7JpX88GFefzGp7PwxxOv2mk211QurP+I=;
 b=oVUHnagwTT7Q1hKYJsOhbWS3a5EApajLpDvaoGXYzyUBgaYS8eiEy+MGPJnITjcS7L8KQI
 aCRHxEeUkzpSDyBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721987759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVJKZTAGnic7JpX88GFefzGp7PwxxOv2mk211QurP+I=;
 b=ZzPrQeuuFIzSdxbtedGqd1KLiTUePAEFQcmsy5ovn10PU4L2CF1wZNbYJVKHpR9ovJdgMG
 ndTBwMvS/izfmL1Not8QTLChrMq009M0gAat+GJ0xx9xskhOFdlixFhKNuviOzth2NqB/u
 cUgk3qIVhsQU/6PfzU5CgUJ5jb+EZA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721987759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVJKZTAGnic7JpX88GFefzGp7PwxxOv2mk211QurP+I=;
 b=oVUHnagwTT7Q1hKYJsOhbWS3a5EApajLpDvaoGXYzyUBgaYS8eiEy+MGPJnITjcS7L8KQI
 aCRHxEeUkzpSDyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D8A713A9D;
 Fri, 26 Jul 2024 09:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GyRGa9yo2anTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 09:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Jul 2024 11:55:44 +0200
Message-ID: <20240726095546.1041726-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726095546.1041726-1-pvorel@suse.cz>
References: <20240726095546.1041726-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.60 / 50.00]; REPLY(-4.00)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lib: Print tested kernel and arch
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

This helps reviewing tests posted on ML or github issue
(reporters sometimes don't include this info).

Using interesting parts from struct utsname to get used linux
distribution, kernel version, release and architecture (less info than
when running 'uname -a', but other info is not much useful).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e5bc5bf4da..63221c5e9d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -13,6 +13,7 @@
 #include <errno.h>
 #include <sys/mount.h>
 #include <sys/types.h>
+#include <sys/utsname.h>
 #include <sys/wait.h>
 #include <math.h>
 
@@ -1793,6 +1794,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 {
 	int ret = 0;
 	unsigned int test_variants = 1;
+	struct utsname uval;
 
 	lib_pid = getpid();
 	tst_test = self;
@@ -1805,6 +1807,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	tst_res(TINFO, "LTP version: "LTP_VERSION);
 
+
+	uname(&uval);
+	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
+
 	if (tst_test->max_runtime)
 		results->max_runtime = multiply_runtime(tst_test->max_runtime);
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
