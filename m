Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E062C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:59:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA446103C
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 09:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEA446103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B0A43C8840
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:59:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F7433C2BA3
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:59:28 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E691600E2C
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 11:59:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1631872768; x=1663408768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EMo+T9XNYHmfXZd6Yk8mJ5qbWssaKRbtXWtHIeizzhA=;
 b=kdbNXn1lvceuR+csJETUgnNZm7FHznFQ61yymN1UWKL7C2bnQk4VsX2Q
 YxkddLvVXWAmdvYV4AQEzPZH648pBmcpbMTmtdJSSq+DkEM9TPK8dlfM9
 adMIN6HtY7Ma3q5VfEiGSkDa7B95nzJhBF0y0NbLzbgGM0Is522QfN3ab
 LPWCC64R5GMcCwxPNhLa9n0UIFrKcjbSnhbWMMKdihqxBWoMzfR1G6oA6
 fDiMa+3p8fU5kRkOR28LlWWdvQrcRcCohPO/bPfDDPs4IUOrM0kai1tZM
 YLpnHV2bqaKeYftKoqp2vUDDzUqZmy8OGPBgozGRVOmMsgGrrQjWIXpqP w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="39395366"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; d="scan'208";a="39395366"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2021 18:59:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNE4tzZQoSzqGolWUk7rKMkqHDk+lrtOALhUjZr/8rNdOwVgomVl0GiK6W5JsSlxrlCxwNlAlPsFRS4qoIhAEKXkuLGIHCQNjI5WgFBxqnOned+X8wZNIh/jetx7aUIFRsQ6MD/gbzlYPPGOesIRKAItc1CK4OHJrPV13t6VjeJLqd+J69gjk7zWmmsqYkbWjGN+sjqQP35GC5F9TVfX0tgU3MFYeXTvbMwVjDsCqeFmOcg4Udd97qZZoWdBzbOmqaXsamOSpIaETzKglokY0vgOuqeIzBQSSXgOZkmFBrmcuu4YKb5j89HSak/Eo4pl1QRm2Jjvj7zFabofsQE+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EMo+T9XNYHmfXZd6Yk8mJ5qbWssaKRbtXWtHIeizzhA=;
 b=RDlCJHKFqAedyBZgiYQ31vljs2NZg4+ZrS1mYd0CLF75dTJfHjQpRGL2SCOXdg2KFvaK9XOeJTj14UKEPVqwkNr2I/ctgyZJcULPCE7tpfJaFYe4tDSp1RZKKER8JcU6hu6MZWxX3mhuZrgyFNJRIMY/TfFUDsCwwbfBHMxtBz6mnWgD2pI5USkV+aM2a2RbgunR15hPA8TPJvf+kxMd24+PzH64eM75zhk/axCux2AyBh0hS9Zl/8iCAaUrYBVu3YM58Ta8+31ym1ShfyyRRegnYem2ACot8UnRIVYTiTkzdGaU/8gv8Qvn4OXGoV2vdvAbULMdZ4ShHHKB9Cs+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMo+T9XNYHmfXZd6Yk8mJ5qbWssaKRbtXWtHIeizzhA=;
 b=czY3RyeIz6z2+uhcwWNNuir9ijDvNzhLfIis18GsWQr1RO1SSBh8MidVu8V26mm+BvItyEcgo3FHg6XHMidVQVaNl8Vul4GsZUoiiWuPc3hu5AavSvci/YaHT+3uM/G8KDPvXd81F9E8XPUWBEQcpfyJjBo2yLr6DMsa8PC8qZQ=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6538.jpnprd01.prod.outlook.com (2603:1096:400:a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 09:59:23 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::783d:cf1b:a4b9:5791%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 09:59:23 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>
Thread-Topic: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
Thread-Index: AQHXqui0GD8mHM0CVUCgJ2DGa79JCaun6LCAgAAL7QCAAAsNgA==
Date: Fri, 17 Sep 2021 09:59:23 +0000
Message-ID: <61446711.4020101@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-5-qi.fuli@fujitsu.com>
 <bcc00ba4-2e7d-8ec3-2856-6cde6d45b587@163.com>
 <OSZPR01MB64547BE94AEC979C8E0AFF1FF7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB64547BE94AEC979C8E0AFF1FF7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceeec59d-443b-4bac-5a2c-08d979c1d399
x-ms-traffictypediagnostic: TYAPR01MB6538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB653893EAE9F9B1131D909B1BFDDD9@TYAPR01MB6538.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NX7rQ8N22JucwZEB3TSkPOl0wxOpTCZWOZ8BX6/54Tm6T3HSX4bA7iRMD7wniqwuDfNdSriw/czzg/S2uHk9q7+uHVptfOK732doyKPdCWLx8dwSm+srqK7Km/oSY4/8gFOlNYHYyFLiv3FhtlMV6FcYwqi6tOeIDDY8Ev+8TpcOfHqZ58/vybkX+v/24dqjGBJd5/T23gQ4T3q1gqI8cPHIaR5UYzGh0IOeY30C5zO7VVE/0qaImgLmNDZjnpD8kmevPNE38uucdfaZjugUOKpJP5AJBaSvGcWH9JDJcmFVqPjNMcnVt6KcjxoHsokaeog9ptOB+w4Rm1ihFuQTx6DJ7gNRijYu6CNkdkGr5gXRd7/yLywhXzlkiORTScRxZ7zGQ3Yuh1o9NzOGXql5bHS+VgUWMbpXf+PJDZz9SejtarArrvXxRC/JkE1SdPCEJJ25yK1NLWFvYGGETwUGamkwP+g7m1jHNQI5nAaJYjrQzEPBNe2av2tSpOYenJtGeqLnuSMM3dZaFHAMgaGgRXM6hxiJ5VksuI3jeqWo1mQMIAGNTwiE24FuR7ReM7N7tElYQUtOfXMO3OX9rsEY1CnzkGXnmAFMKfgJNylh14KVzDSoaA7afw7aeuExD8Rcsu/ZJjPv79jiJgU4f3IM6VWZcCsnczguhwscOAwvib253cqNH+GBG1uzsE1l8lTpAsQ+woCx/p1A17k0asbG8tJmJ3aTsnyMIfHoirS3bgg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(2616005)(54906003)(37006003)(87266011)(186003)(8676002)(38070700005)(6862004)(83380400001)(71200400001)(91956017)(6512007)(85182001)(8936002)(66446008)(316002)(508600001)(66556008)(76116006)(86362001)(122000001)(6636002)(6486002)(4326008)(2906002)(38100700002)(36756003)(66946007)(6506007)(64756008)(66476007)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2tldUdwTkx2WXVTdHhnenlUNFRldFdlbkJKSlN3YkhMa0FSVDRSQksvWk1h?=
 =?utf-8?B?bjRQd2Q5STl5Z0owOURmVlRKNGNKRlVaUGxwWVNKc2lTSFE4RHEzbzgzS3Z5?=
 =?utf-8?B?aFNFeXZpN3BUVzFKUjB0Q1UyNTRQZDBSNlJFOWNuaW56eHA3U2R0WU1NYjk4?=
 =?utf-8?B?VE5zYTQza1hWYnBNQy9tYzhTdGtYZXJnVnVDZE1MUVpDajdKcGM4VjRWK3Jn?=
 =?utf-8?B?OGNkVVdkK1NGcmNpRUdpbXplMjl3SnBkck5kNjdROE1aQXREcXJYdTRKZERw?=
 =?utf-8?B?ZEtXSUl3NEdEdHRjM3hJMktMUDFKTENZNWJGcmhydmF6V1c2ejFWT0VSTktE?=
 =?utf-8?B?NVgxbDlLR3VhVENyVGhhTVhnaExtWTU0bFJxT3pyUGxkbEo1Z003MUJTM1k4?=
 =?utf-8?B?V1NNYWhGWmE0Znc4UExLZEtNSFJDMlB3ZkdHYmF4QU0rWjdjZWpzU0pOemdq?=
 =?utf-8?B?N012aUlmb2JyTklMVHkzcjVTRG5wU3ZNcjNiV2UrVjNoTk5ibWZHZnJlRnow?=
 =?utf-8?B?NVBGdndrQ3p4Q3p6ZkFVZnVJV1hRQzRMb05iNHREUDNzblRlR1F0ZmhwS3o0?=
 =?utf-8?B?elpwRk02UlJNV3VOME1FdFoxV3BpY2hBVFBjM2xFWU9PUVpjQ1k1NzFGbnZX?=
 =?utf-8?B?UUZPd2xocUlUOGM3NTdFZXpZdnZmS3FYbVhlZ3U3RThXNURIQ2dFd21OTm5J?=
 =?utf-8?B?Y3NZTVdobjJJeHo0OGdUd0lreDRZQzhRdWpUUHNZZjNBSmhONDRWc0E5N0Fi?=
 =?utf-8?B?dWY5L3dvSWN5Wmd6emNEbW5QRDBkZzZzU0U0clF6WE5xMlQ3VkhBY0NpZ0M1?=
 =?utf-8?B?TGpUVFFjOTRMSW1hUkdXbW9CemMxV1FHRzBXOUhBcTVCdFlGWk1IM1JGbis5?=
 =?utf-8?B?c0Y2WFZLd1NTbHYzODY2K20yaVB4VHJzV0tKTEs1Uzlma1lBUlZrL29qWU5V?=
 =?utf-8?B?NkplbUtqVEtyRHdTQzV2QitRQnBURGtZK0RTZkxoWkN6UnB4QVExYytLQjdS?=
 =?utf-8?B?Z1hsb2Z2WitXUlowTktXcWsxYzN3ZXJmY3d4MHQrNE9uSGRXT0ZBTHU3TWU3?=
 =?utf-8?B?SmVLaGsrRitFVW5QUnRmRnBGdm1JbE1CajNURjdVc0xiSHlsMGNUYnZST0Fn?=
 =?utf-8?B?TW9rOWVTNW9PbkpVNWhOVmpJK1FPaU12d25hUHFrUnNnUFRUNEVrN0ZBOXhp?=
 =?utf-8?B?WTUxblRvYUdINUZQbWd3bkREOVBVcE10cjJibHZ0bFV3bTZMZzVGQnlYZTlo?=
 =?utf-8?B?SkgrNmFKMXFDMFliUlIydlBPaUY1TGFncXRGMkJFYkVELzdXZ2VTSEVNM1Jj?=
 =?utf-8?B?YzlVaVNBUFlPM2Y4cHlYYllrNFdiM1Q5UzBxeVJnVXdBYkF5b1pxWDU5dEIr?=
 =?utf-8?B?cXlGenFVVTJlOTJOMkZkaDJ6QjJkN2xXYk1oZlNuNUZFZUh2ajRGUVRadktL?=
 =?utf-8?B?Szd6cnhYL2lZblJlY2tsTm94UGdVbTdlc3d6M2x2L1Q1WW4xRzB1TFNycWEw?=
 =?utf-8?B?c3RaUkF0ZWR4MURkblJzZWsyeEU4RWh3MDdKZFozYmsxZDVWWGFXcnNuQ013?=
 =?utf-8?B?WlE2TEc0SzQ5TnVIM2RCdk1PZUI0aHJiZGxpMS9ITHpoSHNhYnRvQi9lM2k1?=
 =?utf-8?B?WXhLK1NsU3pOVDFYTnNRQU1yek8zOXYxcXRsOTE2K3BCVUZHeEY5c3A2NFFZ?=
 =?utf-8?B?NmpiNjhsS2QwMk5yUThmZ1prQUg0WVdJcDFHajRDOVo0OXNRdmp6S21BaGQ5?=
 =?utf-8?B?NTJINjBpV09PSjh1TWlEU2NCVitaYUJkSGtqaGtGZGM1UFFhSExORGM3VkNz?=
 =?utf-8?B?NlZLWWhSMk1lWkdFOEQydz09?=
Content-ID: <A3D0D307AEF78347BC41EC149F46C4D0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceeec59d-443b-4bac-5a2c-08d979c1d399
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 09:59:23.4501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/anQdrslln/Su9cPoc/Rz/FDWeVA0WdZ8Gj/8Gu3Fa/S7kSilW0ipG9URWtgVN+ITw40wiHJSY65C5Tn6gL1SlY+RdHCHWHdNpf68CZ+wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6538
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API
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
Message-ID: <20210917095923.qJja2D9qI5aLaS_9PGywxNb10StuoCbJL6hGzDTjrvM@z>

Hi All
>> Subject: Re: [LTP] [PATCH v3 4/5] syscalls/dup2/dup205: Convert to new API

>>> +
>>> +	if (TST_ERR != EBADF)
>>> +		tst_res(TFAIL, "bad errno on dup2 failure");
>>
>> Hi Qi,
>>
>> Why do you only check EBADF? The old test checks three errno.
>
> Thanks for the comments.
> Both Xu and I got the failures with EBADF,
> so I think that checking EINVAL and ENFILE is not necessary.
Yes, My machine fails with EBADF.
Look this case history, it said nothing about why need three checks.
But kernel code in 4e1e018ecc6f ("PATCH] fix RLIM_NOFILE handling
") ,

it seems old kernel will return EINVAL when rlimit set to 0.
Then will return ENFILE when rlimit set to 0.


And now it looks only fails with EBADF from kernel fs/file.c code.

> I wonder your opinion.
>>
>>> +
>>> +	if (ifile<  min)
>>> +		tst_res(TFAIL, "Not enough files duped");
>>> +	else if (ifile>  min)
>>> +		tst_res(TFAIL, "Too many files duped");
>>> +	else
>>> +		tst_res(TPASS, "Test passed.");
>>> +
>>> +	SAFE_CLOSE(fildes[0]);
>>
>> Why do you close only fildes[0]?
>
> I did try close all fildes[ifile], and it occurred close(-1).
> After talking with Xu, we think that close oldfd is enough.
I think we don't need to close all filedes because dup2 can close newfd
before reuse.  We should close them in cleanup function.

Best Regards
Yang Xu
>
> Best,
> QI
>
>>
>> Best Regards,
>>
>> Xiao Yang
>>
>>> +	SAFE_UNLINK(pfilname);
>>> +}
>>> +
>>> +static struct tst_test test = {
>>> +	.needs_tmpdir = 1,
>>> +	.test_all = run,
>>> +	.setup = setup,
>>> +	.cleanup = cleanup,
>>> +};
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
