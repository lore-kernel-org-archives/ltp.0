Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F32C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 16:28:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E77C3C954A
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 17:28:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E793C8F15
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 17:27:54 +0100 (CET)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30123.outbound.protection.outlook.com [40.107.3.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 77EE32001AC
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 17:27:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFjg1FfAfwkEbN8q7M7BEdPg8t0Je2EdDhEwy37/NanSOHqyWOxJTqBi6ymo4yNkpCYnG60SFfQ5mbEssH0zmafcJ54daCZAjouwP++8f0Q54dhTul/bByhfuJNrNcufzfrQEC7HJJr+PjKwsllBzniH404kqH8/Gd4WWMHMscVdhjVhZ/ImTK8egqiyV7Cofr/wZIwSADgpiuedkGo5bNLTBOes7cYNftyo0ihVDRcpb8ltlKdwTIbFCz+2ClG3skR2XJDrVyKt7dYwJJ1QVuoj9W7S+D5uQQ5gMFZPOmsdkTE3bK5G07+O3sdzuaXUot/nCB2yDNFAPbmp0+r1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1f/FuJ89inGStXbJmESpRSUTUyyjH/AtsS1CV/W1VW0=;
 b=H9DRuaouWS5Eiei13soAwWugZSi05D8BsgGyGO+6GTcy0jO1IgZZVeUZAwNyGNeZi8woSP8G5vvQTi4pnWs20wnkt8X3YkwcLFCz6fxl3XV0hF/xnIvVvv0UIJOlednBuvgoWIRw3H9dLDutGOkUFmTN5OpLiKJbud+IELc5CzdC8D0ILBl7pzWzDQRSEBICEnygw5Cbx69wB6piTPLGRyr0qogJKvmGtThqS7X3/s+KVYzw/K4jPSYfitM3CwHZRIfWMr7d6ksoFBoz+l1VH3KScnL1R3oaceDpblg+p0vVdU2r/KVEmpyz+4riH/4gAb8JMf7PRXEW4i6g/z31oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f/FuJ89inGStXbJmESpRSUTUyyjH/AtsS1CV/W1VW0=;
 b=O0xu7L4m2zSl61lRxougf26n9ln0hn9cWsFHJHhvp2ooPdW8nn0tXS9oUV1cpOVisZDuyV7N2+3dcg3VPMQ0dVqapjK4Rwtq6tgzmkKbRzzKMOeogU975uiDCUNTOvxU55AvUu4JmAP8Hcal7WKH7d8ufEVWREylgASVHwbQI9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by AM9PR08MB6004.eurprd08.prod.outlook.com (2603:10a6:20b:285::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 16:27:52 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d%3]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 16:27:51 +0000
Message-ID: <590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com>
Date: Thu, 13 Jan 2022 19:27:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
 <YeBKRoYuuZFVBmHf@pevik>
In-Reply-To: <YeBKRoYuuZFVBmHf@pevik>
X-ClientProxiedBy: AS9PR0301CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::19) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15dd17eb-b7ec-49c2-7d6c-08d9d6b1a4fe
X-MS-TrafficTypeDiagnostic: AM9PR08MB6004:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB60047C4C90DEC3A3A3FA3D19F4539@AM9PR08MB6004.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAwjtpN6insF+bAKP4HlMG4AeNapY1+xbe/Cz9FGiMkfb4FY0ugB53bxzLy6AqEb/FpbKs4+QIoecnflaHSayhuH3GJv5bsUR6eJBrkfP01Ta83QaUbBwq3CSdDp5ml9uzWPTO0lUf7BBScmitwTamodP7zQ0KFE60nsQWFfX+aSOndANCq3wzQaQvFMiSaTUrZ+AyEK96vcaqKRhiECGg12uIYcnxWY8wizZCDF4Ae+eZLDAPlyiEy7xXW1P1SAwV4AMxPSo7tD3goa7+ZzDs9TnNV3oP61F1QoRZ2zI40EiCz2LrvtxIhAy0fZZGry0rBFVWqx8h+YV3XAPP6+zWrwjWnqjGer5kA6oyI21In82fGkTfW9FvcK8y7dyvPLMqRSO+Htenkk2fD/qSOgL9XXAdccVntVWsU4pJxmSzggRrcqRIfQqIG5r6hWFJM6i+Z7kou7DM65AqzkXH8WqXtmX8X3fzoqHp9VJf1r3RpXDKa1+zEtw/ygchB8+MgRSmXIfNYgbu3CFBgLyGO9WnLmVpifPb21aS2XtP+PSmBUTHBolY+QcqZzynsiFH75/rM5UjwMyD+UeZ0lqYKGgIO0/xeMJ9CNPC3V+42wRyTC6zMqKC5RxIIhjb9Mq/VO0XqRHO39h2qww3RweDO9iRoHzbQJr4VDwvoHxtJaWygPyuxTMoypf/jQD3K8Ix+Rma8vgjqlu+ig7qcX6/fTzbUri0/x5rzhibvf6Iqh7cE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB5630.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(44832011)(5660300002)(36756003)(31696002)(26005)(6916009)(31686004)(6486002)(83380400001)(86362001)(186003)(508600001)(8676002)(6506007)(4326008)(6512007)(2906002)(66946007)(66476007)(66556008)(8936002)(38100700002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpPZjdVV0JLSExhWGhxQlZzM2ZyaWY4ZFVoeWpRcWRrSzBQejhTMnNZdXg5?=
 =?utf-8?B?N3pEYm8rT0QvbnBKUVRkTlRSOUorSmZBb1liWTRsRWV0VUpKZ1FOSFNJY1Bq?=
 =?utf-8?B?MXBIMXRRWnR5Ly9mRU16dDBMYk9QenFVK0wyY0RyT0dVQWxSWGk4MmkvNDdQ?=
 =?utf-8?B?aVBraTNacVhSdHFaZmlRS0hjcG04djAwWUhBRjdhSzE1dUMxMWJGM29wZlhY?=
 =?utf-8?B?RFdnQ01BbWYyQlVsaTRzRmU0V0tWcEZFaUNTWlpqa3plYml0dGZlNTRZTUpo?=
 =?utf-8?B?cU45VjNldktzT3VsUytQK29teElnMDlDTTBpMmhNTTloMFBEL3lUR0FXdW03?=
 =?utf-8?B?QkE1eVVpUlBxMTNxY3ZvZ3RZaEZUZFlzRUI3QzEvdzRoWldkRDNPMnhXL0Fr?=
 =?utf-8?B?ZFI3eU5FSkNROGFYUXUyYmxXRit5eWNITXlCZFdaaEtRMzVuQjVMNW5ZWGR5?=
 =?utf-8?B?c2xSbXlQTXMrN0Y5WXNESFNhcjlFaFJzcC83Y0RCRW1ncTJDN0srM2NscEoy?=
 =?utf-8?B?dFBlQnZtWkJURTArOUhYOTRtZUVmSEkxU21ZdHdHN3R2MDlNUWZuQi9yQjV6?=
 =?utf-8?B?Wjk5UjJRellnYjBMSWQ2TTNxMW5DRnlPSGIyK2Z4cENmNDlDU2ZzZlhPM0dH?=
 =?utf-8?B?RkNqZytJSWplTi9OU1VzWlNaUm0wT3l1STZySzQ3MEdEaVNTWXZPdzBvaXZG?=
 =?utf-8?B?bGFBeVVZRnZTSHMxdElJQ1FSaW8yZTVDbFZqKzZVWXE1Q0JucVlXa1pVVFRm?=
 =?utf-8?B?c1ZlcDF4bHkzUUtCMHVNWDM5cE5wM3A2MVVFL3BYN3NtN2t2MEZDU2Q0YlZF?=
 =?utf-8?B?Y1JrdDJyY3hnTDRtVXA5aDVRRmRoeitTMkdmVjJ3OGlFc2RXTWJCWW1BTVk4?=
 =?utf-8?B?dDJ3OE5uSUJ5NzNNR0JrUkY1NzZjeFJnRHpXS1pEZm44ek13NkJ3YjZWeDJT?=
 =?utf-8?B?V201UmJSOGxKNi9ZZzR2MlpaUVNRNVdLNFk1dmdiVkF1Qm5vQW0xeGpCQ1Q1?=
 =?utf-8?B?Zk9telZITzVwU2ZybVl6dXBkVU9yaGdCQXhORU9zM25EajZSUDVzMHNxMlpt?=
 =?utf-8?B?WkdZM0NwN0NsY1VERCtZV1RPSldGOXl0QmUrcTRoN2dDK01lSGxkUit1Ym4y?=
 =?utf-8?B?SmxKQzdwaU1Zd25yTUJFY0kzSG9ubDlBbnhHRjRHYkdzKytLVUVvQTNaTGRF?=
 =?utf-8?B?NFgyWnBPS0U1ZUdUT2pHSWJFWVNWcUdrdUJtWTBadjdlZkFxZ1JUVnlEaHRk?=
 =?utf-8?B?YktUTUxHWVdwUmZuSlBBUFVMR3hsaFM2SDZ4V0RDaGFRcUp1cGJZaDJzTkNi?=
 =?utf-8?B?TFFRK1I2TFF5dHRhNnJHRkwrRHlyK3o5M0p2blpHS3JZQ21vL3Q2cGdIM2p5?=
 =?utf-8?B?S3FnOE9hYXE0ODVLYmc3dnZOazVDUldyQWlhQW41TVJRakNxMEtnMmF5bm1U?=
 =?utf-8?B?dlBrNVNLUjNUc3Zyb3ZONER3aVdJdTVvdjB6ZHZpWDYvRjBkbkhtZ3lPWWpm?=
 =?utf-8?B?MFVZMWsyZjhtdzZOR2ZnZ2F2QmlobmIwaG5seWlNaXNuSmxOclZDcFloVEpQ?=
 =?utf-8?B?cUZrc2RtUlBqcHF6T0E5eFdTU2dHSDB2Y1pWSWs0UllYeTJVU2c3U0JhNW1p?=
 =?utf-8?B?ZnQ4SVJUVVhiNlBISC9ZZWJOZTdNTWVOb2hUcGFOMWJzdzc4TUpIUnFWVnJP?=
 =?utf-8?B?RzlaVHFxZFhFUHMrL1R1TUt1TzAwek4rUFFTZFpXMGlObFdxQU9TMlVvYytK?=
 =?utf-8?B?cE9xdmtKeE9QWUQrUFFOQVdWN1FPZGcyTXBuT2d4YjR4TVBDZFhRRkl3cmhE?=
 =?utf-8?B?cVhDTCtocWxoN3dUK2ovQ016SENLYy9mWjVkTHVNWi9lTFVlMDlMRDRwOVFP?=
 =?utf-8?B?NVVRcDBXUlhxazA1WFRxbm91dzlqTjdaNmgwZkpEb1VlLzBVUXI3MGI4c1dJ?=
 =?utf-8?B?cjl4NTZFekh2YjFmeThpVSsyd01Tdko1QXA3K1BSV2tnaG1xcTV2dkhBaFUw?=
 =?utf-8?B?bWQvNmdMTzFkT3Ftb2RpZGJWWHB4OEJaYzFTVjM0Slc3Zno2TllCSGIrNnlH?=
 =?utf-8?B?SHhBdzdiMmEzcW55bDE5T1krTkZQZWxZZDVZWkI5NHBhVmFWQUdOQ0UwMTBJ?=
 =?utf-8?B?ZlBEYVlYRDJ4ang1U1QrMmtHSzlGVjhYUDRpMkxsRkFhVVFQaUlVQlM5aEIr?=
 =?utf-8?B?VHMxdjJ2VEJXUXBvL0V5QUlXMnVzODJMOTBwS1J1VldDZ0RGbjNseGZtZnNE?=
 =?utf-8?B?RGhEVy9HSHlScjhtWlZRNHNmUGJnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dd17eb-b7ec-49c2-7d6c-08d9d6b1a4fe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:27:51.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abG+NGbAATdu1+j4rd4E7RzUIYlIE2DQpzE7/0Dh9MJcmig5u+bD7X+2w72XJUEplW1Pe6yGYU4dXi3b+7gEORDAxOfeENJv+Kjfky3f9gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6004
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib.sh: run exportfs at "server side" in
 LTP_NETNS case
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
From: Nikita Yushchenko via ltp <ltp@lists.linux.it>
Reply-To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

13.01.2022 18:50, Petr Vorel wrote:
> Hi Nikita,
> 
> [ Cc Alexey ]
> 
>> In LTP_NETNS case, nfs server is the root namespace and nfs client is
>> the ltp namespace.
> 
>> Then, exportfs shall be executed locally, without tst_rhost_run.
> 
>> Otherwise, things implicitly depend on /var/lib/nfs being the same in
>> the root namespace and the ltp namespace.
> Not sure if I understand your use case. Do you run rpc.statd (or what is using
> /var/lib/nfs) in non-default net namespace?

'exportfs' command maintains /var/lib/nfs/etab file, to be read by rpc.mountd when processing mount 
requests.

'exportfs' must be executed in the same environment where rpc.mountd runs

In LTP_NETNS case, rpc.mountd runs on the host's root namespaces
(and mount runs in ltp's non-root namespace).

Thus for correctness, must execute 'exportfs' in the root namespace.

Currently ltp runs 'exportfs' in ltpns, which works only because ltpns does not unshare /var from root 
namespace.

But not unsharing /var makes AF_UNIX socket for host's rpcbind to become available inside ltpns. Then, 
at nfs3 mount time, kernel creates an instance of lockd for ltpns, and ports for that instance leak to 
host's rpcbind and overwrite ports for lockd already active for root namespace. This breaks nfs3 file 
locking. But that is not found by nfslock01 test because that test ignores the errors from the very 
operations it is intended to test.

This patch, and the patch that makes nfslock01 to actually fail on errors, is part of fixing all that mess.

>> -	if ! tst_rhost_run -c "test -d $remote_dir"; then
>> -		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
>> +	if [ -n "$LTP_NETNS" ]; then
> Please use tst_net_use_netns (as in the patch I Cc you just now).
> 
> Shouldn't be also $LTP_NFS_NETNS_USE_LO considered?

The rule is - run exportfs in the environment that plays the 'nfs server' role.

I'm not sure about exact semantics of $LTP_NFS_NETNS_USE_LO, but per
what I see in the code, it does not affect how address in $mount_dir is configured. Then, it also shall 
not affect the choice of where 'exportfs' runs.

Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
