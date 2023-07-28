Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9820AC0015E
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 08:17:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70A0D3CD6B2
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 10:17:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CFDC3C8AC3
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:17:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 678BE140119D
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:17:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24F181F854;
 Fri, 28 Jul 2023 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690532229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Wui0yds+XZmyMllKtnAKmB59AcF4KOUUQJVTjQl8RU=;
 b=AgTU1n9CagnZE93p1oCcftaqpWIV+eefV4KkCPWI5bXUPtcNNbAece1ckWVC1nwll5XPGc
 7YtCUhoLA9uM4knQDjN/ocnpDnSSGM+VX4Fy5Y/jeNFN2uP2JbsO8hBb0CYzdTjSpbN0Jy
 F5uybLqyUlEqEtfljcpDa/1YfXrV6qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690532229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Wui0yds+XZmyMllKtnAKmB59AcF4KOUUQJVTjQl8RU=;
 b=SkFXFKzdQAVm9U7r8CzhlTaUG4BBSDB0X2G/gupAuZbxDg0wmenO+pv5039JOXmhQAHkRJ
 d0MlMw3z9cqx2RDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E4BA133F7;
 Fri, 28 Jul 2023 08:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OU5ZAoV5w2QfYwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 28 Jul 2023 08:17:09 +0000
Message-ID: <97f281ba-4c7f-b1d9-19c9-71884e4c19bc@suse.cz>
Date: Fri, 28 Jul 2023 10:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230727150013.31835-1-mdoucha@suse.cz> <ZMNya4WWC3IP6FZZ@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZMNya4WWC3IP6FZZ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tst_netdevice: Add missing rtnetlink context
 allocation checks
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

On 28. 07. 23 9:46, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>   lib/tst_netdevice.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
>> index 4a0442932..a57f506e9 100644
>> --- a/lib/tst_netdevice.c
>> +++ b/lib/tst_netdevice.c
>> @@ -332,6 +332,9 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
>>   
>>   	ctx = create_request(file, lineno, RTM_NEWLINK, 0, &info, sizeof(info));
>>   
>> +	if (!ctx)
>> +		return 0;
>> +
>>   	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
>>   		tst_rtnl_destroy_context(file, lineno, ctx);
>>   		return 0;
>> @@ -411,6 +414,9 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
>>   
>>   	ctx = create_request(file, lineno, action, flags, &info, sizeof(info));
>>   
>> +	if (!ctx)
>> +		return 0;
>> +
>>   	if (srcaddr && !tst_rtnl_add_attr(file, lineno, ctx, RTA_SRC, srcaddr,
>>   		srclen)) {
>>   		tst_rtnl_destroy_context(file, lineno, ctx);
> 
> Shouldn't we tst_brk_() in these cases? This function is a base for
> NETDEV_CHANGE_NS_*() which is used as a safe macro without checking it's
> return value.

The tst_brk_() gets called by the safe_*() functions deeper in the call 
tree. But tst_netdevice functions may be called from cleanup() where 
explicit return is necessary even after tst_brk_().

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
