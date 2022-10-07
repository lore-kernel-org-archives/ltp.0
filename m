Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B96DC433FE
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 05:27:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3E0B3CAC83
	for <ltp@archiver.kernel.org>; Fri,  7 Oct 2022 07:27:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6913C2830
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 07:27:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7288B2002D1
 for <ltp@lists.linux.it>; Fri,  7 Oct 2022 07:27:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E262621990;
 Fri,  7 Oct 2022 05:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665120454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vClZoecc4l3EoEAbA3KLCjsAuYzbu/emrxLai2SOJkg=;
 b=o3IzREyntRVbG+i5qugUkI9RiKuF/ke/aKHYgbebG9z2RlNQgIW1h7PpLAVzfzbzu1rYIy
 tJAps0b3Sd8XsZ5/a81KM64j9nhO4SiQnKvaJybAmPLqv+cbultgsKCtUbQ5NOWdpKEUTn
 piNtReVrPiDroy1V8EuqiRJDWqhqOkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665120454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vClZoecc4l3EoEAbA3KLCjsAuYzbu/emrxLai2SOJkg=;
 b=flAaoqcKNAfIXXD8qaYTq/EiOCMeNW6JyAxlQGhVFc0lLGAJLLlwoMqFkRGUKRkAph6CMN
 urucjJJLtf6fzPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B305F13345;
 Fri,  7 Oct 2022 05:27:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0PdJKsa4P2NgMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 07 Oct 2022 05:27:34 +0000
Date: Fri, 7 Oct 2022 07:27:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Yz+4xepB6HlyFSNJ@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

Hi Mimi,

> Hi Petr,

> On Thu, 2022-10-06 at 23:02 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > > The LTP policy rules either replace or extend the global IMA policy. As a
> > > result, the ordering of the LTP IMA tests is important and affects the
> > > ability of re-running the tests.  For example, ima_conditionals.sh
> > > defines a rule to measure user files, while ima_measuremnets.sh verifies
> > > not measuring user files.  Not limiting the LTP IMA policy scope could
> > > also affect the running system.

> > > To allow the LTP tests to be re-run without rebooting the system, limit the
> > > scope of the LTP policy rules to the loopback mounted filesystem based on
> > > the UUID.
> > Thanks a lot for this, that'll be a great simplification for IMA testing.

> By limiting the scope of the IMA policy rules, not everything would
> have to be signed on the file system, which brings us one step closer
> to defining LTP appraise policy rules.

> > I'll have a deeper look tomorrow, but what we need is to ima_setup.sh is to
> > always have loopback device. ATM it's just only if TMPDIR is tmpfs.
> > See patch below (untested, I'll test it tomorrow).

> Agreed.   Seems to be working.  :)
Thanks!

> > Also is the kernel code path very different to use UUID from the current code?

> The code path is the same - either the policy rule matches or it
> doesn't.  Previously, however, the test files being measured could have
> been located on any filesystem.  With this change, the test files now
> have to be on the UUID filesystem.

Good to know. Also, we have new feature in shell API: $TST_ALL_FILESYSTEMS (it
has been for long time for C API as .all_filesystems, which loops the test over
various filesystems: ext2, ext3, ext4, xfs, btrfs, vfat, exfat, ntfs, tmpfs.
Test therefore takes much longer, but it's worth for tests which can behave
differently on various filesystems. I suppose IMA does not need it, right?

> > If yes, we might want also to keep the old behavior enabled with some environment
> > variable (the default would be to use UUID). Or not worth of keeping it?

> Instead of keeping the old behavior, how about defining additional file
> tests that do not match the new UUID policy rule?   These files will
> not be measured.
Correct measurement outside of the loop device? I.e. something in $TST_TMPDIR?
(i.e. /tmp/foo - test unique working directory, $TST_MNTPOINT is mounted on
/tmp/foo/mntpoint, so that we still have working place outside mounted loop device).
Do you mean trying to measure something what expects to fail?

> > I'd also wish to have simple C implementation instead requesting blkid
> > (although util-linux is very common, it's an extra dependency).
> > I might write simple C code which finds which UUID in /dev/disk/by-uuid/ is for
> > loop device should be pretty simple code. But for now it's ok to use blkid,
> > although it should be added into TST_NEEDS_CMDS.

> Sure.  I posted this patch more as a proof of concept than anything
> else.
+1

> > ...
> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > > index 0d50db906..d5c5f3ebe 100755
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> > > @@ -28,7 +28,7 @@ verify_measurement()
> > >  	ROD rm -f $test_file

> > >  	tst_res TINFO "verify measuring user files when requested via $request"
> > > -	ROD echo "measure $request=$value" \> $IMA_POLICY
> > > +	ROD echo "measure $FSUUID $request=$value" \> $IMA_POLICY
> > >  	ROD echo "$(cat /proc/uptime) $request test" \> $test_file

> > >  	case "$request" in
> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > index af1fb0028..95e7331a4 100755
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> > > @@ -27,7 +27,12 @@ load_policy()
> > >  	exec 2>/dev/null 4>$IMA_POLICY
> > >  	[ $? -eq 0 ] || exit 1

> > > -	cat $1 >&4 2> /dev/null
> > > +	if [ -n "$FSUUID" ]; then
> > Interesting, would it be correct if there is no UUID with my changes below (i.e.
> > always use the loop device)? Actually, do we also want to have way to disable
> > loop device (obviously only on TMPDIR not being tmpfs).

> If/when using a non loopback device, there should at least be a major
> warning that the global policy has been modified.
OK not quiting whole test with TBROK, but add TWARN (test continue, but later
exits with non-zero).

> > > +		sed "s/measure /measure $FSUUID /" $1 >&4 2> /dev/null
> > > +	else
> > > +		cat $1 >&4 2> /dev/null
> > > +	fi
> > > +
> > >  	ret=$?
> > >  	exec 4>&-

> > > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > index df3fc5603..016a68cb2 100644
> > > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -178,6 +178,10 @@ ima_setup()
> > >  	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
> > >  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
> > >  		cd "$TST_MNTPOINT"
> > > +
> > > +		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
> > We have $TST_DEVICE for this.

> > > +		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
> > > +		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
> > >  	fi

> > >  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER

> > Proposed (not yet tested) changes.


> Thanks, the proposed changes seem to be working.
Thanks a lot for testing. I give it try today and merge it today or early next
week.

Kind regards,
Petr

> thanks,

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
