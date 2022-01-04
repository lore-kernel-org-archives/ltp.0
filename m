Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BDC433EF
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 11:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89F8A3C908E
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 12:55:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49A1A3C21C8
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:54:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54F74140004E
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 12:54:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5AB022113D;
 Tue,  4 Jan 2022 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641297288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqMMWDhGB1GkGGIvhdFPFBCcXoFiapVEYfpaxD1M9jc=;
 b=E1yK0/g3GII809SxE+6H8fl2vVObg0pmT0mC60VOh6tRdRDiRcc6eOcWmjQwgN0ikyZoqf
 KVHdD/D0wAOLGBi7usW2Klt7JUlw8FhVrwTRtpoOLR+m+SzSPHtdAWFes75WgpbDV7mV/v
 jr3H02M24lAU3altnKJ1bp8sQlX7A28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641297288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MqMMWDhGB1GkGGIvhdFPFBCcXoFiapVEYfpaxD1M9jc=;
 b=TyKFJzvaDVf+M1JIQfkExOBZtGttBSGY0kbP+EV7TrC0IjGeaCttddoAUlKJVpsy92G3uo
 mIBqDWVshwg+sADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2089D13AF4;
 Tue,  4 Jan 2022 11:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QSn3BYg11GFVRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jan 2022 11:54:48 +0000
Date: Tue, 4 Jan 2022 12:54:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YdQ1hg+12qGbzfr6@pevik>
References: <20211220212756.13510-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211220212756.13510-1-pvorel@suse.cz>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[Cc Herbert and Eric ]

FYI Herbert's view for using ELIBBAD instead of ENOENT (reply to Eric's question
whether using ELIBBAD in kernel is a good approach or bug) [1]:

"For the purpose of identifying FIPS-disabled algorithm (as opposed
to an algorithm that's not enabled in the kernel at all), I think
it is perfectly safe to use ELIBBAD instead of ENOENT in user-space."

I suppose that's justify my proposed changes (i.e. testing also ELIBBAD when
fips enabled).

@Herbert if you care, you can post your Acked-by: tag.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-crypto/YclURQzYKqCMHWx6@gondor.apana.org.au/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
