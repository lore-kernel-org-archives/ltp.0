Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D82EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 22:17:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3751D3CDED2
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 00:17:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B8C3C02C7
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 00:16:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BCFF21000406
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 00:16:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 957BC21954;
 Tue, 11 Jul 2023 22:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689113814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hz1BHRs/Ns2I0sCdngvSwKyKODo0AZ/Mgq658xjhqR4=;
 b=v4u2d9f5Kok4O+noQkMTkcvw1lRQdWq186sAHLNoO9jvkEhD+XM8hGsRvDTX9nWfnqfsQx
 Ik89/F0ggb77YLvHo1r5GmIcFKrQb7M9tFJHjy4dIYxp1UEdFTI35o2blAXCUiUhgIFZMa
 vxnKnyUGhRm1spzpJyjHTiOY29NgDQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689113814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hz1BHRs/Ns2I0sCdngvSwKyKODo0AZ/Mgq658xjhqR4=;
 b=jJgLL/BUCVbbX8qUI27cBQ9QDUcVi93BKSmSMXIXTN/Gi706jgWplXnFNtIBTXUIrWkxkF
 7D6ZvldMkJHDzoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7532F1390F;
 Tue, 11 Jul 2023 22:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id siI5G9bUrWSaTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 22:16:54 +0000
Date: Wed, 12 Jul 2023 00:16:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20230711221653.GA741097@pevik>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-3-andrea.cervesato@suse.de>
 <20230711111419.GB722759@pevik>
 <530aac70-b05b-32e6-4b0d-ae874c00d742@suse.com>
 <1c1b56ab-5c40-a1d0-65f1-27ea5c50f7ed@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c1b56ab-5c40-a1d0-65f1-27ea5c50f7ed@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] Refactor mqns_04 using new LTP API
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

Hi Andrea,

> Hi,

> there's an another problem with patches: controllers runtest file is not
> updated according with the latest version, so it will need to be updated.

Thanks for info. I set patchset as changes requested, please wait little longer
for more feedback (others; I also haven't had a chance for a deeper look) and
then send a new version.

Kind regards,
Petr

> Thanks,
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
