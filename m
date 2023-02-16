Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEEDC61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 09:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F05D3CBF1C
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:42:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42C6E3CAEE8
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:42:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03362100078C
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 10:42:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 044B520930;
 Thu, 16 Feb 2023 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676540559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g4+9J5yMixOxWdAyjN61JFxifIA09Ee7hb3H09YPE5o=;
 b=ou3zfOkvGKxn2NW0e09Oi16hxOnVvpSdW+xg5VUhT7La6ikwm8Do3mCpc+aOZIYDY5Yt2x
 vXSFH/Lpje6EpmrvKz1Sm9rz2Y+P2T/yh/u5YvZgE/Il7zSnvaioX1tqokMQD/9Mlp/4rY
 eOeXpofqZyGaHIlRXRium9N7Z2UQ1Oo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 157C8139B5;
 Thu, 16 Feb 2023 09:42:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vHz3N4367WNPLwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 16 Feb 2023 09:42:37 +0000
Date: Thu, 16 Feb 2023 04:42:35 -0500
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20230216094235.GA29664@localhost>
References: <20230209131902.12260-1-wegao@suse.com>
 <20230213010924.12352-1-wegao@suse.com> <87a61go5ro.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a61go5ro.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fsconfig03: New test CVE-2022-0185
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Feb 14, 2023 at 11:05:24AM +0000, Richard Palethorpe wrote:
> Hello,
> 
> > +static void run(void)
> > +{
> > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > +	long pagesize;
> > +
> > +	pagesize = sysconf(_SC_PAGESIZE);
> > +	if (pagesize == -1)
> > +		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
> > +
> > +	for (size_t i = 0; i < 5000; i++) {
> > +		if (!strcmp(tst_device->fs_type, "btrfs")) {
> > +			/* use same logic in kernel legacy_parse_param function */
> > +			if (i * (strlen(val) + 2) + (strlen(val) + 1) + 2 > (size_t)pagesize) {
> > +				TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > +									EINVAL);
> > +				if (!TST_PASS)
> > +					return;
> > +			} else {
> > +				TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > +				if (TST_ERR)
> > +					return;
> 
> We need to close and reopen the FD inside run() otherwise the test fails
> on BTRFS with -i2 because we have already filled the buffer.
Thanks for your feedback, i have some quesiton on this comments:
The error will happen when buffer is full filled on btrfs(means buffer len > pagesize), this is normal 
and current logic verfiy this logic for btrfs.
Are you mean we need create another fd and continue do fsconfig on new fd once first fsconfig fails happen ? Correct 
me if i have misunderstanding.

> 
> > +			}
> > +		} else {
> > +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > +								EINVAL);
> > +			if (!TST_PASS)
> > +				return;
> > +		}
> > +	}
> 
> This loop can be rewritten so that there are less branches and
> indentation. This makes it easier to read.
> 
> 	for (size_t i = 0; i < 5000; i++) {
> 		/* use same logic in kernel legacy_parse_param function */
> 		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> 
> 		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
> 			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> 			if (TST_ERR)
> 				return;
> 		} else {
> 			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> 					    EINVAL);
> 			if (!TST_PASS)
> 				return;
> 		}
> 	}
> 
> 
> > -- 
> > 2.35.3
> 
> 
> -- 
> Thank you,
> Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
