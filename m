Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7823EC76196
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 13:57:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85A8B3CDB9F
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 15:57:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 961F33CC718
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 15:57:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB707600B01
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 15:57:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6544225FF;
 Thu,  6 Apr 2023 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680789420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuI7rEXVAd5Io13zAc2gN/AbKEUjXYbUadrLZJs7G7I=;
 b=WoQVQrTyFaKXRHQ6iNlVrkJacxZ6iPuOSlwv8FUO79mXniCR7F9KJ7FZLAnZMg3XfoJo+D
 TQbwwjFidMIJu2OaeaYCg5kZdTzt/UU17Pe9/xutwnGcSUh84GxYzy8SXx/iJS2OBbTnQ9
 tAjLcs8mYcatRmdu3jgboima/pORdq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680789420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JuI7rEXVAd5Io13zAc2gN/AbKEUjXYbUadrLZJs7G7I=;
 b=oQQ8i5x9muTG5IRPWHI/lZ59dWsyEuxxxsZtmpvMsqc+NcJfWSr5ttQUDlnB7X42A/toTH
 wtozsY0g9vbLWfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF57A1351F;
 Thu,  6 Apr 2023 13:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AHP4LazPLmRcGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 06 Apr 2023 13:57:00 +0000
Date: Thu, 6 Apr 2023 15:58:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <ZC7P9BgW1CTFAMjB@yuki>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
 <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
 <20230406131755.GA1608262@pevik>
 <c2a6d31f-173b-4d08-b377-e31748f33443@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2a6d31f-173b-4d08-b377-e31748f33443@app.fastmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, llvm@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Thanks! I've just searched in musl as well, because it didn't make sense to me
> > it'd be a code for LTP.
> >
> > "to catch the fault on ltp" I wonder if it's not actually musl bug.
> 
> No, musl is fine here. The problem is that ltp passes an invalid pointer,
> expecting to get -EFAULT from the kernel when that faults in
> copy_to_user().
> 
> There is nothing wrong with musl sanitizing the data behind that
> pointer, but then you get a signal instead of the EFAULT error.

That's actually quite common, usually we fix that by running the test in
a child and treating SEGFAULT as a PASS.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
