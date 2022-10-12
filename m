Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98573C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 03:24:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D7223CAE98
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 05:24:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF7A73C1769
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 05:23:50 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A282D1000D40
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 05:23:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665545030; x=1697081030;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=g+3q9+JPlBkduKw5zjRraKSGPb9np9GlNV3rHvKfeQ0=;
 b=PLBsnPnRpJQeASC1PXohmtKYM4GutLn/7J10OqyJ5JaQ+OLqTOqYIejU
 fGMVJI76CLWDYpMKwdiplVIMVxiH+DlpdKB5xolXuUiq3UICG0rmpJCfp
 Rb/V7ChTFN16JFwmHYRT3lQNJyBNj0tZn0tKdVC5NP3MAGvMtDq/AbRwG
 2grWO5ZVMR/6Vi0scoUZCw01sP6dUNO4nXs9u+ILrFG3dyJMBeK13vxWG
 LgK0rbZppLfbj8CH5fFrROfWAH2ykRfWBhkO3VwXME0kOB9r8rCHzM4vi
 jNPo84Jbc8K9/jRW9ysWfHJsCdcEQJSK48aFMJYx2zKzSVAj7MOJQkeR/ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="67226077"
X-IronPort-AV: E=Sophos;i="5.95,178,1661785200"; d="scan'208";a="67226077"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2022 12:23:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmTiCO5L7/YtRe0MpJLupd01V2if+PieltgJvR1mMn4jqBz0cnSdYg/ngOQuXCAQc+xpYGY5r3Lk3cYnWlhCeGZ46RcAgmWVS+AyqlBJpTRbJ+nW68p8AIrCxRCG6QPHtKHs0CPqouG8J2ya4VGG0wllnEC9D2MgDY+Pcvm7VHhKPy9pdX3/590igkmQOPXpIl+8Bji2BjeQY36JAPReAnvuidzMhKad+V3I/RVJWt+2/n2vsMrYMbP5O84iHDxGAJZ+82V7yQE1dA0E8dtHRhVsWhb0uCCVp7YOr0gLtWjo9domutFjTzfNe1RIrtpgJ4hASAYjUoi2DPyWeJqBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+3q9+JPlBkduKw5zjRraKSGPb9np9GlNV3rHvKfeQ0=;
 b=n8XNrNx16SwmZTjI0ELdBEdIW8m+oYTAnDBF0C/at+xVzcQxCLsPD8cb1qVCnUyoFlb9lbQ0H52cwWCHfnxB3ph+EFZduMLjNweZRTtiZddBkXeAKjlgWdCD0N8rOPT903o3rPAFlQXpMzM1ZCSxX4Wl3LcrizSv9zJkTenXkBSemE+9/054X5ty5sb4SdaisVmCmDwW7X/n4rguAPac5D5RDycKEVzpTwi0Xpby+C4GwwTSR83g4FhM4okeg45HGNaf/do91qX6EsHeS0ava5H9baxEPO6hS8sS4XRdTWTf22yJ6W7sDlccIdgGrM0taT2M+1LaD+oAzy9RR2A49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5945.jpnprd01.prod.outlook.com (2603:1096:404:8052::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 03:23:44 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 03:23:44 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: zhaogongyi <zhaogongyi@huawei.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH v2] syscalls/add_key05: Add userdel and groupdel
 before useradd
Thread-Index: Adjd5jE3lvc4sglfRNiAg/h5CAtMYwADFH0A
Date: Wed, 12 Oct 2022 03:23:44 +0000
Message-ID: <1f9f60c9-a5df-591b-f17c-1a7bfbed61f2@fujitsu.com>
References: <61954be9361d4d5282320b9ad58e8938@huawei.com>
In-Reply-To: <61954be9361d4d5282320b9ad58e8938@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYAPR01MB5945:EE_
x-ms-office365-filtering-correlation-id: 18d13fac-9d4d-4417-b84d-08daac012b1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5FUOnXW3CeNlNyKnIKbD1/5dYQP+3A41//A/aE5xzwLu7UI5Plw+eaJ1DYkE0YKT71hQOb1NjV8t7Y9q8g276Uv9oA4FX/yLZkgJg+AOEdPajf6co2ORRtnnyCcKY30o2TuJrXEmxtuzhuBymYq+fLIH5UK5/znjANY5Uxhmdzm1bR0EbCNmeWRaFjwDNoTZHzObjMH5WE0/WtONQ2mn+b5GgCT3hy+MsaZW6JVQ8RqVP3kc2QCvtwf5QnrAR+kpexGLxTxT1cd9uCcEscrwuKNNVq3p2rHdAfa2EkXTslRSDoMTqqrE2bgTWCUBtGN2tRa+klFa0O+wss9Tb3RMrhJt2f0uA0J+xwnKhP5AiAm4p+tczfs9ovWv1nYnxakhftIzK6sW4F5GYHOafaYsVx86SCL77EAMU4DQJO8WNGCQdXIsG64pzDFZbl7lY7wCjCgSyZMjJR3qqISh0mRGbma6ly2xffT/CRGtQYHrRJkUDi/OYnxSJoS9+6OLUPGdh8voCqxPx/Tu/7HzgTGhyzwpE4fX62QAWjaNkyR7q+ziP6hcFM9fouh6H9OWSbNMNYSaNRsMLSXkcflF//Hl3vRwp8vZ/2Eei7VwYLE558h8JWwhTTOGGRnckBDzN7mhpaZEJ/f5MnJgHHW8txV1Towqdz/1/WPrGM4diyLH2pWm+UgXVKLGbkBNj9/K0eQrZkaktAg8+a8s0lhOfq0pj4h8hdVwaUEZp9KIeQsqMQ5KR7ol48BqMhmCyUTu1TmFQ5+vPxUnAbrfNcVs0+5qxWbs8p8J9euNGCvUJ06aCXHMl81P4kGffAHUzYWLI52l9/nILT89OHGSFWGhCjKiY/2aYpYrRv5NOUtQQpXyxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(1590799012)(5660300002)(8936002)(38100700002)(2906002)(41300700001)(8676002)(76116006)(91956017)(66946007)(66476007)(4326008)(66556008)(66446008)(64756008)(86362001)(36756003)(85182001)(31696002)(82960400001)(38070700005)(316002)(478600001)(186003)(6506007)(2616005)(6486002)(6512007)(110136005)(122000001)(26005)(71200400001)(1580799009)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1YvY1MzRFpUNFVaT2g5MCsxOVk1SmdoalY4RVRtcms1Tm1ZWkxDWnhYNWZU?=
 =?utf-8?B?VjRIN1dySUxpcXhqTms0YVY5YjVVRmYrMVJVaG1pQW42TkNhNG1pbDIwMW9t?=
 =?utf-8?B?NnlvekZqNW1TVHNmNjY3bC9kQ1cwd1NBQkNWRjM3ZCsyQnJXQUpXemJvTDBP?=
 =?utf-8?B?Z241dXNqYjZSbXRKRnc5cXkrckgyaDBBbG5RMjVUY3pONTNEbjhnUjBQeTc5?=
 =?utf-8?B?ZEN6VlFEV0p0ajFiOWxweTl6YnJRaSswYjFuNFdySGZ4SU5mZmp5YnAzVmt0?=
 =?utf-8?B?TkhvN0tkYStZQW1TbGJncW9SazBJRVViNzUyVldmODBOYlEwSWsxYjdGc0cv?=
 =?utf-8?B?Mlc5cG5RdTBHU3NtT2o5dFErQkNtMVJwdUZhYmc0TE9jVlN6MGFidDNTQkFL?=
 =?utf-8?B?SnJFdnc1cm82c005UUtWUEpoTGt4WkcwT0ViTHBwS0dpYTg2NTJWbkl0MEVs?=
 =?utf-8?B?ajlZalpQblVpRmt0MTNXbWxpYmcxYkVrUXVtZkFHb2ZkVURaVEVFRDdTbFR3?=
 =?utf-8?B?UW1wZmVYRXF2aEovR0VaV2d1cXBNcVZSZk9HUXRsbmlSQUNUSzRySVptekhq?=
 =?utf-8?B?NS9CN0R6UVBpK3RBSVZIejBqY0hXcmdDMHF1RUpuVklPQmkweHl2TldDbW84?=
 =?utf-8?B?QlV2T2gvdXZnUlpNQnlvd2kvMXZkamxBNGdWZHN4TlJBdFVZS3NVOFgzRUE0?=
 =?utf-8?B?VXZONFlFR2tmRUtORElaOTNkaEszbmdoa0dvOXlCRWQ4ZjZSWWpFMWpuZGt6?=
 =?utf-8?B?c1lKVlRodEFXMnNoVmdmOTllMjNvOGowS2FWVkpNMWdFNERBbWw1WlpoK3Nv?=
 =?utf-8?B?V1Z6SkNKNG5iZ29WOHVaeDNXVm9BOFFDTWVkVm5WM0hLSkdoUG0zM2dTdUtQ?=
 =?utf-8?B?WkkrMDdTdlRCWVdpeHVoVkI0djhWcHltbTNOelpQYnhpYUVOUm1aUjk0S1FX?=
 =?utf-8?B?dk9KeXBMb25ocy9TSDVWd1ozQjBTVi8xSmZBQmJFeGNGLzlmWHVZQjBKRGM0?=
 =?utf-8?B?R2ppMkFWaGk4ZmNhR1ZickRBcFRIOGtPMzJtL1JkQ0ljWENHR3dxSjMzNnM5?=
 =?utf-8?B?YWZtbjVkN3hVOGNMTlNsRlJOUDV6dkFCTytYaiszNGJkYSs2MlMwZDlJY2JQ?=
 =?utf-8?B?SDBUWmVYMitjN0xOQWExd051bEV5anhtVVFJSnlGSE1mcUVmYm9TUVZnUkZo?=
 =?utf-8?B?OUFBbnN2WEtQejJkM2M1a3hOL1JUTW1hTU9mTnFGUDliZldhRWZndDJaQkNI?=
 =?utf-8?B?cE01RnlPR2YydmlKWUZuU3ArNlp2dHBPUlFHVlhFK1BrTW5va2FWQTdzZE9J?=
 =?utf-8?B?OUhwenphd1gxUkY0b2dLMURWSFlESlJCZDdkM0dZTEtFdGNRaDZGeFNyTm1k?=
 =?utf-8?B?b2FyWmljRkcvdXRqWUtNMFlacWlnNklSYnZmcE53VDlaRnJnNVU5SUcrWk1Y?=
 =?utf-8?B?VU9WQmpuMytGLzR1dFVnUUs2VUFYTytsamtacGxhZWRsM3VPdm1wdEpVTWRR?=
 =?utf-8?B?bTVHWXNEVzJNSktPbjZpVUQ2a25ELzR0UGxpRXFTRW8zeUVrYnZXOXVVUWVo?=
 =?utf-8?B?TzRLbWk5dk02ODg5djM2Q2FmaXBZeEdMNFFkYVg0c1h3Y2puZDdIWHovSmR6?=
 =?utf-8?B?bVVjNnM0eG1EUVAxdVBkTXd2d0kxLzVMN29pYXR5a3NkR1g0V0JRVlBhK3U3?=
 =?utf-8?B?Z0JhbjVSZ08vemlPaW94a2ZxdWMyMGtnRE1XYXRFS2NUa1VWQnBVNDhESFR4?=
 =?utf-8?B?UUlrU2J0RFNzcktsWUFIZWRYMDRYMVVaL1g1QWJHS0pXUmpabElxbHhCV1do?=
 =?utf-8?B?V3huU0xCTzY0ZTJ3b05nVkxmdWhKZ29ITGNiOERlcFU5SlozQkxwUEpoSGpR?=
 =?utf-8?B?RE9GRzAySmRSTGYvcS9TWU4raVVwN1ByM2dqRzdBRUJzVEIwazBiVVIxbU1y?=
 =?utf-8?B?VHJpL2VocFZ2a0FsYXdIcjUzYmJwcWx0WlZMS2FlTi85clk3cmRsamRLMW5Z?=
 =?utf-8?B?TWE3RENxa0xOd1lwVTlDbE1EOWxlSjFjVUdtMmE1Z21rNjl3MUlVSVF1SExH?=
 =?utf-8?B?dkM1SXBpZXRKSHlSWFFRTDNoNkMvME13RkZPYXJqQ0tTUEtTK0tsaFplWFFu?=
 =?utf-8?B?NkJGQkRwbVZ3WmJpN2JyQ05id2h1alVJY0U3Y1RpbS9pVzNmcWZUbCtuVGhQ?=
 =?utf-8?B?Wmc9PQ==?=
Content-ID: <21FAC8B4110DD7428AF4F1F3DCC9B6F7@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d13fac-9d4d-4417-b84d-08daac012b1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 03:23:44.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCjQI2znqLVvhJdQQM0vGO7ZO+5EAcAYSykSz+R0ghC5FXkZojGbtbgKxf3do+72Hcw3/QajN+y6SCUyHpheyrEcJrLwvXEzANrhag5fj0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5945
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/add_key05: Add userdel and groupdel
 before useradd
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
Cc: zhangerying <zhangerying@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zhao

> Hi,
> 
> 
>>
>> Hi Zhao
>>
>>
>>> If the test exit abnormal, some user/group will be left, and the next
>>> running of the test will fail and report:
>>>
>>>     tst_buffers.c:55: TINFO: Test is using guarded buffers
>>>     tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
>>>     useradd: group ltp_add_key05_0 exists - if you want to add this user
>> to that group, use -g.
>>>     add_key05.c:41: TBROK: useradd failed (9)
>>>     userdel: user 'ltp_add_key05_0' does not exist
>>>     add_key05.c:56: TWARN: 'userdel -r ltp_add_key05_0' failed:
>> ENOENT
>>> (2)
>>>
>>> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
>>> ---
>>>    testcases/kernel/syscalls/add_key/add_key05.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c
>>> b/testcases/kernel/syscalls/add_key/add_key05.c
>>> index 71a88d1a8..e8d249040 100644
>>> --- a/testcases/kernel/syscalls/add_key/add_key05.c
>>> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
>>> @@ -34,10 +34,15 @@ static void add_user(char n)
>>>    {
>>>    	char username[] = "ltp_add_key05_n";
>>>    	const char *const cmd_useradd[] = {"useradd", username,
>> NULL};
>>> +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
>>> +	const char *const cmd_groupdel[] = {"groupdel", username, NULL};
>>>    	struct passwd *pw;
>>>
>>>    	username[sizeof(username) - 2] = '0' + n;
>>>
>>> +	tst_cmd(cmd_userdel, NULL, "/dev/null", TST_CMD_PASS_RETVAL);
>>
>> I do a test on my system
>> #useradd test
>> #userdel -r test
>> #groupdel test
>> groupdel: group 'test' does not exist
>>
>> so I guess we can only using cmd_userdel is enough because it seems
>> userdel will remove the corresponding group.
>>
> 
> If username is not exist, userdel can not remove the group with the same name.
> 
> I have seen the case on my system, but I cannot reproduce it now.

Oh yes, you are right. I look the source code[1]

[1]https://github.com/shadow-maint/shadow/blob/master/src/userdel.c#L1145

I will add a groupdel cmd check in tst_test struct and merge this patch.

Best Regards
Yang Xu
> 
> 
> Regards,
> Gongyi
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
