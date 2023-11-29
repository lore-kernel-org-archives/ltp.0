Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C1C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 09:42:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA1A83CD955
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 10:42:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 171F73CC2F5
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 10:42:30 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1DFA1000D39
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 10:42:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbhPhBV4tpkqfHDVER3vgVUCt3s1uqPopSJK9ulFKK8/PsGCuMmlUO+/LQ94qhltFxFhrACJNYNHIHASxXtRIn7n8yX1QN62YeizSRYj8GzdkAef2lLCvVWhWdWxUtAogaN2QS8H4BQyJ9JuNijfREy7oC3irzsXzYb9leD3QJwMHktH6hmddq6xN5HgvaXopQDJzgeF9Md2LM77Hu/0CmsbPCyN1EWo5L6Vr6p3IgwHZMNYoM7aaw973PpMnnwAMcozQzx5+kScmpgXHBRKYlfhxbSY0le8/Ss35GzbB7QUL+G5wvA0Zfdlgwx4+tP00LxUy+VWdrW1YAgYdvn3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nTfPRDix7YdIxwUMX2O3QrEe1dq0MgpeAwSEk6XabE=;
 b=SEVToDo8wO7mMS4Ub6lktlh3v4gnAvTBoXn1biU1JE/qH8uK2uhixM2oqahcOZLOqVYlpMEaAaQYf9rVmV/1ueT+gYfYcsiBUCr2k//xF55NvW7CyYeW4AFEwdaWf1B85sKhU1NWL5j/q+Lq/rwpVVTMMKUObKzyJvCGbfhTD7m82QmshPnLMzmTpl4WYtu2pYsvsU0x22SZ489fuXNsSvsJFusz6sJq2RNpu0wgtD36+dYei9AQLuoNTAxhd3H/T/0iAe3/v1hFiwmmfmYT09qeSv3lb8HyQYaDHgtgBaSWLxT2QkL3YfMZjDgrbw5hLHrnF1lLvdcgDjQhUqV0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nTfPRDix7YdIxwUMX2O3QrEe1dq0MgpeAwSEk6XabE=;
 b=qBfCIfCrXQh6+blT7sPyrYZJ3SLJ5rY40A+zS8p9yk4BmsqfxRIk7RMzxyShNAga0p4FijhFOH2yqdtfd/uz3J2MlQgKEzAUlEa+qm+6D5jOVVf/2tHPhbFABC3mqxbup4Dp9CCsuu6h8csaPA4yYx+N0dQdRyWlZZN+JLXQjrHastBNXHCLFLwIi81w9oWQDQ5lOTYixHKPX2PpN9n4oqvH1oey/IUrBHaeqmeawjv7J+78NPDVZM/NrYMTi4PAEehImH4wqloJzfFm1K76wYthGT063YjkjQ7hHYT46DfA3HzsU34c9gqMp3KVgzmbn6sx9eo5ELGxQclc2qMBWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 09:42:28 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 09:42:28 +0000
Message-ID: <5af0b8c4-65a3-46cb-aa65-aad3d7f9d898@suse.com>
Date: Wed, 29 Nov 2023 10:42:25 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>, 
 ltp@lists.linux.it
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-3-andrea.cervesato@suse.de>
 <20231113160200.GD2231337@pevik> <20231128182605.GA409981@pevik>
In-Reply-To: <20231128182605.GA409981@pevik>
X-ClientProxiedBy: LO2P265CA0416.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfb4038-76ee-4b43-f592-08dbf0bf7fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJVdUFhBenfTBNB93qePOU322xhiNKGctUvOZerfT+fgOvceHjMfMEnbwMgcg5NfCuoe8sZ1T1vG3kAMU5S/DX0aXqpZaSjm9jfflwQDxGlvyf9ubxe/NC96N9M5KcBBc7CLAhiL0Hg+2Cqz/MbMu9AltK5cgynoKgRxu/Rf6u+e2sfUCzsZICbB9TmadOvWg/TdjDUrawOYnIwPG0sD32nPdB+cew6knqGnhmdVJ2QSJzg2YTI30Y0l505vURRgzj7bJDd5x8Ob+hDIWFpV7SIO8HORpIMMAYqR8W3TPKWL/JGoL1CxxoVGeH04De8JnCJuIAGNltUOMZhvBNibqKOpeij6YFWmZHbIQ4eM+gfeb9mc5g7pHw0eoogdBZrOgaWEXeo/757PPVm5YlJmHjSRmdTAA5MpQl4oRJsUw65mQJuB5bihOjFajtDdl95ymQbK5pb/MyjzXtInNDDh7/cyVmje5hOD9UFZEpJEpwiODQq9VWk22+U3CoqDoZdaC5PR5Sle4jHqv5M4u3mpvFMIv+gPvVwRtsExT3T7Xa0MqOo2S0a0/1L8PYBClX87FYKUIPPEcaOKKP6vFTqWtMPUIQcezT+JlNYZ00wR6NxE8sviU5O4MZ/wZxLi804jV/gTecb17f37FVbhiuUP+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(38100700002)(86362001)(31696002)(36756003)(41300700001)(316002)(110136005)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(5660300002)(2906002)(4744005)(44832011)(31686004)(6512007)(53546011)(2616005)(26005)(6486002)(478600001)(6666004)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhKV3A2eXloQmlKc3N0dGJUc0svMG0xSTcyZnJCTVlqYjNRdExTV3R6MEhs?=
 =?utf-8?B?Z2lodmUrU0N3Y2NQVkt2SnN6WGUzcWVxZkNORXh1aTQxWFoxbTFZVXpTUUhB?=
 =?utf-8?B?NzJ6cTU2QWZpaHpOWjFzTGsvT1RDT1ZQVVM4TDZCaVBDS21SQm9WQVR5WU85?=
 =?utf-8?B?VWx6V09PazFlVFpyTVBBS01Qa3ZXNis1aDJsc1BBRERyK3EvMXFvV2xmWFQy?=
 =?utf-8?B?aUZ6MVhnN1RFaitHSUpwRWdFMUM4OXJaa2xGYmNvYlZUcktiYnBZS1huY2Y5?=
 =?utf-8?B?dnV2SkZnSjk5U3V2SGJlVGdZN3NUWld5ejN5dm54WnUyaXJzaUN3V0tjRUps?=
 =?utf-8?B?YjAyc3NhOEFDQ1BmNFBFelJvek5aM2EvVTNuV1dMc0gzb0hsR2lDMkRqcjJM?=
 =?utf-8?B?ZjFCcy9pT3lCTE1JMC9FaFpNdTQ4QkNsTXE2VWMxMUVySk1GVTRocVg2NFc1?=
 =?utf-8?B?dk5RTXNraGp0bll4NnVuN1hJNXdIRk1sSm5RTkxZR2hLd1RFVUxiUVJvRjlY?=
 =?utf-8?B?TDhNNHUrVExDajJ5L0I2Q3dzRzBzeVFKQ3dDZWtyclVBZTB3Nk9DQVFlaFZI?=
 =?utf-8?B?U2NUczlOMWpUQ1BYNUEwZGVxb1RQbmNQaloxM2lrYlJGRG9sY2NsOThaamVJ?=
 =?utf-8?B?cjVka04xUkpXcmx4UlFrcnFtNG1NWmt6VExhWjA2dHdUNjdEM3hMdkFBUnpV?=
 =?utf-8?B?SkUydkEvVW9XZFp0TERFOXRhWXFidXJvVFlmR0xLajNucFJ5MmFsUHR3RGZC?=
 =?utf-8?B?SzF5cFdkSVBSS2ZSTnhEQmFiTlF1T3dPMlQ0anZZN3pISVJVbFo1ODVoYjAr?=
 =?utf-8?B?Zy9FVE1zZ3Q1ZWxFL0hwUWt1ak4vV2toUDJLTm5oV2pVdU5Na0JiUHVxSWRp?=
 =?utf-8?B?d3piSlQvMEt4YTlja1FLazgxT0ZWREZ3bFNlT1RuYTFwdkw3Nzh0QitSdUZY?=
 =?utf-8?B?ZTZLWFhlVFczMkl2ZTgvQmlZYnRENDd0bVRLTkQ5Q2pPbHJTZW5wZUhKSEpY?=
 =?utf-8?B?VkRqdE9VVjQ2bE5EdDR0K1FCOFFYL2VYVWxEUHJzSmJPYXc3N0hEUjB6cDhR?=
 =?utf-8?B?MHMwVDVyUjgreTZENTFwcVUzYytRaXJ4cTIrUDBONWN3cVd0M05IV1FpelZs?=
 =?utf-8?B?bjFWcUFna2YzeVFXSUZmMllYTVU1STVYYUt4SDRCcXFpeGFhTFUvOHRUOGRw?=
 =?utf-8?B?aXMyelUrenNBT2dTaXl0azBPclJ4U0JnaEhBUWJld2p4ZnVkd2hJN05xaFhZ?=
 =?utf-8?B?d01FclUwV3pWMnRCTDBUcTAycU5Gb0gwenlwYVJyQ0ZLQlNlL2taaDhJNlFQ?=
 =?utf-8?B?RCtXMkRYeEoycFRWR1F0UnlwcUUrNktvQmtlOWkwcit0SjFEL0Jqc1c5ZE5R?=
 =?utf-8?B?dENaMWFuY0Vkd3RWT3JsQUdmSVFMMEo2L2RvM09SN1Zzayt6WTZnc0JjTzJP?=
 =?utf-8?B?N3BzZ3VvMW0vWUVYbEp5bm9pREtKMVdsdmhEQVB3Rm5HeUlIV0ZScld3TDN4?=
 =?utf-8?B?c3lvQmRiY1ZIZ3EyVUZtSFMxbVhXMktheUU1MW9WK1p3aXR2cXlDcDRPc0tw?=
 =?utf-8?B?WVVQYldDRS9QeTAyZStkcmpMYkJTVHFMMm9wNlFPUGNVeitWVzQvTnJKY29H?=
 =?utf-8?B?anZDemZJWEJvbkxPZ3p4aFNYRGc4TWg1VENWS3hpTHUzT0hRWnVpVkJLV3Zw?=
 =?utf-8?B?WnViVEh2RTlTSWpneTFUNlUwMHh0Lzh1dmVjeUg5ZCtZR3IrYWUvc1ZpRUty?=
 =?utf-8?B?VWJNZXVhQjlXdjQ4SC9WT0V4a0x5QldKeGJUbjdkT1N1RStGQS9vZ1JMWVI5?=
 =?utf-8?B?cEtxK0djQjZFc2daZnVhYUxvb2oxZnZFYjBvM0RlRldDajZ3UWI5RENKazF0?=
 =?utf-8?B?YThXQVhETzgydm5UazRNeVhCb2lzNUhoYmRwNmwxck1VcFRKWmtwU2ZEM3pF?=
 =?utf-8?B?UndJalphTXozaHdCVHF6YVNVM2s2cXR2NXl6Zm5kazd0RytPR2hEcENjNW1w?=
 =?utf-8?B?YWpUNzhvcW5Ua21pcVhKbEM4Rk15UlRod2VmNis4akgyVzAwZWtOR3hpMm95?=
 =?utf-8?B?VTFBY0Z4aEdxRy9qejRUU2xMQjg2MW53RGw5ZU5vU0RNVCt3UndLT1BYaXdp?=
 =?utf-8?B?QjAwd3IxdS9yNmFEL0xwQVoxTXp0T3d2NUZ3MzRkYWp6UFlicU5kVGEybk9v?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfb4038-76ee-4b43-f592-08dbf0bf7fea
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 09:42:27.9900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ978/ETYqr/ohO7PFFE5SRkgm4DRoUkjY3laUV8NP13NrtmLYeuTyTHsm2Opkt/ZIYKLJrc5YJY6aXXRQXb44NW69dJbmZg+35rkysWB3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Remove fsx runtest suite
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

Thank you! This is a really good news.

Andrea

On 11/28/23 19:26, Petr Vorel wrote:
> Hi Andrea, Cyril,
>
> I merged the patchset with moving Makefile change to the second commit,
> where it belongs.
>
> Thanks!
>
>> Hi Andrea,
>> runltp also has fsx part, which needs to be deleted:
>>      # The fsx-linux tests use the SCRATCHDEV environment variable as a location
>>      # that can be reformatted and run on.  Set SCRATCHDEV if you want to run
>>      # these tests.  As a safeguard, this is disabled.
>>      unset SCRATCHDEV
>>      [ -n "$SCRATCHDEV" ] && \
>>      {
>>           cat ${LTPROOT}/runtest/fsx >> ${TMP}/alltests ||
>>           {
>>               echo "FATAL: unable to create  fsx-linux tests command file"
>>               exit 1
>>           }
>>      }
> I merged this as a separate commit.
>
>> With that removed, you can add:
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> BTW I also wonder if we still need testscripts/ltp-aiodio.sh.
> This is still open question.
>
> Kind regards,
> Petr
>
>> Kind regards,
>> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
