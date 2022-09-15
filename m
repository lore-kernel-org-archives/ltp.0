Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5476C6FA89
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 14:09:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E243CAC47
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 16:09:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 966063CA504
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 16:09:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B486E200E08
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 16:08:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97B811F8E7;
 Thu, 15 Sep 2022 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663250938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqvNkM/KflG8ldB/2XERZQWUaUhCFZ2WCF7GIIGrdp4=;
 b=OY0muehYP6ZCGmm97W/0uoBNyk0a4a7ctZe5NPJHKyWWF678IZPXdlJFHwmSVKa09zTp/6
 Lzy15uTiEOnrs+U+RlZB/SwdTe8HlLKl4CPol45zbRDbmRBtCTu9AgBFqoQWle9CvWXbLQ
 nF0X2RY0S790bcJl6LyZf4dvPd0ixbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663250938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqvNkM/KflG8ldB/2XERZQWUaUhCFZ2WCF7GIIGrdp4=;
 b=RzTqUzQM9PNvjnrQ4g5pY2XqFUgokFxGs3GVfFJWBCnX5ByENgnSKUb91jZ4jLD1qVD4vU
 HcmdRxBMd0Ykz8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83758133B6;
 Thu, 15 Sep 2022 14:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HqYGH/oxI2PVcAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 15 Sep 2022 14:08:58 +0000
Message-ID: <4bfb03f3-d508-84c4-d7dd-d10234bc0e98@suse.cz>
Date: Thu, 15 Sep 2022 16:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-5-mdoucha@suse.cz> <YyMuR7825dIOUC6R@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YyMuR7825dIOUC6R@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] readahead02: Add max_runtime
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 15. 09. 22 15:53, Cyril Hrubis wrote:
> Hi!
> Pushed, thanks.
> 
> I guess that for the rest of the problems we should open an issue so
> that we do not forget. Or do you plan to continue working on the test
> after the release?

I'm planning to go back to ULP and KVM tests after release so feel free 
to open a new ticket for the other suggested improvements.

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
