Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF39CC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 17:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66ED13C55A2
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 18:09:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 805FA3C21F9
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 18:09:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76EB31401170
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 18:09:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E3FF1FDFE;
 Tue,  7 Dec 2021 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638896965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAjSdrVQTCNWqebTOsvPkARr9OoCnx2qTytLW7jluk0=;
 b=fa3MDKTQPhVhZXeDIU/rq3Nr0LNdtEnnVi3TCcKri7sMtycpBpwPyzMEus60a6qdElpnXV
 1PqxP1Kfq9tkbQtB5Asxg0wqX33JUwdcs3ANLiX65HciwqloiD6TvYuMUj9LZRCUDfwiH4
 pXEqgqYJpKSIEsgIHH6Bm6ah92hLYIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638896965;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAjSdrVQTCNWqebTOsvPkARr9OoCnx2qTytLW7jluk0=;
 b=OnH68GoOKnSz4RZqRO1MAnsiDvt2xqi9TziCdjsb7HGm5FODg/v9wAJ5z3FK6+77g6vJnh
 E2NsHPmdGvHnJ8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20A7113AB5;
 Tue,  7 Dec 2021 17:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vMyZBUWVr2EBOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Dec 2021 17:09:25 +0000
Date: Tue, 7 Dec 2021 18:09:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Ya+VQ9mVuAo99QOB@pevik>
References: <20211202203006.32259-1-pvorel@suse.cz>
 <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
 <Ya3lc9jWR5UZXB3T@pevik> <87wnkgbm70.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87wnkgbm70.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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

Hi Richie, Jan,

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Jan,

> >> On Thu, Dec 2, 2021 at 9:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> >> > Due many checks of structs, members etc are chosen testsuites,
> >> > presence of used libraries and docparser config results quite hidden.
> >> > Print them as summary in the end.

> >> Color output would be nice too. But I find this output useful in plain
> >> text as well:
> >> Acked-by: Jan Stancek <jstancek@redhat.com>

> > Thanks! I can have look on colors later on, but I'd prefer to do it as a
> > separate approach.

> > Kind regards,
> > Petr

> I wonder if colours can be added to all output with some autotools toggle?
There might be some third party plugin, but I haven't found any.

> Anyway, pushed!
Ah, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
