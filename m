Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82571C71133
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 06:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84EB93CC3B3
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 08:21:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BE373CC341
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:21:39 +0200 (CEST)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E4A821A00FAE
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 08:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692944497; x=1724480497;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=taz9rhv2vI0HUK3gmDTYlg8uJ1N4/fWarF85hHLI77o=;
 b=C6KFA1q5H5UG9d3G5e1YoZ0dZdA0vomn8gfoffNEnTXwn6RUIjbwetup
 jFSZ3OW1J7kFwxNrSCXv1KGu2dvc0Njfz12lumCieAewluwSYETLK6UaO
 7c5DcMiALKiT4m8T0ZDligjlky/2XKpWO6wlefjaaMtB1vDUp5hAMIDNC
 VSF1JJ0fTjXuq3+eYXo2X5sKFil/wUDrBt6471N6yDmCQcirp4ya6A5a/
 bk5xC1D2xOfezME7qoiDzsJlnQglyGXIutgICa4NnrlW465xLwLi77SXd
 u3xIDFjJ23dn5ml3fhy41WfhXz5fNDrGHgzjxu/VEuSJZqAq2j+6IUPM4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="6164958"
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="6164958"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 15:21:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmbgMGNP8ujaIUwAdyrfBl7byuIwiOW09vVu+PhgY2CGNxNwZSYiNNIu9kYJ3frAaHa9vcJGcMaYGn+7Cu6VD255t5CnRwlrBpy2e4GAqVG8ZgdRSra9T6TR9dKfmriAsE9wLsEnzC40YwrUpZZsoUXCjhMw48UXCKEWEbNxQ2MwRaOevhSQsLh4jitv6fRb2mkwSm/+BbQ8XRxlTMiyg77n8sZN2p/bXfvc8DJWAbDCjx+UKvP1G4K6bFj4MhLI9/ndGpoPQ2iO1dokqyFm9jU5zzSETyfLjIE7N7p8ZLZwPc/Ed/JmxzI/8CAyTkmextTaHy4iIh1WxgwgMtkmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taz9rhv2vI0HUK3gmDTYlg8uJ1N4/fWarF85hHLI77o=;
 b=j5A6xs9qgJDBH7WeNvEkfx2WsbBd9BCZ4dmJ4C+9rvvgJsK9B9wndSulT6AD0GkSH0VeMZKtZSU8Giknhq91Ta7IihmRKDc3WWvdHyX1jOnps5vKmuyoBzpPSYiQqSqMRwed8+09ZUAPjbbzpkTqvBdZcx4Lu33H8JESWI2rL1/TzN2GXQKGUpWg++zmwg/pOHWPRSts2tZIZOtStONCtFUvnFhtwUAzXwW1MPmwVLpfCJvH3ntAZddXhS5NyD9/0EGoaRxPx1kDyxFQfPnYhZSCZImVXAljv7Oj4Rn7ArQ4o72ltH+OZGBFVUEPo0j2DJmYBByYXb9fS5LP7rnN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TY1PR01MB10752.jpnprd01.prod.outlook.com (2603:1096:400:321::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 06:21:31 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::3776:b0fb:c837:7c84%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 06:21:31 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/2] syscalls/readlinkat01: Convert to new API
Thread-Index: AQHZ1CQToQEdv5hLHUSk4z26zq/Laq/5LamAgAFi04A=
Date: Fri, 25 Aug 2023 06:21:31 +0000
Message-ID: <0f35af06-113c-5149-8c40-7e5573f74f86@fujitsu.com>
References: <1692617910-32684-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZOcew11vXKk4IKMb@yuki>
In-Reply-To: <ZOcew11vXKk4IKMb@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TY1PR01MB10752:EE_
x-ms-office365-filtering-correlation-id: 5fba5d0f-b88d-4194-661e-08dba53385e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10+LPDFQF3UtgZCOHIGEd5AH8nvV1xcosrqKXfn299tNNVzrdFbUIW4B8cUtkiQTd3gh6+Lm7vMS+KXNrVYGJLxZj7wjvZ9DfDLEbfSQXWXz4dYDFOZC9epFWBGegmnhIUsXnXidgaepBE1CB7o4D1/jS9Lv1pfcJOAPDgPWM+pShjNntGCeWSly6Zevi0e5d2MsEmOikXn+W1sn6w+QDaCHm6lLyyxw253IoVBAKb35b+zF72lJ5qClnJI+vox1cZUVq0QoQ2Sgr4D3VnN5lECo29WZfZHdvqGfOENsMHC6ACl70MddnjOkO4aZz9zuYCmdjmk33u7a4Qi7xR1SIvm6AXbEEQ2Ih5lh1c6A/K9d4Jy8rUFWeC4bpVg8wO4boZRc2mist6JnuKlAuL1F/EkmCHaQNQYhoyPI2ycThKNgn3DwXUoSZlokU0CZEWiOOrYIO2vXTOk/t1nT/NQvy8XPbk/tP8cVUwYFDtQehrrD0IqoSnKewgsg33ErzNyZIRJT2HGbZcygenB/p3waP1q5t/QazTdayBIJW9DDaRHdo2DgXb1KV0ZwwiMuF0k+H/x+CINuJK+YM9pyoWeIAVk4FMByYg4w8o7aq9qyaWcOnCLxj8UtnDr15keDWAhWYKdwRHcQCkQ1mQGrNe78CqJlqDjXbMkVm1WNpMbZD8I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199024)(1590799021)(1800799009)(186009)(82960400001)(122000001)(38100700002)(38070700005)(1580799018)(8676002)(4326008)(8936002)(85182001)(64756008)(31696002)(41300700001)(6486002)(6506007)(316002)(36756003)(66446008)(6916009)(66476007)(66556008)(91956017)(76116006)(66946007)(86362001)(71200400001)(6512007)(26005)(478600001)(83380400001)(31686004)(966005)(2906002)(2616005)(5660300002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVjZStTb2xSdDNFTUs1T0NFaTgwd2lPbEl5WEpLc1lJSWVkTnh1QkhwcnlL?=
 =?utf-8?B?RTBESHVHUklCWVV5SnJjb0NOMW4rMUZLYWd6aFZueHhzTHplODRxb3o2Mm9E?=
 =?utf-8?B?R2E1cHNKMlBTY213MnJldTQzTjRZKzEvL2RMY1JYc0F1cWJnQ1BIUXo3a3FT?=
 =?utf-8?B?RDBSTkZPQk9KbHZpSzlZUjgwTTBKQVhkS1Z4Q01TV0ZrVXdwY1NmZThheEN6?=
 =?utf-8?B?K2l0UHpVTXN4bUorK3hnVzM2VDFQTFp3MnNGWVNMcWlhSmhJSXRra0xRdGxi?=
 =?utf-8?B?NWVoZU4vMVNBa0d3aFZxWENueWlmd2JVVHYwbVBzM0Q1YS9pd2tXZGlCUnUv?=
 =?utf-8?B?Q2QvR0ZHZDRVc01NTnQzdU54WExwcXkreUtleXhIV3lPRVdnREUrWEtyKzRw?=
 =?utf-8?B?Q1ZMV0VoTjFXWk9vL0tZemc4UmFHRFplTlI2dDVmdWl0VXQ2M3krTVpBZUpJ?=
 =?utf-8?B?VTlaOGtUQndOZC8zWnYxTGxOQVM3cGJZbHI2WFBQdE85eEZiRXhaNkJhVXVs?=
 =?utf-8?B?d0xoeTBqelh4eXJPcERqRDBCaUdicUVza1pJbExQTmFVd05SM0JFQVZzSHFo?=
 =?utf-8?B?NDNGeHIyVW9jZXd2ZVJZTDFZZkRoN3ZRdXJwK0QxWDd0TTdYWXlBZ3ZBbXpU?=
 =?utf-8?B?NVRZbStuTDhBZHZlWGlzcjh2UzkwTEN6a3d0OUdjZ3FGS1dTZGgwQVZUMDUr?=
 =?utf-8?B?R2NZMlozUHFEcXJzeE1XMVRIZC9aZGxRdnhORHl3aDFUY1BwMGJ4R0Q2Mk5V?=
 =?utf-8?B?Q3BGMDJwb3I0MThKWTk0ODdlSHRpL3pwL285M2s4SzlzN2hOaU0rZFVseFJl?=
 =?utf-8?B?dkNwdkhoVms5cVZwa0hFaGpoYnpFYUQzdHdDcklCaHF2Q0ZoVlJzeGc2ZjB4?=
 =?utf-8?B?TzJWb3FmZTF1ZlllY0tSSGFoQnVuSlhBRWZENHFlU1llMDZJMUdGa2R4eVp0?=
 =?utf-8?B?NTdaNlByeWo2aEs3OUMwVmIwcGgvOTcwcUhSMGhiVnZGWC9rWThDOE9XVjU2?=
 =?utf-8?B?OGVoalIxZXRrNEVBRll6SEY2VlBMM1VyeDEzNnRMbzF2MloveTRtUUhQc1NR?=
 =?utf-8?B?K3F0RXNDRDJjaFV5aXBJeklqeDJMMFFKRE9NVXc5djFjbGN6cm05OU9hbTAv?=
 =?utf-8?B?eDFiMzhLbkd2Q0NFSUhJaTVGUzV2RkJtN3JGbFpaTlhVajNmTWlHYzAyUFBu?=
 =?utf-8?B?ZGg2cEtkWE11ckxyVUM2TC92WmFZL2NzTjRmNy9rQkdnSnFqblU1TkZtYzNj?=
 =?utf-8?B?dlI2dWZ0NzFRbW84NzIreG5uNTlXWTQ3UHZlSm45VmlNcFNOdnM5L0NSUS9u?=
 =?utf-8?B?Y043eUVuZm9hS0Z2ZC80UlRtbEdtakNTWkpuU0RPWE5XdUEzdjBtZ2JtcWNT?=
 =?utf-8?B?ZEpGMy91aGhTVnNKQjNBQlk5dEplakx1UmhnVzFtenoxMjVweldTVmkwcGVS?=
 =?utf-8?B?TlJuR3JmY0pxdEJQakVDZTF3TmRzc1RtMXBtK0J4UEJwb01oS0daUEg2MThw?=
 =?utf-8?B?YmdZWFJrMW5taEdXeU5RZCtpK0F6WE94MWl3SnFhRzlxWFdqUFNPaTZYai9I?=
 =?utf-8?B?alZhL2Z3ZTF1SjlvUEZjMC9TRXY3TmRRY0VXNUdyMTlCWElONDlNVFcyNGN6?=
 =?utf-8?B?SHNsUFV3WTIrVWNndEVvMzRUd21aNUl2bEdkVFQ0Nmp5Skg4VjR5RktNQlRM?=
 =?utf-8?B?N3djS3Q2OWp2V0t6WXdIRmNUVnh2cGFaWE4vU2lQNGYzYTA0RXRaRDd6TE9H?=
 =?utf-8?B?UFEzWmVQV0x5dm02ZHpZOUZBRmRjM2MrUFE4Rm5PRXBOTjZVWk1CT29YSlJQ?=
 =?utf-8?B?UEdEWWJkVldGaGljWUpVQVBaWWNwcVVabUlYNVNuakw1N2J3SGRuQVJmbmpJ?=
 =?utf-8?B?SWxYNzRXUEFmTUdTeUxkNmtMTUlIM2Jza1pYTXY1aDdCaFh3dk9XWlJJRE0z?=
 =?utf-8?B?bk9pcmZHN2NmN1FlWWZ2ejdUU0RFczRNTWtOMVd2NS83NFhVSHFNQzNxWDNa?=
 =?utf-8?B?OWdJY3FBbmtLdXdaSFJ5ZnNpWkdsTlFnVjNPRlp4T1RkOVUrRW1kdC9GREtz?=
 =?utf-8?B?V09jOFBERDQ1bG9NMk1BVkpnb3E2aENFOWl3UFZqTkE1V0lIajVxVFJsbjdv?=
 =?utf-8?B?U3ROODFGQkh3NzVXZFZ4SU5pNS96U1A5Z3BVTUR5Q2FadzFlc3RUYUR0Vll3?=
 =?utf-8?B?bUE9PQ==?=
Content-ID: <EB28E5B320BC7B4ABAA4AD1E1D6BAB6C@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sX1KxWRayUpliPM2qWVjtf1/vzbgN31SmhotDxLwtNeO9+T+ayfwIOKjUEk54au7rmUUG2/1F1/xbWF1iaGUh3yt85qlU5Qsd2tsfhUU37hZNP0fwBTXgJ7fvQyQW+8r+ugAWPhNH3EmN78SOU82irMV14suF+CKPKvLI/F4TKcDKzXa/D7JItzCQrGCwbnIeyZzTVtX2dXotKCuivwAmKoz/hOPX8PuXhXDnuIcbiOxl/62h8iXj2P39vG8270+kIX9XDKD9UHEWUlg99J3Zr7MX7gGP/jHIPJLIO0BGCDv1BtmP0m6tLVfC6H1+x8B+PqVJb5fIAtOPvFvxuwpiMjZDFi4fUqJ6ZGe1p1D7AkhT8FshDyWCUcBq0bN2tA0bsFea5Q9C6RDvFmUE9DdMqqKXtZt7cPxlE2x8wIbx8qHDMOqFDCszg4KpiRoCUja14LkcY/MhNH2FGtwCrqi2cFGf/EyVfu9cZHBzPoM16OWDpSHQeM1Agtx7unmi/i/aN5iSw24BbBPw60JpzbZRY5/bQkhuxCfGOFTOsh+bccgKui5jkiBfjKMrdiSN1OonHJP1cJ5p+doeqfzjqRCarWZiUELO8w6v/jw9fC+YfAVjtT0aosw123y1a+PDfnDp+HPR1ABioCtz2phzXdxzo2zkR1dugGDvSmnDQ33uLRgsnuuBXIuYYlYuHp2Q4mdWWOByCb+Vi2RX91k10d7UzIUDjAoDbZsex4DiklbmC0J+lCN6f0DtuSeVgx0hLltcxMDWVzz0kJXGKNzu0Fk+IwlG+IBQg1ntr56R7d5nFs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fba5d0f-b88d-4194-661e-08dba53385e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 06:21:31.1388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io1zWWRTP4sM8wHOkVoDzd9fwYdXR0BY4+Y//AM7He8zntmxaYdxKZ/PJ74Uug+Y6yu3wB5HiFqp4fD/QYxcAeABQZdk0AsgZ6o57tMMTuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10752
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/readlinkat01: Convert to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi Cyril
> Hi!
>> +static struct tcase {
>> +	int *fd;
>> +	const char **path;
>>   	const char *exp_buf;
>>   	int exp_ret;
>>   	int exp_errno;
> The last three fields are not unused anymore.
Agree.
>> -} test_cases[] = {
>> -	{&dir_fd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> -	{&dir_fd, abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> -	{&fd, TEST_SYMLINK, NULL, -1, ENOTDIR},
>> -	{&fd_invalid, TEST_SYMLINK, NULL, -1, EBADF},
>> -	{&fd_atcwd, TEST_SYMLINK, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> +} tcases[] = {
>> +	{&dir_fd, &testsymlink, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> +	{&dir_fd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> +	{&file_fd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> +	{&fd_atcwd, &testsymlink, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>> +	{&fd_atcwd, &abspath, TEST_FILE, sizeof(TEST_FILE)-1, 0},
>>   };
> Looking at readlinkat() manual page thre is a special case where the
> pathname is empty string and the call operates on the dirfd, i.e.
> attempts to resolve a directory symlink. Can we please add that case
> as well? Can be done in follow up patch...
ok.I'll update it in the v3 version.
>> -int TST_TOTAL = ARRAY_SIZE(test_cases);
>> -
>> -static void verify_readlinkat(struct test_case *test)
>> +static void verify_readlinkat(unsigned int i)
>>   {
>>   	char buf[1024];
>> +	struct tcase *tc = &tcases[i];
>>   
>>   	memset(buf, 0, sizeof(buf));
>>   
>> -	TEST(readlinkat(*test->dir_fd, test->path, buf, sizeof(buf)));
>> -
>> -	if (TEST_RETURN != test->exp_ret) {
>> -		tst_resm(TFAIL | TTERRNO,
>> -		         "readlinkat() returned %ld, expected %d",
>> -		         TEST_RETURN, test->exp_ret);
>> -		return;
>> -	}
>> -
>> -	if (TEST_ERRNO != test->exp_errno) {
>> -		tst_resm(TFAIL | TTERRNO,
>> -		         "readlinkat() returned %ld, expected %d",
>> -		         TEST_RETURN, test->exp_ret);
>> -		return;
>> -	}
>> -
>> -	if (test->exp_ret > 0 && strcmp(test->exp_buf, buf)) {
>> -		tst_resm(TFAIL, "Unexpected buffer have '%s', expected '%s'",
>> -		         buf, test->exp_buf);
>> -		return;
>> -	}
>> -
>> -	tst_resm(TPASS | TTERRNO, "readlinkat() returned %ld", TEST_RETURN);
>> -}
>> -
>> -int main(int ac, char **av)
>> -{
>> -	int lc;
>> -	int i;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	setup();
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -		for (i = 0; i < TST_TOTAL; i++)
>> -			verify_readlinkat(&test_cases[i]);
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> +	TST_EXP_POSITIVE(readlinkat(*tc->fd, *tc->path, buf, sizeof(buf)),
>> +		     "readlinkat(%d, %s, %s, %ld)",
>> +		     *tc->fd, *tc->path, buf, sizeof(buf));
> Can we check that the buf was filled in with the right file name here as
> well? We did that in the original test. I guess that we can just do:
>
> 	if (strcmp(buf, TEST_FILE))
> 		tst_res(TPASS, "The filename in buffer is correct");
> 	else
> 		tst_res(TFAIL, "Wrong filename in buffer '%s'", buf);

ok.I'll add this.

and i think "if (strcmp(buf, TEST_FILE))" should be changed to "if 
(strcmp(buf, TEST_FILE) == 0)".

>>   }
>>   
>>   static void setup(void)
>>   {
>> -	tst_tmpdir();
>>   	char *tmpdir = tst_get_tmpdir();
>>   
>> -	snprintf(abspath, sizeof(abspath), "%s/" TEST_SYMLINK, tmpdir);
>> +	abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
>>   	free(tmpdir);
>>   
>> -	fd = SAFE_OPEN(cleanup, TEST_FILE, O_CREAT, 0600);
>> -	SAFE_SYMLINK(cleanup, TEST_FILE, TEST_SYMLINK);
>> -	dir_fd = SAFE_OPEN(cleanup, ".", O_DIRECTORY);
>> -
>> -	TEST_PAUSE;
>> +	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
>> +	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
>> +	dir_fd = SAFE_OPEN(".", O_DIRECTORY);
>>   }
>>   
>>   static void cleanup(void)
>>   {
>> -	if (fd > 0 && close(fd))
>> -		tst_resm(TWARN | TERRNO, "Failed to close fd");
>> -
>> -	if (dir_fd > 0 && close(dir_fd))
>> -		tst_resm(TWARN | TERRNO, "Failed to close dir_fd");
>> +	if (file_fd > -1)
>> +		SAFE_CLOSE(file_fd);
>>   
>> -	tst_rmdir();
>> +	if (dir_fd > -1)
>> +		SAFE_CLOSE(dir_fd);
>>   }
>> +
>> +static struct tst_test test = {
>> +	.test = verify_readlinkat,
>> +	.needs_tmpdir = 1,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.bufs = (struct tst_buffers []) {
>> +		{&abspath, .size = sizeof(char)},
> Again, the abspath is initialized dynamically in setup() no need to
> allocate it here.

ok.

Thanks for the patient review.

Best Regards
Yang Xu

>> +		{&testsymlink, .str = TEST_SYMLINK},
>> +		{},
>> +	},
>> +	.tcnt = ARRAY_SIZE(tcases),
>> +};
>> -- 
>> 2.39.1
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
