Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA32C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 09:25:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CF1E3CA363
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 10:25:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6473A3CA1EA
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 10:24:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6479B2010BA
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 10:24:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D9601F385;
 Fri,  4 Mar 2022 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646385893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As+ASaKDw7sLCdxxd+yVyoMftsA26yyQBlsg+SJBmno=;
 b=aIrniApEm1gqjrihLTOcEanivnplfIV5TIWp0EKjiTHzz8m/O73NYF7GeTLp2bI84ii6RT
 JvxPrbMoTf4rd7VPwDnLUz5K8BXxHjp4IxXeYytlcsMaLdbXR2Z/U2xnUjy5/EncOP0F7w
 FMQINTVizzqGSr3f9GwDdqo64t/Z/HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646385893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As+ASaKDw7sLCdxxd+yVyoMftsA26yyQBlsg+SJBmno=;
 b=qabc2tiWIqsbRAmMOq0LCh/3aL2xqmU7dC0gr8vHLY+E+9yDoIEgPgYwvm9jnfetQdRx81
 k2tlrpENsk0fftAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89C5213B2D;
 Fri,  4 Mar 2022 09:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id x92KIOXaIWKbfgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 04 Mar 2022 09:24:53 +0000
Message-ID: <7b039478-a14a-809f-7499-4f760a611093@suse.cz>
Date: Fri, 4 Mar 2022 10:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
References: <20220303153131.3372-1-mdoucha@suse.cz>
 <20220303153131.3372-3-mdoucha@suse.cz> <62216DB6.8040202@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <62216DB6.8040202@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] quotactl06: Fix TESTDIR1 cleanup if setup()
 exits early
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 04. 03. 22 2:38, xuyang2018.jy@fujitsu.com wrote:
> Hi Martin
>> When setup() exits with TCONF before TESTDIR1 gets created, cleanup() will
>> trigger TWARN when it tries to delete it. Check whether the directory exists
>> before calling SAFE_RMDIR().
>>
>> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
>> ---
>>   testcases/kernel/syscalls/quotactl/quotactl06.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> index 8e9a17393..d470486d5 100644
>> --- a/testcases/kernel/syscalls/quotactl/quotactl06.c
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
>> @@ -207,7 +207,9 @@ static void setup(void)
>>   static void cleanup(void)
>>   {
>>   	SAFE_UNLINK(USRPATH);
> It seems we also should check USRPATH whether existed.

If I understand correctly, the file will be created by mount(), even
before setup() gets executed. So if the file doesn't exist during
cleanup(), the error will be valid.

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
