Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8FDEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:28:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA8213CACE7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:28:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C48F3CAC32
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:28:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B09576008FA
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:28:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB589218BB;
 Tue, 20 Jun 2023 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687249691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPuZe6DvpEWN1nI5CU3BqRnc+dHG7SGRBFizSD5CsmM=;
 b=2OcgeeuEOJa0zc38P+a90pONh6QUfx88GPDb2fXsI5LtGMNlKffDKF8KOy4kVZuhoXiTaT
 u/hZDiLrcDpL2QlmzhzMVrL431jApBMMNon9cZOQ89L/Ydklv3KKfkcizyMAE77AiETGbz
 icoD6vmJkyzKQb4fixNY1cV8O/o0Ppg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687249691;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPuZe6DvpEWN1nI5CU3BqRnc+dHG7SGRBFizSD5CsmM=;
 b=cFmRAAlO8BQRavzd2X0/WFC5oyfyz3J53uthGFIb43fzxxHk2zUSdxkCfgS+PmkWq2yL3S
 elxJ8whDtxy6QjDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB97B1346D;
 Tue, 20 Jun 2023 08:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7KrNLxtjkWSaHAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 20 Jun 2023 08:28:11 +0000
Message-ID: <666f5cd5-5f03-95b3-0b33-6e104fd58744@suse.cz>
Date: Tue, 20 Jun 2023 10:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Petr Vorel <pvorel@suse.cz>
References: <20230607144517.24972-1-mdoucha@suse.cz>
 <20230620082442.GA270877@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230620082442.GA270877@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/madvise11: Ignore unpoison failure under
 kernel lockdown
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

On 20. 06. 23 10:24, Petr Vorel wrote:
> Hi Martin,
> 
> ...
>> -	return SAFE_OPEN(debugfs_fp, O_WRONLY);
>> +	TEST(open(debugfs_fp, O_WRONLY));
>> +
>> +	if (TST_RET == -1 && TST_ERR == EPERM && tst_lockdown_enabled()) {
>> +		tst_res(TINFO,
>> +			"Cannot restore soft-offlined memory due to lockdown");
>> +		return TST_RET;
>> +	}
>> +
>> +	if (TST_RET == -1)
>> +		tst_brk(TBROK | TTERRNO, "open(%s) failed", debugfs_fp);
>> +	else if (TST_RET < 0)
>> +		tst_brk(TBROK | TTERRNO, "Invalid open() return value");
> nit: I'd print the return value as we do in safe_open():
> 		tst_brk(TBROK | TTERRNO, "Invalid open() return value %d", TST_RET);

Good point. Though TST_RET is long int so it should be %ld. Should I 
send a v2?

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
