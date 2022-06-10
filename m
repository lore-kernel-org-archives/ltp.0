Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F356CC43334
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 14:42:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CFC53C9264
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 16:42:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43C03C9002
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 16:42:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 61A3B601922
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 16:42:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94A9C2214F;
 Fri, 10 Jun 2022 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654872161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTWHNn8vjDnDZB+p7hSckd5CzmJyEtn21Okxl6C7ioc=;
 b=GyTh95dKgJdkybZcMuFqWuxTW949lS67h4BJg6/4OgPIXJbUMwhd5RPTAUck4S3G0ZSrma
 9D/KYfmMEa3b5+q4lSTowDnCxhD70GaXiq1g1LZ1OP7Q39kCNLKuUs+6UmiYi4jfIqIdvU
 PX7u/dcD0vPccWVd0cVjdJFJGob7lKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654872161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTWHNn8vjDnDZB+p7hSckd5CzmJyEtn21Okxl6C7ioc=;
 b=FvHfv3YgZ12G6qiDjdR0HOjdbfp+1te3nfCK5DaWY+aEV/57FvxX1XkUnXe8rPCwsExI8Q
 +dHM6SQNosOJZEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8158D139ED;
 Fri, 10 Jun 2022 14:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ACNMHmFYo2K7aQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 10 Jun 2022 14:42:41 +0000
Message-ID: <156915a0-cd2b-e6b8-1b7c-273c67911d4b@suse.cz>
Date: Fri, 10 Jun 2022 16:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220610131442.5032-1-mdoucha@suse.cz> <YqNIIb/NFVBjsZdb@rei>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YqNIIb/NFVBjsZdb@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure: Check for KVM linker script support
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

On 10. 06. 22 15:33, Cyril Hrubis wrote:
> Skipping the whole directory will actually cause problems too, since the
> runltp files does include the kvm_pagefault01 now which will obvious
> fail because the binary would be missing.
> 
> I'm not sure what the best solution would be, maybe install dummy
> libraries that just print TCONF in a case that linker does now work?

KVM tests have their own runfile which can be simply skipped. These
tests should not be included in any other runfiles because they should
only be run on baremetal. That's the solution: Don't run the KVM runfile
if the KVM tests were not built.

Also, the KVM Makefile already builds nothing on non-x86 archs so the
problem was there from the beginning.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
