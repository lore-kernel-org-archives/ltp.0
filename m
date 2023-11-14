Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1DC4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 10:31:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9F03CE4DB
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 11:31:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174B43C2A65
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 11:31:38 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5D7B2064E5
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 11:31:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Eg4SnR2Lz6HOlbqS57GvA+EMYFBibCR1y7FYcinDGrEvwzIT8LF9+geD3QqYIl2qWG5VSSpmHAG9x3L8YocSi4die09/y0SNkqbDhx+exuD2Dv+QQtaqpj1HFcvi18HgRgudstQLeu48fSeCDV7b4IlGvxnUhvl0XS28gIDzzI9TxX1EiG3XdcD/tNhgny1YC1nROUE4CLzL4ZWGb5snXhCJkk37APzeLMLsjMbsX9h5ygiyvYkd9Q9UDOi3JhLDEDFVQ3Ki/6Yxs0fGE8qRu/R3cIVOXb7P9gV94u0V/EqstQ/F8Rh1qPCfLHG5A8Ux9qBu8bGwlO4tRcEz6NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7CpxlTwPLpsU5OE31PS0OexQ/R+IIolLJgf8sR7358=;
 b=ABuJpy56LcyH0oaiCS4lTtpzDm8osJcLhzBHJPu7TPQsWePHPX3j+LjN5WrU6WQ69xKXvAcuPCS/dqFjKq62ryP/GGrzpUXwsMOx3WKtRqVMCTilzYIrhmnEw9zjzUkqKUAPNDwrSn2XAEx2HXlkjrRHYo/4gVV9XMz5hkRzT2Z/0jvtb0PvHWUeqMnURdXEoAGHO+VH6dBSPLZLhjIfH12V3umMvpRK2AHVZPh40Sb54N1uEeV09VG+oqcyywTPgev3Ja+u5MXhmA3g0fdPLuhcUcrJdvVJhSYb+IEdgvfPV+mKI4mNVdUjznorMGBJJSlsdnXEGcZYA0aB+g22yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7CpxlTwPLpsU5OE31PS0OexQ/R+IIolLJgf8sR7358=;
 b=1OlVBdr7bGCFb1Gml5FKHBfZiCR/K3OMNvNHbnMexfCqwkBD51nFnwIlqFql8S7RGPJv+ghLJuIyhVzIJ1QGzNX0mJWQPef+PGqoiIistpRZu05sOFqXqCYJw9MPUxB1fb+9kxTVX7MJCJq1DZSI7sGyKLuzXHa1od2lq62U2lEmmo6Q+7oEw2cJXd1F1GXA/XAr0VbT4Cfo6H5N3kmYX9In5VC8Kn/iqeYQY+riwTYpNdz6AnM2jiv3IOJNOpzCSat6Nns+pjCNUka4rveMIamjE6IiFT3hezXG7eD7lO9MiZChH5F3eomlHw7EDDn3qSP3ROLkd8nJAvJ8TrTEJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:31:34 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::37d3:a796:d252:be6c%4]) with mapi id 15.20.7002.012; Tue, 14 Nov 2023
 10:31:34 +0000
Message-ID: <3592b9e9-8d19-4164-9242-c47d2a2c0ef6@suse.com>
Date: Tue, 14 Nov 2023 11:31:32 +0100
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
 <20231113160552.GA2235190@pevik>
Content-Language: en-US
In-Reply-To: <20231113160552.GA2235190@pevik>
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d5dc4470-af07-48b7-1286-08dbe4fcdff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYMLV2hCiEEkaR0fGZPWL4H0C5TJUdHklze54tlh9n8R2YGqQXNr86bSltj7GUFBdz+NJyMhST6bqVKCR2cefYSzj0vw92I3Y6++JXZZQ8BjFLUg4ZvjNDS4EJrl56Nd2zq9ycq8wBDZJWvCfzsAuXDgUVw9dvjpkvZ34HRiN+8c/BJfhWDYySA0kjLUw+Pz8DLoGr7jJrCMD/vTE1BVyuuYpY4w9yKnGrshtZsUQMqXhAxL6dsu+X5OA3xIZX7f5nvpRNDbzUNZZlNkd1rpH5ru/xrOtVJQV1BDkuCYVZm6FYAoWCp9/RGkioMZWxRi/xOCsPfaaH5t0RyEM1kE8XEoNRdFEasSYACUe+ekg/D2jLtfPoGOdL3J3AK64gwYFxxHeHMrwU0zgzXBPyUpQQBtpQGkM/fZYQH7ma5rk6BO0H4jCfTIRaNLgpsL81vM6eouPkVvJpP94BmBRsS2jmjw440LZpmMZ3UzzhYepGJXQqr3zsrtZlh8BvU4QwQSd8wR2aUIKW7WxxyXAcNGzBgNDQf/ASWFf/e+kIGj3GHMCjrqYnM9CHHQ7B3D5VbqbrjTycvILEbqloVIpQAXoLeYYT1iJ72U/qVymOnR0jVoK7JULwLg6wqcxQkQ96R7tmeADKwX9kA3U4rnMBzWMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(6506007)(6512007)(2616005)(26005)(38100700002)(66476007)(66556008)(110136005)(66946007)(31696002)(5660300002)(86362001)(44832011)(4744005)(41300700001)(2906002)(316002)(31686004)(36756003)(8676002)(4326008)(8936002)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9wZWdpbmZITGtwUEFEVmp1ZU1SVmxFUmo2Vi9lb04zNlJpYkF3Tm4vVURl?=
 =?utf-8?B?azZ3RG9ZbXNSMlFTS0FBamlWcE55OHRpenNkbDVqNVNMTHZua09BSVA2SGVY?=
 =?utf-8?B?OFZCWkQ2Z0FRc1Z5bzNGOXRwS0laUGVxOXJYT1AyendEeEgxaWNhbDdTSWVU?=
 =?utf-8?B?L2NyT3N5a2E1amtTYU1PWU5TY1dhVk1taDU1aStnQVcrU2tuTXFNeXUvdGd2?=
 =?utf-8?B?MURCYitKRHlpM3pQTXg2YXp1elJLSnozQ2p1Qm04WEZJaHBlODdRZFI1Umla?=
 =?utf-8?B?bk1NRFAreVpJVEREODg4OU5ZTmhzNzFzOG10SFNqZS9ucGRQa2lYRjRQZVlr?=
 =?utf-8?B?cHRaRURxd3JIZlg3OHpXeU9aTE54Z2lEdEdKZjMwK0J0aUszKzlIb3h5OE92?=
 =?utf-8?B?cU1ZTUovMXdRSlhNbFNWQ3dTQk9TVGliSTJueUdZeVFNd0xtdkxHaHhFRThw?=
 =?utf-8?B?cEZLdTZCY3BJN3VGenpidnQvckFnS3hsdVQvMWZ2SE9qNmFWSDgxTWlwazlq?=
 =?utf-8?B?Z1VWUWxvMXRXY3gxV3VmTE1RY05zZVRyOGVDcjZzbFMrQnpjSks4VG9JM21x?=
 =?utf-8?B?dVRLUWdyejZENmp6WGg5WFlRaW5GeEhuSWU5UUQ3d08zRDFYK3hUVGtsRWlD?=
 =?utf-8?B?dk1YallBUkJ1cjE0ekFOMmhMenJ1T2hVUDJob2dDM3NaazNaRVBRMHNjSTRK?=
 =?utf-8?B?T3NicTExdEYvL3VZcDJjTU9kSVZaMDBiYUh0anJpbllveGl3c3VWTjhEVHdv?=
 =?utf-8?B?eng1TW1MWi9yVDFIeFlCYjJHQ0tJeEIvaGJ1cHJaOUpXQW83cjMwRlczcnVw?=
 =?utf-8?B?aXlycUJtazNYMHE1R0lmcmNrbGVod1czeWMwNm85WVdKMWNJdXgza0RNSUxO?=
 =?utf-8?B?QkthUG84QUFpaTBtV0NhejQ4Y2FEeFNqZUh5WGhSeFAzMGpkRk9UT01ScU82?=
 =?utf-8?B?UEFqaW93SlJJNzFiQnR4eWNPWGxMenVDcFZjOURMUW9ZQVoxWWI5eG9mNG10?=
 =?utf-8?B?Z3pYbjVyVmI5SmUwMDlrcElwSEtWYURGZWpyVlVHVDNlUTJSWmU4Zmp2MDVa?=
 =?utf-8?B?ZWhQbGdQckoyVFpMeXJJRmJXdDNGSnNUanNrUllSbmRvNlpBdmRvMklXdGdo?=
 =?utf-8?B?U05yS1d3bnBXcEpEdjJTdTNyalZvc2Riajg5aUZLUTN4TmQrL2s5K0JSZVI4?=
 =?utf-8?B?UjRvN1dRZHEreEtnRlgxcEM2eGV6aHhoTkx3K0xlNXcvQ3ViOW5Oa0daeHNx?=
 =?utf-8?B?OUZiS0lVV3l6QTR4Q01iTTJLa0NaUXR5dXMrdVRzV1JhcWZ0UGF4OU1YY05t?=
 =?utf-8?B?Z2Q5aXhuSmJhWUNUSTBvcC8wREZ4YWE3Z3Zud0VPRTlIZVkyeitkMFVZQXdk?=
 =?utf-8?B?UURoNzVmUkhEZEY0N1F0YmcyZHhsL096Q0VWK24wNUR2OS9vWHQ0VllUUVFt?=
 =?utf-8?B?NW52NlJhYlJwSXlUSUV3L0s3eHJmbXpsTml1TVIzeFc5SjRiaXRWNm9OYkxY?=
 =?utf-8?B?c1JtRmFqK1R3bFJGOXhtQnJzbC8yalR1c0ZWbmlPQXEwOTNvQ2R3c0tWbGdr?=
 =?utf-8?B?cG9Fa1ArcGF1RHZHaE1hdmJGOENHMGV4ZUV5VlFkWDk4aUtMZi9NUW1UWlBa?=
 =?utf-8?B?c25mVXlGQTBXa2ZHeVUyUHl4ZklldkpwVjZPRjEwV1QrK0lMTjJWYzVGZGNV?=
 =?utf-8?B?bmx1eE5zYitlN1EzeDRTZEtEcEN5bWo4N3RLR3o0WGhvYTBYRzExVjdYTVQr?=
 =?utf-8?B?MVRRQ2dsNlluT2w3SmJpaTM5cjVsWkJ3V0VQaWlISGdvU2QzTGJLenRseWQ4?=
 =?utf-8?B?clBYbVp4V3VMcUpDOHhGSkszcXc1d0xZUkt0TjJGRVphVWcwbjRSc3hJaU5J?=
 =?utf-8?B?M2RiSksrSld3THk3eENyUlVxa0lSTW9HQ2hwbHRLamxjd0dheW1ORmRXbUJK?=
 =?utf-8?B?Y2VLQlRGbkZYVkoxeHdRR2JZQ2ZRZEsvQVJPVWlwa1hsS2RYOGhUa2NwbFhy?=
 =?utf-8?B?UXk5dlRRS2hLa3NGVEkyNWxJUktNVUdmMm9DQjdIS0tmQ2VUQnZPUEdLQ0Zj?=
 =?utf-8?B?NVNUZVIyeVdwRnNGNUU2SUJ5M2pZYThBOW5LRmk2aWN0a2tsMHltVkt2c2E5?=
 =?utf-8?B?bGNsQlNOYzFNbG5KTGk1ZHd4RUNpL21TSEpuaWsvSk9tY1F1dzVZalYvcHg3?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dc4470-af07-48b7-1286-08dbe4fcdff7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:31:34.5042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSKLVRUNhsIN8u4Ab5YRyPoZ2rusGA21AtoTsbdKmv0to7kszWgJGvnQ/YUubgneM0GGZ1kDKq1Ig86TCYKhCytPnQw4AzzfVW1lTq7EB0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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

Hi Petr,

On 11/13/23 17:05, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +++ b/testcases/kernel/fs/fsx-linux/Makefile
>> @@ -22,13 +22,11 @@
>>   top_srcdir			?= ../../../..
>> -include $(top_srcdir)/include/mk/env_pre.mk
>> +include $(top_srcdir)/include/mk/testcases.mk
>>   CPPFLAGS			+= -DNO_XFS -I$(abs_srcdir) \
>>   				   -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
>>   WCFLAGS				+= -w
>> -INSTALL_TARGETS			:= fsxtest*
>> -
>>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> This could be a separate change, right? The point of separating changes is to
> make each patchset smaller, which I agree does not help much here.
Sure, I can do it after review.
> Kind regards,
> Petr

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
