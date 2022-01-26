Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDB4C2BA4C
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 14:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2723C9724
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 15:38:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A6CA3C8D84
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:38:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B2DD91A0112A
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:38:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD434218E9;
 Wed, 26 Jan 2022 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643207915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJGRc8+3tI/VjdJ86vfkyTIhzX2R11iyFI3JCd694iE=;
 b=oNKgGlzozn6UsBApkeM4QBptMPczHfBcNfEipT0XuUE2aKiV5k061qy1FYwvGp91yHOTAx
 UjmAUxjFqrjWLnddKiH/sprEO7IpkT6TAFZlgY+DeblCpkrvadfbS7rxea2WR8PCiYRCUQ
 PZTkZXGqN5pce1NVEzXa1AZbF9PMLCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643207915;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJGRc8+3tI/VjdJ86vfkyTIhzX2R11iyFI3JCd694iE=;
 b=pCUV/7N4sRm98/fwle0yXGoWtDk4P/3aDkD/ff9/gx6JY7Dq9U9arIT+smEoMo9L76bezX
 Lr5azXt5iIXy8eAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B128F13E1A;
 Wed, 26 Jan 2022 14:38:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v6X6JOtc8WFVAwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Jan 2022 14:38:35 +0000
Date: Wed, 26 Jan 2022 15:40:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YfFdWaqX1kWGmGyz@yuki>
References: <20220126091435.16022-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220126091435.16022-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Rewrite process_vm_readv02.c test with new LTP
 API
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
Pushed with three minor fixes, thanks.

* Fixed the munmap() size
* Fixed the documentation comment header
* Made use of tst_strstatus()

Full diff:

diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index ed905a735..2bd66a49f 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
  */

-/* \
+/*\
  * [Description]
  *
  * Fork two children, one child allocates memory and initializes it;
@@ -73,7 +73,7 @@ static void setup(void)
 static void cleanup(void)
 {
        if (data_ptr)
-               SAFE_MUNMAP(data_ptr, BUFSIZ);
+               SAFE_MUNMAP(data_ptr, sizeof(uintptr_t));
 }

 static void run(void)
@@ -104,14 +104,14 @@ static void run(void)
        /* wait until child_invoke reads from child_alloc's VM */
        SAFE_WAITPID(pid_invoke, &status, 0);
        if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-               tst_res(TFAIL, "child 1: returns %d", status);
+               tst_res(TFAIL, "child 1: %s", tst_strstatus(status));

        /* child_alloc is free to exit now */
        TST_CHECKPOINT_WAKE(0);

        SAFE_WAITPID(pid_alloc, &status, 0);
        if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-               tst_res(TFAIL, "child 0: returns %d", status);
+               tst_res(TFAIL, "child 0: %s", tst_strstatus(status));
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
