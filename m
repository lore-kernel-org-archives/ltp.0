Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D8EECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 15:23:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 995B63CA727
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 17:23:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C7EE3C05D5
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 17:23:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE385200A1E
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 17:23:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AFB3220A1;
 Tue, 30 Aug 2022 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661873003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8/GWYjZX5LKOxiDBDQ4q9t8SZH36VCTeS+pWShA4HA=;
 b=vP2zu5DCRGrXfv7lHfIBNE1EunmMpV/8szPSWjAf+gxG8xCfRyD8EeL++eY79mw9AyHj8f
 ZcX8EgTniLgywmT2+Timh85ainRFhPrkaDRWdRKD6n3ZLKHz9RIrKsqL621mdMJwJ7tQkh
 vsEAjqX2S2xv6Onxfc9R7HqxGJS7xOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661873003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8/GWYjZX5LKOxiDBDQ4q9t8SZH36VCTeS+pWShA4HA=;
 b=XyIR3f9nF2zebsTYOhdO63IFgmp5CB7welYH2zRvgCoQsbLC9jdc/9JmjTFl/V50WEhmBB
 ljxZ8BXxO5LKM+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10AC913B0C;
 Tue, 30 Aug 2022 15:23:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E7/4AmsrDmPbNAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 30 Aug 2022 15:23:23 +0000
Message-ID: <78c5ee4c-6100-94ea-e2de-38f16f0d2b0f@suse.cz>
Date: Tue, 30 Aug 2022 17:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-5-mdoucha@suse.cz> <Yw4p4Id3mouqao0+@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Yw4p4Id3mouqao0+@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/10] ioctl_sg01: Set unlimited max_runtime
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

On 30. 08. 22 17:16, Cyril Hrubis wrote:
> Hi!
>> Test setup can take very long time depending on the amount of free RAM.
>> Set unlimited max_runtime to avoid timeout issues.
> 
> I would rather go for large enough number e.g. 30 minutes than
> unlimited as the unlimited runtime turns off the timeouts and such test
> can run undefinitely.

Even setting max_runtime is an ugly hack here because the test itself is 
nearly instant. The setup() function is what actually times out. But 
there's currently no way to change the default 30 second timeout 
allocated for setup() and cleanup(). It'd be much better if I could set 
that setup() has unlimited timeout and the test itself is limited to 5 
seconds.

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
