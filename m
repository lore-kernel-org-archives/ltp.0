Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E73C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 10:42:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E3B53CAE72
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:42:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FCE33C28F3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:41:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79D496002F9
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:41:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 568082191E;
 Mon, 10 Oct 2022 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665398510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UOaFnGVMN7iXrqEZquHHe/Q+B0m/euy50uZVwxGjgk=;
 b=bx8vZ8vFIKZSpikP4klzlCw7acDFkoOhg5WFIbUUNdwjzcD7Pm5S/XWLYkSM4ImwwD+bwI
 /NegrmTqFWwdsMRfjEgmNiaR4HvsACITuO661ntQqDFGyGEAU7pkBwsooX4m2bp/agtSSk
 beZEwjSLDbaVgDeRYbYMK4XphMhEV3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665398510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UOaFnGVMN7iXrqEZquHHe/Q+B0m/euy50uZVwxGjgk=;
 b=VNCLCPTQA1b8cJyQdBv2zXVSiFqXLI/1wjebsFxtSr58vHzyjDmVxAXStyREOjVKJqhUuR
 oORIh0K45KhVG3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36CE713ACA;
 Mon, 10 Oct 2022 10:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hkR+C+72Q2OhMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Oct 2022 10:41:50 +0000
Date: Mon, 10 Oct 2022 12:41:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Y0P27II+FbjqAIz8@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On Fri, 2022-10-07 at 07:27 +0200, Petr Vorel wrote:

> > > > Also is the kernel code path very different to use UUID from the current code?

> > > The code path is the same - either the policy rule matches or it
> > > doesn't.  Previously, however, the test files being measured could have
> > > been located on any filesystem.  With this change, the test files now
> > > have to be on the UUID filesystem.

> > Good to know. Also, we have new feature in shell API: $TST_ALL_FILESYSTEMS (it
> > has been for long time for C API as .all_filesystems, which loops the test over
> > various filesystems: ext2, ext3, ext4, xfs, btrfs, vfat, exfat, ntfs, tmpfs.
> > Test therefore takes much longer, but it's worth for tests which can behave
> > differently on various filesystems. I suppose IMA does not need it, right?

> Nice!  IMA code paths are different on filesystems with/without
> i_version support.   With the proposed i_version kernel
> changes, ima_measurement.sh test2 is really important.

> On filesystems without i_version support, after a file has been opened
> for write, on fput IMA assumes the file has been modified.  On next
> access, the file is re-verified/re-measured.

> I'm not sure if ima_measurement.sh test2, which is limited to
> filesystems with i_version support, should be extended or a new test
> defined to detect whether a file is properly re-measured after it has
> been modified on all filesystems, even those without i_version support.


> > > > If yes, we might want also to keep the old behavior enabled with some environment
> > > > variable (the default would be to use UUID). Or not worth of keeping it?

> > > Instead of keeping the old behavior, how about defining additional file
> > > tests that do not match the new UUID policy rule?   These files will
> > > not be measured.
> > Correct measurement outside of the loop device? I.e. something in $TST_TMPDIR?
> > (i.e. /tmp/foo - test unique working directory, $TST_MNTPOINT is mounted on
> > /tmp/foo/mntpoint, so that we still have working place outside mounted loop device).
> > Do you mean trying to measure something what expects to fail?

> Yes, there shouldn't be a new measurement.

> > > > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > > index af1fb0028..95e7331a4 100755
> > > > > --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > > > @@ -27,7 +27,12 @@ load_policy()
> > > > >  	exec 2>/dev/null 4>$IMA_POLICY
> > > > >  	[ $? -eq 0 ] || exit 1

> > > > > -	cat $1 >&4 2> /dev/null
> > > > > +	if [ -n "$FSUUID" ]; then
> > > > Interesting, would it be correct if there is no UUID with my changes below (i.e.
> > > > always use the loop device)? Actually, do we also want to have way to disable
> > > > loop device (obviously only on TMPDIR not being tmpfs).

BTW using fsuuid= depends on v3.9, on commit:
85865c1fa189 ("ima: add policy support for file system uuid")

v3.9 is quite old, it shouldn't be a problem, but it'd be better to add TST_MIN_KVER="3.9"

I'll send v2, just for you to check the changes.

Kind regards,
Petr

> > > If/when using a non loopback device, there should at least be a major
> > > warning that the global policy has been modified.
> > OK not quiting whole test with TBROK, but add TWARN (test continue, but later
> > exits with non-zero).

> Sounds good.

> thanks,

> Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
