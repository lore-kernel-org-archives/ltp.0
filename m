Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7A5C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 10:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77E73CCADF
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 11:30:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A6A73CCAB4
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:30:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ED61600964
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:30:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99783220D4;
 Tue, 22 Nov 2022 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669113042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0jfFI2yZ61IJXxDiN1/D+klcxDB9kscgoa+lkZXORM=;
 b=Fi9tsSX6DoQgcAxeRYYhIk2LE+E0c+Sey3GzhnXFec/gEIIAu8MrSxps0S678cuv1XDB/M
 ED5nDM1kzWoOzLMtguNxrhMibYxMs349V1rvdrfmA9SXGO1sD6q/Ya8KkIAb0hO8olaUj1
 HFZIZAsqASGOHno4onfj7y0nBb1NhGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669113042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v0jfFI2yZ61IJXxDiN1/D+klcxDB9kscgoa+lkZXORM=;
 b=Clr0I6srfuhkXk2vUXB/VTlbwjmCxN4m0usxERmY9aC7RxF9fw50IEDE9MUdt3hFZudS9x
 zI3bL4IsBCigMNDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7512713B01;
 Tue, 22 Nov 2022 10:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hJsnG9KkfGMpXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 10:30:42 +0000
Date: Tue, 22 Nov 2022 11:30:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y3yk0Im/h5cOCLgx@pevik>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-3-jack@suse.cz> <Y3uUl06QCF6vr5IY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3uUl06QCF6vr5IY@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> >  static void setup(void)
> >  {
> > +	int i;
> > +
> >  	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> >  								      FAN_CLASS_CONTENT, 0);
> >  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> > @@ -880,7 +894,24 @@ static void setup(void)
> >  	SAFE_MKDIR(DIR_PATH, 0755);
> >  	SAFE_MKDIR(SUBDIR_PATH, 0755);
> >  	SAFE_FILE_PRINTF(FILE_PATH, "1");
> > -	SAFE_FILE_PRINTF(FILE2_PATH, "1");
> > +	for (i = 0; i < (int)(sizeof(tcases)/sizeof(tcases[0])); i++) {
>                                   ^
> 				  We do have the standard ARRAY_SIZE()
> 				  macro defined in LTP

With this being fixed before merge
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +		if (tcases[i].mark_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].mark_path_cnt;
> > +		if (tcases[i].ignore_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].ignore_path_cnt;
> > +		if (tcases[i].event_path_cnt > max_file_multi)
> > +			max_file_multi = tcases[i].event_path_cnt;
> > +	}
> > +	for (i = 0; i < max_file_multi; i++) {
> > +		char path[PATH_MAX];
> > +
> > +		sprintf(path, FILE_PATH_MULTI, i);
> > +		SAFE_FILE_PRINTF(path, "1");
> > +		sprintf(path, DIR_PATH_MULTI, i);
> > +		SAFE_MKDIR(path, 0755);
> > +		sprintf(path, FILE_PATH_MULTIDIR, i);
> > +		SAFE_FILE_PRINTF(path, "1");
> > +	}

> >  	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
> >  	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
> > @@ -896,6 +927,8 @@ static void setup(void)

> >  static void cleanup(void)
> >  {
> > +	int i;
> > +
> >  	cleanup_fanotify_groups();

> >  	if (bind_mount_created)
> > @@ -903,8 +936,17 @@ static void cleanup(void)

> >  	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);

> > +	for (i = 0; i < max_file_multi; i++) {
> > +		char path[PATH_MAX];
> > +
> > +		sprintf(path, FILE_PATH_MULTIDIR, i);
> > +		SAFE_UNLINK(path);
> > +		sprintf(path, DIR_PATH_MULTI, i);
> > +		SAFE_RMDIR(path);
> > +		sprintf(path, FILE_PATH_MULTI, i);
> > +		SAFE_UNLINK(path);
> > +	}
> >  	SAFE_UNLINK(FILE_PATH);
> > -	SAFE_UNLINK(FILE2_PATH);
> >  	SAFE_RMDIR(SUBDIR_PATH);
> >  	SAFE_RMDIR(DIR_PATH);
> >  	SAFE_RMDIR(MNT2_PATH);

> Do we have to unlink anything at all?

> As far as I can tell we create these files on a device that is
> reformatted after the test anyways.

It looks it's not cleared, because tmpdir is removed in do_cleanup(),
which is called just before the end of testing, not for each filesystem:

https://github.com/linux-test-project/ltp/tree/master/lib

Files created for testing in test's setup() are called for each filesystem
(do_test_setup), therefore files would remain created:

fanotify10.c:894: TBROK: mkdir(fs_mnt/testdir, 0755) failed: EEXIST (17)

Summary:
passed   492
failed   0
broken   1
skipped  3
warnings 0

And even if we disable just SAFE_UNLINK(FILE_PATH); we get errors
due our rmdir() implementation wanting directory being empty:

fanotify10.c:953: TWARN: rmdir(fs_mnt/testdir) failed: ENOTEMPTY (39)
fanotify10.c:894: TBROK: mkdir(fs_mnt/testdir, 0755) failed: EEXIST (17)
fanotify10.c:952: TWARN: rmdir(fs_mnt/testdir/testdir2) failed: ENOENT (2)
fanotify10.c:953: TWARN: rmdir(fs_mnt/testdir) failed: ENOTEMPTY (39)
fanotify10.c:954: TWARN: rmdir(mntpoint) failed: ENOENT (2)

IMHO it's safer to remove these files instead of creating them just for first
filesystem. Having unique path for each filesystem (e.g. use filesystem name in
the directory path would result would solve the need to remove files but
probably not worth of implementing.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
