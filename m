Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A91C0015E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:58:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60FBE3CD0D0
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:58:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 816EC3C0B90
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:58:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0493C10009AF
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:58:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3AA9F1F74A;
 Fri, 11 Aug 2023 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691755126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TbOP1tyAJW6XHmK+THZPZ1K3c7SW5tHm0zbCk6c2CgQ=;
 b=02y3l/COxUWjAk7rNg5eZJW6c6md0XN7oJMok55oUCs/Hfd1E8wHzLt5pPfPgRchk46Qck
 whyf2f+dsCDBntWgwrMkfuQN0K+3tMtA8VU33egjIv/93u2oE5cJpkCo5AmLevXm2gsH4W
 fonEgt+gzMin6DB8TW1dv7cs57bA/c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691755126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TbOP1tyAJW6XHmK+THZPZ1K3c7SW5tHm0zbCk6c2CgQ=;
 b=8DySjwklVPsewWqOpkeLT5QNb+t7Hbmb+56Oqxr6sBwsygvL/xKdZ0lg9yWNVeZnxpqPYa
 bHV99vd2+mvAAnBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 268DF138E2;
 Fri, 11 Aug 2023 11:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QeLfB3Yi1mQ8XAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Aug 2023 11:58:46 +0000
Date: Fri, 11 Aug 2023 13:59:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNYis5uAp5BRlZ9h@yuki>
References: <1691208482-5464-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1691208482-5464-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNT6GkZ05CrGk5pV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZNT6GkZ05CrGk5pV@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/faccessat201: Add new testcase
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
> Why do we allocate anything here when we replace the pointers in the
> test setup anyways?
> 
> If anything it would make sense to allocate the buffers in the test
> setup instead of using static strings there. Also filepath[x] way less
> readable than actually giving the variables proper names such as
> abs_path.

And it turns out that tst_strdup() was already there, however I've send
a patch to add .str member to the tst_buffers structure as well as
tst_aprintf(). The usage should be clear from the few tests I've
converted to use the new API.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
