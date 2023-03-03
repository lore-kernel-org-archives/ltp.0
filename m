Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345E1C7EE30
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 08:49:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F9BF3CB989
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 09:49:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FFFC3CB97E
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:48:57 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 73B456014FA
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 09:48:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRMqxA4wZz862GQBgotWKRtHW4pCzZkwC7OWGLGlcct6CzPD/KLeCYw2O/R1YoH1rJMWlqgp2DUtA85sa+2yQol+3KpHKINEmHKpTxqQ21RfaJDn4C4e4KJhbQOt9uZjqGjaV8269sUSRc8xzNBZeQvb2kWlbkd7qKSL6LElNjGEn7zG9EzMuKKIvHPVc92cLVURmVCzZh7DpTVmSIqYfeJiA0x1T//d6TriD4UxdMYTOAWS+pT4xyMT+4bjg3p/HVvORjoDdy1Z8tDBvNLu0Bmu4fSclSVbfp06cERcM6LOLzXp2CNIo5Mj7GbQzf719M7jUfEEdcsAtcMensdTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrhM9IldGfCnz9/NECjcSwhoTIqBGBKJXqbOi5uLGkI=;
 b=Zww0ox5FTu/MdPn6nbYESk2taPGYNCCcaGQrtscgNhUqQCJ5wKoTSUsz4EPUVtNCa7RrPW70M5l87Im28LMpQR2z1SDqlvDMcFX9WWDyC6Gck8DvhKP7Zx4Bxx2TArGVX0LIr+MbJGgtxn4WOGD9uuSaZcItCRyF58+rS7ium8CLMHS8oZzx8il7FtAdTHqsb7w+Ezc5w5YrXGlb6Z6ahoowxqi9rzAPZblGLjgi37DNsWoUg2pqHLepw3qgfZkhYeYZkhruAVYEGb0jJLp6fD4wy9s812j9GDblQPmCt3QdAoFuH0D8h59jubXUHAoyiQEilETK6gf80uy+1j0m4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrhM9IldGfCnz9/NECjcSwhoTIqBGBKJXqbOi5uLGkI=;
 b=jqVpltGMfdVucKQLtZS5E0HdSasZ14nHZlsr9NRDT8Xc6N79ZtSNanP+1WoXWUtA7Zee2tdytATQ7CvMvtHmBXI5kDjwoKFTswbzpxSCYCRNXPcTCjSXicjQYxu7AJqy/r78K0sZ4+BCJTD3noyZWUBiqkYK6vhocEnPUPUhWk5oS8fLuvy5YqtIqSz1+qgkXaX2gqEBuqT5EYnmp0F8M1h089XGgQnQnuUoeV78r59d6c//YrEh0zXlo60sT7V5h21gflCfY8jG1lJC8EUuWNQ4AXWQYKs2I68PWVav4DX1LHdSw4uJNmWTpDLsuyw7wuwPdYqyNoFo2Ad4FkIBPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 08:48:37 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%3]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 08:48:37 +0000
Message-ID: <30a9ec9f-4b14-da27-83c4-ffbbf8b0c0cb@suse.com>
Date: Fri, 3 Mar 2023 09:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230301152818.4427-1-andrea.cervesato@suse.com>
 <20230301152818.4427-4-andrea.cervesato@suse.com>
 <20230303092526.GD4255@pevik>
In-Reply-To: <20230303092526.GD4255@pevik>
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b25407-4148-444c-ff67-08db1bc41480
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfjFo4MqSlXt0b7uWx30FgGR9l4OguZrpNRxpVQjPnAiSXikO6BQfnMG9tzJwWsV/nqH9Xzkbme5DKA2sdg3Eaiea3xPSGHNdSxpxs4TNO1RIwdgtaz+1xBzG9JVnO4EASJ/nbOxd3sJ4+BU+0fMl8SEWXQtRd6VdMS8trrLyc0oR4udIcA7dzsVtt0cXtm0HtdNTbEZVUdRkILSWuT2XujleGdejVVWUrbzXDbdPRByI9fvZoZnsTBeTADwKVCdRfgrcgxgOgaIHf6d/5e1L3zhLnW9A675rvHNanBY+P57pIwIXv+CO2WiLvEED8UJ79UYtBsCXbqDIzpFqOnvF5d/gqgIjAc1HujvXW8jRb4EIgncyDppGQLRmkxlh5s1aquwVLLysfPxgtKFIqhvJiKuA1hNLxSroRWBkKHBygtKYSpoy3uYY+HDpaijEnTfoU28nLlJI3koWcDpeWLkz+uHoeCgQsjGJ0Rm72aArc2Oh0RdmMNEcUs44YbEBI6AIsBKBx+xHJSStDB7y+GJ+ekLBOFUgXF+0IPYH8w5MQsIPL1xGslKO7XFBCL2Pxz/GGfRa24ebnxvI/w7pVU8f4YqjntxBOMabfyVg0c5I1XrQjhxarBuPJrT8wOjwiyf6vgt1rZWG0ARRN/+UB/F+uqu8hxeiWSKQOUqFMTVgYej8/jhEEoSpslfY29IXf4oDDmWIjkStOsla3xhQp+JEbQE4LzEccgpQHw7mVFJgjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(36756003)(6666004)(107886003)(53546011)(186003)(6506007)(66556008)(2616005)(6486002)(6512007)(41300700001)(26005)(316002)(4326008)(6916009)(44832011)(2906002)(8676002)(66476007)(478600001)(5660300002)(8936002)(38100700002)(31696002)(66946007)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJLc252bERQYU1VMGNUU2tQcWtBZGJOYVBYeHRpZndjYTRRSEx6Z1Z5MHcw?=
 =?utf-8?B?SnJvYm1IZkY2b2g5SGZYS1hNSUsycWNFbHZDbmlpODJxYVo4WHBtWWp2VjJE?=
 =?utf-8?B?TUNhUC9ocGVJTTJsb0o5UDdQTTZ6TFRHaGdxNCtXajA5eFk3THF1YVMvcXhH?=
 =?utf-8?B?M0tMME1VVTVwWjhUeTU0aG1BUjdZRGgvemt4elRoUjZYaVNiVTZHbjlDbEcz?=
 =?utf-8?B?c2FBTnpNOU5TTVg0aXpMcW40dHNNdWxDVmVRMWpJNTgvRGVQQU5kai9FZ1FC?=
 =?utf-8?B?Wkd1blhSVTdWQW5Wc0xPRUZvYVU2WlJoUjVBdUFoM3V5d2NFQzRZOXhMVzNK?=
 =?utf-8?B?QnRScFp4Yi9MaFhDdGQ3TzRkdkp6MDM3YUNTelluWldkdzVvRy9QU1NuMG5r?=
 =?utf-8?B?WWdlS1JSeHJaMnRvZU5kRWVtTkVadEsrOTJramJFbUR6dk1mczNDdDBqYldW?=
 =?utf-8?B?dmN2ZUxtYjZIelBQd2FIT25FUFNuckhtelhjNkVqbTVEY3VJLzc5dHBNWnlP?=
 =?utf-8?B?TEp6REFuZ1EyNGJndzlFdHVMVnNuWUJ4eW1CTERFcUVGSFdnbnRRR3hLcFMw?=
 =?utf-8?B?em1DUWFkMDE4RWdkUC9XUlhtUFBkanNQNDMxTFI1WkR2bjgwWXd1V3pHbW00?=
 =?utf-8?B?ZXlaaFNZemZaZHBpeXpGQ2RBZTI5L0JXWVo3RzJpbGRCVks4Rk56dFZVMGRB?=
 =?utf-8?B?bkY3a3ZBclNWQ0ozKzk3OEU1b2ZVV1NKK2tsUHJRcnZWTjFlT1pnYkV6NVp4?=
 =?utf-8?B?UXZ4ZG9tM3dPZVk5VmJTY21mNHYySldFTCtjQU4zT1RZN0JCN2hJbGJJdnJG?=
 =?utf-8?B?ajUzdmhkY3Y0ZEVyWlErdUttMEEvYlVFRjNaNmRPZG1FSlp4bDQ4c1IzS2hN?=
 =?utf-8?B?M2hsVmJ1d1lXdGRLV1p4UEdhTEVEa1lCUWhkNmpNbDdIdWNOSzFMcytueUNX?=
 =?utf-8?B?Yk9aTGw1NHdZMHlJbEs4T2pLaG9IVWRoWGxBbGtwT2lDOERqUHFnd2xSOWdi?=
 =?utf-8?B?c3dpNGl4dU8yc3hPVytKd2xDT1ZzcS8wMVdqeXRteGFjMmJtMEpHcERTdnBB?=
 =?utf-8?B?QUJMOWFlSW9JdmFmWUYwZ1ovTk8xRUp3VDVJMU91TUN6ZE5vaHAxWjdhbnNv?=
 =?utf-8?B?MThoMHdxeWRxZnlUb1pCWWg0TFVVbk1uRWpBUkx3bHZIQk1XcElIZWkrejZG?=
 =?utf-8?B?RnNqMmRsTmYzTEhXQy84bjhxQjRROElqOUN5dnA4emVEZXpQNHM0TXQvK0pm?=
 =?utf-8?B?cVJNUzc1VzhiZEFjNTg1cmw1T3Q4QnJaRjZyckFVbWdGQzhLSmxHSGltdktQ?=
 =?utf-8?B?UWJnY1Y4Nnpyc0lLZVYvTkhVeU44UWpjWE5yYTRpMjI5ODlGek5PT0FGMVNF?=
 =?utf-8?B?N0NvNUYyT0doSjZCQmtBZVREaTl1VDZkSWZnQWNSd1NESjNybDZKVklkcTc5?=
 =?utf-8?B?Y21Ud1FOdHJZaGlaOE1Rdit2TkVodDc5TTdiK1FDZVFDQ3pHQ2pJUEFTbVpo?=
 =?utf-8?B?ZjlGNkJmUUxvUGZ6SGpwUzBFNFZRN2h1OHNlT1B1MCtYdGVNOXhrUk5hdTUv?=
 =?utf-8?B?eUNweUdueEp4dGE1b0J1cFY2bVNPWGU2MCsyK3FzN1J2RmdITzI3TEYzS2NY?=
 =?utf-8?B?NVFhTnVURGE0OGk0c2xjeGdIc2dFdlZHb1UzaGxURFFZNzBnc3IvSFRxd0Jp?=
 =?utf-8?B?Z0Y1Ry9aWk0xL2JTSDZwSHhBdHNRWkRCMDhMMDl1bTRBck9rRzMydU44L0M3?=
 =?utf-8?B?b0cyZEVFWVNxYjNVRVI5Q1RCdjJVTVNRSDRCQkNKTS9wMXVKS1I3bEhwSGRX?=
 =?utf-8?B?WlltR280eWw2Z1NUWHB1Tk9adCtGM3ZpU2xDRExpVnFZRC92MnNnMEJ5Mks1?=
 =?utf-8?B?OGFaZDY2bktkZDRtSUN3VnBUUjVKRGllanJ0VTM0MXVzNDd0UWRScTJqZitS?=
 =?utf-8?B?TlJGV3BzU2RvTmFoQkFhZjFEcERTQkhqUzVIenBhUmNTOUE1aXNYWGFNVm4z?=
 =?utf-8?B?UC9jN2tSTDc4MXJMU2VPekF4WXRabW5VR0pOYTRvTnkxODZ1RUc4dU1mdGMz?=
 =?utf-8?B?dHJJbkl4SGtVTlpCaDFoREc3dXEwVElQWXlSREtrakc3WnZQT1g3bjBWQlAw?=
 =?utf-8?B?NTN6dlpXR3h1TjhOMDhqOUVnaEo4c3VrTHJ0S09KLyt2YUtXRnBreVlRNzNZ?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b25407-4148-444c-ff67-08db1bc41480
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 08:48:37.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 867x0zVcP+03+JPM2RdHq5PTUfojDD0qr1feDcYNObCsMAoXRUrs3WGTo40lOAiJUFd+Lo+phY1kEB3tepI4Yf5fJV7lolLqLemPeoZQtng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/6] Refactor mqns_03 using new LTP API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 3/3/23 10:25, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +++ b/runtest/containers
>> @@ -22,7 +22,8 @@ mqns_02 mqns_02
>>   mqns_02_clone mqns_02 -m clone
>>   mqns_02_unshare mqns_02 -m unshare
>>   mqns_03 mqns_03
>> -mqns_03_clone mqns_03 -clone
>> +mqns_03_clone mqns_03 -m clone
>> +mqns_03_unshare mqns_03 -m unshare
> Interesting, it was not run with unshare. +1 for adding it.
>
>>   mqns_04 mqns_04
>>   mqns_04_clone mqns_04 -clone
>> diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
> ...
>> +/*\
>> + * [Description]
>> + *
>> + * Test mqueuefs from an isolated/forked process namespace.
> Again, I'd mention supported modes here.
>> + *
>> + * [Algorithm]
>> + *
>> + * - create /MQ1
>> + * - mount mqueue inside the temporary folder
>> + * - check for /MQ1 existance
>> + * - create /MQ2 inside the temporary folder
>> + * - umount
>> + * - mount mqueue inside the temporary folder
>> + * - check /MQ1 existance
>> + * - check /MQ2 existance
>> + * - umount
>> + */
>>   #define _GNU_SOURCE
> I wonder why _GNU_SOURCE was used here and in mqns_04.c. I don't see anything
> in man mq_open(3), both tests are working without it.
Because of MAP_ANONYMOUS for mmap
> ...
>> +static void cleanup(void)
>> +{
> mqns_04.c checks here:
> 	if (!devdir)
> 		return;
>
> Although it's unlikely that SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir); in
> setup() would fail, I'd add it also here.
>
> Kind regards,
> Petr

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
