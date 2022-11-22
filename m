Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF9C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 12:41:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFDA73CCAD1
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 13:41:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF2B93C1B75
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:41:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E9737D9FCB
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 13:41:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8728A1F88C;
 Tue, 22 Nov 2022 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669120863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2I4qKdFPmJMZaCHc4lp5XnoXGhoDy7NEUv1LlBd19M=;
 b=exfj9c58YuBOupDHveiKdTDxtOjc+5ALWutk1bJwG7CjnyFnUsffd/bFAGoOxGVHzBPMK/
 JnJECOTo7ZkmWHo0gvpm7mqHo/W4uN3DDT8p42/I8uKmU7ge/0c8nLXQ4Oogiiul1fZcGK
 1o9MYoygJLuT7eXCcEQ8MLli3hldNuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669120863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2I4qKdFPmJMZaCHc4lp5XnoXGhoDy7NEUv1LlBd19M=;
 b=5FxBSHHSKG6Vxch3nqfjRNheMXxkuCqBDs4ZaFz16Mg87pc0yhk6IctdFJI+rqev0Nc1cB
 KMJE7izjWuR+cSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7126D13B01;
 Tue, 22 Nov 2022 12:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PPm2GV/DfGOTMAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Nov 2022 12:41:03 +0000
Date: Tue, 22 Nov 2022 13:42:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y3zDsuPkRG3Ms+aP@yuki>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-3-jack@suse.cz> <Y3uUl06QCF6vr5IY@yuki>
 <Y3yk0Im/h5cOCLgx@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3yk0Im/h5cOCLgx@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify10: Make evictable marks tests more
 reliable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!@
> > > +	for (i = 0; i < max_file_multi; i++) {
> > > +		char path[PATH_MAX];
> > > +
> > > +		sprintf(path, FILE_PATH_MULTIDIR, i);
> > > +		SAFE_UNLINK(path);
> > > +		sprintf(path, DIR_PATH_MULTI, i);
> > > +		SAFE_RMDIR(path);
> > > +		sprintf(path, FILE_PATH_MULTI, i);
> > > +		SAFE_UNLINK(path);
> > > +	}
> > >  	SAFE_UNLINK(FILE_PATH);
> > > -	SAFE_UNLINK(FILE2_PATH);
> > >  	SAFE_RMDIR(SUBDIR_PATH);
> > >  	SAFE_RMDIR(DIR_PATH);
> > >  	SAFE_RMDIR(MNT2_PATH);
> 
> > Do we have to unlink anything at all?
> 
> > As far as I can tell we create these files on a device that is
> > reformatted after the test anyways.
> 
> It looks it's not cleared, because tmpdir is removed in do_cleanup(),
> which is called just before the end of testing, not for each filesystem:
> 
> https://github.com/linux-test-project/ltp/tree/master/lib
> 
> Files created for testing in test's setup() are called for each filesystem
> (do_test_setup), therefore files would remain created:
> 
> fanotify10.c:894: TBROK: mkdir(fs_mnt/testdir, 0755) failed: EEXIST (17)
> 
> Summary:
> passed   492
> failed   0
> broken   1
> skipped  3
> warnings 0
> 
> And even if we disable just SAFE_UNLINK(FILE_PATH); we get errors
> due our rmdir() implementation wanting directory being empty:
> 
> fanotify10.c:953: TWARN: rmdir(fs_mnt/testdir) failed: ENOTEMPTY (39)
> fanotify10.c:894: TBROK: mkdir(fs_mnt/testdir, 0755) failed: EEXIST (17)
> fanotify10.c:952: TWARN: rmdir(fs_mnt/testdir/testdir2) failed: ENOENT (2)
> fanotify10.c:953: TWARN: rmdir(fs_mnt/testdir) failed: ENOTEMPTY (39)
> fanotify10.c:954: TWARN: rmdir(mntpoint) failed: ENOENT (2)
> 
> IMHO it's safer to remove these files instead of creating them just for first
> filesystem. Having unique path for each filesystem (e.g. use filesystem name in
> the directory path would result would solve the need to remove files but
> probably not worth of implementing.

Hmm, I was commenting under an impression that we create all files on
the device and it looks like that is the case, but we do not run with
.all_filesystems but rather than that with .variants = 2 and of course
we call do_test_setup() for each test variant. So yes we run the test
twice with the same device and the cleanup is required.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
