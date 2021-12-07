Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9C8C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 19:40:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F0AC3C6444
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 20:40:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08E823C1DE6
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 20:40:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E96A51A00A45
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 20:40:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15EDE21B38;
 Tue,  7 Dec 2021 19:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638906045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGFpVK603+0P/X2D9ssZ9Xwk2ivRlmCzezfJiyu+bB4=;
 b=Fy/yN+fi9Rocyzf/ik9VOkIHBywQDLbbVqrcEPyrs1GEr5qw0A9tFohOARAE5dVi+g1nCX
 3YF+J2VcoOY4BoMqmfxRUWTwJMsk/DCvYsUgaWH6U94m4HKA3/YyoZQMuorqih4K/UBsf2
 ehdO9qKeFE+tyiHkGRNANf9fDKRdyhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638906045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGFpVK603+0P/X2D9ssZ9Xwk2ivRlmCzezfJiyu+bB4=;
 b=lWUCGIU3HwWaKnaDh9RzvzZEhji/oDLhzEhuWiNBE2CejutVTWBA/A/N95zZaBo61wxa+8
 itE4Ab2wnZ8RjyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E763D13ACD;
 Tue,  7 Dec 2021 19:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h9nuNLy4r2FDdAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 19:40:44 +0000
Date: Tue, 7 Dec 2021 20:42:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ya+5CUgD5CBVhdGG@yuki>
References: <20211202203006.32259-1-pvorel@suse.cz>
 <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
 <Ya3lc9jWR5UZXB3T@pevik> <87wnkgbm70.fsf@suse.de>
 <Ya+VQ9mVuAo99QOB@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ya+VQ9mVuAo99QOB@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I wonder if colours can be added to all output with some autotools toggle?
> There might be some third party plugin, but I haven't found any.

Actually you can override the default macros used to print the results
as described in:

https://stackoverflow.com/questions/38729273/colorize-output-from-configure-script

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
