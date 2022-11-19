Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FE2C4332F
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 13:06:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8BF13CCD71
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 14:06:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00B273C2B4D
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 14:06:18 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E6C141400975
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 14:06:12 +0100 (CET)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AJD0NHG032600; Sat, 19 Nov 2022 05:06:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=DEOab5Gthogq8Ewdn7erQJzGDb/opKRnZwkXdMoT5Ow=;
 b=Y2sjhpaDCuPluqx2ce+K5j4ZmTicZ7xCQ/wXRLI7OhbPGVZyIo7iP+pCeksyFIlDHSoS
 m9qSGZXz8qWNQpUz66TFH1jVzURVw8C0FqYLsAYnXOUSneL2U1Dm+Um9KpXZd8MrXR2F
 SvfAT+0I7bwW5RIjzEYuqRuedBs4B6jukZdKTw857xPvDs+HSk1cAEhlW1ktk+GoItlK
 i240GkuhRSD8YQNHR7kuncEzFelNJfYjWjXNfXizeABy5PU8VBPMhOm5KUoofM15fNA2
 Z+cPgD0BJerAV7/nMLoPAtgzGHze4ncJmpS7oXQDGLduXLUX7YN9lFjnMBzDbhqWRDAd iw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxyhq806w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Nov 2022 05:06:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A55LY98Srl2cMic1nDk9Jh6jcJuIgbwktJ8FGR0cRk84ykU6bRZ54fLhM3Tq+Ql85CwVMBUEwXbOMK6uZvrLvyOMUUpL0DJIjVof06J/ZPd4Mty04x6JqI6Aol/xxmwv/nvqS0l9fjxsasZwuTXm8VWBn0aT0fx+Du47OpEjOTBYYYB4w5L94dF91sV1d8pMscbM5fbz6gLcIS687mtTWqocWK99l+dEw3qIdn0yJpjV9PsOj87QnIrDrAhDuuzCKM+hbVVi7PaYq1g+bY4sZpxXbOGEtp2t4DSC/ep0kq3f4/4xBD4jUVyy75O5h9Ojags2zWxDyXHlH8ioGNqOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEOab5Gthogq8Ewdn7erQJzGDb/opKRnZwkXdMoT5Ow=;
 b=cJn6aUEC3ck4PVaO5rxcAsSmHBWxpvYGpOUXso0OlOmhEuem3z6f2j8ECp41/nLzLczquMvmkoy5ZObKP9gsjDgeTpfgJ+MXta/KR92bETdPQMOy87LckCn4tonlVdfRcEEs0RhcbiQSKiKlg/ZIQgd8nwabhfgfxut+VTxQPG5Fd4ywkGEz0LuTz4QIGFmCn5L/06+HUfKKDeXPSiZbG3CZ+Erly7s1SF7HHMwwyj6jbeNd3rxSSbahR3iaiYVDzMuvDxBV6M8GPrQOySmzBAA6a7y6uOaVYEXSlK1Dxh8f348yE3CGRft3SF5SkBIJMDoVyshzc5Kp6uoc8+6IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 13:06:05 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 13:06:05 +0000
Message-ID: <bad83f46-248e-ca40-b015-016c1210338c@windriver.com>
Date: Sat, 19 Nov 2022 21:05:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221116102334.741189-1-zhe.he@windriver.com>
 <Y3eJk1ugDSv+TC70@yuki>
Content-Language: en-US
From: He Zhe <zhe.he@windriver.com>
In-Reply-To: <Y3eJk1ugDSv+TC70@yuki>
X-ClientProxiedBy: SL2P216CA0167.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::16) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da9c524-ebe9-445d-d8f7-08daca2ed065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJoV+DSMwKLBo019tjlXkTtJdAVZv1cIKSS1ti+NdqmnDpBt0rw+xAGepnxw/oCrQhw4/LspaVyMPcQv+k5we1wekNVyXMbP2yGhPi7u4rnbtv2EymL0yOHV4EQcmOl+gIId4XK5m9lM5iBHgfAMXTsLsM120sG6Zolxv3yT8dhWTwIjcHCdKl1A4olIL9T7M87rQolPNqD3OSbzEY1vB0oxDhNQNdjSiKQTW6Qx3XgdwwFb7c4YwUOvM+35q9BAKSs8IaFKRfw19ijoU2agpO1fRUFwZFKwgds9eWVcTAMerLhnI6CLajfZmU5Qbbf1gsFw8fbovG17DcX+n3xYxwcNQWJUe5XceuteJO9sdNv9EX+Po+B8hXymfNL7Irzn99X5oiaGOjlSoWxLKivZUpNv3QLunE5B+5g4Us65/NThay2UXuHMRZ/2FfUTNy1Dtkwe96YvpWMIdqSMOHy6a8pebr5NnhKLPpAWZ0qZsSZsi8MetfIZwrAeNRCMw5T5rUnQ1vJzjiV6imFPYgZa9O+4G1QcWIJSR8S7GllY6uaOcxEn+1InNBtugy78JFgKteSW2kX4bul1fevgS+BIjIGNddiQO2bw1EUlxleqH9hA2oKAV0kZ9LsKSBxAfapyZuvecuttOSj41pcbwHbwS8jBH3wZa3jjf7lf/VJg2ZbkWUXqpM4UHbRcchRW3lcEEXiSqLfbs94hx1xAHuCuXUxzTHy9f2HPnJ5AOH79iOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39840400004)(346002)(366004)(136003)(451199015)(2906002)(83380400001)(6666004)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(26005)(6506007)(6512007)(5660300002)(186003)(316002)(53546011)(36756003)(31696002)(8936002)(86362001)(6916009)(2616005)(6486002)(478600001)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjV1bHJSbU1JSzc3cmFaOElSclAzMFVxZ1Vrb1BhRVdhS0V4WjI1TUZWU2dw?=
 =?utf-8?B?c1hqZmFkM3dIdDRwOWliaU1UZU9DZHk0V1lrTGo4ZWpCcy9QSXYvQWVXZG5F?=
 =?utf-8?B?dHRPUW05cWJIbUQvWmhQNmF2YjZGRksxRDdsZkJlVHZ3ZjVIWC91QlVrN0gy?=
 =?utf-8?B?cmxBSTdJaFhQQUQvSDNBdzUrNDdhdk44bGwyWnBkWmhKTjBMdkpEUC95VGZv?=
 =?utf-8?B?SXpuQlNRbHphaHl4N2cwOFU5R2x3bURjZFAwU1dkRFJXWEJkeUQrSGxOdUFG?=
 =?utf-8?B?WjM3c3h4dlJZSHlHYWNCT3VHUGZrZnp6RlJBeFJaVmpDY0dEeEd2OWFGSmlF?=
 =?utf-8?B?TGc3WHpMdDM5VWxrckRRVzIza1NOUjd2Mms1U0ZVZ1dDSFZNemJKajdidDY2?=
 =?utf-8?B?bUl5VEJCUXpDcWZkbEs3eE4vQjEzZ3hxV1pNVThabzdSb0hZcGh1SkdYcWd0?=
 =?utf-8?B?V1hlMWJXa0t3Q1lWZmNnOVkzSmRTZDNlTkNCMTRRVGZqS2NFWDBsWU1vYXNs?=
 =?utf-8?B?Tk1NVG9kVDVRbjZmWkZ6Z0N2dlRLZWxxMDNiQnFJek8ycVFDdVY1YmNnZzZF?=
 =?utf-8?B?VHZnMlZZeFkzRXFmMm11REx6YnRaM0E2RTA2SXpUakVOWU82ektBdWJyVm9X?=
 =?utf-8?B?amdUNHBEajFVWXFDdkZvMlI1Ui9FclNSd1BHbWFxTWJJUzV4SWwxaGpWU01I?=
 =?utf-8?B?aWMxRUlDOTVJMzhuZTlMb1o3dkhKUDA2UWcweE5XdmRHSUs3bDBnWjljQkhN?=
 =?utf-8?B?WStOVExpWHNEdVJRd01IRXpsMVROd1FaRS9IWHdVTGlEK1pzajZjcWI0S2k3?=
 =?utf-8?B?dXl2aDgySldkV3h0NUZnTDFUU0ZtOGdMZTV5ZUgwN0Jka2xiWk1DdFR0cnVM?=
 =?utf-8?B?UWU1RGFWWFJyTlJVZ1VwOGgxNDJ3MllnV2MrT1hxZlpIUjFXaVViV3RmNnA3?=
 =?utf-8?B?T0liMFI4ektoK2F0cEsxR2kwZjZqanF5NGZ5NFp4ZlllaFRjUXNFeFZDaHdv?=
 =?utf-8?B?dE1TWG1zU0ZqQjdMNnpmZ2lqZFZOZU9oY2s5NnFyZTYvN3FuQ2NYeFJtNWZs?=
 =?utf-8?B?OTVESHBYWW9rbXN1OUZnZGNQelpKT1V2NVFJMlZXS2xsaUMvaUVqY3RIVWVW?=
 =?utf-8?B?QnpZY0lrUENwRm9IL055bEtmNTh1TU5GMnJsTFp2L0FhSnprL1F0UmFQVEs1?=
 =?utf-8?B?OTN4aEFiVG1GdUcwQytPQW1Ob0p1dE1Na1NPUkJEb3dONko2SWRwUjB1MkJr?=
 =?utf-8?B?c0dBZ09mSVJuVEZsdXpnZkJmVHdrTXdhMDJwSXZNT0lPNys1THhXaFYyZTJy?=
 =?utf-8?B?SVQ5Q0ZrTU4wOUhDU2FtNHNsWDNBTDFzTkZXV3plUzJMelZMa2NtZGhoYzNv?=
 =?utf-8?B?bUN1M2RIaG0rQmFlMWZvUjZvVXRTL2xUempYa3NIZ01ZVHk3bm03TDJWYkJF?=
 =?utf-8?B?RUlLZmdNWWhsOW5nTjZiTjYvNm5PQU9OVTRDOFpWeFQ3K0JqRDlLd0NxQS9j?=
 =?utf-8?B?Zkk1SWFsc28vWWFlMmRBaEg3cFRBTGlUUVZ3dFdjMFArL3pUQm0vT2x6YmhI?=
 =?utf-8?B?a05nKzFyM01WSDBRVEwrYWJqQVNaRUNRQlBTQ0NGd0p0aHVNMjFheFVxRTd5?=
 =?utf-8?B?UmYvSDJQNTlwSldsUnV0aHVCbkF4bURUM2NmTFVLZGIxN0xnc29Db2g2Z0Z0?=
 =?utf-8?B?S2g1Sm03Si8zakxFaHFudXFiWElSakdEdzFMOGZCVjlBNWxZV3ArU3RseEVW?=
 =?utf-8?B?Z0FMaUtQUmcrTFBXTTB3RGN1bjBxQmZZMW1DakhTZm9Yd0xhbmZLWFhROFFI?=
 =?utf-8?B?VmE3YnR5MkNreHNJNHA3RVhIMENZbmk0d1dJVTRCdmg1Z29Kb3Z5cGwwMFVI?=
 =?utf-8?B?em5hdnRhTHBHZld2Q0xXQWRFMlA5NERtZFdXQnpvSHh5SERWSmhjeldsbjZt?=
 =?utf-8?B?clZMdTlrNHlBZEl0NXd4bU55V01iRlFaamg2dFF4SGFMN2xEWFkyTEM0OVhS?=
 =?utf-8?B?U0dJcURQcHU0YkhXTFAxTGNVMnNjK2xNZ0RIMkJ6bmlaQkhwdHpkU3haU2d0?=
 =?utf-8?B?djlEMWVudExVTTlWRXFKMEt1K3VGYStDM0QyRGoxUWt4RmFjbnBmNEdQUnlK?=
 =?utf-8?Q?lbt5y26aAId4TO7qjRI5FjABH?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da9c524-ebe9-445d-d8f7-08daca2ed065
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 13:06:05.5924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQzABxjOg6BcQHwH0n7Fd+eSATo+HXixjhTLl5zFVpEwMqAQcZJn3K24y9WZka1vdNUs376zlGXEjB1yu1+r3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-Proofpoint-ORIG-GUID: r7XFXVogzSIsgFqiPdyOG226s9vqNRT_
X-Proofpoint-GUID: r7XFXVogzSIsgFqiPdyOG226s9vqNRT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211190098
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl04: Fix false positive report when
 SECCOMP_MODE_FILTER is not supported
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 11/18/22 21:33, Cyril Hrubis wrote:
> Hi!
> I did reply to the github issue already with:

Thanks for taking care of this. I'll send v2.

Zhe

>
> Looking at the patch, maybe it would be cleaner if we did a test if
> SECCOMP_MODE_FILTER is supported in the test setup and set up a global
> variable based on that, something as:
>
> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> index b9f4c2a10..d4e44cb1b 100644
> --- a/testcases/kernel/syscalls/prctl/prctl04.c
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -61,6 +61,8 @@ static const struct sock_fprog  strict = {
>         .filter = (struct sock_filter *)strict_filter
>  };
>
> +static int mode_filter_supported;
> +
>  static void check_strict_mode(int);
>  static void check_filter_mode(int);
>
> @@ -219,6 +221,16 @@ static void setup(void)
>         TEST(prctl(PR_GET_SECCOMP));
>         if (TST_RET == 0) {
>                 tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
> +
> +               TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
> +
> +               if (TST_ERR == EFAULT) {
> +                       mode_filter_supported = 1;
> +                       tst_res(TINFO, "kernel support SECCOMP_MODE_FILTER");
> +                       return;
> +               }
> +
> +               tst_res(TINFO, "kernel doesn't support SECCOMP_MODE_FILTER");
>                 return;
>         }
>
> Then we can simply use the mode_filter_supported either not to print the
> failure or even to skip the test to begin with.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
