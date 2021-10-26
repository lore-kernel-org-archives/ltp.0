Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD9CC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:55:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4DF60F22
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A4DF60F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDD183C67EC
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 09:55:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9FE73C6639
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 09:55:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 604341401328
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 09:55:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B8CA1FCA3;
 Tue, 26 Oct 2021 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635234930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIWBbXQIBGg993Uq2B3DOlbCJ93CCrpPqooECkM5Ue8=;
 b=VgyGnSU2EonqPhkAUHiW6mHRRUVlhrnM7k5rH4exjjetIBgzRUHFcEndL4Sx2eo2UxGejx
 8tZlwgI8erJKMEE1K9q4qbGpiawyp5osTqF2xUGW3gsTL/ugkNDMeodud/npqp3sohl9Xx
 x9KvuT6IMglpVVL6YPi1DyioLNdrLog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635234930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIWBbXQIBGg993Uq2B3DOlbCJ93CCrpPqooECkM5Ue8=;
 b=9nYnn36SmJ4Eepue4faRF28YGgdm+8p4xG7SgnHc/Ww3WcHVjePG/WzGQOcEal9zG6s6W1
 3JHRiZoxtJ1zd/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A39713AA2;
 Tue, 26 Oct 2021 07:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jJ4vGXK0d2FESAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 07:55:30 +0000
Date: Tue, 26 Oct 2021 09:56:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YXe0owmFqLAYkJwo@yuki>
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-7-chrubis@suse.cz>
 <CAEemH2dQcUW5k3Rv-n3=CrznqwpFta3P28QrB0oVZPZH6PyNuw@mail.gmail.com>
 <YXeqxPwYuAVvrMdv@yuki>
 <CAEemH2eGMNYRDo8drkEesqqBG1HfNAX2O=WPenCa1W0v-S-Lmg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eGMNYRDo8drkEesqqBG1HfNAX2O=WPenCa1W0v-S-Lmg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] lib: Add tst_set_runtime() & remove
 tst_set_timeout()
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes, that should be great.
> 
> After a quick reviewing the whole patchset, I feel that .timeout is
> redundant since .max_runtime can do more thing to totally replace
> it by the end.

Agreed.

> ----------------
> 
> Btw, it looks weird to simply double the runtime by plus MAX(10u, runtime)
> in the runtime_to_timeout, I guess you probably just wanna another
> 10sec for some reclaiming work.

The exact formula is up for a discussion, but I do not think that we
should make it too tight, it's just a safety that is not going to be
triggered unless there is a real bug.

> And the .max_runtime is also maximal time per test iteration,
> but from the output below misleading me to think it is for the
> whole test time.
> 
> See:
> 
> # LTP_TIMEOUT_MUL=1 ./pty03
> tst_test.c:1376: TINFO: Test max runtime 360s
> tst_test.c:1371: TINFO: Timeout per run is 0h 12m 00s
> ....

Ah, right, that should be fixed. Anything else that should be fixed?

Also once we get this merged as well as the preprocessor support for the
metadata extractor it's going to be fairly easy to write a short script
that parses the metadata and then prints overall test runtime given a
test name, which is what I'm going to send once these two patchsets are
merged.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
