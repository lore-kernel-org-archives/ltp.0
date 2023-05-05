Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54F8C77B7D
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 04:55:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC8D3CD84C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 06:55:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2EC3CB32D
 for <ltp@lists.linux.it>; Fri,  5 May 2023 06:55:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CBB1C1400FB4
 for <ltp@lists.linux.it>; Fri,  5 May 2023 06:55:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20A791F88E;
 Fri,  5 May 2023 04:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1683262536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXv/curpsa7B7pnkWt4C1gv2afS2XeJZhDT6LHjswoI=;
 b=WWW2APnVswEV0NJRQhR8YycCRiLMMEN/K9S0CWXE3dTO5d9mr48MDuAanrZ9yxb6l/0A5O
 1CWPIQr67zp6f2TlPNS4rUt7ehIBEwahfZ/5a25qzLmpdaeGQY634FlnR2fYehI59BEFF3
 UXxAftG07unWeOsKJW/KHZpPVCZO/Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1683262536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tXv/curpsa7B7pnkWt4C1gv2afS2XeJZhDT6LHjswoI=;
 b=/QLOFiS7+dbZzw6szmBoHd3sWogwIBRle31LRVr5O+MuyZT8GYv9IXERcaAl5x9DMFo0iw
 iBjjvAxPQGVwSUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95F9013488;
 Fri,  5 May 2023 04:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VUbXGkeMVGTdXQAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 05 May 2023 04:55:35 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 05 May 2023 10:25:33 +0530
Message-ID: <18916633.A95A5DKvIM@localhost>
Organization: SUSE
In-Reply-To: <20230502111813.GA3640896@pevik>
References: <20230427120800.27849-1-akumar@suse.de>
 <20230502111813.GA3640896@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] dup01.c: use TST_EXP_FD macro and add inode
 check
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

Hi Petr,

> > +	TST_EXP_FD(dup(fd), "dup(%d)", fd);
> 
> IMHO only this is enough:
> TST_EXP_FD(dup(fd));
> 
okay, please update when you merge, if everything else is fine.

Thank you,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
