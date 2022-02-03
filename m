Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF368C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 10:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28CE73C9A72
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 11:29:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C1E73C6FE5
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 11:28:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1616A200B73
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 11:28:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D33F1F399;
 Thu,  3 Feb 2022 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643884132;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yFeSNRuz2XJJ4oodb86Lmnb0Msc6YNNqxD5H4hwoHk0=;
 b=kZeN4xwPM3iHCVEL1OY8Qx9gIgY2DAdz5L2WS0bdoTzu7XMIfZxlvEnImf3zARD7WU36v2
 DfeWtMMt79oMiKlIVeIbFYkrXZGAjwq/CtRG+p5bYKc+AouL49oxj9OnlePb9ULcazvdHj
 C+vofPzJChQ8HAHsiti6SwXqEj+g2NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643884132;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yFeSNRuz2XJJ4oodb86Lmnb0Msc6YNNqxD5H4hwoHk0=;
 b=DMuHENd/rfixCENwgUTBtZ3dOm4mP6cnkkyG9ddk9oEDwh/PIPX9h/OO6IxxArgCYV2VBf
 nK1odgyntW1YhBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAEB71348D;
 Thu,  3 Feb 2022 10:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vX+tMWOu+2G6WAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 10:28:51 +0000
Date: Thu, 3 Feb 2022 11:28:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YfuuYR0j4+81BABq@pevik>
References: <20220201142230.20243-1-andrea.cervesato@suse.de>
 <Yfo5P7ZZI33xz+6K@pevik> <8735l0y07y.fsf@suse.de>
 <1fbbeba9-aa4e-81b3-0b56-c92b9b7d8356@suse.com>
 <692e3994-ef2b-3a9a-c4e2-118304cad3a0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <692e3994-ef2b-3a9a-c4e2-118304cad3a0@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Extract libclone from
 testcases/kernel/containers
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

> Hi,

> an update about the last comments: the unshared clone is only used by
> mountns tests suite, so we can add that to the common utilities and get back
> to tst_clone for the other testing suites. I'm going to do that.

Thanks! Thus setting this as rejected.

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
