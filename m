Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964AC43458
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 08:34:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD1793E2EEF
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 10:34:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425F43C08A7
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:34:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5FEB31A0014E
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 10:34:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17FF773A11;
 Wed,  1 Jul 2026 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782894872;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yShla7DtmkanK4aTE/lOpdEr7/U5LjumHsIzFhQVmFQ=;
 b=wrARmac4x5jpDms4dC1eDFEsIgbwFLz5PePpl5MHKYrF5b28jhHPiyIP4auBcccAD71g9C
 QgOarMrbDP0UBd2yube+Me7b3RLKYsdQ6n36Bjd1gir7eFCJZy3QGRnbDLyeGt2dLrFaDl
 2v6LH43YuC+1fRnhGS4qNxxOe9zalyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782894872;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yShla7DtmkanK4aTE/lOpdEr7/U5LjumHsIzFhQVmFQ=;
 b=v4opFpy2Bpei/cVWK/20DFswjlXIiIfst99mNeq7WbjqxPNHnCzb/YPVjvYIXiebUCNjpG
 IORhwGXzziMdQqCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782894872;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yShla7DtmkanK4aTE/lOpdEr7/U5LjumHsIzFhQVmFQ=;
 b=wrARmac4x5jpDms4dC1eDFEsIgbwFLz5PePpl5MHKYrF5b28jhHPiyIP4auBcccAD71g9C
 QgOarMrbDP0UBd2yube+Me7b3RLKYsdQ6n36Bjd1gir7eFCJZy3QGRnbDLyeGt2dLrFaDl
 2v6LH43YuC+1fRnhGS4qNxxOe9zalyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782894872;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yShla7DtmkanK4aTE/lOpdEr7/U5LjumHsIzFhQVmFQ=;
 b=v4opFpy2Bpei/cVWK/20DFswjlXIiIfst99mNeq7WbjqxPNHnCzb/YPVjvYIXiebUCNjpG
 IORhwGXzziMdQqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A18779AA;
 Wed,  1 Jul 2026 08:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GhaYORfRRGrNWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 01 Jul 2026 08:34:31 +0000
Date: Wed, 1 Jul 2026 10:34:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260701083422.GA477554@pevik>
References: <20260616052452.8353-2-wegao@suse.com>
 <20260616093119.8654-1-wegao@suse.com>
 <20260616093119.8654-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616093119.8654-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] connect01: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

to speedup I dared to merge with following diff.

My changes are:
* use designated initializers
* improve doc
* specify salen only     when not detectable
* void => struct sockaddr_in

Thanks!

Kind regards,
Petr

+++ testcases/kernel/syscalls/connect/connect01.c
@@ -1,11 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) Linux Test Project, 2006-2026
  */
 
 /*\
- * Verify that :manpage:`connect(2)` returns the proper errno for various failure cases.
+ * Verify that :manpage:`connect(2)` fails with -1 and sets proper errno:
+ *
+ * - EBADF if sockfd is not a valid open file descriptor
+ * - EFAULT if socket structure address is outside the user's address space
+ * - EINVAL if addrlen is not valid
+ * - ENOTSOCK if file descriptor sockfd does not refer to a socket
+ * - EISCONN if socket is already connected
+ * - ECONNREFUSED if connect on a socket found nothing listening on remote address
+ * - EAFNOSUPPORT if address doesn't have the correct address family in sa_family
  */
 
 #include <sys/types.h>
@@ -30,25 +38,25 @@ static pid_t pid;
 
 static struct test_case_t {
 	int *fd;
-	void *addr;
+	struct sockaddr_in *addr;
 	socklen_t salen;
 	int exp_errno;
 	char *desc;
 } tcases[] = {
-	{&fd_invalid, &sock1, sizeof(sock1), EBADF,
-		"sockfd is not a valid open file descriptor"},
-	{&fd_socket, NULL, sizeof(sock1), EFAULT,
-		"socket structure address is outside the user's address space"},
-	{&fd_socket, &sock1, 3, EINVAL,
-		"addrlen is not valid"},
-	{&fd_null, &sock1, sizeof(sock1), ENOTSOCK,
-		"file descriptor sockfd does not refer to a socket"},
-	{&fd_connected, &sock1, sizeof(sock1), EISCONN,
-		"socket is already connected"},
-	{&fd_socket, &sock2, sizeof(sock2), ECONNREFUSED,
-		"connect on a socket found no one listening on remote address"},
-	{&fd_socket, &sock3, sizeof(sock3), EAFNOSUPPORT,
-		"address doesn't have the correct address family in sa_family"},
+	{ .fd = &fd_invalid, .addr = &sock1, .exp_errno = EBADF,
+		.desc = "sockfd is not a valid open file descriptor"},
+	{ .fd = &fd_socket, .salen = sizeof(sock1), .exp_errno = EFAULT,
+		.desc = "socket structure address is outside the user's address space"},
+	{ .fd = &fd_socket, .addr = &sock1, .salen = 3, .exp_errno = EINVAL,
+		.desc = "addrlen is not valid"},
+	{ .fd = &fd_null, .addr = &sock1, .exp_errno = ENOTSOCK,
+		.desc = "file descriptor sockfd does not refer to a socket"},
+	{ .fd = &fd_connected, .addr = &sock1, .exp_errno = EISCONN,
+		.desc = "socket is already connected"},
+	{ .fd = &fd_socket, .addr = &sock2, .exp_errno = ECONNREFUSED,
+		.desc = "connect on a socket found nothing listening on remote address"},
+	{ .fd = &fd_socket, .addr = &sock3, .exp_errno = EAFNOSUPPORT,
+		.desc = "address doesn't have the correct address family in sa_family"},
 };
 
 static int sys_connect(int sockfd, const struct sockaddr *addr,
@@ -126,8 +134,9 @@ static void verify_connect(unsigned int i)
 {
 	struct test_case_t *tc = &tcases[i];
 	void *addr = tc->addr ? tc->addr : bad_addr;
+	socklen_t salen = tc->salen ?: sizeof(*tc->addr);
 
-	TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+	TST_EXP_FAIL(sys_connect(*tc->fd, addr, salen),
 		     tc->exp_errno, "%s", tc->desc);
 }
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
