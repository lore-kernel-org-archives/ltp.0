Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB4AC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 06:58:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 913A53D098A
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 08:58:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327263D0964
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 08:58:02 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F680208F71
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 08:57:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B61E11F7BA;
 Wed,  5 Jun 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E36C13AA1;
 Wed,  5 Jun 2024 06:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BwG2IXQMYGa5GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 06:57:56 +0000
Date: Wed, 5 Jun 2024 08:57:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240605065755.GB348321@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B61E11F7BA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This patch will fix unlink09 test by checking for filesystems which
> are not supporting inode attributes.

> Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> This will fix the 2cf78f47a6 and resolve issues on filesystems
> which are not supporting inode attributes.
> ---
>  testcases/kernel/syscalls/unlink/unlink09.c | 38 +++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 13 deletions(-)

> diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
> index cc4b4a07e..ed6f0adc3 100644
> --- a/testcases/kernel/syscalls/unlink/unlink09.c
> +++ b/testcases/kernel/syscalls/unlink/unlink09.c
> @@ -11,6 +11,8 @@
>   *
>   * - EPERM when target file is marked as immutable or append-only
>   * - EROFS when target file is on a read-only filesystem.
> + *
> + * Test won't be executed if inode attributes are not supported.
While this is good, wouldn't be better to use approach from Avinesh to add
O_RDWR (or whatever flag) to get test supported everywhere instead of skip?

https://patchwork.ozlabs.org/project/ltp/patch/20240603124653.31967-1-akumar@suse.de/

>   */

>  #include <sys/ioctl.h>
> @@ -22,8 +24,8 @@
>  #define DIR_EROFS "erofs"
>  #define TEST_EROFS "erofs/test_erofs"

> -static int fd_immutable;
> -static int fd_append_only;
> +static int fd_immutable = -1;
> +static int fd_append_only = -1;

>  static struct test_case_t {
>  	char *filename;
> @@ -43,12 +45,18 @@ static void setup(void)
>  {
>  	int attr;

> -	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
> -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> +	fd_immutable = SAFE_CREAT(TEST_EPERM_IMMUTABLE, 0600);
> +	TEST(ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr));
> +
> +	if (TST_RET == -1 && TST_ERR == ENOTTY) {
> +		SAFE_CLOSE(fd_immutable);
> +		tst_brk(TCONF | TTERRNO, "Inode attributes not supported");
> +	}
> +
>  	attr |= FS_IMMUTABLE_FL;
>  	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);

> -	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
> +	fd_append_only = SAFE_CREAT(TEST_EPERM_APPEND_ONLY, 0600);
>  	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>  	attr |= FS_APPEND_FL;
>  	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> @@ -58,15 +66,19 @@ static void cleanup(void)
>  {
>  	int attr;

> -	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> -	attr &= ~FS_IMMUTABLE_FL;
> -	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> -	SAFE_CLOSE(fd_immutable);
> +	if (fd_immutable != -1) {
I thought we could return when fd_immutable == -1:

	if (fd_immutable != -1)
		return;

But obviously this is can be also result of the first test (not only by the
setup), thus you're correct.

BTW verify_unlink() could be made simpler to return on if (TST_RET).

> +		SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
> +		attr &= ~FS_IMMUTABLE_FL;
> +		SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
> +		SAFE_CLOSE(fd_immutable);
> +	}

> -	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> -	attr &= ~FS_APPEND_FL;
> -	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> -	SAFE_CLOSE(fd_append_only);
> +	if (fd_append_only != -1) {
> +		SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
> +		attr &= ~FS_APPEND_FL;
> +		SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> +		SAFE_CLOSE(fd_append_only);
> +	}
Am I mistaken that this check should have been added before?

>  }

>  static void verify_unlink(unsigned int i)

> ---
> base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
I see useful b4 feature :).

> change-id: 20240604-unlink09-dc4802f872f9
But I wonder what is this for (what tool use change-id).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
