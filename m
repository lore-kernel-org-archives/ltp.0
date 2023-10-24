Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15D2C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:38:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CEED3CECE3
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:38:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7586F3CCD8C
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:38:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9069820118F
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:38:26 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7732221B92;
 Tue, 24 Oct 2023 09:38:25 +0000 (UTC)
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D0E872CB1E;
 Tue, 24 Oct 2023 09:38:24 +0000 (UTC)
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-3-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Oct 2023 10:31:07 +0100
Organization: Linux Private Site
In-reply-to: <20231016123320.9865-3-chrubis@suse.cz>
Message-ID: <87bkcouzqo.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 7732221B92
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls: readahead01: Make use of tst_fd
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> TODO:
> - readahead() on /proc/self/maps seems to succeed
> - readahead() on pipe write end, O_PATH file and open_tree() fd returns EBADFD
>
> Are these to be expected?
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../kernel/syscalls/readahead/readahead01.c   | 54 ++++++++++---------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> index bdef7945d..6dd5086e5 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -30,43 +30,47 @@
>  
>  static void test_bad_fd(void)
>  {
> -	char tempname[PATH_MAX] = "readahead01_XXXXXX";
> -	int fd;
> +	int fd[2];
> +
> +	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
> +	             "readahead() with fd = -1");
>  
> -	tst_res(TINFO, "%s -1", __func__);
> -	TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF);
> +	SAFE_PIPE(fd);
> +	SAFE_CLOSE(fd[0]);
> +	SAFE_CLOSE(fd[1]);

Would it make more sense to just close one of the ends?

Or to open a file with write only?

I wonder whether we still need test_bad_fd at all? Perhaps all the cases
should be integrated into TST_FD_FOREACH?

The rest looks good.

>  
> -	tst_res(TINFO, "%s O_WRONLY", __func__);
> -	fd = mkstemp(tempname);
> -	if (fd == -1)
> -		tst_res(TFAIL | TERRNO, "mkstemp failed");
> -	SAFE_CLOSE(fd);
> -	fd = SAFE_OPEN(tempname, O_WRONLY);
> -	TST_EXP_FAIL(readahead(fd, 0, getpagesize()), EBADF);
> -	SAFE_CLOSE(fd);
> -	unlink(tempname);
> +	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
> +	             "readahead() with invalid fd");
>  }
>  
> -static void test_invalid_fd(void)
> +static void test_invalid_fd(struct tst_fd *fd)
>  {
> -	int fd[2];
> +	int exp_errno = EINVAL;
>  
> -	tst_res(TINFO, "%s pipe", __func__);
> -	SAFE_PIPE(fd);
> -	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> -	SAFE_CLOSE(fd[0]);
> -	SAFE_CLOSE(fd[1]);
> +	switch (fd->type) {
> +	/* These two succeed */
> +	case TST_FD_FILE:
> +	case TST_FD_MEMFD:
> +		return;
> +	case TST_FD_PIPE_WRITE:
> +	case TST_FD_OPEN_TREE:
> +	case TST_FD_PATH:
> +		exp_errno = EBADF;
> +	break;
> +	default:
> +		break;
> +	}
>  
> -	tst_res(TINFO, "%s socket", __func__);
> -	fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> -	TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> -	SAFE_CLOSE(fd[0]);
> +	TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), exp_errno,
> +		     "readahead() on %s", tst_fd_desc(fd));
>  }
>  
>  static void test_readahead(void)
>  {
>  	test_bad_fd();
> -	test_invalid_fd();
> +
> +	TST_FD_FOREACH(fd)
> +		test_invalid_fd(&fd);
>  }
>  
>  static void setup(void)
> -- 
> 2.41.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
