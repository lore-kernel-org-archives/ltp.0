Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42533C6FD20
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 10:33:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3746D3CD200
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 11:33:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC9643CAC66
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 11:33:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D1BC31000233
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 11:33:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23D0933777;
 Fri, 24 Mar 2023 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679654016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOrOK/YIdGyqyWsckKjU6wS1vZjdDWtVc+GIsiJ82ZA=;
 b=lvCpXoBLK1t5ISJ/QWAFiVLPO+mME1aYC92JnQod9BNUlWQn+3u+vvgXTZR36IuXppt0iH
 OKG6L+sX89orv/fNTCn4VnEnbEI8WrTllhy43ljjo4Z/sG+bukuIiH1mzYVwwcrVie77qS
 RySUzw3fCifzOVzfE+BHB2zIsAp4wNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679654016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOrOK/YIdGyqyWsckKjU6wS1vZjdDWtVc+GIsiJ82ZA=;
 b=crFNXuCfCvAB7J+DVz3PcA+FXouwXDc4HJ7D+muh2O0R0sFWoOmyAbMS4sws7oT01fglta
 Ze+WBJ9sIHRIxYCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1182138ED;
 Fri, 24 Mar 2023 10:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S+WDNH98HWS0RAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 24 Mar 2023 10:33:35 +0000
Date: Fri, 24 Mar 2023 11:33:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: paulson <lpaulsonraja@gmail.com>
Message-ID: <20230324103334.GA557284@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323121330.92244-1-paulson@zilogic.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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

Hi paulson,

Thanks for your patch. Generally the idea LGTM, also the implementation,
but I suggest various fixes.

There are many fixes (whole diff is below), I put them into my github fork, if
you agree I can merge it as is.

https://github.com/pevik/ltp/commits/paulson/mmap.fixes
https://github.com/pevik/ltp/blob/36ebc4d8900ea8438dc7839f03b7921f0ed9243a/testcases/kernel/syscalls/mmap/mmap20.c

> From: paulson <lpaulsonraja@gmail.com>
Maybe you want to setup your git better to have your name and surname.

Here is missing in the git commit message (or with fixed name):
Signed-off-by: paulson <lpaulsonraja@gmail.com>

CI shows failures on CentOS 7:

https://github.com/pevik/ltp/actions/runs/4509751194/jobs/7939880067

/__w/ltp/ltp/testcases/kernel/syscalls/mmap/mmap20.c:48:25: error: 'MAP_SHARED_VALIDATE' undeclared (first use in this function)
          INVALID_FLAG | MAP_SHARED_VALIDATE, fd, 0);
/__w/ltp/ltp/testcases/kernel/syscalls/mmap/mmap20.c:48:25: note: each undeclared identifier is reported only once for each function it appears in

There needs to be change in lapi file (which will be used later):
https://patchwork.ozlabs.org/project/ltp/patch/20230324101630.562727-1-pvorel@suse.cz/

You're missing record in runtest/syscalls

mmap20 mmap20

and in .gitignore.

Our checker prints many errors
cd testcases/kernel/syscalls/mmap; make check-mmap20

mmap20.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
make: [../../../../include/mk/rules.mk:56: check-mmap20] Error 1 (ignored)
mmap20.c: note: in included file (through /usr/include/asm-generic/mman.h, /usr/include/asm/mman.h, /usr/include/linux/mman.h):
/usr/include/asm-generic/mman-common.h:26:9: warning: preprocessor token MAP_POPULATE redefined
mmap20.c: note: in included file (through /usr/include/bits/mman.h, /usr/include/sys/mman.h):
/usr/include/bits/mman-map-flags-generic.h:34:10: this was the original definition
...

will be described later

> ---
>  testcases/kernel/syscalls/mmap/mmap20.c | 61 +++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mmap/mmap20.c

> diff --git a/testcases/kernel/syscalls/mmap/mmap20.c b/testcases/kernel/syscalls/mmap/mmap20.c
> new file mode 100644
> index 000000000..ca5bfccd7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mmap/mmap20.c
> @@ -0,0 +1,61 @@
> +//SPDX-License-Identifier: GPL-2.0-or-later
Missing space will cause invalid license for tools.

Found by:
mmap20.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

> +
> +/*
> + * Test mmap with MAP_SHARED_VALIDATE flag
> + *
> + * We are testing the MAP_SHARED_VALIDATE flag of mmap() syscall. To check
> + * if there is an invalid flag value, the MAP_SHARED_VALIDATE return
> + * EOPNOTSUPP. The unused bit in the MAP_SHARED_VALIDATE is found, and by
> + * setting the unused bits of the flag argument the flag value becomes
> + * invalid and the error EOPNOTSUPP is produced as expected.
> + */
I'd phrase it as:

/*\
 * [Description]
 *
 * Test mmap(2) with MAP_SHARED_VALIDATE flag.
 *
 * Test expected EOPNOTSUPP errno when testing mmap(2) with MAP_SHARED_VALIDATE
 * flag and invalid flag.
 */

> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>

Some 

> +#include <sys/mman.h>
> +#include <linux/mman.h>

1) mixing <linux/mman.h> and <sys/mman.h> does not work well:

mmap20.c: note: in included file (through /usr/include/asm-generic/mman.h, /usr/include/asm/mman.h, /usr/include/linux/mman.h):
/usr/include/asm-generic/mman-common.h:26:9: warning: preprocessor token MAP_POPULATE redefined
mmap20.c: note: in included file (through /usr/include/bits/mman.h, /usr/include/sys/mman.h):
/usr/include/bits/mman-map-flags-generic.h:34:10: this was the original definition


I pushed fix
https://github.com/linux-test-project/ltp/commit/32aa5c30c257b2021f9648df186d5b2c7a57dfad

+ with my patch
https://patchwork.ozlabs.org/project/ltp/patch/20230324101630.562727-1-pvorel@suse.cz/

you can instead of

> +#include <errno.h>
> +#include "tst_test.h"
> +
> +#define TEST_FILE "file_to_mmap"
> +#define TEST_FILE_SIZE 1024
> +#define TEST_FILE_MODE 0600
File mod is used just once, it's not really important to have it defined.
But I'd define (1 << 7), because that is expected to be invalid
(one day this value can appear in <linux/mmap.h> and the test will fail.

> +
> +static int fd_file = -1;
> +static void *mapped_address;
> +
> +static void setup(void)
> +{
> +	fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
> +	if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
> +		tst_brk(TBROK, "Could not fill the testfile.");
nit: we don't use dots in the end.

Whole diff is here:

diff --git include/lapi/mmap.h include/lapi/mmap.h
index 48795369d..7512e9f81 100644
--- include/lapi/mmap.h
+++ include/lapi/mmap.h
@@ -10,6 +10,10 @@
 #include "config.h"
 #include <sys/mman.h>
 
+#ifndef MAP_SHARED_VALIDATE
+# define MAP_SHARED_VALIDATE 0x03
+#endif
+
 #ifndef MAP_HUGETLB
 # define MAP_HUGETLB 0x40000
 #endif
diff --git runtest/syscalls runtest/syscalls
index b9d4a43c8..8b002e989 100644
--- runtest/syscalls
+++ runtest/syscalls
@@ -794,6 +794,7 @@ mmap16 mmap16
 mmap17 mmap17
 mmap18 mmap18
 mmap19 mmap19
+mmap20 mmap20
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git testcases/kernel/syscalls/mmap/.gitignore testcases/kernel/syscalls/mmap/.gitignore
index 8811226be..569a76ac1 100644
--- testcases/kernel/syscalls/mmap/.gitignore
+++ testcases/kernel/syscalls/mmap/.gitignore
@@ -18,3 +18,4 @@
 /mmap17
 /mmap18
 /mmap19
+/mmap20
diff --git testcases/kernel/syscalls/mmap/mmap20.c testcases/kernel/syscalls/mmap/mmap20.c
index ca5bfccd7..54ddb2087 100644
--- testcases/kernel/syscalls/mmap/mmap20.c
+++ testcases/kernel/syscalls/mmap/mmap20.c
@@ -1,55 +1,58 @@
-//SPDX-License-Identifier: GPL-2.0-or-later
-
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Test mmap with MAP_SHARED_VALIDATE flag
+ * Copyright (c) 2023 paulson <lpaulsonraja@gmail.com>
+ */
+
+/*\
+ * [Description]
  *
- * We are testing the MAP_SHARED_VALIDATE flag of mmap() syscall. To check
- * if there is an invalid flag value, the MAP_SHARED_VALIDATE return
- * EOPNOTSUPP. The unused bit in the MAP_SHARED_VALIDATE is found, and by
- * setting the unused bits of the flag argument the flag value becomes
- * invalid and the error EOPNOTSUPP is produced as expected.
+ * Test mmap(2) with MAP_SHARED_VALIDATE flag.
+ *
+ * Test expected EOPNOTSUPP errno when testing mmap(2) with MAP_SHARED_VALIDATE
+ * flag and invalid flag.
  */
+
+#include <errno.h>
 #include <stdio.h>
 #include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <linux/mman.h>
-#include <errno.h>
 #include "tst_test.h"
+#include "lapi/mmap.h"
 
 #define TEST_FILE "file_to_mmap"
 #define TEST_FILE_SIZE 1024
-#define TEST_FILE_MODE 0600
+#define INVALID_FLAG (1 << 7)
 
-static int fd_file = -1;
-static void *mapped_address;
+static int fd = -1;
+static void *addr;
 
 static void setup(void)
 {
-	fd_file = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, TEST_FILE_MODE);
+	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0600);
+
 	if (tst_fill_file(TEST_FILE, 'a', TEST_FILE_SIZE, 1))
-		tst_brk(TBROK, "Could not fill the testfile.");
+		tst_brk(TBROK, "Could not fill the testfile");
 }
 
 static void cleanup(void)
 {
-	if (fd_file > -1)
-		SAFE_CLOSE(fd_file);
-	if (mapped_address != NULL && mapped_address != MAP_FAILED)
-		SAFE_MUNMAP(mapped_address, TEST_FILE_SIZE);
+	if (fd > -1)
+		SAFE_CLOSE(fd);
+
+	if (addr && addr != MAP_FAILED)
+		SAFE_MUNMAP(addr, TEST_FILE_SIZE);
 }
 
 static void test_mmap(void)
 {
-	mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
-			      (1 << 7) | MAP_SHARED_VALIDATE, fd_file, 0);
-	if (mapped_address != MAP_FAILED)
-		tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have failed.");
+	addr = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
+			      INVALID_FLAG | MAP_SHARED_VALIDATE, fd, 0);
+
+	if (addr != MAP_FAILED)
+		tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have failed");
 	else if (errno == EOPNOTSUPP)
-		tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
+		tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP");
 	else
-		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
+		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error");
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
