Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DDBC4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 13:31:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCF4C3CE99B
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 14:31:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F03D3C008C
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:31:46 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A140600648
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:31:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU1MYjthTvyAnOsI0rf/q4ZmHHlIK9tQzDK59XW5AfGOEBYed5X6rgLHMA4R0tsEG1KG0shzqLsypJDLc0wwwabMc7xCI8Un0RetPn6SWHvMsAC1NShWYym50SyHbXmpMBlx5IJJiVEHddsNobkgvhLOlBFdc7OpJ2B3Relg1z5BoY/IfAKGQ8lEH+63JTDMwYVzxbUuqg7oFSvVro8noPynGZch5tK1xyvzWrHfzsQqiGVw4cuIOR7zzhI+I2aUuCQumY4875TakLpKrOvdzcHgzvUkMLo7p6wyjYzRxFQnfIFESFep1dq7oqcNn8lYXLnUVsMxut28m4hpusycyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NBjPxC9xhRoVwDYynUUPOoIBSeXysPBSvVzwCAL0UI=;
 b=f77FiwyAFfiw0muFnNdml96LqANBK4Dayqe01vtjNQMXptNyyiksSq2s/xDX0bxsj9SqTJhGynsGDDmeKXCU7FkNIFp4A+epN7Wo466JKfnJGkFXMZoBEWjV2zTUi1xSNlrSib8+5A8GuYQCVll7VrHCOveg2bHQF2pevQwEtyUuked/sxhoDKS3C1QJWKT5dudQ3oeKCBYtxCOB3qKGhQZRddzinZA6doX30O4X6ErzNXsjY7NvFNY1zJGNH2eX5CGC8GPtLNuZ8zJQ8LYVGzJTpcXKtJFU1Kii7y8HfyRP7raIfVKVDFyh4EisqjoS2m9Gd/en5A+eSEjf3sv62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NBjPxC9xhRoVwDYynUUPOoIBSeXysPBSvVzwCAL0UI=;
 b=HvNU58ZfjwKJYCo22ZDe/wA3XjE+LlcLYLLYCwIAfiad2F6PFZbycqlPKFTgBub8Nel8E1Ci4uFE2Lql5Vj9ABMyQAkO1jcGZ4VYnvOVMg42232dgisJQXSjUW9x1NNmcu2ZdsqBlogLOHy7MCDbaRygpH0zhQBDJTMxAzG+wXHHVI4lsJ0oELXUX0qyDKq/WCSmo+eEnqVlQqKwGz+tvloclGEkJWVKa65oHkH7WEszlaY0a8CebugDnHUIBiGDEAsC4kS9ZVC1OCJk2WoejUjKDAoUISibNuLevA0tyaTqC5BF5xWhjWXhVg35SSWF+ybM5VqAtR+TSfKaHUshsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB6996.eurprd04.prod.outlook.com (2603:10a6:208:18b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Thu, 2 Nov
 2023 13:31:43 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::fe32:e823:6c2a:ec3a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 13:31:42 +0000
Message-ID: <7263d01f-5cfb-4c2e-aa02-1758fea6c435@suse.com>
Date: Thu, 2 Nov 2023 14:31:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230906080950.23155-1-andrea.cervesato@suse.de>
 <87a5sw10qb.fsf@suse.de> <87zfzzrvbc.fsf@suse.de> <ZUEkhFYIJogalhpq@yuki>
 <87r0l9swzl.fsf@suse.de>
In-Reply-To: <87r0l9swzl.fsf@suse.de>
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM0PR04MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7a72e8-cc1a-43e1-11f4-08dbdba80cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3w+uh1WirHlD+i2qThYhPLHbnc3GXAW+bL/wqu5yI4RrD2en8tXLcI8knhh+zLtwat5xbYUT7w/dxBlmIQXTTrQbC8i8al4Pj0au4PmhOZDmShIWyQQeerQYY5onCsJQWCME6zDQJWiOdrwqGK0gKgKQeKppIRmj41v0RtA1dbE+vsi8uVF+lw00LWjcihkpfSMQLvIKcpQrEKF2zzSPS4Y0HxB3c7qTkSEcMb5yVASZkBF4gjWwbOk8M+Ap+DL1T4oE+65ZTgsQ01Yxc+fuQoYLmGK/Xo/mAqqKqd9xcTvHTuUHiTZyxKp7VwG7iMjoLQENfkbcXH6yhhArvIT6sTtFcn3Jdq1aOVXq14HvF5PFXFEyLUb9gmpUmqe2bAqwGEpwCc3JOiYK6nn+iyVspeGwHXt/OSx/HkonUUUFj4MTsIsJgjF0ZNaeSVdfX+cMaYqDW/jEoHwJMLUcO19thmJUN9DjFLTXzPBpzPsf9Pg7ltMTG1KBJEnPmv340frXq/7VQ5wolLfIWv3ejvoav0RF1YB/nUNKt6ZWvPP+ySfJcIiTVLphyUwf5KrLRulwgstaOvx0CjBiXXJVQZAptfCZBk1xGjMgXiWPY+2IOWKqbI+3dJi/8aF1fbYd2T6l3ciERZjN8qkg/Wo26r1jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(38100700002)(26005)(36756003)(6666004)(66574015)(6506007)(6512007)(2906002)(53546011)(83380400001)(44832011)(66476007)(41300700001)(86362001)(8676002)(66946007)(316002)(66556008)(8936002)(31696002)(31686004)(5660300002)(6916009)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNndThDVEVORm5HL1dFSzVGTWJIaDNxRDdyODRhOHEyTGFMa1VIZUVFeWM0?=
 =?utf-8?B?NFNLNTRpS29IRFF0L1dBV1g5UExya2xXZTFycGNFb1dQZ3Y0YVpKR01qUitl?=
 =?utf-8?B?ejdWbjg4V3JZWS9oTmc5Z2Y1V2k0SmJSQ2J0WGxmT29zVGVMaElpVUVVRVRo?=
 =?utf-8?B?aTJjTUdBbmlvcE9qWDJBcmNLVzRuRW8wQjljQkNRSjc1b1c3cnIxdHU5UTVI?=
 =?utf-8?B?SCtLYTVzR2JPNlUwbk16N3Q5ME5pTnZLQTN1TkYxc1EzUnFRK3doZHVRczl3?=
 =?utf-8?B?VzBiUWRONG1jR3pySXBwOFZtd3U0MjJib2ZHcHBON1haLytSQ0lLSVk0bEVO?=
 =?utf-8?B?UFhlMGpoMEtqSFA3UzExUjlycUlzbVJ4bzZ6d2MybE1wd1RoVVVKMjRoS1pM?=
 =?utf-8?B?WmtoQkVYNEdjb3NSMDIvTjlrTE1YWlh0c2ZROThaS0E1NHBjbWk2TW9tRDBR?=
 =?utf-8?B?b1FhT0NvQ3o2K1g4MzkvRE1wTXowWC84dnRJQndjT0RzQ2tHYjAzbGVvSUtW?=
 =?utf-8?B?dmFmRmp6S1BHSzRERHN1YWxrRG95c3ZlZ3gvTndCaE9tdUtVWTVKZHFpODJs?=
 =?utf-8?B?UVNzc0JFUlZ2MitiSVRaNEZ3SjJiQVdEZE5jWGp1RDZxQXFDKytNS0RIVUZ4?=
 =?utf-8?B?V29kQjRBNXNwMHF4THlveVdvVlFpTFY5aTQzTVBTV09jbVlseEd4R3pPWTJU?=
 =?utf-8?B?ZitJSGhnSFpSWnI0N3hlQ0FJQlNXRTlXcnBnVnlSVDlEYitWTjREZEMvVlND?=
 =?utf-8?B?dzR6SUNib2V4WEdnVXE0dlJWOERlcDRqUWsydnlTbVYram1EaDZTU1R1Tmpw?=
 =?utf-8?B?aXU5UURMVnZoQUV0US9CVFBCc0l5UlI0a0FXZXFCanBhZi94WnFRY0wrWGRi?=
 =?utf-8?B?K3pjcXFPM3gvVWszWWc5YmdCWDk2eEJpYW5pU2x0UnFUcmNXSGR0NWgreFhy?=
 =?utf-8?B?R2E0L3ZZeGxoNG1Nc2pGci82WDFZY20rc2RPRGVqc1lBOXFxcVhISmlseTk1?=
 =?utf-8?B?TDJLNGJrY1MrYVNiL3hHckI0bWpWc2NJRmIvQU5Kbjdtd3lYeWhEWnJNQy9M?=
 =?utf-8?B?OG5jMTUvZXdYbGtwSUlHMm1ia1RtV0JnYVdxUjNLUlpjdEJuT1NRTXhralNn?=
 =?utf-8?B?L0lha2oySnJKQURqMldBb2U2dFg0ajYzaUYyb3FKb1l2dnd3K25kdEpjeVNn?=
 =?utf-8?B?a0gvYkdkbUhTRFVkMGpvekxRYWZWbTQwSmpudUZCcHlQVVhoUjJwVGJiMEN5?=
 =?utf-8?B?WDhpcDdVMnRYVGxrU3JiQjdtVWlmRTFsOWhkVkpSanR0dk54aXI2ZkhyZU5S?=
 =?utf-8?B?ZFhmMTA2LzF3Uy9wNDRNbUJWYUNpTXEvQzVrbUphY2xHQTdacVpKd01QdDJ4?=
 =?utf-8?B?L04venNJeUVhcUhrbnFBRytrSHdCYnJyNStRMU9rRGVHcEJrVDR1ck5VYmVs?=
 =?utf-8?B?Z1g3MXRGVTA3Z1JJM1p2SGI0UVRubzg2Sy94ZjBzRGtMTUhBaC8zYnFlajNZ?=
 =?utf-8?B?NUtUSk1vY2xhcjdNN2hSaCtLLzVUVDQzZjJHbzJLRVBXaFpEL2tjTUh0SmVt?=
 =?utf-8?B?bWhJN2MrOGEydFRBOTh0dEk4V1hzczc2dWhsN3ZOa1lzWVludW5VMHpiV1V6?=
 =?utf-8?B?SWpNSytqU3orOXlGQ0NUVXNHcDJJVkIrTzE3Q1RISUZVOVFZbVA1WGZ2Nm85?=
 =?utf-8?B?RVVCeUk4VXgwNkNhM2l2bGFDYU42eDViLy9GY2hsQTdCOHVRbGRtM2tKakNu?=
 =?utf-8?B?N3lpWFVHQ3ZpSzlEVFlBbVVqV0FpQk5QblA5NGdubDBtcEt0VVV5TzJ2bkZk?=
 =?utf-8?B?bUdnRlUwU21KRG1Wa3ZtcEQyVTgzZ2pTVktPTS9hYStLZHlwSzFETjQybGV1?=
 =?utf-8?B?TnBFbmsrRDU5dlJuTmRRK1JTOThlMFRXOGJBUzVYWGFteXVHZFFFVmhpMU56?=
 =?utf-8?B?aXdVQ0VLYXhleUs2TmpNVEFjYU8xNlZOdXRKWExlZldidDNWQ2dKSHVPMjFu?=
 =?utf-8?B?MEVUOGxiNTFzbmp4dURRZVVRSWtCc2MyTml3U3F0WGZmVm1RaG4wdTZ6Z2kw?=
 =?utf-8?B?ckpWOXRHTjB3NlU0UDF6OUx6MkROcnVVUUVtT0pleGtzYloxRmUxSGs4UDJj?=
 =?utf-8?B?aExKMHJISUs1SmpEMkhBbU90U0k4d0F5WFprUVpCaEN2NTVLelMyaHYyZG8x?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a72e8-cc1a-43e1-11f4-08dbdba80cc4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 13:31:41.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ryklHeV9sm6UY9DX55EW5fkdJevX0ssZVsgyWHc0dcIOjiRfZpdXcPi97B0SJNeBQn+ML+TJMm1mTYsyDXj2f/q9xtvJ4Xbz6SIYtYNscI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6996
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor fork12 using new LTP API
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

On 11/1/23 09:11, Richard Palethorpe wrote:
> Hello,
>
> Cyril Hrubis <chrubis@suse.cz> writes:
>
>> Hi!
>>> This test also randomly fails outside of a container. Also other tests
>>> that are testing the limits. This makes me think more that setting lower
>>> prlimits is needed. Also this rewrite gets higher priority.
>> Just note that this test is not in syscalls runtest file but in the
>> crashme runtest file, which contains highly questionable stuff.
>>
>> I guess that the original test does not really take things like
>> overcommit and OMM into an account, so shifting the test goals by
>> setting the RLIMIT_NPROC so that we effectively check that the
>> limits are enforced is probably reasonable way how to fix the test.
>> Either we do that or we remove fork12.c.
> Looking at the setrlimit tests we already do this in setrlimit01 as
> well.
>
> I guess someone might want to test a fork bomb. However I don't see how
> it could be a reliable or meaningful test unless you set reasonable
> limits for the particular system that the test is running on.
>
> Just a thought; IMO stress tests are better handled by a tool like
> stress-ng and some bespoke scripts for a particular system. Or else we
> have to create a framework inside LTP for deciding on and implementing
> reasonable limits.
>
>
I agree with Richard. We can just remove fork12 and use setrlimit01 
instead (test that needs to be refactoring anyway).

Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
