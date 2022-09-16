Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A27EECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 20:27:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEDAD3CAC9B
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 22:27:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509D63CAC18
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 22:27:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13CAD1A01A78
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 22:27:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6881B20BBE;
 Fri, 16 Sep 2022 20:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663360057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QVOu08HCqGf5Hetbuk6GRADQVufWpNmVH6XxjSqw60=;
 b=inlcNuCyjR84DJTnZhVkTtGFYTvpIeSVh7Mc+c1agxllB2MEhcWVko3S9aqhMnCl2IDEEC
 /XuDsR2HwI7R/QhmXe8dze/6iiHhUiF8eJBjg2OriaYNqaMfRlfVPJCGfxfbF9P2+HFW3v
 X3hpe9+pUmjzjFFIq7MApCMPHpjf78k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663360057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3QVOu08HCqGf5Hetbuk6GRADQVufWpNmVH6XxjSqw60=;
 b=ZJXDcstEwEhXZp37mGBWihJTIjk+puXQsgVSKuwhbGispdgUgsg8bIyUwnAbrvG7Gsz/Z8
 YktQP1EDwpTsznDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EE471346B;
 Fri, 16 Sep 2022 20:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gmc+JDjcJGN5TwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 20:27:36 +0000
Date: Fri, 16 Sep 2022 22:27:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyTcNlcwetdsXQgA@pevik>
References: <20220915093639.2261-1-pvorel@suse.cz>
 <20220915093639.2261-6-pvorel@suse.cz> <YyRv8WmjRKLQrAw3@yuki>
 <YyR1j825ty3gIz/s@pevik> <YyR3apctP+uns07p@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyR3apctP+uns07p@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 5/8] tst_test.sh: Add $TST_ALL_FILESYSTEMS
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Whatever the API ends up I guess that we should check the support and
> > > mkfs here as well in order to TCONF early before we create a device and
> > > attempt to format/mount it.
> > I was worried to add mkfs.foo dependency unless there is a requirement for it
> > (i.e. TST_NEEDS_DEVICE=1). Do you really want to add this dependency for *all*
> > tests? (I'd prefer no, i.e. to keep here check only for test not being skipped,
> > because check for mkfs.foo is in tst_mkfs which does the job, thus not only we'd
> > add an extra unneeded dependency but also duplicity in the check).

> Isn't this mostly theoretical problem? I mean how common it would be to
> have test that tests different filesystem but does not need
> corresponding mkfs?

Have you noticed !=, i.e.:
if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
The check here is for single filesystem testing, just with disabled on some
filesystems (i.e. skip on tmpfs). Equivalent of fcntl33.c (skips on tmpfs,
ramfs - BTW not in fs_type_whitelist, thus not being checked, nfs; but not using
.all_filesystems).

That's why I'm not going to add check for kernel support and mkfs.foo (hope I
was correct you overlooked !=, or did I miss something?)

For testing on all filesystems (TST_ALL_FILESYSTEMS=1) there is obviously check
for kernel and mkfs support in testcases/lib/tst_supported_fs.c.

> > But if you want it, i.e. if we require mkfs.$TST_FS_TYPE (unless tmpfs of
> > course, which is handled properly) here, then we don't need to separate checks
> > for mkfs.foo and skip list in testcases/lib/tst_supported_fs.c.

> I would go that way for now.
I dare to merge this approach:

* all filesystems
tst_supported_fs [-s skip_list]
   print the list of supported filesystems
   if fs_type is supported and not in skip_list (optional),
   print list of supported filesystems and return 0
   if fs_type isn't supported or in skip_list, return 1

* single filesystem
tst_supported_fs fs_type
   if fs_type is supported, return 0 otherwise return 1

tst_supported_fs -s skip_list fs_type
   if fs_type is in skip_list, return 1 otherwise return 0


> I guess that the cleanest solution would be keeping the funcionality
> really orthogonal, i.e. separating the kernel and mkfs checks so that we
> would have -m to enable mkfs check -k to enable kernel check and -s to
> enable skiplist. But that is something that can and should be done after
> the relase.

If really needed, sure.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
