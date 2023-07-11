Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8283EB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 22:24:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06DE03CED39
	for <ltp@archiver.kernel.org>; Wed, 12 Jul 2023 00:24:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CDFB3C1B84
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 00:24:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 638F8600476
 for <ltp@lists.linux.it>; Wed, 12 Jul 2023 00:24:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 311C11FD9C;
 Tue, 11 Jul 2023 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689114266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMg3hdqSVT6KJ7xh0ihU9E43kVkKrSAFiH1+CCLerPc=;
 b=luGy1F7l+RJoAvEAl7UPdt84AIq5a/j9w8FIZunhAoUBS3hafPASl8VDclx5ae5cQpmDFc
 THtK76xZasWVERptdH7y4O4yF9F9goHLuQcK5dLCFe/wBeawayiz317VEjdXhr4pYfHGMj
 b+w6g2zNF6h4m+HnCDMEfp/xjNK0osc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689114266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMg3hdqSVT6KJ7xh0ihU9E43kVkKrSAFiH1+CCLerPc=;
 b=+COhcbBX8VHKdBWNVGZTBpyfRpv0b4uYBVKVM5KYD4Nt69F2O4I21VrhbNBblSVRnj5mGY
 r66atYiP38p5xIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECAE81390F;
 Tue, 11 Jul 2023 22:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wig2OJnWrWSJTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 22:24:25 +0000
Date: Wed, 12 Jul 2023 00:24:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dylan Dai-Rong =?utf-8?B?Smhvbmco6Y2+5bKx6J6NKQ==?= <dylan@andestech.com>
Message-ID: <20230711222424.GB741097@pevik>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
 <20230627135004.GA58180@pevik> <ZJr66taHPoyDthnz@yuki>
 <20230627182635.GA85230@pevik>
 <SEZPR03MB66190287F9B7DAFEC8870340AC2CA@SEZPR03MB6619.apcprd03.prod.outlook.com>
 <SEZPR03MB661997C80EA3A2641F99E4FDAC31A@SEZPR03MB6619.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SEZPR03MB661997C80EA3A2641F99E4FDAC31A@SEZPR03MB6619.apcprd03.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: Mina Hui-Min =?utf-8?B?Q2hvdSjlkajmhafmlY8p?= <minachou@andestech.com>,
 Tim Shih-Ting =?utf-8?B?T3VZYW5nKOatkOmZveWjq+W6rSk=?=
 <tim609@andestech.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dylan,

patch merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
