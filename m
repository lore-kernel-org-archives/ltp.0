Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AF6EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:27:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CDEA3CAF7B
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:27:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C0703CAC32
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:27:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A8D66008B8
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:27:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A37DD1F86B;
 Tue, 20 Jun 2023 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687249661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECsPbNgyn3slAkf0NBWqPwISpehAZMeWt5GS/VqkSGE=;
 b=YX61iZbWofk20wUVY9qreT9iSZNyhBtBv763dG59RT7sbuku6z09czQ4CLSLiMetYL/ebH
 AksVBH/Qlxl/n8EWS4RJzbJVr+/pHQS6NcwLGmmDD7ny6bbjjCRnA2DneSoCfJVLvKqXBS
 hVYqPNm0uKMTYFMpbDgaXv/Q7Ru2kc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687249661;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECsPbNgyn3slAkf0NBWqPwISpehAZMeWt5GS/VqkSGE=;
 b=UfPoeEtq6l0xf/CH18iPm9TzDRltOfyYt8livjrXrt0jmaAL/IFts5L6U2EZXdgSri+dnm
 UVW8jvhBgqoty7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 692D61346D;
 Tue, 20 Jun 2023 08:27:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hZRXGP1ikWRjHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 08:27:41 +0000
Date: Tue, 20 Jun 2023 10:27:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230620082734.GA271551@pevik>
References: <20230619163255.234848-1-pvorel@suse.cz>
 <CAEemH2dQsp17RL1fFODhOCSvRJ8N0=2BUi5_JtxO4d_ofcBx4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dQsp17RL1fFODhOCSvRJ8N0=2BUi5_JtxO4d_ofcBx4w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: Don't test doc generation on Debian
 oldstable
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

Hi Li,

> Hi Petr,

> Thanks so much for the debugging work.

Thanks for your review, merged.
CI should be green again in few minutes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
