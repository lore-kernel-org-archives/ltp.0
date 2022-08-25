Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98438C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA2BC3CA478
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:31:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666043C0367
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:31:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BDC9A200075
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 16:31:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 487741FAE7
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661437875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmlLv4zcYV/CqPHtGeFLKAF7Gbitowt4uiGVZhvrewY=;
 b=bhnLjQE/nWT1HTRaig+RE+oJNDSHoltW/pVj9z2hWLjzK/XeBn86xLYfBypdcv7fx25196
 WHANzhgUY8KFDFWeRFjSoPXpZCF+sPB/wuKaszKsWdWzwrbzaUOsSB4HG70bQUxEg46D0K
 DYk5rMC0GWcxuZSijZMFs/wUZjS9kDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661437875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmlLv4zcYV/CqPHtGeFLKAF7Gbitowt4uiGVZhvrewY=;
 b=JaTbPfOukM9BYamyogpdbOQ3IqPD4fjEtvylEuqBFfWlXpWpd98ZVp0+YN7/qAAC9C5NG6
 BoLnlCYa/vDtiUAw==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F346D2C141;
 Thu, 25 Aug 2022 14:31:14 +0000 (UTC)
References: <20220818171724.9182-1-pvorel@suse.cz> <Yv9Jafy8AzSCH437@yuki>
 <Yv9lxML3bw61wI1o@pevik> <Yv9tWKCKQUcct66H@yuki> <Yv99VtoOhs2m3lSP@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Aug 2022 15:22:03 +0100
In-reply-to: <Yv99VtoOhs2m3lSP@pevik>
Message-ID: <87a67s2y4t.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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
>> > I.e. 1 or 2 kernel.unprivileged_bpf_disabled results bpf() returning EPERM for
>> > *all* users including root. 0 allows running again for all users, but we need
>> > root to set it 0 via .save_restore:
>
>> > tst_sys_conf.c:106: TBROK: Failed to open FILE
>> > '/proc/sys/kernel/unprivileged_bpf_disabled' for writing: EACCES
>> > (13)
>
>> > Maybe we could change tst_sys_conf_save() not to write the value if value can be
>> > read and is the same (and not run tst_sys_conf_restore() if value was the same).
>
>> That would be a good idea either way.
>
>> The unprivileged_bpf_disabled is more complicated that this though. It's
>> a three state as:
>
>> 0 - enabled
>> 1 - disabled and can't be enabled
>> 2 - disabled and can be enabled
> Good point, I didn't realize 1 means "no" also for root :).

IMO I've always thought that it's not worth tyring to change this value
because of this and also the hopeless nature of unprivileged eBPF.

OTOH if it is set to 1 then we can argue that known bugs should be fixed
because setting it to 1 shows intent to use it.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
