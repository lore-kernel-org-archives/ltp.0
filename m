Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E55C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:44:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AEEB3C93EC
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:44:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4027A3C937D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:44:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 60E4A1401106
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 07:44:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFB881F3B1;
 Tue, 11 Jan 2022 06:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641883474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Bf1Q13+BysSCWJuESgY8PO3C6i7tHyz5Y2fevlVpCk=;
 b=DAP5Rrp2DfDI2CXxXRA/Bt8l5L7UmelWgh5tihzuRiErKcpvFfl/Q3x+nX4kWCOtp0Qbua
 MJeA3VEsVU5rFjBAwncvxDIUkB+a4/iSHpGE7fHbJVEWSCuzzgIgshx8eP1OThvp7hV2BV
 7VnzSLG92JFFp2xDkPtgYbq8LhU8cs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641883474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Bf1Q13+BysSCWJuESgY8PO3C6i7tHyz5Y2fevlVpCk=;
 b=u36+ranhtxuFAkJnDKJzQknTZHzH1LnnRiUmxR5JfZQYgCg2Dbm7Wx3q8odjB6w22oalwz
 JoTmaQ1RlAKM98BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CEC013A7C;
 Tue, 11 Jan 2022 06:44:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BL2PJFIn3WETZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jan 2022 06:44:34 +0000
Date: Tue, 11 Jan 2022 07:44:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <Yd0nUUHO6i8s8NTd@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz> <YdQ1hg+12qGbzfr6@pevik>
 <Yd0VnFwxahO0fXjc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yd0VnFwxahO0fXjc@gondor.apana.org.au>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] tst_af_alg: Another fix for disabled weak
 cipher
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

Hi Herbert,

> On Tue, Jan 04, 2022 at 12:54:46PM +0100, Petr Vorel wrote:
> > Hi all,

> > [Cc Herbert and Eric ]

> > FYI Herbert's view for using ELIBBAD instead of ENOENT (reply to Eric's question
> > whether using ELIBBAD in kernel is a good approach or bug) [1]:

> > "For the purpose of identifying FIPS-disabled algorithm (as opposed
> > to an algorithm that's not enabled in the kernel at all), I think
> > it is perfectly safe to use ELIBBAD instead of ENOENT in user-space."

> > I suppose that's justify my proposed changes (i.e. testing also ELIBBAD when
> > fips enabled).

> > @Herbert if you care, you can post your Acked-by: tag.

> Please hold the horses on this patch.

I'm sorry, too late, already merged. But never mind, LTP is not tight to
particular kernel version (we tried to cover also very old releases), thus the
old releases will be covered with this commit, never ones with the default check
for ENOENT (regardless FIPS).

> I'm about to post a series of patches that aims to disable algorithms
> such as sha1 in FIPS mode while still allowing compound algorithms such
> as hmac(sha1) to work.
Thanks for notifying.

> As a result of this series, ENOENT will again be returned for FIPS-
> disallowed algorithms when in FIPS mode.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
