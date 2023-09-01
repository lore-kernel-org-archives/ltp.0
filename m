Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80376CA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 11:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6663CE02F
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 13:58:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD29A3CBB96
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 13:57:53 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 430EE1A00E32
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 13:57:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD0/QOg7rNjU6ybDJiXjpZ/GKK9qAzZ/Fn9X5FqxPxKyA+wefVdHK3eviaefjrVRi2fSPqRFJF5Smm2YfKRFYij1Uu+XgZON7GPYZt6R8/WgFrewTu78sMLRQ0ARU+K4tE7a1ZLV+uLc5vBG96noFPoG93r5DKHXFXLecs0LmcvpDSj2ZJGNG5A6LehXRYoS+1IMDxkaIopwY8M9G5+d9L2qjxaMEy1VNCc0aNFp/Y/e0/2Zr4/H98wrTiCueG0zznc+JCM8kiyJ1qSHgYgmQEVkY/ABZzsCQFb28plJW2nLSHlWt1BMNOz+QK2SAaATXaNC9nRukIM9/pOBgSNUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/FOWLeryn3R+qjk1oKTMjY4NHIMqd3tZ/EsG/qpC6E=;
 b=mndDF+ybGpcUVkJy4OOz8TSckoE92RpihG/FX0hPVkyGZqUZUaoMyZ4ezliFRc0vSrAkQ9kB5uuG8POegcLKqosga9gekwXmCnYi4J5TxFJOe6VBItGRlxOc+y5TB8ga7TcO9O1js1OPZq+6k3K4AO/XYjfBVV02WKaTaO13JJWPxBVpT7zA0FUfzGKyKdDaExQ4LufB3Rq6F+0WtRo30WZEa/OGs+ook2ynbz6RSQWp0ZQvBiTpbZ9lTU/LCk9fYL793ZjxpKzBq3/t5XH98laTqP9kzWLHS3mdY36o3Zjl9t4WvZ7M4aWaoFN+u9ePwjCbrhKw1O+MNzpzLB8lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/FOWLeryn3R+qjk1oKTMjY4NHIMqd3tZ/EsG/qpC6E=;
 b=iJHlkFCU+3ShCiHZoRYThaY8I/a4lmExzXej+g3WQkEfX6prg7g1mGb4mjefSRmUnU4kgul8Al1CNcHQN5Fat1Y6pnZ5cRY+qiJl4eoiAiVNsBJucjEuoX2WT6LB1zKWz32D/46EkBPlufsqiiVPZRLY219XaK+hYqajdhP42t9JbBBE8dQGbyha1AaOGR+yI9xLVF9mQOFL3Bst5Ako/7yHmKrWBkss+szZjxMveEn3qV8PcGfWO7YlUmjz6ELDEzH9zloOCAgolBQ4ueV4YKD7UbJUnIa3AjB/HhnzSDHCtsXEh11JlI8vdu2vBlJrXMvmBan10iuErROKEFwaow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 11:57:50 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Fri, 1 Sep 2023
 11:57:50 +0000
Message-ID: <80324acd-253b-4216-8a92-04e31905c648@suse.com>
Date: Fri, 1 Sep 2023 13:57:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
 <20230831104242.27156-2-andrea.cervesato@suse.de> <ZPCWWXXHG-oEB5qO@yuki>
In-Reply-To: <ZPCWWXXHG-oEB5qO@yuki>
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PA4PR04MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 73369299-9fac-490a-ee9f-08dbaae2aab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9J3BFx8c/4/0TlZr7+DOIAFNdTkfULPNhf/PSI9L/ZkWgJ3InzffWzck1d9RdHJmsq8AYzmDBJpUmnd+4FvIx8uYhKr7v5Sf7K1NFtaxWDI77QysXzNQJhYtjV9cOtlfUDYCwig3HTrlLOHfaF5di2A55S0JLzVNF5e1A56PaHC9cLBaPw6VRNpJG/dBhhNLDjNdHaejm9X97nSHhih+1EqFatyfPIfvheDPT/DAor7NsIJY/UkJvrDdBa2VBBjx3HnQGhnfSZ7MKT+th5nE+3+cj3RpovOt6phLA2nOWOSac4SVQQAkyj7rIoRxmdnwMOTSR3+GqoIXEuAS+mDMJj8IHGjGqfUj5m2ChdagTxvoIINAp/TSa0YHkH3bx/q85j1Z7zpKTDz6oWg/B4uUciu/RBonlba7+kuPkmNArkTiNEVZLnDARVs+VSmANrVvu7tyoooJPvU4odIDc9E8ywLQTIzun3YrHY2Fj8ihln4izjHN5C09X3jMSqVtsgY/YcVWQ3SENEOOXOmilHxEX1/+Mu8549IvzQVjCSsieTCbEg1UqCSdZDiH59kieqw3atzSPa2y+Sj7TqzCJePBp7ty8ejZzphN32iwEi5JTtC7X5gS2Fqw/9pEOFc311gjH6BoiNECxBs6AwxEFmsRpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(186009)(451199024)(1800799009)(38100700002)(478600001)(966005)(2906002)(8676002)(44832011)(4326008)(5660300002)(8936002)(66556008)(66946007)(316002)(110136005)(66476007)(41300700001)(36756003)(86362001)(26005)(2616005)(83380400001)(6506007)(6486002)(6666004)(53546011)(31696002)(6512007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhUWnpnNU5kK2VHOU1qTm5BRzVScXVMeVQwOVk3NkN4WndqZEw5d05PQzdY?=
 =?utf-8?B?M05pN1lFazZ1blBYcVp3Ky9lQ0hNVHcxWWsvdVdLYURVNi9GSk9lZWR2Smx1?=
 =?utf-8?B?R3ZOMHhvYnhXUk8xTEpTaWhQSVdGQ3QxRnBIYTVKbXZHZk12M2d2Yy9La1Vs?=
 =?utf-8?B?TVNCK1Bwa2lmSS9EaFBGcUJjVU9IR3JXUC9IejBUZmF6YUxVVEZFa3phU05k?=
 =?utf-8?B?Wkl1dHN1bVBoK1lLSGNyeFBlUW03dy85bmJvMjY2STdYRzlXUFNDamxTWHR2?=
 =?utf-8?B?bkNIK3RUUkZXMkt3WXd6Z3I1VC9qU01MVzY4NFo5QnJQQjQvemw4UFBhQWd5?=
 =?utf-8?B?cG40SHlZcGNvNDBlWGlOL3JzNmVKZCtaYUtXdmwzTTJzT2VLdloyVkJvWTAr?=
 =?utf-8?B?a0RrcGtLTkwzQStXYWlWd3lib3NQRkhhWXdjTjFiMDJ0M1UrdUtjaEhMMGkz?=
 =?utf-8?B?RTZIbURyYVNTY0liWTN4cDJrT1BRbHhqdGVkdjBGTXZHZEwxYlN5RlZrbmhP?=
 =?utf-8?B?UGErWHpJZE4rblVkcEpDa2FTdnh0L0FVdkp4M0IrSGQvNFM3TkQ4QUQ2OFpQ?=
 =?utf-8?B?dmc0RCtTSGQwUDdRUHlRaWttTnExSVROYll2dnRCVUdLQjRleDJSRDhvbzls?=
 =?utf-8?B?aUpHV3NCTFg4MVJRdkFrR21jSCtwcDNCcnFkNEQrOGZhZjZpNlJXU2E0RGZL?=
 =?utf-8?B?VWcwcG51VkJvcXIzN1Fad2FYRU5PQXpsTUZpOGFhSVQ0SmNuWFZITkRmakRQ?=
 =?utf-8?B?b3V2QlQ2aFZPdk91TFpoY2J4NGpLaFNmbHA4dVMvOGtlaU5LVFZQRnhmKzFl?=
 =?utf-8?B?ZXQ0SjlnUmhUREhQTHlVN1dYamFXT2N4YUhzWWMvUGs1SloyKzYwK0RZMVo1?=
 =?utf-8?B?cjdKNmw3VWJYeU04c2ppRkF2M1JDYzIvSlYydlQzOEZhY2tHb2plS0hmMUhR?=
 =?utf-8?B?eEVFM3dYZmVIcVFNc2VSRVFkVkdCSkNlejIvN0llQUlxaTA4ZUFKUkpUa2FS?=
 =?utf-8?B?OTJHdUdBOFVucGhTU1FkRDhIdHZObjc4WWx1bHExMnJxNnV6cTdJTnZIaE4x?=
 =?utf-8?B?QzFTZmd3Mk1DcjIzRkt4UDg1em1QNzN3TmpZcmoxUVNFR1VBSWk2eXVGak1z?=
 =?utf-8?B?N2dXam1qL2hjZ1dpOGdDVm0wdldxK1FDSEhHdzdBRS9ueFJkeTVZd1R5MW1B?=
 =?utf-8?B?cFVtZCtSTkN2U290T1hkSTh2NDdiaTZCZlRRMzcyZkZtTXZlMU95WFBISmJ4?=
 =?utf-8?B?ekRoU2lPUkk1bVk3NnV5VU1GWTh2YjdITmRqMks4bE1LUGZXbVV5MXdyUnEw?=
 =?utf-8?B?a1RlL0dHZG9OTGJuUjYzb2phM0ZEc2ppRFFhVUVGaFhWM1A1cEVnd2tCVU9M?=
 =?utf-8?B?eElEczhRL09TRnBXdUtVUVZWakpka3dEQkNpNEN4ZHl6RGRhVHI5cnNGMmtw?=
 =?utf-8?B?alJHMGcyamhlM0JoTjMvK00yczBMVzI3VUM1TE1xNUdVczZKeU1IZkpBUGE0?=
 =?utf-8?B?VUo1TEU4R254NmJiZmxFNCtGb1Nac052Z25sOUh5MnZBc1dtbUFmcFBiMWxZ?=
 =?utf-8?B?ZDNhZmZjbUFQT0pIUkUzSU53OUVLQ3RYRUhkOFVGcld5RVZYZHpvRHp5WXJW?=
 =?utf-8?B?czJiUks1cWwwb1FmTXgxVHBrSi9zUDRZd1UwUjBJQkFMd3h3cCtnMWlRK09Q?=
 =?utf-8?B?WDBvSGE0c0pxNTNBOEhtOVZWMFNjYUJEM3BQb2laeGdINWhNR1phYUVRVjQ3?=
 =?utf-8?B?R0VvdlhWWVBsS253a1VDR2diVnF6aTZJQ3FJUWxzRjhQWmZrQUE2NmV1UmJp?=
 =?utf-8?B?SlRhdnkwb2xwSzZLc1RzKzRhRHFnQ0syRXZHZjR3WmFBZXNsVUp0NlVpb3Ew?=
 =?utf-8?B?T1ZOV1F0YWtnaEwydlNwdHljTVg4TFp4bHZYK0RTQUVNU2R4QVRaQmJUSjkz?=
 =?utf-8?B?bC9OalRLYjZUNjVkUHlqTld0ZE5DNUJieG9nMUI1T1EzeEhTMzVPNmpMc2tn?=
 =?utf-8?B?N2gzbjB4M0dXSlpoZVowdExZRGJTTTZGbWJidHZIUklPNnlOOGEralR4VGh2?=
 =?utf-8?B?ZHdmaW9CVXpYSHlEeW9BaExHQ1pPV01oT0plTnhrQnozak4xS2pYTnQ1cHA2?=
 =?utf-8?B?NTZzQVRLc2I3K3NkYWl4eXVXKzRwS3d5U1pmVUVSTGhkYzJpRm95dVlvRFpU?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73369299-9fac-490a-ee9f-08dbaae2aab3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 11:57:50.7587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCxjUlKu9tj5N0Q8bwDG8dsqfgckyE4nCKqLTkhEcGMKcBggWNfBB9Utk4RRiazQnhQ+k6wp7UD+SiPXK1+jOwFPVlL2j2nr2FQS/c1zM+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9222
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Refactor getegid01 using new LTP API
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

the last thing.

On 8/31/23 15:32, Cyril Hrubis wrote:
> Hi!
>> +	gid_t gid;
>> +	gid_t st_gid, st_egid;
>>   
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL | TTERRNO, "getegid failed");
>> -			continue;	/* next loop for MTKERNEL */
>> -		}
>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "Gid: %d %d", &st_gid, &st_egid);
> Hint: You can use assignment suppresion '*' in order to get rid of the
>        dummy st_gid variable.
Also, unfortunately this is not working.
>
>> -		tst_resm(TPASS, "getegid returned %ld", TEST_RETURN);
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> -}
>> -
>> -static void setup(void)
>> -{
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -	TEST_PAUSE;
>> +	GID16_CHECK((gid = GETEGID()), "getegid");
> And this does not work at all.
>
> The GID16_CHECK() is for the case where we have GID that is 32bit and we
> want to check if the value fits into 16bit. In this case we get 16bit
> value from the sycall, so the check will always be true.
>
> Also the check only returns value, which we ingore here, so this isn't
> doing anything at all.
>
> What we need to do instead is to check the gid from /proc/ that is 32bit
> if it fits into 16bit (in the case of the 16bit syscall) and skip the
> comparsion below.
>
>> +	TST_EXP_EQ_LI(gid, st_egid);
> So the code here should really do:
>
> 	if (GID16_CHECK(st_egid))
> 		TST_EXP_EQ_LI(gid, st_egid);
> 	else
> 		tst_res(TPASS, "getgid() passed");
>
> Which skips the check on 16bit syscall in the case that the GID
> overflows 16bit, however we still have to report at least single TPASS
> otherwise the test will be failed by the test library.
>
>>   }
>>   
>> -static void cleanup(void)
>> -{
>> -}
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +};
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
