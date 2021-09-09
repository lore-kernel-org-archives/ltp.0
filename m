Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9903DC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 11:41:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2B661131
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 11:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF2B661131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8E1D3C21F1
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 13:40:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55C093C21F1
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 13:40:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 42B2D1A014C5
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 13:40:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5F78201CA;
 Thu,  9 Sep 2021 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631187645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1QKkRjCEpHpdgPvf3WfOpujxXQYI+KgaG3c3M0Gi1E=;
 b=nz1WMDn1boLAckeYLwo09z6UmiY5JScBx2mcjeeLYLC71hc6pbSrlfEkNoW0mf4gUmDAnf
 NBZP3AmVrtwvLX1qCpAps1KuRu8pCPwdcFRfMlbtdMbOOG1Mdh/HYXBzYp0Xz+5M+/l+Cx
 j9/MbllY1dUMTtiufiX+esb659NApiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631187645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1QKkRjCEpHpdgPvf3WfOpujxXQYI+KgaG3c3M0Gi1E=;
 b=ISEMaE+ILn8lpw9xk8WcNSDOgmgjOGxFfct670CO56cgCuDJ3feKoZa58ktOfnCZ4Hb/jN
 nEDXIcyZRrb0kFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D31A13A5D;
 Thu,  9 Sep 2021 11:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9b1sJL3yOWHGXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Sep 2021 11:40:45 +0000
Date: Thu, 9 Sep 2021 13:40:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, egorenar@linux.ibm.com,
 ltp@lists.linux.it
Message-ID: <YTnyu7cPAqcBenG3@pevik>
References: <20210901051704.1672590-1-lkml@jv-coder.de>
 <YS8zFoKhGSHCh9eC@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YS8zFoKhGSHCh9eC@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_wallclock: Prevent fail on read-only
 /etc/localtime
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909114043.WofwB2fSd7YtZjAOScQwhiLrJ_ZSb4uwBqfqdx6f5ow@z>

Hi Joerg, all,

merged, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
