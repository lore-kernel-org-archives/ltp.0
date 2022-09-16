Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5C2C54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 14:06:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB91C3CAC77
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 16:06:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56ED63C93FF
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:06:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AB43C1A019B2
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 16:06:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECEE8206C7;
 Fri, 16 Sep 2022 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663337187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHxHFnuu823x/UJd2pKnfDKqSwbs3l/csfbm0eLf3x4=;
 b=PCD/1eGqcYVJuVNeXcwnHe/zrdGcRNr73+2z4l9s8C/C/lr71KxJCll9xoTrGsYL8Hmsw9
 CvUtssLIGVKZjc4IM/0mOCocdoKlQNmojNIP4gezyT772yW2mKXkKFmiHnarLZQ+ttPeWC
 uYQhHLp5pcw6I86n1geFbZZOBkAtHs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663337187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IHxHFnuu823x/UJd2pKnfDKqSwbs3l/csfbm0eLf3x4=;
 b=Y00lGgVF+37iqdorlo+HqLA5De5Vb+UboaDLHxpoPFM0e+DkxEpNa3en9+ny35PY/WHJaL
 q53I+ShBl7TlCcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D93591332E;
 Fri, 16 Sep 2022 14:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GBnsM+OCJGPjUAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 14:06:27 +0000
Date: Fri, 16 Sep 2022 16:08:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YySDWP9I46TDIgEK@yuki>
References: <20220906054612.9790-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220906054612.9790-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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
> * EMBEDDED_FILENAME
> fanotify.h:15: WARNING: It's generally not useful to have the filename in the file
> on #include <sys/fanotify.h> in fanotify.h
> 
> * ENOSYS
> fanotify.h:26: WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> on if (errno == ENOSYS)
> 
> * NEW_TYPEDEFS
> fanotify.h:180: WARNING: do not add new typedefs
> on typedef struct {

I'm not 100% sure about the NEW_TYPEDEFS check, that one is mostly
right. The later two are fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
