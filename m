Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00420CE79B0
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 10:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AB4E3CA4C4
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 12:50:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B77E13CA4C4
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 12:50:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2A2660007B
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 12:50:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97EFC1FF40;
 Wed, 20 Sep 2023 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695207044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQp1PjwZmXiGt+WbGZlOGgqsTaVyR1upEQc9HiJBEts=;
 b=nMEhQc5jHCul2c53iFFkyGXEv9hzTXBJlMVRqzHe7dXqkpTH0UrUrcFWN9NAYX0t3OlGG1
 P/c6a5hk0FBW2n/lp3BttgBt/UjUXIzT6IVDeWNOwLcxnrit4QKWzkMKTezBa1E2D8S0bf
 hCvGdkHdH0EumYUkHktxvtfgI+3GdXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695207044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQp1PjwZmXiGt+WbGZlOGgqsTaVyR1upEQc9HiJBEts=;
 b=eIOM3p/IzPlSarG/+X8YaleYVAev5EtzDkUlkGHFCTfoYuUdb1Ldx9XB7/9aSbR4ty2mUO
 iJsJTjxefQcs5hAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83864132C7;
 Wed, 20 Sep 2023 10:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PWnaHoTOCmU2JQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 20 Sep 2023 10:50:44 +0000
Message-ID: <978496cb-0363-b595-702e-9ae841ca4402@suse.cz>
Date: Wed, 20 Sep 2023 12:50:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: rpalethorpe@suse.de
References: <20230919114701.15327-1-mdoucha@suse.cz>
 <20230919114701.15327-3-mdoucha@suse.cz> <87o7hxfexs.fsf@suse.de>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <87o7hxfexs.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] nfs03.sh: Wait for all files to be removed
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

On 20. 09. 23 9:59, Richard Palethorpe wrote:
> Hello,
> 
> Martin Doucha <mdoucha@suse.cz> writes:
> 
>> A race condition between the two parallel calls of rm_files may cause
>> NFS unmount to fail and then the NFS client will get confused by remote
>> filesystem change which leads to strange failures. Make sure both
>> rm_files calls finish before returning from the main test function.
> 
> You mean unmounting fails if there are still operations in progress?
> 
> Like does umount fail with EBUSY?

Yes, the unmount will fail with EBUSY. Then the test filesystem gets 
deleted while still mounted over NFS and a new NFS mount gets added on 
top. Then the NFS client randomly gets confused and complains about fsid 
change.

> 
>>
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>   testcases/network/nfs/nfs_stress/nfs03.sh | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/testcases/network/nfs/nfs_stress/nfs03.sh b/testcases/network/nfs/nfs_stress/nfs03.sh
>> index e5f4de67c..e9ef5fb78 100755
>> --- a/testcases/network/nfs/nfs_stress/nfs03.sh
>> +++ b/testcases/network/nfs/nfs_stress/nfs03.sh
>> @@ -66,11 +66,13 @@ do_test()
>>   	cd ../dir1
>>   	wait $pid1
>>   	rm_files &
>> +	pid3=$!
>>   
>>   	tst_res TINFO "cd dir2 & removing files"
>>   	cd ../dir2
>>   	wait $pid2
>>   	rm_files
>> +	wait $pid3
>>   
>>   	tst_res TPASS "test done"
>>   }
>> -- 
>> 2.42.0
> 
> 

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
