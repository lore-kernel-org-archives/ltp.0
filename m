Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20701C433EF
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 14:12:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 500E73C6B59
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 15:12:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A161A3C07C1
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 15:12:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37F0B601104
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 15:12:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 479ED1FD2F;
 Wed, 24 Nov 2021 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637763153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APC3tCTPsFSHMtpmDjAR4m8pAL3DiEmrc5nu8Od67BY=;
 b=ntehok+qomEvl91bIArxXGcr11J6c/JO3rGbFPP2Au4bxW5Jl0OpLp70y1q6/yvYlTIdx2
 H1UzkjpUdNJEqGz3pauZ3U85zLnQv1oFB87zeT3ki1zxBFilk5ZyhgEUKcTpBnm8ANOz2D
 Fvc9qgolTa+lSk1sTJTixqj1NNlTaHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637763153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APC3tCTPsFSHMtpmDjAR4m8pAL3DiEmrc5nu8Od67BY=;
 b=cSrAy765iKLbbp88E4fEOUPBmUSJlbNXMe86cpb6PtddgCxazXCePO7/7qMo1kPywnJdRb
 klqCzCKXjIvfShCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2605913F26;
 Wed, 24 Nov 2021 14:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DdDJB1FInmHFXAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Nov 2021 14:12:33 +0000
Message-ID: <69812961-2e53-c80d-7b5a-b37305215149@suse.cz>
Date: Wed, 24 Nov 2021 15:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, Petr Vorel <pvorel@suse.cz>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
 <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz> <YZ4LAN2RrJntGlFq@pevik>
 <8b239e34-14cc-dfab-cdf4-bec9148a3a42@bell-sw.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <8b239e34-14cc-dfab-cdf4-bec9148a3a42@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

On 24. 11. 21 15:07, Alexey Kodanev wrote:
> Hi Petr, Martin
> 
> Overall the new test looks good, and I would only replace the old style
> command substitution count=`ls ...` with count=$(ls ...).

Good idea.

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
