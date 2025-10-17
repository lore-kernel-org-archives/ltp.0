Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787B4CCD193
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 08:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBE953CEF26
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 10:57:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 417873CEC80
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 10:56:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 84DB41400978
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 10:56:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32D861F770;
 Mon, 20 Oct 2025 08:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760950601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9ijt+7DsaOqkgmtY9R0bnmem4vaIfKpn2VHGuf9pRY=;
 b=q3pAoFvoLqlwl8I45bzp9548CHXcHsnUDTMOvXkIO/Be7KtGrkMfFOd7YMjRKdPbkyFisk
 ieM0RvFOGTd1aCvg/h/Hhs/6m4HUWQMcEHpivPLgn+Zzh31OO2Q6M47940YCSXAuD+hW6s
 BnW/j2rf3DWq1bNnDjK9GOHhaoo/6vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760950601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9ijt+7DsaOqkgmtY9R0bnmem4vaIfKpn2VHGuf9pRY=;
 b=RnFXPdtbDi1AXhDtITUVwD1AGMiTkbjrFeneBP9U/2HJe7NyLCTebovLFxlqtmsJJFUuEx
 TLHaSZTzzN7pdRDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KGQie0CN;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rAlV/3XS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760950597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9ijt+7DsaOqkgmtY9R0bnmem4vaIfKpn2VHGuf9pRY=;
 b=KGQie0CNyg6O1x6IA9clIECzK0ILwegkwgZbN2KpdWeY68qzXPQ8WR2r2xdJXU/bxapPG8
 kCUClTIJDiicDH50hOaDjP2cffjlsP3Ai4g/Qy4eK8ltVzoifRzTl/PqunV9NPagiuTvD2
 VIly2uWetD7vsAzQKTno7tw9SZqW7nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760950597;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9ijt+7DsaOqkgmtY9R0bnmem4vaIfKpn2VHGuf9pRY=;
 b=rAlV/3XSxsgsNbkD6gSM551432jp9CxgErsUUZkxpzNQwN0DdGVYPM+sbRS+xrp9MJdS93
 TSCgqjkAR5/JLCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10BE813B03;
 Mon, 20 Oct 2025 08:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wSYOBEH59WhZZQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 08:56:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B6C9EA28F0; Fri, 17 Oct 2025 14:43:14 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:43:14 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPIPGeWo8gtxVxQX@yuki.lan>
X-Rspamd-Queue-Id: 32D861F770
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; DATE_IN_PAST(1.00)[68];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_LAST(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[17]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
 ioctl(pidfd, PIDFD_GET_INFO_SHORT,
 info_invalid) expected EINVAL: ENOTTY (25)
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> Hi!
> > > ## Test error log
> > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > @1760657272 aarch64
> > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > which might slow the execution
> > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > info_invalid) expected EINVAL: ENOTTY (25)
> 
> Looking closely this is a different problem.
> 
> What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> size with:
> 
> struct pidfd_info_invalid {
>         uint32_t dummy;
> };
> 
> #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
> 
> 
> And we expect to hit:
> 
>         if (usize < PIDFD_INFO_SIZE_VER0)
>                 return -EINVAL; /* First version, no smaller struct possible */
> 
> in fs/pidfs.c
> 
> 
> And apparently the return value was changed in:
> 
> commit 3c17001b21b9f168c957ced9384abe969019b609
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Fri Sep 12 13:52:24 2025 +0200
> 
>     pidfs: validate extensible ioctls
>     
>     Validate extensible ioctls stricter than we do now.
>     
>     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..0a5083b9cce5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
>                  * erronously mistook the file descriptor for a pidfd.
>                  * This is not perfect but will catch most cases.
>                  */
> -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
>         }
>  
>         return false;
> 
> 
> So kernel has changed error it returns, if this is a regression or not
> is for kernel developers to decide.

Yes, it's mostly a question to Christian whether if passed size for
extensible ioctl is smaller than minimal, we should be returning
ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
is our "extensible ioctl expert" :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
