Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F5CECAAD2
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 10:41:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 742CD3CA599
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 12:41:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02B373C759A
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 12:41:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CEAAA1400BD8
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 12:41:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CA1D1F461;
 Mon, 29 Aug 2022 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661769693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FUtt9ZHJcfvLL2U8OugtDLTRa+8tTNiw/VmEggc0fE=;
 b=FZpvGRjejLS3xlzLsfI5XEngKQjShFIkWWfrizppK+1nc260IR7GgTKNwA2j+mgiNxJnkk
 OVujeXAXlFvlgP+tgsptZABMOT4SnNS7SZpotgEnxU/v+giMJoV6XiYcjHkO/bZBkwrPXn
 B5Y5k6dIMsv0PzaRXuaKDQ6g5HD8mVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661769693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FUtt9ZHJcfvLL2U8OugtDLTRa+8tTNiw/VmEggc0fE=;
 b=EYVizWn+4kwcn9Y+oL1RtI5SHKoDukIf6QsEuDbtfhuSF8K7gaH5aG351+xokpIiSA8Caq
 dGFVrA0p7nikuzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6795A133A6;
 Mon, 29 Aug 2022 10:41:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q8IAFt2XDGNRSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Aug 2022 10:41:33 +0000
Date: Mon, 29 Aug 2022 12:43:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YwyYUzvlxfIGpTwo@yuki>
References: <20220827002815.19116-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220827002815.19116-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 0/6] Track minimal size per
 filesystem
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This patchset require to be on the top of:
> 
> [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
> https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

I'm not that sure if we want to run tests for xfs filesystem that is
smaller than minimal size used in production. I bet that we will cover
different codepaths that eventually end up being used in production
that way.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
