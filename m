Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE687C54EE9
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 14:54:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 749C13CA900
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 16:54:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7905D3CA900
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 16:54:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4589600848
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 16:54:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A14DD20508;
 Wed,  7 Sep 2022 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662562470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pq78KMxfx0FdpEWLQzoX0+SHdrdgyejrUs4qui+l9o=;
 b=j/v9C4J915qUJeP/NFJ9vyr2gokN9WMDnswcOkXzfW7LiSPf56YXkQhMt2vSf0JK632ifN
 ak389zMwjEtEVr6S9XyQLvez9EzxAafOqgPqkQWN8fDsRw5cgIK2C1PlaDcPehf0klv2TY
 3t8ZpQDVt0eMzpWAgC0lehNcC+A3Hts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662562470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pq78KMxfx0FdpEWLQzoX0+SHdrdgyejrUs4qui+l9o=;
 b=PLei5jGvmVrhg4ioUWbHq1EOcp+70YBYBg5FmsdRvetELPOqOlaAGBYqzZSKsrNgx/fYRl
 g64TFliqA3xPY2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76FBF13A66;
 Wed,  7 Sep 2022 14:54:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dLlUG6awGGOATgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 07 Sep 2022 14:54:30 +0000
Date: Wed, 7 Sep 2022 16:54:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yxiwo/OtgISy0BGX@pevik>
References: <20220824080947.9414-1-akumar@suse.de>
 <bf8c64a5-1427-9b63-f5ae-9a3fc4cd11d7@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf8c64a5-1427-9b63-f5ae-9a3fc4cd11d7@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: skip test on ntfs filesystem
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

Hi all,

@Avinesh: it's always better to put the explanation *why* to git commit message.
Adding just a ticket is not enough.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Hi Avinesh

> I just want to know whether this patch was verified by pragat22
> or you?

> ps: I don't have environment to test this.
You can test it:
# LTP_SINGLE_FS_TYPE=ntfs ./statx04

I have tested this on various systems without setting LTP_SINGLE_FS_TYPE, most
of them are skipped due "fuse", but on Alpine with v2022.5.17 (libntfs-3g) it is
*not* caught:

# ./statx04
tst_supported_fs_types.c:89: TINFO: Kernel supports ntfs
tst_supported_fs_types.c:51: TINFO: mkfs.ntfs does exist
...
tst_test.c:1599: TINFO: === Testing on ntfs ===
tst_test.c:1064: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1078: TINFO: Trying FUSE...
statx04.c:93: TBROK: Unexpected ioctl() error: EINVAL (22)

Please do not merge this, I've ask the reported for name and email (so that I
can put his credential) and also put some extra info (explanation why fuse is
not enough).

Kind regards,
Petr

> Best Regards
> Yang Xu
> > Fixes: #956

> > Reported-by: pragat220
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >   testcases/kernel/syscalls/statx/statx04.c | 1 +
> >   1 file changed, 1 insertion(+)

> > diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> > index 98f9a6315..3923b7f8e 100644
> > --- a/testcases/kernel/syscalls/statx/statx04.c
> > +++ b/testcases/kernel/syscalls/statx/statx04.c
> > @@ -132,6 +132,7 @@ static struct tst_test test = {
> >   	.min_kver = "4.11",
> >   	.skip_filesystems = (const char *const[]) {
> >   		"fuse",
> > +		"ntfs",
> >   		NULL
> >   	},
> >   	.tags = (const struct tst_tag[]) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
