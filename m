Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3126BC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 09:57:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4F03C9ABC
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:57:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00C03C9ABC
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:57:01 +0100 (CET)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com
 [68.232.151.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 436FF1001721
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:56:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645178220; x=1676714220;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=r8h+kUqgFx05e7SHcXts61XNcygHzn5ns+RjHc4O76g=;
 b=Fokt24EiVQxABPZuhbEWYPtmlrj4SI5IuD5dSZbFYI5Q70r/mKEudTBJ
 zcY7Xuk2BMhYywVjtVR6njP312WR44D9rF0NnyHh7PSnXbVQjKqQRPVTQ
 sSjr9hxI7k2zi9y3p/bw2zP4acaoj0d80UFCumO+TfzviwRvwJSPZ4Xzi
 KSgJ+q0TmCJ58o764LU06wTvjTmRlQ4rsN5bNbCDjc4bHaP/rNNxah39n
 DzMx0KKNYnkLCg6k+Q8a2XiZqbmYjvTxd18kohDb9zlf+2lt2j/7FFaUT
 68aud+OebXFbpf/IYlczOEBtm2bB2EYEEjo/eWDh8+mEIosivjh9EYVM2 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="57911016"
X-IronPort-AV: E=Sophos;i="5.88,378,1635174000"; d="scan'208";a="57911016"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 18:56:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIjJj/LlUp5pc3L8Ii1JRz/7+vrNRsh6d0Bu50iWxkPEQ2YKc1YAdS8aL8X5RAw/0gwgiJD3PmHt8+HaNJY1AaxCO094Rx9SuC+/IgzVZjdfxAVIQYo4Wg3aXV9QeR4CTD+wXfEg6WSZlgxSBsP6L584IiYVFejBJTfYjAiitVUtyiW9YctqzC8MeAQR8GO4ZVnd269ZUMo0W1qnY7hiOglyagkwGB8rR83CJNH0KSwIBeXB5cpGfTt1/fOLxD5Y6YPwJFv2xZSxuzp9+8g3xdMZqzkzvZvn0ISkPscpO3ak2w0vjKZmvDR07vFTCnwrL38qGWt+Dd8a0XuJGeWkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8h+kUqgFx05e7SHcXts61XNcygHzn5ns+RjHc4O76g=;
 b=XqpipUyXhkUA3cf9i8GSmyLlrstrd+rr6ARKGyVLpKQlKfo2IQ4ucVsotaT7OxgJDnJRxgDrgqtGRowoiI7JPVRM/rEsyXr8+/4SwEjoJGoboH3SYdDGcCbPoH83/WCEQDXSJ7h9E47/Erx2srV8aXlLQKGV20fXSWR2gz0oiO43qDaIeJGXdYbxm/ljLGGqTTrPsw64CgVgiPhR4FN8O7gR1PjpTB17g5AORaNt2Xmi8zXO4jGkwRIIrvaGajYL0bQjNPXkt1Q0ucRd90MPw/PR9naRM5Fo8RokPzM9Jb39lqPTxtnh0C0FyHlZDNhCAUzUnTXOBP1HQfdkHbPTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8h+kUqgFx05e7SHcXts61XNcygHzn5ns+RjHc4O76g=;
 b=pbi3BbE7dgeI4DGMv86Fi2T/L7TVmSuo+cAt6Y7gR/yzyby9bWH23kk97ShB34oTJdpt92Z7jZOUHcLDnfqdmCcBfDm/bXZio/rze527Q1vBoFRlm3TIsXQ84LDeRT163vR/i1KAiOIokkLKfOpJdFJB1uewefYyApL7S5q1HEQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6705.jpnprd01.prod.outlook.com (2603:1096:604:10f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Fri, 18 Feb
 2022 09:56:55 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 09:56:55 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
Thread-Index: AQHYIxyo0AgRBKwaoEiby0F40YV9n6yYIIkAgACHeACAAFzvgIAAEMGA
Date: Fri, 18 Feb 2022 09:56:55 +0000
Message-ID: <620F6D91.1070903@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik> <620F118E.3070306@fujitsu.com>
 <Yg9fg4L26MRmbpny@pevik>
In-Reply-To: <Yg9fg4L26MRmbpny@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ffe8cb9-c98b-4b22-18c9-08d9f2c4ff05
x-ms-traffictypediagnostic: OS3PR01MB6705:EE_
x-microsoft-antispam-prvs: <OS3PR01MB670584042C4BA320D52E0E8FFD379@OS3PR01MB6705.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a30IPETo8OKn+ur0OaFB6yhDG3mFIMtNM3jEGVx+jWT7avRnrbRcFOzJqjMa6LAAq8ppo5Ozi2b4D+R9f3yue/DOAeZUpCkV/njOmRcbU94hy1BI7WIWLuE58+68O5NBlwiCxdqnAgCnHDCDJOquOwQcYa+wNZrJW7gENYHVZujCuR2ZzR3SaVN2NSbnPxUa4+ZDC8V3b1vDCqJ8ebgT25xcOxfWec2VbweOy0NfoAOQ1CEW73tvjRYxvj9hCs8zIXyeMghDxjXqiEL4l45fh31pLcM9f5/EXT7+yQWBVyJBFNutqX0jn7/flfD4HV+RGgjB83M84cNryH5hIfgrPQOFOHUNvRbyzS5Cqu3TRYMokRDuPpf4PoZ5JCbr3cn4Hu1LCzovKoGGbOVuQmJTLYVwLM/kSdE/dCUZI95PEwixTYodIxPPU/SiENdgPPDKbKo8HZGEFB2NJ2Pqxy01TG05mYFLhJuhlnDFBftCu7eEOUbCV2XmKMcC+EBUS1j0u8wFW+/UvyspNxVco7qtozim+rxIeMJjSHKjJb7hk45YdN0OQdOvcCVgFqeGfK3jOZnRmErz1fmLHksxzAvkMihdCC8h+hU5JGbpgF5fBXg5TU+7SYpI3Ya0OC8Rc8SsSFGBk4YQFAO4/mH0ItBGuO0PloR36l4zmxa8Sx1wVeH5F9QszMoM2LuqYJrVZQJCEGz+O1NF+Th2l4IjjVOi/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(36756003)(38070700005)(508600001)(6486002)(122000001)(33656002)(6916009)(87266011)(83380400001)(316002)(2906002)(85182001)(2616005)(82960400001)(91956017)(86362001)(4326008)(6512007)(26005)(8676002)(71200400001)(66446008)(186003)(64756008)(66556008)(5660300002)(66476007)(66946007)(76116006)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TThqNTh6MVZqcStKV0tOcFF5cnQ5eFBOemNSNCtJSVdQcktYSnZQN1dET1NW?=
 =?gb2312?B?eTV1ajh3SnBkTnNqOWVLWkFGcDlZRmNYdEE1TXFOQUdEWlV6Um1rNWVJNDJX?=
 =?gb2312?B?eE5EaHJ0dlpCSC9FQ0hxd3JyRFB1NUtVSmw1c0R1MUg1c2Rmc0VPYnV4cW9h?=
 =?gb2312?B?K1RkVE9RT2NaYXEzc0ZYaWtEZ2tSOVZTdnpPOEtyMlBIdDk0TEpTUjBBN1NV?=
 =?gb2312?B?Tmpid3NOclB6OEtGREpVTS9qL0IyNHJaUUdIbDhsWTRjUFNJVVc4WEpDdkRo?=
 =?gb2312?B?VVBlcHp2cEJzUkdrNlk5M1MwWVBhWjBOQUk5ZFErZlJRS2dra2lTK05scGx2?=
 =?gb2312?B?R1J4VUgzUWgxd1V6QWdza2tQU1lrRG55emFqNDEyNldJRXRxN3NiNnZjRWpx?=
 =?gb2312?B?TDJUTFJvU2hPU2F4VXRqWE1WTzFoUTlqNFdRQWExbXdCcHQvY1hLZ3d1SEUz?=
 =?gb2312?B?YXNPTGhWQ01wVlFnbzhSdVZKejdtQWJQd3ZrUHpBOEYxL3lqMFNDYU15Q09F?=
 =?gb2312?B?ZkNVNGt0aXU4aG5HVTVXSTFsTWR3Tko1ZzBENUdORjRrZDRPeWowNHhPQXVD?=
 =?gb2312?B?Q1BVU0JLb1htS1VnZmtEdnlpTlBvSnZOclB4S3h4VjNxbDFvYTBJQk94d24x?=
 =?gb2312?B?NFJCQThXK2E0VHJKYTh6Ti9hcE1WZjVMK1BUZUxvSGk2QzgzRHJiOW96R0NQ?=
 =?gb2312?B?RFFOYVBUY0c1MzA4MjFPSXhsSXp2bU1Sa081a3ptRkVzbGhXTDQ1UllPOXll?=
 =?gb2312?B?bEVDSEl2U2pEUnovVG9yMm0wak5NWjNDeit4WWhMNHFFYnV6TFFVOU9FYlF3?=
 =?gb2312?B?NmpnajVtaTNDVEpkZUhoNFV4NW11NWhCcEVKWFM5aVEzSkxVZkZiQU9KQTFT?=
 =?gb2312?B?SVRKL3piMGVIQ2MwT2NlWDNEQ0dZNDdaNmNsaGZoSlVudStCUllsNzJSR2NX?=
 =?gb2312?B?RGZScGlQQ3c4ZHA3ZzU2bHFkallqS1JibDdNQWQ4REpSdVFITWNCSUVtb2RC?=
 =?gb2312?B?N3cwaUQwQWlCdHFQZTVvZU45bktneXpOUGMrT2laWkVsOW16RjQ2MWpUcEdF?=
 =?gb2312?B?WFBCTXA4TWorNU1XemFLbmNsakZHSUFtWGhaalhBQkxqRDA1UmN0TTFkTk5l?=
 =?gb2312?B?dWJHeHVnazUrV0dBZjU3YjRjaFRzZXYzUmptVEF2dDh6NXpGRnJJcUJYdy9y?=
 =?gb2312?B?UEdOZDF6aWY2TlVxa1lZeVNsQWJTM3ZLM0ljdWZoOG5Sd21hNlRvTVZYSTJp?=
 =?gb2312?B?K1kyN09Gb3Q3NTR3TEdObklldXZXQXhCVHNsYXQya2Y1N1FYT01hTEk1cS9R?=
 =?gb2312?B?RTlKWWdsU2FuYnpOZFN6akFLZ0ZWdHZ6eWhsZjV0TlZwWWsvQkd1K3g1ZTJh?=
 =?gb2312?B?L2JlenIzZnk3ZjArRk1YbGh3elBON3F0WmVuVGFYVHgrVDVLR0JEN2dGczNE?=
 =?gb2312?B?cTN4QkVFVy9iOS9wa211bG9XNXFZcEQzVFFoVGhKL215TmxJVFAyWmoxWXgr?=
 =?gb2312?B?RzN4bWpzc1ZoVWZDbHJkNmNqK25jaGhPWW90aWlSM01BK05RcmY4am5WS2Vo?=
 =?gb2312?B?bk01SU1ncVN1Wkp5Ry9BeVgwUGtVSERYQzVtMk9JUW83MDVhM3hBLytDRnc3?=
 =?gb2312?B?YTNMZDJpS2VmWFlsVlFiOVg5enVCMmtwODZSbFJTZ0sxdmRDVU8vdnRqVU1X?=
 =?gb2312?B?aEo0QUptU1IzQkdLeTlhK3NqYnEyQmRWMmxuOGp1ZGFjQWtZUitnYk83VldP?=
 =?gb2312?B?Vm91bmhrVCtPOGJBRkZzSVlHdmxwNmJ3ZXJSVkhkWjdtSUhZZ2pMYVhzTW9l?=
 =?gb2312?B?cUNmRVJYOW1kWW42WXIrUXdvaWFBOStLLzB5SG5tQXlWZDM4L1FkZExsd2I4?=
 =?gb2312?B?ZHNKUXpDQ3czeWZLZk96N0hHS0R4cmRHRGdtcVA3ZHIzZjR1c0JXUFh4TmNM?=
 =?gb2312?B?WngzOUppZi9sS0M0dXVjS3JxV1cyNXBpSk5zSTFud2lkMmJ3eTFUUXI4U0lv?=
 =?gb2312?B?MVJ0dTVOV3NoSUsvYXl6QWEralZhK1JNMU5xTkFxN2c3cnBNcjY0MTlaMHF3?=
 =?gb2312?B?bDc3SEM5a3psODhzZXZvenpnMHJ4VFVJVkRFbVJlbDExSjhRWnI1bVRNMUlE?=
 =?gb2312?B?V0JRbWhyQitLbFk4Tk1tWUk2MEgrenJ4NEoxRDQ4V2lML3V0VUgxMWVXcDVp?=
 =?gb2312?B?d21iQ2pKcW9TUlR3TkJEdExTRkQ1VEFZZkpsdGo1Rk91Y0VIMlNpVXhpeXRE?=
 =?gb2312?Q?RRhXaRjdZDx5gmjiqfCHbb0z8neD3sMszhq1Mthbxk=3D?=
Content-ID: <A0962748A0C5884AAB4D5140240F1CC3@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffe8cb9-c98b-4b22-18c9-08d9f2c4ff05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 09:56:55.5046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dn2uhpVuzIYqbQMJ3JbboKZBNkiYCf06QoxVmToh8woDrDy4UMypmuYF2KBjVSNw2JYbdQ1oYb03O1IGsf8Op4XpQk33YugsMVKm985gok0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6705
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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

Hi Petr
> Hi Xu,
>
> ...
>>>> +	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>>>> +	if (TST_RET != 0)
>>>> +		tst_res(TFAIL, "pidfd_getfd() didn't get the same open file description");
>>> Maybe just:
>>>          TST_EXP_PASS_SILENT(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>> I think we can't use this macro here see below(kcmp manpage about return
>> value):
>> 0 v1 is equal to v2; in other words, the two processes share the resource.
>
>> 1   v1 is less than v2.
>
>> 2   v1 is greater than v2.
>
>> 3   v1 is not equal to v2, but ordering information is unavailable.
>
>> On error, -1 is returned, and errno is set appropriately.
>
>> So 1,2,3 are not invalid return value.
> I'm sorry, you're right.
>
>> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>> if (TST_RET==-1) {
>> 	tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
>> 	goto free;
>> } else {
>> 	if (TST_RET<  0 || TST_RET>  3)
> +1 (very nit: instead of if/else I'd use 2x if and (TST_RET<  -1 || TST_RET>  3)
> - readability).
Good catch. I add the last "if" otherwise 1,2,3 are ignored.

TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
         if (TST_RET == -1) {
                 tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
                 goto free;
         }
         if (TST_RET < 0 || TST_RET > 3) {
                 tst_res(TFAIL, "kcmp invalid returns value(%d)", 
(int)TST_RET);
                 goto free;
         }
         if (TST_RET != 0) {
                 tst_res(TFAIL, "kcmp returns unexpected value(%d) 
instead of 0",
                                 (int)TST_RET);
                 goto free;
         }

         tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);

free:


Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> 	tst_res(TFAIL, "kcmp invalid return value %ld", TST_RET);
>> 	goto free;
>> }
>
>> free:
>>    ....

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
