Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FC4EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:44:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD1073CB65A
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 14:44:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B6B3C9DB1
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:44:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A836D1400526
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 14:44:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0B2EB21908;
 Wed, 21 Jun 2023 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687351466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kz0WBR3cQOvH1rhkD7i6BIzZRlBF7C0BbE0vVMHIOdQ=;
 b=ZQZpDWPxUh8F0D2VDtUpVw6Mpn4SbW6NqQgt4z9hUGQJOKkiFRhWJv2AXEt0xBTorMan5w
 0sGPoHDjS9PuT8BxVtpjX4L0223uaz/hPcC682zRoB+2KNMPcJDARBZJWWTpXzELErzjXV
 ZvNNfxobwVYf30jQgho/28PVu27IIDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687351466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kz0WBR3cQOvH1rhkD7i6BIzZRlBF7C0BbE0vVMHIOdQ=;
 b=KMYaEubNE2NLgVUhnYmqOyBJVNzlRhXYrQHJfenBKE5SXjMINfdbIpKLdeTt+4pnMcV4ME
 iQdpncaRIpoGk6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71DA5133E6;
 Wed, 21 Jun 2023 12:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VfC+F6nwkmRmUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 12:44:25 +0000
Date: Wed, 21 Jun 2023 14:44:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230621124423.GB407092@pevik>
References: <1685699755-4766-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1685699755-4766-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork03: Convert into new api
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
>  #include <sys/types.h>
nit: I don't think this is needed

> +#include <unistd.h>
>  #include <sys/wait.h>
> -#include <stdio.h>
> -#include "test.h"
...
> +#include <stdlib.h>
> +#include "tst_test.h"

...
> +	pid1 =3D SAFE_FORK();
> +	if (!pid1) {
> +		/* child uses some cpu time slices */
> +		for (i =3D 1; i < 32767; i++) {
> +			fl1 =3D 0.000001;
> +			fl1 =3D fl2 =3D 0.000001;
> +			fl1 =3D fl1 * 10.0;
> +			fl2 =3D fl1 / 1.232323;
> +			fl1 =3D fl2 - fl2;
> +			fl1 =3D fl2;
>  		}
> +		if (!pid1)
> +			exit(0);
> +		else
> +			exit(1);
nit: maybe just
exit(!!pid1);

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I suggest further tiny space cleanups.

You can download it or use diff below.
https://github.com/pevik/ltp/raw/4788c24a97c2f0885a2da3a8930f27d2f15f93d3/t=
estcases/kernel/syscalls/fork/fork03.c

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fork/fork03.c testcases/kernel/syscall=
s/fork/fork03.c
index 072f12797..9f04c113b 100644
--- testcases/kernel/syscalls/fork/fork03.c
+++ testcases/kernel/syscalls/fork/fork03.c
@@ -1,20 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines Corp., 2001
- *
- * AUTHOR
- *=A0=A0=A0=A0=A0 07/2001 Ported by Wayne Boyer
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: 2001 Ported by Wayne Boyer
  */
 =

 /*\
  *[Description]
  *
  * Check that child process can use a large text space and do a large numb=
er
- * of operations. In this situation, Check for pid =3D=3D 0 in child and c=
heck
- * for pid > 0 in parent after wait.
+ * of operations. In this situation, check for PID =3D=3D 0 in child and c=
heck
+ * for PID > 0 in parent after wait.
  */
 =

-#include <sys/types.h>
 #include <unistd.h>
 #include <sys/wait.h>
 #include <stdlib.h>
@@ -36,22 +34,23 @@ static void verify_fork(void)
 			fl1 =3D fl2 - fl2;
 			fl1 =3D fl2;
 		}
-		if (!pid1)
-			exit(0);
-		else
-			exit(1);
+
+		exit(!!pid1);
 	}
 =

-	tst_res(TINFO, "process id in parent of child from fork : %d", pid1);
+	tst_res(TINFO, "process id in parent of child from fork: %d", pid1);
 	pid2 =3D SAFE_WAIT(&status);
+
 	if (pid1 !=3D pid2) {
-		tst_res(TFAIL, "pids don't match : %d vs %d", pid1, pid2);
+		tst_res(TFAIL, "pids don't match: %d vs %d", pid1, pid2);
 		return;
 	}
+
 	if ((status >> 8) !=3D 0) {
 		tst_res(TFAIL, "child exited with failure");
 		return;
 	}
+
 	tst_res(TPASS, "test PASSED");
 }
 =


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
