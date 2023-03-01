Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E31EC64ED6
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 14:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 992C23CDD91
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 15:12:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF5213CB9D7
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 15:12:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A83910011C0
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 15:12:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC1721A90;
 Wed,  1 Mar 2023 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677679947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0kjYgMkxaVY2ivmtbnse9T9iifr+uag1beJnz/6k6Q=;
 b=ARM9DpgblWbdhloTi0ClKkIntgjj9FR9cPiJQQfeUELjTF1rBTtVyRHjP7tQoT8pCK/+AP
 gBizyQQ6cfxDHWbKzCyO2OkV9mPDesi57uMnYmnLiowCSaq13g8Aj2bhT5x6+1jQElRIR3
 Q01gWqyJqqX+uYsRrfb7BQ/n19vtIFk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF2113A63;
 Wed,  1 Mar 2023 14:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aXzCBUpd/2OQMAAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 01 Mar 2023 14:12:26 +0000
Date: Wed, 1 Mar 2023 09:12:22 -0500
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230301141222.GA10677@localhost>
References: <20230228032254.13992-1-wegao@suse.com>
 <20230228032745.16595-1-wegao@suse.com>
 <12a64a2b-a739-a9fb-c584-f0967fc126de@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12a64a2b-a739-a9fb-c584-f0967fc126de@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] fsconfig03: New test CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 01, 2023 at 02:46:16PM +0100, Martin Doucha wrote:
> Hi,
> 
> On 28. 02. 23 4:27, Wei Gao via ltp wrote:
> > +	for (size_t i = 0; i < 5000; i++) {
> > +		/* use same logic in kernel legacy_parse_param function */
> > +		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> > +
> > +		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> > +			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> > +		else
> > +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> > +					    EINVAL);
> > +	}
> 
> This special case for Btrfs is wrong. Btrfs is just the last major
> filesystem which does not implement its own fsconfig() handlers in the
> latest kernel release. But on older kernels, the same applies to other
> filesystems as well.
> 
For old kernel btrfs ONLY can update legacy_parse_param() so above logic will pass.
> Any other filesystem that still uses legacy_parse_param() and has the CVE
> fix applied will fail this test with exactly 117 error messages on x86.
> That's how many iterations it takes to fill 4KB buffer with the test string.
I expect most of other scenario will use new parse_param function instead of legacy_parse_param.
The security fix should use commit which change parse function instead of update old legacy_parse_param(). 


> 
> -- 
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
