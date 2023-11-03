Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CB3C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 12:20:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D01363CC802
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 13:20:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1A8A3CA616
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:20:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3CE33209A06
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 13:20:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD6541FD69;
 Fri,  3 Nov 2023 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699014041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1NfkjAWPhSNB5Agve/xCyfzBUdR0tDeCI1RDcILaig=;
 b=cxIVsxh+qT1DSWMLLvmdFuCfweIZo3t5rQVNdTVEyLYmOioudV1wswMwH1cYHo+FgUkSLw
 1/n2ACofyS1tP/EN9SJA018+GuMiO9K5svYVQK/WLRHQRUhnCfjFFdLujaATLWPpH8HETZ
 ooeM02tvM615TxaWEVbb/hdLLyx5jec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699014041;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O1NfkjAWPhSNB5Agve/xCyfzBUdR0tDeCI1RDcILaig=;
 b=nIabtHvlcKb02/IO31RW9liq1vNMknQktHj1jo2+BfcqdINBUD5T2MfG767SVdvuXuwNO7
 1ybvn21WlO21i3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9806813907;
 Fri,  3 Nov 2023 12:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TJfPI5nlRGXRUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Nov 2023 12:20:41 +0000
Date: Fri, 3 Nov 2023 13:21:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZUTluqkrUOBLHw7G@yuki>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz> <ZUJ8K9nna0Poa9FS@yuki>
 <20231103121201.GA1005170@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231103121201.GA1005170@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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
> Yes, but see safe_cmd() in lib/tst_safe_macros.c. tst_cmd() is called with 
> TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING, thus this is covered.

TCONF_ON_MISSING means to TCONF when the command is missing, i.e. if
modprobe is not installed on the system. When module is missing modprobe
will return 1 so I suppose we have to handle the return value from the
TST_CMD() or do I missing something?

> > modprobe -r please, rmmod has been deprecated for ages.
> 
> Ah, here goes the reason. Should it be replaced also in tst_module_unload_()?

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
