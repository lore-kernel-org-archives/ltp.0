Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D72C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 12:24:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0081A3CA7D6
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 13:24:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4693C19DF
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 13:24:01 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFB791400BF6
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 13:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1647260639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RA+wz+JVQarSDKOI83xcXKIfoG6Qm/ijMNQ4NSyDyf0=;
 b=KvJ6bmK/KP3f//Hp1AQ9kpAViM2pHdipkbxgGn5mLND9exMEh5kIZr0dzUfbz4+UutsC23
 lA12vS2VbospPWRdDSXVyAKYZmSl3L/6I2/UVxX6Tkz36qq1n1vKAOXA6rickic2EEk9fd
 kgQSoymV2C85XU2bdB0JJ3YGAKOQilg=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-G3BMXXBfMNGDeS6s9yRpAg-1; Mon, 14 Mar 2022 13:23:58 +0100
X-MC-Unique: G3BMXXBfMNGDeS6s9yRpAg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+ptM51mu9dDl4s6vTInDoRGlxsI3ywMRALQoiLgI0Y1Tnx2/Xfaco3RHbEmrzhhd8ej6isLWmjcUYF4uw9tZRnf+hMmArkpfHOsjnLSLojd8zVs3vwPXEUwQd7aa1WzgtRBAU9djUwRsiemAPmT3h2T8WEj9q5bG3h2+BylJbm7hoVmUmNowsipmjksnF61e2tC2kf4vAW8oTszNdo2HjvP5f7QnidFXJ+O6kE7JX/dQDGdFbQCKJKUaTyaHZ17aXbagKsyf5QHKnRAjE8GP/UWpnS2k1Uen3Xv5GOF1twvDTQnVc/+UVQCl/wvrs+J5a3CU9IUoFZ3zp97D6RERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA+wz+JVQarSDKOI83xcXKIfoG6Qm/ijMNQ4NSyDyf0=;
 b=kxhiZUPJ30HCRyZ8++AKHcNTjQlPPrU8XTt7DX7jzyGpk4zGsAmSW026QgKn58f8w4hB2vGOI76D1CNKglykIEyeKFdQlCkTs+FE1pCB+25cDyYoMjRv5FeBQeCP1Cm/ArVj2BqsTu7BrCDHOpSTILZ5h69JzXE9L3PLDDGIWIUVD8ui+ZLjsIK2sgK9NIdbXPCUVDkQIfB+mOG3/VIoucHpJxLuLtzn4nb1nHv8117fZkFFEsKXB0BedntT0VoWLHPKC1WVXKUK7ybG1V9evvAP5sMO9FhzI68Y7nws9GPcz9XLbBi3jZn34qNgQtvxqlI/26t5FxZCVtzKbY/Jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB4899.eurprd04.prod.outlook.com (2603:10a6:208:c5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 12:23:56 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 12:23:56 +0000
Message-ID: <048dca25-9519-5575-aadf-313250f8b011@suse.com>
Date: Mon, 14 Mar 2022 13:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
 <20220310105916.7960-2-andrea.cervesato@suse.de> <YioISjHts5dstfLM@yuki>
In-Reply-To: <YioISjHts5dstfLM@yuki>
X-ClientProxiedBy: AM6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::21) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171a6043-0055-4571-b280-08da05b5823e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4899:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB489973DF3685B4B9213644D4F80F9@AM0PR04MB4899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YglBrzplvLMTsrldq7H3RefWVpz3tXSFfhTKtLkZjr8KV1GRGJSWPz5mmvGKknKpiWgzhyZ+jdj9EbS6OAWf3R04R6J3n6WCv5HPK5KfL9sqv1y79qXIJmmMZ3YmP+J9cuvkBIKTwbkVO96faWzaYjQh/EHcjVSgv1iGtWOEvCJEP/Mwgd0sVWdJ2d9etUpbTPtBlE+FhamDHZJsWX+TwTluVzJkRMNuwqJXpwqVII+vna98NMY3UrtKBgsJOadi66/sTcI/WRxCWLKvmWWAtKzzzOf8HlqGK2SQ6e1rdlOLHQ7/y5E/Wo691wQiPoQz6BBh4JxK9ueu0+8zPkC9YCkReR1H30gKgzUSf3w+nhc18GZlPipgIThx6AdGenAFVs+vKMnfMCllk2Fwl7RGbfsFTiFzuOTY1P+lurs4Kcy7tuCdpJ1dhd/aZtXtNY8kZFWSJtFYTAHntx76vNNGkOwTcmRic/OZJ10GLvBNlvid6WBAJV3CdWdEb6qafxf1GT0vIdYp/w12mt+/OwOrimJroW1eTPUFRZlfhEs0n30kenWkacrbOG7Qfg4LumflTlQlEuwlnT0YJ5n/GxfY+2IJ7BAyC/LT5G9WRQVuBusL8IKd44PgzSjtPlofBbi87UOUQ+Rx4Wai1GKuA4RGyLACqHZg3RTm6tzxmB+Ez2tvVZdJdZ/7Cs8HPoU9ON1M68kE/Y16ngSBRh4lQi0kAHXUURxUwvklN4MqPpEMT/ELJn1kZI93Y8ZV/oHbt53z6mpQmcA58+kL0sZJAbRlwrGfO45ogeXunjlxdfcQa/Mt5SKcB1NKZBqEDQ1iZcIsCXBVTg3dGgQR64ntz0Gp0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(316002)(86362001)(38100700002)(31696002)(166002)(966005)(6486002)(110136005)(5660300002)(8936002)(2906002)(66946007)(4326008)(8676002)(66556008)(66476007)(36756003)(83380400001)(44832011)(2616005)(508600001)(6506007)(6512007)(186003)(26005)(53546011)(33964004)(31686004)(30864003)(2004002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW1CQkJUeXdvam8yZU1DVldhdlRhTlVOdlFZa1JuU2txUzRCRkRSam1zV0Qx?=
 =?utf-8?B?TmRqaUxRU0prVnNnalFqNkJDeDZ2SURuY01XRzRuRzBISzdRWS9LbWtzS2pK?=
 =?utf-8?B?UGRxTmlrcEgySzlzZ1VaS2NRRm9lQkZZRzdMeUdwWlE0ZDRESVpBSHhVUGQ3?=
 =?utf-8?B?MGhValJYZy8yU3ErRWkzWXlqVEVjeGh5WHF6N2RzUVpWQWZ0NXRyWGdYRndZ?=
 =?utf-8?B?QU81TkMxb0thdDFxZitmdVJBQi83WFZyWkFkU2dEU3YxRm9wQlluQUFQVCsv?=
 =?utf-8?B?MEZyWFdHZHNLV3Z0b05rdTlyMDZ2aFlxczVrcEtuV2laMEIwN0JEUVlMaGFi?=
 =?utf-8?B?Z25ubm9iN2pZcWlJSjg3aUJVV0VVVTdpblRSazBteTBUSjZBUlpVM0JVTmdS?=
 =?utf-8?B?Umw0UFJQcXltTWluSEhZQkluU21MSjd3OTNKTzdaNXRyaEkrd08yZWJ2Rytv?=
 =?utf-8?B?RDBpOURUTm5uK0xYUnkyWDZwMUFpb0JsZVZzUTE0amgwS2xSMFdJZE00RGdG?=
 =?utf-8?B?Ynl3cnVWU3lld242NEhCMTNLSVMwSkoxNzE2T05kam4yMFdrUnJ3Qjl6czcw?=
 =?utf-8?B?MnBEK0dMWjVJQnFtVlVpanVaN29QMzhWYVI2Z3c2YVY4d2t4NU1Ga0NoZHlF?=
 =?utf-8?B?dHBVWkc0NEpwTGVKZ29MYmtRWjh3SWk0dW9ndjlDVHBxZ01vWE8xcWtpYTd0?=
 =?utf-8?B?ZVBBdkg1R2F0bUNzUldsblVzakYxSlAzT2FRY1l6cnN3MXprM0hFMXhCeExC?=
 =?utf-8?B?a1pZRmxjVWR4T0dxWmlIVHNCVUNvZGFIZWFaVU8vUVhhVXc1Z0ZlcDd0ZkF2?=
 =?utf-8?B?dmQvWU8xc05DaE5ta3N2d1BRMXVTWHpiWElZV01wMFNHaDdLZm9ZcDNXMDBl?=
 =?utf-8?B?R1ZkSkNDdVRORWg2UjJ3eHVKNEdManp0MS8rS3lHWmlWODZCYkdDNk5NZmcr?=
 =?utf-8?B?M21RSUcrYlNWZVBtejhERFlFbTVXTXN3UjFMLzh6Wi9JdUhJVnJ1RXRKSFNM?=
 =?utf-8?B?aXZDd2tpTStNTGt6d3d1amhBdCt3Q3A5VUFTbXQzaDRFNzdyZkY1bjR5Q3Ar?=
 =?utf-8?B?ZnNKVXordE5ZOXVza2lDb1ZRUFNpOUlLZ25CZzZTZlhmbGdWbW9WYkNhMEdl?=
 =?utf-8?B?UCs1bTJrRm9lRnNXRDJPdWx1dmlJRVV1dmh4NmxQenBINWFYYzVONkpOelFO?=
 =?utf-8?B?eHAwWVpsOVQ3SSsxTmZyaC9OdTFmRzdaQU05b0VnYjZHakVQb3AzVzg3Sk1N?=
 =?utf-8?B?S3lvY2JhSmt2Vm5XalI1RVhtYUdxcWdDWGpqL1VKR0VMZ1QwMzVJNnNGK2Qv?=
 =?utf-8?B?cGphMzl0WHFFSGdjcVpIZ1NNbWZ2dysrK0FDTEw5dTR3aGFtUDJJWnhZckRw?=
 =?utf-8?B?WmxxbERwM2s5YUNBOU1VZzZlZmFLeXJKUjZqeHlGV1QwUklseW9NaHdFbHFh?=
 =?utf-8?B?SktKRkdFWGhLVkJTYlBnSUhEZCtIcEpTZHNSOGRVTWw3WlM1dWVpSDVsdVpW?=
 =?utf-8?B?K1lFM0hvWVFTZWtMb2FnbkJsWkV0Q3BvblFZK1JTM0NjTGE2aGFtazJHVUdJ?=
 =?utf-8?B?aGpEazBGREVKUWt1YytGcm94eXZ4eFFESmlTL3NmdjZ2a0k1VDJzcUJEWFEz?=
 =?utf-8?B?U3JUYlQ2M2lYVmxqcG1KWGZFU2k2a0I4ZGl6bXFVUVRPUUVIU2FsTUFYajcw?=
 =?utf-8?B?WnI2NlpSWmhVWFByVjhTNnRPbGNIVkdadmV2c3hKSkUzcXBCaDlpVUx1Qndj?=
 =?utf-8?B?VjUrcC9Ya3dFZHl0dTczb0t0SlV1eEtoOWlHNTlWTVBNQ2E0dk9Zams0TnJu?=
 =?utf-8?B?WGVzR3VtU0diNU5EU0d4MW1EaTBuc3VGMzM2ejdzbThTUmVaYjBBN3ZWYktD?=
 =?utf-8?B?NndRL24yN2Q3WkVtOGhIa0YrNmpRdmk0T25rSmhPSkRJeEZwWnQ5NlozQTBT?=
 =?utf-8?B?T2dxL1NLVmpOb2ZDZkMxcHV0Z2VDVFMvRlNPdVR1aVB3NVEvMjJtM3NZMlVt?=
 =?utf-8?B?ZDhiMHlQRHV3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171a6043-0055-4571-b280-08da05b5823e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 12:23:56.1837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRarM69V5zmWy7AvKNLVx+rscsj4HkHwu6/DGg8VP2FAZghwH7P1Xkl+ROcDsVJyMPWS7KGWoVb6eez+6135TL+8HVo/hW+iaRtbSu0ne+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4899
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/10] Rewrite mesgq_nstest.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============0157648431=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0157648431==
Content-Type: multipart/alternative;
 boundary="------------sYtbVF2FcDV9hFWHe2eoTCuq"
Content-Language: en-US

--------------sYtbVF2FcDV9hFWHe2eoTCuq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 3/10/22 15:16, Cyril Hrubis wrote:
> Hi!
>> ---
>>   testcases/kernel/containers/sysvipc/common.h  | 157 +++++++++++
>>   .../kernel/containers/sysvipc/mesgq_nstest.c  | 247 +++++++-----------
>>   2 files changed, 254 insertions(+), 150 deletions(-)
>>   create mode 100644 testcases/kernel/containers/sysvipc/common.h
>>
>> diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
>> new file mode 100644
>> index 000000000..1fea6fafa
>> --- /dev/null
>> +++ b/testcases/kernel/containers/sysvipc/common.h
>> @@ -0,0 +1,157 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) International Business Machines Corp., 2007
>> + *               Rishikesh K Rajak<risrajak@in.ibm.com>
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>> + */
>> +
>> +#ifndef COMMON_H
>> +#define COMMON_H
>> +
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +#include "lapi/namespaces_constants.h"
>> +
>> +enum {
>> +	T_CLONE,
>> +	T_UNSHARE,
>> +	T_NONE,
>> +};
>> +
>> +static int dummy_child(void *v)
>> +{
>> +	(void)v;
>> +	return 0;
>> +}
>> +
>> +static void check_newipc(void)
>> +{
>> +	int pid, status;
>> +
>> +	if (tst_kvercmp(2, 6, 19) < 0)
>> +		tst_brk(TCONF, "CLONE_NEWIPC not supported");
> 2.6.19 was released in 2006 it should be safe enough to drop this check
> now
>
>> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child, NULL);
>> +	if (pid < 0)
>> +		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
>> +
>> +	SAFE_WAITPID(pid, &status, 0);
>> +}
>> +
>> +static inline int get_clone_unshare_enum(const char* str_op)
>> +{
>> +	int use_clone;
>> +
>> +	if (strcmp(str_op, "clone") &&
>> +		strcmp(str_op, "unshare") &&
>> +		strcmp(str_op, "none"))
>> +		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
>> +
>> +	if (!strcmp(str_op, "clone"))
>> +		use_clone = T_CLONE;
>> +	else if (!strcmp(str_op, "unshare"))
>> +		use_clone = T_UNSHARE;
>> +	else
>> +		use_clone = T_NONE;
> Why do we have to parse the string twice?
>
> Why not just:
>
> 	if (!strcmp(...)
> 		...
> 	else if (!strcmp(...))
> 		...
> 	else if (!strcmp(...))
> 		...
> 	else
> 		tst_brk(TBROK, "Invalid op '%s'", str_op);
>
>
>> +	return use_clone;
>> +}
>> +
>> +static int clone_test(unsigned long clone_flags, int (*fn1)(void *arg),
>> +		      void *arg1)
>> +{
>> +	int ret;
>> +
>> +	ret = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
>> +
>> +	if (ret != -1) {
>> +		/* no errors: we'll get the PID id that means success */
>> +		ret = 0;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int unshare_test(unsigned long clone_flags, int (*fn1)(void *arg),
>> +			void *arg1)
>> +{
>> +	int pid, ret = 0;
>> +	int retpipe[2];
>> +	char buf[2];
>> +
>> +	SAFE_PIPE(retpipe);
>> +
>> +	pid = fork();
>> +	if (pid < 0) {
>> +		SAFE_CLOSE(retpipe[0]);
>> +		SAFE_CLOSE(retpipe[1]);
>> +		tst_brk(TBROK, "fork");
>> +	}
>> +
>> +	if (!pid) {
>> +		SAFE_CLOSE(retpipe[0]);
>> +
>> +		ret = tst_syscall(SYS_unshare, clone_flags);
>> +		if (ret == -1) {
>> +			SAFE_WRITE(1, retpipe[1], "0", 2);
>> +			SAFE_CLOSE(retpipe[1]);
>> +			exit(1);
>> +		} else {
>> +			SAFE_WRITE(1, retpipe[1], "1", 2);
>> +		}
>> +
>> +		SAFE_CLOSE(retpipe[1]);
>> +
>> +		ret = fn1(arg1);
>> +		exit(ret);
>> +	}
>> +
>> +	SAFE_CLOSE(retpipe[1]);
>> +	SAFE_READ(1, retpipe[0], &buf, 2);
>> +	SAFE_CLOSE(retpipe[0]);
>> +
>> +	if (*buf == '0')
>> +		return -1;
>> +
>> +	return ret;
> Can we please clean up this mess as well? We can easily use
> SAFE_MACROS() in the new library and we do not need to propagate errors
> via pipes anymore. So this should really be just:
>
> static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg),
>                          void *arg1)
> {
> 	int pid;
>
> 	pid = SAFE_FORK();
>
> 	if (!pid) {
> 		int ret;
>
> 		SAFE_UNSHARE(clone_flags);
>
> 		ret = fn1(arg);
> 		exit(ret);
> 	}
> }
>
> And once all tests are converted we can even drop some more of the code
> since the fn1() can be declared to return void as well.
>
>> +}
>> +
>> +static int plain_test(int (*fn1)(void *arg), void *arg1)
>> +{
>> +	int ret = 0, pid;
>> +
>> +	pid = SAFE_FORK();
>> +	if (!pid)
>> +		exit(fn1(arg1));
>> +
>> +	return ret;
>> +}
>> +
>> +static void clone_unshare_test(int use_clone, unsigned long clone_flags,
>> +			       int (*fn1)(void *arg), void *arg1)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (use_clone) {
>> +	case T_NONE:
>> +		ret = plain_test(fn1, arg1);
>> +		break;
>> +	case T_CLONE:
>> +		ret = clone_test(clone_flags, fn1, arg1);
>> +		break;
>> +	case T_UNSHARE:
>> +		ret = unshare_test(clone_flags, fn1, arg1);
>> +		break;
>> +	default:
>> +		ret = -1;
>> +		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__,
>> +			use_clone);
>> +		break;
>> +	}
>> +
>> +	if (ret == -1)
>> +		tst_brk(TBROK, "child2 clone failed");
>> +}
>> +
>> +#endif
>> diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
>> index dbf311dc8..bb58b7211 100644
>> --- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
>> +++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
>> @@ -1,175 +1,122 @@
>> -/* *************************************************************************
>> -* Copyright (c) International Business Machines Corp., 2009
>> -* This program is free software; you can redistribute it and/or modify
>> -* it under the terms of the GNU General Public License as published by
>> -* the Free Software Foundation; either version 2 of the License, or
>> -* (at your option) any later version.
>> -*
>> -* This program is distributed in the hope that it will be useful,
>> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>> -* the GNU General Public License for more details.
>> -* You should have received a copy of the GNU General Public License
>> -* along with this program; if not, write to the Free Software
>> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> -*
>> -* Author: Veerendra C<vechandr@in.ibm.com>
>> -*
>> -* In Parent Process , create mesgq with key 154326L
>> -* Now create container by passing 1 of the flag values..
>> -*	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
>> -* In cloned process, try to access the created mesgq
>> -* Test PASS: If the mesgq is readable when flag is None.
>> -* Test FAIL: If the mesgq is readable when flag is Unshare or Clone.
>> -***************************************************************************/
>> -
>> -#define _GNU_SOURCE 1
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> -#include <unistd.h>
>> -#include <string.h>
>> -#include <sys/ipc.h>
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) International Business Machines Corp., 2009
>> + *				Veerendra C<vechandr@in.ibm.com>
>> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * Test SysV IPC message passing through different namespaces.
>> + *
>> + * [Algorithm]
>> + *
>> + * In parent process create a new mesgq with a specific key.
>> + * In cloned process try to access the created mesgq.
>> + *
>> + * Test will PASS if the mesgq is readable when flag is None.
>> + * Test will FAIL if the mesgq is readable when flag is Unshare or Clone or
>> + * the message received is wrong.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +
>> +#include <sys/wait.h>
>>   #include <sys/msg.h>
>> -#include <libclone.h>
>> -#include "test.h"
>> -#include "ipcns_helper.h"
>> -
>> -#define KEY_VAL		154326L
>> -#define UNSHARESTR	"unshare"
>> -#define CLONESTR	"clone"
>> -#define NONESTR		"none"
>> -
>> -char *TCID = "mesgq_nstest";
>> -int TST_TOTAL = 1;
>> -int p1[2];
>> -int p2[2];
>> -struct msg_buf {
>> -	long int mtype;		/* type of received/sent message */
>> -	char mtext[80];		/* text of the message */
>> +#include <sys/types.h>
>> +#include "tst_safe_sysv_ipc.h"
>> +#include "tst_test.h"
>> +#include "common.h"
>> +
>> +#define KEY_VAL 154326L
>> +#define MSG_TYPE 5
>> +#define MSG_TEXT "My message!"
>> +
>> +static char *str_op = "clone";
>> +static int use_clone;
>> +static int ipc_id = -1;
>> +
>> +static struct msg_buf {
>> +	long mtype;
>> +	char mtext[80];
>>   } msg;
>>   
>> -void mesgq_read(int id)
>> +static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
>>   {
>> -	int READMAX = 80;
>> -	int n;
>> -	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
>> +	int id, n;
>>   
>> -	n = msgrcv(id, &msg, READMAX, 5, 0);
>> -	if (n == -1)
>> -		perror("msgrcv"), tst_exit();
>> -
>> -	tst_resm(TINFO, "Mesg read of %d bytes; Type %ld: Msg: %.*s",
>> -		 n, msg.mtype, n, msg.mtext);
>> -}
>> +	id = msgget(KEY_VAL, 0);
>>   
>> -int check_mesgq(void *vtest)
>> -{
>> -	char buf[3];
>> -	int id;
>> +	if (id < 0) {
>> +		if (use_clone == T_NONE)
>> +			tst_res(TFAIL, "Plain cloned process didn't find mesgq");
>> +		else
>> +			tst_res(TPASS, "%s: container didn't find mesgq", str_op);
>> +	} else {
>> +		if (use_clone == T_NONE)
>> +			tst_res(TPASS, "Plain cloned process found mesgq inside container");
>> +		else
>> +			tst_res(TFAIL, "%s: container init process found mesgq", str_op);
>>   
>> -	(void) vtest;
>> +		n = SAFE_MSGRCV(id, &msg, sizeof(msg.mtext), MSG_TYPE, 0);
>>   
>> -	close(p1[1]);
>> -	close(p2[0]);
>> +		tst_res(TINFO, "Mesg read of %d bytes, Type %ld, Msg: %s", n, msg.mtype, msg.mtext);
>>   
>> -	read(p1[0], buf, 3);
>> -	id = msgget(KEY_VAL, 0);
>> -	if (id == -1)
>> -		write(p2[1], "notfnd", 7);
>> -	else {
>> -		write(p2[1], "exists", 7);
>> -		mesgq_read(id);
>> +		if (strcmp(msg.mtext, MSG_TEXT))
>> +			tst_res(TFAIL, "Received the wrong text message");
>>   	}
>> -	tst_exit();
>> -}
>>   
>> -static void setup(void)
>> -{
>> -	tst_require_root();
>> -	check_newipc();
>> +	TST_CHECKPOINT_WAKE(0);
>> +
>> +	return 0;
>>   }
>>   
>> -int main(int argc, char *argv[])
>> +static void run(void)
>>   {
>> -	int ret, use_clone = T_NONE, id, n;
>> -	char *tsttype = NONESTR;
>> -	char buf[7];
>> +	msg.mtype = MSG_TYPE;
>> +	strcpy(msg.mtext, "My message!");
>>   
>> -	setup();
>> +	SAFE_MSGSND(ipc_id, &msg, strlen(msg.mtext), 0);
> With large enough -i this will block sooner or late in the case of clone
> or unshare because nobody reads the messages in this case. I guess that
> the easiest solution would be:
>
> 	if (use_clone == T_NONE)
> 		SAFE_MSGSND(...);
>
>> -	if (argc != 2) {
>> -		tst_resm(TFAIL, "Usage: %s <clone|unshare|none>", argv[0]);
>> -		tst_brkm(TFAIL, NULL, " where clone, unshare, or fork specifies"
>> -			 " unshare method.");
>> -	}
>> +	tst_res(TINFO, "mesgq namespaces test: %s", str_op);
>>   
>> -	/* Using PIPE's to sync between container and Parent */
>> -	if (pipe(p1) == -1) {
>> -		perror("pipe");
>> -		exit(EXIT_FAILURE);
>> -	}
>> -	if (pipe(p2) == -1) {
>> -		perror("pipe");
>> -		exit(EXIT_FAILURE);
>> -	}
>> +	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
>>   
>> -	tsttype = NONESTR;
>> +	TST_CHECKPOINT_WAIT(0);
> I guess that we can make even get rid of the checkpoints at this point
> and do just tst_reap_children() here instead.
Yes, it was garbage code I let it there without reason. I usually get 
rid of tst_reap_children() because it's already called by default
>> +}
>>   
>> -	if (strcmp(argv[1], "clone") == 0) {
>> -		use_clone = T_CLONE;
>> -		tsttype = CLONESTR;
>> -	} else if (strcmp(argv[1], "unshare") == 0) {
>> -		use_clone = T_UNSHARE;
>> -		tsttype = UNSHARESTR;
>> -	}
>> +static void setup(void)
>> +{
>> +	use_clone = get_clone_unshare_enum(str_op);
>>   
>> -	id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
>> -	if (id == -1) {
>> -		perror("msgget");
>> -		/* Retry without attempting to create the MQ */
>> -		id = msgget(KEY_VAL, 0);
>> -		if (id == -1)
>> -			perror("msgget failure"), exit(1);
>> -	}
>> +	if (use_clone != T_NONE)
>> +		check_newipc();
>>   
>> -	msg.mtype = 5;
>> -	strcpy(msg.mtext, "Message of type 5!");
>> -	n = msgsnd(id, &msg, strlen(msg.mtext), 0);
>> -	if (n == -1)
>> -		perror("msgsnd"), tst_exit();
>> -
>> -	tst_resm(TINFO, "mesgq namespaces test : %s", tsttype);
>> -	/* fire off the test */
>> -	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
>> -	if (ret < 0) {
>> -		tst_brkm(TFAIL, NULL, "%s failed", tsttype);
>> +	ipc_id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
>> +	if (ipc_id < 0) {
>> +		tst_res(TINFO, "Message already exists");
>> +		ipc_id = SAFE_MSGGET(KEY_VAL, 0);
>>   	}
> I think that it's outright wrong to reuse a queue that does already
> exist, we hardcode a key in the test which means that if we are unlucky
> enough we will attempt to use a queue that is used by a different
> processes. It would make more sense to exit the test loudly with an
> error instead and let the user deal with the situation.
>
> And technically it would be best to call the msgget() with IPC_PRIVATE
> and then get the key by msgctl() IPC_STAT.
According with documentation and examples, msgget() is mostly used with 
IPC_CREAT . What's the advantage of using IPC_PRIVATE in this case?
>> +}
>>   
>> -	close(p1[0]);
>> -	close(p2[1]);
>> -	write(p1[1], "go", 3);
>> -
>> -	read(p2[0], buf, 7);
>> -	if (strcmp(buf, "exists") == 0) {
>> -		if (use_clone == T_NONE)
>> -			tst_resm(TPASS, "Plain cloned process found mesgq "
>> -				 "inside container");
>> -		else
>> -			tst_resm(TFAIL,
>> -				 "%s: Container init process found mesgq",
>> -				 tsttype);
>> -	} else {
>> -		if (use_clone == T_NONE)
>> -			tst_resm(TFAIL,
>> -				 "Plain cloned process didn't find mesgq");
>> -		else
>> -			tst_resm(TPASS, "%s: Container didn't find mesgq",
>> -				 tsttype);
>> +static void cleanup(void)
>> +{
>> +	if (ipc_id != -1) {
>> +		tst_res(TINFO, "Destroy message");
>> +		SAFE_MSGCTL(ipc_id, IPC_RMID, NULL);
>>   	}
>> -
>> -	/* Delete the mesgQ */
>> -	id = msgget(KEY_VAL, 0);
>> -	msgctl(id, IPC_RMID, NULL);
>> -
>> -	tst_exit();
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.needs_checkpoints = 1,
>> +	.options = (struct tst_option[]) {
>> +		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
>> +		{},
>> +	},
>> +};
>> -- 
>> 2.35.1
>>
>>
>> -- 
>> Mailing list info:https://lists.linux.it/listinfo/ltp
--------------sYtbVF2FcDV9hFWHe2eoTCuq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font><br>
    </p>
    <div class="moz-cite-prefix">On 3/10/22 15:16, Cyril Hrubis wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YioISjHts5dstfLM@yuki">
      <pre class="moz-quote-pre" wrap="">Hi!
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 testcases/kernel/containers/sysvipc/common.h  | 157 +++++++++++
 .../kernel/containers/sysvipc/mesgq_nstest.c  | 247 +++++++-----------
 2 files changed, 254 insertions(+), 150 deletions(-)
 create mode 100644 testcases/kernel/containers/sysvipc/common.h

diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
new file mode 100644
index 000000000..1fea6fafa
--- /dev/null
+++ b/testcases/kernel/containers/sysvipc/common.h
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2007
+ *               Rishikesh K Rajak <a class="moz-txt-link-rfc2396E" href="mailto:risrajak@in.ibm.com">&lt;risrajak@in.ibm.com&gt;</a>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ */
+
+#ifndef COMMON_H
+#define COMMON_H
+
+#include &lt;stdlib.h&gt;
+#include &quot;tst_test.h&quot;
+#include &quot;lapi/syscalls.h&quot;
+#include &quot;lapi/namespaces_constants.h&quot;
+
+enum {
+	T_CLONE,
+	T_UNSHARE,
+	T_NONE,
+};
+
+static int dummy_child(void *v)
+{
+	(void)v;
+	return 0;
+}
+
+static void check_newipc(void)
+{
+	int pid, status;
+
+	if (tst_kvercmp(2, 6, 19) &lt; 0)
+		tst_brk(TCONF, &quot;CLONE_NEWIPC not supported&quot;);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
2.6.19 was released in 2006 it should be safe enough to drop this check
now

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child, NULL);
+	if (pid &lt; 0)
+		tst_brk(TCONF | TERRNO, &quot;CLONE_NEWIPC not supported&quot;);
+
+	SAFE_WAITPID(pid, &amp;status, 0);
+}
+
+static inline int get_clone_unshare_enum(const char* str_op)
+{
+	int use_clone;
+
+	if (strcmp(str_op, &quot;clone&quot;) &amp;&amp;
+		strcmp(str_op, &quot;unshare&quot;) &amp;&amp;
+		strcmp(str_op, &quot;none&quot;))
+		tst_brk(TBROK, &quot;Test execution mode &lt;clone|unshare|none&gt;&quot;);
+
+	if (!strcmp(str_op, &quot;clone&quot;))
+		use_clone = T_CLONE;
+	else if (!strcmp(str_op, &quot;unshare&quot;))
+		use_clone = T_UNSHARE;
+	else
+		use_clone = T_NONE;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why do we have to parse the string twice?

Why not just:

	if (!strcmp(...)
		...
	else if (!strcmp(...))
		...
	else if (!strcmp(...))
		...
	else
		tst_brk(TBROK, &quot;Invalid op '%s'&quot;, str_op);


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	return use_clone;
+}
+
+static int clone_test(unsigned long clone_flags, int (*fn1)(void *arg),
+		      void *arg1)
+{
+	int ret;
+
+	ret = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
+
+	if (ret != -1) {
+		/* no errors: we'll get the PID id that means success */
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int unshare_test(unsigned long clone_flags, int (*fn1)(void *arg),
+			void *arg1)
+{
+	int pid, ret = 0;
+	int retpipe[2];
+	char buf[2];
+
+	SAFE_PIPE(retpipe);
+
+	pid = fork();
+	if (pid &lt; 0) {
+		SAFE_CLOSE(retpipe[0]);
+		SAFE_CLOSE(retpipe[1]);
+		tst_brk(TBROK, &quot;fork&quot;);
+	}
+
+	if (!pid) {
+		SAFE_CLOSE(retpipe[0]);
+
+		ret = tst_syscall(SYS_unshare, clone_flags);
+		if (ret == -1) {
+			SAFE_WRITE(1, retpipe[1], &quot;0&quot;, 2);
+			SAFE_CLOSE(retpipe[1]);
+			exit(1);
+		} else {
+			SAFE_WRITE(1, retpipe[1], &quot;1&quot;, 2);
+		}
+
+		SAFE_CLOSE(retpipe[1]);
+
+		ret = fn1(arg1);
+		exit(ret);
+	}
+
+	SAFE_CLOSE(retpipe[1]);
+	SAFE_READ(1, retpipe[0], &amp;buf, 2);
+	SAFE_CLOSE(retpipe[0]);
+
+	if (*buf == '0')
+		return -1;
+
+	return ret;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Can we please clean up this mess as well? We can easily use
SAFE_MACROS() in the new library and we do not need to propagate errors
via pipes anymore. So this should really be just:

static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg),
                        void *arg1)
{
	int pid;

	pid = SAFE_FORK();

	if (!pid) {
		int ret;

		SAFE_UNSHARE(clone_flags);

		ret = fn1(arg);
		exit(ret);
	}
}

And once all tests are converted we can even drop some more of the code
since the fn1() can be declared to return void as well.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+}
+
+static int plain_test(int (*fn1)(void *arg), void *arg1)
+{
+	int ret = 0, pid;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(fn1(arg1));
+
+	return ret;
+}
+
+static void clone_unshare_test(int use_clone, unsigned long clone_flags,
+			       int (*fn1)(void *arg), void *arg1)
+{
+	int ret = 0;
+
+	switch (use_clone) {
+	case T_NONE:
+		ret = plain_test(fn1, arg1);
+		break;
+	case T_CLONE:
+		ret = clone_test(clone_flags, fn1, arg1);
+		break;
+	case T_UNSHARE:
+		ret = unshare_test(clone_flags, fn1, arg1);
+		break;
+	default:
+		ret = -1;
+		tst_brk(TBROK, &quot;%s: bad use_clone option: %d&quot;, __FUNCTION__,
+			use_clone);
+		break;
+	}
+
+	if (ret == -1)
+		tst_brk(TBROK, &quot;child2 clone failed&quot;);
+}
+
+#endif
diff --git a/testcases/kernel/containers/sysvipc/mesgq_nstest.c b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
index dbf311dc8..bb58b7211 100644
--- a/testcases/kernel/containers/sysvipc/mesgq_nstest.c
+++ b/testcases/kernel/containers/sysvipc/mesgq_nstest.c
@@ -1,175 +1,122 @@
-/* *************************************************************************
-* Copyright (c) International Business Machines Corp., 2009
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
-* the GNU General Public License for more details.
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-*
-* Author: Veerendra C <a class="moz-txt-link-rfc2396E" href="mailto:vechandr@in.ibm.com">&lt;vechandr@in.ibm.com&gt;</a>
-*
-* In Parent Process , create mesgq with key 154326L
-* Now create container by passing 1 of the flag values..
-*	Flag = clone, clone(CLONE_NEWIPC), or unshare(CLONE_NEWIPC)
-* In cloned process, try to access the created mesgq
-* Test PASS: If the mesgq is readable when flag is None.
-* Test FAIL: If the mesgq is readable when flag is Unshare or Clone.
-***************************************************************************/
-
-#define _GNU_SOURCE 1
-#include &lt;stdio.h&gt;
-#include &lt;stdlib.h&gt;
-#include &lt;unistd.h&gt;
-#include &lt;string.h&gt;
-#include &lt;sys/ipc.h&gt;
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2009
+ *				Veerendra C <a class="moz-txt-link-rfc2396E" href="mailto:vechandr@in.ibm.com">&lt;vechandr@in.ibm.com&gt;</a>
+ * Copyright (C) 2022 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test SysV IPC message passing through different namespaces.
+ *
+ * [Algorithm]
+ *
+ * In parent process create a new mesgq with a specific key.
+ * In cloned process try to access the created mesgq.
+ *
+ * Test will PASS if the mesgq is readable when flag is None.
+ * Test will FAIL if the mesgq is readable when flag is Unshare or Clone or
+ * the message received is wrong.
+ */
+
+#define _GNU_SOURCE
+
+#include &lt;sys/wait.h&gt;
 #include &lt;sys/msg.h&gt;
-#include &lt;libclone.h&gt;
-#include &quot;test.h&quot;
-#include &quot;ipcns_helper.h&quot;
-
-#define KEY_VAL		154326L
-#define UNSHARESTR	&quot;unshare&quot;
-#define CLONESTR	&quot;clone&quot;
-#define NONESTR		&quot;none&quot;
-
-char *TCID = &quot;mesgq_nstest&quot;;
-int TST_TOTAL = 1;
-int p1[2];
-int p2[2];
-struct msg_buf {
-	long int mtype;		/* type of received/sent message */
-	char mtext[80];		/* text of the message */
+#include &lt;sys/types.h&gt;
+#include &quot;tst_safe_sysv_ipc.h&quot;
+#include &quot;tst_test.h&quot;
+#include &quot;common.h&quot;
+
+#define KEY_VAL 154326L
+#define MSG_TYPE 5
+#define MSG_TEXT &quot;My message!&quot;
+
+static char *str_op = &quot;clone&quot;;
+static int use_clone;
+static int ipc_id = -1;
+
+static struct msg_buf {
+	long mtype;
+	char mtext[80];
 } msg;
 
-void mesgq_read(int id)
+static int check_mesgq(LTP_ATTRIBUTE_UNUSED void *vtest)
 {
-	int READMAX = 80;
-	int n;
-	/* read msg type 5 on the Q; msgtype, flags are last 2 params.. */
+	int id, n;
 
-	n = msgrcv(id, &amp;msg, READMAX, 5, 0);
-	if (n == -1)
-		perror(&quot;msgrcv&quot;), tst_exit();
-
-	tst_resm(TINFO, &quot;Mesg read of %d bytes; Type %ld: Msg: %.*s&quot;,
-		 n, msg.mtype, n, msg.mtext);
-}
+	id = msgget(KEY_VAL, 0);
 
-int check_mesgq(void *vtest)
-{
-	char buf[3];
-	int id;
+	if (id &lt; 0) {
+		if (use_clone == T_NONE)
+			tst_res(TFAIL, &quot;Plain cloned process didn't find mesgq&quot;);
+		else
+			tst_res(TPASS, &quot;%s: container didn't find mesgq&quot;, str_op);
+	} else {
+		if (use_clone == T_NONE)
+			tst_res(TPASS, &quot;Plain cloned process found mesgq inside container&quot;);
+		else
+			tst_res(TFAIL, &quot;%s: container init process found mesgq&quot;, str_op);
 
-	(void) vtest;
+		n = SAFE_MSGRCV(id, &amp;msg, sizeof(msg.mtext), MSG_TYPE, 0);
 
-	close(p1[1]);
-	close(p2[0]);
+		tst_res(TINFO, &quot;Mesg read of %d bytes, Type %ld, Msg: %s&quot;, n, msg.mtype, msg.mtext);
 
-	read(p1[0], buf, 3);
-	id = msgget(KEY_VAL, 0);
-	if (id == -1)
-		write(p2[1], &quot;notfnd&quot;, 7);
-	else {
-		write(p2[1], &quot;exists&quot;, 7);
-		mesgq_read(id);
+		if (strcmp(msg.mtext, MSG_TEXT))
+			tst_res(TFAIL, &quot;Received the wrong text message&quot;);
 	}
-	tst_exit();
-}
 
-static void setup(void)
-{
-	tst_require_root();
-	check_newipc();
+	TST_CHECKPOINT_WAKE(0);
+
+	return 0;
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int ret, use_clone = T_NONE, id, n;
-	char *tsttype = NONESTR;
-	char buf[7];
+	msg.mtype = MSG_TYPE;
+	strcpy(msg.mtext, &quot;My message!&quot;);
 
-	setup();
+	SAFE_MSGSND(ipc_id, &amp;msg, strlen(msg.mtext), 0);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
With large enough -i this will block sooner or late in the case of clone
or unshare because nobody reads the messages in this case. I guess that
the easiest solution would be:

	if (use_clone == T_NONE)
		SAFE_MSGSND(...);

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-	if (argc != 2) {
-		tst_resm(TFAIL, &quot;Usage: %s &lt;clone|unshare|none&gt;&quot;, argv[0]);
-		tst_brkm(TFAIL, NULL, &quot; where clone, unshare, or fork specifies&quot;
-			 &quot; unshare method.&quot;);
-	}
+	tst_res(TINFO, &quot;mesgq namespaces test: %s&quot;, str_op);
 
-	/* Using PIPE's to sync between container and Parent */
-	if (pipe(p1) == -1) {
-		perror(&quot;pipe&quot;);
-		exit(EXIT_FAILURE);
-	}
-	if (pipe(p2) == -1) {
-		perror(&quot;pipe&quot;);
-		exit(EXIT_FAILURE);
-	}
+	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
 
-	tsttype = NONESTR;
+	TST_CHECKPOINT_WAIT(0);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I guess that we can make even get rid of the checkpoints at this point
and do just tst_reap_children() here instead.
</pre>
    </blockquote>
    Yes, it was garbage code I let it there without reason. I usually
    get rid of tst_reap_children() because it's already called by
    default
    <blockquote type="cite" cite="mid:YioISjHts5dstfLM@yuki">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+}
 
-	if (strcmp(argv[1], &quot;clone&quot;) == 0) {
-		use_clone = T_CLONE;
-		tsttype = CLONESTR;
-	} else if (strcmp(argv[1], &quot;unshare&quot;) == 0) {
-		use_clone = T_UNSHARE;
-		tsttype = UNSHARESTR;
-	}
+static void setup(void)
+{
+	use_clone = get_clone_unshare_enum(str_op);
 
-	id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
-	if (id == -1) {
-		perror(&quot;msgget&quot;);
-		/* Retry without attempting to create the MQ */
-		id = msgget(KEY_VAL, 0);
-		if (id == -1)
-			perror(&quot;msgget failure&quot;), exit(1);
-	}
+	if (use_clone != T_NONE)
+		check_newipc();
 
-	msg.mtype = 5;
-	strcpy(msg.mtext, &quot;Message of type 5!&quot;);
-	n = msgsnd(id, &amp;msg, strlen(msg.mtext), 0);
-	if (n == -1)
-		perror(&quot;msgsnd&quot;), tst_exit();
-
-	tst_resm(TINFO, &quot;mesgq namespaces test : %s&quot;, tsttype);
-	/* fire off the test */
-	ret = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mesgq, NULL);
-	if (ret &lt; 0) {
-		tst_brkm(TFAIL, NULL, &quot;%s failed&quot;, tsttype);
+	ipc_id = msgget(KEY_VAL, IPC_CREAT | IPC_EXCL | 0600);
+	if (ipc_id &lt; 0) {
+		tst_res(TINFO, &quot;Message already exists&quot;);
+		ipc_id = SAFE_MSGGET(KEY_VAL, 0);
 	}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think that it's outright wrong to reuse a queue that does already
exist, we hardcode a key in the test which means that if we are unlucky
enough we will attempt to use a queue that is used by a different
processes. It would make more sense to exit the test loudly with an
error instead and let the user deal with the situation.

And technically it would be best to call the msgget() with IPC_PRIVATE
and then get the key by msgctl() IPC_STAT.
</pre>
    </blockquote>
    According with documentation and examples, msgget() is mostly used
    with IPC_CREAT . What's the advantage of using IPC_PRIVATE in this
    case?<br>
    <blockquote type="cite" cite="mid:YioISjHts5dstfLM@yuki">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+}
 
-	close(p1[0]);
-	close(p2[1]);
-	write(p1[1], &quot;go&quot;, 3);
-
-	read(p2[0], buf, 7);
-	if (strcmp(buf, &quot;exists&quot;) == 0) {
-		if (use_clone == T_NONE)
-			tst_resm(TPASS, &quot;Plain cloned process found mesgq &quot;
-				 &quot;inside container&quot;);
-		else
-			tst_resm(TFAIL,
-				 &quot;%s: Container init process found mesgq&quot;,
-				 tsttype);
-	} else {
-		if (use_clone == T_NONE)
-			tst_resm(TFAIL,
-				 &quot;Plain cloned process didn't find mesgq&quot;);
-		else
-			tst_resm(TPASS, &quot;%s: Container didn't find mesgq&quot;,
-				 tsttype);
+static void cleanup(void)
+{
+	if (ipc_id != -1) {
+		tst_res(TINFO, &quot;Destroy message&quot;);
+		SAFE_MSGCTL(ipc_id, IPC_RMID, NULL);
 	}
-
-	/* Delete the mesgQ */
-	id = msgget(KEY_VAL, 0);
-	msgctl(id, IPC_RMID, NULL);
-
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.options = (struct tst_option[]) {
+		{ &quot;m:&quot;, &amp;str_op, &quot;Test execution mode &lt;clone|unshare|none&gt;&quot; },
+		{},
+	},
+};
-- 
2.35.1


-- 
Mailing list info: <a class="moz-txt-link-freetext" href="https://lists.linux.it/listinfo/ltp">https://lists.linux.it/listinfo/ltp</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------sYtbVF2FcDV9hFWHe2eoTCuq--


--===============0157648431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0157648431==--

