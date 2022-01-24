Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067EEC433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 14:26:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD3BB3C8B9B
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:26:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1EF53C875F
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:26:46 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80090.outbound.protection.outlook.com [40.107.8.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E630B6005C9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:26:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhV5Rndkj5Qng70nvSyi7tmJ/ubKsN32nRJJi2ckVGcxAORpCS20ws6H9wkg03NSVGZHUNiNbcnOCrWbVZjSxcdtVcyoKALLU5I5uxzfcsz8CK8WEWdcCpKrvCnVrhOKM/ngVA8J0RPIkKnhWWYSpbYm2c+SraX2mFGhcC44zQhCmIevOFQdtoQwv768iKdhnOHGXQ4GLOkzR3VJx3Rqwi8XOcvs6b3dgKGdchXEh/S7TtrHj/orEEFFugwTXaTHjLNhkFor61x/z/OKcBFN9LEuFMhb8R2LdGSgbwkFHQPRXRcmaVLSOHIsYwN0bWLgAE8GUErPsNgKsR0k+dsXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ/Y1aPfnpWij89gdgauo3f1GUKUcCRWIkMQ0vJ2+Ms=;
 b=gGJUd/G7ExUtBCdI7lvaJcu7tlrk2+OiwqgVDjuilIO/nCz3EB/QNQVs57Z3XZbzMqZGlzVBbyRR4yp03Aqka0dC6X3Ppg8qq68/YPP+YsS9nN0g4dTUxIfX5zvh6DZraezBgeN1qaUHGmWv0xKGXt9LbDZKq6kyq2OH0v8lWNQjbCqSRxSor+dAe51LoV35whGs2afahsJJw+9Szlo9So0sJl+9rCa9xcG8uyvsIoWYqlMCMcSFmqV0GIdgcbYoNC4cyaQFHlKIp3KFrA+mi7L1JlsizywPe0O7BJAbxGMILt9KMCGy/1XYMcBAyVK1xc6edrdQjY3eirpJ1doG5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ/Y1aPfnpWij89gdgauo3f1GUKUcCRWIkMQ0vJ2+Ms=;
 b=B7CHziW4radFHykEJsFaFHBbal5g7OQvB/4MMXdRuuLFC9SjXd7N2tqY40p08LQw+drsBvIY48CVxia9sr7pOwOzfM16uNuf2LIs4n1pf+65nMTIf3RKictmF2SJVfovUBWbisA0FAGbgSkPuywju+CwT2gAQXy7ftOpQt1LFec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by DB9PR08MB6570.eurprd08.prod.outlook.com (2603:10a6:10:251::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 14:26:44 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 14:26:44 +0000
Message-ID: <d566cf35-7e73-5052-4f77-2bbe05ba8904@virtuozzo.com>
Date: Mon, 24 Jan 2022 17:26:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220124065937.17383-1-pvorel@suse.cz>
In-Reply-To: <20220124065937.17383-1-pvorel@suse.cz>
X-ClientProxiedBy: AS8PR07CA0039.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::8) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d9b132-6068-4eca-5a08-08d9df458ba5
X-MS-TrafficTypeDiagnostic: DB9PR08MB6570:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB65704446AEE11E6AF9B8DDC7F45E9@DB9PR08MB6570.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LP5cG+lFAfQdcieT7t8K8lENSHRSO1b5mkISOg5JwzwLp7UKchB1/yNwrudH8++A/WKazFz9s0l1u9P+aIJCN1DRjOPGYXEz1H089InThwdqTnZC6jLv0puXxBgginJb5lXds6pfKwSG83db9R7JuFXaVOlHhhcSjqpD+npRL3XgCpvJzXpZ+Bmg/S2GOCJx4+J6vRN3IhqQchP9WvRgnUZOFiwPiwkEJikyjnCq8BjdBUoYmqPM48KWRSgnlzuoQurflsoPWtcWgfZuwVxqfWfHIE791fcEVVsjFFJk/Wn2rnQ1BOE+3li6CTQpg0j7qC68+q05yH5HKmvF/XWiQLWqkLdrjAGBJ5W7YYih+0K54Cdifyy4UDOu4abzE0tDjNygnRtm6Z9kbWjTOhReS+1H61jj0IsnDsUJmZMfiCk19XIZRI0tct2DJ2dTLg8XeVUf5HvpLRi7Bk8giTFlS2C2cqvEMN3TN9jR4/r7GzV+KdQ7+ucY/fUaWYq3uzwcyUpilxT8nGGs+YkI/qTYYrhUaZU2vLBOu2eAZ5Yc+0cxk3SC0GKO8MlOK6VPBGmpDF9DpbxXEbIf9n74LEKqbA72TTQEfvXWplZmKNHWx6+0ip6qdVjy0qETnxjbhVztiiI87xQlkD50avRoGG7SMG++damaAzFSHYHOToIaWQf7Z+27Hxn55YSVfHXOJeiAIDcKTGIJFpRZPtPZnBVMudvTNDHVCRhRkhgWnpNFLd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB5630.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6486002)(8676002)(83380400001)(508600001)(44832011)(38100700002)(186003)(31686004)(26005)(66476007)(2616005)(31696002)(86362001)(2906002)(4326008)(36756003)(66946007)(66556008)(5660300002)(6512007)(316002)(4744005)(6666004)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFpQQk5JM1RvVkJVMW9kZ3ZvMGk4bHVsbHVJVUtNdWNoMGdQNjNvOUhPVkFY?=
 =?utf-8?B?TzM5bkI5MnRJMlQyM01KQ3JlR0V2TDZPK2J4dzFwenZVK1AxZDZPUDZoKzhT?=
 =?utf-8?B?MTI4MkNkc1lmQ1JucWxWQ3lIT1p1M0hFUElGNENnR1J5L1FBQU1xM3ZCZHBX?=
 =?utf-8?B?bnJnQ1VyM2R1WEE1eWVvVDhJOEFtNURRK1d4Qm12SUFhd01BSlpFb0RWUjJz?=
 =?utf-8?B?K3lLY3dzckE5dktHN2VYR1c5Y005UFZyTnJJc0dWMUJvL2RmeE1SS2VyTjls?=
 =?utf-8?B?UlVNUkQyc09UUEtmZEQxWjBRZTBRRWxXeS9UdVBuL2RyRWU0NUhtb1NWVFFF?=
 =?utf-8?B?T0s3c1VMS3M0Um5NTWMvaDR5T2VuWk44QW5Xd0lUZzFnOXorZlZvdHR6aXZp?=
 =?utf-8?B?bGgwSitnT1NuTmtQMVZybUFUY0lkb21jUGIvMm1qWnJ6Tnl0Q1lYcjZ4ZFM4?=
 =?utf-8?B?RE1OaGlJTTFOR0k3NGxydE83K0RMZ2ZEOU5tWGU0S3NEbTFrY0hjbHI4bDJM?=
 =?utf-8?B?dURTL0JwVnZORXNGcTAwVWpVTW9xb1Fjb0Z6c1JROWRsMXFzN2xDaW4zU2w2?=
 =?utf-8?B?Ujhtc0VEWnZwejZrbXBad1JCNU54d0lPMFMrU2dCRUV0azM2eFZUTDBlOERa?=
 =?utf-8?B?UDRkK2xTYm1HV1h2RDVGVWVFQjBLY21LbS9aRzZqT1c3YVRxMVl6OWV3QXo0?=
 =?utf-8?B?R25TLzF1YkFYanlFR3NyUE9uUy9xNTBPdkNLL2crNXA5MEw5L0ZlVnQyY013?=
 =?utf-8?B?Z1g4cUF0c1h5Y3JZaWQ2aDZHZFcvMFB6b0dmYUhNOEY5UlJ5aWVsTmpBdDU5?=
 =?utf-8?B?NzVMN3RVK0lGemVDY004R290T3JXUHgvT2wwYkxjT0JucGhnaGErU1YwaHg5?=
 =?utf-8?B?czhqZ1p2WURYZGdvdVMrT1NFcEpOeGY0RzE2SFk2bHEwMS9nQ1JEdmhVQTVQ?=
 =?utf-8?B?QTE0U0hNYlA2U01YaFdUOVh3SEJHcmpzalJRR0RjRU5CRCsvU1BITnRtdG5v?=
 =?utf-8?B?NTJYMkNNNHJLUUdEM1NWK2NWbDFNWjRWOEhFSUZOK1pBOFE1TDkxZk9BV0dm?=
 =?utf-8?B?Z1hjM3NrWXR2Wm5VZnU5blBEdDBCQjVCVEltMVNtSTZza090OVhoN3RxQXlS?=
 =?utf-8?B?SmZFcFZxOHU0cEJoRGtJT1BFeHlVaWpmbTlweTNydktuQmtjakRzNWJVQ3V0?=
 =?utf-8?B?TTlaZFlHelJEdy9kbGN3N1hxV2V3QU9hRFdhQjRTQytvWFd3RkZCQ1o3cVcv?=
 =?utf-8?B?akJVcFhMNDZPeUh5anRlVXh0VkxHdlo5OUZScmhWNndXRXkzWXp1SkZabnNX?=
 =?utf-8?B?ZHNOWnZ1S2hFcktvSnMweEh5cUszMVZMbUxNVEtjNlo4c3dJNW5VYy8vdkt5?=
 =?utf-8?B?ZllnWnRRbk1ZazJwQW05ZnpaZHBLUENyRFNNZ0lxUzNERHppclRqYTVtRVBL?=
 =?utf-8?B?WGtzN0k5aDEzNlo5UlNaeFlteTlWTVB6M3RxbG9BZklWS3h6MzM0TEx6Qk1a?=
 =?utf-8?B?eDZFbk1FTDk3VXhpalc3S0ZUL3pta1NPUFFCZzdJb3JjMWxsNXZGOFpXREoz?=
 =?utf-8?B?YkViSjNrOTg3TUJZUWU2UWJaR2FDUnBDbDhTYmExRm1kNll2WEdVaTlMVlls?=
 =?utf-8?B?VlA0U0k1eHpWdnFvNTJicXJ5NzFLSDlmRnp5UE1KVFhHQVg0NmhkRURreEZB?=
 =?utf-8?B?QmFJa1U1U01zc3ZwZmFabDRqbFNBeW5UeE9Rc2RhVDNvZ1dXVlNsK05OcUZt?=
 =?utf-8?B?aHkzRGdRY0VVS3ZBN2hyQ09idDVlWHFCdGEzaTZBbGVndnRQS09mNG5aY0pW?=
 =?utf-8?B?K1FjQ2JRVkpzcU94S3pTamhOb0N4aDNIUDh6WTlDcGJpQVFzL3VDaitSVnBz?=
 =?utf-8?B?RlZnN1dBMWd3TFI2R3d1L1hPVmhmWFI5YUhOZnk0MTlOSHl3TXdXR0JiYnJq?=
 =?utf-8?B?TUtodkJvL1ltRWh2bHRnOWh3cUxIOWgvb1dpRXJmalJqdDloZnY0UVRKNXpH?=
 =?utf-8?B?eGhNMDNscnN5UlhJbTJUeEt4TUJvZUdVTjIrMFpGVXRpcDlPRUNqYkoydExi?=
 =?utf-8?B?di9IcWpsbjRaTnpTcGZBR040UnU0aWNOMWtNVlNZWURwWU9hdU9NVk81VVd2?=
 =?utf-8?B?WEhjTnhFeFNlL2FZcnVkUzErV0RONUkrUHp3Q0RxSDJBNSszaU02SkZBQ0ZE?=
 =?utf-8?B?ajBXTEpZaUJrekNXZjQ1dTNiQ3RKSzBuMjBKdzgxMVBySXJDWkxoS2pNOVpt?=
 =?utf-8?B?TVZWOWhmRm9vYUx3QjZlSHR6YmdRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d9b132-6068-4eca-5a08-08d9df458ba5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:26:44.1679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzHgAMdm7xO+GBmbNLaJbBAUxc/nnmxZ0/0wcbBiFbFulDW686AT44kItuGv2sUIhlgfSMpW9o0Z0lSkeCg0+UM8uClyod9PKd4Evkoz6EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6570
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] rpc_lib.sh: Check for running RPC
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
Cc: NeilBrown <neilb@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

24.01.2022 09:59, Petr Vorel wrote:
> instead of just rpcbind/portmap was running.
> 
> This should fix problem for some containers where rpcbind has not been
> started and calling rpcinfo should do the socket activation.
> 
> Reported-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> Suggested-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
> 
> Nikita, does it really fix your case? Or there needs to be 2 rpcinfo -p
> calls with sleep in between?

Yes, it fixes that.

Btw, easy test is:
   systemctl stop rpcbind.service
   runltp -f net.rpc

After applying your patch, that results in no TCONF from rcp01.sh, because rpcbind.socket is still 
there, and systemd restarts rpcbind on request.

Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
