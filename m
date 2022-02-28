Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BBFC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 06:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55E093CA287
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 07:43:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B41D53C24D6
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 07:43:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0EEDA600721
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 07:42:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE411F3A5;
 Mon, 28 Feb 2022 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646030579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=168U1/wdfJSWQB5hBeTTpcxAsbhQkKYU0JSsiDEKvyU=;
 b=VS3eHzuQ2tjniSlvM4sHdBA/CFyb7prMDL7u/7XCFMPhyhmVaGk0bR7VymVTtLpfbUitFS
 mlPo2NjkxHGAeAn7HAEV2b+khHwFD10Ek/RBK2kvh/EISLoNbTnAXZkjA7t3CdKiGrO7Ja
 /6rfOwlnJ99XG6WlDNUiunZl9bzc3Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646030579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=168U1/wdfJSWQB5hBeTTpcxAsbhQkKYU0JSsiDEKvyU=;
 b=QQwZN+GBdhnLgVa+pH9Yg68bCUMUZSYjobTosCg6+cTG0bJ6xnigxnd5cU2INhZLuZK39x
 MWqYPvGwbfa6axDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDB9412FC5;
 Mon, 28 Feb 2022 06:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4m6UNPJuHGI5FQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 28 Feb 2022 06:42:58 +0000
Date: Mon, 28 Feb 2022 07:42:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <Yhxu8elhUJakYJHH@pevik>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] kernel/fs/fs-notify: fsnotify stress tests
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Murphy,

> Hi all,

> How to run another LTP test case fs_racer.sh or read_all in a new C
> programme testcase?
Both read_all and fs_racer.sh are in runtest/fs.

You can run them manually with corrctly set PATH [1] (best is to fully install
LTP and add $LTPROOT/testcases/bin:$LTPROOT/bin (where LTPROOT is prefix for
installed LTP, i.e. /opt/ltp [2]).

Or you just run whole runtest/fs with the old runltp.

Note, we're working hard on new runner, but not finished yet.

Kind regards,
Petr

> I tried but hit some issues with the PATH configuration.

> Is this recommended by you guys?

> Thanks,
> Murphy

[1] https://github.com/linux-test-project/ltp#shortcut-to-running-a-single-test
[2] https://github.com/linux-test-project/ltp/wiki/User-Guidelines

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
