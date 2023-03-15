Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BF9C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 12:22:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A616E3CAD2A
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:22:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0E53C95FB
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:22:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5E0E1000A68
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:22:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CC077219AB;
 Wed, 15 Mar 2023 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678882944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/faaYNdCP38re+Wqwm+4BKFBoxqDSc6a2n2MoAjulc=;
 b=eBLVodWml/9SFGigYjoMtPTMaaTCMA7+RUC7VtpAp+BCyu+UU9NRuMvPy7U/B/r+PaaHOR
 8CiYhJ4G4BdOd/7QbheB4yeGAFn8YwDoUVY/lf9pkF70vKmQZh9+BEH8ebyDQZ1SsKLFYf
 fVLh0ndvOWpa2RUgVzazMjT9OwBadYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678882944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/faaYNdCP38re+Wqwm+4BKFBoxqDSc6a2n2MoAjulc=;
 b=Z5L0yYluazVCf+bI2bABQyO+pmOGhhdgx0EVestCEKHgTiiXxaDaz2zseyBSMXz+ekjNZO
 UUiQdVASKMdZi9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 986A313A2F;
 Wed, 15 Mar 2023 12:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ny/pI4C4EWS1BgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 12:22:24 +0000
Date: Wed, 15 Mar 2023 13:22:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230315122223.GA9861@pevik>
References: <20230308085023.3607-1-andrea.cervesato@suse.de>
 <20230309090412.GB11947@pevik> <ZA7z9cRXDaP4nW9r@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZA7z9cRXDaP4nW9r@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Remove execltp script from install
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

merged!
Thanks Andrea.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
