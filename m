Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E04CCD1A7
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761052898; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=W6/UzqMi1+JP54wSdZT2bAOox4lgsAyspkm7Ub/1edI=;
 b=kQ88xMub0dh5aOXGX4Rvk9r5r6QMCLT2GWcHbLUG4EUVgUFpf7GiWYQYlz/f2EriztEt6
 1xe8gXsOVhI9En56ZSxjhZ1mswpaC8gwwbXhPW8XbHJUNUhRkI+3AfkovIs3fqQ0PgXIX9S
 DP/gVIINerkbIhcewQyZZlb9btm3Wv0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536FA3CF054
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 15:21:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998C23CEFAE
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 15:21:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA6FC20096C
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 15:21:17 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A480C48B6D;
 Tue, 21 Oct 2025 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD8C4CEF1;
 Tue, 21 Oct 2025 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761052874;
 bh=lvcRb/61yamx9Ux8qcx+0p2Z2oz7rIaAXsUA3+G6uXU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qRZ9V5QZIibDOsO9wccPJdCMBqXt9+lUebH4uqUNlwIGaqGNPHXtxgk83a1Rg6KX0
 On7CO7L3CH3u8UM6MvMznOHukWIxAJmmtkHpKXyhyZyJqLiWZ1FKnz29oi4S51rxfY
 U8OpG0vUpUy3PCNi3RE7Ig91WHeNU40tA6FKiN2OLmobeH0i8fNPxGHWx6HrBm5H3C
 NP7kIxANp5Xch80kwvtZUuiP512KcySpiGdz00wgSDZfP/6zuEXUITgFZxPWFwM0YC
 d505f4KOmvU7NF1GiN3FKzl3LXlMZqpVyiF5mt7NvobjAQYvJVbvuOW4JgdbR4MhIt
 i3QIg217Yj6ZA==
Date: Tue, 21 Oct 2025 15:21:08 +0200
To: Jan Kara <jack@suse.cz>
Message-ID: <20251021-wollust-biografie-c4d97486c587@brauner>
References: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
 <CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com>
 <aPIPGeWo8gtxVxQX@yuki.lan>
 <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <qveta77u5ruaq4byjn32y3vj2s2nz6qvsgixg5w5ensxqsyjkj@nx4mgl7x7o6o>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
From: Christian Brauner via ltp <ltp@lists.linux.it>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
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

On Fri, Oct 17, 2025 at 02:43:14PM +0200, Jan Kara wrote:
> On Fri 17-10-25 11:40:41, Cyril Hrubis wrote:
> > Hi!
> > > > ## Test error log
> > > > tst_buffers.c:57: TINFO: Test is using guarded buffers
> > > > tst_test.c:2021: TINFO: LTP version: 20250930
> > > > tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
> > > > @1760657272 aarch64
> > > > tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> > > > tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> > > > which might slow the execution
> > > > tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
> > > > ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
> > > > ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
> > > > info_invalid) expected EINVAL: ENOTTY (25)
> > 
> > Looking closely this is a different problem.
> > 
> > What we do in the test is that we pass PIDFD_IOCTL_INFO whith invalid
> > size with:
> > 
> > struct pidfd_info_invalid {
> >         uint32_t dummy;
> > };
> > 
> > #define PIDFD_GET_INFO_SHORT _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info_invalid)
> > 
> > 
> > And we expect to hit:
> > 
> >         if (usize < PIDFD_INFO_SIZE_VER0)
> >                 return -EINVAL; /* First version, no smaller struct possible */
> > 
> > in fs/pidfs.c
> > 
> > 
> > And apparently the return value was changed in:
> > 
> > commit 3c17001b21b9f168c957ced9384abe969019b609
> > Author: Christian Brauner <brauner@kernel.org>
> > Date:   Fri Sep 12 13:52:24 2025 +0200
> > 
> >     pidfs: validate extensible ioctls
> >     
> >     Validate extensible ioctls stricter than we do now.
> >     
> >     Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
> >     Reviewed-by: Jan Kara <jack@suse.cz>
> >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index edc35522d75c..0a5083b9cce5 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> >                  * erronously mistook the file descriptor for a pidfd.
> >                  * This is not perfect but will catch most cases.
> >                  */
> > -               return (_IOC_TYPE(cmd) == _IOC_TYPE(PIDFD_GET_INFO));
> > +               return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_INFO_SIZE_VER0);
> >         }
> >  
> >         return false;
> > 
> > 
> > So kernel has changed error it returns, if this is a regression or not
> > is for kernel developers to decide.
> 
> Yes, it's mostly a question to Christian whether if passed size for
> extensible ioctl is smaller than minimal, we should be returning
> ENOIOCTLCMD or EINVAL. I think EINVAL would make more sense but Christian
> is our "extensible ioctl expert" :).

You're asking difficult questions actually. :D
I think it would be completely fine to return EINVAL in this case.
But traditionally ENOTTY has been taken to mean that this is not a
supported ioctl. This translation is done by the VFS layer itself iirc.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
