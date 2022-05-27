Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E098C433F5
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 12:05:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBCB3C1BBD
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 14:05:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8B683C051B
 for <ltp@lists.linux.it>; Fri, 27 May 2022 14:05:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BFBD4601A31
 for <ltp@lists.linux.it>; Fri, 27 May 2022 14:05:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B26B219D8;
 Fri, 27 May 2022 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653653127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTFPgjjE7ht+N88AKB+GOEI+lAIfGONH7n3BXfsQBng=;
 b=ZkSuI1HlBqjB6sWj1bF+w5o/+8NT1VTVE6KsdTA467xZYy7Qtlwkpzxrai3TYkHr9cWeCc
 SLNFfIrnrEXcwx/qlD8Yk6abAbdqpQS72lL4R9F7IF6SSoJISl2UVv6EtOVDi0+AaFg+1r
 gk+DYJiI4Ivi/W1zul1OJEx6I7rVj6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653653127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GTFPgjjE7ht+N88AKB+GOEI+lAIfGONH7n3BXfsQBng=;
 b=3vfX2M419oK256b07zcFZxOANOzUzIM9YkGR6Tf7BHIKsDneY8D7LFsGV12xTQFBVCva2H
 J7qZtgaRwLKE2zDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2919C13A84;
 Fri, 27 May 2022 12:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KHuQCIe+kGLiHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 27 May 2022 12:05:27 +0000
Date: Fri, 27 May 2022 14:07:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YpC/BoMCMn7u6Idm@yuki>
References: <20220316150429.2873-1-pvorel@suse.cz> <YjH9dDef3w7Iu3vG@pevik>
 <CAEemH2cB+k+dbS_N=S0jGs9H3ct1wBUYhuaR-+V7wRVtydVN_g@mail.gmail.com>
 <YjQ1WKtV0amHh4Aq@pevik>
 <CAEemH2e8af4Y=1vGTL36OjKy2TbuYRBwYFkf7fHT7pfjg6-87w@mail.gmail.com>
 <YmKQUzWN7DKS30r4@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmKQUzWN7DKS30r4@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/1] ci: Ubuntu xenial -> bionic
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

Hi!
> NOTE: if we accept it, I need also to update doc/supported-kernel-libc-versions.txt:
> 
> -| Ubuntu 16.04 LTS xenial      | 4.4    | 2.23  | 5.3.1 | -
> -| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
> +| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
> +| Ubuntu 16.04 LTS xenial      | 4.15   | 2.27  | 7.3.0 | -
                      ^
		  18.04 bionic?

Other than that this looks good, the oldest kernel we have to support
does not change anyways, since RHEL 7 needs 3.10 and SLES 12 LTSS needs 3.12

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
