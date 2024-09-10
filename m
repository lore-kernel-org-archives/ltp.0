Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B7ECE591
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 00:18:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5043C19F0
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 02:18:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88D23C068A
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 02:17:43 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 3F1166007AC
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 02:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=aZgkIqlZJojdB2AaLwv4UPem7CJ6dowqN8grFaiUjC4=; b=l
 hWKZ8us4KaOY9j5CBhrNLdUmmMh8oDMaiI15LpPi9xrBtA4emylhHIxzUvAk0+HA
 KHiyI9fEbigr/T4pfoKIK1vGTbRPoUr/FoaGq+qwM+qoQNRNO4G4g2AE8u54OlJk
 NYcf1G9Lj/MXi4tzXcAURzEwjTHls0VKn7Cg3gF3pM=
Received: from ice_yangxiao$163.com ( [160.86.227.247] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Tue, 10 Sep 2024 08:17:13 +0800
 (CST)
X-Originating-IP: [160.86.227.247]
Date: Tue, 10 Sep 2024 08:17:13 +0800 (CST)
From: =?GBK?B?0e7P/g==?= <ice_yangxiao@163.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <tixinevflrciek4bnjwzxv6dwqyokfhrhtmu6qndc7hs2qoizd@iqg2tpjjtwyt>
References: <20240909125621.1994-1-ice_yangxiao@163.com>
 <tixinevflrciek4bnjwzxv6dwqyokfhrhtmu6qndc7hs2qoizd@iqg2tpjjtwyt>
X-NTES-SC: AL_Qu2ZB/WZuEwo5SeRYOkfmkwaj+w9XcqwuPsm24BUOpp+jBHo4CcPZkdAOnHZ98CDLi+zmxuUTB5g1+BUeZR7docnHpFs2+7yF3SGE55UFMVE7Q==
MIME-Version: 1.0
Message-ID: <17a3c672.469.191d94aa64e.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3X4YKkN9mre5LAA--.1556W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMxZVXmXAnvvpZgAGsn
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] mm/vma: Return the exact errno in
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
Cc: lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, vbabka@suse.cz,
 akpm@linux-foundation.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


At 2024-09-09 22:07:09, "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>* Xiao Yang <ice_yangxiao@163.com> [240909 08:56]:
>> __split_vma() and mas_store_gfp() returns several types of errno on
>> failure so don't ignore them in vms_gather_munmap_vmas(). For example,
>> __split_vma() returns -EINVAL when an unaligned huge page is unmapped.
>> This issue is reproduced by ltp memfd_create03 test.
>> 
>> Don't initialise the error variable and assign it when a failure
>> actually occurs.
>> 
>> Fixes: 6898c9039bc8 ("mm/vma: extract the gathering of vmas from do_vmi_align_munmap()")
>> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202409081536.d283a0fb-oliver.sang@intel.com
>> ---
>>  mm/vma.c | 21 +++++++++++++--------
>>  1 file changed, 13 insertions(+), 8 deletions(-)
>> 
>> diff --git a/mm/vma.c b/mm/vma.c
>> index 8d1686fc8d5a..dc5355d99a18 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -1171,13 +1171,13 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>>   * @vms: The vma munmap struct
>>   * @mas_detach: The maple state tracking the detached tree
>>   *
>> - * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
>> + * Return: 0 on success, error otherwise
>>   */
>>  int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  		struct ma_state *mas_detach)
>>  {
>>  	struct vm_area_struct *next = NULL;
>> -	int error = -ENOMEM;
>> +	int error;
>>  
>>  	/*
>>  	 * If we need to split any vma, do it now to save pain later.
>> @@ -1191,8 +1191,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  		 * its limit temporarily, to help free resources as expected.
>>  		 */
>>  		if (vms->end < vms->vma->vm_end &&
>> -		    vms->vma->vm_mm->map_count >= sysctl_max_map_count)
>> +		    vms->vma->vm_mm->map_count >= sysctl_max_map_count) {
>> +			error = -ENOMEM;
>>  			goto map_count_exceeded;
>> +		}
>>  
>>  		/* Don't bother splitting the VMA if we can't unmap it anyway */
>>  		if (!can_modify_vma(vms->vma)) {
>> @@ -1200,7 +1202,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  			goto start_split_failed;
>>  		}
>>  
>> -		if (__split_vma(vms->vmi, vms->vma, vms->start, 1))
>> +		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
>> +		if (error)
>>  			goto start_split_failed;
>>  	}
>>  	vms->prev = vma_prev(vms->vmi);
>> @@ -1220,12 +1223,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  		}
>>  		/* Does it split the end? */
>>  		if (next->vm_end > vms->end) {
>> -			if (__split_vma(vms->vmi, next, vms->end, 0))
>> +			error = __split_vma(vms->vmi, next, vms->end, 0);
>> +			if (error)
>>  				goto end_split_failed;
>>  		}
>>  		vma_start_write(next);
>>  		mas_set(mas_detach, vms->vma_count++);
>> -		if (mas_store_gfp(mas_detach, next, GFP_KERNEL))
>> +		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>> +		if (error)
>>  			goto munmap_gather_failed;
>>  
>>  		vma_mark_detached(next, true);
>> @@ -1255,8 +1260,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>>  			 * split, despite we could. This is unlikely enough
>>  			 * failure that it's not worth optimizing it for.
>>  			 */
>> -			if (userfaultfd_unmap_prep(next, vms->start, vms->end,
>> -						   vms->uf))
>> +			error = userfaultfd_unmap_prep(next, vms->start, vms->end, vms->uf);
>
>This line is too long.
>
>> +			if (error)
>>  				goto userfaultfd_error;
>
>Good you saw this issue, I was going to point it out.
>
>>  		}
>>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
>> -- 
>> 2.46.0
>> 
>> 
>
>Besides the line over 80 characters, this looks good to me and should be

>squashed into my series.


Hi Liam,


Thanks for your reply.
It seems that the default maximum line length is 100 now, should we split the line?
In addition, is it better to remove the fixes line as you mentioned on previous patch?



If you agree with these two changes, I will resend the v3 patch as soon as possible.



Best Regards,
Xiao Yang

>
>Thanks,
>Liam

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
