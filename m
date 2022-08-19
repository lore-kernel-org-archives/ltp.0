Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A86C25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 08:12:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB65B3CA1DB
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:12:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425663C8A8C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:12:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56C86200220
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 10:12:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF2E20757;
 Fri, 19 Aug 2022 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660896755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpC4MbEOhUeEDJF+Cm2XAe4Oh/Qccw2viIwqA8eFJeo=;
 b=hadPyk9VCvcL7fL1TXLTt0SZVp7dTNStMSSCZjTysvFNt6hBKu1h0R2oc9djN94ex4BhHS
 kQIa/P3/K9FUNBcvIjIVDx7EIgNEHHBE8E43Q26iFlqUybgOVA5qV6uj66nquIp8kfDYSA
 vKJIzZjClP00O6FcBhhx2pTL4Ybi38I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660896755;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpC4MbEOhUeEDJF+Cm2XAe4Oh/Qccw2viIwqA8eFJeo=;
 b=cMwp/2uy+yp49L4F2xiVV0nXwX9dw1pVjRVFPSroPFXX3vsNZuJ8Aii1GJshMNyTvv4i8h
 emcZOA6yCeuwN0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D9513AE9;
 Fri, 19 Aug 2022 08:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 17btMvJF/2IGYAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 08:12:34 +0000
Date: Fri, 19 Aug 2022 10:12:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <Yv9F8MnPGyLLE0Zm@pevik>
References: <20220712173921.2623135-1-edliaw@google.com> <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
 <YvyxCXTGYpLd8kbQ@pevik>
 <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
 <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > On Wed, Aug 17, 2022, 2:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> >> Hi Edward,

> >> Would you mind we delay merging after you fill the bug in llvm, so that
> >> we can
> >> add it to git commit message?


> Here's the link to the bug on llvm:
> https://github.com/llvm/llvm-project/issues/57234

Thanks! The bug was closed as 'adding "cx" worked'. Reading topperc's comment it
looks like there no other way to fix the issue on clang than workaround with
volatile. Does it mean that it's a syscall problem and clang can do nothing
about it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
