Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E6C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 12:18:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B44EB3C9FF8
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 13:18:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3DE43C0309
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 13:18:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 710D36010E2
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 13:18:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79C432198B;
 Thu, 17 Feb 2022 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645100316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axdt3EO2+0MqS0c3sL0sQw6bvpSjFXBb3syTZCsQbpo=;
 b=uM7Z4JrowsceTFgR4LJ8w6cGo0MW7oQh6wv5mXrm3PLgdcievuMN/xtsk1k81D6k3TMm8Q
 VH7YaRn03hNYZrjMeBomFapqeOt7YlfGRTiiowVFhrJQ7utF6j5i4gWCFdyd2ThaOzoGzW
 vwloyb9W/QTPHjQUQ7YxMe9RIRptoNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645100316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Axdt3EO2+0MqS0c3sL0sQw6bvpSjFXBb3syTZCsQbpo=;
 b=Tg26PDacoXaWXUN/IH4a9hpC8qVlGmkaIyJ2eKgkmd+xw9ICX9KgEv78szxrQjdzhU2VvK
 RqrcnJ2GxmDvqtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16D8713BF1;
 Thu, 17 Feb 2022 12:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QaWhAxw9DmKOdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 12:18:36 +0000
Date: Thu, 17 Feb 2022 13:18:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yg49GRX9Gpyle0pG@pevik>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz> <Yg4bt2V6rrircZ+x@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg4bt2V6rrircZ+x@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
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
Cc: Vlad Yasevich <vyasevich@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, ltp@lists.linux.it,
 linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

patchset merged (with suggested changes + few more TERRNO replaced).

Thanks!

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
