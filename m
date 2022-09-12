Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDF0ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 10:13:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14EED3CAABA
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 12:13:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DB013CAAA3
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:12:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A6C41000640
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:12:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5327A22689;
 Mon, 12 Sep 2022 10:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662977571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yFQC4pwjLkgqCrMF5C96shcH7GVOy/ZoWCcoClz55E=;
 b=v5tjIF9bHF0mYQzts9a+CxNs11g1pPM1+WIknCvm3Cfp7ZqQLjOaYwOKwaDL+pAjgVkuJ+
 05sIIWGhRcwZX/wB+7YzHJhTQ64Z3YxedtnL85/rZxKVB4/P1bkvvL/ki80MeCXxFI1J2z
 LA91Ef4XgnBLEQ88+Di1H+Ufi8FvoGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662977571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yFQC4pwjLkgqCrMF5C96shcH7GVOy/ZoWCcoClz55E=;
 b=9O8x+YquD6DKRSFgoBHbTHZXJc+Kz+xuL9fpSKVQrq9iSw6GDR9buKMHVUidGuj/dlZpz+
 4W4vN7WRBAXBm9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A297B139C8;
 Mon, 12 Sep 2022 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KvVMJiIGH2MuWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 10:12:50 +0000
Date: Mon, 12 Sep 2022 12:12:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx8GIUos8bZNja1D@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-3-pvorel@suse.cz> <Yx8EDrF0P9fhbC3O@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx8EDrF0P9fhbC3O@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 02/10] shell API/tests: Require root for
 format/mount tests
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Although the warning is quite obvious:
> > tst_device.c:101: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
> > tst_device.c:140: TINFO: No free devices found
> > TBROK: Failed to acquire device

> > It's safer to expect root to get valid result.

> Another option would actually be to make the TST_NEED_DEVICE flag imply
> TST_NEEDS_ROOT flag, but I do not think that we have that for the C
> library either.
No, it does not imply in C API either. Yes, that would make sense for both API.
But I'd keep it as it is now and I'll do this change after the release,
Because I have other small fixes on API I'd like to post before the release.

BTW I always wondered why it was not done from the start, I thought there is a
reason for that (i.e. some special user with approved permissions).

> Either way this is fine as well:

> Reviwed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
