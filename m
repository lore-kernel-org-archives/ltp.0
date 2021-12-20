Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1128DC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 09:53:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE393C917D
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 10:53:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 727FD3C6AD0
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:53:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BFC2B1A00376
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 10:53:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFEF9218F6;
 Mon, 20 Dec 2021 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639994011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdUREv04H/i7J4UokBVil09oNGcMPFgJu9i1LZVLBSc=;
 b=Yka2YGAK+aey8nVFdfWpFhO/U5j4odpB1kqaH/yN5iYN5mwnLpaHlXRUjhEksceUYSXFen
 db/jIl9fl7pcGDvmVAgEFCRyyGnk/LJzhagYBqMqnPnX0mY5JkgZ0Eri15SKLLbf8JSaTk
 3iYqKWL+xzBkd0UJktyMFVkOgyX6Cso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639994011;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdUREv04H/i7J4UokBVil09oNGcMPFgJu9i1LZVLBSc=;
 b=yYNxfY7eWF85i9i22blAXC6PNAKgym17TWvKco9FucYUDiSDsLJtHa8hJEFqrUuq81QbTt
 jTiZFkNpCAoTsDAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C51AB13BFC;
 Mon, 20 Dec 2021 09:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zy2NLptSwGH+GwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 09:53:31 +0000
Date: Mon, 20 Dec 2021 10:53:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YcBSmpdWBnx/L/XY@pevik>
References: <YbMyhM7/wqbGCdgk@yuki>
 <1640028184-20297-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1640028184-20297-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/write06: Add new test
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

Hi Dai,

> Like pwrite04.c, test the write() system call with O_APPEND.

...
> +++ b/testcases/kernel/syscalls/write/write06.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test the write() system call with O_APPEND.
> + *
> + * The full description of O_APPEND is in open(2) man-pages:
> + * O_APPEND
> + *        The file is opened in append mode.  Before each write(2), the
nit: FYI this formatting will be lost in our metadata.
(To see the output, you can run make metadata/ and check docparse/metadata.html
or docparse/metadata.pdf.)

...
> +static void verify_write(void)
> +{
> +	off_t off;
> +	struct stat statbuf;
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC);
> +	SAFE_WRITE(1, fd, write_buf[0], K2);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND);

Quite often I get EACCES when running the test. It's strange that not always.

$ ./write06
tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1423: TINFO: Timeout per run is 0h 05m 00s
write06.c:45: TBROK: open(write06_file,1026,4162714000) failed: EACCES (13)

IMHO this depends on umask (0022) in my case.
Obviously specifying permissions as it's in pwrite04.c fixes the problem:


@@ -38,7 +38,7 @@ static void verify_write(void)
 	off_t off;
 	struct stat statbuf;
 
-	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC);
+	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	SAFE_WRITE(1, fd, write_buf[0], K2);
 	SAFE_CLOSE(fd);

(pwrite04.c specifies permission in both SAFE_OPEN(), but it's obviously enough
to put it just in the first one, which uses O_CREAT).

Also Cyril noted using permissions in review of v1 patch:
https://lore.kernel.org/ltp/Ya9my0FdHXLqvkJr@yuki/

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
