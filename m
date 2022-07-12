Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C82CC433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 16:07:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09A263CA2E9
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 18:06:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 880433CA1BA
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 18:06:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D66C910009DA
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 18:06:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C5913203AC;
 Tue, 12 Jul 2022 16:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657642007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iE/rBV1YF3zwpA73n7PcTv7cBNE8yvQ3v/jPeR1JW8s=;
 b=xPcvn7cYv8AfwE6Vl/MqFbd6VhGrra/nTHnqG8wq35nPdMYZRpcmaZ6bGlso0y0B957BIb
 bKLLlNRQ9xQHyn8C1Y/f+afNr2rhUSOhW4hqwFx440tmGm18BRWqgk+psRVKdFGTkwRa1x
 vBmhPNPF1GJy+xVOMkb8gwrXjEpmis8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657642007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iE/rBV1YF3zwpA73n7PcTv7cBNE8yvQ3v/jPeR1JW8s=;
 b=nYlkEyDx/DQ07OtQ8om7wLubumeP6uIHtHIUt74KEt+HZyTMuLXOJmmfo75iRxlHYnaaPu
 5O3xOQk7/tb9ZKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B905113A94;
 Tue, 12 Jul 2022 16:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pbeyHRaczWIVCgAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 12 Jul 2022 16:06:46 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:36:44 +0530
Message-ID: <118407732.DU46jWBZyT@localhost>
Organization: SUSE
In-Reply-To: <YsxHHDw0H1lZTFMN@pevik>
References: <20220708170634.842-1-akumar@suse.de> <YsxHHDw0H1lZTFMN@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fstat02.c: simplify using TST_EXP_*() macros
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

On Monday, July 11, 2022 9:21:56 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> 
> LGTM, thanks!
> Minor comments below.
Hi Petr, Thank you! I agree with your comments here.
Do I need to send v2 or you will merge with these changes?

> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ...
> > +++ b/testcases/kernel/syscalls/fstat/fstat02.c
> ...
> > -#include <errno.h>
> > -#include <unistd.h>
> > -#include <sys/stat.h>
> > -#include <sys/types.h>
> >  #include "tst_test.h"
> > -#include "tst_safe_macros.h"
> 
> nit: obviously works without all these headers, but <sys/stat.h> is
> needed (fstat) but included by tst_test.h
> 
> > +
> > +/*\ [Description]
> > + *
> 
> This is wrong, causes docparse not being formatted. It must be:
> /*\
>  * [Description]
> 
> (can be fixed before merge)
> 
> >   * Tests if fstat() returns correctly and reports correct file information
> >   * using the stat structure.
> >   */
> ...
> > -	tst_res(TPASS, "fstat() reported correct values.");
> > +	TST_EXP_PASS(fstat(fildes, &stat_buf));
> > +	TST_EXP_EQ_LI(stat_buf.st_uid, user_id);
> > +	TST_EXP_EQ_LI(stat_buf.st_gid, group_id);
> nit: At least st_uid and st_gid are unsigned, thus maybe TST_EXP_EQ_LU?
> > +	TST_EXP_EQ_LI(stat_buf.st_size, FILE_SIZE);
> > +	TST_EXP_EQ_LI(stat_buf.st_mode & 0777, FILE_MODE);
> > +	TST_EXP_EQ_LI(stat_buf.st_nlink, NLINK);
> >  }
> 
> Kind regards,
> Petr
> 

--
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
