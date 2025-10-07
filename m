Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004E4CCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 12:40:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C5C3CE480
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 14:40:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA7383CE3CC
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 14:39:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1A5A2001DD
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 14:39:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EBB21F788;
 Tue,  7 Oct 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52B113AAC;
 Tue,  7 Oct 2025 12:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EWi2NhgK5Wg5FAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Oct 2025 12:39:52 +0000
Date: Tue, 7 Oct 2025 14:40:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aOUKRrt9yH1leYrX@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-4-bf458fa66358@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007-xattrat-v2-4-bf458fa66358@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0EBB21F788
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/10] setxattr02: add setxattrat variant
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

On Tue, Oct 07, 2025 at 08:46:56AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/setxattr/setxattr02.c | 79 +++++++++++++++++++------
>  1 file changed, 60 insertions(+), 19 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
> index 9f5f998da..b5042a0df 100644
> --- a/testcases/kernel/syscalls/setxattr/setxattr02.c
> +++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
> @@ -19,6 +19,10 @@
>   */
>  
>  #include "config.h"
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_XATTR_H
> +
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>
> @@ -30,12 +34,10 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#ifdef HAVE_SYS_XATTR_H
> -# include <sys/xattr.h>
> -#endif
> -#include "tst_test.h"
> +#include "lapi/xattr.h"
> +#include "lapi/fcntl.h"
> +#include <sys/xattr.h>
>  
> -#ifdef HAVE_SYS_XATTR_H
>  #define XATTR_TEST_KEY "user.testkey"
>  #define XATTR_TEST_VALUE "this is a test value"
>  #define XATTR_TEST_VALUE_SIZE 20
> @@ -49,6 +51,8 @@
>  #define BLK      "setxattr02blk"
>  #define SOCK     "setxattr02sock"
>  
> +static int tmpdir_fd = -1;
> +
>  struct test_case {
>  	char *fname;
>  	char *key;
> @@ -120,39 +124,58 @@ static struct test_case tc[] = {
>  
>  static void verify_setxattr(unsigned int i)
>  {
> +	char *sysname;
> +
>  	/* some tests might require existing keys for each iteration */
>  	if (tc[i].needskeyset) {
>  		SAFE_SETXATTR(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
> -				XATTR_CREATE);
> +			XATTR_CREATE);
>  	}
>  
> -	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
> -			tc[i].flags));
> +	if (tst_variant) {
> +		sysname = "setxattrat";
> +
> +		struct xattr_args args = {
> +			.value = (uint64_t)tc[i].value,
> +			.size = tc[i].size,
> +			.flags = tc[i].flags,
> +		};
> +
> +		int at_flags = tc[i].needskeyset ? 0 : AT_SYMLINK_NOFOLLOW;


I do not get why this is needed.

In kernel:

SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
                const char __user *, name, const void __user *, value,
                size_t, size, int, flags)
{
        return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, flags);
	                                           ^
						   the setxattr() the
						   always sets the
						   at_flags to 0
}


So shouldn't setxattrat() just work the same if we pass 0 there?

It's the lsetxattr() syscall that passes AT_SYMLINK_NOFOLLOW:

SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
                const char __user *, name, const void __user *, value,
                size_t, size, int, flags)
{
        return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name,
                               value, size, flags);
}

>  static void setup(void)
> @@ -185,12 +208,30 @@ static void setup(void)
>  	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
>  	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
>  	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
> +
> +	tmpdir_fd = SAFE_OPEN(tst_tmpdir_path(), O_DIRECTORY);

This is memleak, on the top of that can't we just use the AT_FDCWD
instead? Or if you want to make sure that the syscall works with a real
fd we can do SAFE_OPEN(".", O_DIRECTORY) instead....


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
