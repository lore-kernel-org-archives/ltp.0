Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79733ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:49:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 233B33CAC01
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:49:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96C283CA9C6
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:49:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA120600075
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:49:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10D5722066;
 Wed, 14 Sep 2022 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H5ntjVfcDyj/Yhc3ygkpMJF8B/9QpRfc5wlnU/71QU=;
 b=m9sZQvmUSwy+6+Np03LiTEHRyp0Mp9Fync5pC6YZAiyqaYoqtFUFEzY8bt7U7sOlbORZJe
 4c9PAtOG9bW67pZmEeGGgFPW9zOOn9H5WJ14+ju/d5VxkOtlBVoWhSlB6d7oJs4W+4A+7S
 BRI6+ldHQ3ZNUHqOsy/0P9vqe0x0x8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148969;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H5ntjVfcDyj/Yhc3ygkpMJF8B/9QpRfc5wlnU/71QU=;
 b=Sz3x6ve0aP6qVLPeEx0xxp66quck9JubMiGqin0m/EhcSfgZaDGvknAJF4EieqVEUuhGix
 PqLKenr8VNrUskCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1578134B3;
 Wed, 14 Sep 2022 09:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eubmOaijIWNcNgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 14 Sep 2022 09:49:28 +0000
Message-ID: <74d06a26-2ca3-f0e4-7c1f-88f3d637d209@suse.cz>
Date: Wed, 14 Sep 2022 11:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-4-mdoucha@suse.cz> <YyGg8VilN9Jhv1lQ@yuki>
 <a6fbe570-109d-a7f8-1a56-99791fcdd7b4@suse.cz> <YyGjt23DZS8M4Ryx@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YyGjt23DZS8M4Ryx@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] dio_sparse: Fix child exit code
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

On 14. 09. 22 11:49, Cyril Hrubis wrote:
> Hi!
>>> Ah, this is the fix. I would go for tst_res(TFAIL, ""); and return 1;
>>> otherwise this looks fine applied over the previous changes.
>>
>> If I returned from io_read(), I'd have to rewrite the calls in
>> dio_sparse.c and aiodio_sparse.c to exit(io_read()). Otherwise testrun()
>> in LTP library would always force the exit code to 0. This is less work
>> and you won't need to remember LTP library implementation details when
>> you reuse io_read() in a new test.
> 
> What about tst_res(TFAIL, ""); followed by exit(1). Really this is a
> case where the test does fail we and we should report failure properly.
> Or even just exit(1) as we do check the exit value after your changes.
> 
>> Should I send a v2 for tst_validate_children() or will you delete the
>> if(WCOREDUMP()) branch and merge it now?
> 
> Is there a good reason why you are trying to avoid tst_strstatus() that
> simplifies the whole inner body of the loop to a single if?

OK, I'll send v2.

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
