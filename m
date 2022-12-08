Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB049C63708
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 06:35:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08BA13CC055
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 07:35:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 150EF3CB123
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:35:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6358610007FB
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 07:35:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8426E206B6;
 Thu,  8 Dec 2022 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670481331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw7aNJyZs3Zm/1w4PycCls1O0R5fPnY8r8sFQsna9KA=;
 b=dHcE9wS5eriE245QoChhYbAuDok7MCTX313ciY5js72Xoh71KnWupVrSB/oTaNayVJ+tEw
 o65H5nSuONx/NgLieEvDSwmihRJKoyotZaT88USREw4iOdHMpB/ooZ1JkOWGigD71TvB/Y
 ohfSpB74MpOAwmu6w8F771t5IM0XYOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670481331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aw7aNJyZs3Zm/1w4PycCls1O0R5fPnY8r8sFQsna9KA=;
 b=l8qf0zQfD3rux2+1VtHJz2zeyVbtBidRFKsMG4smUve4cRcKcBrywO4k0hzowx/zPWB/CL
 XQXX8EC+WGewTMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC79F13416;
 Thu,  8 Dec 2022 06:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h+dFH7KFkWMpdwAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 08 Dec 2022 06:35:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 08 Dec 2022 12:05:28 +0530
Message-ID: <2042676.XiyxxtkoYD@localhost>
Organization: SUSE
In-Reply-To: <CAEemH2dW2u+tYQUtvresJXMYYfaqiXqtKksdK4rHaGTCG+5L0w@mail.gmail.com>
References: <20221206075747.17352-1-akumar@suse.de>
 <CAEemH2dW2u+tYQUtvresJXMYYfaqiXqtKksdK4rHaGTCG+5L0w@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setresuid04.c: Rewrite the test using new LTP API
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

Hi Li,

On Thursday, December 8, 2022 9:07:08 AM IST Li Wang wrote:
> Hi Avinesh,
> 
> Avinesh Kumar <akumar@suse.de> wrote:
> 
> > -               /* Test 2: Check a son process cannot open the file
> > -                *         with RDWR permissions.
> > -                */
> > -               pid = FORK_OR_VFORK();
> > -               if (pid < 0)
> > -                       tst_brkm(TBROK, NULL, "Fork failed");
> > -
> > -               if (pid == 0) {
> > -                       int tst_fd2;
> > +       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
> 
> There is no reason to modify 'real UID' and 'saved set-user-ID'
> at this time, we do only care about 'effective UID' made changes
> successfully or not.
> 
Yes, Thank you, I realized this while working on setresuid05.c test.
I think we should leave the 'real UID' and 'saved set-user-ID'
untouched even when resetting 'effective UID' to root:
       SAFE_SETRESUID(0, 0, 0); should be
       SAFE_SETRESUID(-1, 0, -1);

I will send another patch as we also need to add .needs_tmpdir=1
because we are creating a temp file.


> So I tweaked the patch a tiny and merged it:
> 
> --- a/testcases/kernel/syscalls/setresuid/setresuid04.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
> @@ -40,7 +40,7 @@ static void run(void)
>         pid_t pid;
>         int status;
> 
> -       SAFE_SETRESUID(0, ltpuser->pw_uid, 0);
> +       SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
>         TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
> 
>         pid = SAFE_FORK();
> 
> 
> 

Best regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
