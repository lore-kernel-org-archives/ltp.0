Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9952BC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 08:51:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05CDA3CC48E
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:51:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D933CC471
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:51:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DCF2600428
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 09:51:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2405921B14;
 Thu,  1 Dec 2022 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669884703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf6TjFanvoqx14Q4zv18Q13431vHtDFuqooVscmm4PE=;
 b=ORoHo6j6k74sPfTH1p7jFfWXY+YT31zUuh1mEa3XTgSfXUdcu27vf8QIXDDt87MIWlufU4
 8U3jf2mEpXpR/VOdq5QSKKWxMWUCvNBBxyCliL1ibzjQjBHfTaaX/SZhP0ObzL7IOTLTE1
 EdzoBGFvPxnHBJbnTfxF8vv0PeBwBK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669884703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf6TjFanvoqx14Q4zv18Q13431vHtDFuqooVscmm4PE=;
 b=mJnMZWdhfRA9gphwFftX40ys47nFos6klCQc/wiqUEqj04urr07Bp2BWMxU4PI0b/+gTt6
 y0SMWLp5opfuaMDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CEB713B4A;
 Thu,  1 Dec 2022 08:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oXWxFB1riGOtGwAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 01 Dec 2022 08:51:41 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 01 Dec 2022 14:21:38 +0530
Message-ID: <1774275.JVTEKzzMJm@localhost>
Organization: SUSE
In-Reply-To: <Y4cnbaAtMAtw3IWC@pevik>
References: <87r0xmt3ts.fsf@suse.de> <Y4cZxK/SqTtpQb07@pevik>
 <Y4cnbaAtMAtw3IWC@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statvfs01: Convert to new LTP API
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
Cc: Li Wang <liwan@redhat.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Wednesday, November 30, 2022 3:20:37 PM IST Petr Vorel wrote:
> Hi all,
> 
> ...
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.needs_root = 1,
> > > +	.mount_device = 1,
> > > +	.mntpoint = MNT_POINT,
> > > +	.all_filesystems = 1,
> > > +	.skip_filesystems = (const char *const[]) {
> > > +		"vfat",
> > > +		"exfat",
> > I was looking what's wrong with vfat and exfat.
> > statvfs.f_namemax returns 1530, which is obviously too long, thus valid_fname
> > obviously returns ENAMETOOLONG (36). Tested on 6.1.0-rc6-1.g4c01546-default.
> > I wonder why, isn't that a bug?
> 
> To reply myself, both glibc and musl defines:
> statvfs->f_namemax = statfs->f_namelen;
> 
> TL;DR: 6 * 255 = 1530 due names being in UTF-8:
> 
> Therefore looking into kernel sources for statfs->f_namelen:
> 
> include/linux/nls.h
> #define NLS_MAX_CHARSET_SIZE 6 /* for UTF-8 */
> 
> === exfat ===
> exfat/exfat_raw.h
> #define EXFAT_MAX_FILE_LEN 255
> 
> exfat/super.c
> static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
> {
> 	...
>     /* Unicode utf16 255 characters */
>     buf->f_namelen = EXFAT_MAX_FILE_LEN * NLS_MAX_CHARSET_SIZE;
> 
> === vfat ===
> include/uapi/linux/msdos_fs.h
> #define FAT_LFN_LEN 255     /* maximum long name length */
> 
> fat/inode.c
> static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
> {
> 	...
>     buf->f_namelen =
>         (sbi->options.isvfat ? FAT_LFN_LEN : 12) * NLS_MAX_CHARSET_SIZE;
> 
> => i.e. for vfat without long filename support it'd be 72.
> 
> How about
> 1) don't skip exfat and vfat but just skip creating file with valid name? or
> 
> 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate
> length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?
> 
> Kind regards,
> Petr
> 

Thank you for the review and research on vfat, exfat scenarios.
I have adopted the option 1 for now and sent a v3 of this patch.


Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
