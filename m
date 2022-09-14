Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027B6C6FA8A
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 09:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02A913CAC0C
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:44:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3670A3C1C21
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:44:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C7E62600F2E
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 11:44:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19CEA336BB;
 Wed, 14 Sep 2022 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663148673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAkQlIoPCQKbzIfNE+xRc2si4+9+T5dyIrGiFDM1TKY=;
 b=wOf+b6n+Vv1T6CuOC6cZ9PvndcpfwoLhacaAlFGdWMK9piVr7Gz3X+8UDe1Q6UDa1zAOaA
 MhYRKKjjXAs1HBk6nLvCp+8andRqc7AKJTbuwQN+aJ51DLgwSgnRmPiBNI/bcp069xGDBx
 DI+UodKzdVS2f3LGAVqoOtSzVlcQv+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663148673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAkQlIoPCQKbzIfNE+xRc2si4+9+T5dyIrGiFDM1TKY=;
 b=VzIlIrt9bPtIMVBZEdj+dQaOJOrNgCNWdrJkBlH9hCrjXVLznu9DSnALDsEzQ8mJGxcK4g
 /nYdJFl+3u4ULkAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 077AD134B3;
 Wed, 14 Sep 2022 09:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OvqCAIGiIWPAMwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 14 Sep 2022 09:44:33 +0000
Message-ID: <a6fbe570-109d-a7f8-1a56-99791fcdd7b4@suse.cz>
Date: Wed, 14 Sep 2022 11:44:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220913151907.26763-1-mdoucha@suse.cz>
 <20220913151907.26763-4-mdoucha@suse.cz> <YyGg8VilN9Jhv1lQ@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YyGg8VilN9Jhv1lQ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On 14. 09. 22 11:37, Cyril Hrubis wrote:
> Hi!
>> dio_sparse currently ignores all child failures because children never
>> exit with non-zero code. Fix child exit status.
>>
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>> ---
>>   testcases/kernel/io/ltp-aiodio/common.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
>> index 68465dc54..6265831af 100644
>> --- a/testcases/kernel/io/ltp-aiodio/common.h
>> +++ b/testcases/kernel/io/ltp-aiodio/common.h
>> @@ -78,9 +78,9 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
>>   			if (r > 0) {
>>   				bufoff = check_zero(buff, r);
>>   				if (bufoff) {
>> -					tst_res(TINFO, "non-zero read at offset %zu",
>> +					tst_brk(TBROK,
>> +						"non-zero read at offset %zu",
>>   						offset + (bufoff - buff));
> 
> Ah, this is the fix. I would go for tst_res(TFAIL, ""); and return 1;
> otherwise this looks fine applied over the previous changes.

If I returned from io_read(), I'd have to rewrite the calls in 
dio_sparse.c and aiodio_sparse.c to exit(io_read()). Otherwise testrun() 
in LTP library would always force the exit code to 0. This is less work 
and you won't need to remember LTP library implementation details when 
you reuse io_read() in a new test.

Should I send a v2 for tst_validate_children() or will you delete the 
if(WCOREDUMP()) branch and merge it now?

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
