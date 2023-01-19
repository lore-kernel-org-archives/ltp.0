Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB074C00A5A
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 14:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9084D3CD836
	for <ltp@archiver.kernel.org>; Thu, 19 Jan 2023 15:56:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12CAF3CB45F
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 15:56:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A88A601C4A
 for <ltp@lists.linux.it>; Thu, 19 Jan 2023 15:56:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83AFA3EB50;
 Thu, 19 Jan 2023 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674140197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytx3hD4WZGfNLGEZSWv5TlLtzFH3KQGlNmXxsFUpuxQ=;
 b=TgTENaq1YpfIGSEbwcyX18R/RQ4gQoalEKI4rAXcgIFjjWkmOUoyPna6Dn6nvsPIiFKkv4
 ggMls4s/uRI2nLttbMVKCG6qkubZXKufStd71Y09vKLg3Rri3TWGl5I8ylZnyNRk8rKLw1
 4mTDgViPeP1al0xiluqkY07LTegZzKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674140197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytx3hD4WZGfNLGEZSWv5TlLtzFH3KQGlNmXxsFUpuxQ=;
 b=ZQJEXCV/Mr3j08x0QPQ0iUEvpU+JxDC1wuGctdGZbnzxItKMHkVN51c+qI4PtuEpZO2EDf
 wy9dGBtEz4WdXDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E00E139ED;
 Thu, 19 Jan 2023 14:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 80vxGSVayWNUNgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 19 Jan 2023 14:56:37 +0000
Message-ID: <6d8d9f5f-a37b-1925-16aa-8e9598286b0b@suse.cz>
Date: Thu, 19 Jan 2023 15:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230118133643.11371-1-chrubis@suse.cz>
 <37ee8021-c13b-c4a9-f27b-84f504800169@suse.cz> <Y8lWibGsvl1DzkXB@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y8lWibGsvl1DzkXB@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statvfs01: Correcly zero terminate the
 strings
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 19. 01. 23 15:41, Cyril Hrubis wrote:
> Hi!
>>>    	memset(valid_fname, 'a', valid_len);
>>>    	memset(toolong_fname, 'b', valid_len + 1);
>>>    
>>> +	valid_fname[valid_len] = 0;
>>> +	toolong_fname[valid_len+1] = 0;
>>
>> Is there a possibility that valid_len could be equal to PATH_MAX-1?
> 
> I do not think so, POSIX explicitly says that PATH_MAX should include
> space for terminating null character.

That's still true if valid_len == PATH_MAX-1. But we write valid_len+2 
bytes into toolong_fname.

But if always f_namemax <<< PATH_MAX, then we don't need to do anything.

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
