Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18906C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:23:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBFAC3CB1D3
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 15:22:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0B83CACEF
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 15:22:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 48CD8200AF0
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 15:22:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2182E1F889;
 Fri, 21 Oct 2022 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666358567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R109LwonxaM++2tPBwyL6nD5M3Yi1TBY2o5TWOKUFyI=;
 b=ZGKpjI+ozR4voLxn2g/prPvFhblMnw2tbc5ZA7PyzwehgidqnGic/hua3HFa0PskDmZIEc
 5mcm9leM42TryEzVQswdEoQVWKqnbDuPtideiLFOeq/Kbve9bnOQtruuoAOljwa1rW/w4g
 AFW+NC+8P0gge7BbiIdWD5n6BPNBO9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666358567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R109LwonxaM++2tPBwyL6nD5M3Yi1TBY2o5TWOKUFyI=;
 b=4DKBUk9L+5BREKybtEtJYfLUt4NItyoMsdh5ZEsB7YorPnGzdnONk2MR7piZsPQXjMY7lq
 WYUKijQ0jn1JsgDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E70B1331A;
 Fri, 21 Oct 2022 13:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zXRrAiedUmOLfgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Oct 2022 13:22:47 +0000
Date: Fri, 21 Oct 2022 15:24:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y1KdjE6gu/ILnEO6@yuki>
References: <20221020133715.256521-1-akihiko.odaki@daynix.com>
 <Y1GFvU/ixieqDSq6@pevik> <Y1JiQSWlxVSkhuoq@yuki>
 <Y1KBzfdqbibHmAa3@pevik> <Y1KTyn/9pv5lvbhj@yuki>
 <Y1KanyaTySzBG7xN@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1KanyaTySzBG7xN@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_test.sh: Normalize the locale
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yep. I thought more about pure C API programs. Mostly they don't have any locale
> related code, but sometimes they call other programs via shell (e.g.
> tst_system(), but there are more).
>
> I also aimed for consistency between C and shell API.
> That's why I thought we should consider setlocale() on LC_ALL and LANG in
> lib/tst_test.c. But maybe I'm wrong.

I do not think that we need to call setlocale() in tst_test.c we do not
have any support for locales there anyways.

As for any programs executed from these as long as environment is
propagated correctly the locale would be set to C once the corresponding
program calls setlocale() in main().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
