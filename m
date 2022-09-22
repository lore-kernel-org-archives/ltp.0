Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D78C6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 08:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE6A3CAD6B
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 10:44:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E7293C93EF
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 10:44:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2ABB1A002E2
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 10:44:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE45C218E0;
 Thu, 22 Sep 2022 08:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663836250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpc+rBc1sBDGDIwzmJjj2L3nmTi6PxMF8qwyTjXgReU=;
 b=WTmNAfGpE7IAO1tfbzdZfVOMarpgf/ew6ApWjsh66TOe8NsD1u/5JGpZ2oir5zJ96mBm9Z
 viNScUSbptHlJAgOwsvq/YAcL/T+t2rwLvpgqwNZCg4gHl5xCR0akhu314CzeSyhw5IMkQ
 h3l3Ql3tkUDTX5VRYWsluZ5uX/Rf1nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663836250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpc+rBc1sBDGDIwzmJjj2L3nmTi6PxMF8qwyTjXgReU=;
 b=kjAuQ5T0YnMKihRoPoilsrbA7SIXZegGrAjEIQnaIH76gaRETxEc+icRSdG3hzgy0z8VDL
 2izgSyqYsnVXTHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54D861346B;
 Thu, 22 Sep 2022 08:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0rd1D1ogLGO+aQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 08:44:10 +0000
Date: Thu, 22 Sep 2022 10:43:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YywgNSfv58iIvFbq@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <b1a19673-de0b-d6e0-0434-3eb457aaf69d@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1a19673-de0b-d6e0-0434-3eb457aaf69d@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 22. 09. 22 6:16, Li Wang wrote:
> >      =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skiplist) {
> >     -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tst_fs_in_skipl=
ist(argv[optind], (const char * const*)skiplist))
> >     -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst=
_brk(TCONF, "%s is skipped", argv[optind]);
> >     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tst_fs_in_skipl=
ist(fsname, (const char * const*)skiplist))
> >     +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst=
_brk(TCONF, "%s is skipped", fsname);


> > TCONF does not means return 1, we might need explicitly 'return 1' here.

> Yes, but that's a problem which already existed before my patch and affec=
ts
> the other single-FS checks as well. The fix should go into a separate pat=
ch
> after release.

Yes, that's not related. I changed it in eb47b4497 ("tst_supported_fs: Supp=
ort
skip list when query single fs") as with 32 one can detect it's TCONF.
As long as 0 is success, non-zero for failure.
But I forget to update doc.

Thus I'll wait for feedback from others whether we should get back to 1 as =
error
(thus use TINFO) or update doc to mention to exit 32 (or more generally non=
-zero
exit).
very nit: I'd use exit instead of return in docs.

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
