Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9842BC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713528047; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MCEz0FMhxko4B5+HJJWMWt33nVrUtMSj28ecMxe7xOc=;
 b=Y0yH4xZTwH1VLKz7MZNSK9U7CqvmJTLXz1dGDzqardJhSrxWQMxqz8t4D6Lf69ysbt6s1
 QS1ZsNpUGQkGui2ZKYse67AriQBRNj+DbNjP0kFSjs2Zk3G+sKj9iAVMh63iWsVZ6H5B+Qm
 mBw6TEzX1hKFx6pSPAYRD0k3noTj04c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89953CFD97
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 14:00:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855BE3CF3FC
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:11:37 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=suse.com (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=vbabka@suse.com; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3604600A72
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 10:11:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 876FD346A0;
 Fri, 19 Apr 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 787F0136CF;
 Fri, 19 Apr 2024 08:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OazHHDcnImb9YgAAD6G6ig
 (envelope-from <vbabka@suse.com>); Fri, 19 Apr 2024 08:11:35 +0000
Message-ID: <cef1a016-f47c-4785-adea-c9eb9cd88f4c@suse.com>
Date: Fri, 19 Apr 2024 10:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Wei Gao <wegao@suse.com>
References: <20240418071422.10221-1-wegao@suse.com> <ZiFLikOzOFDwfR2d@yuki>
In-Reply-To: <ZiFLikOzOFDwfR2d@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 876FD346A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 19 Apr 2024 14:00:26 +0200
Subject: Re: [LTP] [PATCH v1] swapping01.c: Add sleeps in the loop that
 dirties the memory
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
From: Vlastimil Babka via ltp <ltp@lists.linux.it>
Reply-To: Vlastimil Babka <vbabka@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 4/18/24 6:34 PM, Cyril Hrubis wrote:
> Hi!
>> https://bugzilla.suse.com/show_bug.cgi?id=1217850#c34
> 
> If I'm counting right this is 10ms * 1024 which is 10s, I would be
> happier with 1ms sleep instead. Or if we did 10ms sleep once every 10
> memsets() instead.

Yeah I proposed you can try to reduce the sleep time/frequency to basically
to lowest value (with some margin) that resolves the issue reliably in your
testing. That 10ms per MB was just a possible starting point.

> Also since this was proposed by Vlastimil in the bugzilla he should
> ideally give his ack here as well (now in CC).
> 
>> Signed-off-by: Wei Gao <wegao@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

>> ---
>>  testcases/kernel/mem/swapping/swapping01.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
>> index a0030a75f..338881c8e 100644
>> --- a/testcases/kernel/mem/swapping/swapping01.c
>> +++ b/testcases/kernel/mem/swapping/swapping01.c
>> @@ -47,6 +47,7 @@
>>  #define COE_DELTA       1
>>  /* will try to alloc 1.3 * phy_mem */
>>  #define COE_SLIGHT_OVER 0.3
>> +#define MEM_SIZE 1024 * 1024
>>  
>>  static void init_meminfo(void);
>>  static void do_alloc(int allow_raise);
>> @@ -101,6 +102,13 @@ static void init_meminfo(void)
>>  				swap_free_init, mem_over_max);
>>  }
>>  
>> +static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
>> +	for (int i = 0; i < mem_count / 1024; i++) {
>> +		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
>> +		usleep(sleep_time_ms * 1000);
>> +	}
>> +}
>> +
>>  static void do_alloc(int allow_raise)
>>  {
>>  	long mem_count;
>> @@ -115,7 +123,7 @@ static void do_alloc(int allow_raise)
>>  	if (allow_raise == 1)
>>  		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
>>  	s = SAFE_MALLOC(mem_count * 1024);
>> -	memset(s, 1, mem_count * 1024);
>> +	memset_blocks(s, mem_count, 10);
>>  
>>  	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
>>  		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);
>> -- 
>> 2.35.3
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
