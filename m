Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2707C25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 14:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 912F83C9F0F
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 16:48:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AAD83C9B4F
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:48:43 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41FDE1A0068E
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 16:48:41 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dnSkM9JvtDm6a9bpmdeRmADj2mn3inzTyWerA4sTTV/hW0Fas12HMnmYsfwO/LVdu3VVM2nRdghPEI8yjXAP62mx9fh+QSVvzbUyVm/DhLD2ZaH/sZef22SUTl0Ple36PHUfh36+gU7Vbl1ZS06yWsZxtKQr4F4zJQeOA4PgijeDBuguwu3bRiRC5j9VmzvEVB0dlu+cCxlCt1Gs0/J9ni/fZ8s3gNh6ZfAgc351MxHdnk8EdbECfaNNUaLPj/icmOQwU7rEM3Tn1xiF11hXwhjwo46gKJz1JGOD3BUjSIONgdVHz96Gl5vHBePSZXdOhZ8JA+3eCJNq/AiqDg5ECA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNT98M9ukw116cSMtQloc1YyoihbaVLD2AUUrssRdaQ=;
 b=JY6NvhSO+lkbsa2mtQI3YQf2N9A6raJxmYW9K4L3NIoQ9Z/YhKxyVVp5Mkf4kpLM2Ww5FajZQIAdLuoL2sGiPCW8WAmAjM121oOYcqaHx7klmnJFEkr9Alpm3b2aelVTX1fDor+YtKUypAuIFi5AaSNtnT1x19LGKTVLuxkiK2PvpWIqJmIZTgGIjinxZozrVx8VGEDkSU2pgaXn2g8/qDFF7e/QB10IMQopDxkiH1dnCrJzfpaNrOr1EJacnjDZD0znhqEiwe8n7ngakbhi6iTqfa+1Eq/bdARjsarOzOztxx3Xk+lp0Udcvqzr5ShdfB3jvxHIdmUMsBFr8oPV7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNT98M9ukw116cSMtQloc1YyoihbaVLD2AUUrssRdaQ=;
 b=sWnUQ+1soCVBivBaXmq3shnneQgIluFpk65bqndIxt82+Eu1aoggYvInZo5V6QabW38I38mcPPEkcNuzkzcK5pVRro2aZLYkCrnV2myLoEcZat4TR3JV9UmzXaKO5GcTionZ8ZhwlN6uIHwntjv6TEqY/4/1bqhpzEPGX0lHWfU=
Received: from AS8PR04CA0079.eurprd04.prod.outlook.com (2603:10a6:20b:313::24)
 by PR2PR08MB5225.eurprd08.prod.outlook.com (2603:10a6:101:1c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Wed, 17 Aug
 2022 14:48:39 +0000
Received: from AM7EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:313:cafe::95) by AS8PR04CA0079.outlook.office365.com
 (2603:10a6:20b:313::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19 via Frontend
 Transport; Wed, 17 Aug 2022 14:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT012.mail.protection.outlook.com (100.127.141.26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 14:48:38 +0000
Received: ("Tessian outbound 63c09d5d38ac:v123");
 Wed, 17 Aug 2022 14:48:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 556fbaf60c5405f6
X-CR-MTA-TID: 64aa7808
Received: from d5fe9bdfdf24.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 B29A2DEE-359C-443A-A743-7CBD470D15E7.1; 
 Wed, 17 Aug 2022 14:48:32 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d5fe9bdfdf24.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Wed, 17 Aug 2022 14:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyEdnrGGlG7fHFTaRPXknWgjfKfTKxFjeTTTxFK0+MCaC/6DW587wCcUEuwXJiWuFSgjPuN2EEU05tHohxe7x4DTEf2nu29kPzIrTejqijSNS9o8Sae0wZOi5Jy7Mi8qJWoFSLgPI75StP5GAIBIhd8kJRDKYgqq/b+9Ci4pEWd0XgWpM/F6re/macQ+LF+JbLyvS5D8BhR8tOouO1oMTVl9VDb1aixDVQdOATwaq6/tsl20uaEVBE/93v5EZTCl/ahxZL3rFGknV+6mHRI12syAF0lwyZ9Xqyz+LBdllRWjk3DM/u0Jjw9oxZzDftq2cm3j/nF5I3psoZxGkrGc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNT98M9ukw116cSMtQloc1YyoihbaVLD2AUUrssRdaQ=;
 b=CJjyqVU7Yej9NqvHQUUmc0Zemj46ns1IB67HsJL948GGhSK7NYDxBqxFMPZi65cUzTjf7h1iEThWreitW/P3gw0+xmyYkCaT7EsvFr8Rhw5rPAg1WvCFJ7ySJZRfI1PSauvQO3Ws/fUxyX/vKaVMAm/YGWfJyL/tRMmC+XyG/ldktjk/wFGatB5IRm/1F06oQpJui3qCYfjBjgP/0BXR6SAzrtxGpz9cwAZ7F8JhSqY5qp/AkMLS13pxgrfvKmUh8UQ43LX3rmTOGh7sOmx0Kh/PPMj7UgCJcGW5GKmiP/ZkXCthgCrealnd0Na90HW00Ic8fIMMGSqze1pq+H3c/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNT98M9ukw116cSMtQloc1YyoihbaVLD2AUUrssRdaQ=;
 b=sWnUQ+1soCVBivBaXmq3shnneQgIluFpk65bqndIxt82+Eu1aoggYvInZo5V6QabW38I38mcPPEkcNuzkzcK5pVRro2aZLYkCrnV2myLoEcZat4TR3JV9UmzXaKO5GcTionZ8ZhwlN6uIHwntjv6TEqY/4/1bqhpzEPGX0lHWfU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (2603:10a6:5:21::26) by
 AM6PR08MB5175.eurprd08.prod.outlook.com (2603:10a6:20b:ef::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 17 Aug 2022 14:48:29 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::3114:524e:9c6a:73dd]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::3114:524e:9c6a:73dd%4]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 14:48:29 +0000
Message-ID: <e07160ce-dbbd-1f6b-176c-8a33b949d24d@arm.com>
Date: Wed, 17 Aug 2022 15:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220817133929.234873-1-tudor.cretu@arm.com>
 <Yvz2hT0VGNZrcArJ@yuki>
From: Tudor Cretu <tudor.cretu@arm.com>
In-Reply-To: <Yvz2hT0VGNZrcArJ@yuki>
X-ClientProxiedBy: LO2P265CA0500.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::7) To DB7PR08MB3276.eurprd08.prod.outlook.com
 (2603:10a6:5:21::26)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 106e11dd-ce06-46e6-b9dd-08da805f922e
X-MS-TrafficTypeDiagnostic: AM6PR08MB5175:EE_|AM7EUR03FT012:EE_|PR2PR08MB5225:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: eOScNFQ9oJpxH9SYR9OoQ+JF4x45howlUunS5oH4Bax4MIY11a7mUx4M0NqNYZ1DaRRRs/D294qL9g4mhhHn4BETH34iGyvxLLxFLXh2kEWljGyxKKKaIiYZi99AaCiF6ldKar5PYq1U1m0uMtU8Zkq40O/JdaEr8SiasDu7Dcakf/p6zheQGl+5SWNo8mv1Lz/qz7yVN/C2WByrrYWqwTyUmzCNJJkwi7FofZOou6DRli/+BVhxgkfpmK9zBWQEyG2W2cYhoXxAjDvtBwFqH5RG0Lt34nWd2hgENF5q4cT1XshxDp6kSh444GELHrc9nkDkzkV6NLuwZc6WX2D9aldH31+tZMdtI4GY7GCc0KDPjGCb0ifMlR42sdkoHnP8Z1SDqKcecn0pfiy8NFNIAxA2TuZETPxYD61EcsETvTKr3Q36RI9AYs/xdJW7pBZdPtDRoIdbY78k1Z+NQMfawN0690pp2Bt0JqhvTtuhF85Pz0vCD9O46lXwDOrZh1vhzgA3xyV4Fp9BWMQce/B5VzhOOQC9HZWA8QTTlMWb6aL7stVx88MGdORslaEBy0wEmWt6nvj3EC1Xrv9kfO6NOVD0yhOtMJhXppk4fn6mZENmAGcTLGXy//NkP78Vyedv32y2mGrvBmr0xdBUYKceSX5zudTrcibCac1lXMDhLerb5+aoNQrHtcdWyvX1F/jxH5QCMSB5tU1FhZa8Sdz2tQVQcr7+O391kwM0tM3aoqsEqk4eKuyUrmHRKmr41HdIQELSVPkE916n6Y7Q1nTeZMCNMSa3LEpdu57ec3iEWlr6S66Jdm1999rVmvMvnGOB7gZB1IYzO+C4u499bx4nVg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB7PR08MB3276.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(2906002)(186003)(478600001)(53546011)(26005)(36756003)(6512007)(6506007)(41300700001)(31686004)(6486002)(6666004)(6916009)(38100700002)(8936002)(31696002)(86362001)(66946007)(5660300002)(4326008)(8676002)(83380400001)(44832011)(2616005)(316002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5175
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8ae94990-0ae8-4f13-c033-08da805f8c8c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPx1GTblIEHgGsB++aerpcgAEGwQYZfa3ujUx+OtMn6BVTWyqxUOdmsUU4A/m95l8FCGW/K4TpxIFuV+HQUwukiaWCg//lCI31Rn8uyryANOC20mCK+i0Qo3zcX+l5suaTnzITIEWS4X7B5xyYWVdpLRoWhzgwe5MiNy+lEYkuxyBzG/EeVIgS5bYCNncAa6ynNjcpX/JLiyo3QNIU2wal9b4GJwq4Ma3HLiqJi/RMRg/SKjB/soSA9OHPvHbGTKMtfisfzzJbkdDjgfBijkwA+uInkEYOquz+TN3tmmooHelV2aVBRP7YLuV5iM2cf6Q0R4uaP2+xhgrEgypm4Squ+IED/Ro+jdMrHmjjJquwd5+TLYNWp9Bp/24C/0Hvoun4bis5fuD1HPPAMz9QdB4XWboQIHagIePFZlmBWdYsh7B9l9nAqq79HDfkbM4CY8p5f/hwTjaFbe5CE8e9RW2zPzgA9Ys1TD2AnsdqD+7iWV9/GWzqPB5uLEr6nH8Ausrdm3m38tO7K7QPgYaOIUyhQngYv0mYtjSICtUnKoyDqKYW/7NoRmAeIShivaOVQiX9zMtKvR1yyBL4hzc7AdGXh6xWaVv7rPs2yC7Yf28OPPgxgy1F/2qorTj9a7FHGIvcbvQsft2aZ7ZU4wss3x+ZSVo+MsCDhNVl+y734RpOYDR2kjLQdaqIw6sQQBb9uoeV0eIv9lmO0dnhn8n/UEAaIjETmkNqkx5/gVGC0IYK4YhdDN39QsEMzAP2eN8NwkIEQd4Q+Z/63mr8pJ45Ykg+6zLPFQxT6CgGxpZ/EsBF46Af0TNc++Dwy8ryBztAouERKtkt7OcjFhNzeO16Y+Hw==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(53546011)(40460700003)(31686004)(31696002)(6666004)(36756003)(86362001)(2906002)(6506007)(2616005)(316002)(6512007)(44832011)(83380400001)(26005)(5660300002)(36860700001)(4326008)(8676002)(40480700001)(478600001)(6862004)(6486002)(186003)(70206006)(8936002)(82310400005)(47076005)(41300700001)(356005)(336012)(81166007)(82740400003)(70586007)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 14:48:38.8505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106e11dd-ce06-46e6-b9dd-08da805f922e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5225
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] utils/compat_16: Allow build.sh to disable
 the compat_16 tests
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

Hi!

On 17-08-2022 15:09, Cyril Hrubis wrote:
> Hi!
>> The option that allows disabling the compat_16 tests has been erroneously
>> removed in a previous change, so re-add it. Also, enable build.sh to use
>> make options such as TST_NEWER_64_SYSCALL or TST_COMPAT_16_SYSCALL.
>
> It does not seem to be removed erroneously. What problem are you trying
> to solve?

I'm sorry, I think "erroneously" wasn't the right word indeed. In my
usecase, I cross-compile the kernel/syscalls tests for AArch64 and send
the output over the network. Not compiling the newer_64 and compat_16
tests reduces the total size of the LTP syscalls tests binaries folder
by about 20%, which was convenient.

>
> Generally we rather produce tests that then return with TCONF (skipped)
> status than disable them from compilation.

In this case, I agree there is not much incentive for this change and
I'm happy to drop it.

>
> If you want to skip them at runtime you can filter them out from the
> rutnest files.
>

Thanks,
Tudor
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
