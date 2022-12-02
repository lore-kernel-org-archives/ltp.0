Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B77C4321E
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 13:22:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 876C43CC411
	for <ltp@archiver.kernel.org>; Fri,  2 Dec 2022 14:22:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AF2D3CC3C4
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 14:22:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C22F6317180
 for <ltp@lists.linux.it>; Fri,  2 Dec 2022 14:22:12 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B8E11F88C;
 Fri,  2 Dec 2022 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669987331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a1oWMhLZnUvKOAY7S48rTIezb3UtEnmeVmm7XGUa5Q=;
 b=FpabqQvNxiLKzCu5LwaA+Z0HAKdypIclMi575Q5bjEL3wQlOY3RjTAi8YDD4kqrlAdcCJZ
 /wnT60vt87piYphws00T3pyXKu9vlS8BXur05GSZrc82D9fq/PFdTNUZNKm9/VuICUL0H8
 gGd9iQX5XSBmYdiPXaTWYNsTVPufbCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669987331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3a1oWMhLZnUvKOAY7S48rTIezb3UtEnmeVmm7XGUa5Q=;
 b=0glDO7B87SBaMhxw3nIH8cjzU4apuWTJfUwD/L/IYOnY3kDrtH5ua+juVpRoEHl1fW1leJ
 2Y4DkIKBCc8sqTBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 883BA133DE;
 Fri,  2 Dec 2022 13:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id v9NPIAP8iWOvSQAAGKfGzw
 (envelope-from <mdoucha@suse.cz>); Fri, 02 Dec 2022 13:22:11 +0000
Message-ID: <4ac60d63-7105-4069-5a3a-1fecff4bdd03@suse.cz>
Date: Fri, 2 Dec 2022 14:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20221202114205.11077-1-mdoucha@suse.cz> <Y4nxfJrxPQ6AiTFI@pevik>
 <Y4n5Es6nvz8oe+I1@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y4n5Es6nvz8oe+I1@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2017-16939: Improve and fix test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 02. 12. 22 14:09, Petr Vorel wrote:
> Hi Martin,
> 
>>> +++ b/testcases/cve/cve-2017-16939.c
>>> @@ -29,50 +29,63 @@
> 
>>>   #define BUFSIZE 2048
>> Actually, BUFSIZE needs to be removed too.
>> I'll do it before merge.
> 
> Merged with the change above.
> Thank you!

Thanks

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
