Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FBC433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 09:53:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CF0E3C9B00
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 10:53:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A794E3C074D
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:53:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E23431A006FA
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:53:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05078210E9;
 Mon,  7 Feb 2022 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644227619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3HxGmeLp5qOKBkMxpS9CJQz5VSRg+qZPsMFsnLRLUI=;
 b=so3hSNMDjtdLZw0q2wypYiuayPMmOPTRQFNATCeWqZDFopZsxJwv//sC44dEyAg9lMmjAZ
 G6SuwEeAOLkfekJPcTUK9YfFB7Mcw5XfQUUuzfnB07V3JqqH1YQCnzEXp4hqbGbCslB5ly
 SslPLf4gPX7t9wCDtUG2vraxOHXIrPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644227619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3HxGmeLp5qOKBkMxpS9CJQz5VSRg+qZPsMFsnLRLUI=;
 b=AMx4ZO4ZIHoigbGVUFR9bckMQrkDszdQ/2PyHQ4dIV7enMKmpdJXq4fkNEm31YhnkqFL1H
 6um6+nU990E6GHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC29413B68;
 Mon,  7 Feb 2022 09:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4YZ4LCLsAGK8KQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 09:53:38 +0000
Date: Mon, 7 Feb 2022 10:53:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YgDsIaf5z2rg5tCH@pevik>
References: <20220203061222.625948-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203061222.625948-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/inotify: New test for IN_DELETE
 regression
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
Cc: Ivan Delalande <colona@arista.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

Thanks for this test.

> Check that files cannot be opened after IN_DELETE was reported
> on them.

> This test is based on the reproducer provided by Ivan Delalande
> for a regression reported in kernel v5.13:
> https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/
Cc in the commit mentions v5.3+, thus we don't need to mention it in the commit
message or in docs.

...
> diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
> new file mode 100644
> index 000000000..88ac4d2d7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify11.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 CTERA Networks. All Rights Reserved.
> + *
> + * Started by Amir Goldstein <amir73il@gmail.com>
> + * based on reproducer from Ivan Delalande <colona@arista.com>
> + *
> + * DESCRIPTION
This should use docparse description header
/*\
 * [Description]
 * Test opening files after receiving IN_DELETE.
 ...

FYI we produce doc about test metadata:
https://github.com/linux-test-project/ltp/releases/download/20220121/metadata.20220121.html
https://github.com/linux-test-project/ltp/releases/download/20220121/metadata.20220121.pdf

> + * Test opening files after receiving IN_DELETE.
> + *
> + * Kernel v5.13 has a regression allowing files to be open after IN_DELETE.
> + *
> + * The problem has been fixed by commit:
> + *  a37d9a17f099 "fsnotify: invalidate dcache before IN_DELETE event".
> + */
> +
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <time.h>
> +#include <signal.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>

nit: I'd cleanup some of clearly unused headers:
<poll.h> (used in reproducer, but not in LTP code, <sys/syscall.h>, <stdlib.h>,
<time.h>, <sys/time.h> (maybe copy paste from previous tests?).

I might do a cleanup of the headers in other inotify tests.

> +
> +#include "tst_test.h"
> +#include "inotify.h"
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +/* Number of files to test */
> +#define CHURN_FILES 9999
> +
> +#define EVENT_MAX 32
> +/* Size of the event structure, not including the name */
> +#define EVENT_SIZE	(sizeof(struct inotify_event))
> +#define EVENT_BUF_LEN	(EVENT_MAX * (EVENT_SIZE + 16))
> +
> +static pid_t pid;
> +
> +char event_buf[EVENT_BUF_LEN];
nit: use static

> +
> +void churn(void)
here as well.

FYI one of the reasons we're passion about using static is that some people
link all tests into single binary to save space (similar way busybox use it).

> +{
> +	char path[10];
> +	int i;
> +
> +	for (i = 0; i <= CHURN_FILES; ++i) {
> +		snprintf(path, sizeof(path), "%d", i);
> +		SAFE_FILE_PRINTF(path, "1");
> +		SAFE_UNLINK(path);
> +	}
> +}
> +
> +static void verify_inotify(void)
> +{
> +	int nevents = 0, opened = 0;
> +	struct inotify_event *event;
> +	int inotify_fd;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		churn();
> +		return;
> +	}
> +
> +	inotify_fd = SAFE_MYINOTIFY_INIT();
> +	SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
> +
> +	while (!opened && nevents < CHURN_FILES) {
> +		int i, fd, len;
> +
> +		len = read(inotify_fd, event_buf, EVENT_BUF_LEN);
> +		if (len == -1)
> +			tst_brk(TBROK | TERRNO, "read failed");
Just:
len = SAFE_READ(0, inotify_fd, event_buf, EVENT_BUF_LEN);

> +
> +		for (i = 0; i < len; i += EVENT_SIZE + event->len) {
> +			event = (struct inotify_event *)&event_buf[i];
> +
> +			if (!(event->mask & IN_DELETE))
> +				continue;
> +
> +			nevents++;
> +
> +			/* Open file after IN_DELETE should fail */
> +			fd = open(event->name, O_RDONLY);
> +			if (fd < 0)
> +				continue;
> +
> +			tst_res(TFAIL, "File %s opened after IN_DELETE", event->name);
> +			SAFE_CLOSE(fd);
> +			opened = 1;
> +			break;
> +		}
> +	}
> +
> +	SAFE_CLOSE(inotify_fd);
> +
> +	if (!nevents)
> +		tst_res(TFAIL, "Didn't get any IN_DELETE events");
> +	else if (!opened)
> +		tst_res(TPASS, "Got %d IN_DELETE events", nevents);
Shouldn't we compare nevents == CHURN_FILES instead of just printing the number?
> +
> +	/* Kill the child creating / deleting files and wait for it */
> +	SAFE_KILL(pid, SIGKILL);
> +	pid = 0;
> +	SAFE_WAIT(NULL);
Interesting. I didn't figure out why kill and wait cannot be done just in
cleanup.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (pid) {
> +		SAFE_KILL(pid, SIGKILL);
> +		SAFE_WAIT(NULL);
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.timeout = 10,
I guess you fear of similar problems of fanotify22.
Sure, why not (we remove this once we set the default much lower).

> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.cleanup = cleanup,
> +	.test_all = verify_inotify,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "a37d9a17f099"},
> +		{}
> +	}
> +};
> +
> +#else
> +	TST_TEST_TCONF("system doesn't have required inotify support");
> +#endif

Tested-by: Petr Vorel <pvorel@suse.cz>
On various systems. Interesting enough on it does not reproduce on affected
system with enabled FIPS (at least FIPS on SLES) when run as ordinary user
(reproduces when run as root). But that's nothing we should worry about.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Suggest to apply with this changes (unless if worth to compare nevents ==
CHURN_FILES).

Kind regards,
Petr

diff --git testcases/kernel/syscalls/inotify/inotify11.c testcases/kernel/syscalls/inotify/inotify11.c
index 88ac4d2d7d..062b92409f 100644
--- testcases/kernel/syscalls/inotify/inotify11.c
+++ testcases/kernel/syscalls/inotify/inotify11.c
@@ -4,8 +4,10 @@
  *
  * Started by Amir Goldstein <amir73il@gmail.com>
  * based on reproducer from Ivan Delalande <colona@arista.com>
- *
- * DESCRIPTION
+ */
+
+/*\
+ * [Description]
  * Test opening files after receiving IN_DELETE.
  *
  * Kernel v5.13 has a regression allowing files to be open after IN_DELETE.
@@ -18,16 +20,12 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <stdlib.h>
 #include <fcntl.h>
-#include <poll.h>
-#include <time.h>
 #include <signal.h>
-#include <sys/time.h>
 #include <sys/wait.h>
-#include <sys/syscall.h>
 
 #include "tst_test.h"
+#include "tst_safe_macros.h"
 #include "inotify.h"
 
 #if defined(HAVE_SYS_INOTIFY_H)
@@ -43,9 +41,9 @@
 
 static pid_t pid;
 
-char event_buf[EVENT_BUF_LEN];
+static char event_buf[EVENT_BUF_LEN];
 
-void churn(void)
+static void churn(void)
 {
 	char path[10];
 	int i;
@@ -75,9 +73,7 @@ static void verify_inotify(void)
 	while (!opened && nevents < CHURN_FILES) {
 		int i, fd, len;
 
-		len = read(inotify_fd, event_buf, EVENT_BUF_LEN);
-		if (len == -1)
-			tst_brk(TBROK | TERRNO, "read failed");
+		len = SAFE_READ(0, inotify_fd, event_buf, EVENT_BUF_LEN);
 
 		for (i = 0; i < len; i += EVENT_SIZE + event->len) {
 			event = (struct inotify_event *)&event_buf[i];

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
