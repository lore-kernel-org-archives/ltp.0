Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A7C77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 07:46:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A5C03CD436
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:46:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 661AA3CB28E
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:46:42 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0715.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B5AB1400075
 for <ltp@lists.linux.it>; Thu, 18 May 2023 09:46:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a89D4wGYtpTG9QHXWZSnunFUC4cAbUxOaCVs7RE2ECz6fEqLxJK3pJ90ZqK8kRPqd/N7z1BLcSOT4xdX77/Gb+A1A0XzirRaaFluSKa0AmFOezJsOnGOSeTdCgdURAQ/CxYuNHMT9smjH7MtG3O1m8f5pyXYFqCmR5t5/q3JpHa+UxPNhBAJwTSJeczQeiDNOeGJBT5oZmoPjm1DrKP2d/by7xRVEndyiE1Y+jYp4EfEh4yKA+LQIBQ6cjXMds/jvwsI/+a9QXPT0FEdigXbkApNhbp+j4+gkjnLNWvFxetmoSf6+eTJXyoNI8xTQ5i3eBh5Gjuhg+QHdv3tVseAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohOeRBIw3OmRd0d9UaQJAtmjauBU6FQMgsdVPskbJf4=;
 b=Cuv8i6vF2uqAm71WuACbqhReiDvpYV3WonfH+ZKAucyax8Kd4o1El1lx3DwShQP90sX0iXUXBhkE3z8f54xETSqxA6K2vQ9OZ88UuUYigD6lE6Lhsbg9y0Fy7GUij1JOTNFOO6eTiZPuIn+I2PLRaqp//BmUcA2fNMzy17hFHByfABLKGkzs1SAuMNtBNrGXWXWoSoVTswj/6kKmgrFp8DnYyW1eQufiu/73BEGWcDRz5FExL+KjgMUpITGTQhyaU6djIIWSIBffvGpa3Jc+vKZDUcbb7BJUvwqXq7pm6NK8okFEuL7Goz11JeyhmXcaABGA8VA4CZLu4EI0xgKV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohOeRBIw3OmRd0d9UaQJAtmjauBU6FQMgsdVPskbJf4=;
 b=nLTkchRc/cBkPWq3gE25UAt5UHJsgfnrUCqMFB9BiWFFiMmdI0RLyvg8OiZrnN50yCszbQqWy+DkHaIaX3OAcw0xQCaXntMk/Sm8WR6PiNdlOy97UJ2gHb/NoryZfJ6XVo4P38jiADOkji7LgVSCABYZpizFRx0IqtGNn4He2nFxlyzm+ekcWXTMVDsovfdoS1Q9zsWInc06I5Sni7PRTkJQqaQNZ88w1w2u/DJXkOFHilXDE87A9wtqhSlUiMZzXqZijxrHhCFDZN8ObxHlnGzeYnPhsxWAVNsV53yN4o6ehb01m4RwaUTMmHOyd1tXUNnzr8T/Ac9VW6CKZlakfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com (2603:10a6:10:1a7::12)
 by PAWPR08MB9688.eurprd08.prod.outlook.com (2603:10a6:102:2ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 07:46:38 +0000
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::9cc3:ad9a:13ca:90ac]) by DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::9cc3:ad9a:13ca:90ac%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 07:46:37 +0000
Message-ID: <038933d2-2c0b-c339-42b2-19f9f9eef3d7@virtuozzo.com>
Date: Thu, 18 May 2023 09:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230516165929.1343864-1-khorenko@virtuozzo.com>
 <20230517002302.GA9395@pevik>
In-Reply-To: <20230517002302.GA9395@pevik>
X-ClientProxiedBy: VI1PR08CA0105.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::31) To DBAPR08MB5830.eurprd08.prod.outlook.com
 (2603:10a6:10:1a7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR08MB5830:EE_|PAWPR08MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2648e3-eeba-4697-e234-08db57740289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIsp21vpC0MVkS7S35KXr9TjPBqeg2ttSbps5tVa11x4CgEtA7ijLXnFkgaX4ZPzDGYbjXzaQuXlChDX+H82JQaDzDN4NWIG3I/8SMtGDLh/lsJ+ipqMT+yK19VW5ufRDeYD2KTaLzkcic8gZhnOjc/RlDD3VMI+oGvVC/mDUvyuUXZlvYF61NPDD/ziLpoBdTu/nhmJIExT7/gw5D3pAl2j9dKEm1SNkn0oUAfd8g09TYd6Ol2Pnvu7wzaL07Mdd849gauY6QMzYdHsLIdHs5o54+CUtDWgUeNg7XX9AX4TwNJWcj7XEf+XRbIhQhTcFLEZoschsDeXFgVHCRjAsT/4IZHMnI5KCDXXIA3KuqBVXeO9d0idwv0vJsU0gVw7EqYuLaWgTfqieGRBcZcmcS1bqJKj7SrKpPO2XketyhZP7cYG1D2oc7D6UKOnecpreg8GYtJuyXL/L8g7qs5SuMD1yiDLBa8ESZlc7Vycs4ouSi52Dp+Jr0j5UeMIMQ18DpksyUNLB8P4g8FYMYl8GhdDxeGBBHDMHpHS9TjMojVzQ9ZGo+G/sKyS4WgZ4WZ3FDeIIUo02Ylu1CYqLCIQVdg1EIAs8n+g/8sHJKIcgHugv8dh3/Fv7npbdj2L1M/QhoiF+S47wJPecy7G8OiNd80iWb3L0ME2SjQHHUDthFizwqRhAuuB653ewwtXtKA/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBAPR08MB5830.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39850400004)(136003)(451199021)(41300700001)(31686004)(8936002)(2906002)(8676002)(52116002)(6486002)(6512007)(6506007)(26005)(53546011)(66556008)(66946007)(38100700002)(83380400001)(6916009)(36756003)(316002)(478600001)(186003)(38350700002)(5660300002)(66476007)(4326008)(31696002)(86362001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlF5V1lJN3I3NTRpdDBXdTdGU01tS1Znc1R1ZWtoL0plbkZFRWJ2Y0dhODB3?=
 =?utf-8?B?WVc3YXhYUWVEUytwRGdvYnIzbS9OTnFMWHJ5Y09UckU0MjhUNzdTLzdaUSsv?=
 =?utf-8?B?ZGtGS04xOHkvTWw2bXV2RU5MZEFLK0VkR2dWbFdpSVQ5cDBsQzltV0FrajAz?=
 =?utf-8?B?RUlqZExyQnk4c29xakRWa0NjMm40cGhqUkxFTkd5QThZc1U1b3c2clRJWkhQ?=
 =?utf-8?B?ekJvVGxUSGdVTnBVRGdEY0pGN1ZxZUdVRHhTWGxydkV2c2hTRjZzNXFLQmVn?=
 =?utf-8?B?QTdFOVVYelNmZVFkbUY4ZFh0S0lqVXJJbkFpb1BjRnlmcWlqeEVBeWZXS1pl?=
 =?utf-8?B?MWwwMTlwKzRPcEIraVJxcXAvQ3lvQmM1NFk5YlpZQVJFWnAva3pHVGx0MXhV?=
 =?utf-8?B?dk9PdDBFL3dnc1c3ZGxjSklldGk1eSs3U09LRTVTWHdWL0RmT00vWjc5Y1dL?=
 =?utf-8?B?R3NESGtRQnRKQVRkL0oxaHpLMkxkaXplM2lSdWx6RENxS0ZaL0w4WXprL0FV?=
 =?utf-8?B?Qm43dmpHaEhkR2l4NExHdncyUXcrbUNEL3o4cUFDclE1dFhRaHl1RW8yVVJI?=
 =?utf-8?B?Vmt4NHBkaHZiMEpNdDh2bUJMSWNuMTRsSDVRTndSVTNEVnNiZUxiOW9iTVQ1?=
 =?utf-8?B?RU9EeGpmODZqYVBCQVdyaVR5dStUbEpOcEdmckxyNklCZmNlMjFseFNNYnFV?=
 =?utf-8?B?U0lLak1HTHZQQWdIK3pUdGtNbUltdzNRcDUwUVVaOTE2eDUrSTZUdFRPK1JL?=
 =?utf-8?B?LzF4MUlpcmQ5U3lqdFdxQk5vbVZHNUNkUUxUb2xJSzRsUjd2Qnk5dWRvUXVC?=
 =?utf-8?B?d01paVJIWUZPTzR6dlFuZS9vYWVrQ3hmU3djMDVscnY4cVR3WURFRzVLUHA5?=
 =?utf-8?B?Wm1GbFovRnE1TUpUWUVOQTFPUXlLSEF4VTBqUERyOGd4U1IzcUZyTVBwR1dv?=
 =?utf-8?B?UHJZU0ZPWnJtZk9iRzZkMWdOcVh5dW8wbWhvVXJTVUVUTHlkVkJrVXNrSy9y?=
 =?utf-8?B?RWFtNjNRVlJ6K3laV2RCV1EyYTgrUXNHSHNSRUlRRjIvcUd5V0ZvSlp1RXhr?=
 =?utf-8?B?d0dFQ0wrcGNNV3gwU25zZEZRZjFIaVErTDRKNkNNam1QandnbllkQUFLYmxY?=
 =?utf-8?B?MS9rd3Jzd0JUK1gxVjd2TXEzeUhqVmNQc0VXRGdveTlZa1ZWTHBkUnlCSWxU?=
 =?utf-8?B?TEovRzNDamtydTRuN2FFdFMxK05FUGJwZHVRR1NGY2xmVG9BRUVoRXR2Vnh2?=
 =?utf-8?B?M1JlOHFCOTlnUkRHc1pINGdnV21GWTdKVWxTSVNKQlJ6dkxFUFJrSk5EOEJy?=
 =?utf-8?B?VmFhNzFxc244OTByUWhwYXlhYitFOXcyclY2WjI0QysvWlovMGVnUnBmZE1L?=
 =?utf-8?B?SFNza1hZNFY5K3hCbGttQ2FjNGorS1lqQVVvTEM5K05SSEJBV0VpN2YzQnJw?=
 =?utf-8?B?Y3NHQTBmSGhXVm5oeTYvMlg4MnVOY0wwaGNaanJBbVljamRNSXdHcFEzbDdj?=
 =?utf-8?B?cDhORmROeDUrcUdRL3FDY1JHM1RCL2ZjQzlvNHc3cVBFeDRRT0g2dzY2RmJ6?=
 =?utf-8?B?U1FRS0FOQzNnNzhEdVU2aEc0ODBLcGVjUDBiTFpWSklaYTNRVzV4YTZkY2Jk?=
 =?utf-8?B?Ky9JMmtWb3dQd3IrZzVsNU42Sjdhbmt6NlRZRXRrTW4yZ2dXajBEVGUvNnJF?=
 =?utf-8?B?UVk0ZEZ5RkNGYUJ4REdqZE45S200OVRITGV1d2NOM0hYaStnK1p4NTJYWlJ6?=
 =?utf-8?B?MmVzNW45S25jNnNRSkdjcGhOdjBrZ3dvWmdpd29LYnloRkNEc2NhNitucEdw?=
 =?utf-8?B?WUs4dFBLT2Nud3h5K0JKM1FMMzcxN3oydll3VkpxSWREZS8rSTI1c2VrVm5S?=
 =?utf-8?B?VVVROHNhajdOMHpFa0pIWFVzMk5Ca3FZR1B4b3gxL014TkhURndkWW9yKzgr?=
 =?utf-8?B?VkFMNkIwTUFPZzRBM2RhdHRXZEFWUVNIZXM4cCs1RnB0cllzVlFQQXhnRXZr?=
 =?utf-8?B?b3FOd2UrU2Z2ZW1qSmZseFZVT3pXUUlzUkFTSDYrZG5pWVlkMU5PaDJ5N05Z?=
 =?utf-8?B?YUVoNFh1dUtSM1hYUkJJY0w3djhPV1V2Tm1SN3VBYVgrME1NZUhsOGlJKzNK?=
 =?utf-8?B?Q2xlME9TaC9tc1pkVEVqdURaZDJxemYyQVliSk1GYi9kbVJUMnN2UDF4UHl2?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2648e3-eeba-4697-e234-08db57740289
X-MS-Exchange-CrossTenant-AuthSource: DBAPR08MB5830.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 07:46:37.5919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3AAgTzCv99vOMO7KnM5xNZzaNS1cbur0TuCLaxweTgrFWq7Wd9t0nzMsQjJUiOTpuRqG7BDNrSVlLBHxGDi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9688
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] scsi_debug/tlibio/lio_write_buffer: Always
 return total amount of written bytes
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
From: Konstantin Khorenko via ltp <ltp@lists.linux.it>
Reply-To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 17.05.2023 02:23, Petr Vorel wrote:
> Hi Konstantin,
> 
>> Sometimes we got failures like:
>>   growfiles(gf217): 65884 growfiles.c/2262: 104203 tlibio.c/744 write(3, buf, 5000) returned=2288
>>   growfiles(gf217): 65884 growfiles.c/1765: 104203 Hit max errors value of 1
>>   gf217       1  TFAIL  :  growfiles.c:134: Test failed
> 
> I wonder on which circumstances do you get this error. Running on container?

Yes, your guess is correct. :) Our QA runs ltp in Containers and VMs under high load,
i mean when many Containers/VMs host on a physical Node and run in parallel different tests.

>> Which looked strange as partial write is something usual and valid.
>> It turned out that lio_write_buffer() has the code cycle writes in case
>> of a partial write happens, but it anyway returns the amount of bytes
>> written by the LAST write.
> 
>> And upper growfile() consider the returned amount from
>> lio_write_buffer() to be less than it tried to write and fails the
>> testcase.
> 
>> Fix lio_write_buffer() to always return total bytes written, even in
>> case partial writes.
> 
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>> ---
>>   lib/tlibio.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
>> diff --git a/lib/tlibio.c b/lib/tlibio.c
>> index cc110d1c9..8298e2de9 100644
>> --- a/lib/tlibio.c
>> +++ b/lib/tlibio.c
>> @@ -539,6 +539,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>>   		long wrd)	/* to allow future features, use zero for now */
>>   {
>>   	int ret = 0;		/* syscall return or used to get random method */
>> +	int totally_written = 0;/* as we cycle writes in case of partial writes, */
>> +				/* we have to report up total bytes written */
> 
> Nit: I'd do multiline comment (much more readable):

No problem, will redo and resend.

Thank you for the review!


Best regards,
Konstantin Khorenko

> 
> 	/* as we cycle writes in case of partial writes,
> 	 * we have to report up total bytes written */
> 	int totally_written = 0;
> 
> Otherwise LGTM.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>>   	char *io_type;		/* Holds string of type of io */
>>   	int omethod = method;
>>   	int listio_cmd;		/* Holds the listio/lio_listio cmd */
>> @@ -745,13 +747,14 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>>   						fd, size, ret);
>>   					size -= ret;
>>   					buffer += ret;
>> +					totally_written += ret;
>>   				} else {
>>   					if (Debug_level > 1)
>>   						printf
>>   						    ("DEBUG %s/%d: write completed without error (ret %d)\n",
>>   						     __FILE__, __LINE__, ret);
> 
> BTW growfiles.c and other files based on tlibio.c would deserve big cleanup and
> rewrite into new API.
> 
> Kind regards,
> Petr
> 
>> -					return ret;
>> +					return totally_written + ret;
>>   				}
>>   			}
>>   			wait4sync_io(fd, 0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
