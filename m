Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAD2EB64D7
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 10:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABE0E3CBEFE
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 12:14:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16BE73CBBCC
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 12:13:55 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id C3B0F100093F
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 12:13:52 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.185])
 by gateway (Coremail) with SMTP id _____8DxAOndNYxkJfAFAA--.10936S3;
 Fri, 16 Jun 2023 18:13:50 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxZuTdNYxk1i0dAA--.17250S3; 
 Fri, 16 Jun 2023 18:13:49 +0800 (CST)
To: Martin Doucha <mdoucha@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 Petr Vorel <petr.vorel@gmail.com>
References: <20230609012740.19097-1-zhanghongchen@loongson.cn>
 <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
 <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
 <a4057bbd-1ff0-5bd4-8573-7872b23f20ce@suse.cz>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <8d553b8e-88ba-79c5-2dfe-893a82be1046@loongson.cn>
Date: Fri, 16 Jun 2023 18:13:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a4057bbd-1ff0-5bd4-8573-7872b23f20ce@suse.cz>
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxZuTdNYxk1i0dAA--.17250S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAEB2SK-4IcRwABsL
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy7Ar4rGr1UJw4kWF4kuFX_yoW8GFWkpF
 Z7Ka4jqr1kGF47Cr4Iv3W2vryIyry5JF4UXrySgry7J3Z8uana9r18JrWY93ZrAwn3G3y0
 ka12qa9rWa43ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_spread: change lowerlimit to 5000kb
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

Hi Martin,

On 2023/6/16 pm 5:31, Martin Doucha wrote:
> On 16. 06. 23 4:10, Hongchen Zhang wrote:
>> Hi Martin,
>>
>> On 2023/6/15 pm 10:27, Martin Doucha wrote:
>>> Hi,
>>>
>>> On 09. 06. 23 3:27, Hongchen Zhang wrote:
>>>> When I test the cpuset_memory_spread case,this case FAIL too often.
>>>> After dig into the code, I find out that the fowlloing things trigger
>>>> the FAIL:
>>>> 1) random events,the probability is very small and can be ignored
>>>> 2) get_meminfo which before send signal to test_pid
>>>> 3) account_memsinfo before result_check
>>>>
>>>> About 2) and 3), we can increase the value of lowerlimit to keep
>>>> the result as SUCCESS.After my testing, 5000kb is a reasonable value.
>>>
>>> we're also seeing these failures but only on architectures like 
>>> PowerPC with pagesize higher than the usual 4KB. On which 
>>> architectures do you see failures and what's the pagesize there?
>> I test on 3C5000+7A2000 machine, the architecture is LoongArch.The 
>> pagesize we used is 16KB.
> 
> So the underlying cause is the same - higher pagesize. That means the 
> upperlimit, lowerlimit and DATAFILE size should be calculated from 
> pagesize instead.IMO,upperlimit and DATAFILE size will not affect the result.
Change the lowerlimit like following?
lowerlimit = 2000kb*get_pagesize()/SIZE_4K;
But I have no idea which formula can we use.
Any suggestion?
> 

Best Regards
Hongchen Zhang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
