Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70CC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFBB60BD3
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 14:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DFBB60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3CED3C0CC6
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 16:52:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D766A3C03FE
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 16:52:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 039B91000798
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 16:52:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7681FEBE;
 Mon, 11 Oct 2021 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633963920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAgqrEZlCjAsetbk8KpEfJqY6c+NYBA7oJYIGAnnWrs=;
 b=lIMNVHvM0wayLRC9UcnotWrSXvPo4JlSHz22LLHE38cTZNneOF6tfGmeAjUmOS2gnZ3JPo
 3Stm9CYKwElHC7FoHi4hcc5CnGl6SjhbQwj9UTZRQtX1Fhi6aRX2g8pdO9KXYPGlCocIM9
 /ZOBB+GERhbfwXkVqc8Hvxwtp3YG++s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633963920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jAgqrEZlCjAsetbk8KpEfJqY6c+NYBA7oJYIGAnnWrs=;
 b=wTT0mMJxoR/x+Ol5GNW3w+eYwTmiGdZimpZQb5IsDC+IoZ7kITA2tSTUN/FiAyzo9ijNRe
 RPy8Wz7Va2SLoeBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4B0C13C72;
 Mon, 11 Oct 2021 14:51:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N38pNo9PZGFTQAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Oct 2021 14:51:59 +0000
Date: Mon, 11 Oct 2021 16:52:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YWRPtqBwhlpjyRbs@yuki>
References: <20210907113510.7431-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210907113510.7431-1-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/clone01: Convert to new API
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
I've changed the malloc() for safe buffer[1] and pushed, thanks.

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
