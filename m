Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD4C433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 08:14:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C176113E
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 08:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0C176113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57E983C9185
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 10:14:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36A6B3C2E5D
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 10:14:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5ABB7601CB7
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 10:14:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C6C61FE4A;
 Wed, 15 Sep 2021 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631693649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVFDEWPRu0oRA4DCf5hYm8RroxI55g/CwOlGzj+Bf0U=;
 b=K2FDYG78S5l1ByrtY1xaMo0Fu8TNdFIw9nxKr9g1+vF/wgE+CxCRv77Y8VZWHzeBclgOzg
 alF0md7Z4XflTieSiqUMwLQP51uCKaRW/yer5z/y4EpJ7jjHHlTN/nRo5FErU54oDStALC
 oeCDWNOOWoFEQDa4QKFLceJ/HKa4OoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631693649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AVFDEWPRu0oRA4DCf5hYm8RroxI55g/CwOlGzj+Bf0U=;
 b=DGgSYkKFMussmOWDi47R2qz61pYJdte8Sdq1G6qs0W0CBJJiRYsHX3EQQqTIRVNcqPoWxF
 VIVBphuexTdQKUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EACF13C21;
 Wed, 15 Sep 2021 08:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rvm4ElGrQWFgLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Sep 2021 08:14:09 +0000
Date: Wed, 15 Sep 2021 10:14:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YUGrZ/My4DHyUAT5@yuki>
References: <20210914150220.2467-1-chrubis@suse.cz>
 <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_virt: Add option to override virt
 detection
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210915081431.zLjRG9L6MHXQsmz3D4sE-JYR_wifdmEz5bl0PWBzjQA@z>

Hi!
> > There seems to be cases where systemd-detect-virt does not detect
> > virtualization correctly. To work around this bugs this commit adds a
> > a support for LTP_VIRT_OVERRIDE environment variable that if set is used
> > instead of the output from the systemd-detect-virt command.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

I've added a description for the variable into doc/user-guide.txt and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
