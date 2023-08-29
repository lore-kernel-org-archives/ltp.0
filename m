Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D13DC83F14
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 07:52:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6880B3CC0B4
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 09:52:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6003C3CB722
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 09:52:20 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 396D0200AFB
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 09:52:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i61qX3XhTAhgAtJCld8koFF3LkGJMPKuDZuiUmRMtZDLgvqTyP/3oDsJVRCbnTuXr1udoR+ewJcOZOfiVgm4JIfAaflgVqpoKog/Mls5/6AAGzuwuzx+K5gljS4qPdGhXTlXoHcF5Spu7p7mJChHIiGp4uvcsRRNVdvMiYg/NK1VgK7MAO19FPXhcUGNvJRGPug9X2TgpzNJ8gj4r9f377iJLeqeKVMMfwk8nXFsz468dd2N9SPSFGqkK4VzeCJk5HhlA55ZiP968DE0Vphm8N3ozSuTkiOGXlo/urUmCxtjObtMM4M2LgWIsiOOX+Hm6YHxnyc7RCMET6jNghMUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUnnxWzFGdn9z2q1aB92S6DLCrAy9vPkKNWeyXE+rUw=;
 b=RreEViqeBWxJsGlnGTNjlq6s+6mLy3G2betp8PpOFHrdp5PbV/68GHfIBAZSjVOrvCDwhFkpqtGbVnZ5+LKE8p+mK39lqLs8qjUTdCskP44wTVSwpN36gzl+/5cDvwP/OB5K8w6ZFOquk/btG3ScSPqKJPk1bILQrNFmJQTxG399AIWUy+J33S8eXvC9S44l6MIpWnCFGx0D5YhdXls21nC4pSoJqrjmoou7umOyjMiru4XfDWvtHY45+UmK3C2/cp8SFP39uVI+R34rjqpfNlgfv7eQp0eOP9Ue7hMCS1j8Qh8tqNmPqFxfdR+d99JN0SgfGpZI4ZIX3Bm2JJEyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUnnxWzFGdn9z2q1aB92S6DLCrAy9vPkKNWeyXE+rUw=;
 b=tTtP6qMZdNnDg/vtlVVdmDgvCp+UaOIo4AlBKWyDSc4KA3qS4pi93sSt6Isg5ntCqktANvas/LpWixY8amDWlRLigaP2XZiIDyEuIszvy6KB5Abx++IrLQxO9KkCmxFRuZ3HYbSg/FlgP2C3yU65qx44pgXWlGaRj+Owt1JLSBeZYbFVfLiYW7C9BsensDJBHUXIFepqabmVTCUuCHypfjQMqquksEgMJKBMnvg9zW9nP/Q7sOqrhWAOMcmrZCWnGaNxo12Dwj86sMFBd9Vj9vljS68jbgW0vY0n/egfniCeHX1olYCbzZR5eykua/Xpbp/B1ZSsx3PCaBwXgAuePQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 07:52:16 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Tue, 29 Aug 2023
 07:52:16 +0000
Message-ID: <1717e228-1556-4ba0-8f91-4cb7160c3908@suse.com>
Date: Tue, 29 Aug 2023 09:52:15 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230823130904.26051-1-andrea.cervesato@suse.de>
 <ZO2dfwOM0pK8xz1j@rei>
In-Reply-To: <ZO2dfwOM0pK8xz1j@rei>
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DU0PR04MB9372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adca4c2-260f-4b08-3249-08dba864dd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15qLzm5XSHnXqub1PQ42c6b0rnN3g6qgVxVfCFeMIO664q0PRYF665t2L2HJEKJbD23dRVx4XZ9V5/FiHxnT0y9HCy/zby+HaRO4NkxpqBclBkBC/kGYcXZ0Cdb2OYhJ/w280xgAAkdsPjtsU9zzzKQT9+5/BPZ2nDvizvGjzxSKP8oC18h2KnxRZiPaC6vH/EbYB0p1ZgQzTSx/0wT+tTJq7hPDe3yBdLiczISqwTDJJIDt49Yr/8tJDo1mspnbbWTkW9MIs+GX/9Ug8rMtnCykC3eEY0g/7Nt/88ZSm2umi0Re2AcNjjotV8C08D2kkl6omtwIfsE9/LM+YdhR3YKYhqrqdJ47/qQTXfYQMjv1Wz5TO8UbghUFkqhoIUxvPALbZs8IXx0ilPGa8fo8YVDpdf+Y57TaXYKHhc0pitjp4Q37+aGRRDMmoB6MzSQllAITfQN7UKViyWG/urWUszeuyvc2xxCVhKTtTsLBTa4+Vf8TuYxzSVmmiv/qym9ita8pqeEolCCYg9PaHipwzQoceq/y59S28v1c75KNKgEPR4yUkfHXrYxdypEa2dNmTYf0KsJns1zbPztPhkWhG2pqcu0JG0hGOub3uEVz3x3VO9iIwIijkANqsYjOQdoEJCm7//wgx+HXEF3H3/Sdjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(83380400001)(478600001)(966005)(26005)(31686004)(6486002)(2616005)(6512007)(110136005)(53546011)(6506007)(31696002)(86362001)(36756003)(316002)(44832011)(2906002)(38100700002)(8676002)(8936002)(4326008)(66556008)(66476007)(5660300002)(41300700001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lRTmNNWGxDZkNiUkFMVXpMMDEwK3UvMUlWazBZcC9SN3VpOThIaUNFTFZJ?=
 =?utf-8?B?R01sZEYzdGkrZWlndlhXR2RDbVBDNzBxMng2aWFGY0JTb2NvMDZ2RmhqVFpF?=
 =?utf-8?B?enM3eWtHRlRFTW9jN2dzSldKWGV2YmlRR2paU2dJS3Nid1IzcjVQOFZwcXB1?=
 =?utf-8?B?eHZrSG9EaTFJR1psRjllS2VESEFFNnNVME9aV2V1a2NRb1RoSEhXMGJCazFD?=
 =?utf-8?B?MTBWZnM3VmZnR0hnMm1zT0RFNGkzajJ3ZUN1M0dmKzZBTU1Fb1crUWNKMEF4?=
 =?utf-8?B?M2FxWTVOV3RFZGFZSy8xNEpzdTFmR25Xa1NJaHFDOVFMbFdZTUg2SHJJRGxj?=
 =?utf-8?B?Tzd1N2ovL2h1TFBmUnJCcWZwalhjWVM5SGNpbGpjRUQwTjhWZDh0K1pVZVlo?=
 =?utf-8?B?eGxOYmpNcmVIU2oxNzRudng3eC9WWTR3bG9mN1N3WlpmTGR2cThGV25aOUpJ?=
 =?utf-8?B?SlZ6cEkwU28xYjE2RlVFWGdRY3lpNklKcnl1QWcxMktjQnAvL2VueUI4NDlz?=
 =?utf-8?B?cU1UbUdTUmswZGQzZmNPVTBxTEYyalZ4cXFobzdsWGxMODlqSUxtdmVYTWFQ?=
 =?utf-8?B?Q1FBaXN3WmppSzZOa1VFa25vbDhQSmNnUWZES2hjMmdlTVdGZXpPOXlhNWl6?=
 =?utf-8?B?cktIeEdVUW96QnVyWVBjS3dER0ZpWXpuNGN1OTloNkc0SFF6R2J2aWIvdnk5?=
 =?utf-8?B?RFJXZVprR3R5WFBxajdVaGRaVy9jcVdQcmJ1cDRMaDFvQTZaNFVvbmEvTE4z?=
 =?utf-8?B?MklpVlh3bGtSbi9hSTd1aTZ2RU9JbjVKc2grRTkrT1djclNoSGhIcHZPQjhx?=
 =?utf-8?B?WnA3clpMcG5GbXF4TXBXdGVtN1NEUjRVWjNUU1pGY1p4MHd5bTl6ZDNZVWls?=
 =?utf-8?B?elJpKzB3WlBPSW51UkRuWFJCMTJHeU0rbWh6dWdCZWFCdEV6dkdIWk9uSGVB?=
 =?utf-8?B?YWFSRGNhaHJkQ3drUTZXRTZkQjIrZnRlc3RiUU1iTVVnKzdLcEpZM2dieFU3?=
 =?utf-8?B?WFRwT0V2NkcyRktkQnlVMmtjTGFTeDliWHJndE0xeXZTRnpjSkRMRlduZmtk?=
 =?utf-8?B?d0grRFdISFArbmRSYkdyREJIMG5nTXg3Q2NkdzlOOTloangwdUlSSUJKUEdk?=
 =?utf-8?B?YjNkK2hIaXJNOTRDUEtUZnppZkVPS0V0NUxCU3BLMy90am1ZWDNJUXdsTm4z?=
 =?utf-8?B?NzNxWXNPdnRJaUZRQW5EMDNiUllXN1BWeTBGSllkR0tGcWY5aHVwNHZEbENZ?=
 =?utf-8?B?TkkyemNlOTZ3Q2ZyRnNsdmcwYWlBTnJiZjdHbzNiT1lZb3dqSHhwR3U3WDFq?=
 =?utf-8?B?UTVZTkxrL3I1UE9yUW9BMW94OUxtN3lsWFQ1U2t4YXZsR3kxNFpORXBQOFRq?=
 =?utf-8?B?UnE5Wlo5YjJrdU1jTkg3Q21RdUk2QVBGYjNrRGtaWDM5N29pOGpjVVc4cmNs?=
 =?utf-8?B?TklCUWRGNFI1cWI1Zjc1SmZiN1U4NXl2QkdsOFJuTkFqR2F4US9CbGNRRkV1?=
 =?utf-8?B?OWlaVnprMFY1a3dPZ3RCdlNCWDRGUXA4M1MwQmdIOVRKQ0JCdzgvallPM0lC?=
 =?utf-8?B?NTdRbFpub1RhdmtCNnFFbXpRN01TVUsyWWJtZkJ5elJpenZUaXU5czc5MGVT?=
 =?utf-8?B?dlA0aVF6UXNLaFBqc3ZpNUhVWldXd2grNzJhcEtJVmhFWkZORVBvWmJWQVJl?=
 =?utf-8?B?UTF1clNDdVpaRHRsTW8wbUxzSEZzZnJybWhzVklPclVGMmQ2NkdHb3lhb2RJ?=
 =?utf-8?B?TzBlZlRmOG1GNlRLTE55Z3U0cnpJMStmdk43UzVGYUFHL1lydnR5eVBHcUkz?=
 =?utf-8?B?ZTR3OFRma0dVMjRHQkFBSW9rN3M1ZTVwZTMzSWt1TVJEbWR4a1lhcm9FbVY1?=
 =?utf-8?B?TGpRMnJ3bXg1Tll0NzZwQ3diTUd1RW4yeS9CZmN4TFByNTlLR21MQVhaWkR3?=
 =?utf-8?B?NFR6T25uRmZtVk1JU1NGT2FSeEhmcWd5NFQvNFAyZnZMSC9KTGQrNi9aMi81?=
 =?utf-8?B?dG5jc1c1dU9NWnpQdWJQdktrWmNKdmJoNTVpNVhrVVVqMFJvejRVSndnd1JN?=
 =?utf-8?B?a0xLejlDUmhXNkdhQ1h2ckc2VEJFdVBwMlNkNC9KckdhdFJFOUVzQi81bjIv?=
 =?utf-8?B?NFZjc2p6eHdqaXhabUQvRjlCaWljaU1zVFdack4vMjRxT2VMS0g1ZHUyQUtq?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adca4c2-260f-4b08-3249-08dba864dd1c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 07:52:16.5794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMGvtjPxv3ArX4MxrHE4lsBUXZxeGmDZj3pOvdlZVN5d+s4zmki3roQMLW/hiDSVXzBux9YcmuZ7zfrbEkDZwwTtwe4TVJUIBirkhQSYlt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9372
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add epoll_wait05 test
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 8/29/23 09:25, Cyril Hrubis wrote:
> Hi!
>> This test verifies that epoll receives EPOLLRDHUP event when we hang
>> a reading half-socket we are polling on.
>>
>> Implements: https://github.com/linux-test-project/ltp/issues/860
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ...
>
>> +/*\
>> + * [Description]
>> + *
>> + * Verify that epoll receives EPOLLRDHUP event when we hang a reading
>> + * half-socket we are polling on.
>> + *
>> + * As reference please check https://lwn.net/Articles/864947/
> I'm a bit confused here, the test itself looks good, but it references
> an article and a kernel commit that changed how polling on _pipe_ works.
> The kernel change literally changes only pipe_write() in fs/pipe.c and
> this test actually tests inet sockets.
>
> I guess that the confusion is caused by the fact that the github issue
> referenced the lwn.net article as a reason why we need more epoll
> coverage, but these tests are not directly related to that commit at
> all.
>
If patch is fine, is it possible to push it removing the reference?

Thanks,
Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
