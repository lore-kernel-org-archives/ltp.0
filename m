Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F6EC77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9C9D3CE93C
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:35:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33D263CBA98
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:35:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E84B31A00A3A
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:35:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E268B21B16;
 Thu, 27 Apr 2023 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682598946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2SSFwcf74U7eccN9zzpwJOE762O1+VvU1hD0kV7ssfA=;
 b=qGXqOQMBktdn1n5UJfauIzz4SgjAGnpuOGsVMgg/Y2EuXJfZ5qyN7BahOeWCwT47OrgCn/
 glorhEu1qSDGegUkLFAPoKYXftXgJ8hVxcM8IgZBpc/Olwv98vg0PeNEuCd4o5GHuViuXm
 dU0K9ACOEAibpqMMy906/V8Lq+WL4Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682598946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2SSFwcf74U7eccN9zzpwJOE762O1+VvU1hD0kV7ssfA=;
 b=iYHUHW+XCIulXApTTfz5Fg/uOcphaTHFQ1Jo/F/ycBAQB8qa5Puo6NYFhkd8Jo6+PkBKL6
 tNyaf1Z0SqBBS1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF07313910;
 Thu, 27 Apr 2023 12:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4rFNMSJsSmRwWgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 27 Apr 2023 12:35:46 +0000
Date: Thu, 27 Apr 2023 14:33:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <ZEprt3jn04U5EAOL@rei>
References: <20230427034039.46512-1-liwang@redhat.com>
 <CAASaF6xujKxK+7Enp5uCk5CZuioc3TjUMjuYe4C6UdWMC6_X+A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xujKxK+7Enp5uCk5CZuioc3TjUMjuYe4C6UdWMC6_X+A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap24: increase the baseline of
 slice_boundary according to hpage size
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
Cc: Fanhui Meng <mengfanhui@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> It's an improvement, but the issue of usage of MAP_FIXED remains.
> No harm taking the patch, but we should likely still rewrite this test.
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>

I suppose that this is a band-aid that can go in before the release, but
as Jan said the test needs to be redesigned.

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
