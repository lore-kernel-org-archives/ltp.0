Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C677EC00144
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 15:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 935123C8CAA
	for <ltp@archiver.kernel.org>; Fri, 29 Jul 2022 17:37:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE6243C816F
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 17:37:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39DDA10008FD
 for <ltp@lists.linux.it>; Fri, 29 Jul 2022 17:37:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D63F210A5;
 Fri, 29 Jul 2022 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659109054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rhem0GaHMXJ7ETLWDzzB+o3lVR6D2z06cO2NwHWzUCc=;
 b=MukpBFlYec6Q5hsKjV6Qg35ILXZUmGNyi5x/07EGUPJ2M5Ttmx8uHDKfKNRUjwzf9faucH
 Sg/ORTJ5OrmGHJPnNWOsA9BXVGmdgeyEnAmnPjfL1lORwMoLd5MpCZvFE0VJ1GTb5l+3cv
 L718+LVKpXxo2NmgOWtzH65PW6QogoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659109054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rhem0GaHMXJ7ETLWDzzB+o3lVR6D2z06cO2NwHWzUCc=;
 b=k/hP9A/knsptqCJkyECsk4XPjaIHNfo9m8wseTp5Lexf4BVCNIt9epP0m39dEBEnNfRAhb
 Whp4AGu2tMqEBpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5737B13A8E;
 Fri, 29 Jul 2022 15:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wX/lE77+42K/fgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 29 Jul 2022 15:37:34 +0000
Date: Fri, 29 Jul 2022 17:37:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <YuP+vDRO+5qU9WO/@pevik>
References: <20220722083529.209-1-chenhx.fnst@fujitsu.com>
 <YuPyB1Vr3Yps37yX@pevik> <YuP0H794ld8hhvqo@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YuP0H794ld8hhvqo@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] resource_files: inline resource file for readable
 doc
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

Hi Chen, Cyril,

I was wrong, inlining arrays does any change in the docparse output when
constant is kept being used. I'd be still for inlining with kept constant, due
better readability.

I tried to address replacing constant in separate patch:
https://lore.kernel.org/ltp/20220729153246.1213-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20220729153246.1213-1-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
