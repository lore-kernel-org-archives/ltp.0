Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8386BC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 13:54:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B088960EBA
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 13:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B088960EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D088E3C9195
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 15:54:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2B733C22CB
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 15:54:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBAAE200E1D
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 15:54:32 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E35E20157;
 Wed,  8 Sep 2021 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631109272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNpYXvglspGAGZiR1CDRGLT46JIKAYa7ZMiT0ly0fio=;
 b=d8aMRJlRFdmr8W9NeimouuNAmNCaT6Ys/Rz1xa64DjOvIE/HelcR0vZJykvh/GYbNSNRjq
 R13pV6w5jUpFqphvy5UhfW6rELwQMxKgZzsvMzSmag/v3kk+dv10a7cvl03o0sBQ24kzPP
 ixUdn5G6c1VC1NcCHhusgnZuXUJh394=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631109272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNpYXvglspGAGZiR1CDRGLT46JIKAYa7ZMiT0ly0fio=;
 b=Vw7qrx8drGyzeU2YouVUWjPHSg8VOTxwIEed84JEc31VIpWcXh2eh/UAaddmIX848rgYcj
 Z6en3eOfcVu7IHCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3468313A94;
 Wed,  8 Sep 2021 13:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id tJV3C5jAOGGHKwAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Wed, 08 Sep 2021 13:54:32 +0000
Message-ID: <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
Date: Wed, 8 Sep 2021 15:54:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YTi8qQOZU3NriZvZ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
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
Message-ID: <20210908135431.oprNtwKWiW6y1Z8qkoMlyJ27jW4ursx3DAWoksGXxkk@z>

On 08. 09. 21 15:37, Cyril Hrubis wrote:
> Hi!
> I guess that this is another bug that should be fixed before the
> release. I still think that the memory pollution is a best effort
> operation and that we should be more conservative with the reserve. I
> would go for a few percents of the free memory just to be extra sure
> that we do not cause memory pressure.
> 
> If we go for 2% we will add following;
> 
> safety = MAX(safety, info.freeram / 50);
> 
> Also it looks like info.freeram is the same as MemFree: from
> /proc/meminfo, I guess that this is not wrong, since memory that have
> been used in buffers is dirty enough for our case.

I'd recommend dividing by a power of 2 (either 32 or 64) but other than
that, I completely agree.

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
