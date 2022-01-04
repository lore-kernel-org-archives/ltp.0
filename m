Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B573C433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 11:01:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A01E3C90A9
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:01:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01FE53C1D3C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:01:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 353441A0099C
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:01:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CA811F397;
 Tue,  4 Jan 2022 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641294066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fw8ID2NpvGAkg+5ursUna7aFqyDMifxJjSBIF0OcWRw=;
 b=N40HeB2v8jMP0/XCLg/T0MspNMff7KTDSx9nIOPoPDNeO2GDx4Al+s/77kd4TO9qzmFDNV
 CWV1WwQMozVL+CqTk8cFS6KFeTEWXICa/d49vRSsXRkl9Vgeh4UwrtcLShGEDafGL0nx/+
 7NyD7fdfN81rALQpLSrH5sZJjhwm5yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641294066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fw8ID2NpvGAkg+5ursUna7aFqyDMifxJjSBIF0OcWRw=;
 b=2tySdFg4nNb683Jf/vJ6EwXcZF4fcgc5c8ZrvOZGBRR3w/uuVLsLu4nkD0ekdSNZL6Owtu
 ZuwUomjxXNI4fSBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DC4313ADF;
 Tue,  4 Jan 2022 11:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rzPxDvIo1GEELgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 04 Jan 2022 11:01:06 +0000
Date: Tue, 4 Jan 2022 12:02:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YdQpS0WPRvz4vZup@yuki>
References: <20220103151332.1989-1-pvorel@suse.cz>
 <20220103151332.1989-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220103151332.1989-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ustat0{1,
 2}: Mark failure on Btrfs with known-fail tag
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

Hi!
> --- a/testcases/kernel/syscalls/ustat/ustat01.c
> +++ b/testcases/kernel/syscalls/ustat/ustat01.c
> @@ -44,6 +44,10 @@ static void setup(void)
>  static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
> +	.tags = (const struct tst_tag[]) {
> +		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs"},
                                   ^
				   Maybe we should just remove the
				   "known to fail" from these messages.

Since the code in the library will print:

---
You _MAY_ be hit by known kernel failures:

ustat() is known to fail with EINVAL on Btrfs
---

so the 'known to fail' part is redundant here.

What about:

---
You _MAY_ be hit by known kernel failures:

ustat() fails with EINVAL on Btrfs
---

Other than this I think that this is a good way how to put these kind of
hints into the testcases.


Also I do wonder if there is a good URL that would contain more verbose
description of the problem but I guess there isn't. Well maybe this one:

https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg95697.html

Not sure how to encode that, maybe just add it to the test top level
comment?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
