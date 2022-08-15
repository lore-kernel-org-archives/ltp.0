Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C38C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 06:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 186313C9664
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 08:40:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A553C0780
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 08:40:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B8DE600724
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 08:40:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A06720599;
 Mon, 15 Aug 2022 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660545644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7s9rpzFEsSbivewu8hD4yv81S7rLgRMm17lgLJj9hvU=;
 b=iZvFCzdbyjAxf2IGZm1sCYxza3XWVpks1EvLY3mP9f6xIKVVsifWq72qQto109ia1OHDjq
 zjLzYVjEJECuxQ5ehZ+dgBdVv4wVuXGJfGE14qUvtWeSvwoENEcTF2EeJcrLnznOTfiMHt
 oMlR91a9dC7O/VoAOKmbTYKa6Ajcdg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660545644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7s9rpzFEsSbivewu8hD4yv81S7rLgRMm17lgLJj9hvU=;
 b=e0QM/suX77jA5dGw4l/pcLOXBW5YOLgv45EFHsjqwxmiiXtH2dFcdCnKItojbI4g+Wgpcy
 /i46/Ch6OK3WSDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA46D13A93;
 Mon, 15 Aug 2022 06:40:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5XkEJmrq+WKdEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 15 Aug 2022 06:40:42 +0000
Date: Mon, 15 Aug 2022 08:40:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YvnqZfyByO42kAX9@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

> Hi Petr

> > Hi,

> > I wanted to speedup mount03 rewrite [1], thus I finished the work.

> > Changes include:
> > * simplify code by using:
> >    - SAFE macros
> >    - TST_EXP_FAIL() instead of TST_EXP_FAIL2()
> >    - remove if () check from SAFE macros (that's the point of safe macros
> > 	to not having to use if () check

> > * fix mount03_setuid_test call, so it can expect 0 exit code
> > I wonder myself why this fixes it:
> > -		SAFE_SETREUID(nobody_uid, nobody_gid);

> Why here is nobody_gid?

> > +		SAFE_SETGID(nobody_gid);
> > +		SAFE_SETREUID(-1, nobody_uid);

> What problem do you meet?

Using original code SAFE_SETREUID(nobody_uid, nobody_gid);
causes mount03_setuid_test to fail (exit 1).
The same code is in creat08.c, creat09.c, open10.c.
Did I answer your question?

> > * add missing TST_RESOURCE_COPY()
> > @Cyril: is it really needed?

> IMO, if we use resourcein test struct, we don't need it because ltp lib 
> has move it to tmpdir, we  can just use SAFE_COPY ie prctl06.c.

Ah, thanks!
SAFE_CP(TESTBIN, file);

...
> > +#define FLAG_DESC(x) .flag = x, .desc = #x
> > +static struct tcase {
> > +	unsigned int flag;
> > +	char *desc;
> > +	void (*test)(void);
> > +} tcases[] = {
> > +	{FLAG_DESC(MS_RDONLY), test_rdonly},
> > +	{FLAG_DESC(MS_NODEV), test_nodev},
> > +	{FLAG_DESC(MS_NOEXEC), test_noexec},
> > +	{FLAG_DESC(MS_SYNCHRONOUS), test_synchronous},
> > +	{FLAG_DESC(MS_RDONLY), test_remount},
> > +	{FLAG_DESC(MS_NOSUID), test_nosuid},
> > +	{FLAG_DESC(MS_NOATIME), test_noatime},
> > +};

> > -	sleep(1);
> > +static void setup(void)
> > +{
> > +	struct stat st;
> > +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");

> > -	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
> > +	nobody_uid = ltpuser->pw_uid;
> > +	nobody_gid = ltpuser->pw_gid;

> > -	SAFE_FSTAT(otfd, &file_stat);
> > +	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> > +	TST_RESOURCE_COPY(NULL, TESTBIN, file);

> In fact, old test case copy resource file when mount fileystem, but now, 
> you change this.  So in test_nosuid function, you test nosuid behaviour 
> in tmpdir instead of different filesystems.

old code in setup:
    fs_type = tst_dev_fs_type();
    device = tst_acquire_device(cleanup);

    if (!device)
        tst_brkm(TCONF, cleanup, "Failed to obtain block device");

    tst_mkfs(cleanup, device, fs_type, NULL, NULL);

    SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);

    SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
    TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);

new code:
    snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
    SAFE_CP(TESTBIN, file);

Well, Li in his v2 removed the code because there is .mntpoint = MNTPOINT, in
struct tst_test, therefore MNTPOINT is mounted in the filesystem, right?

But he also did SAFE_STAT and SAFE_CHMOD on MNTPOINT, which is IMHO wrong
(or at least different from the old code).

Kind regards,
Petr

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
