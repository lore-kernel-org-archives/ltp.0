Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3924606A326
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zQtQHJZY;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yVhuQIyC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=abEqJaTn;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=upcx2ay2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3859E3CCB68
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 19:33:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6504F3CCB68
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:33:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C4D4060013E
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 19:33:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 680801F388;
 Wed,  4 Nov 2026 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793817182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+leAtEi+SHagJRkdAzLp1fxLP0mAC7OlhBZUEL+bDE=;
 b=zQtQHJZYKKJN72VDMHXhqxD/TQwsvUU6rQBFkFWxhB3dV5PsXEg8H8U9+ndaikLVOxg0V7
 Dn27he/kN1He5PIiP8M0Aue63dYAI/gfNlwcE7clQMU48QHo6dLhZkhpY7A4HLWqAQVKm0
 Lh5NBRDBYOlvVWGWQ5itz0KRpbPf58o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793817182;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+leAtEi+SHagJRkdAzLp1fxLP0mAC7OlhBZUEL+bDE=;
 b=yVhuQIyClcwz17zQMLQ3sd5478EY8k8hdRqLqOqJ6vrPvmm4j2KmGedMZzUnfJf27pZ2UY
 wiF7fROfjvkA/aCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793817181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+leAtEi+SHagJRkdAzLp1fxLP0mAC7OlhBZUEL+bDE=;
 b=abEqJaTnyuqGxcCcvmBw7yDidQQQx9mwz+LNmqjoAb7gRopsknpsPG6AK5oXLfV0cCuxt3
 UEsUF0g7CyEW5AqsEFOnKTZzs5s7CaTnDZs0TxwFCb3mBlscChgze82iLUEHJJIFfNXJSD
 7MFt4IFCCgqMVgMyOinGtrX7hMEQtNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793817181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+leAtEi+SHagJRkdAzLp1fxLP0mAC7OlhBZUEL+bDE=;
 b=upcx2ay2+4zV6fKuWOrzcjt4sYRcglGDVBH4FOybTeKRddtjMat0LDOsvrz2QryoG8XmpP
 5kFCXjGpoJg1oDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ECC1134F0;
 Wed,  4 Nov 2026 18:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5uUcLVx662pLawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Nov 2026 18:33:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 19:32:59 +0100
Message-ID: <20261104183259.423259-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104164638.407069-1-sbertram@redhat.com>
References: <20261104164638.407069-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] accept03/tst_fd: Harden parallel runs against
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Concurrent syscall runs can TBROK in tst_fd when multiple processes
> race on fixed fd_file/fd_dir names (unlink ENOENT). Use pid-unique
> paths with O_EXCL, distinct names for the file and O_PATH cases.
> 
> This covers accept03, epoll_pwait06, ioctl_pidfd01, and splice07,
> which call TST_FD_FOREACH without a private tmpdir.

While this is smart (no more tests will have bug due missing .needs_tmpdir = 1),
I'm not sure if it's a good idea. There is a reason why we have .needs_tmpdir,
e.g. CWD is read-only, no cleanup of created files, etc.

That's why I'd prefer to fix the 3 tests (add .needs_tmpdir) and then:

1) either add a check for missing .needs_tmpdir for these functions (patch
below) or
2) enable temporary directory creation for each test (slower, but no need to
ever worry).

The approach bellow is not ideal, because it covers only this case.
But adding check to safe_open() (and other functions) would have to check if the
path is relative or not, for which I would not bloat the library code.

Therefore I sent a patch checking this via sparse ('make check'):

https://lore.kernel.org/ltp/20261104182800.421758-1-pvorel@suse.cz/T/#u

Kind regards,
Petr

commit fa68043e5948ff1b8cb2c647d309ccf4808e23d7
Author: Petr Vorel <pvorel@suse.cz>
Date:   2026-11-04 18:34:06 +0100

    tst_fd: Add check for missing .needs_tmpdir

    Signed-off-by: Petr Vorel <pvorel@suse.cz>

diff --git lib/tst_fd.c lib/tst_fd.c
index 6538a098c7..05e1bbe8b0 100644
--- lib/tst_fd.c
+++ lib/tst_fd.c
@@ -22,6 +22,8 @@
 #include "lapi/bpf.h"
 #include "lapi/fsmount.h"
 
+#include "tso_tmpdir.h"
+
 #include "tst_fd.h"
 
 struct tst_fd_desc {
@@ -30,8 +32,17 @@ struct tst_fd_desc {
 	const char *desc;
 };
 
+static void require_tmpdir(struct tst_fd *fd)
+{
+	if (!tst_tmpdir_created()) {
+		tst_brk(TBROK, "%s fd requires .needs_tmpdir = 1",
+			tst_fd_desc(fd));
+	}
+}
+
 static void open_file(struct tst_fd *fd)
 {
+	require_tmpdir(fd);
 	fd->fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT, 0666);
 	SAFE_UNLINK("fd_file");
 }
@@ -40,6 +51,7 @@ static void open_path(struct tst_fd *fd)
 {
 	int tfd;
 
+	require_tmpdir(fd);
 	tfd = SAFE_CREAT("fd_file", 0666);
 	SAFE_CLOSE(tfd);
 
@@ -50,6 +62,7 @@ static void open_path(struct tst_fd *fd)
 
 static void open_dir(struct tst_fd *fd)
 {
+	require_tmpdir(fd);
 	SAFE_MKDIR("fd_dir", 0700);
 	fd->fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
 	SAFE_RMDIR("fd_dir");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
