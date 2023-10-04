Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA9AE7C4C1
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DEA53CDB0D
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 16:24:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9CA63CB7DA
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:23:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 198BF60562C
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:23:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDDDB1F38A;
 Wed,  4 Oct 2023 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696429427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHb/a3BAxQGZndtORH0UCfwT2Tjg3D0onRWIB4VDNv0=;
 b=NQ2m09+eoeyOldzeU7SnmNZrATJsUEmCM/SKqPXBIEEcv4f3UpFqic66vnfWg6TuKtUo5j
 G7/lb0lYwApQKhpbg2h2VMLcnOGALCZ5lhW4dKfWV4ObO0PNep9rQQ39+rmjnAh+iNzZZc
 8Ca7hSTqGcNjtQQzafZFT/5iqKvqgGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696429427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHb/a3BAxQGZndtORH0UCfwT2Tjg3D0onRWIB4VDNv0=;
 b=6aMOd8elijYE0oYQUMq7AmmhFN6X27xSwyrOMbTa8R0wZZ+T1IH6jC9SvcokNBqUJu3Rm4
 rByPfKCEZfznGyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F4ED139F9;
 Wed,  4 Oct 2023 14:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AJphFXN1HWWjdwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 14:23:47 +0000
Date: Wed, 4 Oct 2023 16:24:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <ZR11nlq3Le1GAwcd@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-3-chrubis@suse.cz>
 <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/readahead01: Make use of
 tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > TODO: readahead() on /proc/self/maps seems to succeed is that to be
> >       expected?
> 
> Not sure.
> How does llseek() work on the same fd?

Looks like we we can seek in that file as well, accordingly to man pages
we cannot seek in pipe, socket, and fifo, which seems to match the
reality.  We can apparently seek in O_DIRECTORY fd as well, not sure if
that is even useful.

> > -static void test_invalid_fd(void)
> >  {
> >         int fd[2];
> >
> > -       tst_res(TINFO, "%s pipe", __func__);
> > +       TST_EXP_FAIL(readahead(-1, 0, getpagesize()), EBADF,
> > +                    "readahead() with fd = -1");
> > +
> 
> Any reason not to include a bad and a closed fd in the iterator?

I wanted to avoid mixing valid and invalid fds because we tend to get
different errnos for these, since the situation is different between
"this is not a file descriptor" and "this is not supported on this kind
of file descriptor".

> >         SAFE_PIPE(fd);
> > -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> >         SAFE_CLOSE(fd[0]);
> >         SAFE_CLOSE(fd[1]);
> >
> > -       tst_res(TINFO, "%s socket", __func__);
> > -       fd[0] = SAFE_SOCKET(AF_INET, SOCK_STREAM, 0);
> > -       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EINVAL);
> > -       SAFE_CLOSE(fd[0]);
> > +       TST_EXP_FAIL(readahead(fd[0], 0, getpagesize()), EBADF,
> > +                    "readahead() with invalid fd");
> > +}
> > +
> > +static void test_invalid_fd(struct tst_fd *fd)
> > +{
> > +       switch (fd->type) {
> > +       case TST_FD_FILE:
> > +       case TST_FD_PIPE_OUT:
> > +               return;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       TST_EXP_FAIL(readahead(fd->fd, 0, getpagesize()), EINVAL,
> > +                    "readahead() on %s", tst_fd_desc(fd));
> 
> Thinking forward and we would like to change this error code to ESPIPE
> is there already a helper to expect one of a few error codes?

Not yet. The hardest part is again figuring out right API. We usually
try to check for the new behavior on newer kernels, which would be
complex to encode into the parameters, so maybe we just need to pass a
callback that would return the right errno. Maybe something as:

static int exp_errno(void)
{
	if (tst_kvercmp(6, 7, 0) >= 0)
		return ESPIPE;

	return EINVAL;
}

...
	TST_EXP_FAIL_CB(readahead(fd->fd, 0, getpagesize()), exp_errno,
		"readahead() on %s", tst_fd_desc(fd));
...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
