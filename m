Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79729C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 12:45:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D9F23CB072
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 14:45:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 229533CA7C2
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:45:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6ABD31000944
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 14:45:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23AB5205DC;
 Tue, 18 Oct 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666097108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aK4CScra7xcTe4Lnue49fjUzOgQd1DrOxHN9d+C6jkM=;
 b=2JEOIpnUPlWjq7zKBi4+Ej72fwunNesJVTWcE405fTQNdlYJAvqQ0UCfj8FegRrJqyRD8A
 AqBrV8HEnp6DbiIsXPXbRU7oW+bgxocDLSMPSDyHsBsQYPR8tvpIPKNu40byExmQtzF7yq
 gs4bqv7wbufQb2yHEKAbpnwijkTKsEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666097108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aK4CScra7xcTe4Lnue49fjUzOgQd1DrOxHN9d+C6jkM=;
 b=2TcMn49X6hmUTJSygfeC3g8tnE4bL3CbwCJ4D+xv4zlzLiHZmoKgdGbwCE6/YJDQbiu1bU
 CrOv9tqPlqBq1sBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0E4C139D2;
 Tue, 18 Oct 2022 12:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oXRkKNOfTmODfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Oct 2022 12:45:07 +0000
Date: Tue, 18 Oct 2022 14:45:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y06f0WK4CeabqTIi@pevik>
References: <20221018032203.3429895-1-liwang@redhat.com>
 <87bkq9mryj.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkq9mryj.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pthread_barrier_init: remove the restrict limit
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Acked-by: Petr Vorel <pvorel@suse.cz>

> Hello,

> Li Wang <liwang@redhat.com> writes:

> > The restrict keyword tells the compiler that a given pointer
> > does not alias any other pointer in the same context. But this
> > is only supported by C99.

> > To make older platforms compilinng LTP successful, we have to cancel
> > that limitation in function definition.

> > Fix error: https://github.com/linux-test-project/ltp/actions/runs/3263823142/jobs/5363481739

Fixes: f55cb14ca ("syscalls/nice05: Add testcase for nice() syscall")

...
> > Notes:
> >       I also considering adding "-std=gun99" for compiling the whole library,
> >       but not sure if this could bring a bigger potential impact on
> > LTP.

> It would be nice to at least use C99, but I guess we can wait a bit
> longer until centos7 is EOL.

Exactly.
Also LTP is used by others on embedded, which might still have old toolchain
(although C99 as the default is since gcc 5.x [1], I'm not sure if anybody
really uses gcc 4.9.x [2], we could ask on automated-testing ML after 2024-06 -
CentOS 7 EOL).

Kind regards,
Petr

[1] https://gcc.gnu.org/onlinedocs/gcc-5.5.0/gcc/Standards.html
[2] https://gcc.gnu.org/onlinedocs/gcc-4.9.4/gcc/Standards.html


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
