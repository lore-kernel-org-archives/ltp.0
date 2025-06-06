Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1C5C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B1243CA3FB
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 15:59:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE4443C9AD4
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 15:59:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A1FC1400759
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 15:59:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 307151F445;
 Fri,  6 Jun 2025 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749218361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnzmrUMz47oywaWR0qqHWhToeFt/LN3sjB6osH+bK8k=;
 b=lEAfSv8JWybBHjp2LLkrsLyU3PZHIPSkWnhD/ujXPLk/j//0uuQYxFrYBiELG+s/IR5Vg6
 HbIJEMv16iKG76jiXUuROmjmsI/qR/NLM+IEZIHYC9/NoaUpkdcWZVYVJpYOlM9ecYHoyL
 YWOtwn6hNinb4q43Y5Pg2g4fnrE+5o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749218361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnzmrUMz47oywaWR0qqHWhToeFt/LN3sjB6osH+bK8k=;
 b=m3aEPhbgoRDoFcTBV9jKmUJbG53ICuMNNHilJX2ntSCFrn0OuTLXEa5eKYmAVMDKLfVvt0
 9PI/dtzFtE2wmhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749218361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnzmrUMz47oywaWR0qqHWhToeFt/LN3sjB6osH+bK8k=;
 b=lEAfSv8JWybBHjp2LLkrsLyU3PZHIPSkWnhD/ujXPLk/j//0uuQYxFrYBiELG+s/IR5Vg6
 HbIJEMv16iKG76jiXUuROmjmsI/qR/NLM+IEZIHYC9/NoaUpkdcWZVYVJpYOlM9ecYHoyL
 YWOtwn6hNinb4q43Y5Pg2g4fnrE+5o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749218361;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xnzmrUMz47oywaWR0qqHWhToeFt/LN3sjB6osH+bK8k=;
 b=m3aEPhbgoRDoFcTBV9jKmUJbG53ICuMNNHilJX2ntSCFrn0OuTLXEa5eKYmAVMDKLfVvt0
 9PI/dtzFtE2wmhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 172B61336F;
 Fri,  6 Jun 2025 13:59:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +kQjBDn0QmjyCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 13:59:21 +0000
Date: Fri, 6 Jun 2025 15:59:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606135919.GA1312985@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-4-0b5cff90c21c@suse.com>
 <20250606112720.GC1289709@pevik>
 <DAFF0QSC0XFW.12UHYZ9YEBXPT@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DAFF0QSC0XFW.12UHYZ9YEBXPT@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/8] syscalls/mknod04: Convert to new API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

> > +++ testcases/kernel/syscalls/mknod/mknod04.c
> > @@ -17,6 +17,7 @@
> >  #include "tst_test.h"

> >  #define MODE_RWX 0777
> > +#define MODE_FIFO (S_IFIFO | 0777)
> >  #define MODE_SGID (S_ISGID | 0777)

> >  #define TEMP_DIR "testdir"
> > @@ -29,7 +30,7 @@ static void run(void)
> >  {
> >  	struct stat buf;

> > -	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
> > +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO, 0);

> >  	SAFE_STAT(TEMP_NODE, &buf);
> >  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, 0);

> Can you please also apply this one:

> diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
> index 4b7e9577266e..34611b57ee92 100644
> --- a/testcases/kernel/syscalls/mknod/mknod05.c
> +++ b/testcases/kernel/syscalls/mknod/mknod05.c
> @@ -18,6 +18,7 @@

>  #define MODE_RWX 0777
>  #define MODE_SGID (S_ISGID | 0777)
> +#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)

>  #define TEMP_DIR "testdir"
>  #define TEMP_NODE TEMP_DIR "/testnode"
> @@ -29,7 +30,7 @@ static void run(void)
>  {
>  	struct stat buf;

> -	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
> +	SAFE_MKNOD(TEMP_NODE, MODE_FIFO_SGID, 0);

>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, S_ISGID);

> Thanks a lot,

Sure. Yeah, both mknod[45].c should use also S_IFIFO for both mknod() and
chmod(). Changed both.

Merged the rest of the patchset, thank you for the rewrite!

As there were quite a lot of changes, here is the following diff for mknod[3-8].c.

Kind regards,
Petr

> RBM

diff --git testcases/kernel/syscalls/mknod/mknod03.c testcases/kernel/syscalls/mknod/mknod03.c
index 00a6133f7a..8cb9be9287 100644
--- testcases/kernel/syscalls/mknod/mknod03.c
+++ testcases/kernel/syscalls/mknod/mknod03.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
  *	07/2001 Ported by Wayne Boyer
diff --git testcases/kernel/syscalls/mknod/mknod04.c testcases/kernel/syscalls/mknod/mknod04.c
index ceb9565b4d..441894b3b9 100644
--- testcases/kernel/syscalls/mknod/mknod04.c
+++ testcases/kernel/syscalls/mknod/mknod04.c
@@ -17,7 +17,8 @@
 #include "tst_test.h"
 
 #define MODE_RWX 0777
-#define MODE_SGID (S_ISGID | 0777)
+#define MODE_FIFO (S_IFIFO | 0777)
+#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)
 
 #define TEMP_DIR "testdir"
 #define TEMP_NODE TEMP_DIR "/testnode"
@@ -29,7 +30,7 @@ static void run(void)
 {
 	struct stat buf;
 
-	SAFE_MKNOD(TEMP_NODE, MODE_RWX, 0);
+	SAFE_MKNOD(TEMP_NODE, MODE_FIFO, 0);
 
 	SAFE_STAT(TEMP_NODE, &buf);
 	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, 0);
@@ -48,7 +49,7 @@ static void setup(void)
 
 	SAFE_MKDIR(TEMP_DIR, MODE_RWX);
 	SAFE_CHOWN(TEMP_DIR, nobody_uid, free_gid);
-	SAFE_CHMOD(TEMP_DIR, MODE_SGID);
+	SAFE_CHMOD(TEMP_DIR, MODE_FIFO_SGID);
 
 	SAFE_SETGID(nobody_gid);
 	SAFE_SETREUID(-1, nobody_uid);
diff --git testcases/kernel/syscalls/mknod/mknod05.c testcases/kernel/syscalls/mknod/mknod05.c
index 4b7e957726..bfac9227b9 100644
--- testcases/kernel/syscalls/mknod/mknod05.c
+++ testcases/kernel/syscalls/mknod/mknod05.c
@@ -7,8 +7,8 @@
 
 /*\
  * Verify that mknod(2) succeeds when used to create a filesystem node with
- * set group-ID bit set on a directory with set group-ID bit set. The node
- * created should have set group-ID bit set and its gid should be equal to
+ * set-group-ID bit set on a directory with set-group-ID bit set. The node
+ * created should have set-group-ID bit set and its gid should be equal to
  * that of its parent directory.
  */
 
@@ -17,7 +17,7 @@
 #include "tst_test.h"
 
 #define MODE_RWX 0777
-#define MODE_SGID (S_ISGID | 0777)
+#define MODE_FIFO_SGID (S_IFIFO | S_ISGID | 0777)
 
 #define TEMP_DIR "testdir"
 #define TEMP_NODE TEMP_DIR "/testnode"
@@ -29,7 +29,7 @@ static void run(void)
 {
 	struct stat buf;
 
-	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);
+	SAFE_MKNOD(TEMP_NODE, MODE_FIFO_SGID, 0);
 
 	SAFE_STAT(TEMP_NODE, &buf);
 	TST_EXP_EQ_LI(buf.st_mode & S_ISGID, S_ISGID);
@@ -48,7 +48,7 @@ static void setup(void)
 
 	SAFE_MKDIR(TEMP_DIR, MODE_RWX);
 	SAFE_CHOWN(TEMP_DIR, nobody_uid, free_gid);
-	SAFE_CHMOD(TEMP_DIR, MODE_SGID);
+	SAFE_CHMOD(TEMP_DIR, MODE_FIFO_SGID);
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
