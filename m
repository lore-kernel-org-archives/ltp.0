Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377B8C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 13:11:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 715583C92BD
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 15:11:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83CEA3C91A6
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 15:11:27 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 7F1CE1400066
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 15:11:24 +0200 (CEST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf9P4W9Vi1MEmAA--.33492S3; 
 Mon, 18 Jul 2022 21:11:20 +0800 (CST)
To: Cyril Hrubis <chrubis@suse.cz>
References: <1656315600-22268-1-git-send-email-zhanghongchen@loongson.cn>
 <YtUiDXXLf+ob7Dm4@yuki>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <4ff01bbf-c288-5053-52da-fe6530eff1d2@loongson.cn>
Date: Mon, 18 Jul 2022 21:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YtUiDXXLf+ob7Dm4@yuki>
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dxf9P4W9Vi1MEmAA--.33492S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DJFWUCFW5ZrWkGrW5GFg_yoW8urW3pr
 n3GF1rtr4rJFyxGrWxWwn0qFWFvrn5tr15u3yjyw45Z3Z5JrZ5ZrsFqas8Gry0vrW0qrWF
 9F4kZry3Krn0ya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
 ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
 0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
 IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
 Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgg
 _TUUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syslog11: fix console loglevel changed after test
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
Cc: ltp@lists.linux.it, Lingling Li <lilingling@loongson.cn>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2022/7/18 pm 5:04, Cyril Hrubis wrote:
> Hi!
>> the console loglevel is force to be 7(LOGLEVEL_DEFAULT) after test,
>> which is not the desired behavior.So we reset the console loglevel
>> to its original value after the test body.The method what we take
>> is just same as commit:
>> a2ff1c2d141d ("kmsg01: set/restore console log level").
> 
> First of all the test is mess, it would be nice to clean it up first and
> convert it to the new library.
> 
OK, I will change this test to new API and make a v2 patch.
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> Signed-off-by: Lingling Li <lilingling@loongson.cn>
>> ---
>>   testcases/kernel/syscalls/syslog/syslog11.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
>> index b9540ef..78a7cc4 100644
>> --- a/testcases/kernel/syscalls/syslog/syslog11.c
>> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
>> @@ -84,6 +84,11 @@ struct test_case_t {		/* test case structure */
>>   	char *desc;		/* Test description */
>>   };
>>   
>> +#define PRINTK "/proc/sys/kernel/printk"
>> +#define CONSOLE_LOGLEVEL_QUIET   4
>> +
>> +static int console_loglevel = -1;
>> +
>>   char *TCID = "syslog11";
>>   static int testno;
>>   static char buf;
>> @@ -195,6 +200,11 @@ void setup(void)
>>   		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
>>   	}
>>   
>> +	if (access(PRINTK, F_OK) == 0) {
>> +		SAFE_FILE_SCANF(NULL, PRINTK, "%d", &console_loglevel);
>> +		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);
> 
> Do we need to set the loglevel at the start of the test here?
> 
OK, I will change to use .save_restore to do this
>> +	}
>> +
>>   	/* Pause if that option was specified
>>   	 * TEST_PAUSE contains the code to fork the test with the -c option.
>>   	 */
>> @@ -208,5 +218,6 @@ void setup(void)
>>    */
>>   void cleanup(void)
>>   {
>> -
>> +	if (console_loglevel != -1)
>> +		SAFE_FILE_PRINTF(NULL, PRINTK, "%d", console_loglevel);
>>   }
>> -- 
>> 1.8.3.1
>>
> 
Thanks.

Hongchen Zhang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
