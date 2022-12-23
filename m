Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6169AC4332F
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 14:41:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653C53CB9CA
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 15:40:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39C3D3CB945
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 15:40:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F07F0601BD5
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 15:40:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 387D66AFF5;
 Fri, 23 Dec 2022 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671806447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7kFe/MdqUQgNvukhhDpGQXDloCC5wVAVAf4nVb1Cgg=;
 b=Wg2o6dsLChY8Q/T4wYPgHmePJDS5U/8wMGXwe5YZ9WqU+kum3SrSmhEZHnHrwBMIGm6neO
 ec9remOKA13ALCcj2iyLpPw/1Biz+QAZiF4sRToP2XTuElzaXu83qsF6bVMVA2pfP+B13K
 nIvHUzfYSMrx4bT2wvA2NTkOSPATSCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671806447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7kFe/MdqUQgNvukhhDpGQXDloCC5wVAVAf4nVb1Cgg=;
 b=TOIrc8TTWO6a4ft4zU3kWGTLgrt8/VaIi0p44hFSI3NgUySiPaYPzmp8mCj8BPZvxtjh/l
 SJZx5bf2xVScV9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FCC2138E4;
 Fri, 23 Dec 2022 14:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yOgkOO29pWMIcAAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 23 Dec 2022 14:40:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>, rpalethorpe@suse.de
Date: Fri, 23 Dec 2022 20:10:43 +0530
Message-ID: <1737562.O6BcrhNQLJ@localhost>
Organization: SUSE
In-Reply-To: <87a63fsqs3.fsf@suse.de>
References: <Y5xF6PU5Yvh+oku5@pevik> <Y6QoLAfvY/W175WH@pevik>
 <87a63fsqs3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Richie,

Thank you for reviewing again and providing more improvement suggestions, I've
made the changes in v6.

Thanks,
Avinesh

On Thursday, December 22, 2022 3:23:35 PM IST Richard Palethorpe wrote:
> Hello,
> 
> Petr Vorel <pvorel@suse.cz> writes:
> 
> > Hi Avinesh, Richie,
> >
> > Generally LGTM, thanks for fixing exfat and vfat.
> >
> >> > +	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
> > However, length could be smaller:
> > Instead using buf.f_namemax + 1 (1531) also for exfat and vfat,
> > invalid length is already buf.f_namemax / NLS_MAX_CHARSET_SIZE + 1
> > (256).
> >
> >> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> >> > +		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> >> > +	else
> >> > +		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);
> 
> There is also a memory leak when running with -I. You could just use an
> 4Kb (PATH_MAX) static buffer as the name. If we find an FS that allows
> longer names then we can increase it.
> 
> We could also use a guarded buffer (specified in tst_test).
> 
> >
> >> > -		if (TEST_RETURN == -1) {
> >> > -			tst_resm(TFAIL | TTERRNO, "statvfs(%s, ...) failed",
> >> > -				 TEST_PATH);
> >> > -		} else {
> >> > -			tst_resm(TPASS, "statvfs(%s, ...) passed", TEST_PATH);
> >> > -		}
> >> > +	memset(toolong_fname, 'b', buf.f_namemax + 1);
> >> > +	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> >> > +		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> >> > +	else
> >> > +		memset(valid_fname, 'a', buf.f_namemax - 1);
> > Also valid length is for buf.f_namemax, not buf.f_namemax - 1. I guess -1 is for
> > \0 (NULL terminator), but tests work even with just buf.f_namemax.
> >
> > Also adding variable to hold the length makes source more readable.
> > How about this?
> >
> > 	struct statvfs buf;
> > 	char *valid_fname, *toolong_fname;
> > 	long fs_type;
> > 	long valid_len;
> >
> > 	fs_type = tst_fs_type(TEST_PATH);
> >
> > 	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
> >
> > 	valid_len = buf.f_namemax;
> > 	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> > 		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;
> >
> > 	valid_fname = SAFE_MALLOC(valid_len);
> > 	memset(valid_fname, 'a', valid_len);
> >
> > 	toolong_fname = SAFE_MALLOC(valid_len + 1);
> > 	memset(toolong_fname, 'b', valid_len + 1);
> >
> > Final diff is below.
> >
> > Kind regards,
> > Petr
> >
> > diff --git testcases/kernel/syscalls/statvfs/statvfs01.c testcases/kernel/syscalls/statvfs/statvfs01.c
> > index 034835da7d..f357855eb1 100644
> > --- testcases/kernel/syscalls/statvfs/statvfs01.c
> > +++ testcases/kernel/syscalls/statvfs/statvfs01.c
> > @@ -25,22 +25,21 @@ static void run(void)
> >  	struct statvfs buf;
> >  	char *valid_fname, *toolong_fname;
> >  	long fs_type;
> > +	long valid_len;
> >  
> >  	fs_type = tst_fs_type(TEST_PATH);
> >  
> >  	TST_EXP_PASS(statvfs(TEST_PATH, &buf));
> >  
> > -	toolong_fname = SAFE_MALLOC(buf.f_namemax + 1);
> > +	valid_len = buf.f_namemax;
> >  	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> > -		valid_fname = SAFE_MALLOC(buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> > -	else
> > -		valid_fname = SAFE_MALLOC(buf.f_namemax - 1);
> > +		valid_len = buf.f_namemax / NLS_MAX_CHARSET_SIZE;
> >  
> > -	memset(toolong_fname, 'b', buf.f_namemax + 1);
> > -	if (fs_type == TST_VFAT_MAGIC || fs_type == TST_EXFAT_MAGIC)
> > -		memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1);
> > -	else
> > -		memset(valid_fname, 'a', buf.f_namemax - 1);
> > +	valid_fname = SAFE_MALLOC(valid_len);
> > +	memset(valid_fname, 'a', valid_len);
> > +
> > +	toolong_fname = SAFE_MALLOC(valid_len + 1);
> > +	memset(toolong_fname, 'b', valid_len + 1);
> >  
> >  	TST_EXP_FD(creat(valid_fname, 0444));
> >  	SAFE_CLOSE(TST_RET);
> 
> 
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
