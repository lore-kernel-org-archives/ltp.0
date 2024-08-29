Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141EC7EE3A
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724920121; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=K5WjC5w0x0rcLxJlBYl1D7n0qLrDrG0nSfE7y/9vxrI=;
 b=U85EtD4UXNF9yPB5tHAJHPKWX6+K1jviUzazmKWcugrUcQmPr8VrwyoIhRJqvphVEiZ69
 9pf31Wcp2Cz1vUYWc3jqAvdoj3w3qoMoGQVCcXkkZ4G6D9Y1Pa8eShPdXmqKez9jiswDqyB
 XMq97uwoVU4f44VRqU1XCH/V7P3WxXE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 185DB3D27E8
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 10:28:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E8E53D27DE
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 10:21:03 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=wangkefeng.wang@huawei.com; receiver=lists.linux.it)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24A53256FE6
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 10:21:02 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvYyH3cdxz20n0B;
 Thu, 29 Aug 2024 16:16:07 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
 by mail.maildlp.com (Postfix) with ESMTPS id D6C571A016C;
 Thu, 29 Aug 2024 16:20:57 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 16:20:57 +0800
Message-ID: <dfeb5f5f-2b21-4b8f-bb8b-7170ef001773@huawei.com>
Date: Thu, 29 Aug 2024 16:20:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: kernel test robot <oliver.sang@intel.com>
References: <202408291314.bdbfa468-oliver.sang@intel.com>
In-Reply-To: <202408291314.bdbfa468-oliver.sang@intel.com>
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100008.china.huawei.com (7.185.36.138)
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 29 Aug 2024 10:28:19 +0200
Subject: Re: [LTP] [linux-next:master] [mm] f1295af16a: ltp.madvise11.fail
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
From: Kefeng Wang via ltp <ltp@lists.linux.it>
Reply-To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it,
 Oscar Salvador <osalvador@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 2024/8/29 16:13, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.madvise11.fail" on:
> 
> commit: f1295af16abee075de68400c58550cffacc29eb1 ("mm: migrate: add isolate_folio_to_list()")


f1295af16abee075de68400c58550cffacc29eb1 tags/next-20240828~164^2~86

on next-20240828, it was fixed in the next patch,

f1295af16abe mm: migrate: add isolate_folio_to_list()
4e3a04695e25 mm-migrate-add-isolate_folio_to_list-fix // this should fix 
the issue.

or please test next-20240829

Thanks.

> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240824
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-01/madvise11
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408291314.bdbfa468-oliver.sang@intel.com
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
