Return-Path: <SRS0=1KVt=O3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4155C433F5
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 12:52:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D77361019
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D77361019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4CA73C7ACD
	for <ltp@archiver.kernel.org>; Thu,  7 Oct 2021 14:52:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2219E3C6CCC
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 14:52:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2EE0510005B4
 for <ltp@lists.linux.it>; Thu,  7 Oct 2021 14:52:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E1DB224F0;
 Thu,  7 Oct 2021 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633611162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O31pyHCOQOEXkKXdOVNNl4DUYb8MZ8v8nRo22Ik4IZ4=;
 b=FTC9rYNN/raxz98X9jMh0BSyU9DZ4vcTEp7IHUhD+rFWdRHCT4ODyqJpWOS3ExG5kLs54r
 vbnNyM+T3SqRAcq5aWf4etAnxpgvrL/2ctYcUQ/XaQFoXilXg11HR6+dROYAwVYvh4ffqF
 SirzpUjGqNwVR/vuN8jtXO2lbKQcecY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633611162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O31pyHCOQOEXkKXdOVNNl4DUYb8MZ8v8nRo22Ik4IZ4=;
 b=WKyiiITdnjudaVS0yBE85iOZZerUre9i5xpJVaw0Hckv/ZpoV+ftOf3kONQB+Z4V+p97nt
 pb17BoI6rQ2pwIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C4FC13C9F;
 Thu,  7 Oct 2021 12:52:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iDVhAprtXmELHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 07 Oct 2021 12:52:42 +0000
Date: Thu, 7 Oct 2021 14:53:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YV7tvVgHvY0XT2tN@yuki>
References: <1632289182-2191-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1632289182-2191-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] syscalls/dup202: Also check mode whethter
 change when calling chmod after dup2
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
>   * Test whether the access mode are the same for both file descriptors.
> + * Style: creat mode, dup2, [change mode], check mode
>   *
> - * - 0: read only ? "0444"
> - * - 1: write only ? "0222"
> - * - 2: read/write ? "0666"
> + * - 0: read only, dup2, null, read only ? "0444"
> + * - 1: write only, dup2, null, write only ? "0222"
> + * - 2: read/write, dup2, null, read/write ? "0666"
> + * - 3: read/write/execute, dup2, read only, read only ? "0444"
> + * - 4: read/write/execute, dup2, write only, write only ? "0222"
> + * - 5: read/write/execute, dup2, read/write, read/write ? "0666"
>   */

I've changed this description slightly so that it renders nicely in
asciidoc and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
