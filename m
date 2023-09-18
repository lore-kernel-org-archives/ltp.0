Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4232CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:07:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23FF43CE4C3
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:07:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A1A3CA9AE
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:06:53 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C77B5102F3E0
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:06:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+hwWgdKQBYsvEEnIbXLhxvoJrXJaY/04uL/+pdMG6qpM7TJBLQNXatQRY9jqlrYxK6woCltjIUREeIiHC/2ouhx2TUwdGDEpAdFys1xDIX7WYAxKmVPr/5DIixirTbUj4oeQauck4WyTbAgoI7oQ7zWw0902nrGU8TiphQ7I8WkxCvTuxOEYW9/G4VL4Fd6TZ52zK26K9pnvJWnNYouJ7+ID91ArIWKPB5DZCxmFKWh+xW+wJYV0LLzgO8L+SXZxC8ap7k7kLW3ifluEwNXAV3gHKvLcnz0Ol0dq4CGNppVzNFicBBLrO818Ww7fnICdxmzsAfJZR16pSScXQVVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/4SDpJD8N65mVYMAgTIUEmp0z0V+V6T1T0K8ToZfyQ=;
 b=Kr5Q34ENaCCIgwfMt+SiR0Eed/SY0kzL58/BjwEso4nC8Nh1FRwBModEpa4bZaYZuWXnfPvXWgUwcg8ICkk74fu3x+1uI8ytOo3qlw9ESBRpjYN+sL9y3JISAgss9EbH4XfDKk8IdRZJ0AZoameLIkf0iNym6aTP1AIptWHht4uo0EMKoTNXtJIjbw4yIyCa66OWPEsCq+INkHM41LVgnpBo3rp3Bwf1oEhmhofwmxdZ9jSBVNTgpOh3ebqiP6cxNEUjxzt60RwZNUG8h8R+Mzvx9HvHjp1JT8DUIvxWTXvOUmGr8wRIYSVFB2q53QKkKiAno71r7miWv8RCX6BhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/4SDpJD8N65mVYMAgTIUEmp0z0V+V6T1T0K8ToZfyQ=;
 b=1rGRms/dQ9PPv7vGUSdtN7uBd+JxuuKH4xzDr8rXBFsPpV6U9FuVQo3OMWVin+SiuIE5+0oB5fufWNR9he45JPLHR80f6CsD1bzpQdGHB75AszzIJePWxaldrsXw+MwcdoSiPNQLLot1fhPoELEyPd8y87fN2R6/ik7qU23jNUKaUhuZSxFHp4zq0BDpPKgVNZ80MK6b3kdi9x7Obf2uhLB0FELyJpRbUaEPOF6pn9YDiTIWAAvbIEhjpacNo0/Pb1LY4wJyJf6y2pDyDmfUmC9VQsIKDxHqtYSB5b2m3iAIx5gp7XbzUE8NFwJaqEzN+0SXP7rO7IMM99vJBWgO1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:06:51 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:06:51 +0000
Message-ID: <43565f36-60f3-4ebe-894a-31442ad018b3@suse.com>
Date: Mon, 18 Sep 2023 11:06:48 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
 <20230918082506.17464-2-andrea.cervesato@suse.de>
 <20230918090136.GA30304@pevik>
In-Reply-To: <20230918090136.GA30304@pevik>
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 615b319e-723f-4fe4-9069-08dbb826989c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUT+pE/uzn+V/tbpU8GJU9k9/qn2pQ+wQpNdddqia0RcF9jNDWpZp4KeWHFssB2TpG2nxjKfkrjV9PO/EE1Jfas2Hfs3qqA4HbHirwnaiaPbicYZLGwp8PJv6DntkemDxczi+nAeyicSCozVsZe9lwMYe5Ss3C4l8rUX9Is+Pi+n1UXAG4KQJUnKA8yn9i3H+hFbZoIhOcUV0633SHQXQTuJDkFQtbKifC1iEhwFJklnrVTwWLxoFWR1S7ovOGmPDS4jQKg7EwXPBPye+fZvMHtGNcRoc+CILwnd6m7g74Wm4zhsDDQQi2dGQyo+Rn8+gt8H72X8LwCItxzsj2obD96FVun3oX0xRwvxYSS5kxhFliLbYvr1mbXhWEaI/YjxmovValnnWjaawF6DsxgGlQPbY9kY6jhV7yOclc+gW2bQE4E6uVMUtAyaBj/AIo9K0/UlFytmqEtPQaiWqszal1zX0jIEhWY91OY4Sq9i5F9r38YxKWSXRXhxIX15H+SytI4duUR3QCqs/mgCwI5cgoG6ckZzduQoj7koTAoAfxBBW9YhBx04xPhCTwraxqyyzCr24b0IgUi66t0moLInjZD4Yce5ipmPGbw9HtCPNodVocNXkqic/wdpLMS28nbskzD0kNos8PmO8K+7QO33tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(1800799009)(186009)(451199024)(966005)(66476007)(478600001)(316002)(66946007)(110136005)(26005)(53546011)(6486002)(2616005)(6512007)(66556008)(6506007)(6666004)(41300700001)(8936002)(8676002)(44832011)(5660300002)(4326008)(38100700002)(2906002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRqUWVJbzJJT0phMU9sUFZNQ2dKYzBaS3pkaGxRbmozNG1OaFdyNGo1SDla?=
 =?utf-8?B?RnNURlh6OW1nUDhMSEliOU9JMk11Wjdvbnp0TDBMdGxlQzE2Q2s1MExWcnZI?=
 =?utf-8?B?VUZoWkVRR3RDYlVIR3BLWlE1aE1sK3lUSWlKV2xPS0ZGeG51aW9pcmFsV0pE?=
 =?utf-8?B?b2ZSdFhFOHROVkxraytlRVBkK1o2c1kxc0pzSisyS2VvUXZQRUdxSXVUZXBK?=
 =?utf-8?B?cE5qS3RnSExIaDljOEowbmV0VW14YkM1cU52Wm1wWTRsTnEvZElWRzVLenJw?=
 =?utf-8?B?dmJzT3ZzUlMxYXF5RXpNYnNqMk50dzU0aUtHQTZuMHBNZE9LMWpCNysvdzFU?=
 =?utf-8?B?ZG9TV0FPMmNjY3g0R010RWVQdGFONStNWU1SSm0yZ25sdjM0OURRZTU0RHhh?=
 =?utf-8?B?Ri85Yk9Sd3g5NUlDUVRnU05pWlZjdGhNT3RlaWNiVkMwN0tNQlBYUHptKzF5?=
 =?utf-8?B?Z0R4eE9Kd1JQTENqRkxiTjJxQWZLWm5BejdkMFA5TnhoOHE5bW41TEdFZ1dM?=
 =?utf-8?B?cFI0ZVV1aCs4c1hHdmdqWnUrWEc5OHZDT2lXRStLTEwyUnROc3M3YlZYN0Ix?=
 =?utf-8?B?Q1EzV0JRSm03SWtxSHV0RlA2ZHdpSUhwc1pwT1h4ZmZqVnlTK1poaFpTcWZj?=
 =?utf-8?B?dG5GOVM3Z1JoSUJ5K3hjSC81NWZ6Rkw0dWdnblJnaTBRZHBTZklVOGRrZmxU?=
 =?utf-8?B?eDU2bUFMekQwcVhic3ZRRGhWbjJtcm9ndXQyT1dvZHQ2UkpIZnV6STNmV2g2?=
 =?utf-8?B?S3FEbzhabkFsYUNPa29LODB4YVVFZlJHN1RFQThKTTZ1bWxRamgveXB0dFEx?=
 =?utf-8?B?T0ViYWtmeG9OSHNMZ2NTZVNNNC9SLzNvU2doNFRpSXV5aVlLWVlkNS9qenlD?=
 =?utf-8?B?Yy85bllWRTRkNnRQY2JSUnl3VEh1TzFlMStXQzNJYnBldEpnY1ExRi9ZOFZs?=
 =?utf-8?B?TGgrQnJoK3JUM2E0bnRBOWQyMFVPaUQvWWx6cGR6Y2pCS3ZQc1BXekxBRStM?=
 =?utf-8?B?Z3EvOU9mSVZNK1htaVlaa1V2ME5KNWs0eCtQbHMra2ZHWmRQdC84d1RlV1do?=
 =?utf-8?B?YkpBUVNqTVp5S3dYcUc2Y1l3UXVITUtCTHNMM0RCUkhuRXdpanJqQk1uNlpQ?=
 =?utf-8?B?U2p1SjVUNG1ZSy9qU3lPdEhEVzd0L3UzN0RmbTBpZUJqMDFGK2RUR2g3MjV4?=
 =?utf-8?B?bmxTN2tQa3RlaWkyd3pyWHZqUDg2bTV0WHYwZXd5SHZSUnhKSWVjenkwUVRB?=
 =?utf-8?B?bzFtS1NOMnB6bk5ad2MvY1lhaW55clUzVHRsOTZ3MWhENGw1R3gycUxqMjN6?=
 =?utf-8?B?Q3EyTU9jRVVOUHd1cXpVMEpoMFptTmd2RVdFekdwQUlnTXIva245UkNlOWdU?=
 =?utf-8?B?bXNXYU1Wa1VlU3RvOE5aUVpPQ3VtdStHWTc2R0xUaDNWZlNBYWdaaHJXMW5O?=
 =?utf-8?B?WHVZS2NIMUdBUkh2Q2cvdmUva2dWMkg3aGtQOVlzcis3NEl1U2RCbUNLTmFw?=
 =?utf-8?B?QUVzdFo1dndrNjV6RU00TFZzUWxMM1Ric25PY3UrZnRvRy9aWG5QeU5wZmEx?=
 =?utf-8?B?bmZhOFllUW5Oc1pJZXB0c0xNWkZhZ3F3emEyWk9udlFRbXZmNThuRmpuUUpB?=
 =?utf-8?B?dUJnL3BqaWN3OFFaWHpJbzYvNE1xTW1GUi9pRS9DVVBXQjBjMnFkU2h1SVdi?=
 =?utf-8?B?ZTUwaTBuWHltakJvWm5JQ0JnL3ZET25ndEh2MFZHcnkyWkQxREg4WVZFemtq?=
 =?utf-8?B?dnR3cWhpS1J0RUtwYzg0a09xTjZxL1dWM1JQSDNZUGFwQ3JLWUJnNXZKQ3F6?=
 =?utf-8?B?YTRzOUZaVGY2ZlJKSWNGOWZnOFdKMFVFNjJJOXo0M29Ed3V0N3oyV1N1cUxl?=
 =?utf-8?B?bUovK1pBZlE0RkltSFM3Z2Vsb0Rsa0F2UzhLRXdqZGFjakF1V3pGaGR1bXJX?=
 =?utf-8?B?WU9US09mRnB0dCtPbzAvRmpYWEhQTFl3T2hwbUQzaW9qaitqRVpia25CT25t?=
 =?utf-8?B?VldmYnpDRm55Y0RyakYzbGdjK09sc1lITU5zSkhCS0VqNGFLWnAwd0sycThI?=
 =?utf-8?B?RmdZV3grb09teGI3TnpweC9TTmQ5M3FJd0Uzbi9lenBNZlVYUzR5VTRTNWRr?=
 =?utf-8?B?Nks3OXp5SkJhWEVjYnBHRWdTemNrS1dpbkNVWFhlQk1Yb25XZ3h3T0xvdlVk?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b319e-723f-4fe4-9069-08dbb826989c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:06:51.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 236Ny4dPlkmaC0dI2+wx/b2jPKiqo3sfUMd9cfXG15EKYfyIilVnzNsrp8bQM1w32ON2sIvZYfPa7AUn/Rj4BKkpK/WMWdFYAaeo/DNz5YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Replace runltp-ng with kirk framework
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

On 9/18/23 11:01, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +++ b/.gitmodules
>> @@ -7,3 +7,6 @@
>>   [submodule "tools/runltp-ng"]
>>   	path = tools/runltp-ng
>>   	url = https://github.com/linux-test-project/runltp-ng.git
>> +[submodule "tools/kirk"]
>> +	path = tools/kirk
>> +	url = https://github.com/linux-test-project/kirk.git
> I'm not sure if anybody asked you to keep runltp-ng, but I'd prefer to remove
> runltp-ng as you did in v2. I don't think runltp-ng was really adopted a lot
Yes, I forgot to do git rm on that folder.
>
> We should have runltp-ng symlink to kirk at least in LTP:
>
> cd tools/kirk && make install
> install -m 00644 ../../tools/kirk/libkirk/*.py /opt/ltp/libkirk
> install -m 00775 ../../tools/kirk/kirk /opt/ltp/kirk
> ...
> Here I would add
> ln -s /opt/ltp/kirk /opt/ltp/runltp-ng
This has to be done in the kirk repo.
> ...
>> +++ b/tools/kirk
>> @@ -0,0 +1 @@
>> +Subproject commit c7419dd6f73d90f3f02aa17d30270e895e30c88e
> +1 for fixing this.
>
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
