Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C02CC77B7C
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 12:22:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEE2A3CC012
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 14:22:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88F4B3C8663
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 14:22:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8DC41A00A5F
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 14:22:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E38381FD8B;
 Wed, 19 Apr 2023 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1681906958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bBtEY1zPudze8/KOuYRLEwojMuifUZgs8kIB/FTil0=;
 b=Ef3Huqivy0acNWofh7QK53JjaTqybCWDUElj4D9Fj752CsFguk8Y3gbUpXZqVaEDVbEtIm
 k5OWTRrdGisSCD9D6OHNlfouKWATnWxVZXk41TW4SKowtpNyMH0PgKVeTxYdnBDpAz6FHo
 IzXeFshtFzPFODmaEthnU6hvOFC0R+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1681906958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bBtEY1zPudze8/KOuYRLEwojMuifUZgs8kIB/FTil0=;
 b=FD8tALG3vNbyTZl+AXUK29CZ+iSPqahFwXNQQeAKEUiPyoEnV7VlHYI6oZg8DTuAMcRz+u
 LQi8BHn2wCCyl6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D71113580;
 Wed, 19 Apr 2023 12:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Eco1DQ7dP2TsBQAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 19 Apr 2023 12:22:38 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Apr 2023 17:52:36 +0530
Message-ID: <6279343.jONZJM60Ip@localhost>
Organization: SUSE
In-Reply-To: <ZD/P71dlmvBbRhpb@yuki>
References: <20230413054952.14607-1-akumar@suse.de> <ZD/P71dlmvBbRhpb@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] getpgid01.c: Rewrite using new LTP API
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

Hi Cyril,

On Wednesday, April 19, 2023 4:56:39 PM IST you wrote:
> Hi!
> > +		TST_EXP_POSITIVE(getpgid(1));
> 
> Actually I did remmmeber that we do have TST_EXP_PID() which should be
> more fitting here, since getpgid() returns a PID. Do you agree with
> changing these in the two tests before applying?
Ah, I missed finding that. Please apply in both tests.
Thank you!
> 
> 
--
Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
