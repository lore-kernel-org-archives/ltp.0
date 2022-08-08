Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0DEC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 767B13C94FD
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:53:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C5C83C712D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:53:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF7CF600067
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:53:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D25DD37ABD;
 Mon,  8 Aug 2022 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659963191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zc5JHK8rM6pkNuDJ0jZGxu5P0EhREFoXGDEdobhJnTQ=;
 b=ZijfMRaxpBN2+/slY1+gGA7clJOopWO38PsFuhdvx/atggfKhKsWoTfm5uCnL0MEr1Ie89
 hFkiz9cTxJ2g8RR/XRRPcoW2GNDrplZ8OMfIxpy2896LnLY3kW6iD179aT7ZXi50PBfUM5
 Wb9eahYAOF4KazXNb9lzqR3/GElLHFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659963191;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zc5JHK8rM6pkNuDJ0jZGxu5P0EhREFoXGDEdobhJnTQ=;
 b=5wEu9vLXdqGf9iLvntm6B45YkxgOXF4N+8Gziby37Gdf9TIRGVkiL3ZtHms/vjKPme58gw
 DxUbJTa89dYTY2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CEBF13A7C;
 Mon,  8 Aug 2022 12:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aDYGHDcH8WJZUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 12:53:11 +0000
Date: Mon, 8 Aug 2022 14:53:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YvEHNbOm0dSSmjoI@pevik>
References: <20220808110416.2244071-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808110416.2244071-1-dylan@andestech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_bind: Fix incorrect mount option
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
Cc: x5710999x@gmail.com, alankao@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dylan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I wonder why test didn't failed (at least on SUT I tested it).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
