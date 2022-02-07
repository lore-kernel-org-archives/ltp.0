Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4685BC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 13:45:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D8D73C9B0A
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:45:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 964833C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:45:46 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7D910200984
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 14:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644241544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQaRK4nmR34HqWNcfZh0dGEFS9s990v+Ha1KAh8V1gk=;
 b=nQ2wVTIOgbdXhSJqXEwfZLXgyUUoIRB9/eVKf6C66PxHsyWglGBtXkjdxZsm3HlHwvtJnN
 qdJ2lFKdG/M6v5ribrJg5cI/eifGF7VNXmiOazrT+OkpEWG8nvXekcr2y57YQ+BDqSl2Ta
 8eSRWTnz/wrY8MCn3QW20/x2WcnmYzk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-f1XVYJaZMh6vwZfyu0_fqA-1; Mon, 07 Feb 2022 14:45:43 +0100
X-MC-Unique: f1XVYJaZMh6vwZfyu0_fqA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOudYdT/mAJ/RrhmZ8y4kB8G0Pfe/Rvh5/MOflP8e4ihgr+Abie7N74UABVoiTr1vRi/2GKvgSJPB4r4x3ARy9hefqFwDlzc5HIp7nYHzbG/1Y5fAiitqjb7M+xdr6+419+ERAfxf0Ou2f3mrJ2d9CgzrIQIpVzr6xPUJAR5XfZD842WTB2R+70npVt3/Vom2JrmHt+8ReWlXqWofUtyj1RS4+EuZQXmZ/GvHkHe6c6v+UaMdt/Y1cYjsD0ri5PL1ap4MAg5Qd7gGIEsomKmeW1BRGh2mUggzZuahiSodnZdHn9711uYfRpV/9LdGDqOwEEJGqHZEKn8EsEe9HWlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQaRK4nmR34HqWNcfZh0dGEFS9s990v+Ha1KAh8V1gk=;
 b=I9f0oD3Coz0ug0gFEB3lGZZMeA4UUITrBkwV/OrKI0RY1iatYjTalA+kq+FS6V6hxYnDVnyBv0P8jG/BiOBNt8l0jMiixkvj1+0vxPjl6RELpTc7JAui0X44YU4OIWjANhHPxCFXr2euV0NIjDIrvRj8a4ti2iKQoS1fbBj1SjYKUKLLuP0Ip1HB/PN23hkLic89R0y7rd6N0lr1lcY7iZ+BZzeJ6ePsUwxtHt6SgCVhEQzW/rNbZp+6gYpkCuguFHjuOF/57wHGWI7neRH859aqoiTV+BlXB/DZLmGdrCmCnjtUeqmSA0IBn9jCLJ4voSnB/4HqkqdsNLZ6HQPEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM7PR04MB6790.eurprd04.prod.outlook.com (2603:10a6:20b:dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 13:45:41 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::69ee:ea32:8cf8:2e02%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 13:45:41 +0000
Message-ID: <f6ffeb4b-541b-722d-992e-4f45bf60acaa@suse.com>
Date: Mon, 7 Feb 2022 14:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
 <YgEB9/BvNhgIAl2n@pevik> <YgEDBRSBEUMK3dEF@yuki> <YgEIviW5/HrW4yja@pevik>
In-Reply-To: <YgEIviW5/HrW4yja@pevik>
X-ClientProxiedBy: AM6PR0202CA0068.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::45) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a177af9a-470e-40c6-b553-08d9ea40216a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6790:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB679071F041C970854DDA74B5F82C9@AM7PR04MB6790.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4J+W5ZV+ea815REZjQiVAiHejdNPM+Nhv3JWteuGhyt921jfmlfCb3ZZD1GN0f4MifJNPlU/lvzBg5r/7ocbNmTCBo+oMTDP8N4508OMI0XAHa1wtp24ebGuQA0eq9qJuB7lhOQP+QFuRjFOqoaZwjuCxI42NXjeQAGNwRj9iAce5FRCFqOZDWFAdwJNyhAG2brzFBwEgztKPnJ7qbB47QN9GyuoPQpNyloVWkZfCfbLvOCyR3lowxQxjhZUaWHJ9L2FpR9DphX8BYgLwQLIPY3ovE+mRc7ijLhP/6I1sp1d02NLjMcN8xetIupmqnrwJLDr13wRhdbP7r2OJiNJ6QZSWwyV6CgzCnZ4if8WwQwiqtL1UOvB9LVsQuh87G0MmhKBMThBG6PZJ8/whpdSje1FEFNotn07lGXiHtb6nyIoFXmUwHSJUjmBp2MgdOyD735NwCVC3zxJ/bQeS1uyZ7itZS/0NgX2Qbn9eq/CkkwUfS9sM7it9meOnVnYjkMfu4UAOMBmtrblqTpLCX+2Nzse3thswdF6FhBHx/wOQLxNrsJEUP2Bh1QeaRh45GTbl6vbRMDBM4axVnqqhz+LDOPfloEXAhuKpCAlqV7aWZpSMIE/oCGa68z91KCNI5B9VCjWXoQvFqI3kh23JyjYGVZRedML1b4tjodWm6fV8rvlt8dH14ex3ojFwEgmFJq2tpIFqzGLciEzRwA8Q256yqxYKJkJH9tgB2phYHi04tJYTec72gDbmRIGDfiWJqOgwDoKiQIsVFRg7BBJF7CSSIT+vk2H/dMd4PjlWhZ3kMaC0MExAxEgACyXdp9Ctrut4gSdKp43K3TnhWejKzaL2E4bX8pCtDajZbuaPTkS98Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2616005)(66556008)(8936002)(21615005)(66476007)(8676002)(83380400001)(31686004)(36756003)(508600001)(6486002)(966005)(26005)(6506007)(38100700002)(86362001)(31696002)(53546011)(33964004)(5660300002)(6512007)(166002)(44832011)(66946007)(316002)(6916009)(2906002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ell5alU2UGhqS21PRnV4Y0hyUGpqTTBna2Y4VCtZSUlVT0EzWVlQTis4YVhP?=
 =?utf-8?B?MmJQcWEyZzdYRW51TGJUR25sZkYwSnIrVlkrajRzTEt0aUovcGJMWWVXcU01?=
 =?utf-8?B?djRTd2RkWDBjWDNYd1g0STYrNWF3YVZld3kxTWNtamlwcHNJVTVHRkkxUkli?=
 =?utf-8?B?R2lqeDFhSDZscTR1UWh2ZGV4eDQ1YzU4eDQ4T3hreVZ4a2tvblNaZmx4dUdh?=
 =?utf-8?B?UkE1WFBDbm9wYkVTNDVuWXNyZVplZUwreVVNdlAwT1pzNmtMYUl2SHNEQWlj?=
 =?utf-8?B?blhjd2MyOGV3MWxpVHIyUCtheTVySjJxbVRHcitEZXhJaUdXb3Z3amdhRkYr?=
 =?utf-8?B?ZnB0K3craFlva3NzSE5TYU9WYkFLSkt2eE96YjB4S0tUV2d3LzdxYzcxY0dG?=
 =?utf-8?B?MkNiUUtoUzlCcTBUb3ZWZUJ2N1poNXRUS3YvTVI0VXhEeHpXUTg2VGE5cWdU?=
 =?utf-8?B?RmNsK0VLMDdNNklrbFF6MURHMzRlR3lyYmdGd2ZyUDVnMUE3L2RVT3VXTE9i?=
 =?utf-8?B?RlRUV2JuUzUxVVA5Mm84UGdkU09HMndhb2NYREROQ1ZSTWpxdm1aUWxWczVT?=
 =?utf-8?B?eEY2cHBiR1pRMmo5S3dlMTBRenV6bnhDYUE2VU1mWHF4TituSE5OTTkrZjhZ?=
 =?utf-8?B?YnFaOVRGdHZxcVRWbUt4SnQyazRtNjRQRWNNWmhUVnFsUysrQTZRcWd4TjFG?=
 =?utf-8?B?UjcyN3dvUlh3ZE95K0VIV1FqdFBGem0rTmdVQ3NYYXJqTVBzN0p0ejBBZkV0?=
 =?utf-8?B?U3FranlPQ3lxTXZGTGg1Z2FpT1pRUFliSmhWb3FZZmR1NWtlKy8yN3AyMDA3?=
 =?utf-8?B?L0xJamVBd096Z1FzVkhyVzZsTXoyRzZkS3pJM1hDb2wrQ3NLTGtvdlM1S2di?=
 =?utf-8?B?N3BsckFQTXdxbTNWaVlYNWRBUTBNSmxwVVRObXJOaEUyeERiUllTdFBocGZM?=
 =?utf-8?B?Z3NCU0pJS1E3VG5yZ0tUNnh3UzkySURMK2hJdHBLdFZ1WFVJejBiT2NYZDEw?=
 =?utf-8?B?SEVYaTJoTU9weCswaHU3eVMxb0x3T3dYWVdKSXQwM0FTcmdUZitjZGZRY2Fk?=
 =?utf-8?B?Nm1hMTU0T0Y3RzRYNU9KeDZhMXFzSFo0U1RNU1c1MnlKcExFQzU0djkwR0lm?=
 =?utf-8?B?SlVFL0JSYk9PTFBMMzIzUU5haUJLc1djaDl5Rmp0NnEvU1FldGtQbUFFdWs4?=
 =?utf-8?B?ZWcrQmUvT2RvLzRqKzU4U0VLdmFCYmgzd2pHcC84dGlrZGNxS2V3RWxEeXI1?=
 =?utf-8?B?NG5RWUM5RVJleGFVTzVucmpTSzc2WTdKSzB2c29zRDdCMlYzNGgrb1c1eEtJ?=
 =?utf-8?B?cVkwMlp4K213QWNKR1VDdDc0Q21mZVlCVUx4anZsMDVCS2pNa0dOdDByOGh6?=
 =?utf-8?B?akRXdkdtclJGVXFOWVZDVmdkdU5EYUp5NjNna3BxdTJycmhkTFl1ZitsMzlZ?=
 =?utf-8?B?Y2svR2dacGF3Mm1mRkJFV1R4WkZ5OGUzb09aUHEwNXo0VnowL0dEOVJ4TUYv?=
 =?utf-8?B?akpBZFVZbVBrOVFWcmtTV05DaFJFL3hTZDhiQU9aaURSaG9BeW14U0dRMm5a?=
 =?utf-8?B?KzlVeWZBbHJGOHhUVXJuUXRSR0c1VlkwWW5kNGdvOVRYQTVYMzg2TUJQejR3?=
 =?utf-8?B?RXJ6bzkrVjVZRXNlNkZwMFRFVm5oTVZmS3ZvNkE3Z2VmRXdsUXVLQjc1bFN2?=
 =?utf-8?B?QzdoNGdERkdsWS9RQmw5dFU2NTUyWHE3N090NDZPSjczR2ZrUDR3c0FtRkJv?=
 =?utf-8?B?ME1wbTVyOFpVOEdrU3g2WVhQeEdjQmhFc0ZZeHpxbG83UjB1WW9VekVFdm13?=
 =?utf-8?B?K1I1M0Q0U0FPN01TbnhDbFlORjg2NVZEaXIxaFBDOHNBNkhVbFQ0VWQxeHlE?=
 =?utf-8?B?RkhjSFZ2d2xNSm9mTjA3ZWNyQU1kVmR2VlFiNlREbkI1MWNJSmhLZi9QdTJC?=
 =?utf-8?B?UHZlenZYTEdHYUhoWlo4cXp5VTdleERFR21BTVNmT1dTWHRqN0FxNDZRTUZh?=
 =?utf-8?B?bnZZRVlBUjNCYXVwMEdJczlvODJwU0pPVVB3bkNrMmE2aWpQd3JwZk1jelA5?=
 =?utf-8?B?T055bnJLcVpaWkRvY0VZMWlVMmJrTUFSRm1IM3lKTWRVcllaZ1o2UnRXU2kx?=
 =?utf-8?B?Vk50TlFpSEVOOTBUYzdEZHpXM0dwYkduK2tVS0pWbmNqdVlHRDViQ3FjbFJ2?=
 =?utf-8?B?NkZKdzAreHhhQzErS3BWdjNZaDR6SEQ5dTBEWkJ0YUpaZ2ZYUWdvaEdVM3pj?=
 =?utf-8?B?MWhXNW4yc0QvOWh3ZlNqUjRsQkJnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a177af9a-470e-40c6-b553-08d9ea40216a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:45:41.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QECQYhx8FQcLk4rUAW3fqubaB4t59D5lKobX8YB+q6QiMgX/GLE71Q0zKTRDUqj4y62Elv+H69LhnF0jrtiSV/Z4Mep6oB8gjzjKKa9DoZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6790
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: multipart/mixed; boundary="===============1838270237=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1838270237==
Content-Type: multipart/alternative;
 boundary="------------gD4fNNDmo1YZXsmgtKCwLe0F"
Content-Language: en-US

--------------gD4fNNDmo1YZXsmgtKCwLe0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I also think that support for an array of functions is needed to cover 
all scenarios and cleanup the code a little bit. The real problem with 
tcases is that sometimes we are doing what we might do with multiple 
functions, but using an approach which is expecting struct and some sort 
of "filtering" in .test_all function.

And in some cases, where one particular testcase differs by a statement 
from an another, struct needs a flag to filter out the specific 
testcase. This would be easy to handle with two different functions.

Also the output message sometimes is stored into the struct, in order to 
show the correct TPASS/TFAIL message we need, according with the tcase. 
And this is probably an overengineering solution, since that would be 
handled well using multiple testcases functions, testing different 
scenarios and using different output messages.

Also simple tests, such as input arguments unit tests, would benefit 
from array of tests functions, since we can split tcases into multiple 
functions and make code more readable.

To sum up things, I think that having support for an array of test 
functions can cleanup code in many tests and make them easier to 
read/maintain. tcases can still do well sometimes, but adding the 
support for an array of functions can improve the LTP framework and so 
the way we are testing the kernel.

Andrea

On 2/7/22 12:55, Petr Vorel wrote:
> Hi all,
>
>> Hi!
>>>> +static void run(unsigned int i)
>>>> +{
>>>> +	tcases[i].tfunc();
>>>> +}
>>> OT: we may lack something in the API, when function like this need to be
>>> defined.
>> See:
>> https://lists.linux.it/pipermail/ltp/2017-October/005829.html
>> https://lists.linux.it/pipermail/ltp/2017-July/005132.html
> https://lore.kernel.org/ltp/860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com/
> https://lore.kernel.org/ltp/20170727081437.27995-1-chrubis@suse.cz/
>
> Very nice that you remember your old work :) (we didn't have patchwork back then).
>
> Now I remember it - you already implemented it in 5 years old RFC, Jan didn't
> see a value and that's why it haven't been merged.
>
> Yes, Jan is right that it complicates code a bit, but even if you replace this
> code:
>
> statx09.c
> static struct test_cases {
>      void (*tfunc)(void);
> } tcases[] = {
>      {&test_flagged},
>      {&test_unflagged},
> };
>
> static void run(unsigned int i)
> {
>      tcases[i].tfunc();
> }
>
> with .test_all where you have the switch it still kind of boilerplate. Thus I
> agree with cyrils argument:
>
> https://lore.kernel.org/ltp/20171003125958.GB11692@rei/
>
> 	"aiming to avoid the need to have a switch () in each testcase that
> 	implements a similar tests but cannot be easily data driven (as we do
> 	for most of tests that loop over an array of structures describing the
> 	test data)"
>
> Thus, not sure if we want to rething the implementation, but I'd be for adding
> the support (sure doc and docparse adoption would need to be added but that's
> obvious).
>
> Kind regards,
> Petr
>
--------------gD4fNNDmo1YZXsmgtKCwLe0F
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">I also think that support for an array of
        functions is needed to cover all scenarios and cleanup the code
        a little bit. The real problem with tcases is that sometimes we
        are doing what we might do with multiple functions, but using an
        approach which is expecting struct and some sort of &quot;filtering&quot;
        in .test_all function.<br>
      </font></p>
    <p><font size="4">And in some cases, where one particular testcase
        differs by a statement from an another, struct needs a flag to
        filter out the specific testcase. This would be easy to handle
        with two different functions.</font></p>
    <p><font size="4">Also the output message sometimes is stored into
        the struct, in order to show the correct TPASS/TFAIL message we
        need, according with the tcase. And this is probably an
        overengineering solution, since that would be handled well using
        multiple testcases functions, testing different scenarios and
        using different output messages.</font></p>
    <p><font size="4">Also simple tests, such as input arguments unit
        tests, would benefit from array of tests functions, since we can
        split tcases into multiple functions and make code more
        readable.<br>
      </font></p>
    <p>To sum up things, I think that having support for an array of
      test functions can cleanup code in many tests and make them easier
      to read/maintain. tcases can still do well sometimes, but adding
      the support for an array of functions can improve the LTP
      framework and so the way we are testing the kernel.<br>
    </p>
    <p>Andrea<br>
    </p>
    <div class="moz-cite-prefix">On 2/7/22 12:55, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YgEIviW5%2FHrW4yja@pevik">
      <pre class="moz-quote-pre" wrap="">Hi all,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi!
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+static void run(unsigned int i)
+{
+	tcases[i].tfunc();
+}
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">OT: we may lack something in the API, when function like this need to be
defined.
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">See:
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://lists.linux.it/pipermail/ltp/2017-October/005829.html">https://lists.linux.it/pipermail/ltp/2017-October/005829.html</a>
<a class="moz-txt-link-freetext" href="https://lists.linux.it/pipermail/ltp/2017-July/005132.html">https://lists.linux.it/pipermail/ltp/2017-July/005132.html</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com/">https://lore.kernel.org/ltp/860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com/</a>
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/20170727081437.27995-1-chrubis@suse.cz/">https://lore.kernel.org/ltp/20170727081437.27995-1-chrubis@suse.cz/</a>

Very nice that you remember your old work :) (we didn't have patchwork back then).

Now I remember it - you already implemented it in 5 years old RFC, Jan didn't
see a value and that's why it haven't been merged.

Yes, Jan is right that it complicates code a bit, but even if you replace this
code:

statx09.c
static struct test_cases {
    void (*tfunc)(void);
} tcases[] = {
    {&amp;test_flagged},
    {&amp;test_unflagged},
};

static void run(unsigned int i)
{
    tcases[i].tfunc();
}

with .test_all where you have the switch it still kind of boilerplate. Thus I
agree with cyrils argument:

<a class="moz-txt-link-freetext" href="https://lore.kernel.org/ltp/20171003125958.GB11692@rei/">https://lore.kernel.org/ltp/20171003125958.GB11692@rei/</a>

	&quot;aiming to avoid the need to have a switch () in each testcase that
	implements a similar tests but cannot be easily data driven (as we do
	for most of tests that loop over an array of structures describing the
	test data)&quot;

Thus, not sure if we want to rething the implementation, but I'd be for adding
the support (sure doc and docparse adoption would need to be added but that's
obvious).

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------gD4fNNDmo1YZXsmgtKCwLe0F--


--===============1838270237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1838270237==--

