Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E452C00140
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 14:44:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807323C9ACC
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 16:44:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 807C23C9880
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 16:44:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 15DCA1000DE4
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 16:44:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74F7537F4A;
 Tue, 26 Jul 2022 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658846647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HdoY5MM361CGMXXGIVnORDdBhiIaCkF7vPt+xvw1sg=;
 b=RscwBJp4Y8ezuMmMWze2KnYiSdIgzgINzuwLn2x4dyQDky9fyz6vNj5ytnOQeXEGINhsYu
 JHnIfl7TDWsx6Zzzwi6bDMDPP3nKBACNH8hlM4KLmBap+YJ07/temRZMTUY3SACmNWTcOM
 jO7kcc8QZBikADo/B3W3PMGGiQgnycI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658846647;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HdoY5MM361CGMXXGIVnORDdBhiIaCkF7vPt+xvw1sg=;
 b=JCuuv5+wAe24O1nv3JUrbr+wugp+TBB9g1lvOSSrB8bGCaCf29P8r/YzillIcpnXGikjQ2
 z6HoP2xG4/eYeuDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3541B13322;
 Tue, 26 Jul 2022 14:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BXQ3C7f932KmRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 14:44:07 +0000
Date: Tue, 26 Jul 2022 16:44:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <Yt/9tWAx9bujvngr@pevik>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <a84f4b5177545cb10912c325f23175662a921396.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a84f4b5177545cb10912c325f23175662a921396.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/18] tst_test_macros: Add TST_TO_STR and
 TST_STR macro
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

Hi all,

>  include/tst_test_macros.h | 3 +++
...
> +#define TST_STR(s) #s
> +#define TST_TO_STR(s) TST_STR(s)

NOTE: I changed before merging TST_STR to TST_TO_STR_ as Cyril requested [1].
I'm sorry I forget to update git commit message.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YnPSgLxK2jUGndIv@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
