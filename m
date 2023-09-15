Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29EFEE6459
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 11:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E01E3CE6C4
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:29:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5703CE684
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:29:24 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 30FFC14088ED
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 13:29:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi1JLAzf5yun9T4BLsTjc3iPerzg/jDLrlRpAGg1SLK5m8OWReERSc5xb94ZnqzsvE7IOo/PraFpYxIgpQuY8unDnv+wmf3jmQeNXRfgCE9zshwre+v1gj8aLFdTRFLhj9F+UOzIWPIOQhhvlwHtLY9uQGMCKmd9wUJLDcDp8OiLskP9UGqsVoihF7Nffu3aN7RghWeLASUBDoj0H9/TfQ0qSnqzGulnLzrOjmgTVP3dR/g1JYxOiEgTNCggXkkKoZR9Diy0beCEEq6IuTs6mfgRxRnBaN+1/VWrdcoxY11O5hJSx471UgImnWXR3NdN0NarmC/qspwCYPKvy34RrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLjKsn6Ia233Bmqmp4fZfI9Jolgg0I463FyCT2Fc5y8=;
 b=XWgD8RaDHWIGVdYfRIv73Lsg3jyJpzCadykWUDuKXazpmcto7mrzm9IE2SM5Y8TBqyioQsDKNvcR32pDWs+pvW4bOIJDq6ujczYu/+ynv2ROJ03UGQeNv8it0b0PbAb6deAOTBgT+guCDhK62IMXkhE8r76KpmvFsC9ihl35/5zameO19yQvZOvuqyRVo9Yy+t2JHOMuQig8mSdppQbTExPm08kckE3uCk3n5VuZEzNkRdmF0gYYP1RfjkIDqECKbEhemj42vtfMLT6X08a6LQVi27VpN55+R9+FOpf6kzi+fnUy/7Tk0o2Hi3iWfccXJbhVZnhmGkYjGjK2dyTX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLjKsn6Ia233Bmqmp4fZfI9Jolgg0I463FyCT2Fc5y8=;
 b=mnOM7qwBExl0mxhTQkDrsQb7X1SR7sgj6bU+z+HK5EZv6Xl6wPCCI42/CBcNq7AbbOGiTMn31MJO5itSz0gTkhBbD3y93oNixZFOOTZkf5zyuyrUZ06hKPZVHBRIx+kgiUvM7bNkY03IBDTnpXSauEhi+n9HaBYBQZDCSweLntapFPNBIKnhRQCyoAYMQ9Zp1QiJt/Yt7Hk3LaAHB7xknf0TNPDxy/uQt6fznDrR8axZl+z1gsquyBJgR4M3miDMl9K/7Sh1psHGKvoQlMCmYIPjAQgSt5t3xyAXAjdhGCGV2NGnB0axEfBNxTgJgTh70i0y1g95Ii3WlNu7XE1n2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by GVXPR04MB9850.eurprd04.prod.outlook.com (2603:10a6:150:11a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 11:29:20 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 11:29:20 +0000
Message-ID: <cbfb41c4-9ec5-494d-9b86-1e67d7e16703@suse.com>
Date: Fri, 15 Sep 2023 13:29:18 +0200
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20230915091547.26270-1-andrea.cervesato@suse.de>
 <ZQQ4ax1A2ZkFNwIH@yuki> <20230915111924.GB46324@pevik>
Content-Language: en-US
In-Reply-To: <20230915111924.GB46324@pevik>
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|GVXPR04MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5825ad-582b-4b74-64f8-08dbb5df00d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A9stTWqzoKi3B5Z951GgKX3hyn3z1POIymkCiHvzYkVQEmVr4wc0G/d/eqQJpTMWj99/UcdMP9mK6v3bUNUgxc65eu93JBhhosCnR6UzNvpqwQqUQbpC0E0HhAPpu8e4UG35C9DTCVDfivkA0WaAE2ljLhSUd929SY9CnAhG1NofnZ/FwSYhulaRFB2JF6MEGhwibIMoVEcSdlervZqr3YfXEtlDWpXcydBkmU/a/71GY0NBdDYYceo9orF8Uq8ysvOjKJMzVdKDkPubzwiVuHh7Qsdm04nRPoe23FA54/elBXNMQfPd6Ymz6PLk/n6noKhjOVb3ejLYqYlcSz+kKsqgJcKWuCXwzgWTTJqTxjXGt154N0rJs1opPuUrpr+AveDSzJV4x00j7a9lhdd5gz2oH2UwPE52Iljzkzvgy5ei64/3nJqGDuMT0kBzYy0CL5qToEUTBs2GM/0Sl4cf4H0R5BAsyERsT4qy/3oQt/RmXUYjxXBRe+3G8OoZ7PyLoJ0PaG6YAek5kF31NmndD1hu2fM/ygu0n4wMcIpErK6MFm2C7cDBFbMIK2LDGKvM1GCbiwZ9Ay4ul3sb118nYilhywGNE0ZXgwhLt9jPlBGecp5UT7Vc0cA/iXkIGo1BQHmDJz4VrzW+kPH3mRodQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199024)(1800799009)(186009)(316002)(66556008)(66476007)(66946007)(41300700001)(110136005)(478600001)(38100700002)(31696002)(36756003)(86362001)(2906002)(44832011)(5660300002)(8676002)(4326008)(8936002)(26005)(2616005)(31686004)(83380400001)(6506007)(53546011)(6512007)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9yMk10SjgvU3UzOHRqZFNxbittbHlLaUgrWkZGc2NTRWlsS3RZckVUUVFy?=
 =?utf-8?B?T290U2VuazhSeWxSWEhkZS9nNm5XQ0pTOTU3Z0xLcyt4MVJDNHU1eGErVEMr?=
 =?utf-8?B?eW4yRkZ5bUtjYXFBMnBRMmd1S29SUnVnNWJPeURzR3VMR3gwUmxudVBGS1Yr?=
 =?utf-8?B?aXJSbTJKS3hvYnhERDZVRGRIaDBqMDV4QkFFRkcyLzZ5eDI4VkUxcmFLV1hO?=
 =?utf-8?B?V0tBb0x1cThsTi83dHo1UEpWNittOVh2SnVJejFqZHcrRmlYUDNoU25KdGs3?=
 =?utf-8?B?Zm9sRzV1Y1lhbHZORE45RDg3N1Z6QXRiVkxMRUYrMzFQNFErSys2NVpaZzNQ?=
 =?utf-8?B?RDlkTVFQWnBmMk9vcVc1Q0lONExHV0xjY2hFNkJIb3NlcHMzeVY2WHBRaWRK?=
 =?utf-8?B?eVRSOWZmdEF1OVhBbXVXdytZU01Rd3plYjR6aWh3Q09IYmFKVDVVdmtvai9C?=
 =?utf-8?B?RHVoVWZ4M3U1UWdMUmxpQU05WVZhWjdzdlZQR3dURHpBT21wYjBiVVJLZXo0?=
 =?utf-8?B?MDg4SmIwZGU5aVNuTFNOYWt2MVpuM2pyMGV3dGRTOTZxeUNQMEIrZHpIUkJn?=
 =?utf-8?B?NHFONEhGSFVBTXd5eHI4SXoxcmEwSEZiNU11VzNRdmtBelpkTGVMNjdjTnJ5?=
 =?utf-8?B?ZUc0M09mOTZNTzd4QllvWHQ5cHY5TkF3TkxrWEVjbG0ySXFSUFF1TGFsbGt2?=
 =?utf-8?B?ajNqR0x2ZXhNbW1VcHVFcm4vTml1eFdrbjlYb3Fsa0svOThDUkczL1EyYzlV?=
 =?utf-8?B?T2hGUi8yVTdTWUJsdUFzOWkyZDN6aE9IM2cwNXMyQjhKRngyZHV4Zlg3Tm1z?=
 =?utf-8?B?RjRJSUVJNDY4d2oyS29PUGF5MXRwRG16ZjZocHZMYTJGRUpUSmU2VXhleG9C?=
 =?utf-8?B?SzZNM05QdW1NTi9lWnZyRnVKVjFJTVRQakwzZTdEUW1SQ05oRmtOVGpEZUtm?=
 =?utf-8?B?a1ZxTUdNQzZJR1lLUHk1cDFvTWl2VHRRcW5aYXVuZEEybE92K041YThMN08z?=
 =?utf-8?B?Y3BISWZDWWZ5R3MrY2kvWkRXc0lrMDk3Um1CMTg3SlpFNnRxbjh4LytCS21m?=
 =?utf-8?B?ODF0NmFIdzRzNUR0d0E3Vk9Ka2p0NXlDeXAzdE9SVEtxTmZ5SUJVc0J0cVR1?=
 =?utf-8?B?U0pwc0NOSTIrc2dmU2NOUlBBWmJnM3RqVjhZV0tVd2hJTUdZdHlNNXVvWk5C?=
 =?utf-8?B?azF4eXIrVnRJdzhJeGJPNmgzMDUrQjJhQ056bmFwcDdkZndjb2NCcmxoSllU?=
 =?utf-8?B?dUVKZUtlUEN6NTd6TGVDR1ZPMVI5dkl5NGt4SnM4UGo3UHEvbjJsZ0RCN2E0?=
 =?utf-8?B?VXFWK3FzZTNtWjRxTGdzakpnd1ZKN2psMVdON0pZN29vYjByeUJPR3lQQkhG?=
 =?utf-8?B?c1paSDhWdnNTY2ZDMXgxTTRCdmN1TU44S2V0dCt1K2RlWHFYL1ZiRVdPWjFy?=
 =?utf-8?B?dCtaanpUeE5mZ0xCbDV3d0pkSDdmdnI0Rk53eDBsbExtWXo0aSt1dC9hZE11?=
 =?utf-8?B?Z2xCRHRpOFROZHFUb0dGd3E0cmlnK1Zucms0dWVXSDM4VkFSSTFXajFKK25q?=
 =?utf-8?B?SnRSM09kZGdsMUdUWkdVaG80ejdWeDRra2cxUnJMV0JDWlFKdFdDNHJrZkxk?=
 =?utf-8?B?T2tKUEo2STJ6K2t0TGtCdkg0emNEVlVBUDVoSU1QekJ4YU53bXQyRFFkeG1B?=
 =?utf-8?B?OE56WUxrb0JnMzNQT1kyRlowSDkvczFtdFBHU3JnM0ZwZHA1bEFHd2p6M1Er?=
 =?utf-8?B?MW45VFhGclZ2YW13R1V5Ymk4S2JwckR6d2RTZmJycHRmd2UraXh5MGxncys0?=
 =?utf-8?B?dThSUlhqeGwwWFMvSm9SMk9lNCtjNkNCSUl3dHQ1aTRFUjM0T2taZjBhTXZS?=
 =?utf-8?B?VnFWZDFkQTBVblZpbk5iVEd3M1c3YzJCYW8rZitkbmdVbkFzcnRRb25SQ205?=
 =?utf-8?B?cDlWSk44RkVRT1pMWGNYSXpDbVI0a01LK24zZlNMNUJnNlJ6a04yVXFDTEVm?=
 =?utf-8?B?bWp6WHRERjFrdmtQMkgySTV5ZjZ5QnAydE04eGpXbE5sUWJGL3B4VjBWczJI?=
 =?utf-8?B?Znh3UFdZczgxellHYUpsMFhOZ1FUcDU3b004eHUwTnlKR3BlYmRNUHVrdVo1?=
 =?utf-8?B?RFg3RFFzWlZGTDBqSDBoTDlqcVhaYmxDNkpSMGwwb2xTNmdNcTdxZy9IUk9G?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5825ad-582b-4b74-64f8-08dbb5df00d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:29:20.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79dLABW3fUJDca373V6k9/aXEbo3yD0yb6ph6vN5Z5tL+IyVRI2c6z9kkXEf2FwfonCsGXeIAV+/7vZY7FTrFSj3kdneDk+qKEzIKHrr5Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9850
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace runltp-ng with kirk framework
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

On 9/15/23 13:19, Petr Vorel wrote:
> Hi Cyril, Andrea,
>
>> Hi!
>>> Kirk application is a fork of runltp-ng and it aims to merge multiple
>>> Linux testing frameworks in one tool, providing support for remote
>>> testing via Qemu, SSH, LTX, parallel execution and much more.
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> ---
>>>   .gitmodules     | 6 +++---
>>>   tools/kirk      | 1 +
>>>   tools/runltp-ng | 1 -
>> Do we also want symlink from runltp-ng to kirk?
> +1
>
> BTW I suggested Andrea in the beginning of kirk to have runltp-ng symlink,
> which would behave like 'kirk --framework ltp'. I.e. this:
>
> ./kirk --framework ltp --run-suite syscalls
>
> would be equivalent of
>
> ./runltp-ng --run-suite syscalls
>
> Instead of having to run:
> ./runltp-ng --framework ltp --run-suite syscalls
>
> In that case kirk would be a drop in replacement.
> Andrea, would it be possible to implement this functionality?
> (the default framework could be detected by symlink name, the same approach
> busybox uses, more symlinks could be added).
>
> Kind regards,
> Petr

The default kirk behavior is to use '--framework ltp' by default, so 
there's no difference between

./kirk --framework ltp --run-suite syscalls

and

./kirk --run-suite syscalls

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
