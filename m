Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E870C43217
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 11:54:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4553CAEAB
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 13:54:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF8903CADF8
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 13:54:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB72610006CC
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 13:54:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE4C1F388;
 Wed, 12 Oct 2022 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665575678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ca3ncexORfoGm3ZLEzAiJtEGKiuOWz2y7SF5kC/OWAA=;
 b=xAXvTp9eSbSSCiGnTs4sq5G84hqk4/x9OwwpHtw2WIsjI6DTSWQh8Vj5mmE6h6ysToEyrd
 JspJEk9trC8Il4NVyLHe7O7dkOvq8FQk0Zt/MC07xzDEKpm4mhxYpBWLg0TtE/sDlwvUAx
 lCcyDIWsRQnlKml/nicCPdSP0brBAKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665575678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ca3ncexORfoGm3ZLEzAiJtEGKiuOWz2y7SF5kC/OWAA=;
 b=fZMoRd6Wc2bzD5rEBAtGpfJOOJSXbAFVGkEpZDBKT5hr2OaagfkUH8+q1WfFXxvdIQiLDw
 +wFdmC8p3THy1JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C5A713A5C;
 Wed, 12 Oct 2022 11:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ruGjFP6qRmNVQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Oct 2022 11:54:38 +0000
Date: Wed, 12 Oct 2022 13:54:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Y0aq/Oar7Swmqzhj@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

> On Mon, 2022-10-10 at 13:43 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > FYI I have problems with ima_violations.sh, when run whole runtest/ima:

> > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
> > ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.Og149san78/mntpoint
> > ima_violations 1 TINFO: timeout per run is 0h 5m 0s
> > ima_violations 1 TINFO: IMA kernel config:
> > ima_violations 1 TINFO: CONFIG_IMA=y
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> > ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
> > ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> > ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
> > ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> > ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> > ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y

> > ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-
> > 5.19.12-1-default root=UUID=6de93d21-b5ed-4aa4-a9e4-00a7ab77c6d9
> > splash=silent video=1024x768 plymouth.ignore-serial-consoles
> > console=ttyS0 console=tty kernel.softlockup_panic=1
> > resume=/dev/disk/by-uuid/570474ff-969e-41e6-883e-ecff2fd15015
> > security=apparmor mitigations=auto ignore_loglevel lsm=integrity
> > ima_policy=tcb

> I would use either use the original "security=" or the new "lsm=" boot
> command line option.
FYI lsm= ima_policy=tcb would break booting, although on 5.19 I don't se the
warning lsm asking to have integrity among the values. That's the old problem,
it'd be good to move integrity off the security hook as you suggested [2].
Therefore only "security=" or without both "lsm" or "security" kernel boots.

BTW security=apparmor is in the result of the setup from openSUSE installer. It
got back to using security, due previously mentioned problem with boot..

Although "security=apparmor lsm=integrity ima_policy=tcb" might not be a good
idea, it does not cause ima_violations.sh. Actually with all of these fails
ima_violations.sh fails:
* lsm=integrity ima_policy=tcb (without security=apparmor)
* security= ima_policy=tcb
* ima_policy=tcb

For some reason ima_violations.sh works, when run as the first test after boot
(at least with only "ima_policy=tcb" setup), but not when whole ima runtest file
is run (as there are tests run before it).  I'm still trying to figure out
what's wrong.  What do you use for running LTP IMA tests? And do you run whole
runtest file?

Questions:
* which kernel cmdline options (IMA related) makes sense to use on testing IMA?
* is it feasible to have cmdline setup which which would be suitable
for all tests (running ima runtest file) + any of these tests? At least have a
detection and TCONF instead of failure.

> > ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> > ima_violations 1 TINFO: LTP IMA policy rules based on fsuuid=7ab2cd65-3060-4dbc-b786-72703604a33e
> > ima_violations 1 TINFO: using log /var/log/audit/audit.log
> > ima_violations 1 TINFO: verify open writers violation
> > ima_violations 1 TFAIL: open_writers violation not added
> > ima_violations 2 TINFO: verify ToMToU violation
> > ima_violations 2 TFAIL: ToMToU violation not added
> > ima_violations 3 TINFO: verify open_writers using mmapped files
> > tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> > ima_mmap.c:38: TINFO: sleep 3s
> > ima_violations 3 TFAIL: open_writers violation not added
> > ima_mmap.c:41: TPASS: test completed

> > My fix [1] does not help. Problems are with my changes or just with your
> > original patch. Continue debugging.
> > Kind regards,
> > Petr

> > [1] https://patchwork.ozlabs.org/project/ltp/patch/20221010085944.26814-1-pvorel@suse.cz/

> Only the ima_conditionals.sh and ima_policy.sh tests define policy
> rules based on fsuuid.  The other tests are still based on the builtin
> "ima_policy=tcb" rules.
Ah, correct. What was the reason not to transform the rest?
Maybe my following patch which uses loop device for all tests wasn't a good
idea.

> Without seeing the output of "cat /sys/kernel/security/ima/policy" it's
> hard to understand what's causing these errors.
It's empty. with fsuuid based setup I'll try to use policy examples, so that it
won't TCONF, but that's a next step after we solve this.

Kind regards,
Petr

[2] https://lore.kernel.org/linux-integrity/cacde31235f08eeec698c63025a0eef81e10fe71.camel@linux.ibm.com/

> thanks,

> Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
