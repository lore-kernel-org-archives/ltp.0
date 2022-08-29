Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C635ECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 12:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FFBC3CA52C
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 14:22:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8DEA3C6817
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 14:22:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7AD7E6002CE
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 14:22:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9554421ACA;
 Mon, 29 Aug 2022 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661775758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YExzfCoaQN/oTWD6ESVhdwgwQ+OKBaUq8QvyYtel9o=;
 b=v+9kyiQBvqC44Th6nDkLBXUQxFLzyo/0NenaPJqfulD4X8wEApWBZ1s1HrHZqzITr4LCL1
 zW3aAWXLuItrnilNAseH06h47FthpSnNMEKvZzkQyrdBlvE7SNgNhoWvaX3EVi4RMI3Mxj
 Udavy7/UD7b5d108qNXftfu+1odEK18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661775758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5YExzfCoaQN/oTWD6ESVhdwgwQ+OKBaUq8QvyYtel9o=;
 b=DTpH5WsFvHgcJybuIFUtgPsWeQZHoY/25EHu1sODJJEa8m9Y99ELkP7rd4wyjsuhNa0R1M
 oFpZn61F4hLCEuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77C22133A6;
 Mon, 29 Aug 2022 12:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LeTBD46vDGMdMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Aug 2022 12:22:38 +0000
Date: Mon, 29 Aug 2022 14:24:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YwywBFhVtfO6gc0u@yuki>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-3-pvorel@suse.cz> <YwybzIVhMaCqYR/S@yuki>
 <YwyjDLcGzhDiWXkD@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwyjDLcGzhDiWXkD@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 2/6] API: tst_device: Track
 minimal size per filesystem
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
> > I do not think that we should harcode this here. I would be for a more
> > dynamic approach, i.e. add a function into the tst_supported_fs_types.c
> > that loops over supported filesystems and chooses max over the minimal
> > values for all supported filesystems. That way if we run on embedded
> > targets the device size will be 16MB as long as btrfs-progs is not
> > installed. Also that way we can easily define minimal size for xfs 300MB
> > and things will work for embedded as long as xfs-progs are not
> > installed.
> Correct. So the value for .all_filesystems should be maximum of supported
> filesystems. The only think I don't like about it that it takes some time to
> check everything (mkfs.* available ... etc), but we can't avoid it.
> 
> Is it worth to cache this value (make it static in the function) so that it's not
> searched more than once?

Actually all we would need is a flag that would just return the pointer
to the fs_types array from the tst_get_supported_fs_types() on second
and subsequent calls.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
