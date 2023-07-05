Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF41AEB64DA
	for <ltp@archiver.kernel.org>; Wed,  5 Jul 2023 13:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0A413CEE60
	for <ltp@archiver.kernel.org>; Wed,  5 Jul 2023 15:19:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AA923CBFCA
 for <ltp@lists.linux.it>; Wed,  5 Jul 2023 15:19:05 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 073251A00932
 for <ltp@lists.linux.it>; Wed,  5 Jul 2023 15:19:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgeYwtl0hBjpoNrbwc8x6fM3dtWA2MO6/DL66aUhfMObZ9wUS5VUyEGMcil1WRKqOULbyi9IWgNpKhUZck8vJfHa7BQqGtjolvH6Zo/8DZm+YJOKlBKRFA14eHLWhKDnpqeE2fJHCIQZzWQAmRXBUx8xM25nAamBNbu7M230R5SGDEB9VcEYWBEL+lLLKkm8er+X0tsHjCfbZLL2JwefNcAHRlXbLNqc4U4L99j+CA8yA5bm+JjwG7L6bSaCjt3rwkGuhGk8Hx7HpA0n46ZgFnRZ/qp6I/IN4uzUdWsTaMZUtzMp4i2esvs3tQp6ty2xB0Ew7+SFPQ5CKAKGEmVSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMsP7zICuPtURD+DSCDZYMW/akB0YLGxnWhpGT/4CS4=;
 b=Qsp3MiCcoeuReVRXKeCulMvQKbDdU9aFwk+HLTbD/RoNa5ZpXfvp3Pay/vRbdyF/AV2H35REuOrMFx3ytZMd+rOHcZV1rVwlReOJs2zZhGhlKx8HJQOyJ+ESh3PwEuTWaA9vjuk1RLG8dG1Z9uUxg4jWju2xt9xxGBtGAYJziCswGLZlahRbvKLhKPWA57I0spDntaoJX6KtXe5ipneOGFY/93yFG1IXfLfDgl10q92S1uc7U2o74B4LXUaCH+ZG1DTH7GyTErO1nYl9zk3KJeDqfSmw62++/IoGILIHJoqfQ1WsPF7rE1w3fqsNYiDIboP2BO51yyLzRfRiGZwntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMsP7zICuPtURD+DSCDZYMW/akB0YLGxnWhpGT/4CS4=;
 b=gIX55/6IowXPdIt+BkR4r5eZ1p756giI6thDWQxwS+KVvuary6TorIfjYbUnHtONIz5qqpC9EbcGPLLkCqDEwuibvJLt3Inx81+w8CMFB1Cpn96r1ycym9ljGU+6oL67pFXpD5Xg5J/z8EjH6iicgoxkAEUbd7HXCTNsw01zvQk1aW8e14caGQbGQ+iAiTWbz2s41GlwxODqtVyd14kcGCsAHm8VnF4DggJ1bwqkbohRSH7DQsVKPf1gX5rej3mj+N1ceXKPDj7gNEuLEAp8+S0Kn3fcL51P3VjS12lJYB+9wmkgogijX3hNXXoG721gYhRwd6kRLTte7dxc/PqybA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB9447.eurprd04.prod.outlook.com (2603:10a6:102:2b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 13:19:03 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4b97:9c5:9bab:4e53%3]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 13:18:57 +0000
Message-ID: <ead18659-fb0a-cef1-2514-b344e12d8b40@suse.com>
Date: Wed, 5 Jul 2023 15:16:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230510124206.19627-1-andrea.cervesato@suse.de>
 <20230510124206.19627-4-andrea.cervesato@suse.de> <ZGt_GrwbwPJChf6P@yuki>
Content-Language: en-US
In-Reply-To: <ZGt_GrwbwPJChf6P@yuki>
X-ClientProxiedBy: FR3P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: c22bf2fd-5e31-4afe-bf58-08db7d5a6356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLYkB5Z0PeQFO3txPmMaXUwb3Z+EKO1cPeFanzejZ1uxl9ZoAukUvIeWI2JumlH8IMQYwMUQgMHpQdxMlSN/9pm3WKR/tKNkaqCZSAHYcfSTaEUGzAWzHM/FyimOAFXEkqbLcr7C2ZYZ64d+6gudgNHI6QHyEKbID5LQfzVBpWn3DUkA0fvnY8175LfixN/qiXf5J/rdAaupwopPDWNM1JssJvMrZtvAcb0U+fAbut4VQ2vscv0zTf921uckiHprDl081zIFTzlSDkrA8hpSEtwK4eO+BXtTYbqlfTOlMXzbgkAynie03Id4HOOhkiEetw+0JPvBxNSoOM9DMsKIQ0BjVYVP2u5zVwCHPImDbjXtVXmpXPeQsORMSIygHfa0KlS3k8yiPZ1dM4kCS0t2FxexcuVPiZgQKCuUtE8RS6oZiFoDuIhN3zXvhsqmh5AardxquXkVxLDEvA6fGiYZpoX131QSmdtV7txTVH1xCI43pzq27fMn/vLYtcqOlYAFO+XYJ+WpcbZAEe/zRTf8gPxmEppVAmWMGlvIofrkFHZgBzry6F6LjybHNsMO63dSSJ9Ks3R2BXe16aTPNUG1pYFj/NptwH5S5P+QKO5tH2bgJuaW02RYCSv32VyWVLh9W4aWkZIl88srn7dFsFznoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(6512007)(6506007)(53546011)(66476007)(316002)(38100700002)(4326008)(66946007)(66556008)(6916009)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(31686004)(8676002)(8936002)(44832011)(36756003)(31696002)(5660300002)(6666004)(86362001)(6486002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBLREw2dUQzdjYzRmtLenlsZ3owNS8wRnNqUXRzeWZoMDU2MlRQUFFVZWFt?=
 =?utf-8?B?OXNPSi9QVDlieEtIOW5pVm5teWsrUEQ3NU5haWR4NFVlZVpaeDQvNU95OVBj?=
 =?utf-8?B?VkptR2FiUUNpUEZqN0tjZ055WXZCdk9yOUE3a3ZQOUJmWW5PN0xIdENNWGJ5?=
 =?utf-8?B?YURWalNmVmc1YkVEODFFMko3eHk0NVQ5dThBMEhMN0Q1ektRTmNIZnMrOXhJ?=
 =?utf-8?B?dzdMLzdYaGd6alJ1N0FZSWJ4RnVaaE9RVmdsSzYvelNsWVNxM1FBRGZTNzlk?=
 =?utf-8?B?R3haUTNZQWFBamhoZ25qSkJsMHJhSmR2cGFnV3lXREQrVDBrOHZwSkJ2YlJW?=
 =?utf-8?B?WG5SR2d1clF6ckM0amVEY2U3bVBtSWxnQ0FNVnlMV0ZuNUxzZXhaRURnUm1z?=
 =?utf-8?B?bGR6Q2hkRXpmc1dKMUJPaUhYS2paR3lUM1pseHUyWnJRdjVlOVpkNi9BMzM0?=
 =?utf-8?B?dWRBWGpKZW1tOUxON3NCNXovbEp3Ym9rY2Yra1BoaVc4MGMyTmhhNjFNNk9F?=
 =?utf-8?B?RVQ0RUtwQnpPQk5EV2lmWXc5ZVRxaGxCdVZpTHdxWlhJV3p6TzNRM3R3SVQz?=
 =?utf-8?B?WnlrUVFuNG4rWWNoMWVaajV4dFFDUWdMbldkRkFsQ3QxckVYc2VtVU9tblk3?=
 =?utf-8?B?Y2s1NWtNWEFzN1J3elFMSVViakZGUXhHbGo5eVNVNHdHU3UwSXdVVitBbm94?=
 =?utf-8?B?SmdPcXZQV24xTEZCZmduOTMwVzFNWFlRajFLZC9zYWxva2E0aVQrQ3pHWC9t?=
 =?utf-8?B?ZGc4aTFxZ3NNQWVnSzRIUHdZWVNNOUpqaEZlb1pXV0NXaVVVNkFKN2xkOEdJ?=
 =?utf-8?B?YWFsbWl0RkplWnpuRk1EUUdUMWlKd0V4RUE0TkJrZm5VNi9wNy8yWkVDcXJE?=
 =?utf-8?B?aDI0dzhOTUgvS0ZQbmQwOVdxQW9pQWRjRm1MM1JoYXVtN3lQS1ZDYUE4OFBW?=
 =?utf-8?B?RU02Q21hSTRlRDBKU1dSL3Q1QS9NOElJblh5VHBFQmxPSXZmeC9Sa0o1bWFG?=
 =?utf-8?B?L0hwQzl1ZXI5RFQ4RUttMnhZbUFCTy9PenRFVzRFTmwyVjJnMkdmS1lyQm1m?=
 =?utf-8?B?SVFqOThMUDRaUnZYR0JFTGZwMVd6K0lib0h1ZmZWbmVBYmQwLzcxUC8xcnR1?=
 =?utf-8?B?ektPN3puK0tJWFRGZlE2TEo1MG5YeEVncGxpYkluWHpQUm9TcitBN1lTeVNZ?=
 =?utf-8?B?S3BxYVRVWmZudDFNbDl5aEUvbEdtQ1YzQ3pCZDJHa1dpbGZoaWFwWWNWQzhL?=
 =?utf-8?B?MnJTYWlIcWZjeU8yOGw3SmU5bEEwY2FvWTVPdXJucWI2aGZXSTVKODJwS2xu?=
 =?utf-8?B?RldrVGFBSE1vVVFVeXFsbTNKaWRyejE4VmlYNGNxYVN2TFd1STQ3aGdZRXI3?=
 =?utf-8?B?dDI0QzJ6cWs4cmlLT0g3bE55M0oyaGY3UityQmpVenUrVWxYbEtaRlJNS21w?=
 =?utf-8?B?dnB6OW1kSG5jamVvRVZmZDNGNWNPbDlHWENMTytCdURNVTJnZjBNR1d0bC9n?=
 =?utf-8?B?YmxibnlObUNSem9VUTArWXRSQ0pqbnhseEdBQ2NFMmRlTkdXNzhocUFoRDl6?=
 =?utf-8?B?bnZmV0pOamZTS25pYmNmNTlBOVVRcG5odW1FRHhoT2xXTWpvelRTV0Z6SGNp?=
 =?utf-8?B?NDExMmdPdjdCZUkzaWtYYXJHemIxWmY2YW1XOE05WVpqOGZCbVFkZmM3UnFa?=
 =?utf-8?B?ZDgwNytzK0NJTjF2R1EycmgzeTNyYzZpQnFQa2U1WHh4RWJGbzU2RCtoMndZ?=
 =?utf-8?B?dnQrbWk2VmdZS0FZZ211QlphQW5uZWw4OWtxaUJrOHowNThadFBENWVNYldv?=
 =?utf-8?B?TThuU2M4a01kQ3FuT0t4d0tHd3pwa29RZkZGSzlHRUFaSjU5TnNMbFVzb1kx?=
 =?utf-8?B?NzNxaEpmK2N1Zms0OThZdXJ4U2ZyTk03RCt5Sm1IWG02UUQ1b3pJNkdpTUx0?=
 =?utf-8?B?WWl6am5wSkdOY1oxd1Nob3BJUDlrRjB2NEpneUs4U29aNVVoY3dOa1o5UnYx?=
 =?utf-8?B?ck5yekRrYW1NNWlIL0Nic2JNYWNwSUxwNWdUVDlBYy92Sk9ndE1pcmgzTWM0?=
 =?utf-8?B?L3VJaHIvU3B4TGtVdjRFK3Y0emZ5VWNOV3BiV3JoOFp4ejcxRWNMandudUx2?=
 =?utf-8?B?MjhCdVVLRVRxSFlmZHFmbkRPM1lqMndRQlkyL2lNS2hJa2NZSmRFeDkwWU1T?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22bf2fd-5e31-4afe-bf58-08db7d5a6356
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:18:57.2345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnam8jDBeOQvGOIIcAvTB7M4aCOJnHn2vKqIAmGoi7O2prHjcZstz58QL3u+aa+2Z7iiv9HVQ2d0Y7WELk4/00s/6NhY5jCNel5vz137KJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9447
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/6] Refactor mqns_03 using new LTP API
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

Hi Cyril,

On 5/22/23 16:41, Cyril Hrubis wrote:
> Hi!
>> +#include "tst_test.h"
>> +#include "lapi/sched.h"
>> +#include "tst_safe_posix_ipc.h"
>> +#include "tst_safe_stdio.h"
>> +
>> +#define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
>> +
>> +#define MQNAME1 "/MQ1"
>> +#define MQNAME2 "/MQ2"
>> +
>> +static char *str_op;
>> +static char *devdir;
>> +static char *mqueue1;
>> +static char *mqueue2;
>> +static int *mq_freed1;
>> +static int *mq_freed2;
>> +
>> +static void check_mqueue(void)
>>   {
>> -	char buf[30];
>> -	mqd_t mqd;
>>   	int rc;
>> +	mqd_t mqd;
>>   	struct stat statbuf;
>>   
>> -	(void) vtest;
>> +	tst_res(TINFO, "Creating %s mqueue from within child process", MQNAME1);
>>   
>> -	close(p1[1]);
>> -	close(p2[0]);
>> +	mqd = TST_RETRY_FUNC(
>> +		mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0777, NULL),
>> +		CHECK_MQ_OPEN_RET);
>> +	if (mqd == -1)
>> +		tst_brk(TBROK | TERRNO, "mq_open failed");
>>   
>> -	if (read(p1[0], buf, 3) != 3) {	/* go */
>> -		perror("read failed");
>> -		exit(1);
>> -	}
>> +	SAFE_MQ_CLOSE(mqd);
>> +	tst_atomic_inc(mq_freed1);
> I do not think that we need atomicity here, the cleanup code does not
> run concurently at all as the cleanup in the parent is triggered after
> the child did exit. I suppose that instead we need to set the mq_freed
> to be volatile because it's shared memory which may change at any
> change, so we need to tell that to the compiler.
That's fine, but I followed suggestions in the reviews. I think that 
having 3 people reviewing the same patch doesn't help the development 
process. Now I'm not sure who I should follow :-)
>> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
>> -		0755, NULL);
>> -	if (mqd == -1) {
>> -		write(p2[1], "mqfail", 7);
>> -		exit(1);
>> -	}
>> +	tst_res(TINFO, "Mount %s from within child process", devdir);
>>   
>> -	mq_close(mqd);
>> +	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
>>   
>> -	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
>> -	if (rc == -1) {
>> -		write(p2[1], "mount1", 7);
>> -		exit(1);
>> -	}
>> +	SAFE_STAT(mqueue1, &statbuf);
>> +	tst_res(TPASS, "%s exists at first mount", mqueue1);
>>   
>> -	rc = stat(FNAM1, &statbuf);
>> -	if (rc == -1) {
>> -		write(p2[1], "stat1", 6);
>> -		exit(1);
>> -	}
>> +	tst_res(TINFO, "Creating %s from within child process", mqueue2);
>>   
>> -	rc = creat(FNAM2, 0755);
>> -	if (rc == -1) {
>> -		write(p2[1], "creat", 6);
>> -		exit(1);
>> -	}
>> +	rc = SAFE_CREAT(mqueue2, 0755);
>> +	SAFE_CLOSE(rc);
>> +	tst_atomic_inc(mq_freed2);
>>   
>> -	close(rc);
>> +	tst_res(TINFO, "Mount %s from within child process a second time", devdir);
>>   
>> -	rc = umount(DEV_MQUEUE2);
>> -	if (rc == -1) {
>> -		write(p2[1], "umount", 7);
>> -		exit(1);
>> -	}
>> +	SAFE_UMOUNT(devdir);
>> +	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
>>   
>> -	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
>> -	if (rc == -1) {
>> -		write(p2[1], "mount2", 7);
>> -		exit(1);
>> -	}
>> +	SAFE_STAT(mqueue1, &statbuf);
>> +	tst_res(TPASS, "%s exists at second mount", mqueue1);
>>   
>> -	rc = stat(FNAM1, &statbuf);
>> -	if (rc == -1) {
>> -		write(p2[1], "stat2", 7);
>> -		exit(1);
>> -	}
>> +	SAFE_STAT(mqueue2, &statbuf);
>> +	tst_res(TPASS, "%s exists at second mount", mqueue2);
>>   
>> -	rc = stat(FNAM2, &statbuf);
>> -	if (rc == -1) {
>> -		write(p2[1], "stat3", 7);
>> -		exit(1);
>> -	}
>> +	SAFE_UMOUNT(devdir);
>> +
>> +	SAFE_MQ_UNLINK(MQNAME1);
>> +	tst_atomic_store(0, mq_freed1);
>>   
>> -	write(p2[1], "done", 5);
>> +	SAFE_MQ_UNLINK(MQNAME2);
>> +	tst_atomic_store(0, mq_freed2);
>> +}
>>   
>> -	exit(0);
>> +static void run(void)
>> +{
>> +	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
>> +
>> +	if (str_op && !strcmp(str_op, "clone")) {
>> +		tst_res(TINFO, "Spawning isolated process");
>> +
>> +		if (!SAFE_CLONE(&clone_args)) {
>> +			check_mqueue();
>> +			return;
>> +		}
>> +	} else if (str_op && !strcmp(str_op, "unshare")) {
>> +		tst_res(TINFO, "Spawning unshared process");
>> +
>> +		if (!SAFE_FORK()) {
>> +			SAFE_UNSHARE(CLONE_NEWIPC);
>> +			check_mqueue();
>> +			return;
>> +		}
>> +	}
>>   }
>>   
>>   static void setup(void)
>>   {
>> -	tst_require_root();
>> -	check_mqns();
>> +	char *tmpdir;
>> +
>> +	if (!str_op)
>> +		tst_brk(TCONF, "Please specify clone|unshare child isolation");
>> +
>> +	tmpdir = tst_get_tmpdir();
>> +
>> +	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
>> +	SAFE_MKDIR(devdir, 0755);
>> +
>> +	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
>> +	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
>> +
>> +	mq_freed1 = SAFE_MMAP(NULL,
>> +		sizeof(int),
>> +		PROT_READ | PROT_WRITE,
>> +		MAP_SHARED | MAP_ANONYMOUS,
>> +		-1, 0);
>> +
>> +	mq_freed2 = SAFE_MMAP(NULL,
>> +		sizeof(int),
>> +		PROT_READ | PROT_WRITE,
>> +		MAP_SHARED | MAP_ANONYMOUS,
>> +		-1, 0);
> So here you are allocating two pages of memory for something that is
> basically two bitflags. Can you at least change this to a single mmap()
> something as:
>
> static int *mq_freed;
>
> 	mq_freed = SAFE_MMAP(NULL, 2 * sizeof(int), ...)
>
>
> 	mq_freed[0] = 1;
> 	...
>
> Moreover since we can actually stat()/access() the mqueue we can as well
> check for the existence of the devdir in the cleanup and only remove it
> if it exists in the filesystem.
>
> Also I would be more afraid of the mqueue filesystem being mounted in
> the temp directory if we trigger a failure between one of the
> mount()/umount() calls, so we should as well check if it's mounted in
> the cleanup and attempt to umount it.
>
>
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
