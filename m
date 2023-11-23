Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3093C61DF7
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 15:25:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39E3A3D0357
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 16:25:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1A9C3CEFD3
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:25:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D1F9601641
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:25:10 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 58A9221A3C
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700753109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7+orTKEEKfxBYh7rYc1Iwup8M5si8eQCRKDTy1FSYw=;
 b=z6KhbcE9bGqIh+3F7eeEBXlnJvkmDi52rmKy1gT9z18YCUWVgodx6sMP1SE0zqh4BqqYPq
 uajBke9xw8MGCrV3qsiGH28rSJJIIbaqhuLz/WRUMKaTfund1CiuEEDlK4CiEw6nWnQF1i
 cHYkXG6Wijb3l96x8RODOajagtAlm6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700753109;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7+orTKEEKfxBYh7rYc1Iwup8M5si8eQCRKDTy1FSYw=;
 b=EwT6UloSzkandcuZvUxivGO/noCckudKUkt/7YHztAmFkXoOC3XNzUbPOY2Qz0wr0B7cWr
 +UfaUI3nubQyTQCw==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DEEB22CFA1;
 Thu, 23 Nov 2023 10:53:20 +0000 (UTC)
References: <20230921090658.11224-1-mkittler@suse.de>
 <5973304.lOV4Wx5bFT@linux-9lzf> <ZQ2GltNFaQIrszXl@wegao>
 <4513172.LvFx2qVVIh@linux-9lzf>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Marius Kittler <mkittler@suse.de>
Date: Thu, 23 Nov 2023 10:46:21 +0000
Organization: Linux Private Site
In-reply-to: <4513172.LvFx2qVVIh@linux-9lzf>
Message-ID: <87cyw091wf.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [14.29 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(1.20)[suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 58A9221A3C
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port getxattr03.c to new test API
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

Marius Kittler <mkittler@suse.de> writes:

> Am Freitag, 22. September 2023, 14:20:38 CEST schrieb Wei Gao:
>> On Fri, Sep 22, 2023 at 11:23:47AM +0200, Marius Kittler wrote:
>> > Am Freitag, 22. September 2023, 02:00:32 CEST schrieb Wei Gao:
>> > > > #ifdef HAVE_SYS_XATTR_H
>> > > 
>> > > Normally i saw this kind of ifdef in include/lapi/xattr.h
>> > > I suppose we need create include/lapi/xattr.h?
>> > 
>> > No, we don't need that header here. This macro is actually defined in
>> > `config.h` which also makes sense as it is generated at configuration
>> > time. Note that also all builds (including musl) are passing with this
>> > change, see
>> > https://github.com/Martchus/ltp/actions/runs/6259530698.
>> 
>> Maybe some misunderstanding, i mean put ifdef logic into
>> include/lapi/xattr.h instead of define HAVE_SYS_XATTR_H, since i saw ifdef
>> logic for judge exist of xxx.h normally handled in include/lapi/xxx.h.
>
> Ah, so I'd add `include/lapi/xattr.h` and to the `#ifdef HAVE_SYS_XATTR_H` 
> there. But is that really the way to go in that situation? I've just checked a 
> few header files in the `include/lapi` directory and there's no precedence for 
> the case when a header is not supported at all and the corresponding test 
> should thus be disabled. These headers seem more for abstracting differences 
> between different (versions) of C libraries but not for handling the case when 
> a test should be skipped completely.
>
> Note that the way I wrote this test was suggested to me in "Re: [LTP] [PATCH 
> v1] Port `getxattr01.c` to new test API".

lib/safe_macros.c included sys/xattr.h without any guards in 2016.

I have removed the ifdefs and an inline comment and pushed!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
