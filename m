Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABC0C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:05:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AE413CB82A
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 16:05:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1C853CAE69
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:05:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B829200934
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:04:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 016DF1FE0A;
 Mon, 13 Mar 2023 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678719899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qml8kVJ2wdkNcFhXMRz+jDPze0EVOkbZZo+phXl6Vxk=;
 b=IKIzllZwvE2d0Y/hnCsdGtU1rVOYZc2cw/5PQFidB1NyNR28K852RbqohOv3QNTiduSRd0
 c9AJC0sGCKjGHXoE7kOeylGcJrDuTMbRD7hTjdpAa6gM1zvnEqVXTqEINOErVwz8pmPfzo
 RXNdJZJJ1bSS/vSnCg+uZxcvIuO4eBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678719899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qml8kVJ2wdkNcFhXMRz+jDPze0EVOkbZZo+phXl6Vxk=;
 b=/C4XUwtzztpfP5YIfgMImxe+GnMURj0ROeX84RgtwaaMe5M9abkRNtbDQQepSVvj/oLB2r
 dIdKPk7hQOSRUbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4FA313582;
 Mon, 13 Mar 2023 15:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3d8bNJo7D2QJYAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Mar 2023 15:04:58 +0000
Date: Mon, 13 Mar 2023 16:06:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZA87677RI2ddqkJm@yuki>
References: <20230310124125.14279-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310124125.14279-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Move container utils to testcases/lib/
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
> Preparation for https://github.com/linux-test-project/ltp/issues/991.
> 
> NOTE: this patch conflicts with my other patch [1]
> (touching testcases/lib/{Makefile,.gitignore}).
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20230307145517.1359-2-pvorel@suse.cz/
> 
> 
> Petr Vorel (3):
>   ns_exec.c: Rename to testcases/lib/tst_ns_exec.c
>   ns_create.c: Rename to testcases/lib/tst_ns_create.c
>   ns_ifmove.c: Rename to testcases/lib/tst_ns_ifmove.c
> 
>  doc/namespaces-helper-tools.txt               | 14 ++++++------
>  .../ns_common.h => include/tst_ns_common.h    |  6 ++---

I'm not sure about moving this header into top level include, it would
probably make more sense to add it next to the C files that include it.

>  .../kernel/containers/netns/netns_lib.sh      | 22 +++++++++----------
>  .../kernel/containers/netns/netns_sysfs.sh    | 13 ++++++-----
>  testcases/kernel/containers/share/.gitignore  |  3 ---
>  testcases/kernel/containers/share/Makefile    | 22 -------------------
>  testcases/kernel/fs/fs_bind/fs_bind_lib.sh    |  7 +++---
>  testcases/lib/.gitignore                      |  3 +++
>  testcases/lib/Makefile                        |  2 +-
>  testcases/lib/tst_net.sh                      | 16 +++++++-------
>  .../share/ns_create.c => lib/tst_ns_create.c} |  5 +++--
>  .../share/ns_exec.c => lib/tst_ns_exec.c}     |  8 +++----
>  .../share/ns_ifmove.c => lib/tst_ns_ifmove.c} |  2 +-
>  13 files changed, 52 insertions(+), 71 deletions(-)
>  rename testcases/kernel/containers/share/ns_common.h => include/tst_ns_common.h (89%)
>  delete mode 100644 testcases/kernel/containers/share/.gitignore
>  delete mode 100644 testcases/kernel/containers/share/Makefile
>  rename testcases/{kernel/containers/share/ns_create.c => lib/tst_ns_create.c} (92%)
>  rename testcases/{kernel/containers/share/ns_exec.c => lib/tst_ns_exec.c} (91%)
>  rename testcases/{kernel/containers/share/ns_ifmove.c => lib/tst_ns_ifmove.c} (97%)
> 
> -- 
> 2.39.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
