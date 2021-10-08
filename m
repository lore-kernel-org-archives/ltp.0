Return-Path: <SRS0=B/OF=O4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5BAC433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 14:43:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603FA60FC1
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 603FA60FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881BB3CA59F
	for <ltp@archiver.kernel.org>; Fri,  8 Oct 2021 16:43:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 473193C5A82
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 16:43:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 799281A01782
 for <ltp@lists.linux.it>; Fri,  8 Oct 2021 16:43:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98FA822356;
 Fri,  8 Oct 2021 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633704186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7o9ggc8qehc8yU9cP6whbD+qZdHWT8ZXJQ6v8zHmdr4=;
 b=MniaPO2dlqHT3m0SpTFcVq8QUO+DGIwyQNQytMw+ApJl7HxpByNWgPnvokC6aMKlcgDBqk
 LGoL+l4RRnaCW58Yz1ai3UOCDYFiDynoeOf4eAwU9Ex5FILjIj4vyviRhjeXmDdXaA9TvK
 JTRNHWpH6AMVGovO2bvrxRNScuJ+VCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633704186;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7o9ggc8qehc8yU9cP6whbD+qZdHWT8ZXJQ6v8zHmdr4=;
 b=/lfdn+d5kPmGrE4pJVGB3Ag0NCXTsWE34zNddyaS9cpUYpbCwqKGcSCQMhv15qv4jfmKzm
 4NMs0+3F/uvXICCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62E1A13F34;
 Fri,  8 Oct 2021 14:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0I0pEvpYYGEqDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Oct 2021 14:43:06 +0000
Date: Fri, 8 Oct 2021 16:43:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YWBZHtrFEEO59BQm@yuki>
References: <20210929083249.22320-1-zhanglianjie@uniontech.com>
 <20210929083249.22320-2-zhanglianjie@uniontech.com>
 <YV7f8yhhvy7L9YIX@yuki>
 <9895d2c0-82a1-833f-c920-b57d1757a7dc@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9895d2c0-82a1-833f-c920-b57d1757a7dc@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/readdir21: Convert to new API
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
> The count here is not used, there is no way to test EINVAL.

Right, looking at the kernel source it's completely unused.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
