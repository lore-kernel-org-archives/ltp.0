Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE12FC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 17:36:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B28D3C9B54
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:36:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DD503C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:36:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E5D311400F8F
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:36:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E96E9210E7;
 Tue,  8 Feb 2022 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644341801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7eZ1n526XqwXHxKHI2VJkQZX7iQAQxoqmx9VUPXeas=;
 b=1as72GaSGybVKWQZgkabayGvi1JTQ39nMnr4OXIHGNU5hpfB4MDVPrX1CGPJ0wORw+syWk
 0P42NUO41/73o1iA3i/nc5fvVMft5CiFilZ9qAra3hCsoF9pDYK+Po5U79YowaB9Y+G2cE
 Px4vjygxMClEcLPWOWLDrEO7tFPdUGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644341801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7eZ1n526XqwXHxKHI2VJkQZX7iQAQxoqmx9VUPXeas=;
 b=uqVM4dyM+2MxNLLlngYrNK+KmgX2VXouUzt6nvWvD6Ar8jaAt5yXRMHU8oFzhfGF0LIFR1
 ntVlu+X0hsCl4gAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F121338F;
 Tue,  8 Feb 2022 17:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VwvVLSmqAmKnaAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 17:36:41 +0000
Date: Tue, 8 Feb 2022 18:36:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgKqKM32COAnmxfo@pevik>
References: <20220126181210.24897-1-pvorel@suse.cz>
 <20220126181210.24897-4-pvorel@suse.cz> <YgJ6dOD7tC+7UQL2@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgJ6dOD7tC+7UQL2@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +++ b/doc/shell-test-api.txt
...
> > +| 'TST_FS_TYPE'            | Overwrite the default filesystem to be used.
>                                   ^
>                                 Override?

+1, thanks!

> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
...
> > +	if [ "$TST_FORMAT_DEVICE" = 1 ]; then
> > +		tst_mkfs "$TST_FS_TYPE" "$TST_DEVICE" "$TST_DEV_FS_OPTS" "$TST_DEV_EXTRA_OPTS"

> This would work with the proposed change to tst_mkfs if we swapped the
> $TST_DEV_FS_OPTS with $TST_DEVICE.

Do you mean to swap here? i.e.:
tst_mkfs "$TST_FS_TYPE" "$TST_DEV_FS_OPTS" "$TST_DEVICE" "$TST_DEV_EXTRA_OPTS"

But in tst_mkfs it has always been the second parameter:
local device=${2:-$TST_DEVICE}

What am I missing?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
