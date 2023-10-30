Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E6AC4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 11:08:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7AB3CEA9F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 12:08:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBBEA3C6D29
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:08:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 12138600AFD
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 12:08:22 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A64AF21CEC
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 11:08:21 +0000 (UTC)
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2DB9F2CB30;
 Mon, 30 Oct 2023 11:08:21 +0000 (UTC)
References: <20231027104951.32464-1-rpalethorpe@suse.com>
 <20231027110116.GA649751@pevik> <ZTvH_DptjIrZJx-A@yuki>
 <20231027174512.GA710840@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Oct 2023 10:39:17 +0000
Organization: Linux Private Site
In-reply-to: <20231027174512.GA710840@pevik>
Message-ID: <878r7ktljv.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-0.00)[32.36%]
X-Rspamd-Queue-Id: A64AF21CEC
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: Make mount failure TCONF
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

Petr Vorel <pvorel@suse.cz> writes:

>> Hi!
>> > > It appears that if the subsystem is available under V2 then mounting
>> > > the V1 can fail. Probably when the V2 has processes assigned to a
>> > > group it controls.
>
>> > Sounds likely, but it would be good to check this in the kernel code or with
>> > kernel cgroup developers.
>
>> I'm pretty sure that controller can be used either in v1, or in v2 but
>> not from both at the same time by choice. Some of the changes between v1
>> and v2 are incompatible so this couldn't work either way.
>
>> I think that once the controller name is written to
>> /sys/fs/cgroup/unified/cgroup.subtree_controll mounting it to v1 should
>> fail, so maybe we should just try to grep the fail instead and exit the
>> test with TCONF if we found the controller bound to v2 already.
>
> Sounds like a good idea.

I tried a quick experiment. Adding it to cgroup.subtree_control is not
enough. However adding a process to a cgroup where the controller is
enabled causes mount to fail with EBUSY. There could be other ways. I
would assume that sort of thing can change as well between kernel versions.

If we want to avoid attempting the mount then maybe even just scanning
cgroup.controllers is best. This is practically what we do in tst_cgroup
lib. However there is also just the option of not running the test on
systems where only V2 will be used. So this is just a minimal fix to
keep the test limping along until they are obsolete or rewritten
entirely.

Another option would be to split the tests into V1 only and everything
else. That would work for us if distros are practically stopping support for
V1 on newer versions. Then there is no need to make these tests detect
V2, we just don't run them on those systems.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
