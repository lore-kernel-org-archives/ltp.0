Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D6CC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:45:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2393CC48F
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:45:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70F223CC450
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:45:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B00491001144
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:45:12 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9B8E121AAE;
 Thu,  1 Dec 2022 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669887912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9A0vuQl0PJQprHt1qfFmIu4siUDANP5myz8wszOnK0=;
 b=mP45wUxXpvxuYMdl6B40HnSHGysg01sOpvXqbDKdCOWUTPP3XHgvrOOD33VNlg1AOomDbo
 zUDhVbBUtFK8hOdAoYgIKbJaPNfHoVO/06yCkfGCRyq7NQGZ54G/n7SmTclxOGT6b4YdM9
 5AL+A7NmOQ9vjKq0i4kgJVQypBsfOU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669887912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9A0vuQl0PJQprHt1qfFmIu4siUDANP5myz8wszOnK0=;
 b=lZXmNoea6BmG5LDVk2KNvNj3wmwikJhN/uN7dwMb9vKUMQpug1GJOZNholqzYuhkWp8SNq
 ZteixtRupIG9V7DQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5D4412C142;
 Thu,  1 Dec 2022 09:45:12 +0000 (UTC)
References: <87r0xmt3ts.fsf@suse.de> <20221130070500.28664-1-akumar@suse.de>
 <Y4cZxK/SqTtpQb07@pevik> <Y4cnbaAtMAtw3IWC@pevik>
 <CAEemH2dO+QXEteiEOqA5o_Axxxe9c4mdPrMB34Pj1FMPyDf9EQ@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 01 Dec 2022 09:34:07 +0000
Organization: Linux Private Site
In-reply-to: <CAEemH2dO+QXEteiEOqA5o_Axxxe9c4mdPrMB34Pj1FMPyDf9EQ@mail.gmail.com>
Message-ID: <87y1rrihjs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> On Wed, Nov 30, 2022 at 5:50 PM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi all,
>>
>> ...
>> > > +static struct tst_test test = {
>> > > +   .test_all = run,
>> > > +   .setup = setup,
>> > > +   .needs_root = 1,
>> > > +   .mount_device = 1,
>> > > +   .mntpoint = MNT_POINT,
>> > > +   .all_filesystems = 1,
>> > > +   .skip_filesystems = (const char *const[]) {
>> > > +           "vfat",
>> > > +           "exfat",
>> > I was looking what's wrong with vfat and exfat.
>> > statvfs.f_namemax returns 1530, which is obviously too long, thus
>> valid_fname
>> > obviously returns ENAMETOOLONG (36). Tested on
>> 6.1.0-rc6-1.g4c01546-default.
>> > I wonder why, isn't that a bug?

This is the kind of issue which made me think it should be a separate
patch. Because maybe it is a bug.

>>
>> To reply myself, both glibc and musl defines:
>> statvfs->f_namemax = statfs->f_namelen;
>>
>> TL;DR: 6 * 255 = 1530 due names being in UTF-8:
>>
>> Therefore looking into kernel sources for statfs->f_namelen:
>>
>> include/linux/nls.h
>> #define NLS_MAX_CHARSET_SIZE 6 /* for UTF-8 */
>>
>> === exfat ===
>> exfat/exfat_raw.h
>> #define EXFAT_MAX_FILE_LEN 255
>>
>> exfat/super.c
>> static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
>> {
>>         ...
>>     /* Unicode utf16 255 characters */
>>     buf->f_namelen = EXFAT_MAX_FILE_LEN * NLS_MAX_CHARSET_SIZE;
>>
>> === vfat ===
>> include/uapi/linux/msdos_fs.h
>> #define FAT_LFN_LEN 255     /* maximum long name length */
>>
>> fat/inode.c
>> static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
>> {
>>         ...
>>     buf->f_namelen =
>>         (sbi->options.isvfat ? FAT_LFN_LEN : 12) * NLS_MAX_CHARSET_SIZE;
>>
>> => i.e. for vfat without long filename support it'd be 72.
>>
>> How about
>> 1) don't skip exfat and vfat but just skip creating file with valid name?
>> or
>>
>
> Sure, I think this method is better.

Is it supposed to return the length in bytes or unicode 'characters'? If
it's the later then things get really complicated so I guess it's bytes.

However BTRFS also supports unicode (and bigger file names in theory)
and just reports 255. If you look at the BTRFS code comments, it says
that they limited it to 255 because other things might break.

So will creating a file with > 255 chars ever work, even if we use
UTF-16 symbols?

In the meantime could we just read the data into a guarded buffer and
check it's not all zero's or all one's (for e.g.)?

>
>
>>
>> 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate
>> length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?
>>
>> Kind regards,
>> Petr
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
>>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
