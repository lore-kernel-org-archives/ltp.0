Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535A8CCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 07:52:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B16633CF0B2
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 09:52:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FD893C0BB4
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:51:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9099F600B3E
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:51:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 697FE1F391;
 Wed, 22 Oct 2025 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761119501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
 b=WLXa50SGfYw7rx7r4BN+nhQyq++ghDHg1ILi/T4sza3/QJ+Who//4+jrQgwYV1akk7mj1e
 9Wth5U2AbZuywjMz8SsZzGeVFhkYoNIprJLooi5yCtd63A+P/FfKtMyDb68RF30DJR7NMz
 DtRUuqFSo7684kNY44GPwwAkH2lVOx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761119501;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
 b=Gp2gnW1d6NINLIIhBR2OqeKJ2ILh4BD4+Ntp3mI0DgeiMeQPjZppVQiozFYkz1maTSiKUy
 JPHthh/9+rROq4DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761119497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
 b=EpE1Gh4kUFU/o+1PmPuBcPQ6azU+Q4iPrQLtzPMrEIQX+rcbdk4IDS2sWtGyp3FsmSmdOn
 INwmNqPtKfDLGOO+IV2FofeD94ZxKaYTh9tL1vGSiUz3oC5nf9ro4jR/SYd4zVikQscUqQ
 1eDWVg/r1IkQDOKbF2EmlR46J0u5BPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761119497;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G+GN8XQO5NVhzF4+79I45VeDXm2lq0alql08lbGTcE=;
 b=S4V6uw3JuJ1C9DB14S9HN2lPzawgxazhh8V4t99V+qeTHqzukUimBNO5VmcFCeaGETjmth
 pwex/ShDkTVcsFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B76D11339F;
 Wed, 22 Oct 2025 07:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGcUKgiN+Gj4KAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 07:51:36 +0000
Date: Wed, 22 Oct 2025 09:51:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20251022075134.GA463176@pevik>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner>
 <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Andrey Albershteyn <aalbersh@kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> > On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > > Hi!
> > > > > > ## Test error log
> > > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > > @1760657272 aarch64
> > > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > > which might slow the execution
> > > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > > info_invalid) expected EINVAL: ENOTTY (25)

> > > > Looking closely this is a different problem.

> > > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > > size with:

> > > > struct pidfd_info_invalid {
> > > >         uint32_t dummy;
> > > > };

> > > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)


> > > > And we expect to hit:

> > > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > > >                 return -EINVAL; /* First version, no smaller struct possible */

> > > > in fs/pidfs.c


> > > > And apparently the return value was changed in:

> > > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > > Author: Christian Brauner <brauner@kernel.org>
> > > > Date:   Fri Sep 12 13:52:24 2025 +0200

> > > >     pidfs: validate extensible ioctls

> > > >     Validate extensible ioctls stricter than we do now.

> > > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>

> > > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > > index edc35522d75c..0a5083b9cce5 100644
> > > > --- a/fs/pidfs.c
> > > > +++ b/fs/pidfs.c
> > > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > > >                  * erronously mistook the file descriptor for a pidfd.
> > > >                  * This is not perfect but will catch most cases.
> > > >                  */
> > > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > > >         }

> > > >         return false;


> > > > So kernel has changed error it returns, if this is a regression or not
> > > > is for kernel developers to decide.

> > > Yes, it's mostly a question to Christian whether if passed size for
> > > extensible ioctl is smaller than minimal, we should be returning
> > > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > > is our "extensible ioctl expert" :).

> > You're asking difficult questions actually. :D
> > I think it would be completely fine to return EINVAL in this case.
> > But traditionally ENOTTY has been taken to mean that this is not a
> > supported ioctl. This translation is done by the VFS layer itself iirc.

> Now the translation is done by VFS, I agree. But in the past (when the LTP
> test was written) extensible ioctl with too small structure passed the
> initial checks, only later we found out the data is too short and returned
> EINVAL for that case. I *think* we are fine with just adjusting the test to
> accept the new world order but wanted your opinion what are the chances of
> some real userspace finding the old behavior useful or otherwise depending
> on it.

+1, thanks! Is it ok just expect any of these two regardless kernel version?

@Naresh Kamboju will you send a patch to LTP ML?

Kind regards,
Petr

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
