Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B535C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 14:10:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB1D03C6D1F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 15:10:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FB043C1B97
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 15:10:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E51591A00141
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 15:10:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C20C21106;
 Thu, 10 Mar 2022 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646921411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTgjynAaZ/R3KF/e6zZWPWXoKgjKVx6B4TgzocUv7rU=;
 b=cGBNel7WlXCAQAhvCRyMg6gDxBs17B+zXYpy5ggisUiWyU7ytuftpcW8IX5P9rKXJ2a+JF
 lvihJdHShUETnXuPfLx6XEZuuOFK4MsY+d2es5pxf2ZK8EQi8SE6na7FhhsB5lLZjgZCbf
 Z48t9GwX4cjZTAoEq0j5IPZHzTgT4Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646921411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BTgjynAaZ/R3KF/e6zZWPWXoKgjKVx6B4TgzocUv7rU=;
 b=/EDPREjLc9mVqHDq5Ft3oDqrGoKNnAvkyYOgTTwiyaBzauElpcE69Xl6BkRtjLwPiIoehF
 UU+gKMkPlkYnopDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E809113FA3;
 Thu, 10 Mar 2022 14:10:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id emzNN8IGKmLhVwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 10 Mar 2022 14:10:10 +0000
Message-ID: <5e9807b7-3b41-8408-42d2-dffaa71741e1@suse.cz>
Date: Thu, 10 Mar 2022 15:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220309164954.23751-1-mdoucha@suse.cz> <Yij8XwFjK3Ua+jYA@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yij8XwFjK3Ua+jYA@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] KVM test infrastructure
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

On 09. 03. 22 20:13, Petr Vorel wrote:
> Hi Martin,
> 
> this patchset looks really great.
> 
> Unfortunately there are some compilation time errors [1]. Various
> Debian/Ubuntu versions (but not all) and Alpine have problem to
> compile it [1]: /usr/bin/ld: bootstrap_x86_64.o: relocation
> R_X86_64_16 against symbol `kvm_gdt32_desc' can not be used when
> making a PIE object; recompile with -fPIE
> 
> Can you please have look into it?

Can you try whether this one-liner fixes the error? The diff will
probably get corrupted by my mail client because GUEST_CFLAGS is too
long but it's trivial to apply this by hand:

diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
index 139358961..24ca91fc3 100644
--- a/testcases/kernel/kvm/Makefile
+++ b/testcases/kernel/kvm/Makefile
@@ -9,7 +9,7 @@ ASFLAGS =
 CPPFLAGS += -I$(abs_srcdir)/include
 GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
 GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables
-mno-mmx -mno-sse
-GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
+GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none,-no-pie
 GUEST_LDLIBS =

 FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86

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
