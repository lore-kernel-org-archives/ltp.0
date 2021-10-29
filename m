Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B4C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:21:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A24261157
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A24261157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7CCB3C6EC7
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 10:21:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE10D3C0EBB
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:21:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 966171007EAD
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 10:21:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BAEA21971;
 Fri, 29 Oct 2021 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635495686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ97Apz9GKS3FSa/Gr2uvXirKdYMezilvoC+YF4bHoA=;
 b=M92/EKYVQywlmb7IBtPRlCESTx//XZE8VPozj1HKKcjknWP9CyY82bpwAeD0gIP8deUDgD
 7K3mc5kL6kdR5ShtxDzRbN1wsAmKa7O27/xMwxhrbcV1z9H6NQw2UnRvMzcuTEUe10PdSp
 uclBM9qgY5/kj/jnpKf3ucYKnRSHFOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635495686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qZ97Apz9GKS3FSa/Gr2uvXirKdYMezilvoC+YF4bHoA=;
 b=3SDMkYnGWZeiAJE0rJreQi+fNg/r95al5SZ5unQcTj+MA06XMYYP75y7Jia8+CxgE6CAof
 mNVEwyPUVuTBQzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 867CC13A83;
 Fri, 29 Oct 2021 08:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VyVWHwave2GRDwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 29 Oct 2021 08:21:26 +0000
Date: Fri, 29 Oct 2021 10:22:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YXuvOmU3Q+n61eSn@yuki>
References: <20211027092027.7124-1-pvorel@suse.cz> <YXkfDEFLUkOO+70q@pevik>
 <YXkhQ86Oal0KuI0K@yuki> <YXkmPU9/02Ickuso@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YXkmPU9/02Ickuso@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] CI: Reenable Tumbleweed
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

Hi!
> > Looking at docker documentation it looks like --privileged disables much
> > more than just the seccomp filtering. I do not think that this is a good
> > idea. Let's go with just disabling seccomp for affected distros.
> IMHO both are ok for just compilation (other projects use it as well for just
> CI doing compilation), but sure, let's use the minimum.
> FYI this disables seccomp for all machines. Is that ok for you?
> IMHO that's not a big deal + we will not have to bother when Fedora also gets
> new enough glibc (IMHO problem will periodically occurs on bleeding edge distros
> when glibc starts to use new enough syscall).

Anyways:

Acked-by: Cyril Hrubis <chrubis@suse.cz>

For the original patch that disables seccomp.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
