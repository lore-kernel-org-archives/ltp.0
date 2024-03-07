Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18676C48BF6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709822835; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=oZBLbplKDj9AqNIUNrznaFlMiWPf1JC+0eI4SnpGwQE=;
 b=EHtsUqZZhqDxtOo76/OZfM57XLc6UqZnCDDPsJCNoqQIi/fiXJY1qj/zdWZgC+S/sfsoT
 bq1tdFI5CFviZT4JW9nqt+o5oEifhV25WP/jEU4w+tXvzFWCSOm5zE+52q+hPbKLIT7Wbx+
 Gxzuur0wdNqdfoY9NYksZjEkaK5QHoQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E353B3CFE23
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 15:47:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDFDC3C1354
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 15:46:55 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 730631A00E32
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 15:46:54 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-413129b0cc2so4152125e9.2
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709822814; x=1710427614; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OSiKHMP0R89OeEeVy8lgYELMLMISIiCaET8WLzjmcMs=;
 b=REUdeL/B0A0auDb3hAq4ftMsKlD7MAAr4HbzjjYvd5Dhq4y+MFcfy5sQdxm68O3S8w
 omiOgzOuUAJPTOKNYiW/8wu/fJ24Sv7WjEXsJYxKeoBPw1JldFdB1ZGxOPiavVPadw/R
 QKdK2K/9Jc8vmOGV0Om74G/GzMuX6wYhZoizjk0JMF/2/UGQqv+/v+xg6B2OEeMgNdB9
 sDwz4fNTyLaglZMKAZpcSRAJP4VY4qBwsbg25f59g2P9ENdcdkBIdeCy1mb8CSG4ZkE8
 R57tSo2YIG/qbXxeJ7oe81rWuXeqDUjslGIFhJtFtgXPBhy4N+ioL2epq94Mj2lrGjJi
 1hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709822814; x=1710427614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OSiKHMP0R89OeEeVy8lgYELMLMISIiCaET8WLzjmcMs=;
 b=myOhA5dYC5c6DdqTn5burcIXiFu+5Vx0H0xu4hTD52Db/yHHDY5aD1SGnEITyRI1rX
 2oSTaiptosu7fD9OaTX5KG9WOBsFEJGMDFrgV1Ltl1xuN7HQ6r9uDEaMml6w9jdESJn3
 v1f9whUMoOR491X24jL2/aOMFP1CJAH6YQA1fm8OXz8DDrqw2DPsNqpI4Hrqr95No73g
 g5N4SKEj+oikROViKcT1MW4zvI4yOtXNfmxXlMzOFhDMrDdY3QUmuCeq0PsIXH/V9lEU
 BMiqRpaLgJA+cW72+bdEbodKFC6/IB2L4MuC5PfbLb5Dm0o4poGOeuGYhyoOV+f0/PYS
 gM/w==
X-Gm-Message-State: AOJu0YwwmP+5XPoQeglweVXnDTcAgihJK7yeaxZQs9r5/VU5yC6ij0SC
 gzqoEZ4kWOHYrOl9Ow8ih2bK54dLYTmMIHY79rExXBLcCw1gjnh3Xh9fxCi2SQ4=
X-Google-Smtp-Source: AGHT+IEcM6qH6iUZ8Ba0n0Q0oGclJJ5ZpDeEX0ekXTJYCVWyWJ91Mv+TDUmNAEsL4mLuPtF+COmvKw==
X-Received: by 2002:a05:600c:5247:b0:412:9dd0:f7e7 with SMTP id
 fc7-20020a05600c524700b004129dd0f7e7mr13635953wmb.22.1709822813838; 
 Thu, 07 Mar 2024 06:46:53 -0800 (PST)
Received: from [172.20.10.2] ([37.160.210.202])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a7bc44e000000b00412f6c695d1sm2815905wmi.43.2024.03.07.06.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 06:46:53 -0800 (PST)
Message-ID: <f61464e4-834f-4341-ab85-792765ddb9e5@suse.com>
Date: Thu, 7 Mar 2024 15:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240216122904.11446-1-andrea.cervesato@suse.de>
 <ZemmFwvEl9qgGEAN@yuki>
In-Reply-To: <ZemmFwvEl9qgGEAN@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite msgstress testing suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 3/7/24 12:33, Cyril Hrubis wrote:
> Hi!
> First of all this patch removes all users of the libltpipc library but
> keeps the library orphaned in libs/ leaving a dead code.
This was done by purpose. I have track of dependences inside LTP and the 
idea is to remove it on a second moment. But I can send a following 
patch removing it already.
> Secondly if you look at the libmsgctl.c you can actually see that the
> reader and writer pair sends messages in a loop. This is imporatant
> because without that the test can be hardly called a stress test. The
> point is to start as much processes as possible that keep sending
> messages around so that eventually we saturate the system. The new test
> just sends a single message, which means that the children finish too
> quickly and we never run more than a single digit of read/write pairs.
> Given that we now have a runtime support in the test library we should
> change this so that the reader/write paris continue to send messages
> around until we are out of runtime. And the runtime should be at least a
> minute.

Actually this is a good idea, but test might send not enough messages if 
system is not responsive.
I would keep the loop like we do now in this case, so we ensure a 
certain amount of stress, no matter the runtime.

>
>> +static void reader(const int id)
>> +{
>> +	int size;
>> +	struct sysv_msg msg_recv;
>> +	struct sysv_data *buff = NULL;
>>   
>> -	/* Fork a number of processes, each of which will
>> -	 * create a message queue with one reader/writer
>> -	 * pair which will read and write a number (iterations)
>> -	 * of random length messages with specific values.
>> -	 */
>> +	memset(&msg_recv, 0, sizeof(struct sysv_msg));
>>   
>> -	for (i = 0; i < nprocs; i++) {
>> -		fflush(stdout);
>> -		if ((pid = FORK_OR_VFORK()) < 0) {
>> -			tst_brkm(TFAIL,
>> -				 NULL,
>> -				 "\tFork failed (may be OK if under stress)");
>> -		}
>> -		/* Child does this */
>> -		if (pid == 0) {
>> -			procstat = 1;
>> -			exit(dotest(keyarray[i], i));
>> +	size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
>> +
>> +	for (int i = 0; i < ipc_data_len; i++) {
>> +		if (ipc_data[i].id == id) {
>> +			buff = ipc_data + i;
>> +			break;
>>   		}
>> -		pidarray[i] = pid;
>>   	}
>>   
>> -	count = 0;
>> -	while (1) {
>> -		if ((wait(&status)) > 0) {
>> -			if (status >> 8 != 0) {
>> -				tst_brkm(TFAIL, NULL,
>> -					 "Child exit status = %d",
>> -					 status >> 8);
>> -			}
>> -			count++;
>> -		} else {
>> -			if (errno != EINTR) {
>> -				break;
>> -			}
>> -#ifdef DEBUG
>> -			tst_resm(TINFO, "Signal detected during wait");
>> -#endif
>> -		}
>> +	if (!buff) {
>> +		tst_brk(TBROK, "Can't find original message. This is a test issue!");
>> +		return;
>>   	}
>> -	/* Make sure proper number of children exited */
>> -	if (count != nprocs) {
>> -		tst_brkm(TFAIL,
>> -			 NULL,
>> -			 "Wrong number of children exited, Saw %d, Expected %d",
>> -			 count, nprocs);
>> +
>> +	TST_EXP_EQ_LI(msg_recv.type, buff->msg.type);
>> +	TST_EXP_EQ_LI(msg_recv.data.len, buff->msg.data.len);
>> +
>> +	for (int i = 0; i < size; i++) {
>> +		if (msg_recv.data.pbytes[i] != buff->msg.data.pbytes[i]) {
>> +			tst_res(TFAIL, "Received wrong data at index %d: %x != %x", i,
>> +				msg_recv.data.pbytes[i],
>> +				buff->msg.data.pbytes[i]);
>> +
>> +			goto exit;
>> +		}
>>   	}
>>   
>> -	tst_resm(TPASS, "Test ran successfully!");
>> +	tst_res(TPASS, "Received correct data");
> This spams the test output with a few hundreds of lines of output, which
> is known to choke test runners. For this case we should probably output
> one single TPASS at the end of the test.
>
> Also this seems to be a common pattern, so we may as well add a function
> into the test library that would produce TPASS unless we have seen a
> FAIL/BROK/WARN. Or maybe just a function that would return sum of the
> result counters so that we can do:
>
> 	if (tst_get_res(TFAIL|TBROK|TWARN))
> 		tst_res(TPASS, "All data were received correctly");
>
>
Isn't it like this already?

Regards,
Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
