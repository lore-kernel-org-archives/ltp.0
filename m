Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8746C25B06
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 14:19:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B7143C9635
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 16:19:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B823C0780
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 16:19:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3604020005C
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 16:19:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 502F633D9D;
 Mon, 15 Aug 2022 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660573170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nApUIEzhR7Ab8gNd6HsR4YlS1nYbRQDd+eFv/sP1xDs=;
 b=tv5Q9GFw5WGTNp89a/yTRqhrVlFf4gsDeikuNMoA2JFxE786BGV6R1DDGxLkW2Hbvwhls+
 zrWqr5h604HAGQvpNdbkFMo1vDafPpLegnllIcB2Mx0tvQBiHTT//gKTXA6LAi8pbS2va8
 j25ZvRV14OuFxNNbdB6ac4hxU5K/b/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660573170;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nApUIEzhR7Ab8gNd6HsR4YlS1nYbRQDd+eFv/sP1xDs=;
 b=IzBE+kRZoqJZCbwjamHeNn+OCkDPQ6UKuwNAzchgsqnceGXnSOIZmpxNlKSkiGJlbrmfO2
 nyGL4c3GUoWOBkAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F4DC13A99;
 Mon, 15 Aug 2022 14:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l8j1CfJV+mJgXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 14:19:30 +0000
Date: Mon, 15 Aug 2022 16:19:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YvpV8Iz+zVAhwvRv@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
 <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> > diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
> > index 74b018d78..9c58783d7 100644
> > --- testcases/kernel/syscalls/mount/mount03.c
> > +++ testcases/kernel/syscalls/mount/mount03.c
> > @@ -15,7 +15,6 @@
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> >   #include <pwd.h>
> > -#include "old_resource.h"
> >   #include "tst_test.h"
> >   #include "lapi/mount.h"

> > @@ -145,7 +144,7 @@ static void setup(void)
> >   	nobody_gid = ltpuser->pw_gid;

> >   	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> > -	TST_RESOURCE_COPY(NULL, TESTBIN, file);
> > +	SAFE_CP(TESTBIN, file);

> I still think we should test nosuid behaviour on different filesystem 
> like other test function because we have expand it to all filesystems.

> Also include tmpfs, so SAFE_CP should be in test_nosuid function 
> otherwise may hit ENOENT problem.

Ah thx, good idea. I guess the point of the setup was to run copy only once, but
your points are obviously valid.

I didn't notice it before because I overlooked SAFE_EXECLP() in test_nosuid() it
had parameter TESTBIN, thus not being run from mountpoint.

nit: I suggest to move to SAFE_EXECL() as it expect path, not filename as it's
not using PATH. Similarly we could change execlp() to execl() in test_noexec(),
but I'd prefer to keep execlp(), so that we test two different libc wrappers.

> different code as below:

> [root@localhost mount]# git diff .
> diff --git a/testcases/kernel/syscalls/mount/mount03.c 
> b/testcases/kernel/syscalls/mount/mount03.c
> index 74b018d78..b0582c76b 100644
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -21,6 +21,7 @@

>   #define MNTPOINT        "mntpoint"
>   #define TESTBIN        "mount03_setuid_test"
> +#define BIN_PATH           MNTPOINT"/"TESTBIN
+1 for avoid the need of snprintf when there are 2 constants.
NOTE: we can separate 3 items with spaces:
#define BIN_PATH	MNTPOINT "/" TESTBIN
But I'd rename it to TESTBIN_PATH.
Or maybe even better to use just "TEST":
#define TEST        "mount03_setuid_test"
#define TEST_PATH	MNTPOINT "/" TEST

>   #define TEST_STR "abcdefghijklmnopqrstuvwxyz"
>   #define FILE_MODE      0644
>   #define SUID_MODE      0511
> @@ -75,12 +76,19 @@ static void test_nosuid(void)
>   {
>          pid_t pid;
>          int status;
> +       struct stat st;
> +
> +       snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
this is not needed when we have BIN_PATH
> +       SAFE_CP(TESTBIN, file);
SAFE_CP(TESTBIN, BIN_PATH);
> +       SAFE_STAT(file, &st);
> +       if (st.st_mode != SUID_MODE)
> +               SAFE_CHMOD(file, SUID_MODE);
	SAFE_CHMOD(BIN_PATH, SUID_MODE);

>          pid = SAFE_FORK();
>          if (!pid) {
>                  SAFE_SETGID(nobody_gid);
>                  SAFE_SETREUID(-1, nobody_uid);
> -               SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
> +               SAFE_EXECLP(BIN_PATH, TESTBIN, NULL);
>          }

>          SAFE_WAITPID(pid, &status, 0);
> @@ -138,18 +146,10 @@ static struct tcase {

>   static void setup(void)
>   {
> -       struct stat st;
>          struct passwd *ltpuser = SAFE_GETPWNAM("nobody");

>          nobody_uid = ltpuser->pw_uid;
>          nobody_gid = ltpuser->pw_gid;
> -
> -       snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> -       TST_RESOURCE_COPY(NULL, TESTBIN, file);
> -
> -       SAFE_STAT(file, &st);
> -       if (st.st_mode != SUID_MODE)
> -           SAFE_CHMOD(file, SUID_MODE);
>   }

>   static void cleanup(void)

Final diff is below, but for readability it's temporarily also on my fork:
https://github.com/pevik/ltp/blob/57ba1ba47987a201c39764b4259a15aa39db9d2e/testcases/kernel/syscalls/mount/mount03.c

Kind regards,
Petr

> Best Regards
> Yang Xu

diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
index 9c58783d7..eef2a65c6 100644
--- testcases/kernel/syscalls/mount/mount03.c
+++ testcases/kernel/syscalls/mount/mount03.c
@@ -18,8 +18,9 @@
 #include "tst_test.h"
 #include "lapi/mount.h"
 
-#define MNTPOINT        "mntpoint"
+#define MNTPOINT	"mntpoint"
 #define TESTBIN	"mount03_setuid_test"
+#define BIN_PATH	MNTPOINT "/" TESTBIN
 #define TEST_STR "abcdefghijklmnopqrstuvwxyz"
 #define FILE_MODE	0644
 #define SUID_MODE	0511
@@ -74,12 +75,18 @@ static void test_nosuid(void)
 {
 	pid_t pid;
 	int status;
+	struct stat st;
+
+	SAFE_CP(TESTBIN, BIN_PATH);
+	SAFE_STAT(BIN_PATH, &st);
+	if (st.st_mode != SUID_MODE)
+		SAFE_CHMOD(BIN_PATH, SUID_MODE);
 
 	pid = SAFE_FORK();
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETREUID(-1, nobody_uid);
-		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
+		SAFE_EXECL(BIN_PATH, TESTBIN, NULL);
 	}
 
 	SAFE_WAITPID(pid, &status, 0);
@@ -137,18 +144,10 @@ static struct tcase {
 
 static void setup(void)
 {
-	struct stat st;
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
 	nobody_uid = ltpuser->pw_uid;
 	nobody_gid = ltpuser->pw_gid;
-
-	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
-	SAFE_CP(TESTBIN, file);
-
-	SAFE_STAT(file, &st);
-	if (st.st_mode != SUID_MODE)
-	    SAFE_CHMOD(file, SUID_MODE);
 }
 
 static void cleanup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
