Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14505C6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 10:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59E6D3CBFF6
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 12:59:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDF0A3CB34B
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 12:59:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16FA3600A25
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 12:59:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C37B1FD8A;
 Wed, 19 Apr 2023 10:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681901959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Auz5AI2bkhFkx0kYB6j9fKwp+kreEIVxKq64EW1z+s0=;
 b=NEgQQ+SML9oO5erQGrJRn2bZf8xCNIjNDVShF1B3mhcdiyeoScfjtMDTdEfZ6sqS4RyTOs
 H6AJtHoigiRYJ42N30acZreTXtgXhKFJZ+ULq2sA3Z2Y51mXvhReNVP6lQcEPLcKoExHhC
 8F5+lMqmZZQ+ec/uIxO7VYpMNc8c8KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681901959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Auz5AI2bkhFkx0kYB6j9fKwp+kreEIVxKq64EW1z+s0=;
 b=EtRvBF1QnkJwAoSWKgH2GvLg6/2YhcBt6cWHJY9KNZbhTZva5vncu+MFRr+mSkL6sIG7mn
 AsghCEAYIWcGuOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 096EF1390E;
 Wed, 19 Apr 2023 10:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ISaQAYfJP2TtPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 19 Apr 2023 10:59:19 +0000
Date: Wed, 19 Apr 2023 13:00:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <ZD/JxunXsz7Lms9U@yuki>
References: <20230418130944.181716-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230418130944.181716-1-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setpgid02: Use pid_max as PGID for EPERM
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> In some simple systems (like Busybox), the login shell might be run
> as init (PID 1).
> This leads to a case where LTP is run in the same session as init,
> thus setpgid is allowed to the PGID of init which results in a test fail.
> Indeed, the test retrieves the PGID of init to try and generate EPERM.
> 
> Instead, get the PGID we use to generate EPERM from the kernel pid_max.
> It should not be used by any process, guaranteeing a different session
> and generating an EPERM error.

So I suppose that we hit slightly different condition in the kernel:

        if (pgid != pid) {
                struct task_struct *g;

                pgrp = find_vpid(pgid);
                g = pid_task(pgrp, PIDTYPE_PGID);
                if (!g || task_session(g) != task_session(group_leader))
                        goto out;
        }

Previously we were supposed to hit the task_session(g) !=
task_session(group_leader) now we hit !g.

Also I guess that the only way to hit the second part of the condition
is to actually open and initialize a pty so that we have a process
outside of the current session.

The patch itself looks okay, but we should at least update the
documentation comment such as:

diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 4b63afee8..68b663633 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -13,8 +13,8 @@
  * - EINVAL when given pgid is less than 0.
  * - ESRCH when pid is not the calling process and not a child of
  * the calling process.
- * - EPERM when an attempt was made to move a process into a process
- * group in a different session.
+ * - EPERM when an attempt was made to move a process into a nonexisting
+ *   process group.
  */

And ideally write a test for the second case as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
