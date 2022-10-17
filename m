Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA30C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 08:49:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D122C3CAFC9
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:49:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA9083C80B3
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:49:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D676B1A002C4
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:49:20 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2AFB3201AB;
 Mon, 17 Oct 2022 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665996560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6elTHpm2hHiLbuK92C+XYCEKC1H94TmkJC1/YU4KdKM=;
 b=Fmd6bB4CmO82W+SQxJYADUWl+UlwrObO4CBo+Y2N9roaPzDJWAud+hTYaJ5lvTHzYkFJ+R
 ZT/3Yo6JILXe/XavjESd4WS/t+JoIQWC4XqFAt50ICKTsszDKbuYGSd+yyQSakheKvsCQm
 KI12XyJbHkaANZrE6GXOusrH3MHaZsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665996560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6elTHpm2hHiLbuK92C+XYCEKC1H94TmkJC1/YU4KdKM=;
 b=HFPfvIx7dv291xx8nXIZlFDseEiEK6Q/G1YmjUWu/wQJ6KhIeiZw0erxIcWQF7/40VIgBy
 oZz1LDfiXzaUksAQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B99212C141;
 Mon, 17 Oct 2022 08:49:19 +0000 (UTC)
References: <1661329049-14309-1-git-send-email-liaohj.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Liao Huangjie <liaohj.jy@fujitsu.com>
Date: Mon, 17 Oct 2022 09:28:13 +0100
In-reply-to: <1661329049-14309-1-git-send-email-liaohj.jy@fujitsu.com>
Message-ID: <875ygiq1gx.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/read04:add multiple read size
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Liao Huangjie <liaohj.jy@fujitsu.com> writes:

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/read/read04.c | 59 ++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 16 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/read/read04.c b/testcases/kernel/syscalls/read/read04.c
> index 47875c0..37c670f 100644
> --- a/testcases/kernel/syscalls/read/read04.c
> +++ b/testcases/kernel/syscalls/read/read04.c
> @@ -6,36 +6,49 @@
>  /*\
>   * [Description]
>   *
> - * Testcase to check if read() returns the number of bytes read correctly.
> + * Testcase to check if read() returns the correct number of bytes

Trailing whitespace at the end of this line

> + * when using multip sizes [0, 1/2*page_size, 3/2*page_size, 2*page_size].
>   */
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> +#include <unistd.h>
>  #include "tst_test.h"
>  
> +#define MNT_POINT "mntpoint"
> +static int page_size;
>  static const char *fname = "test_file";
> -static const char palfa[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
> -#define PALFA_LEN (sizeof(palfa)-1)
> +static char *write_buf[2], *read_buf;
>  
> -static void verify_read(void)
> +static void verify_read(unsigned int n)
>  {
>  	int fd;
> -	char prbuf[BUFSIZ];
> -
> +	int size = n * page_size / 2;

Usually interesting things happen around page boundaries. It would be
better to read (page_size - 1), page_size and (page_size + 1). And also
use an offset starting at (page_size - 1), pages_size etc.

>  	fd = SAFE_OPEN(fname, O_RDONLY);
> -	TEST(read(fd, prbuf, BUFSIZ));
> +	TEST(read(fd, read_buf, size));
>  
> -	if (TST_RET != PALFA_LEN) {
> -		tst_res(TFAIL, "Bad read count - got %ld - expected %zu",
> -				TST_RET, PALFA_LEN);
> +	if (TST_RET != size) {
> +		tst_res(TFAIL, "Bad read count - got %ld - expected %d",
> +				TST_RET, size);

There is no requirement for read to return size bytes in a single
call. A loop is required.

The test presently passes because the buffer is small and the process is
unlikely to be interrupted. However if you start to read one page at a
time and use all filesystems it's much more likely to fail.

>  		goto out;
>  	}
>  
> -	if (memcmp(palfa, prbuf, PALFA_LEN)) {
> -		tst_res(TFAIL, "read buffer not equal to write buffer");
> -		goto out;
> +	if (n <= 2) {
> +		if (memcmp(read_buf, write_buf[0], size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer1");
> +			goto out;
> +		}
> +	} else {
> +		if (memcmp(read_buf, write_buf[0], page_size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer2");
> +			goto out;
> +		}
> +		if (memcmp(read_buf + page_size, write_buf[1], size - page_size)) {
> +			tst_res(TFAIL, "read buffer not equal to write buffer3");
> +			goto out;
> +		}
>  	}
>  
>  	tst_res(TPASS, "read() data correctly");
> @@ -48,13 +61,27 @@ static void setup(void)
>  {
>  	int fd;
>  
> +	page_size = getpagesize();
> +	write_buf[0] = tst_alloc(page_size);
> +	write_buf[1] = tst_alloc(page_size);
> +	read_buf = tst_alloc(2 * page_size);
> +
> +	memset(write_buf[0], 'A', page_size);
> +	memset(write_buf[1], 'B', page_size);
> +	memset(read_buf, 0, 2 * page_size);
> +
>  	fd = SAFE_CREAT(fname, 0777);
> -	SAFE_WRITE(1, fd, palfa, PALFA_LEN);
> +	SAFE_WRITE(1, fd, write_buf[0], page_size);
> +	SAFE_WRITE(1, fd, write_buf[1], page_size);

This patch fails to apply now because this was changed to use
SAFE_WRITE_ALL.

>  	SAFE_CLOSE(fd);
> +

More trailing whitespace.

>  }
>  
>  static struct tst_test test = {
> -	.needs_tmpdir = 1,
>  	.setup = setup,
> -	.test_all = verify_read,
> +	.test = verify_read,
> +	.tcnt = 5,
> +	.mount_device = 1,
> +	.mntpoint = MNT_POINT,
> +	.all_filesystems = 1,
>  };
> -- 
> 1.8.3.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
