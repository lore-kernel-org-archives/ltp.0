Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B821ECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:29:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1278E3CA52C
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 13:29:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C89863C81E1
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:29:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EC5F1A002D5
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:29:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BF6F22CDB;
 Mon, 29 Aug 2022 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661772558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKTSO34xK/2s5bPMDkcHOgBnBROAK8E7pSIP+Jg1TpI=;
 b=wcrBfpcm+hOrYi5HkF7XXr+LO8qWmV0ZXhOGQ1fud5NNAKg8bLHR27YxHKajukO9RVSqzv
 n2RnpgBJhAK692QcIj9QvSfrlxj2TZG3N4kP7GuhCJjRF4rS6aJ0gu2v1ATLf8BJ6q5Mk7
 TrfCubCEh7W3ZyWKaPCMfS7PQYxRx/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661772558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKTSO34xK/2s5bPMDkcHOgBnBROAK8E7pSIP+Jg1TpI=;
 b=mH0t6BrHTCH072mHb6lpJVX31wRRPqsUB/+yAl1g7+lpce4mLERznbxqwHlPhRSMR5fa4T
 lvtICuMQODZncaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 052501352A;
 Mon, 29 Aug 2022 11:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JBgSOw2jDGMCHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:29:17 +0000
Date: Mon, 29 Aug 2022 13:29:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YwyjDLcGzhDiWXkD@pevik>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-3-pvorel@suse.cz> <YwybzIVhMaCqYR/S@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwybzIVhMaCqYR/S@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] API: tst_device: Track minimal size per
 filesystem
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

thanks a lot for a review!

...
> > +++ b/include/tst_fs.h
...
> > +unsigned int tst_min_fs_size(long f_type)
> > +{
> > +	switch (f_type) {
> > +	case 0:

> TST_ALL_FILESYSTEMS ?

Thanks for catching this. Mistake which is a result of very late Friday night coding.

> > +		return MAX(DEV_SIZE_MB_BTRFS, DEV_SIZE_MB_DEFAULT);

> I do not think that we should harcode this here. I would be for a more
> dynamic approach, i.e. add a function into the tst_supported_fs_types.c
> that loops over supported filesystems and chooses max over the minimal
> values for all supported filesystems. That way if we run on embedded
> targets the device size will be 16MB as long as btrfs-progs is not
> installed. Also that way we can easily define minimal size for xfs 300MB
> and things will work for embedded as long as xfs-progs are not
> installed.
Correct. So the value for .all_filesystems should be maximum of supported
filesystems. The only think I don't like about it that it takes some time to
check everything (mkfs.* available ... etc), but we can't avoid it.

Is it worth to cache this value (make it static in the function) so that it's not
searched more than once?

> > +	case TST_BTRFS_MAGIC:
> > +		return DEV_SIZE_MB_BTRFS;
> > +	case TST_SQUASHFS_MAGIC:
> > +		return DEV_SIZE_MB_SQUASHFS;
> > +	default:
> > +		return DEV_SIZE_MB_DEFAULT;
> > +	}
> > +}
...
> > +++ b/lib/tst_fs_type.c
> > @@ -43,6 +43,34 @@ long tst_fs_type_(void (*cleanup)(void), const char *path)
> >  	return sbuf.f_type;
> >  }

> > +long tst_fs_name_type(const char *fs)
> > +{
> > +	if (!strcmp(fs, "btrfs"))
> > +		return TST_BTRFS_MAGIC;
> > +	else if (!strcmp(fs, "exfat"))
> > +		return TST_EXFAT_MAGIC;
> > +	else if (!strcmp(fs, "ext2"))
> > +		return TST_EXT2_OLD_MAGIC;

> I'm not sure that this is a correct mapping, I think that all ext
> filesystems goes by EXT234_MAGIC these days.
OK, I'll dig into kernel's fs/ext{2,4}/
The problem is, that we still theoretically support kernel 3.0,
thus old kernels are likely using this approach and newer not.
Let's see if and when it was changed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
