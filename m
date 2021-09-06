Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32157C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:40:25 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F360F92
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F8F360F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7EE83C708B
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 14:40:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A235A3C25E9
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 14:40:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B201B60084E
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 14:40:12 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07AAB1FEF2;
 Mon,  6 Sep 2021 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1630932012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XI6+hnOwLqPalQpsb9/49TDest25D0uKooCinjcX91Q=;
 b=abxSfZ2WUHoLtjeqUdW0d5AEfiNNxMrZFRK6wELVsgwi0P/VMxvG5r3IVqaB+KP1tlhROa
 EhhjZTHIODZI0MhHigafHyrW4XzES8PIt1yiN088kAKQSc4NLinwkJTAOU8tXf8+skYbn9
 7Vql08Caoke2Y7r4qleWbjwoXvWD0qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1630932012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XI6+hnOwLqPalQpsb9/49TDest25D0uKooCinjcX91Q=;
 b=yTIfnBDWIB2SFC5ZhaRz8C1YN1Px5LCmYCpR9KfJ3HYhabMHJjFOMWYPPiG7GrS0CKleU/
 RkniohVmkVheDMBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E8B4F1396D;
 Mon,  6 Sep 2021 12:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id ZaG3NysMNmFbNAAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Mon, 06 Sep 2021 12:40:11 +0000
Message-ID: <528952e4-bebf-617e-4d3f-0aea39797584@suse.cz>
Date: Mon, 6 Sep 2021 14:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
 <20210903154848.18705-4-mdoucha@suse.cz> <YTYH4DdeUqsYeglK@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YTYH4DdeUqsYeglK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] Add user/group ID lookup helper functions
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
Message-ID: <20210906124011.TW5uXkYLJQgdiSBZwjgdbPUW3Nn1d1d8heu9iDb2rx4@z>

On 06. 09. 21 14:21, Cyril Hrubis wrote:
> Hi!
>> +	if (!ret) {
>> +		if (errno) {
>> +			tst_brk_(file, lineno, TBROK | TERRNO,
>> +				"getpwent() failed");
>> +		} else {
>> +			tst_brk_(file, lineno, TBROK,
>> +				"getpwent() failed: end of file");
>> +		}
> 
> I'm not sure if "no more users in the /etc/passwd" should be reported as
> an error.

The alternative would be that pretty much every test that calls
SAFE_GETPWENT() in setup() will need to check for NULL and explicitly
call tst_brk(). I don't see any use for allowing SAFE_GETPWENT() to
return NULL outside cleanup().

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
