Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E84ECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:56:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 993AC3C0F6B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64C53C068A
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 14:56:19 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 4DC78600C6F
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 14:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=tq2Fo5m1IwUOla/q37kIBEqg0D8o0pWsIvcpAeOEIhc=; b=F
 bQRHk7N/X4ojAleSHTSLTULsIYD+4jmJtlfgauozq7cteVh8ww4wsuUNlr7u+VNf
 A8S0xYpQECCLI45cw/KGiWtAsjxhCtLSpogJuxsosbVXZaTIvqBHVlJqcfQkpBkH
 hdj4PuLqCRTr2LfB6fB7QpYfBQxLHds0bPmcN95y4o=
Received: from ice_yangxiao$163.com ( [160.86.227.247] ) by
 ajax-webmail-wmsvr-40-105 (Coremail) ; Mon, 9 Sep 2024 20:55:55 +0800 (CST)
X-Originating-IP: [160.86.227.247]
Date: Mon, 9 Sep 2024 20:55:55 +0800 (CST)
From: =?GBK?B?0e7P/g==?= <ice_yangxiao@163.com>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <9a899c60-cb88-4991-8c5f-3fb14c8a09b8@lucifer.local>
References: <20240909050226.2053-1-ice_yangxiao@163.com>
 <9a899c60-cb88-4991-8c5f-3fb14c8a09b8@lucifer.local>
X-NTES-SC: AL_Qu2ZB/STuU0u4yedY+kfmkwaj+w9XcqwuPsm24BUOpp+jC/pyhICcXpaPmHMwOadJxuLtQGOXDNi5cBmUK9bVIYyYfgxMhrYka9GDdZhN4Q7jQ==
MIME-Version: 1.0
Message-ID: <b52b2aa.c178.191d6dae671.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDXX4Nc8N5m5E4IAA--.5973W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0gZVXmWX0RUYngAEsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mm/vma: Return the exact errno for __split_vma()
 and mas_store_gfp()
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
Cc: linux-kernel@vger.kernel.org, Liam.Howlett@oracle.com, linux-mm@kvack.org,
 oliver.sang@intel.com, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


At 2024-09-09 17:09:43, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com> wrote:
>On Mon, Sep 09, 2024 at 02:02:26PM GMT, Xiao Yang wrote:
>> __split_vma() and mas_store_gfp() returns several types of errno on
>> failure so don't ignore them in vms_gather_munmap_vmas(). For example,
>> __split_vma() returns -EINVAL when an unaligned huge page is unmapped.
>> This issue is reproduced by ltp memfd_create03 test.
>
>Thanks for this! :)
>
>Though pedantic note - please ensure to check scripts/get_maintainer.pl and cc-
>the reviewers and maintainer, the maintainer being Andrew and the

>reviewers being me, Liam and Vlastimil.


Hi Lorenzo,


Thanks for your kind reminder.

>
>The maintainer is especially important as it's Andrew who'll take the patch
>;)
>
>I've cc'd them here :)
>
>>
>> Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
>> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
>> ---
>>  mm/vma.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/vma.c b/mm/vma.c
>> index 8d1686fc8d5a..3feeea9a8c3d 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -1200,7 +1200,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  			goto start_split_failed;
>>  		}
>>
>> -		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
>> +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
>> +		if (error)
>>  			goto start_split_failed;
>
>We'd probably want to stop assigning error = ENOMEM and just leave it
>uninitialised if we're always going to assign it rather than filter.
>
>You'd want to make sure that you caught any case that relies on it being
>pre-assigned though.
>
>>  	}
>>  	vms->prev = vma_prev(vms->vmi);
>> @@ -1220,12 +1221,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  		}
>>  		/* Does it split the end? */
>>  		if (next->vm_end > vms->end) {
>> -			if (__split_vma(vms->vmi, next, vms->end, 0))
>> +			error = __split_vma(vms->vmi, next, vms->end, 0);
>> +			if (error)
>>  				goto end_split_failed;
>
>Related to point above, In this and above, you are now resetting error to 0
>should this succeed while some later code might rely on this not being the
>case.
>
>Basically I'd prefer us, if Liam is cool with it, to just not initialise

>error and assign when an error actually occurs.


Agreed. I will resend the v2 patch as you suggested.


Best Regards,
Xiao Yang

>
>But we filtered for a reason, need to figure out if that is still
>needed...
>m
>>  		}
>>  		vma_start_write(next);
>>  		mas_set(mas_detach, vms->vma_count++);
>> -		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
>> +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>> +		if (error)
>>  			goto munmap_gather_failed;
>>
>>  		vma_mark_detached(next, true);
>> --
>> 2.46.0
>>
>
>I'm in general in favour of what this patch does (modulo the points about
>not initialising error and checking that we don't rely on it being
>initialised above), but it very much need's Liam's input.
>
>If Liam is cool with it, I'll add tags, but let's hold off on this until we
>have confirmation from him.
>
>Thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
