Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FA2C433F5
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:21:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FABF60F4A
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FABF60F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E36993C12AD
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 12:21:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C49B33C01FA
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:21:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC7CD1001431
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:21:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 34867201D5;
 Wed, 13 Oct 2021 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634120465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1z8j0zsbeBi8jPcmMN6Tx8tdDiACg5qw2alcuQfx50=;
 b=Y+39dOG5T5m2xlBcy8lIKC1xvwF56pcapxaENL14mpfYt6NVDFmMopdYQac83fmJKkIQ/L
 wRf/mHBcJfeyGQAfXrOC95z24967OUuf1tVh6I+PHzPRuPB9Z9eqVa/9rN9MLnMV563wSx
 3Eo/OClkv3XygTlCyRQsD93HsDqSTHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634120465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M1z8j0zsbeBi8jPcmMN6Tx8tdDiACg5qw2alcuQfx50=;
 b=+yrXdCL7CmOLrDEBWqiVlt77J51k7NE8taGkzYU7yB+jhW7/7wKoBuNQewhMVJsz7f3Zbc
 pvH8vrj4pd6z6ZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22A8213CEC;
 Wed, 13 Oct 2021 10:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yhK3BhGzZmGySAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Oct 2021 10:21:05 +0000
Date: Wed, 13 Oct 2021 12:21:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Anton Smorodskyi <asmorodskyi@suse.de>
Message-ID: <YWazOorfTyVsNQj+@yuki>
References: <19307e07-fee3-aaaa-b934-452917478a36@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19307e07-fee3-aaaa-b934-452917478a36@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getrusage04 issues on virtualized env
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
> I am running LTP tests in different public cloud providers ( Azure , GCE
> , Amazon ). Currently have issues with getrusage04 test on Azure . Looks
> like
> https://github.com/linux-test-project/ltp/commit/3e0ba9aa6a7c933a74d6525ca69028992a3ba1ad
> not behaves as expected ==> test is not actually skipped on Azure and
> failing because of known instability of the tests in virtual environments :
> 
> sh-4.4# getrusage04; echo cmd-exit-774-$?
> getrusage04    0  TINFO  :  Expected timers granularity is 4000 us
> getrusage04    0  TINFO  :  Using 1 as multiply factor for max [us]time
> increment (1000+4000us)!
> getrusage04    0  TINFO  :  utime:        2538us; stime:           0us
> getrusage04    0  TINFO  :  utime:        3813us; stime:        1906us
> getrusage04    0  TINFO  :  utime:        6317us; stime:        6317us
> getrusage04    0  TINFO  :  utime:        7407us; stime:        6317us
> getrusage04    0  TINFO  :  utime:        8849us; stime:        8849us
> getrusage04    0  TINFO  :  utime:        9587us; stime:       12783us
> getrusage04    0  TINFO  :  utime:        9637us; stime:       16062us
> getrusage04    0  TINFO  :  utime:       10709us; stime:       21418us
> getrusage04    1  TFAIL  :  getrusage04.c:133: stime increased > 5000us:
> 
> 
> I manually checked "systemd-detect-virt" execution on VM in azure and it
> returns "microsoft" as expected. Digging into tst_is_virt source code
> and around also haven't bring any ideas to me :(
> 
> Any hints how to follow up ?

I guess that we should skip the test if any virtualization is detected,
that should be done with:

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 06b576d79..318fa7ffc 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -197,7 +197,7 @@ static void setup(void)
 {
        tst_sig(NOFORK, DEF_HANDLER, cleanup);

-       if (tst_is_virt(VIRT_XEN) || tst_is_virt(VIRT_KVM) || tst_is_virt(VIRT_HYPERV))
+       if (tst_is_virt(VIRT_ANY))
                tst_brkm(TCONF, NULL, "This testcase is not supported on this"
                        " virtual machine.");


Will you send a patch to ML or should I do so?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
