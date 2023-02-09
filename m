Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1298DC05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:37:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2677F3CC0AC
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:37:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763213C1047
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:37:43 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8CAA1A00358
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:37:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZtC2bivObNe7amCCaV5KeJ0eTXXaOj1yXpH2kyDXrU0cBhuAdjYWPZwFpTopVAPS1hGZny33Uzyrb5FI7+2OCMZERFx5MU8utgGu90CtuPwtZKtmmO1lXiQkh/WSUyqsrC2eJQfA6eAYDV0jerN7m16OB/+DUZgIzFfGzwLk85xbD9sF3DBAin8dgfjfRi/n+LciKjQ1GFVrLDEQUUF65xDXUqG3PFKqgfsLs93ffBl5SejkV3J1UIGE1XueIgctL84EP551yTEM9PMzGSc//mOXajF5yz9Occ6PLbi9S/WvZ6LgWrtb0lQv41/uAfzx7GVipMF13TV9wPEqUegnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg3SOz3aYMD0AeQ5WMYEzIFjXPsYMRTpkZW2M1E3uxQ=;
 b=gilGcE1ytdyjEtSURH+j0NfaLF3e/zBCsdJ2neKoSOfcdiv1rFu7bIYOHIQXhpZFuXFQz1YqbGjc+yoMLsaxcGKqdBlCUGOU5DrnMWlh67sJqI2ANymTdQ2Tzh1WlamYpsM+PaRpf7UA0NYtUy7qW51BYMNwndKWr1uNdv7rxwZFmLc8uh12w4y/7bmhG4F/PLDtvANxzJxNRHqCaf++1tJs3o1nvW+bYcf7X40yBf5PFioFprAj+wHEy5jS1zVQ13HMBCGG5SGHjw7fX5IiWDVfTbhVpulwlOxoclSdFCBy5MERin+CsuMqvJl6vpXGTKC6DMxH5PyM1WcOBknQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg3SOz3aYMD0AeQ5WMYEzIFjXPsYMRTpkZW2M1E3uxQ=;
 b=LmwTlU6Ou8AF/K4uH97CJ4vprDZHhC+MpzbhyXs4QcMp+/+sE/poHjEx6lhCreKx005VdXjsHEZ/Gpj7jpim1Ft8GUAOtMx5oEIrd9jtHffFAFAL2blWwjercvga/eoU6QB/WaP+Yk2QVjKAvKo0EFeqOSpvkVwOWxLVaqmTps8GC7W2bLMLgswUXk2ztJmxOq6Blj88/mc1evOdx49K16GlrHph0AKup/J+d4sSJT3SMcUyE3wz7eP7p9VW/zheXLOSgDizhfvUQ5/+MsPB/cEv8aUiiqyxGxMIGl6cCH4YFq+vGHbVaGsZ5ImcsJQuHgI7DuTtomczdxuE3rn1uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB7637.eurprd04.prod.outlook.com (2603:10a6:20b:29d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:37:41 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::a9f4:e4e9:9b9b:2dc6%5]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 14:37:41 +0000
Message-ID: <a4e0b95e-47dd-0c05-9575-a844d1e05953@suse.com>
Date: Thu, 9 Feb 2023 15:35:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230209142016.494090-1-pifang@redhat.com>
In-Reply-To: <20230209142016.494090-1-pifang@redhat.com>
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7510a574-f5f7-418b-0f47-08db0aab32c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DL1IofkF8PAF5ZrvMHscu5/7wr7rV2PdkO0MzGQXiy1jgKG2JdnL6i/0OVtm6Q9b12j2UHb0tnaORMrz4Bs8hz9Z/eW7V6aQ5dEBaZAOgqKUcMbFNNUxaIizHoe2AQuNwphmkzaTbpQzGkEXxT40NZ5B6VDvU5NsO7RlEXnD/yaT2MspEDQ8ERSeoqc+N1iCqebj7puGCD2D+EoXhF+3EnfWkuIXGp/SAisTtoONkEkvuU7tTzatr1R5KogT8KCg9lmyr4Rl7PhE1fOXSGicnOqxVEBcd9daNbpoIonDv0rYlC56EnUlSDKVIL3fwtUgUGD23w5HaYMOaFVrvV1BDjB+xKi4ZAS36i8phJ0iJaZTzFkMswwAcDKmV2pyKNHph5WYhE9OkVNsX/go9ZPq3gFFkEJdVm72NrVqzOnnSffga6nT0eIWfMq0hbGaGsp/NZx3T5Zda+3gWJZswg9MEpx3JOJhsCLrithFEqlGtjGLjYbvaTGHLmhjdd53GfZfflXYQO/L6EY33iMKi+Z7EHG5cBotrry0fT4UCYZulrnF9tFVUG2Z2d5FMOhgEne0j70ZPi5/zCeggKWZ+qJPR6NmKe3NOsZFFBQQUqa25KZfaRKSpC8lE3RPqQvRkutPck7H1opUTP6nzERYNUoiGIcUAchoUZ+roExdaZ16yRGpEN66UUiygLI6xOskrAqhx/dW94Hgb8EtaVmN20N7M0utWS81FOeK3y6MV8qfxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(36756003)(31696002)(86362001)(66946007)(6486002)(66476007)(66556008)(316002)(8676002)(478600001)(6916009)(2906002)(8936002)(41300700001)(44832011)(5660300002)(83380400001)(38100700002)(53546011)(186003)(26005)(6506007)(6512007)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1BNOWw4dW1VTVB0Vy9nY3hHVW5BenR6ZGNRMzNXbit1elh0dmlLbXdrSlh5?=
 =?utf-8?B?NlJ1WENNWUVWK0dXUjFYY3RmQ3Rya2JhclRFQUl1cHdudUhvbmxxNDV5Y1Vt?=
 =?utf-8?B?Z2NWRzRVdWtvaVpmdWNDcDNiSENQOWJXRWpEQzR1YXk1bzFNMXp0eXVZbXlL?=
 =?utf-8?B?cjVEb1g0bjlrSjJ1ekYrRWpWbTZXMHlWUVZadEhhaWs1eExIcitRQklHTGdV?=
 =?utf-8?B?bTNVdlZXZXhOQldYZ2thUlV2aHBjc0dvM29Ka0V5ZTE3aklWdXI3dHp0aEF5?=
 =?utf-8?B?TzBSaStKNzUzU3RUN2RhQnR0NkEwY3VCVWhwbTA0R2xXMmJpRHB4TzN3QUpW?=
 =?utf-8?B?U0tMQjc0MnRSNFdhOGh4dVNmS1J3b2tOOTVRTFNwbmNZRlZCWU9PT1h5clIz?=
 =?utf-8?B?N2tSMDJqK1pmb20xRE1LeFRKaGVUQy9hZzcrMHpRMWI1dmI2anlGTzNyOUVF?=
 =?utf-8?B?QUpzVXFtVHphaEFGQmNCTlYxWm0xdEVlditKY01wbHRuOC9jbktvSlk1dUpu?=
 =?utf-8?B?VFpUU2xiaFNWUUd1S2dRMmlnRHo0SGdjbldxV3V4c0Z2RExKaEFHZkVHS1Uv?=
 =?utf-8?B?TFUwWjMvQVkvVTVJaWhONDNZMkJnLzJPWDI2SXBqYUh5NXdvV2RndURqelNo?=
 =?utf-8?B?OHR2MzR5cEp0OHJBNGpQaHc1ZEpDdDNlMFY5UGhyUS8vOVFrU0ErM0E2N0RH?=
 =?utf-8?B?VEc1SUVtOXlaWkl1NXNhYlJPY0NaL29OYnhXMENsS2RuZWRPbUNzSFBERzg0?=
 =?utf-8?B?Q2dyKzUxd1ltV3paM0U2dXpiYnNKVFRTL3lBY3MwQjBlangra3dHaWl5dThk?=
 =?utf-8?B?SnJzMTNYSERiQnJibGRmZXBBbFN5eVBCc1R0Y05JSGlaVEJXOEtldlJHeVlj?=
 =?utf-8?B?eEo4MzN2ak05REpYVVFHeUZ2SHdYaDd4bEdhVDBuTzlyVXpDMXAyc0NYY05i?=
 =?utf-8?B?K0dMZ1hXTzNxOEtUVE5PcmtGOXZrWUlEYUE2OSt2RW9Sa0VqdGFNQ1NUN3hj?=
 =?utf-8?B?ZzU3SElXTjNjM1BySjh0a0h6aXo1c0dvQ2lHNFF3WWx6MUZyMVRpYTVBUzJ4?=
 =?utf-8?B?MmVSNW1BZmwyemdWb3V5Nm15M0g5clUyNGMvUGZNZDFLQ1NkeEZoTENvKzJw?=
 =?utf-8?B?dGhaNnNEbFUyWUZDbjNtaDkxcGJsaktNbDZ5NCtYSUh4U0liaEVQZFEzNFh5?=
 =?utf-8?B?QkR6VGVOZEVYYmwvQStzdk1BZDhQRDFocFR4ME41WnNiVmZDbEtERjdmc1Vk?=
 =?utf-8?B?TzhteDMybmpkMUVoVGlvOXBnNUdqYk0yS3NrdkFzS01BRFBDL2JoUklsMnB3?=
 =?utf-8?B?dmgxTGZhZXA3c2g0Q2J2dndFak9MTFNPR3BiZFhZRmFMTFBzWXNDR01iai9T?=
 =?utf-8?B?ZW80U1IvMU9SWkZOUitFYlZtQUJZb21aMXhBYm01TitJMEdzUnhFbmRZTHA4?=
 =?utf-8?B?dDlXQUVjWm5FK1AwMFE1cnhpMTlVcVBNaTFPRWY5bjltNGFPTnpHUUlxKzNs?=
 =?utf-8?B?QmZSQkVVOGFxYkUwbW1PVWxHNmRra2xHNXZialE5VDRTRXpNTHF4YU94Tk96?=
 =?utf-8?B?cjVObCtwRm40NDNQV2oxNFZMNGdURVVYMmN5R2E3emduZnVlSmt6eWUyTGk4?=
 =?utf-8?B?aWZURHlmbUM4NjBzdnc3NTg3Zy9iL0lMSzRKbUozR1pDSThFUjZNRVFOVDNW?=
 =?utf-8?B?SnVhMG5jTVJmODRMcGp2NHcxMjdkYkFrNUlHYzEwVUMwOVJPM241dkZYUHBV?=
 =?utf-8?B?djAycEFBNHJBbkpCQ3lYSFRGOENZZWF1bTBDaGNJVWlzR3RVVndXbGtZM1JJ?=
 =?utf-8?B?aFlKMGZGQ2VGR3VSTms5RW9lSzZVUFhrTSsxTnhJQ2dGMWE2TCthYnpTQ0x0?=
 =?utf-8?B?Vk9FdTBDN1ArdEkzSENlVnRaTzBwRlp1SjNqN21aVkF3d2VFWkw2NVBRZWYw?=
 =?utf-8?B?ZkNaVDdHVFJXTE0yU2dZR1c1eHltOUNTQTcydEhrb2RvZGVORkVQU3U4Z0ZH?=
 =?utf-8?B?M0RobEdFcU1vR2JuNjg5VE03YmlkdFJ0UEIyNHV1L3A1anFvQ28vcHVIOC9q?=
 =?utf-8?B?Ym1taHpCa1hMNG1LVkVOMVc2aE85UzFEL01oaytLcDRDUXhpcnc3Yk5iWU0w?=
 =?utf-8?B?bkZPKzE5L3d1eHQxcWlRQlhSbTc5YkJtM0VlK0RWaUxMMTgyTEZUZG1KNStS?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7510a574-f5f7-418b-0f47-08db0aab32c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:37:41.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8qN9tdulxzwREw8tG1OwHfXFqKRaXEW1L02OOMAoXlJbM359GPUO+uqFOdDpYDbIAsOujD1i3WElkPj3jOdINIS9fhO5aMASHM3T8YQa1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7637
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] aiocp: remove the check read unnecessary flag
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Andrea

On 2/9/23 15:20, Ping Fang wrote:
> When aiocp executed with -f DIRECT will fail.
>
> <<<test_start>>>
> tag=AD049 stime=1675520824
> cmdline="aiocp -b 8k -n 8 -f DIRECT"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
> aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> tst_device.c:585: TINFO: Use uevent strategy
> aiocp.c:250: TINFO: Fill srcfile.bin with random data
> aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
> aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
> aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1: EINVAL (22)
> ...
>
> The code which checks that the data has been written correctly
> may wrong use the O_DIRECT flag, which may cause a failure like the
> one above.
>
> Signed-off-by: Ping Fang <pifang@redhat.com>
> ---
>   testcases/kernel/io/ltp-aiodio/aiocp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> index bc0e209b2..6212d8ee8 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> @@ -297,8 +297,8 @@ static void run(void)
>   		return;
>   	}
>   
> -	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
> -	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
> +	srcfd = SAFE_OPEN(srcname, O_RDONLY, 0666);
> +	dstfd = SAFE_OPEN(dstname, O_RDONLY, 0666);
>   
>   	reads = howmany(filesize, buffsize);
>   



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
