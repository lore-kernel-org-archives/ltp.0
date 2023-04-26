Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99F3C77B7F
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:22:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 447523CBB97
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 11:22:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9623D3C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:22:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2298320093E
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:22:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58A09219FA;
 Wed, 26 Apr 2023 09:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682500961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2Gk1SeuyEB6L4zVQ/tXIWKU8gi2sY8g09X8syH5iXk=;
 b=XUgjUCthBGnoxc1bqhNNRHGmgfOpR3r0mb0NwFvTG6hJZ4rGq9bZptMhfFcmbm0ojZJa/F
 Ng0Qwp6arUn11kWkRj0OSwGyk9Th2TVwtQT/E8VjJ0fAHYGRniRrieteZ3JOfrwyoLZQGU
 omIBC0NaErARj+r6BRVCyOolwQj4+ps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682500961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j2Gk1SeuyEB6L4zVQ/tXIWKU8gi2sY8g09X8syH5iXk=;
 b=3om2KxoXa2bOoAxooRubPiOnbBg5iaSbw2h/JarMtHOfxw262/FE3VPImLUq+WwpBGKHVv
 dz7jLfx5ei8ek8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43DE9138F0;
 Wed, 26 Apr 2023 09:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JZZUD2HtSGReNwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 09:22:41 +0000
Date: Wed, 26 Apr 2023 11:20:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZEjs9vdLhq15e1T2@rei>
References: <20230421145746.5704-1-mdoucha@suse.cz> <ZEjcFS+yZewIinvL@rei>
 <5caf6d8e-e58c-0cb4-bc46-1a0d8dc56190@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5caf6d8e-e58c-0cb4-bc46-1a0d8dc56190@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] KVM: Add helper functions for accessing
 GDT/LDT
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
Cc: ltp@lists.linux.it, nstange@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I did have a look at the patchset and I do not see anything wrong, but I
> > cannot really review the code without spending a weeks reading the AMD
> > CPU manuals. What about sending v2 with the runtest file change and
> > CCing the x86@kernel.org mailing list? Hopefully some of the kernel devs
> > on that list will have a bit of time to check the actual correctness of
> > the code...
> 
> I've CC'd Nicolai who wrote the original KVM tests. If he approves, I'd 
> say it'd good enough to merge. I've tested the code on AMD machines and 
> it works and successfully reproduces the CVE on affected kernels.

Fair enough, Nikoai can you add you Reviewed-by?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
