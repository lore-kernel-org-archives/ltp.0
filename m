Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D48C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 05:42:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B833C96CB
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 06:42:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65F823C8D83
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 06:41:51 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60127.outbound.protection.outlook.com [40.107.6.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE7C01000EB5
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 06:41:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2NFnJmYTRLV96e56Ml3YrSN/RcETDbKK/DfeOjOlHC2yNWbzr/hIxI5ER+bAI6UceIK6l8UuJkMl2K5MBCN8PHnniY5HMxWuPg5A70/xxc6zM2cC9D5CoJnKYEx1W6//4XCpFZF2b7lak8n6u7EgNn8oJOIZM9ht+IW6szTJVyHWdcRXEERZRCZTR9I6BXMXdOGv7hCAOOt3xYHSbh732+bZBLQ8I3g70Yf+T/vluvpWdngRDAxN7Q8y+cPt/dio6JuKfgZPB2NF3l/o0iGOrmPmhPIQz9xc1RPtRH3/V2pWPYBT5Lrx9CkrMeJiDWOV/JL7qMfSZt2Yu/aAXzoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKbmQD3+0O4GpwvDdYd0XZWxyCgsG2AjF0i4qx0FBVU=;
 b=fo6tfR5NVaU2Ovmn5QW6E9tU0pYTjPRnJNUD4XxyFsAGMtiYi2iHr2ifPJEe32XVQORTbQNpjryNrDdV6Tv8BL92NW+VEU3sZST+87IlPC9PrSeVJCbrd6kcjYHmn5W5DzhY5nsj8EOPUVx3OhhNkrbnTpQnln8NfHFUA1bgMoKyLM8FY/qWKA3HC0nvzfcUC50Ryt+YhMOc/gFJAlXCV/hBEj86TgQfZxAUMxDeqBNsfB3nJZsQzf2Ff7V9P1Cipud+KKWuF1IWXuk1F2h8TfogwpYKV3PcOuVHI9QukIpqNNfw9yyAH4B89OGIWDJy3UsuBXbZBHE4yjVJhIuO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKbmQD3+0O4GpwvDdYd0XZWxyCgsG2AjF0i4qx0FBVU=;
 b=XoMvknU9LNmQF/M2Qq8R3vGnyfH2J1KYdrsR4b+cK26DCpFKzOBHc6cq9o8FcHK85IpcpzUkchuUsTWWMy93tcd7SIVC/SWJEWRhG7rre6y6mq/Ep9cYIZSRDypdhIgRvwfr60h30R5xtPQSwzuTQro9aCYq/p1GqMli7l16Fy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by AM6PR08MB3095.eurprd08.prod.outlook.com (2603:10a6:209:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 05:41:49 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::4456:3e05:28ee:51e4%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 05:41:49 +0000
Message-ID: <31a29913-11f4-8dfd-6c5c-735673dcd1a2@virtuozzo.com>
Date: Fri, 21 Jan 2022 08:41:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220120143727.27057-1-nikita.yushchenko@virtuozzo.com>
 <YenNsuS1gcA9tDe3@pevik> <da777e8f-ca8a-e1c6-d005-792114b78f84@virtuozzo.com>
 <YepE066MwWSf7wAK@pevik>
In-Reply-To: <YepE066MwWSf7wAK@pevik>
X-ClientProxiedBy: AM6P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::23) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8539c6-3adf-4a8e-5454-08d9dca0b81d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3095:EE_
X-Microsoft-Antispam-PRVS: <AM6PR08MB309576800EFEBB5323B5592EF45B9@AM6PR08MB3095.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnBGwe32p4ChDq/PHVG9HKUah/C9ITX8ig+CHu4uN0eJ2IhkoKyMn/PmwB33jZK3jDiDpCSNYkbNT6V23P4H6iGV0McNtCxBjF+s5WjEUCy4K6Mv8uHbFmKGMI2GacnjqT8baxOl/Eq/DMa+kvkwpwhAqxDVMcrOUxkYy4Urp9lgKdPThjsFYsf+r/TzAYsw8Tlhmi2yyNzDlBNkxlK+jS9Y3ZymZepgcEtVW8w5QYTg3B0q2HO6NWi7oWhA8nKq9MJ8T4vpS/4WvS+6K4N7uKP74O2lW5qoYm47lNcUJ1BzxJT1TPX01lAnH0HEj3xQOqyQEk/N3lnJZgsMRQAZQEbQlSgFX4gLvuDvwoYLmkzgIXXB/9Saq1LhRo//wmP+6GZ9BbOjkFQFIbmST3B7NbkF8pRQn6KQV09iOrfHZpItjcDG4queT5ULWxZNPgtvIml14l5lFtuISF4P3cWYFULl6YRLBCLotht4RmLG+W3Un4FEqc3KKma8VECSG9FPoyQz3A8tAIxEc+mqaP0ILO3UpQ6A0bQKefBLeT6b0MBwqJ0nG+hh9ReF2eQaZM1Gv6ITqUiVrJFEVut7YsoMRso2qewcx9dDq/RHHqibQMElmMgMi24lb1pOEiM/bHSM5R/D5QieyoPGCY4I0rtM6mBnUY3x6iF2blqWplKlSKb3NjQQ2rCnVTTi/aAZipd4+yx1sFVfv53FD2NFWePEAOr6LNDMWUXJeekuOA27mzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB5630.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8936002)(31696002)(86362001)(66476007)(26005)(508600001)(31686004)(4744005)(38100700002)(54906003)(2616005)(2906002)(44832011)(66946007)(186003)(6916009)(316002)(6512007)(8676002)(36756003)(6506007)(6486002)(66556008)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Eydzd4VktlM2hiTGJMV2xUQmUvZjg1VVJFYVhQUmJld2FwdGF5dDcxaGtq?=
 =?utf-8?B?OTlOSmFaS2tiTVpYOFVYSFo2TC81c1pYYjJ5U0dGZnllTlBkUmQyVFhYcVF5?=
 =?utf-8?B?SGpaZ0czSXVkakZQUUZ5U29NMTd0ZmhZV2lab0oxVFRqTmEvZ3prRkxmQ2NG?=
 =?utf-8?B?U0l4RHNwQmlDSHJKVlBDYnVIaUdHVlJyQXU5UUgzOFd4Wk04anpFTXlJTDhp?=
 =?utf-8?B?ZUtNUDV2RlZjVjBnc1dOUkJneDFoWVVTa2JjbGpRc3NEUFZ6Zkp6QlNQejNi?=
 =?utf-8?B?Z1c1ZmtncnZvbDFGVmt3MWRlS3RyZnFtak9NYm1wWHNUaFlZbHkvNzJMeXgy?=
 =?utf-8?B?L2hBV1g4T2dsemJmbTdUN0pZUG5HZm9nQXFxbWVma25EeFAyQjdYTlhiemRq?=
 =?utf-8?B?Tm13S2JZbTlNblFnSFBaM2V3dEROVlNKeFE4S21oSk82ZVY1cjZ6eC9xekJi?=
 =?utf-8?B?Ymxlc2diMnFZV1F5WkVpb2lzR2Frd1pMWXJDZHZvMWNhK0swZWFPYzZodFFD?=
 =?utf-8?B?c0ZiNUR3SmJ1NEJyVTd1OUloc1pUVW5JaDhmVFRkamYzRnVjWWdZWmcycWpD?=
 =?utf-8?B?TWdORzRsa2dzN0R3ODVReEJCQzJMcDd6cVMyRGU0bUhVdW8wcjBsajNVSzhw?=
 =?utf-8?B?bm05RTNkbW1qU3FjeWtyTnVBYW9PZlc5Y2dxNm9VSTVONW1yY2JNYzhqYmVw?=
 =?utf-8?B?ZUlFWnZvT0lZcUxORzRvcHdvdVFYL0RHdUIvaGhPNS9RdHNHSjNFT3BYUnNz?=
 =?utf-8?B?SzVqRzVJakxOcXdiNHlYOFN4MXNRNjJuRFU4bitQQnR2WU4vdTZkZUY0NVh1?=
 =?utf-8?B?R08yR0lLdm5pK0VnenNSRnFVVnVPaC9SMDV6NlJCdFE3MGdrQjFSRHBiK283?=
 =?utf-8?B?UHRYOVBNREtlYzY2ZWVKREtGMGFEZ09MQVVWcUd5cUg0Z1VyL0dZWXZWaTQ4?=
 =?utf-8?B?eGxaM0t3QWVIU2Y5WnRlYjY2MmQzODJpcjI5N0htVU1OZnNxNlhRTHBiWENo?=
 =?utf-8?B?QzR0ODZzUE5yRGduWUp6NXI0NFc2UHNKeXZSbDhJNTg3NThDeFN6MXdGS1J4?=
 =?utf-8?B?WktDTDZ4WEkyV1pOUFhHL3E2MXlVaDRkb2xoMDJyeXNNMnI4ZElPaEF5L1pp?=
 =?utf-8?B?akJkaFM4Q2M0U0JxaTZaMGxPZ3lGQzREYnlCdzVCZzArWmwySUV6Ynh5UU8z?=
 =?utf-8?B?NnlJdmQralpPK1lGZ2FTYzByV2NoQzNlWWdmR09LSStyM2o3dUk1SDMyMjNP?=
 =?utf-8?B?STdXRGM1VHJsbGxZamZIY29COU0zL0FVM3RsaXA0VEZlVHNTT3ZZbExrc1Zn?=
 =?utf-8?B?a1h6bmJaQis3YkFnNE9STHJyUWhtcktwK0J3czBkVkI4Tktkb1dQdlI0cFcy?=
 =?utf-8?B?RE10OFdMaEdFUUtRcG5OZ1ZRc2lQQkNUY1JFMi9pOEZrMGZZTjJ5SWxtRUxp?=
 =?utf-8?B?Y0hDNDR0aUlzK1N3bXQ3dUtORVRyUGZKVmxHQi9uUllsZW1YVEN6MWJ3WlFD?=
 =?utf-8?B?VVNaOVgraDFVaXlNS3dRUHkwelVtQTAxZTVsem05VmFrdUI3RnprSWhxSE0z?=
 =?utf-8?B?cmQ2M0pnWVRkL0RMdGRPQVNFRWlSbEZhZWhLcEk3S1Z0SzNCWEoyS1dqQVlW?=
 =?utf-8?B?UDd3bnVMRUJYZXVrNXkxZlNSMnlUZ3g5TysxRTZPY0ZEU2JaajlIV2VrOUhu?=
 =?utf-8?B?M01ycXo2WDV1bnRRY2xPTmZGUHVlYkdEWVNsTWR2Q2hKVWU2eGY5NUlXOGFQ?=
 =?utf-8?B?TzZsYjFKSlJRQjdwakNWUCs3cDlnRlpHTnVNR0dwdWJWS2NFeGRLd2p2VVJp?=
 =?utf-8?B?SEQwaUVzSWJNYXcwdlk2ZS9vM3NaU3laWnMyMEZvblJ6YVhBQzc2L0hoeExh?=
 =?utf-8?B?RHFnamZrMDRtT1BqVGxsQy9tS3RQUlBwM1REY3F4TlhTRHExWE9HNUs1cnY0?=
 =?utf-8?B?WmlFeVpSOVVJRjZyblB6YjliUkp1N1VwUGhqRnJzS0JSbWlZNWtMdHFicWpq?=
 =?utf-8?B?MmNFMElTS0dWOGMxZlozR3h1dEx5N1IrZFhzcGNYeWF6S0UyK1ZuYVg2UzBU?=
 =?utf-8?B?RitaclgyUmZJYVY1N3JqeStGcDdSUHRoV3Zxblh6WnM1YTIwdWE5RVM0YlB1?=
 =?utf-8?B?NFB5azJZcG5tQ01OUFh6dUQ3OXRHeWgyTmt3b09mS2Q1bit5aWx6R0hQQktu?=
 =?utf-8?B?bTN5YVZMWGt6dS9iS0x6bDdLZy9kMEVISktmQVZDOXZFQVRGYlB6UU9VbTBC?=
 =?utf-8?B?elFTN1A0YnhiU3ZhZFR5MmpweTBRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8539c6-3adf-4a8e-5454-08d9dca0b81d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 05:41:49.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZggHrV0pEkOCxwLlrb3iIQPsbUnumgxU7iYNmaejyWkmy6EMVVM3Mpo0CkocuG3JILmfXsrZPlFhjUmFQ3bFz+OdjWUuzs8JQsEwYghDOB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3095
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc_lib.sh: fix portmapper detection in case of
 socket activation
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
Cc: NeilBrown <neilb@suse.de>, linux-nfs@vger.kernel.org, kernel@openvz.org,
 Steve Dickson <SteveD@redhat.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> 
>> I had to add this patch to make 'runltp -f net.rpc' pass just after
>> container is started - that happens in container autotests here.
> Yep, I suspected this. Because on normal linux distro it's working right after
> boot (tested on rpc01.sh). Can't this be a setup issue?

This depends on what is installed and how it is configured.

But definitely the state with rpcbind process not running and systemd is listening on rpcbind sockets - 
is valid.

In the setup where the issue was caught, the test harness creates a container with minimal centos8 setup 
inside, boots it, and starts ltp inside.

Just reproduced manually:

[root@vz8 ~]# vzctl start 1000
Starting Container ...
...
[root@vz8 ~]# vzctl enter 1000
entered into CT 1000
CT-1000 /# pidof rpcbind
CT-1000 /# rpcinfo > /dev/null 2>&1
CT-1000 /# pidof rpcbind
678
CT-1000 /#

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
