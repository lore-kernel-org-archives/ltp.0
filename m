Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FE1C61CE8
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 11:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A4843CA595
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:44:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D813C9AEF
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:44:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1DD1A1000477
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:44:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5E343368A;
 Fri,  6 Jun 2025 11:44:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 747EE1336F;
 Fri,  6 Jun 2025 11:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O3wdG43UQmjyTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 11:44:13 +0000
Date: Fri, 6 Jun 2025 13:44:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606114412.GD1289709@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-5-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-5-0b5cff90c21c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A5E343368A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 5/8] syscalls/mknod05: Convert to new API
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

...
> -/*
> - * Test Name: mknod05
> - *
> - * Test Description:
> - *  Verify that mknod(2) succeeds when used by root to create a filesystem
> - *  node with set group-ID bit set on a directory with set group-ID bit set.
> - *  The node created should have set group-ID bit set and its gid should be
> - *  equal to that of its parent directory.

> - *
> - * Expected Result:
> - *  mknod() should return value 0 on success and node created should have
> - *  set group-ID bit set and its gid should be equal to that of its parent
> - *  directory.
> - *
...
> +/*\
> + * Verify that mknod(2) succeeds when used to create a filesystem node with
> + * set group-ID bit set on a directory with set group-ID bit set. The node
very nit: The original reader was not consistent when referring to setuid.
Mostly he used "set-group-ID" which is also used in man chmod(2) and in The
Linux Programming Interface book. Therefore I'll modify before merge:

s/set group-ID/set-group-ID/

> + * created should have set group-ID bit set and its gid should be equal to
> + * that of its parent directory.
>   */

> -#define LTPUSER		"nobody"
> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
> -#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO

And again, as I noted at mknod0[34].c here is constant used for mknod() uses
S_IFIFO.

> -struct stat buf;		/* struct. to hold stat(2) o/p contents */
> -struct passwd *user1;		/* struct. to hold getpwnam(3) o/p contents */
> +#define MODE_RWX 0777
> +#define MODE_SGID (S_ISGID | 0777)

But you don't use it.

...
> +	SAFE_MKNOD(TEMP_NODE, MODE_SGID, 0);

> -		/*
> -		 *  Attempt to create a filesystem node with group id (sgid)
> -		 *  bit set on a directory with group id (sgid) bit set
> -		 *  such that, the node created by mknod(2) should have
> -		 *  group id (sgid) bit set and node's gid should be equal
> -		 *  to that of effective gid of the process.
> -		 */
> -		TEST(mknod(node_name, MODE_SGID, 0));

I vote for following diff (using a constant you defined also for mknod03.c).
No need to repost, I can change it before merge.

Kind regards,
Petr

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
