Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C660EB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 09:50:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F3DB3CE1AF
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 11:50:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF9AA3C8D9E
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:50:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF0DC2009D8
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 11:50:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C12A0218A2;
 Mon,  7 Aug 2023 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691401836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smq0SOnWJTALUdgASHtBZaQSmwDh4qJc5NgcEDPVAjM=;
 b=HJpzgPVDe/U94UlvsAQnR4xi1qwpbqd+u0sLRCHAMuqvJ5ZrtO4+70doQhr+VUAlKKEC3a
 HMLANHf2SiBc9nxzswDJoZdaa0ij0GuKegJSLa42wXJX8Ky0yBP7e+OryFSPh6JYXMf/XV
 MncejXbOIB3SJ3MgGpOWmynypumYKbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691401836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smq0SOnWJTALUdgASHtBZaQSmwDh4qJc5NgcEDPVAjM=;
 b=W2VhmTKJg7TtGJ+TP+B5TpcRVxsP7ApFLOfVLpjXOjigswJEJyHXanT6xnaq0ec39qUbnp
 ewPm1kSeEh+xhTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D31813487;
 Mon,  7 Aug 2023 09:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DtC9BWy+0GQZLgAAMHmgww
 (envelope-from <akumar@suse.de>); Mon, 07 Aug 2023 09:50:36 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 07 Aug 2023 15:20:34 +0530
Message-ID: <3946361.0HB8mIXUQK@localhost>
Organization: SUSE
In-Reply-To: <20230725094557.GA1629064@pevik>
References: <20230722134949.15684-1-akumar@suse.de>
 <20230725094557.GA1629064@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe07: Rewrite the test using new LTP
 API
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

Hi Petr,
Thank you for the review.

On Tuesday, July 25, 2023 3:15:57 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> generally LGTM, thank you.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW it's funny that when run with valgrind, it fails because valgrind opens
> some file descriptors:
> 
> $ valgrind ./pipe07
> ...
> pipe07.c:45: TINFO: getdtablesize() = 1024
> pipe07.c:49: TINFO: open fds before pipe() calls: 10
> pipe07.c:54: TINFO: expected max fds to be opened by pipe(): 1014
> ==1629480== Warning: invalid file descriptor 1030 in syscall pipe2()
> pipe07.c:69: TPASS: errno == EMFILE (24)
> pipe07.c:70: TFAIL: exp_num_pipe_fds (1014) != num_pipe_fds (1020)
> 
Ah yes, I also tried this. So valgrind is opening some file descriptors in the 
process context, but I don't know if it's ok to ignore this behavior. 

I'm taking care of other nit suggestions in revised patch.

> > +static void record_open_fds(void)
> 
> nit: num_opened_fds is used only in setup(), I'd personally return int
> and store variable in setup().
> 
> >  {
> > 
> > +	DIR *dir;
> > +	struct dirent *ent;
> > +	int fd;
> > 
> > -	min = getdtablesize() - rec_fds_max;
> > +	dir = SAFE_OPENDIR("/proc/self/fd");
> 
> ...
> 
> > +static void run(void)
> > 
> >  {
> 
> ...
> 
> > +	do {
> > +		TEST(pipe(fds));
> > +		if (TST_RET != -1) {
> 
> nit: wouldn't be safer to use: if (!TST_RET) (i.e. for TST_RET == 0)
> (we check that return on error is exactly -1, not > 0)
> 
> Kind regards,
> Petr
> 
> > +			pipe_fds[num_pipe_fds++] = fds[0];
> > +			pipe_fds[num_pipe_fds++] = fds[1];
> > 
> >  		}
> > 
> > +	} while (TST_RET != -1);
> 
> ...

--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
