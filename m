Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4AC77B73
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 11:31:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CBEA3CEFCA
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 13:31:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 927473CAC01
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:31:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF88010009B8
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:31:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A06FA222BF;
 Wed, 24 May 2023 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684927897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhtheA/Gzw9ZBNNVZW5R7hvu64pufOsIiq+9Wxeew6w=;
 b=yaEmWV91uf9kFNZVSdwCR4ztkwEzW569EA78TK2s1YpmSCk2G/OcFo4QTL+cl4r99DaM9D
 GUUAJMXFpG52ncpystMX4EUZixq4KVqQcHdQ9tH9PUPiiJtoSV5nQL9hHWhyZgBVeOXnVF
 3C8piEzc8ZspkJSibAR5EWqKQmzCmhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684927897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhtheA/Gzw9ZBNNVZW5R7hvu64pufOsIiq+9Wxeew6w=;
 b=IWt0IOG3fSUbfiZwva2e35cH8bCx65a6TP4dEfu5vqXHyWpU94jKn5TXlqBtiPMBWZ6Wqo
 bHlt31ywkP0EXEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 818D7133E6;
 Wed, 24 May 2023 11:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nmgMHpn1bWQDRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 24 May 2023 11:31:37 +0000
Date: Wed, 24 May 2023 13:32:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <ZG3130X0GO9eNJfc@yuki>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
 <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: syscalls: statx06.c:138: TFAIL: Modified time >
 after_time
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > [ 1192.088987] loop0: detected capacity change from 0 to 614400
> > tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> > extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> > dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> > mode: none.
> > tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> >
> > statx06.c:140: TPASS: Birth time Passed
> > statx06.c:138: TFAIL: Modified time > after_time
> > statx06.c:140: TPASS: Access time Passed
> > statx06.c:140: TPASS: Change time Passed
> 
> I found a description in
> 
> https://lwn.net/ml/linux-kernel/20230503142037.153531-1-jlayton@kernel.org/
> 
> which indicates that this is expected. Added Jeff to Cc in case
> I'm misreading his explanation.

We even have in-flight patch from Jeff to fix the test with fine-grained
timestamps in LTP:

http://patchwork.ozlabs.org/project/ltp/patch/20230518113216.126233-1-jlayton@kernel.org/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
