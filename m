Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F253DE7D27C
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 10:51:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E6233CDC91
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:51:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1BEB3C5AC7
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:51:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EFBE9200740
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:51:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 630AD2184B
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695725473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWlzMLg23/F73GS8J6HIva8s/tX64zAFFOTc6syl7TI=;
 b=cxeAmr4G3UI9XQs45/kSwIWyLmZIFnEWSMdCj6DUjJKtThQeOOWtJF6yuQbbkWGj0Ot5EK
 bOreMbASgyrFyVZEAKKMJt5F/LKQbiun16qoRKlGvibr1nmBjxmcu+6hv6P5Y+KhvR4NHQ
 jqm/eDVNhOCwvw2+O3XliTSiW0cH0jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695725473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWlzMLg23/F73GS8J6HIva8s/tX64zAFFOTc6syl7TI=;
 b=p4QHhMLdg+y7c8CXOHh6QDo5HSs2h9Sid4fN1ud4Hv1m0zkWNIB/VqGFYGkIomDtEaVhzC
 /S8Nd5KHZh+CqWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A4D113434
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 10:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /ABBEaG3EmX1WwAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 10:51:13 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 26 Sep 2023 12:51:12 +0200
Message-ID: <2307102.ElGaqSPkdT@linux-9lzf>
In-Reply-To: <20230926090101.7565-1-rpalethorpe@suse.com>
References: <20230926090101.7565-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] Add simple Alpine container
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Dienstag, 26. September 2023, 11:01:01 CEST schrieb Richard Palethorpe via 
ltp:
> Can be built with `docker/podman build .`. Then run with `podman -it
> run sh`. It contains Kirk in /opt/kirk. So `cd /opt/kirk && ./kirk -f
> ltp --run-suite syscalls` will run some tests.
> ---
> 
> Hello,
> 
> This builds and installs the LTP and Kirk inside an Alpine
> container. The idea is to use a standard container workflow to build
> and run the LTP from source. This helps with testing LTP itself and
> running tests inside a container.
> 
> I'd like to add some container files to upstream to help with various
> workflows.
> 
> The container has a number of problems:
> 
> 1. If the Git directory has build artifacts in it, these are copied
>    into the container (.dockerignore may help)

Doing an out-of-source-tree build might also help. Even just printing a 
warning/error in case the repository has already been configured might be good 
enough.

> 3. Where should we put container files and how should we name them?

Maybe just a subdirectory `container` and within that one subdirectory for 
each container.

> Also, for developing tests, it may be better to build the LTP outside
> of a container then copy in the files.

How would you do that? Relevant container-specific dependencies such as musl 
are within the container. One had to expose the container's filesystem tree 
somewhere in the regular filesystem and had to use that as prefix. That doesn't 
seem like an easy way of doing things.

By the way, to develop "[PATCH v1] Skip cgroup-related tests if `/sys/fs/
cgroup` readonly" I simply started on a fresh Alpine container, invoked our CI 
script for installing dependencies, followed the build instructions from the 
README, committed the container for later use and then just continued 
developing within the container as usual. (I was still using my editor from 
outside the container. So the clangd integration still assumed glibc headers. 
Maybe one could expose the container's filesystem on the host and change 
include paths via `.clangd` to prefer musl headers from within the container.)





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
