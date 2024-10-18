Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E9D3C55E
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 07:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5812B3C6267
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 09:51:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6634D3C2CEE
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 09:50:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=loongson.cn (client-ip=114.242.206.163; helo=mail.loongson.cn;
 envelope-from=zhanghongchen@loongson.cn; receiver=lists.linux.it)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id EC158101E010
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 09:50:46 +0200 (CEST)
Received: from loongson.cn (unknown [111.207.111.194])
 by gateway (Coremail) with SMTP id _____8DxPItSExJnWnsjAA--.51409S3;
 Fri, 18 Oct 2024 15:50:44 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
 by front2 (Coremail) with SMTP id qciowMBxd8VRExJnBdoyAA--.34397S3;
 Fri, 18 Oct 2024 15:50:42 +0800 (CST)
To: Petr Vorel <pvorel@suse.cz>
References: <20240731073403.1406035-1-pvorel@suse.cz> <ZqoSvzmu3vmJugC7@yuki>
 <ZqoUaJ4sc30EHzNm@yuki> <20240731193051.GA1428673@pevik>
 <ZqtOqZPo4qWb2_xu@rei> <20240801091441.GA1487933@pevik>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <46cb58dd-14fd-f0f8-a5aa-c944b39daa60@loongson.cn>
Date: Fri, 18 Oct 2024 15:50:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240801091441.GA1487933@pevik>
Content-Language: en-US
X-CM-TRANSID: qciowMBxd8VRExJnBdoyAA--.34397S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQEOB2cQ-X4TnQAAsz
X-Coremail-Antispam: 1Uk129KBj9xXoWruF45Ww1rWr17JFWDtF4kXwc_yoWxKFX_X3
 Z0vry3KwsayrWfCw47tFWUua9rWw17tr97Xr9rJr1DKwnrJFs8WF48u34Iqry5J3Z7A3sa
 gF1rua1FqFZ0kosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] cachestat01: Reduce required space on 64kb
 page size
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

On 2024/8/1 pm 5:14, Petr Vorel wrote:
Hi Petr and Cyri,
   I encountered the same problem when using 16K page. The calculated 
num_sthift is 5 (300 * 1024 * 2.5/16384~=46), and the final write size 
is 16384 * (2<<15)=512MB, so num_sthift is too large.

I think we can change the calculation method of num_sthift to:

unsigned int max_shift = log2(tst_device->size*MB(1)/page_size);
num_shift = MIN(max_shift, 15);

>> Hi!
>>> Problem is only with Btrfs and XFS. Others have between 0-1% (including
>>> Bcachefs). Therefore 2.6* (or 2.7*) is IMHO still secure.
>>> If you worry, we can have 2.5* (more secure).
> 
>> Let's go for 2.5 then.
> 
> Thanks, merged!
> 
> Kind regards,
> Petr
> 


-- 
Best Regards
Hongchen Zhang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
