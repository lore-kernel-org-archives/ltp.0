Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CA8C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 08:47:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBF7F3C8809
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 09:47:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83263C3040
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 09:47:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1FBE31400996
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 09:47:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 50A88210F0
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647938848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3wAqJKnATWwQzt2U8YNEVj/opoMWgiTSPvAxlbxYFg=;
 b=MC4gYWuAuWfH5H7VcLBdtb+MSYUFRbvdK3qyZbJejV8xB12tGf1pJUMDhT1k7x+D4CaREi
 Em8He8I17dK+PVQOGr+ZXibPOT+6wQNdZEaF+eYokc15zp59Ku2AEQKH+dVKJmIyj/RDdP
 WHbS7C5cERMoL3DpOFD2t8O+zI4ylno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647938848;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3wAqJKnATWwQzt2U8YNEVj/opoMWgiTSPvAxlbxYFg=;
 b=5QoID9/fPWQfvkNwuDWB5xa4yKJ9FlDtR/8pJj6lfHRmBggWmMpVgpLiVfXAEm5gdgQ9S1
 HA3MeFSnJC8BHvDA==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 16167A3B93;
 Tue, 22 Mar 2022 08:47:28 +0000 (UTC)
References: <20220311095101.10112-1-chrubis@suse.cz>
 <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz> <YisfIWsrgxVt8xc2@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2022 08:13:26 +0000
In-reply-to: <YisfIWsrgxVt8xc2@yuki>
Message-ID: <875yo6cr1f.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty/pty07: Restore active console after the
 testrun
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> >  static void cleanup(void)
>> >  {
>> > -	tst_fzsync_pair_cleanup(&fzp);
>> > -	if (fd >= 0)
>> > +	if (fd >= 0) {
>> > +		tst_res(TINFO, "Restoring active console");
>> > +		SAFE_IOCTL(fd, VT_ACTIVATE, vt_active);
>> >  		SAFE_CLOSE(fd);
>> > +	}
>> > +
>> > +	tst_fzsync_pair_cleanup(&fzp);
>> 
>> If you move the fzsync cleanup to the end of cleanup(), you can end up
>> with the open_close() thread racing against fd cleanup.
>
> Ah, right, looking closely at the fzsync, the thread B may be racing
> against the restoration in the case that something caused premature exit
> in the thread A.
>
> Will move the call back to the start of the cleanup().
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

Why are we using /dev/tty8 instead of allocating a pty with /dev/ptmx?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
