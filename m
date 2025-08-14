Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4313CA0ED1
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 04:15:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F70E3CBC14
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 06:15:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4269D3C06B5
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 03:28:01 +0200 (CEST)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com
 [45.249.212.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 760C31400332
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 03:27:58 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
 by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c2SKk5Z7xzKHMV2
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 09:27:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
 by mail.maildlp.com (Postfix) with ESMTP id 0F8D51A018D
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 09:27:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
 by APP4 (Coremail) with SMTP id gCh0CgAHgxOVO51oPzBtDg--.8664S3;
 Thu, 14 Aug 2025 09:27:52 +0800 (CST)
Message-ID: <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
Date: Thu, 14 Aug 2025 09:27:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>
X-CM-TRANSID: gCh0CgAHgxOVO51oPzBtDg--.8664S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fAFW7tF4UtrWrWr1DGFg_yoW8Zw4xpF
 WrCF98tr45X345ArsFvw4IgFyUtrZ8Krn5Wr1rtw17C39IkryDZF4SgF1Y9F97Jr4DCFyr
 ZrsFv3sIyryDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
 6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
 vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
 xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
 0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
 6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
 14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
 Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
 j6a0PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:15:42 +0200
Subject: Re: [LTP] [PATCH 6.16 000/627] 6.16.1-rc1 review
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
Cc: Ian Rogers <irogers@google.com>, Jan Kara <jack@suse.cz>,
 Zhang Yi <yi.zhang@huawei.com>, qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, hargar@microsoft.com,
 Dan Carpenter <dan.carpenter@linaro.org>, f.fainelli@gmail.com,
 shuah@kernel.org, jonathanh@nvidia.com, Joseph Qi <jiangqi903@gmail.com>,
 patches@kernelci.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, srw@sladewatkins.net,
 broonie@kernel.org, Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Theodore Ts'o <tytso@mit.edu>, rwarsow@gmx.de,
 pavel@denx.de, patches@lists.linux.dev, conor@kernel.org,
 linux-perf-users@vger.kernel.org, achill@achill.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2025/8/13 22:53, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
>> Hi Greg,
>>
>>>> 2)
>>>>
>>>> The following list of LTP syscalls failure noticed on qemu-arm64 with
>>>> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
>>>>
>>>> Most failures report ENOSPC (28) or mkswap errors, which may be related
>>>> to disk space handling in the 64K page configuration on qemu-arm64.
>>>>
>>>> The issue is reproducible on multiple runs.
>>>>
>>>> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
>>>>
>>>>   - fallocate04
>>>>   - fallocate05
>>>>   - fdatasync03
>>>>   - fsync01
>>>>   - fsync04
>>>>   - ioctl_fiemap01
>>>>   - swapoff01
>>>>   - swapoff02
>>>>   - swapon01
>>>>   - swapon02
>>>>   - swapon03
>>>>   - sync01
>>>>   - sync_file_range02
>>>>   - syncfs01
>>>>
>>>> Reproducibility:
>>>>  - 64K config above listed test fails
>>>>  - 4K config above listed test pass.
>>>>
>>>> Regression Analysis:
>>>> - New regression? yes
>>>
>>> Regression from 6.16?  Or just from 6.15.y?
>>
>> Based on available data, the issue is not present in v6.16 or v6.15.
>>
>> Anders, bisected this regression and found,
>>
>>   ext4: correct the reserved credits for extent conversion
>>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
>>
>> Report lore link,
>>
>> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)
> 

Hi,

This issue has already fixed in 6.17-rc1 through this series:

https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/


To fix this issue in 6.16, it's necessary to backport the whole series
instead of just pick 5137d6c8906b ("ext4: fix insufficient credits
calculation in ext4_meta_trans_blocks()") and 95ad8ee45cdb {"ext4: correct
the reserved credits for extent conversion").  Otherwise, this will make
the problem more likely to occur.

Thanks,
Yi.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
