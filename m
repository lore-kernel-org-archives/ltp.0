Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0F9EED615
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 15:41:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE7D3CE69F
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 17:41:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1356C3CB576
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 17:41:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6518C600AA8
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 17:41:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39DC71FD73;
 Fri, 15 Sep 2023 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694792498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtT+Il6mBazxj1DODPdwa7M3rlzSg0FwXvjHSVPm2t4=;
 b=iqoTyfMI9jajYH4rL68DVhl+ma9LbPXoEhlhhfYH45tVJESy9GEyzrCZpw+SNNO93dAnGQ
 hrzueAP62teGgjgZsqYK5PKTftI6kYReQyfvsTy//i/iyE/0xkLE4ZjUJu35R5yqZX/YBD
 uzvs3PtYrOLbA/reUf8C5NeuHTEhowM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694792498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtT+Il6mBazxj1DODPdwa7M3rlzSg0FwXvjHSVPm2t4=;
 b=v7mvw3C0zBYVxanpXdlwcjqxG18oiD4Rg2aufZJfGAisBPw79Q4za9XIsOhCz4RleeKtt5
 F7UnnnKC3EFv20AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7062D1358A;
 Fri, 15 Sep 2023 15:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LqWrEzF7BGVlIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 15:41:37 +0000
Date: Fri, 15 Sep 2023 17:41:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20230915154135.GA11318@pevik>
References: <20230915144156.22380-1-andrea.cervesato@suse.de>
 <20230915144156.22380-3-andrea.cervesato@suse.de>
 <20230915152910.GB73280@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915152910.GB73280@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add Linux Test eXecutor inside tools
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

Hi Andrea,

> Hi Andrea,

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

This is breaking build:

2023-09-15T13:47:12.1128844Z make -C ltx
2023-09-15T13:47:12.1148029Z make[3]: *** No targets specified and no makefile found.  Stop.
2023-09-15T13:47:12.1153175Z make[2]: *** [/__w/ltp/ltp/tools/ltx/Makefile:13: all] Error 2
2023-09-15T13:47:12.1159251Z make[1]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
2023-09-15T13:47:12.1163512Z make[1]: Leaving directory '/__w/ltp/ltp/tools'
2023-09-15T13:47:12.1169815Z make: *** [Makefile:94: tools-all] Error 2

Reproduce with simple:
$ cd tools && make -C ltx

The problem is because there is no tools/ltx/Makefile

Why are the sources in tools/ltx/ltx-src instead of tools/ltx anyway?
I guess you used sparse approach, which is not necessary here.
I'm ok with that if it makes things simpler, but please include the required
Makefile.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
