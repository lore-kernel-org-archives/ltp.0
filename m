Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047EDC4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 02:30:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A20AD3CA1DD
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 03:30:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA9C13C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:30:04 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 68FBB1000A3D
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645497003; x=1677033003;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Fd2R5Mx63DXKdLPY2pTDJKnvaek5l+s6+SWThIODFSo=;
 b=pw1d7ZXncudYwp6p5WnUmhvyYq5wBK2fPdONMblp1ajzn1oLQq3EOyBk
 PXu53PuzL7L+0q4M7yGJyeSndxEYNkBSfH0DvkgQ1uttGz0FGBIxc59ZJ
 AOXzYBliFfm13x3UOKMBH5zeSeNMIc6XSfC+yxAiogu9nLJfVy43U43Ck
 7Nxw/A7vC2pLaJCudcD0J2umU18+hMBfeO/zag1iHqh9y9HX/kqvKBlBo
 aBFjpG2ZmCO2EQYhzBro6jPgdSVkJgPeTN0G2ndeHq/p4rlp3KjTCBrvn
 Xv2amLd3gahMvoUiDvmOAM3rA4VVsT1WYskFlBBnjE4zFMQuKljAq94oC g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="50179707"
X-IronPort-AV: E=Sophos;i="5.88,387,1635174000"; d="scan'208";a="50179707"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2022 11:30:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmDuM6ZVKywCktbioEciNFwo1Ee86nBZKe5yeculmv+dBwDfxu715Ng7Yp2cvQwsCsYa09fpaHKncba8ON7+l6NGVM6dQP61LVgBZqcE9jaZHudQJddtMcYGdTmy/EMz15fa1kEb/hmNU/v2clUrrEy+TT0BpsUcEOWtNnvAnTdQAWi2y9fs2iM9pZODN7n1e53hHxuHrj6+tO0S2Ou5bVlhI0FokRfbylNIXaS0E7/G/bhU5Pi+U51jEQyxvO0hHnXSGvNtxJueH+ZeONGsvgC6GqSwuE3C0j14w+ydl7Yro4fo5AIr4ls3cPNt2YCkKhmZp4l27yLeyRNq6a5CHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd2R5Mx63DXKdLPY2pTDJKnvaek5l+s6+SWThIODFSo=;
 b=lvfpArB8HtPMXkCow7NGW9LNoKkjrqvSCx6+4maKRqeK6PUMXeK+hj3UHRW3qjIVgO5qhBYFtXi19JnsS70fm7rjulXrTH5fslYziHRkmvq/j+cySiEFJqSYU/7ck1N40NotJiK88YdYzu2GGoJ0AceTpxz6e9BH1a/SxEwGK5lwD3MinnN/00hwC2yOpo7Lnt2/DrusQcw/ZCcFRd6ejN4waiS4ZVqSc0taY7Owl+aY/K7mDHi4c/bXP/T7Q/4RWmgsHc8h+FRjOsYZp/qULz2C1mQ0iq7IWRzFjqrolZxF99bY1tAzmxPOmCUH+2HWSoIo6N4oP+BTteNj23Z9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd2R5Mx63DXKdLPY2pTDJKnvaek5l+s6+SWThIODFSo=;
 b=YXkrpuIZKnA6JM0lyy1cMaGxVJ2sqT98RKjKmJo1iUQqnY+QMHnhnHs1xDhxj5JaPIjzAhWcHcqdg9sxo6cBjSAD55GzMGQ4b5GPyFfRHrFpBO2lqkAWxdzJQGtC1LS6d2X6HqLhb8eySQYJR2Xwf7p761I8YCbjIbNdW/tQFsM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB7254.jpnprd01.prod.outlook.com (2603:1096:604:11d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 02:29:58 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::29ed:c2:4190:cf13%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 02:29:58 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
Thread-Index: AQHYIxyo0AgRBKwaoEiby0F40YV9n6yYIIkAgACHeACAAFzvgIAAEMGAgAAFIYCABcdZAA==
Date: Tue, 22 Feb 2022 02:29:58 +0000
Message-ID: <62144AD6.4010302@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik> <620F118E.3070306@fujitsu.com>
 <Yg9fg4L26MRmbpny@pevik> <620F6D91.1070903@fujitsu.com>
 <Yg9x397xUislLTm9@pevik>
In-Reply-To: <Yg9x397xUislLTm9@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15366069-4463-4abf-8f78-08d9f5ab384c
x-ms-traffictypediagnostic: OSAPR01MB7254:EE_
x-microsoft-antispam-prvs: <OSAPR01MB7254E63CF8A5FA61B3AC75D6FD3B9@OSAPR01MB7254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xERvbuGXI7/uuw2hXMqPhXC6zkHk2T36ezMaH3wlUPFvF7bzAt9lBi4ocoHGrmdnIoxKlMEg+MGYs5kDBZ8wNm1HWiJZoHjOvwckqvhPORPHvnr7wc+KxH0/pTfUWL8ner3LxRz+12ebYkzo2K/w+uWtpaGtxlaNx6PgvPQy7y/IKlU1kgKLvVnuGBw98bNpTNe2U70keijCHNb0u3d/wl3jCUh73Ee/Awj0qVc1lEa0sPt5rotWoxvhdjYCb23a0J0sDmkVNoSCgY1fNprNwNeVLTYRHkYZE8hr6mLyHH9pWGm4K5/Cag5jZP3I7bDLLxA9GjDtFs2uS/v76xzetdvLI0NwJa7zlUn7eww/c0jgF2B7vju/7UCCPlo6HSuP4iUJUvDx1MotTn/oSXHRINS2Nsm2aHMmTTlVA/0qc5tKQ+GG6zJHx5Cg9ZReSkb582WnIZj7ENx6LbMlHRoFjd/zpSPjHgAhOB/I/tK5OOKi38DsEHRCwTaQLMM+h/D2QXZ7lZklMxiPJj5JZPKLLbA8YQv+2PZGLFer/BmfqWq9gRuFMV1DL+VM0vhtiJtZoaXG70SgRxbXcuntsowAvx+TZnOFBfIdHowlJlroL/w+qbb6PWNWPZXnlueKlNhRbjmRvambmYYXmbRP7pKjzAAPJ4cmGpaGhAxmZ07qnnNd3zeYtLpCmxRjkqQRxBx8fYryYi0ScHWrecqUkWwvyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(6506007)(186003)(26005)(87266011)(2906002)(71200400001)(36756003)(122000001)(82960400001)(38070700005)(85182001)(38100700002)(66476007)(8676002)(66556008)(76116006)(6486002)(316002)(508600001)(6916009)(66446008)(4326008)(66946007)(64756008)(91956017)(6512007)(8936002)(2616005)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OXpxZEVHZVBDRFl4OTVYVmFXa0Y4R25yNTdpUXhya3pJY05seUhoa0FQVlRS?=
 =?gb2312?B?MHlkbytSYUZ6emwvY3NGSnljMElMVXRPS2VDR1F6WFVNMWZBdFhidSttSUdL?=
 =?gb2312?B?dTlJcXpnOWRDUEJnbkNTc2U4MGRYOWZEblY5K3k0elM0K2luZzBUQ0xPVEhB?=
 =?gb2312?B?TVFJSUdkMHhzcWtqK3cyUnNyVnd4bVJ2V2RhQXRJRmprUFIvWnh3eEVMQ1Rw?=
 =?gb2312?B?TFBjUzF4djlaRDhlaHJrdjk5Q3NrUDVrNGNXZDlDUnBqOVoyVEFBL1ZSYURK?=
 =?gb2312?B?cHduQ3VCK0U0VGorNGdySHVEUkR1dGdzOWJ5QVVzaGVIR2tGZVBYcnZqcGNQ?=
 =?gb2312?B?eHpkQ1JLS05SK2NSTXNkWkRiMlJoRVFDRDFKSUN2Z1gyUkNzL29XWWNzNU5n?=
 =?gb2312?B?MVJ1dUlxa0RKNjVwSHlkNWdMeCtwUGlhcWhXcXhZYWgwV3QzakF1SndYT1BT?=
 =?gb2312?B?dlV0T29HVk8rUHBUbk1JSStZYXhrY0FKSE9nb2NQeWRIQ2FUTEI4TmhyWGtS?=
 =?gb2312?B?TWVHaEEyL3pMclQwQS8ySWhkUzBFbFBGZjBwdDhHbU9sY2pIOUFtZnh3Nzly?=
 =?gb2312?B?bDhhY2NpbGhETS9QMzF1NlpqbVZONlh5SktVQXZVOWxOWVluT1Nqb1h4eFlX?=
 =?gb2312?B?M21aVXNRU1dobys0RE1IYjV6azlLWHR4eWZsck1BZWFXSlFWZ2FhdGwzOFdr?=
 =?gb2312?B?Wm94MGV5bE1rd1BET3NkT3A0ckswbXh5VXdydUZHbUNWakRXYUppNjFyL3o2?=
 =?gb2312?B?UzJDWmNUSlhXTUVnTjdHNnZ0cUJJNXZhdXRmQWlaa2lpSHBERWtBWUl0ZGVp?=
 =?gb2312?B?MHBMQW9jUW5Gbm1IcGgzUmo3LzNhTTdhRTduRGZrNVhNQ0RQZTRFRG1iUU44?=
 =?gb2312?B?UTJRMW9xQXZQMC9FZERPa0hNOUNNWFVSUzZCWk5HMFBTYTh3cTFlbkd2cWQz?=
 =?gb2312?B?N05xeWdxU0V1R0JuQTk1UlNmOGhvdVhZNVNRUTlLdmtMckthVmg3V0ZUS01X?=
 =?gb2312?B?RjlUTTRBZUdsVHNUM1llRWl2ZG90SS9WaWoxcFNXSUk1TkM1dHZ1YlhueDV2?=
 =?gb2312?B?QUo5OEk4MU5TQTZIa1RQUTlCUVZ6bnNDQ1E1VC9EUDNobnd3SmdyQm5EcFpY?=
 =?gb2312?B?dkFOU0gyeWkzc3AxUXladE52S3VodDYzWXBQMlZERTVzdVhqZFBZRkhTUDhD?=
 =?gb2312?B?N0VxanVLQ1ErVmxPaEVYSGNQTGRPVFhPRWNJbjJlalpub0lheHRoZnU1UEdn?=
 =?gb2312?B?R2p1bDNpZEVLU3RyamtXZlN5VUV1YW9jb3hURDlGL1RxVVYveERSb2kwdWpQ?=
 =?gb2312?B?N1VDU2cwbG5RTENYdk5LSkRSVWVYc1lHRStVekVuU0oxblRuUTg4ckRuYXNw?=
 =?gb2312?B?MTc4Kzd3TmZJZFFjVHNhdVlOWHV0cWU0RXNTN1IvN3FidDhNdGpLZU5TeVly?=
 =?gb2312?B?SlEzVXJjanFCd2hVR1B6RFNGajZBUDNLQmRSNGRxUWJTeU1tYkZkNWVwSm5D?=
 =?gb2312?B?SGg2S0IvaUkwVnhNUXg2RkNXU0ZGN0w2QUFLQXRHeEtkZm93MGR5bFhaWXdw?=
 =?gb2312?B?WngzS3J0Wk1iRVpoNkZwN3ZNYU1EN0p5TEpIZEt0YkZQL0hWTkVpbFQ0Q2pp?=
 =?gb2312?B?RDZXRW1QZy8rSXVCamZlSm9aUVdoNHoyck0vd2lMWVBSbXVqbTNZMHUxTXhF?=
 =?gb2312?B?M3lwUExMMy9MTklPSVVlYkxIMWJ0TjduV3pocWNPT04wOTNwLzA2UmJ1S2lM?=
 =?gb2312?B?TDFCOXo2THNCcnIxeXRIdnZiTUx3TFR2R3pFd3RmUTIxVmVRMVNrdUhhZ1E1?=
 =?gb2312?B?a3R3QzA3a1QzVFBkMjNlRm9FMERPTDBVZkw4S2d6R0xDRUp6SVdldnJuYmlL?=
 =?gb2312?B?MVNBdENlalNkdEl2N3pXdmtsNGlQcFBUMWdTTmZUVyszcWpKWkY3YU5OdnpJ?=
 =?gb2312?B?NFpKOUlKU1RzTXU5NEZxSmZiRmlHSkJaeDRxRjRtSDY3Y2lPN1ZmNHhuL2tX?=
 =?gb2312?B?NjhmTlhMSnZmVTZPNTJXbUpMcEpOV0lqdEt5RHdNeWZNZXYvTU15MVNYSGxQ?=
 =?gb2312?B?WGE0d0RKblNBZ2xQaGdXNVEzeDl5UnVkbVFFWUtES1lBYm9ndzBERjFwNG5a?=
 =?gb2312?B?cUNoV09hWVh6bmFWOHlzd044MVRuemszNGNpRUR2Y0wxbW16Szl4Wk56am9J?=
 =?gb2312?B?M0pZN01VSzVIUEc1anJsdGJuYVEvdStqdGVKNFFjNk1TbHg0QVU1Nzd1dFEv?=
 =?gb2312?Q?kCjYFkcBj5CZElz6qSWV3JpS55v9g8VJTA1/LXIUVY=3D?=
Content-ID: <E1FDF39F0633154DA67849CCF82EBE53@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15366069-4463-4abf-8f78-08d9f5ab384c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 02:29:58.1765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcU6RuFvcs95WSgzTxtrgV15TtygrfJywCAmKV7IHYwl5j3PyGsckm2MCKAu5hsO2iPAidmFnoxGFBp8i2GezOsNJYVGY+8Ks0157OZiOYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7254
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
>>>> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>>>> if (TST_RET==-1) {
>>>> 	tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
>>>> 	goto free;
>>>> } else {
>>>> 	if (TST_RET<   0 || TST_RET>   3)
>>> +1 (very nit: instead of if/else I'd use 2x if and (TST_RET<   -1 || TST_RET>   3)
>>> - readability).
>> Good catch. I add the last "if" otherwise 1,2,3 are ignored.
>
>> TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>>           if (TST_RET == -1) {
>>                   tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
>>                   goto free;
>>           }
>>           if (TST_RET<  0 || TST_RET>  3) {
>>                   tst_res(TFAIL, "kcmp invalid returns value(%d)",
>> (int)TST_RET);
>>                   goto free;
>>           }
>>           if (TST_RET != 0) {
>>                   tst_res(TFAIL, "kcmp returns unexpected value(%d)
>> instead of 0",
>>                                   (int)TST_RET);
>>                   goto free;
>>           }
>
>>           tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
>
> FYI Unless we want to have explanations why it failed, we could use TST_EXP_VAL() or
> TST_EXP_VAL_SILENT().
Ok, I will use TST_EXP_VAL_SILENT.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
