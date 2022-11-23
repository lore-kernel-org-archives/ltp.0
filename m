Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C695C433FE
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 12:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79AA03CCA2D
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 13:01:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4449F3C0162
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 13:01:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C43AE60004A
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 13:00:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14FB61F8C0;
 Wed, 23 Nov 2022 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669204858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiaeddghVhYVm//HSXvwy2PnLwzXyYmqhH5qcEk5rmw=;
 b=cFBJSSHLwowNLFc6JrqEJLo4wdWZe9krDkEUeZUrgUyvVJZ5gbCe4iU6lw9tmIzq7/PUNS
 /x+VR5MxkCB1IfusBfZpe5SdOuoMD66pu4hYS/B3djjifTEMYv1qTYrJlvczdp64gYtujX
 rkvT4e9Y2ENmRs2MWylHIPZW8YVQdw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669204858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiaeddghVhYVm//HSXvwy2PnLwzXyYmqhH5qcEk5rmw=;
 b=82OijcNtfXPgCNpQLgK2FSA1JNy9EP50NfOT2EW+GE+wkqWPZS/bd9MfDJQK/gYOt9n+ZQ
 L+u2mfjX7fS3pYDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB94913AE7;
 Wed, 23 Nov 2022 12:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SuZ/EHkLfmMoWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Nov 2022 12:00:57 +0000
Date: Wed, 23 Nov 2022 13:00:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: SANDUR Suresh <suresh-s.sandur@thalesgroup.com>
Message-ID: <Y34Ldi2CIHPYc8Hk@pevik>
References: <MR1P264MB3953913324A116A1E9CADE40A80D9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MR1P264MB3953913324A116A1E9CADE40A80D9@MR1P264MB3953.FRAP264.PROD.OUTLOOK.COM>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Need info on LTP tests that use /dev/loop mount device.
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

Hi Suresh,

> Hello,

> I am trying to understand the test cases that use the /dev/loop* device. For example the following tests use the loop device:

> chmod06, chown04, chown04_16, create06, fallocate04, fallocate05 and fsetxattr01

> What is the purpose of using the /dev/loop device? Is it to test some feature of the FS which cannot be done with the currently mounted FS? For example, execute the testcase on a RO filesystem? Are there any others? I am not sure about this, but does LTP also do something like mount the loop device and put different FS, like ext2, ext3, ext4, xfs on the loop device and run the same testcase?

/dev/loop is used for .all_filesystems to run the test on various filesystems
(btrfs, exfat, ext2, ext3, fuse, ntfs, vfat, tmpfs, xfs). But you could pass a
real device via environment variable $LTP_DEV.

https://github.com/linux-test-project/ltp/wiki/C-Test-API#115-testing-with-a-block-device
https://github.com/linux-test-project/ltp/wiki/C-Test-API#113-filesystem-type-detection-and-skiplist

Kind regards,
Petr

> regards,
> Suresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
