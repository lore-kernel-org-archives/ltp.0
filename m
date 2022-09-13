Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8C7C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFA543CAAF3
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:13:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FA933C01CC
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:13:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F6491A00E20
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:13:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 638F55BFB7;
 Tue, 13 Sep 2022 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663056817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpfuKYfc0pKzwqYyzzuhfLItPOrCjePoy3LDZI+TYDk=;
 b=qlvCmqZXz5xmkAJ/VDNYudKjRQBQZhXhVIL1J/BjrXK32MgpZ8ogTkJfVeYQ8AEcmEb7gO
 d4fWVZnBgpFR5fJeel6IcIyqVtf6ByQ6fpxbSNdNDxuTQLXmIs2jCmMxnNYtnQiTk64FgA
 QJpVAlhacdbCc0jblFMsFbtf9T0ckrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663056817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpfuKYfc0pKzwqYyzzuhfLItPOrCjePoy3LDZI+TYDk=;
 b=DQtNXG4ENA/VZeHTKcH8Wg9vh3wNoCDKTq3NRoj+SmLX1V7nTyZHR9tQdei3H2F55OoDmc
 K+2hxVmAppLEPOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5106013AB5;
 Tue, 13 Sep 2022 08:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 68WfErE7IGPAEgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 08:13:37 +0000
Date: Tue, 13 Sep 2022 10:15:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YyA8JQXmeTBQVbgY@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-8-pvorel@suse.cz> <Yx9QFWuRMjDUAafp@yuki>
 <Yx+Q0+fUokI7jlhT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx+Q0+fUokI7jlhT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Also maybe it would be a better as a function so that the code does not
> > run unconditionally on each tst_mount() call?
> Do you mean e.g. tst_is_fuse() and df01.sh would call it?

Yes that looks slightly cleaner than adding another variable.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
