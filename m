Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D8C433F5
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 13:36:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4101D3CA15E
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 14:36:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5ABF3C1041
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:36:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5955E1A00922
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 14:36:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D7B41F38E;
 Mon, 21 Feb 2022 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645450581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awTagJCGeEh1zy61g9g2t8uS3jNXvZ2UX+MjG3YsJWI=;
 b=oM63vyLRI+pt1o3FKWcKiCmRyDF/Jpi2VuLrU7vfn9ltUoq0wL3R3Llbic0vGM7p5No3rW
 AAdbje1X0xj5YfZg/O1y0TVZWw7nxuxhSVf2KJLzzlf3S6lZ52S+8F/CkYkAx63zvporFS
 F3AfzMjx9TVoNJ53B5xHdqkfTnvPfQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645450581;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awTagJCGeEh1zy61g9g2t8uS3jNXvZ2UX+MjG3YsJWI=;
 b=rxkF8QsAV6+/XeG/Ggx5MdaYZOGyhA71FWWpqwpJx+ssVPJpLh+4huiVemF82Ok6sTC7Gb
 QEHni2hEkSvFcSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE3413AF5;
 Mon, 21 Feb 2022 13:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /0KsCFWVE2KXCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 21 Feb 2022 13:36:21 +0000
Date: Mon, 21 Feb 2022 14:36:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YhOVU92yOLJSWiV2@pevik>
References: <20220218164845.11501-1-pvorel@suse.cz> <YhOONDJPpHcX4bZW@yuki>
 <YhOQAEHFCeMkrYsE@pevik> <YhOTEWKaPpn9Z3yX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhOTEWKaPpn9Z3yX@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC??[DO_NOT_MERGE][PATCH v2 1/1] netstress: Fix race
 between SETSID() and exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

merged, thanks!

> > Yes, this looks like enough. Do you want me to merge this proposal with added
> > this change? Or you send a patch or just merge fix yourself?

> Just merge it all into a single patch.
Sure this was to go to single commit, just wasn't sure if you want to merge it.

> > > However the debugging took longer than I wanted to since the network
> > > tests are such a mess. The server does exit by TBROK (which looks like
> > > it's an expected behavior), only half of the sever log is printed on a
> > > failure, etc. These should really deserve some cleanups...
> > I'd say specifically tst_netload() (in tst_net.sh) and netstress.c deserve
> > cleanup. Also, as we noticed several times shell tests tends to be buggy,
> > specially in combination with C tests. But not sure if feasible to write
> > everything in C.

> I guess that we can do some minor fixes, but the whole codebase looks
> like it needs to be rethinked and redesigned...
+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
