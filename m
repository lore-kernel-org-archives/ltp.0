Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8F1CCD1AF
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 20:49:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75BC23CF086
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 22:49:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0293CE837
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 22:48:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D0FE7600212
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 22:48:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DBCB211A8;
 Tue, 21 Oct 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D5E4139D2;
 Tue, 21 Oct 2025 20:48:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WUCqGrbx92h3VQAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 20:48:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id CC0EBA0990; Tue, 21 Oct 2025 22:48:49 +0200 (CEST)
Date: Tue, 21 Oct 2025 22:48:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <lguqncbotw2cu2nfaf6hwgip6wtrmeg2azvyeht7l56itlomy5@uccupuql3let>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
 <20251021-wollust-biografie-c4d97486c587@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251021-wollust-biografie-c4d97486c587@brauner>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 7DBCB211A8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Jan Kara <jack@suse.cz>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>, linux-fsdevel@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 21-10-25 15:21:08, Christian Brauner wrote:
> On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> > On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > > Hi!
> > > > > ## Test error log
> > > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > > @1760657272 aarch64
> > > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > > which might slow the execution
> > > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > > info_invalid) expected EINVAL: ENOTTY (25)
> > > 
> > > Looking closely this is a different problem.
> > > 
> > > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > > size with:
> > > 
> > > struct pidfd_info_invalid {
> > >         uint32_t dummy;
> > > };
> > > 
> > > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
> > > 
> > > 
> > > And we expect to hit:
> > > 
> > >         if (usize < PIDFD_INFO_SIZE_VER0)
> > >                 return -EINVAL; /* First version, no smaller struct possible */
> > > 
> > > in fs/pidfs.c
> > > 
> > > 
> > > And apparently the return value was changed in:
> > > 
> > > commit 3c17001b21b9f168c957ced9384abe969019b609
> > > Author: Christian Brauner <brauner@kernel.org>
> > > Date:   Fri Sep 12 13:52:24 2025 +0200
> > > 
> > >     pidfs: validate extensible ioctls
> > >     
> > >     Validate extensible ioctls stricter than we do now.
> > >     
> > >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> > >     Reviewed-by: Jan Kara <jack@suse.cz>
> > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > 
> > > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > > index edc35522d75c..0a5083b9cce5 100644
> > > --- a/fs/pidfs.c
> > > +++ b/fs/pidfs.c
> > > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> > >                  * erronously mistook the file descriptor for a pidfd.
> > >                  * This is not perfect but will catch most cases.
> > >                  */
> > > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> > >         }
> > >  
> > >         return false;
> > > 
> > > 
> > > So kernel has changed error it returns, if this is a regression or not
> > > is for kernel developers to decide.
> > 
> > Yes, it's mostly a question to Christian whether if passed size for
> > extensible ioctl is smaller than minimal, we should be returning
> > ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> > is our "extensible ioctl expert" :).
> 
> You're asking difficult questions actually. :D
> I think it would be completely fine to return EINVAL in this case.
> But traditionally ENOTTY has been taken to mean that this is not a
> supported ioctl. This translation is done by the VFS layer itself iirc.

Now the translation is done by VFS, I agree. But in the past (when the LTP
test was written) extensible ioctl with too small structure passed the
initial checks, only later we found out the data is too short and returned
EINVAL for that case. I *think* we are fine with just adjusting the test to
accept the new world order but wanted your opinion what are the chances of
some real userspace finding the old behavior useful or otherwise depending
on it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
