Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45114C3F6B0
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 11:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C7DB3C95CF
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 13:50:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DD233C95CF
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:49:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 643BA200921
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 13:49:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E2D834CE9;
 Tue, 16 Aug 2022 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660650596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYfcxaojpjLg7F7GjHTohvFZgHCrer5t+x21XAuVzW4=;
 b=cf4A57RFSPj1emagN3yLMga7rhHHZGsPuCxVStsnUR+K2+ByODBNaF/I1IHPJcMpDh0loh
 zV50MUsCduuloiFd8/wQQMljr1lp0ntcCqwKlwTgDR9xh1Kuz93ELqfsTiFlGOmsgz8io0
 NOkTRI6snONnfBNqY5ygr6Y2HngMKf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660650596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qYfcxaojpjLg7F7GjHTohvFZgHCrer5t+x21XAuVzW4=;
 b=JcuYpoOFXu/cVCziAXMhQaCeKIvtkFvtA155IZxH/qR1U7zx4YzI8AZb/AJNR6twJxMSEU
 3hTcBrL0V7EMpNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DA73139B7;
 Tue, 16 Aug 2022 11:49:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pkjDBWSE+2IWPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 11:49:56 +0000
Date: Tue, 16 Aug 2022 13:49:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvuEYiIq23D6/zw6@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
 <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
 <YvpV8Iz+zVAhwvRv@pevik>
 <f7c6df02-3c39-ead8-2bbd-8cc26d36ff7f@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f7c6df02-3c39-ead8-2bbd-8cc26d36ff7f@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

...
> > +++ testcases/kernel/syscalls/mount/mount03.c
...
> >   #define FILE_MODE	0644
> >   #define SUID_MODE	0511
Good catch, SUID_MODE must be 04511.

> Here SUID_MODE miss S_ISUID, that is why this case also pass if we 
> execute a program on filesystem that not mounted with nosuid option.
@Cyril any idea what's wrong here? (not yet tested on tst_reinit()).

> Also, it seems make check code has problem when detecting S_ISUID
Indeed.

> Symbolic permissions 'S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH' are not 
> preferred. Consider using octal permissions '0511'.
This already been implemented.

> Since we have converted mount03 into new api, mount03_setuid_test.c 
> should also be converted into new spdx.
Planning to, with other required fixes (C API pointed out by Cyril).

> Best Regards
> Yang Xu

> > @@ -74,12 +75,18 @@ static void test_nosuid(void)
> >   {
> >   	pid_t pid;
> >   	int status;
> > +	struct stat st;
> > +
> > +	SAFE_CP(TESTBIN, BIN_PATH);
> > +	SAFE_STAT(BIN_PATH, &st);
> > +	if (st.st_mode != SUID_MODE)
> > +		SAFE_CHMOD(BIN_PATH, SUID_MODE);

> >   	pid = SAFE_FORK();
> >   	if (!pid) {
> >   		SAFE_SETGID(nobody_gid);
> >   		SAFE_SETREUID(-1, nobody_uid);
> > -		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
> > +		SAFE_EXECL(BIN_PATH, TESTBIN, NULL);
> >   	}

> >   	SAFE_WAITPID(pid, &status, 0);
> > @@ -137,18 +144,10 @@ static struct tcase {

> >   static void setup(void)
> >   {
> > -	struct stat st;
> >   	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");

> >   	nobody_uid = ltpuser->pw_uid;
> >   	nobody_gid = ltpuser->pw_gid;
> > -
> > -	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
> > -	SAFE_CP(TESTBIN, file);
> > -
> > -	SAFE_STAT(file, &st);
> > -	if (st.st_mode != SUID_MODE)
> > -	    SAFE_CHMOD(file, SUID_MODE);
> >   }

> >   static void cleanup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
