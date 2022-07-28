Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0BC04A68
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 11:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBBD53C4CA9
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 13:49:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4513C2A24
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 13:49:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99C1B600D2B
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 13:49:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E33B33FB7
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659008956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vh6ipDw1zMPtK7VUZE4MjHMBCFk897r9GCDspKnulDo=;
 b=mFOZY5bh7KFDIALAJ1OfqSB1j7GYRolNSJkvxpPnyaGWbXa4Nj4oJ48Qi7EA/FT2gzNdcx
 9pZQ74tefnlATWCt1YvE+B06Z3kqU4p+vXgUAuFV8GlZ6LwpLgcBP+lKcpwKJ3JTRjv2fl
 wAKtEAl4jWXm6au1YA6jIx+/7bRYVlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659008956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vh6ipDw1zMPtK7VUZE4MjHMBCFk897r9GCDspKnulDo=;
 b=b7UqGOuveg+f3+20OT7Zk9PcYFNpD4HsBrcUFmTVNHeY7Dq7EOZCvopR01bEARLovWqqzx
 FBuT4q4oI5EKjkCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F82E13A7E
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 45o8Grx34mILFgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:49:16 +0000
Message-ID: <b2ff91ff-d65c-325c-c07e-18dcc5fe1805@suse.cz>
Date: Thu, 28 Jul 2022 13:49:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
References: <20220728114258.30832-1-mdoucha@suse.cz>
 <20220728114258.30832-2-mdoucha@suse.cz>
In-Reply-To: <20220728114258.30832-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_rod: Fail on directory change commands
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 28. 07. 22 13:42, Martin Doucha wrote:
> Using tst_rod to check directory change success doesn't work. The command
> gets executed in a subprocess and will have no effect on the parent
> shell where the directory change is desired.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

Beware that this patch will cause a lot of broken shell tests to fail.
Another patchset fixing the incorrect ROD usage in shell tests is needed
before merging this patch.

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
