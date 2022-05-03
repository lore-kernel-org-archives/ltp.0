Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86D0C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 21:21:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B3B03CA889
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 23:21:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9509D3C9378
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:21:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FB0D6001A9
 for <ltp@lists.linux.it>; Tue,  3 May 2022 23:21:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B8F2210E7;
 Tue,  3 May 2022 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651612890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeZMXQaRL71Mh2uCvwifjZ/sAVSPUX/h1Plfg9aUZM4=;
 b=kH1nxivlfDvjJImM9/n0+q5LpBmgD8tzm4ZtZ7a+0v07BxqsGXJmmSja9Kvd2qdTZneGm5
 ++yX0XHfkiHfzsN9MgvjltzXyWNzBbf6ujPfqsJIt1EIz4Qr0pgI0M3DEC5l1mbMAB0IQm
 ZeYjB63dR+7U+a8gX0cwR5D1BQdRzWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651612890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeZMXQaRL71Mh2uCvwifjZ/sAVSPUX/h1Plfg9aUZM4=;
 b=+lu4Pl94JuBHKdxX4M0GpnJ9uil8LNsCbuuJ9QgInvzVbIr5VW9mIcqwre6q1jqPlsKTyD
 kB+G3Dh03g084ZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A644913AA3;
 Tue,  3 May 2022 21:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PVWRJNmccWKHCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 May 2022 21:21:29 +0000
Date: Tue, 3 May 2022 23:21:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Message-ID: <YnGc14Ef2S0EEd4g@pevik>
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
 <16EBB49075039E76.23911@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16EBB49075039E76.23911@lists.yoctoproject.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> ...
> >  doc/user-guide.txt                            |   4 +
> >  include/tst_test.h                            |  27 ++++
> >  lib/newlib_tests/.gitignore                   |   5 +-
> >  lib/newlib_tests/test10.c                     |  22 ---
> >  lib/newlib_tests/test12.c                     |  21 ---
> FYI test12 is run in CI, need to be removed from runtest.sh.

>  .../{test18.c => test_runtime01.c}            |  10 +-
And obviously rename test18 to test_runtime01.
>  lib/newlib_tests/test_runtime02.c             |  31 ++++
And add test_runtime02, which TPASS.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
