Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0804FCA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 04:37:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00B9F3C1445
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 06:37:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55CE63C08CF
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 06:37:37 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id A157160B04F
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 06:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=Ds8SGJNrGKKPwrRg5/3qgVtYu3HnLnrC+bgY+oUH6VA=; b=n
 GjmtBSwtZx60+UvJiJmOIezVguPAfWnW+k2nhRxATTEKmckpJPLIXZXuwMIjNkHz
 gMSCkjbsNH3xiPtK4OquZKLvdCEPa7hbw1wxEHuH+WOQZyHWWbIPkX90Aj7IkGBe
 Y6dutC5qfc7RPTJrvgxWatZyYVfbv7RGlyevmy/wXI=
Received: from ice_yangxiao$163.com ( [160.86.227.245] ) by
 ajax-webmail-wmsvr-40-125 (Coremail) ; Wed, 4 Sep 2024 12:37:19 +0800 (CST)
X-Originating-IP: [160.86.227.245]
Date: Wed, 4 Sep 2024 12:37:19 +0800 (CST)
From: =?GBK?B?0e7P/g==?= <ice_yangxiao@163.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <3zloqsccdzrelzht454tpafo3jseckjtnbyznyn7ve25m62uyf@olxy27mjxn42>
References: <20240901145025.2311-1-ice_yangxiao@163.com>
 <3zloqsccdzrelzht454tpafo3jseckjtnbyznyn7ve25m62uyf@olxy27mjxn42>
X-NTES-SC: AL_Qu2ZB/iZu04o7yaRZukfmkwaj+w9XcqwuPsm24BUOpp+jAzp0z4ac3RdEmXn4t2DDBKjoQaJdTlg0/xgd4tWc4cL9bTRuTKzqZztgR3EX5bBOg==
MIME-Version: 1.0
Message-ID: <60c0ae1b.4e59.191bb529ed5.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3Xxr_49dmx5JdAA--.31718W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0g9QXmWX0JuOWwADs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mm/vma: Return the exact errno for
 vms_gather_munmap_vmas()
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
Cc: linux-mm@kvack.org, oliver.sang@intel.com, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Liam R


Thanks for your reply.

Could you share the URL of your v8 patches.



Best Regards,
Xiao Yang

At 2024-09-03 23:58:26, "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>
>Thanks, but this is already fixed in v8 of my patches.
>
>* Xiao Yang <ice_yangxiao@163.com> [240901 10:51]:
>> can_modify_vma() in vms_gather_munmap_vmas() returns -EPERM if vma is
>> sealed so don't always return the fixed -ENOMEM on failure.
>> 
>> Fixes: c2eb22189bbc ("mm/vma: inline munmap operation in mmap_region()")
>> Fixes: 5887a7ac2383 ("mm/vma: expand mmap_region() munmap call")
>> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202408312155.fd26a58c-oliver.sang@intel.com
>> ---
>>  mm/mmap.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index c1781f643046..c9a0dc035819 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1386,8 +1386,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>>  		mt_on_stack(mt_detach);
>>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>>  		/* Prepare to unmap any existing mapping in the area */
>> -		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>> -			return -ENOMEM;
>> +		error = vms_gather_munmap_vmas(&vms, &mas_detach);
>> +		if (error)
>> +			return error;
>>  
>>  		vmg.next = vms.next;
>>  		vmg.prev = vms.prev;
>> -- 
>> 2.44.0
>> 
>> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
