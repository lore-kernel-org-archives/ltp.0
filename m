Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E4DC8303C
	for <ltp@archiver.kernel.org>; Sat,  5 Jul 2025 07:10:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 833C53C9EB0
	for <ltp@archiver.kernel.org>; Sat,  5 Jul 2025 09:10:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CD7B3C6583
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 09:10:14 +0200 (CEST)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
 [45.249.212.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86A381400962
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 09:10:12 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
 by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bZ1q60YYlzKHMVm
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 15:10:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
 by mail.maildlp.com (Postfix) with ESMTP id 80B491A06DE
 for <ltp@lists.linux.it>; Sat,  5 Jul 2025 15:10:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
 by APP3 (Coremail) with SMTP id _Ch0CgBnxyTKz2hoUJLWAg--.53385S3;
 Sat, 05 Jul 2025 15:10:04 +0800 (CST)
Message-ID: <094a1420-9060-4dcf-9398-8873193f5f7b@huaweicloud.com>
Date: Sat, 5 Jul 2025 15:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joseph Qi <jiangqi903@gmail.com>
References: <CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com>
 <2dbc199b-ef22-4c22-9dbd-5e5876e9f9b4@huaweicloud.com>
 <CA+G9fYv5zpLxeVLqYbDLLUOxmAzuXDbaZobvpCBBBuZJKLMpPQ@mail.gmail.com>
 <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <2ee5547a-fa11-49fb-98b7-898d20457d7e@gmail.com>
X-CM-TRANSID: _Ch0CgBnxyTKz2hoUJLWAg--.53385S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJry3Gr1kKrW8KF1rCryrtFb_yoW8AF4rpa
 y3Ja4DCF4UGr18JrWIqF1vqw17ta18tr48Xr9xGry5C3Z0yF1xur4SgF1j9F90vr1xuwnY
 qr4q9a4I9ayjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
 6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
 vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
 xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
 0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
 6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
 14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
 ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
 Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
 7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250626: WARNING fs jbd2 transaction.c
 start_this_handle with ARM64_64K_PAGES
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
Cc: Theodore Ts'o <tytso@mit.edu>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4 <linux-ext4@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2025/7/3 18:47, Joseph Qi wrote:
> 
> 
> On 2025/7/3 15:26, Naresh Kamboju wrote:
>> On Thu, 26 Jun 2025 at 19:23, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>>>
>>> Hi, Naresh!
>>>
>>> On 2025/6/26 20:31, Naresh Kamboju wrote:
>>>> Regressions noticed on arm64 devices while running LTP syscalls mmap16
>>>> test case on the Linux next-20250616..next-20250626 with the extra build
>>>> config fragment CONFIG_ARM64_64K_PAGES=y the kernel warning noticed.
>>>>
>>>> Not reproducible with 4K page size.
>>>>
>>>> Test environments:
>>>> - Dragonboard-410c
>>>> - Juno-r2
>>>> - rk3399-rock-pi-4b
>>>> - qemu-arm64
>>>>
>>>> Regression Analysis:
>>>> - New regression? Yes
>>>> - Reproducibility? Yes
>>>>
>>>> Test regression: next-20250626 LTP mmap16 WARNING fs jbd2
>>>> transaction.c start_this_handle
>>>>
>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> Thank you for the report. The block size for this test is 1 KB, so I
>>> suspect this is the issue with insufficient journal credits that we
>>> are going to resolve.
>>
>> I have applied your patch set [1] and tested and the reported
>> regressions did not fix.
>> Am I missing anything ?
>>
>> [1] https://lore.kernel.org/linux-ext4/20250611111625.1668035-1-yi.zhang@huaweicloud.com/
>>
> 
> I can also reproduce the similar warning with xfstests generic/730 under
> 64k page size + 4k block size.
> 

Hi, Joseph!

I cannot reproduce this issue on my machine. Theoretically, the 'rsv_credits'
should be 113 under 64k page size + 4k block size, I don't think it would
exceed the max user trans buffers. Could you please give more details?
What is the configuration of your xfstests? and what does the specific error
log look like?

Thanks,
Yi.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
