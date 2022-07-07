Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2906C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 18:04:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272423CA2E5
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 20:04:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFD73CA184
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 20:04:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13E4260081D
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 20:04:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F4DA21883;
 Thu,  7 Jul 2022 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657217061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cIZ2rUDVX1271jJ5tS2wjurVvxc8OyoENSxX65YHMR0=;
 b=RLdDyE008M2hydLmXt/Dp7zv9bzM40MK4pct22cWuF+ttS3rhCGKAKVttGrZydDW8LL42X
 Jmbad542Z4bb8Cm4hS5IQGzvyeYf0FFV5SiAwAK/LLSaE51OhtyysUKDKXAQ5YfNo/5cdo
 0dOutcX+b7pwQ66QTQpYbV7q3Zxfn/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657217061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cIZ2rUDVX1271jJ5tS2wjurVvxc8OyoENSxX65YHMR0=;
 b=uXcu7c0fqNA5F7tmK33+Ya+NY0V5P2DZG+EWBiHRnLNT5dpfBfFLdoNERrHLHLLXGgzyZx
 J65RKgSmGBkZPPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7C0013A33;
 Thu,  7 Jul 2022 18:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1xMkKSQgx2JuCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 07 Jul 2022 18:04:20 +0000
Date: Thu, 7 Jul 2022 20:04:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YscgIvZauxbArm7i@pevik>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62C5663C.2060009@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62C5663C.2060009@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: Christian Brauner <brauner@kernel.org>,
 Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr

> Share some process with you...

> I have rejected this patch and a kernel patchset[1] is plan to fix this 
> but doesn't merged to upstream kernel due to none continue to review 
> this(It is about one month since v9...)

> TBH, this case only tests simple creat file with open but miss
> open with O_TMPFILE[2]
> mknodat[3]

> setgid strip logic is not only affected by umask but also include acl 
> operations[4].

Thanks a lot for an update.
Al, Christian, Amir, could you please have look on v9?

Kind regards,
Petr


> [1]https://patchwork.kernel.org/project/linux-fsdevel/list/?series=643645
> [2]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=87cf32ad3fa234e3d5ec501e0f86516bef91d805
> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=5328ab947ff4d2d492a6ac90b22d31ab02637bd8
> [4]https://patchwork.kernel.org/project/fstests/list/?series=643643&state=%2A&archive=both

> Best Regards
> Yang Xu
> > XFS fails on umask 0077:

> > tst_test.c:1528: TINFO: Testing on xfs
> > tst_test.c:997: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > tst_test.c:1458: TINFO: Timeout per run is 0h 05m 00s
> > creat09.c:61: TINFO: User nobody: uid = 65534, gid = 65534
> > creat09.c:62: TINFO: Found unused GID 3: SUCCESS (0)
> > creat09.c:93: TPASS: mntpoint/testdir/creat.tmp: Owned by correct group
> > creat09.c:97: TFAIL: mntpoint/testdir/creat.tmp: Setgid bit is set
> > creat09.c:93: TPASS: mntpoint/testdir/open.tmp: Owned by correct group
> > creat09.c:97: TFAIL: mntpoint/testdir/open.tmp: Setgid bit is set

> > Thus clear the default umask.

> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> >   testcases/kernel/syscalls/creat/creat09.c | 2 ++
> >   1 file changed, 2 insertions(+)

> > diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> > index bed7bddb0e..70da7d2fc7 100644
> > --- a/testcases/kernel/syscalls/creat/creat09.c
> > +++ b/testcases/kernel/syscalls/creat/creat09.c
> > @@ -56,6 +56,8 @@ static void setup(void)
> >   		(int)ltpuser->pw_gid);
> >   	free_gid = tst_get_free_gid(ltpuser->pw_gid);

> > +	umask(0);
> > +
> >   	/* Create directories and set permissions */
> >   	SAFE_MKDIR(WORKDIR, MODE_RWX);
> >   	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
