Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096CCC433F5
	for <ltp@archiver.kernel.org>; Mon,  4 Apr 2022 10:52:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCC9E3CA3F3
	for <ltp@archiver.kernel.org>; Mon,  4 Apr 2022 12:52:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FBB43C8941
 for <ltp@lists.linux.it>; Mon,  4 Apr 2022 12:52:09 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBDD014004E8
 for <ltp@lists.linux.it>; Mon,  4 Apr 2022 12:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1649069528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S90lsY1uo7UCui5f3yrx7bPjgtBYx/7msqGf/ravxjo=;
 b=hWS+MUlQ7kneFdz5W6qXIEmr7UtNX1IAB13N8omedrPBSDH4dECbfsx0DnBF0hSS+EOZ5C
 xthYhGarTRjOqDzeGvPH61Zn01ma7N4Zl19LnC+cc3D+KXmW4wKloLSDBa3H7mpNE5Glaf
 pBBkLjUa8kYs0A6MpzMY2ZguNh5TCk4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-G1xpP7dcOUG1RbYcas5opg-1; Mon, 04 Apr 2022 12:52:07 +0200
X-MC-Unique: G1xpP7dcOUG1RbYcas5opg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4A5g/4cwqXspzGitgDYpLmqKZKOvzP0Mi6Vy2oCkSGEFUGSwULw8TTC7WkSHk9gINiGV3I/uGD5HzWOHUnRlbc6FxmwP+fcUdoOuUxlXNpAdiCjbaZ+5nGCmC3rAFZSIoztZdDoI90PIHDfBVMjyBVBb2bNcMRQK/gdQpzoyjFDUcpiughZYT33FSgtMXo00zfyzf/tURw9bnvqsXJUfdRELQjMd1Mb8INXDGweJsslYyIzW3Tw1qPYnYl7OF7Q4lLMcuVdxVdA0k/UOcFyD+SW7DsJT2QLPb6umHyAc+ef9xlZ6WFfdVDu3fuFwats2lsb05XlZAoaUCQG7FKfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S90lsY1uo7UCui5f3yrx7bPjgtBYx/7msqGf/ravxjo=;
 b=hUzEs+Fju7JRQyjdNdGo5ELqN5pBDYBYlvgqbrIGHxwNXffWGgLm5ATcnCfIJpY69SN+aBWQnYWcVaqakjjdLYUFDKErrah8fKpxEdOjbCZW/IseLACCExAPFCOCuuQDATOdtYaNClKI/cJmnxClOqn3Kt+xg+xQAE7kT3GMi42B1a7A7ISJijusCz3qsETk89+SxE7d9tm1SYTZRVFd+YnqI8FgUQ/lUVXGkOCnisH9XFU3c7MtkwQdl5YPd1zgSwV7Qfg8+vBHhDMJHHsl/nAYpXR2FVNgX9sGncDMokgiWc6yGSchtKu8XnHhhWC7mztGW7I4w09S/1hGDNhhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB6PR0401MB2328.eurprd04.prod.outlook.com (2603:10a6:4:46::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:52:05 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::1504:3316:3ce:7b0f%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 10:52:04 +0000
Message-ID: <348d5c14-97e2-7c23-9666-92ba77354417@suse.com>
Date: Mon, 4 Apr 2022 12:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220401050804.1286-1-andrea.cervesato@suse.de>
 <YkrJfb0vZq6WSZmX@pevik>
In-Reply-To: <YkrJfb0vZq6WSZmX@pevik>
X-ClientProxiedBy: AS9PR06CA0758.eurprd06.prod.outlook.com
 (2603:10a6:20b:484::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0090431a-93f8-418d-0f3e-08da16292800
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2328:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB23282CF4CD57FF67F792E9B4F8E59@DB6PR0401MB2328.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXFNkoUYGwHwRgcdLiPdw5cAGlCyGbmyBfc2CckfhU0IXqRiULM3/O53QETFZ3t/zT9DgXU37xna7mL92XwQ78TYjmpkAHilVo21tbEvG/NgFMUiRkuWFwUqaQh4qdEtt+HnaQLNyV5zt30m+O6uvD1T/G8uoPs9u9h1ZVAbDOR4zxxNeri2wd+EQ+mXiihShV9Y/x5QYZ2AQXLtL1li3quSQH9PvSCPDvl6BiCf49XX8h8slDEvB/J/xIqt3mNE+Dka0KNULS25QmBwjtKK0AGAyACrVVuGTldrP0ULky1dJauNxlCmOQlnso3l0/LuXYUn1TDwQuMVAOzF2BSh1peVq8afjz3V66HuND6ysil3aFAGs8iaKmX86gpIdGPLTr/oHHECaVKjdK8QMa0QXwh/916KDuB0KLvHUyFNa5AFkSDX8TH+aGtra3a/z4ANrns2+EKAdei3gTZ2/d1pA4I1BlfmDCxLDf4DdOFbE4O1Ogcwbsdbkk09E0OUGfDubauSWI21IiHETKPGZhgfpnF0Xa866dzmTDHSx+aMgEJibW5Mo4UreguiuiPOEin4yFttaz0OqIeoY9SSgRVRbq39UrdbA2u7ObEiNX+RiiwzBHHv7oU6IUZjUeKM9ExvBQ5uv/2wOaEpiC5vUqEc7ezYwG+AVzgsIsjl9sIkK8dzEtp4IEGaK5Cdte/vNR/BYfQlo6p5/QnVV8VL8XSwHoc8ZXlyisHnl2xMDKqk4c0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6506007)(83380400001)(186003)(26005)(2616005)(8936002)(33964004)(53546011)(44832011)(86362001)(6512007)(31696002)(2906002)(66556008)(38100700002)(8676002)(4326008)(6486002)(36756003)(66476007)(31686004)(5660300002)(66946007)(316002)(110136005)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDROUmsvZElPejZlTWZILzdiM0FKU2xZaUFyR2pBbVl6a3pZZit3a0daVDVl?=
 =?utf-8?B?ODhPRlFkc3RjSDBtcy9VbkRBZ0MrNHhsU3JEVE43MGl0WGdodU1NUUQ3aDBC?=
 =?utf-8?B?NVFkUXRMOUVydnRudWYzMXlXbmt1ejZ4L0RMeXg3dVY4c25JUGJqbW02RTBa?=
 =?utf-8?B?cHY0NlRud1EyaEJkZGFjem41d1pabXJ6aEtVZTE3QzlKWlVlVnhwTFZmNlVw?=
 =?utf-8?B?Ujd4aytLVjZFOEdzQVFTWWdOMzlzekU3U2NQbXVMVXdKSFkzbFRUaE9SR2py?=
 =?utf-8?B?YUpIY0d4bFByVW9zempaV3pnRmNnWDBaeUFKL0tYclhPcXl5NUgrUTJFcmND?=
 =?utf-8?B?clRxRkJYbkdiZXFpaGJZNzNObVU2NHVac2FuT1NQL2wyL2JVZkxiNzJidHhS?=
 =?utf-8?B?Nk5JcUczU1NUMk1zWE9WVU9JUkhyd1dPY2NaQ21abUZaVVV5aWJFb0J2c2My?=
 =?utf-8?B?aEhBQWhjWGlSWGVZWk83U1ZWRGtCOHJobnNFVzdUVXFmVDlYRjFuM0poRVVi?=
 =?utf-8?B?dmNCNnFLR1JzTFAvQ3FmM01QZGd0RFBuMnAxNkFqQ1VUaXdKck9YTHFHMGN0?=
 =?utf-8?B?L0ZvQnU1SUdWSE1WUTNDQ1pYeXJzbnJua2Q4NXFYb2NwT25xc1FZQW9JTDc0?=
 =?utf-8?B?K2phbVUrZFdRaS9obmJrZnRNb0dqRFJtWkRjN3RCdFlOS2liZ0todXRWZURt?=
 =?utf-8?B?WGdpQzVWdWxpemh6QmcxVyt2cDZIVmxaeVptdnpxK1dDVEw0OVN2MFZlSzFK?=
 =?utf-8?B?cGtBcTJDbUczUlpEaWo1R1hhT2R5WjhNb0ZwaTVYald0ZHI2UXBtejFrSHov?=
 =?utf-8?B?WVFHTFBhNkhrdXNXRjZ3ZjBmdlpkdHZuby91cEhNZEFJNFk4WlJVZFNDaTE2?=
 =?utf-8?B?TFQ3aGdZM0lwTXJwcnE1UlFlaFI4ZHhicWJWaEU0Nit2cHlXZEtya1p4ekdr?=
 =?utf-8?B?Wk1aTTF5U1pRZWhQc0FlbmZ6UTE3U3dhK0pHTHZKVnZvcG82aFN0aVpNYjhC?=
 =?utf-8?B?eDR0NHRncUNORU55ZzFxOUw4cGtVenZpM1RkSG80QUc0U0J0UWsrcXRzSFBs?=
 =?utf-8?B?eGJRS3YxWGlIdHg3S2poYXRlZTNKamN2U2ZtLzZxZklwTzFZRzhGMkVOYVR0?=
 =?utf-8?B?WXZsek5vdFBCenhLMkkrc1pwRHM5M0pLaDBSangycjQwL05nUUVTS3JtNnBr?=
 =?utf-8?B?MnMvRFFaZ2k0TGkzcDhwN1Z2Y1V4aWdXYkcybXpuSmg2RFpheEp4QkRGMjFM?=
 =?utf-8?B?cXJJVHdmTXNzeHFDak03TFpTQXB4MzdKbEJtWUxMcUNyQSt5dVQ0QVZDMmdi?=
 =?utf-8?B?cGpCWkF1R3VRbktLUU5TeFBhSGdGOXZtZXVuM00zOXhHYVRja1BKeElWQXJn?=
 =?utf-8?B?WlNiMVJ0VlhGL3ZqVGxhcGFYUVg3eUxMNm92ZDFMUmZUZndrdGxpeFRVdEVu?=
 =?utf-8?B?K3F2ejFxcTRLTE8xM2t6cStWWm8rOE1DM1NqOHVmRFJoNUtmSVJHNnFEV3cr?=
 =?utf-8?B?WERVcXgzdE13a09zNTBVb3VyNE5uNEV4THppS055eERITVJrMkV3VzVIU3pU?=
 =?utf-8?B?SzVyQjdpbnNBdWl3TzZUcGFSU0tOWGg1SFNXOUk4YjY3eXNURW8wU1FmTnRs?=
 =?utf-8?B?TGFVdTJMWGpjQW4rek50aEFxbndZSE84RHlucWhaRnBHUDZ1WjNMb0tzMzJV?=
 =?utf-8?B?ZngzUlV4a3owVzdzVWo5Z0QvTjNaRUVpSjNBU1lCM2Z4NmNiS0RiVjkzenpB?=
 =?utf-8?B?ZTFuSDZJckxNNEJnQnB0dllxRFN6YU95N292d1htNWM0Q01PNGRDbjlzUU1o?=
 =?utf-8?B?WmdlelRtcjBQVzRFcmhaQW8rZmtBazNXd1hRZjZGME9yeFpFa2o2cG0xQzlx?=
 =?utf-8?B?MCtZOXMrRExPUHJCMjFZalF6RE1CV1ZMcXgxZE5PU3piTWdBY1ZJU0VoV1Vn?=
 =?utf-8?B?bzhTaHIyTUNTcWZhbEN6Z21NaVNBZE1EWWtyWFVveXlHeG1KOHUyeENWYlF2?=
 =?utf-8?B?bzhRZnJ6aTd6T04ra1I2YTBldGwycXUzMWFjcWFVVTRaakxhYm9Oa2sxRkNm?=
 =?utf-8?B?S0k0Rkk2Z0FIVkNMZWJTR1BHcDNjQjFLS3pSNE5uWHViSGYreS9UNXpMSFcz?=
 =?utf-8?B?UnUwd0VFSFJFNkUwQkRSS1hZaWZHeUpueGN0RkNrSVQza0F6c0NmNThqVW0z?=
 =?utf-8?B?b1V4a3ZIRkRUcXhYaFpWY25LRGdhSTErbkZhWjRadFRqdDd3dEovVVo5SDVU?=
 =?utf-8?B?RjBNMnErelJrV1pSdXI4Vm9mQjZhQS9KUjBEZlJGK0RIbzJWU2ZiL1NuVysy?=
 =?utf-8?B?LzlYNWpUNXJkeGpBeVl4dDlVaEozOWVaL2lvRWM1NXRWbVJWdE51bjJOZExL?=
 =?utf-8?Q?dRk7jp7KWO47pCIU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0090431a-93f8-418d-0f3e-08da16292800
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:52:04.8158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMHSYpDYfKXwKz8msTtedDPJUp4ixLEWby9JxM7vGWh9JkX4mrKtnt4Fnbazs6t608/lMYSGObwu2WpfEIcNy/1jgzLByQ/N8AejRS5B9As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2328
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Rewrite userns06.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============0751709270=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0751709270==
Content-Type: multipart/alternative;
 boundary="------------JGb9kfn3d2SmxD4042tkoi0N"
Content-Language: en-US

--------------JGb9kfn3d2SmxD4042tkoi0N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

can TST_TEST_CONF be used even if TST_NO_DEFAULT_MAIN is defined?

Andrea

On 4/4/22 12:33, Petr Vorel wrote:
> Hi Andrea,
>
> BTW it'd help reviewers a bit if you include a changelog.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
> TL;DR: TST_TEST_TCONF() in userns06_capcheck.c
>
>> diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
> ...
>> -/*
>> - * Verify that:
>> +/*\
>> + * [Description]
>> + *
>>    * When a process with non-zero user IDs performs an execve(), the
>>    * process's capability sets are cleared. When a process with zero
>>    * user IDs performs an execve(), the process's capability sets
>>    * are set.
>>    */
> nit: I wonder if we want to have docparse documentation in both userns06.c and
> userns06_capcheck.c, they now look as 2 separate tests. Maybe describe
> everything in userns06.c.
>
>> +#define TST_NO_DEFAULT_MAIN
>> +#include "tst_test.h"
>> +#include "config.h"
>> +
>> +#ifdef HAVE_LIBCAP
> ...
>> +	if (argc < 2)
>> +		tst_brk(TBROK, "userns06_capcheck <privileged|unprivileged>");
>> +
>> +	tst_reinit();
> I'm not sure if tst_reinit() shouldn't be called even before tst_brk(TBROK, ...).
>> +
>> +	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
>> +
>>   	if (strcmp("privileged", argv[1]))
>>   		expected_flag = 0;
> nit: It might help debugging to print argv[1] in TINF0.
>
>>   	caps = cap_get_proc();
>> -	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
>> +
>>   	for (i = 0; i <= last_cap; i++) {
>>   		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
>>   		if (flag_val != expected_flag)
>>   			break;
>> +
>>   		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
>>   		if (flag_val != expected_flag)
>>   			break;
>>   	}
>> -	if (flag_val != expected_flag) {
>> -		printf("unexpected effective/permitted caps at %d\n", i);
>> -		exit(1);
>> -	}
>> +	if (flag_val != expected_flag)
>> +		tst_res(TFAIL, "unexpected effective/permitted caps at %d", i);
> The flags are CAP_EFFECTIVE and CAP_PERMITTED only here, right?
> (i.e. no CAP_INHERITABLE). Not sure how helpful would be to print here which
> flag was the failing one.
>
>> +	else
>> +		tst_res(TPASS, "expected caps at %d", i);
>> +}
>>   #else
>> -	printf("System is missing libcap.\n");
>> -#endif
>> -	tst_exit();
>> +int main(void)
>> +{
>> +	tst_brk(TBROK, "System is missing libcap");
>>   }
> Why don't you also use TST_TEST_TCONF() here?
>> +#endif
> Kind regards,
> Petr
>
--------------JGb9kfn3d2SmxD4042tkoi0N
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">can TST_TEST_CONF be used even if </font>TST_NO_DEFAULT_MAIN
      is defined?<br>
    </p>
    <p>Andrea<br>
    </p>
    <div class="moz-cite-prefix">On 4/4/22 12:33, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YkrJfb0vZq6WSZmX@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

BTW it'd help reviewers a bit if you include a changelog.

Reviewed-by: Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a>
TL;DR: TST_TEST_TCONF() in userns06_capcheck.c

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">...
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-/*
- * Verify that:
+/*\
+ * [Description]
+ *
  * When a process with non-zero user IDs performs an execve(), the
  * process's capability sets are cleared. When a process with zero
  * user IDs performs an execve(), the process's capability sets
  * are set.
  */
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">nit: I wonder if we want to have docparse documentation in both userns06.c and
userns06_capcheck.c, they now look as 2 separate tests. Maybe describe
everything in userns06.c.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#define TST_NO_DEFAULT_MAIN
+#include &quot;tst_test.h&quot;
+#include &quot;config.h&quot;
+
+#ifdef HAVE_LIBCAP
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">...
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	if (argc &lt; 2)
+		tst_brk(TBROK, &quot;userns06_capcheck &lt;privileged|unprivileged&gt;&quot;);
+
+	tst_reinit();
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">I'm not sure if tst_reinit() shouldn't be called even before tst_brk(TBROK, ...).
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+
+	SAFE_FILE_SCANF(&quot;/proc/sys/kernel/cap_last_cap&quot;, &quot;%d&quot;, &amp;last_cap);
+
 	if (strcmp(&quot;privileged&quot;, argv[1]))
 		expected_flag = 0;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">nit: It might help debugging to print argv[1] in TINF0.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 	caps = cap_get_proc();
-	SAFE_FILE_SCANF(NULL, &quot;/proc/sys/kernel/cap_last_cap&quot;, &quot;%d&quot;, &amp;last_cap);
+
 	for (i = 0; i &lt;= last_cap; i++) {
 		cap_get_flag(caps, i, CAP_EFFECTIVE, &amp;flag_val);
 		if (flag_val != expected_flag)
 			break;
+
 		cap_get_flag(caps, i, CAP_PERMITTED, &amp;flag_val);
 		if (flag_val != expected_flag)
 			break;
 	}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-	if (flag_val != expected_flag) {
-		printf(&quot;unexpected effective/permitted caps at %d\n&quot;, i);
-		exit(1);
-	}
+	if (flag_val != expected_flag)
+		tst_res(TFAIL, &quot;unexpected effective/permitted caps at %d&quot;, i);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">The flags are CAP_EFFECTIVE and CAP_PERMITTED only here, right?
(i.e. no CAP_INHERITABLE). Not sure how helpful would be to print here which
flag was the failing one.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+	else
+		tst_res(TPASS, &quot;expected caps at %d&quot;, i);
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> #else
-	printf(&quot;System is missing libcap.\n&quot;);
-#endif
-	tst_exit();
+int main(void)
+{
+	tst_brk(TBROK, &quot;System is missing libcap&quot;);
 }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Why don't you also use TST_TEST_TCONF() here?
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+#endif
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------JGb9kfn3d2SmxD4042tkoi0N--


--===============0751709270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0751709270==--

