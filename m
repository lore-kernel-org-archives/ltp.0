Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63690D6B6A6
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 16:21:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868743C9E2E
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 17:21:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33203C9E2E
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 17:21:33 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8EE1C7BFE50
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 17:21:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E04E021E40;
 Wed, 30 Oct 2024 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730305291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJX6OEVbIGKj+KCFDN72fJa9qmRMZLgDCJNZmjcMW8=;
 b=F6lwHhicrFTxavF2QTr69QSN7ezfw3I6R5GPVk81XCAvsL9gKNyiBEqQqe73d0O7KCULsg
 LZbgfdV29cR7VIz1Ro29nJ/pFIF0F6a5d1hN0uqwAgIuQCOdVOidysLpJ3nmyq8T22Jq+k
 Cx/sqwKzHLilVwEbQn0ynFYe4NVOW7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730305291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJX6OEVbIGKj+KCFDN72fJa9qmRMZLgDCJNZmjcMW8=;
 b=JEcuDcMMMS+Ooc0kg6QKD+7gIV0S7VWkksNnH1j0prlK2n8jtY+dUhohC7EiiHiG3K9dQK
 d0EDFIhLWL2GiaAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a41nZL2m;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HPrZcm11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730305290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJX6OEVbIGKj+KCFDN72fJa9qmRMZLgDCJNZmjcMW8=;
 b=a41nZL2m6dpGUuADdnTl6Siqsy0W91cvWvpPQCuywYkhVpbmDbv+/D7UeaCVvOuFgJ6Lmu
 omuUcW/0WXAIPZE8oWNzIlBp5XrthOGseGuQyEOamMGIoGCizNYSALTekDSNGoAK2nMATu
 OQAg7hzJ31So4hWG6lHiJb3NMqy+x8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730305290;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJX6OEVbIGKj+KCFDN72fJa9qmRMZLgDCJNZmjcMW8=;
 b=HPrZcm11C39z4Ya2sytklYol5jKfMlnMEubLnbJ8zH7qeOQWu7kr9SxFkk/Qq0tAXcDKSu
 8aHChWZSPk/6JHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8891136A5;
 Wed, 30 Oct 2024 16:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WQQ2LwpdImedLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Oct 2024 16:21:30 +0000
Date: Wed, 30 Oct 2024 17:21:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20241030162114.GA935480@pevik>
References: <20241025-convert_mmap14-v1-1-6ba672485028@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241025-convert_mmap14-v1-1-6ba672485028@suse.com>
X-Rspamd-Queue-Id: E04E021E40
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap14: Convert to new API
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

Hi Ricardo,

very nice, few minor things below.

> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>  testcases/kernel/syscalls/mmap/mmap14.c | 97 ++++++++++-----------------------
>  1 file changed, 30 insertions(+), 67 deletions(-)

> diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
> index 31632601bbed85b60f1dfee7044bf961b1f2a756..63a2f9e4cab2f7ab12b1ad982bc690f9fabcc252 100644
> --- a/testcases/kernel/syscalls/mmap/mmap14.c
> +++ b/testcases/kernel/syscalls/mmap/mmap14.c
> @@ -1,22 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
>   *
nit: blank space above (ideally to remove). You could also add your/SUSE/LTP copyright.

> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */

> -/*
> +/*\
> + * [Description]
> + *
>   * Test Description:
>   *  Verify MAP_LOCKED works fine.
>   *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."

I would use something like:

/*\
 * [Description]
 *
 * Verify basic functionality of mmap(2) with MAP_LOCKED.
 *
 * mmap(2) should succeed returning the address of the mapped region,
 * and this region should be locked into memory.
 */

Also, having more than one space after '*' causes different formatting in
auto-generated doc (it will become <pre>...</pre>)
You can see it if you have asciidoctor (or asciidoc) installed and run

cd metadata && make
resulting docs is in ../docparse/*.html

We publish the docs in releases, e.g.:
https://github.com/linux-test-project/ltp/releases/download/20240930/metadata.20240930.html

> @@ -28,65 +18,45 @@
>  #include <stdio.h>
>  #include <sys/mman.h>

> -#include "test.h"
> +#include "tst_test.h"

>  #define TEMPFILE        "mmapfile"
>  #define MMAPSIZE        (1UL<<20)
>  #define LINELEN         256

> -char *TCID = "mmap14";
> -int TST_TOTAL = 1;
> -
>  static char *addr;

>  static void getvmlck(unsigned int *lock_sz);
Ideally you just move getvmlck() code above instead using function signature.

> +static void run(unsigned int n)

Here n is unused. That's why you should use void

static void run(void)

And below in the struct tst_test test just:
	.test_all = run,

See our old doc (not yet converted to the new format):
https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#11-basic-test-structure

>  {
>  	unsigned int sz_before;
>  	unsigned int sz_after;
>  	unsigned int sz_ch;

> -		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> -			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> -			    -1, 0);
> +	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> +			-1, 0);
very nit (just formatting - feel free to reformat the old test):

	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);

> -		if (addr == MAP_FAILED) {
> -			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> -			continue;
> -		}
> +	if (addr == MAP_FAILED)
> +		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
You need to have return here (like in mmap05.c) to skip the rest of the test.
In the old API this was achieved by continue.

> -		getvmlck(&sz_after);
> +	getvmlck(&sz_after);

> -		sz_ch = sz_after - sz_before;
> -		if (sz_ch == MMAPSIZE / 1024) {
> -			tst_resm(TPASS, "Functionality of mmap() "
> -					"successful");
> -		} else {
> -			tst_resm(TFAIL, "Expected %luK locked, "
> -					"get %uK locked",
> -					MMAPSIZE / 1024, sz_ch);
> -		}
> -
> -		if (munmap(addr, MMAPSIZE) != 0)
> -			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
> +	sz_ch = sz_after - sz_before;
> +	if (sz_ch == MMAPSIZE / 1024) {
> +		tst_res(TPASS, "Functionality of mmap() "
> +				"successful");
This is not much useful information. Also IMHO it's better to avoid splitting
string (not ideal for grepping)

> +	} else {
> +		tst_res(TFAIL, "Expected %luK locked, "
> +				"get %uK locked",
> +				MMAPSIZE / 1024, sz_ch);
>  	}

Maybe something like:
	if (sz_ch == MMAPSIZE / 1024) {
		tst_res(TPASS, "mmap() locked %uK", sz_ch);
	} else {
		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
				MMAPSIZE / 1024, sz_ch);
	}

> +	if (munmap(addr, MMAPSIZE) != 0)
> +		tst_res(TFAIL | TERRNO, "munmap failed");
The above should be replaced with:

	SAFE_MUNMAP((char *)addr, sz_ch);

>  }

>  void getvmlck(unsigned int *lock_sz)
Here is missing static.

> @@ -97,7 +67,7 @@ void getvmlck(unsigned int *lock_sz)

>  	fstatus = fopen("/proc/self/status", "r");

Please, use here:

	fstatus = SAFE_FOPEN("/proc/self/status", "r");
(it needs #include "tst_safe_stdio.h")

See old (not yet converted docs):
https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#a-word-about-the-cleanup-callback

Or in our old tutorial (already converted to the new API):
https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html

>  	if (fstatus == NULL)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
> +		tst_res(TFAIL | TERRNO, "Open dev status failed");
Then the check above is not needed. Also beware, tst_brk() (or tst_brkm()) quits
testing. But tst_res() usually not (tst_res(TBROK, ...) still quits testing, but
that's kind of misusing the API), thus you changed a test workflow.

>  	while (fgets(line, LINELEN, fstatus) != NULL)
>  		if (strstr(line, "VmLck") != NULL)
> @@ -105,20 +75,13 @@ void getvmlck(unsigned int *lock_sz)

>  	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
>  	if (ret != 1)
> -		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
> +		tst_res(TFAIL | TERRNO, "Get lock size failed");
Again, SAFE_SSCANF() instead of check, also remember tst_brk() tst_res() difference.
int ret is then not needed.

Also, we usually use in tests SAFE_FCLOSE(fstatus) instead of fclose(fstatus)
(it checks the return value and yells if unexpected).

...
> +	.needs_root = 1,

As I noted above, instead of these two:
> +	.test = run,
> +	.tcnt = 1,

please use just:
.test_all = run,

If you want, I can merge with the following diff below
(+ the copyright you prefer me to add).
Or just send another version.

Kind regards,
Petr

+++ testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,23 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
- *
  */
 
 /*\
  * [Description]
  *
- * Test Description:
- *  Verify MAP_LOCKED works fine.
- *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
+ * Verify basic functionality of mmap(2) with MAP_LOCKED.
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and this region should be locked into memory.
+ * mmap(2) should succeed returning the address of the mapped region,
+ * and this region should be locked into memory.
  */
+
 #include <stdio.h>
 #include <sys/mman.h>
-
+#include "tst_safe_stdio.h"
 #include "tst_test.h"
 
 #define TEMPFILE        "mmapfile"
@@ -26,9 +23,23 @@
 
 static char *addr;
 
-static void getvmlck(unsigned int *lock_sz);
+static void getvmlck(unsigned int *lock_sz)
+{
+	char line[LINELEN];
+	FILE *fstatus = NULL;
+
+	fstatus = SAFE_FOPEN("/proc/self/status", "r");
+
+	while (fgets(line, LINELEN, fstatus) != NULL)
+		if (strstr(line, "VmLck") != NULL)
+			break;
+
+	SAFE_SSCANF(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
+
+	SAFE_FCLOSE(fstatus);
+}
 
-static void run(unsigned int n)
+static void run(void)
 {
 	unsigned int sz_before;
 	unsigned int sz_after;
@@ -37,8 +48,7 @@ static void run(unsigned int n)
 	getvmlck(&sz_before);
 
 	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
-			-1, 0);
+			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
 
 	if (addr == MAP_FAILED)
 		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
@@ -47,41 +57,16 @@ static void run(unsigned int n)
 
 	sz_ch = sz_after - sz_before;
 	if (sz_ch == MMAPSIZE / 1024) {
-		tst_res(TPASS, "Functionality of mmap() "
-				"successful");
+		tst_res(TPASS, "mmap() locked %uK", sz_ch);
 	} else {
-		tst_res(TFAIL, "Expected %luK locked, "
-				"get %uK locked",
+		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
 				MMAPSIZE / 1024, sz_ch);
 	}
 
-	if (munmap(addr, MMAPSIZE) != 0)
-		tst_res(TFAIL | TERRNO, "munmap failed");
-}
-
-void getvmlck(unsigned int *lock_sz)
-{
-	int ret;
-	char line[LINELEN];
-	FILE *fstatus = NULL;
-
-	fstatus = fopen("/proc/self/status", "r");
-	if (fstatus == NULL)
-		tst_res(TFAIL | TERRNO, "Open dev status failed");
-
-	while (fgets(line, LINELEN, fstatus) != NULL)
-		if (strstr(line, "VmLck") != NULL)
-			break;
-
-	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
-	if (ret != 1)
-		tst_res(TFAIL | TERRNO, "Get lock size failed");
-
-	fclose(fstatus);
+	SAFE_MUNMAP((char *)addr, sz_ch);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.test = run,
-	.tcnt = 1,
+	.test_all = run,
 };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
