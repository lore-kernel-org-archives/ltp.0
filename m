Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29042C433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 14:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A683C953D
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 15:18:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F3A3C58A8
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:17:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A0C1D600E2D
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 15:17:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACD521F3D2;
 Fri, 14 Jan 2022 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642169877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXG+pjSpghsjokRmZcymUrWsF/rbMfze3Qd/MDC/kaM=;
 b=UMqnbSkK9NM91EzSexFqq+1Y7zzyJl2oWEYv1q1zk8XEYKElM2DIYYYIvFyj/Oqj0rDNTh
 cbeAVI3QoXtvA83rARQYfhF4sPCFHvSwzMtxUrAvLYC09rgXe/KXUaMWExGEAEENnDnVWr
 Bmx/XW7lzxGHeka0RNszea3RS+Kpf+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642169877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXG+pjSpghsjokRmZcymUrWsF/rbMfze3Qd/MDC/kaM=;
 b=0wfERnUcMBireUZZvEaS6j+bfVqKz+vKATSHi7zoNLaSLZRZIgyVKTjzV6lhi9ANO2/Ohx
 8+zq/763rtdW2tCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8496013B7F;
 Fri, 14 Jan 2022 14:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NBxcHhWG4WEhLAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 14 Jan 2022 14:17:57 +0000
Date: Fri, 14 Jan 2022 15:19:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YeGGeN9Z1q0gpAJi@yuki>
References: <20220103151332.1989-1-pvorel@suse.cz>
 <20220103151332.1989-2-pvorel@suse.cz> <YdQpS0WPRvz4vZup@yuki>
 <YdXShIOue2pXGr0C@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdXShIOue2pXGr0C@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ustat0{1,
 2}: Mark failure on Btrfs with known-fail tag
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
> I'd prefer to have it in metadata html/pdf and in known-bug section.
> Thus I'd prefer:
> 
> 	.tags = (const struct tst_tag[]) {
> 		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
> 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
> 		},
> 		{}
> 
> But while this is obviously ok for test output:
> 
> $ ./ustat01 -h
> ...
> Tags
> ----
> known-fail: ustat() is known to fail with EINVAL on Btrfs, see https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/
> 
> It gets parsed as new line:
> 
>   "ustat01": {
>    "tags": [
>      [
>       "known-fail",
>       "ustat() is known to fail with EINVAL on Btrfs, see ",
>       "https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
>      ]
>     ],
>    "fname": "testcases/kernel/syscalls/ustat/ustat01.c"
>   }
> 
> Unless you think it's useful to expect that tag values can have longer input and
> thus testinfo.pl should use all array items (except the first which is key),
> I'd go the easy way and put the link only to top level docparse section as you
> suggested.

I guess that the URL in the tag field is okay too. It makes the line
slightly longer, but at the same time it's more descriptive.

Anyway, can we please still consider this for the release?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
