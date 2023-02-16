Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC732C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 12:18:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F17D93CC0D6
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 13:18:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14CD23CB167
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 13:18:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 626211A0024C
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 13:18:14 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6729F22585;
 Thu, 16 Feb 2023 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676549893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0n6G0R9BUHUgH/GbHMe1RTy+1KLtopsCtrN4A7ihuk=;
 b=xJlvTEOezDNT5b0b/ZU09GFqnS2/kkQOvomf9Namb3laMgiDxzTKIUIZ0F2cTmDZjsw7aJ
 +g4G0s50ZqzqCYXipweP5SFAohuheNTUZqQxlLnlXNWGYNNvsLzM/9qAxHkLY1blB3xY/Y
 8jHNYRSzL4PBoxuiAiP4+9qq+irycnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676549893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0n6G0R9BUHUgH/GbHMe1RTy+1KLtopsCtrN4A7ihuk=;
 b=nQPt8WZThOkD6ZuMYZtMZxbtDbdZYeNRK4uxnxXx4rKdicu1EGD0lnvt8ISSBr6BMJHTtK
 XCsQ3kPOAaab9qBQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 220242C141;
 Thu, 16 Feb 2023 12:18:13 +0000 (UTC)
References: <20230209131902.12260-1-wegao@suse.com>
 <20230213010924.12352-1-wegao@suse.com> <87a61go5ro.fsf@suse.de>
 <20230216094235.GA29664@localhost>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Thu, 16 Feb 2023 12:09:20 +0000
Organization: Linux Private Site
In-reply-to: <20230216094235.GA29664@localhost>
Message-ID: <87h6vlregu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao <wegao@suse.com> writes:

> On Tue, Feb 14, 2023 at 11:05:24AM +0000, Richard Palethorpe wrote:
>> Hello,
>> 
>> > +static void run(void)
>> > +{
>> > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
>> > +	long pagesize;
>> > +
>> > +	pagesize = sysconf(_SC_PAGESIZE);
>> > +	if (pagesize == -1)
>> > +		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
>> > +
>> > +	for (size_t i = 0; i < 5000; i++) {
>> > +		if (!strcmp(tst_device->fs_type, "btrfs")) {
>> > +			/* use same logic in kernel legacy_parse_param function */
>> > +			if (i * (strlen(val) + 2) + (strlen(val) + 1) + 2 > (size_t)pagesize) {
>> > +				TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
>> > +									EINVAL);
>> > +				if (!TST_PASS)
>> > +					return;
>> > +			} else {
>> > +				TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
>> > +				if (TST_ERR)
>> > +					return;
>> 
>> We need to close and reopen the FD inside run() otherwise the test fails
>> on BTRFS with -i2 because we have already filled the buffer.
> Thanks for your feedback, i have some quesiton on this comments:
> The error will happen when buffer is full filled on btrfs(means buffer len > pagesize), this is normal 
> and current logic verfiy this logic for btrfs.

I'm not sure you understand what "-i2" means. The run() function can be
called multiple times in a loop. If you do ./fsconfig03 -i2 then you
will see the test fails.

That's because it executes run() twice and the second time
TST_EXP_PASS_SILENT fails.

> Are you mean we need create another fd and continue do fsconfig on new fd once first fsconfig fails happen ? Correct 
> me if i have misunderstanding.

This would also work.

>
>> 
>> > +			}
>> > +		} else {
>> > +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
>> > +								EINVAL);
>> > +			if (!TST_PASS)
>> > +				return;
>> > +		}
>> > +	}
>> 
>> This loop can be rewritten so that there are less branches and
>> indentation. This makes it easier to read.
>> 
>> 	for (size_t i = 0; i < 5000; i++) {
>> 		/* use same logic in kernel legacy_parse_param function */
>> 		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
>> 
>> 		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
>> 			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
>> 			if (TST_ERR)
>> 				return;
>> 		} else {
>> 			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
>> 					    EINVAL);
>> 			if (!TST_PASS)
>> 				return;
>> 		}
>> 	}
>> 
>> 
>> > -- 
>> > 2.35.3
>> 
>> 
>> -- 
>> Thank you,
>> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
