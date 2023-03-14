Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7FC6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 08:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B299F3CD4ED
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 09:16:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B607E3CACD8
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 09:16:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32DCE2009DA
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 09:16:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF6EB21884;
 Tue, 14 Mar 2023 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678781781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qTkd0UEr/lP0ALqN4W+sJpTjHqw+Ggg7nopeRXPGSPk=;
 b=ERUtKAW2wavsF2ZSunb9Dmkq9oDSfTZIASofPkFNzAOQ6avpGcEqaBMq/hrusQgiFfgMZT
 jwdu0ELIgz4zJJaqOEk+CYlwIEK9zteojvXbsrH2Aubx6PjB37Ji6XkYW7H7FZ798hs7mH
 7420rsoeh/VjuxKOXnSWouHSjIIRDrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678781781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qTkd0UEr/lP0ALqN4W+sJpTjHqw+Ggg7nopeRXPGSPk=;
 b=HYodHXdSsX3KITSplo/+ACkcSYjEc60LNCO/pBLXHPXSgyMEG4gXABzXqxtcml2lJd1/K+
 L1y5fnpCfES0reAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B939313A26;
 Tue, 14 Mar 2023 08:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id goVkK1UtEGQxPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Mar 2023 08:16:21 +0000
Date: Tue, 14 Mar 2023 09:15:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZBAtCbeSVH0/l137@rei>
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com> <ZA7qq15aeKS+ZeJR@yuki>
 <20230313122100.GA12608@localhost> <ZA8Y+O7QFfVB0/62@yuki>
 <20230313134624.GA9783@localhost> <ZA8t7hVYRmF+I9k0@yuki>
 <20230314053151.GA22202@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314053151.GA22202@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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
> This is caused by "_" and "-", current search function not do this tricky translate part.
> Input parameter is hwpoison_inject but actually string in modules.xxx is hwpoison-inject
> 
> /lib/modules/5.14.21-150400.24.41-default/modules.dep | grep hwpo
> kernel/mm/hwpoison-inject.ko.zst:
> 
> Other info just FYI:
> //modprobe can accept both "-" and "_"
> localhost:/home/ltp # modprobe hwpoison-inject
> localhost:/home/ltp # modprobe hwpoison_inject
> 
> //get info from lsmod and /proc use "_"
> localhost:/home/ltp # lsmod | grep hwpo
> hwpoison_inject        16384  0
> localhost:/home/ltp # cat /proc/modules | grep hwp
> hwpoison_inject 16384 0 - Live 0xffffffffc09d6000

Sounds like a bug that shoudl be fixed, we probably need to create two
search strings, one with dashes and one with underscores and try to
strstr() both.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
