Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E0CC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A3093C9716
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:39:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5F3C3C96DE
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:38:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBB4810009FB
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:38:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF1D621979;
 Fri, 21 Jan 2022 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642772329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFQzOQplrycUZZR/6wjNxGYP+e3KdGNfA0nwB71IzPM=;
 b=z1XmmJdQMLVzHp/VsxpmEJbyJivXVVs7h+GBbQdbFyCreJfBV0a6ymmdsJ5hUVtyG92S5+
 hSnGOyaRxsp5rvJzXPmnzZ4p0Go8JUXkA0MNRgE8r73tqyMMiqb5I6hgeMSvGQy4BnnbYu
 UVSXkWka8NMdji2Eu6vaaq4wJP1WyVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642772329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DFQzOQplrycUZZR/6wjNxGYP+e3KdGNfA0nwB71IzPM=;
 b=Srlu8sNTojwDEYe5oiTe3BsJhZbHbMNGetfK7tLSJKdD3GKZfm0Zrt6o/OEKOsNMlSZiwf
 yXNhOGYnhzr6nUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA21C13671;
 Fri, 21 Jan 2022 13:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y9mQL2m36mFjTwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Jan 2022 13:38:49 +0000
Message-ID: <5988d540-ce29-d210-365e-7e5efa91b547@suse.cz>
Date: Fri, 21 Jan 2022 14:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220121103011.6266-1-pvorel@suse.cz>
 <4508acbd-3ca2-b1b4-ff38-6ffa573aa6fd@suse.cz> <Yeq2KeBX5/04d01m@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yeq2KeBX5/04d01m@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] aiodio: Set timeout 30 min
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

On 21. 01. 22 14:33, Petr Vorel wrote:
>> Hi,
>> only dio_sparse really needs higher timeout because we use it for a slow
>> stress test in a runfile. dio_read should get a lower default number of
>> child processes instead (8 or 16 to keep the default memory requirements
>> under 512MB).
> Thanks!
> 
> I also noticed dio_read, but as you pointed out it's already fixed by
> f3caabe44c ("Reduce memory footprint of the dio_read test")

Runfile usage is fixed but running the program manually with default
setting would still result in extreme memory use. We should make the
defaults more sensible as well.

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
