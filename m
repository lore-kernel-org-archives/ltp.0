Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1437C6FA86
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96F473CAA95
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:15:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90E9F3CA9C9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:15:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5F5C660048B
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:15:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1EE1F891;
 Fri,  9 Sep 2022 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662732945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1w+BEz25wvx2APxQRVlHDtWh5sAnzeYCqAh+MMmuNfg=;
 b=h4K4zti/EQ95QOn3PVh9mB13FlO2KiTMaV1ky63FUFLmxHHUffuOATBWKUOQWIz49xuHmO
 NXH3Uy1D010uju0AG6fOoe+KtXb2zH7207eYjuaaEi31QZR5kpiECPHt7y9pktb5jjLJH8
 GjkOjESt1tHImwnsfuTXXz6e82ZnmFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662732945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1w+BEz25wvx2APxQRVlHDtWh5sAnzeYCqAh+MMmuNfg=;
 b=puG/fji1l4Q+/01vEL3y9GAKVLUjBLGKpu5xtKSVOzWzwUmMwEqArBKxZSwLC5vI+5kNKL
 yIjel8BbfcfXiWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 391AE13A93;
 Fri,  9 Sep 2022 14:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vyvNDJFKG2P9VgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 09 Sep 2022 14:15:45 +0000
Message-ID: <70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz>
Date: Fri, 9 Sep 2022 16:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik> <Yxsgg8f7vOFdXV3q@yuki> <YxskoojodIaNuI6G@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YxskoojodIaNuI6G@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] tst_supported_fs: Support skip list when
 query single fs
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

On 09. 09. 22 13:33, Petr Vorel wrote:
>> Hi!
>>>>> +++ b/lib/tst_supported_fs_types.c
>>>>> @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
>>>>>   	return TST_FS_UNSUPPORTED;
>>>>>   }
> 
>>>>> +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
>>>>> +					      *const *skiplist)
>>>>> +{
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = tst_fs_is_supported(fs_type);
>>>>> +
>>>>> +	if (!ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
>>>>> +		tst_brk(TCONF, "%s is not supported by the test",
>>>>> +			fs_type);
> 
>>>> I would expect to return TST_FS_UNSUPPORTED here. It's a bit hacky
>>>> solution to exit a library call with tst_brk(TCONF, "");

I agree with that. Return a status code from 
tst_fs_is_supported_skiplist() and raise TCONF somewhere higher in the 
call chain.

>>> +++ b/include/tst_fs.h
>>> @@ -171,7 +171,8 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>>>   int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
> 
>>>   enum tst_fs_impl {
>>> -       TST_FS_UNSUPPORTED = 0,
>>> +       TST_FS_UNSUPPORTED = -2,
>>> +       TST_FS_SKIPPED_BY_TEST = -1,
> 
>> Maybe just TST_FS_SKIPPED
> 
>>>          TST_FS_KERNEL = 1,
>>>          TST_FS_FUSE = 2,
>>>   };
> 
>> I wonder though if we really care about the difference between
>> unsupported and skipped. Maybe just print TINFO message in case of the
>> skipped filesystem and return zero in both cases? And maybe rename
>> TST_FS_UNSUPPORTED to TST_FSNOT_USED.
> 
> I thought being precise why there is TCONF would help, but users will just read
> previous TINFO messages.
> 
> Having just single "error" enum constant, I'm OK to keep TST_FS_UNSUPPORTED
> (unless anybody really think renaming it to TST_FS_NOT_USED would be better).

I'd like to see why exactly a filesystem was skipped so I prefer two 
enum values. Though I'd name them TST_FS_UNAVAILABLE (missing mkfs or 
kernel support) and TST_FS_UNSUPPORTED (disabled by test skiplist).

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
