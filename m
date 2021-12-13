Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F1DC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:59:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3569A3C8C62
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:59:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 960523C0BA7
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:59:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8614C60009E
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:59:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 081A821127;
 Mon, 13 Dec 2021 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639414746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHrYS7N4mqt4CHcTYR1Axy6DjWbhNZeT9PPflaqFR1I=;
 b=JkzivEJeqNWYqg61hoQqk/ErrxvQttxE/aOY+x3hNLq0kAc1GjpRqzTRz4XBMasLiQJZM4
 Dr1Pg3DLHY+pCxJauG38R6dtzMVgAqgdWTcvyfZ3iEe+44qSGwZ92Lo4DLzYkb5OncIsG9
 Fu8fv5b42nW2WmErVkxRqFvuJRk3PDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639414746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHrYS7N4mqt4CHcTYR1Axy6DjWbhNZeT9PPflaqFR1I=;
 b=LobYnnmJSoQCSXGWEbmqC1UEE4c6CPNcqIpPRKH67b1/CooPNWP0docfZfQbRw3eEbnWe4
 6E5x823w6pg5WjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAC2D13E47;
 Mon, 13 Dec 2021 16:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v380NNl7t2GraQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 13 Dec 2021 16:59:05 +0000
Message-ID: <771fb3e4-06be-1d08-9036-b35feed14128@suse.cz>
Date: Mon, 13 Dec 2021 17:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
 <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz> <Ybdxt/KBUQ6ZKHmY@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Ybdxt/KBUQ6ZKHmY@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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

On 13. 12. 21 17:15, Cyril Hrubis wrote:
> Hi!
>> I'm afraid it won't be that easy. The main cause of OOM killer going
>> postal and killing processes with tiny memory footprint is that a
>> process executing the mlock() syscall cannot be targeted by OOM killer
>> at all. That's a known issue in the kernel with no easy fix.
> 
> This is only single test out of at least 10 that can trigger OOM, right?

All 5 oom* tests in the mm runfile have mlock() subtest. All of them can
end up killing the whole userspace by accident. And all of them
regularly do so in our automated test system.

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
