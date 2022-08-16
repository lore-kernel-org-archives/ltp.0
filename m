Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2104C28B2B
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 13:01:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BCCD3C9A9A
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 15:01:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D2183C97E3
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 15:01:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DBBD0600769
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 15:01:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E27A01FBAD;
 Tue, 16 Aug 2022 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660654879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2My+LiBlhjLEV/IwKsr9c/AsSTH0k26pcC0hW0zy9nw=;
 b=a2CBqpE+o5jaB8WVv6nw4qvGlc7a7Yeg00irqKUlahr+GSY/a3XL+eKpGxlwp5OtsjDkiN
 2vtYp4dzt0JUOgBAcaGrVJtueeNa78mVM9KF2gkiHcyXtxkTPjD4U/JP+J5TAtcrjes5c4
 0uJzmdiyBt/nwb3l+Fq7K7zCqOV4mTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660654879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2My+LiBlhjLEV/IwKsr9c/AsSTH0k26pcC0hW0zy9nw=;
 b=HjJc96qOmd7C8ZsAKL0lFZv11xYU+9FxMarFjQumhmucYncfl5rCPIxv8D5wDsIa5U8W0u
 dkVI/+j//t1y23DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A34651345B;
 Tue, 16 Aug 2022 13:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NsZVJR+V+2J6XAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 13:01:19 +0000
Date: Tue, 16 Aug 2022 15:01:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 Cyril Hrubis <chrubis@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <YvuVGOql4gIG4yju@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
 <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
 <YvpV8Iz+zVAhwvRv@pevik>
 <f7c6df02-3c39-ead8-2bbd-8cc26d36ff7f@fujitsu.com>
 <YvuEYiIq23D6/zw6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvuEYiIq23D6/zw6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

Hi Xu,

> ...
> > > +++ testcases/kernel/syscalls/mount/mount03.c
> ...
> > >   #define FILE_MODE	0644
> > >   #define SUID_MODE	0511
> Good catch, SUID_MODE must be 04511.

BTW reading https://lore.kernel.org/ltp/e043db5b-91cd-3e26-d6cd-32189c91518c@fujitsu.com/
do you suggest to use
#define SUID_MODE	0511 | S_ISUID

instead of this?
#define SUID_MODE	04511

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
