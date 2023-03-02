Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2469AC6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 10:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5C63CCDFC
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 11:45:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BE0D3CB9CF
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:45:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D979860091A
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:45:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4811FE66;
 Thu,  2 Mar 2023 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677753932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTLEaCQqRKiU+1MP7d2YCyM8Yi2mpzVcShD8ADzsj1s=;
 b=GxtQJXcHk2WQ+3h3fMbVlUHK9ifbN1McqRUvC6hvHQVPqP+YSpfHubgpKtQimece2Ja9Cx
 qmMvVkIjf5ZDrf/D1WwcEZYICz0a+iil/RmFOvqrj2H04+URYaq59/P+yOfjtUFROTyqcm
 z4tthoc8sO5nZ7wn1ZoOZfGm84MkqzY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C1C13349;
 Thu,  2 Mar 2023 10:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ssHcN0p+AGRWZQAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 02 Mar 2023 10:45:30 +0000
Date: Thu, 2 Mar 2023 05:45:27 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230302104527.GA17006@localhost>
References: <20230228032745.16595-1-wegao@suse.com>
 <20230302014519.31512-1-wegao@suse.com> <ZABzqALt4+Zjqtxq@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZABzqALt4+Zjqtxq@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fsconfig03: SKIP check return value for old
 kernel
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: kernel-qa@suse.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 02, 2023 at 11:00:08AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  .../kernel/syscalls/fsconfig/fsconfig03.c     | 21 ++++++++++++-------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > index 7ee37f4ae..9adf06207 100644
> > --- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > @@ -41,15 +41,20 @@ static void run(void)
> >  	if (pagesize == -1)
> >  		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
> 
> > -	for (size_t i = 0; i < 5000; i++) {
> > -		/* use same logic in kernel legacy_parse_param function */
> > -		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> > +	if ((tst_kvercmp(5, 17, 1)) >= 0) {
> I suppose 722d94847de29 (in .tags) change the old behavior (from v5.17-rc1).
> Shouldn't be the check against 5.17.0?
> if ((tst_kvercmp(5, 17, 0)) >= 0) {
yes, 5.17.0 is better one!
> 
> 
> > +		for (size_t i = 0; i < 5000; i++) {
> > +			/* use same logic in kernel legacy_parse_param function */
> > +			const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> 
> > -		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> > -			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > -		else
> > -			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > -					    EINVAL);
> > +			if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> > +				TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > +			else
> > +				TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > +						EINVAL);
> > +		}
> > +	} else {
> > +		for (size_t i = 0; i < 5000; i++)
> Repeating the loop again. Wouldn't be more readable moving the if clause to
> separate function and doing if/else inside of for loop?
> 
> Also "\x00" might be in #define (used 3 times).
> 
> Kind regards,
> Petr
> 
> > +			fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0);
> >  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
