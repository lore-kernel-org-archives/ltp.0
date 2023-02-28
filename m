Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CEFC64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 01:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 565A33CDE70
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 02:32:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6A93CB0EA
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 02:31:55 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26922600637
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 02:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1677547915; x=1709083915;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zlUUGsGaWRuzQXkuCEyMdv4DTPFeCPaFvaHgh3aHsNI=;
 b=Q2jG8FibdX48/1233LzuBRWvC7frDnlCnuQYs/9ZEUPgGEyPKRu+PvE2
 /MAo9U5KLNHQtINyO63WxxJt/+Ds0jMqVgjlnY9hAEEp/U2nIFhaTmmLH
 Ad3PyKCDYAXjQDuVoHuNdudswaJyVaohM2VswKk56cPEUAJ373SNbOD2i
 lV+z20rqiJelFXFWFHsZoWzrh3JQpFk0nTfmOPTLuCuYHU4/NNKV8IaRu
 eRkyGNLQmtn+1YKHM+B+q01q+qedOusxYn+PRcgo27bd787uRbCXy6qGb
 MoayCpCSeb6Q6nkHJEyARhFAmp6oalltmrJbUqnoE25tA8ngHRJPvUi6I Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="80269628"
X-IronPort-AV: E=Sophos;i="5.98,220,1673881200"; d="scan'208";a="80269628"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2023 10:31:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/WsDoeRaHBJpdVWE/GxDgVLnNF9L5Awscpp5m9iYg4/WXTDv4J8wcF8bl3ova3XWaZjc9y8o1VUNvBbmHmvlRwn282ltfo2rtTnNWPhgAB8VRedFJJrOzBaYM/l7C0lllv59Y/Sh3T9hPVoC0bynZDUAzgnkmjkgvDtfizoAKGBQSOtZyE901scvP9T3iDtnQwcue6Zryb5J5MgFLrBQkXweUIUOmqQP2rBsWaz3gSLWivnIN1E4ql4Ii9Hlm0YVgEmw/PP5/V0VQoGMLqUkyD+JXdd9mmeXZTfnEqQ/RwaD1BhpHvEPAtdQjv5/t/x3lPpk3KB5XhSTCsfHobDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlUUGsGaWRuzQXkuCEyMdv4DTPFeCPaFvaHgh3aHsNI=;
 b=f53TfG2icMtlH7j+awehVJS08xtoRrmD0fabqt/m2YWQUK8z0CFOjLsdVHRUW4mIylsT7YWF6lrj3hvG6j2Mp2j2W7nB2oTq66ao1eabT4lKDPOJovPCz5rR+GDUIMqYC5GG+Z8sWvQ1ZBsyxaKNWTJm2EenEVMw1KMmCRgH2FNW7Ho5uBpQhu/omqYmfEE66qPU0u+prIDe3eFDYeGXU5/JkZJoWbpXJLgeRQoVm82WsQ91e94CMSp6Vcr77SxXftP7kY1iK9vJ8dQFkCcygNhiFjghUPyWXBNIGViZWyRDAvGiPS+x//aSrxQriAxCiRl6BvqCE27k96sDOW0W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB8194.jpnprd01.prod.outlook.com (2603:1096:604:174::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 01:31:47 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 01:31:47 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH] mount03: flip to the next second before doing the
 access
Thread-Index: AQHZSnwdMXKNCj8tO0akunk2aAJaq67jk94A
Date: Tue, 28 Feb 2023 01:31:47 +0000
Message-ID: <cd413ddb-5451-14be-9d47-a5d54076d39f@fujitsu.com>
References: <20230227072103.264317-1-liwang@redhat.com>
In-Reply-To: <20230227072103.264317-1-liwang@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB8194:EE_
x-ms-office365-filtering-correlation-id: 6c048132-1636-4281-efc0-08db192b8efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CSoeTW21CqgVWsIkAxTJrymjg7+Ey/fik7AjrHekZd/uL+cZ+tyuNY+Jl0fIsYGGCZghySRCRM6h7AopzapBGoLObWkyQDEC7XlNxZVM9o8zp6nHsAJseTXUyVw1KscXyyDNHPIh5YuIeQdft9ZfAKBLmOUjZLqKZFoE4Q3fbPhhJVV/+bof7dcv/aTinPqlbVxSKOu1uzKHP4O0YJB8w4g0jSRnTHkkActODyL0pa1fvv7j9XwMh/yb29SZOIn6rQLPj2BW7WgHeN4nFTXs2RhIhFFMCTtm6d6SUinH6U4pAvGR07rATZqHPAZQg0USMGl6QvmFgziWO97sTaGn+G0aYfMtugMgMN2EBphv0NTsQbPhy3JLXYmIRGqJsA3VlZUxr7UlkEeJJontfJIp45xL2108xWseuLyhIa4GVEAAySflqvQG4llbFvWfQ12cQ4XZ3Cd+JnTVG8Pghp5rYClHOE7n4VGQfngn1uEN0MBYBx2ZWPR4J8sJ63lgNd7+yd3f5hVwOEJk6de+K+JZ2haxarCiPtE/U7TDX2HgM5gx7jVAKQCFkd8ibYq1HIvortRTO4dlzx6TaW06ZxLmu41vA7NPmn2wLfpQj2hfTGsLq/0g5V9YBjwTd5yyAjlanF0rxsORaszeS2gCe8Ofdnw1PRal28kGVEY2ubr7bnpLr76k6b7MWUcarrbQ7aHOm5iDhMzKE0hkYEU9iePP2Fq7Eo1/3MtsNZBDoeFUg1a0w2i6uWubYGohKiuDe4f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199018)(1590799015)(1580799012)(31686004)(85182001)(36756003)(31696002)(86362001)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(8936002)(5660300002)(4326008)(2906002)(41300700001)(82960400001)(38100700002)(122000001)(38070700005)(6916009)(71200400001)(6486002)(478600001)(91956017)(316002)(54906003)(76116006)(83380400001)(2616005)(26005)(6512007)(186003)(6506007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzNzOElpYjVVYkQyV0dlc0xacXU3UGFUSzJ3V2tuNFBKYTVOTmdHSXVOTUZi?=
 =?utf-8?B?TjkzQkV4bFVLT01OYUdPMjFYNGJmNUtENEhnUmxQQ296VDRLR2l1bndoTWlq?=
 =?utf-8?B?cFBrVVhSTURKSDl2YkN0bk11dHp3SnVNbDludmJhVlNVS0E3SjVUU1Roc3h0?=
 =?utf-8?B?NnBmZ1VIcHd3M2FzZ3dRNEkydnVFeXdMQkpiV2l1S09MTnd6TW10ZTZEZS9T?=
 =?utf-8?B?RU1zNm5pV3pzTmdkMEliWU5vVjdBY2lYbDA5eUhwTFQraW9PNDhzQmFGV2F5?=
 =?utf-8?B?T1JjSTBxcS9PZEZhQVVWTGMxamlBVWRpT1Zsd3lFdjRibFFVbHFKaDFLcDB4?=
 =?utf-8?B?TUlNcFNlNDUzMExPQThaakhoekFjSHkyRU9pQU03NHprY1R0cUhXaXBXSWdp?=
 =?utf-8?B?OUpBMDhhT0FIWDhPV2JmQzN4aWdSYks3VnJQdmZuRXZoNGJZYW0wVmEzR0M3?=
 =?utf-8?B?aGp1NlVKM3NXdGpKVTQ4aHlUWWpYbXBEUWI3S0hiblAraCsrWkFBTUsvaGo0?=
 =?utf-8?B?b2t0VGg1VXBRaVhPYkwwK05tVzFjaEs5ZWp2RTA1MDVlMFY0UlRyajVibVh1?=
 =?utf-8?B?b1dNd3ExTHd6RWZadEtHUnJsbE0rMG1ZTDVJVS9VenFmZUFPeWRmbS9nU3Vw?=
 =?utf-8?B?c1JQSWRITjU3UXFLWkQzbTg2Nldqd2x6STJOUThXbUNrMitaQVJIUTdyM3FJ?=
 =?utf-8?B?N1F1VmdRU083STRzejRCVG9ZS04yMGptZWhxN1l5VWtrazMxRERzU2s4bXU0?=
 =?utf-8?B?ZHlkUXc3RkQ1YlBGalF0YTBYaEtDTFh2SWk5L3dvSWxZcTVEQjhpTmVNM1JP?=
 =?utf-8?B?UlcrUFlSbVc0SXdKWVZGdFpFZjMyVnhHY1ZsNkk2L3Z3S2tEUk84bjFacVkz?=
 =?utf-8?B?cXNCY2xMSU9MT3ppL0Y0bWI4Tk5ja2djMG5hdWQ1bVZtVldpenpENjJPMlFL?=
 =?utf-8?B?NUFZUHpIQXdtVSt5d256Qk9PWWFUR09udDJ0U0hJOElXd09DZnV6b1dhS01G?=
 =?utf-8?B?ajhjdGdoUXkvcXRYaWllTW83RkdiZjM5SFd2bUtnSDNheXVJTXVyR216amE4?=
 =?utf-8?B?RDU0RG1vYzN2MG1uOFQwV3JTZmo3Z2ljdXpTUXA2c0JxY1hkSkZWN0crNmhR?=
 =?utf-8?B?NEpNWUxFcUFMU3FycjViUllFb3lmeVRSSmplanNtL2R5ejAxWUNNajJhSEpX?=
 =?utf-8?B?Y0NhaXhWVFhqWnRidDlNZHoxcE1iYnlYNkZhRmd0TFNpWmptREhRUDcwRGlM?=
 =?utf-8?B?WThVa2lEVnVzanZ3S2o5czBFa0lINkJWd0VkbHVScnhiQjg5RnhtTEF1SFRh?=
 =?utf-8?B?QzlyMVNvaVVlclpPVGVHaVBHejI0YmlhMFBBY0xscHBPYTcwTWNyRklWVDUx?=
 =?utf-8?B?L1VxVlF5ZythRHp1eXk0R1kvWkt0ZS9rVHpqS3dXRTZhNndDM0tCcUNGdlc4?=
 =?utf-8?B?cTl6alNxWHR2TEhHeTdVcjR3b1I3cjhxMHZ0c1FEUzZYaEppTVhIeXhCRVV1?=
 =?utf-8?B?TG1PWHB5SnJPVnp3azRjZ3VPZ3lSZlhDY05yd0QzZ3ljd29hc3haZnJORVRR?=
 =?utf-8?B?TlhLSDZsbVI2ZTZGYi8xYWJ4M2toNU5XcUlYSXYvUDZZYnAzK2dHcFlMQUh4?=
 =?utf-8?B?VlJDMys5TUgrUUJiVlc0NndaYXE5RUc1ZFl3c2FocUk1SUVNWS9nR1FGVUc4?=
 =?utf-8?B?WkJLRG1DbU9Ja2RtQlh5MW53UjZZVDVqWmFKd1NLV3pQVW1KR21zQVg4V2hS?=
 =?utf-8?B?OWhZcWFpZjhLaDFITlJOcGE5eVhDaS9YWVVJMjcwNFA4dU0yV050TEk2dVBn?=
 =?utf-8?B?elpEODhSWmlkd1NrYkRMbEtSd0ZmMUZrTkdYSzhGZ3o1dTd5NUVENzlQMDlM?=
 =?utf-8?B?TlZ1Kzh5WXlyd0ZrSk9tb0dGeHpESm9CWEdiYnNhb3RVSWlSeFovV0JBZEV4?=
 =?utf-8?B?a3J3NVRMRW94NmhkU0lQRFVTcFFWbW81YVl6dy9aSnprODBTRVZ6ZVJ2T3Yx?=
 =?utf-8?B?dzJTU0tscFlRTEs1c2lQMzRzVlExZ2xzZ3lCUytFbnZwNVZ1NXlwTHFUa25x?=
 =?utf-8?B?V3FYSnpLU1RpSW1MaGd0RHE0amtaQWh2SlJRM3cyT3VWMnV0MlBUSFo0aDRy?=
 =?utf-8?B?UzI3T2ZtKzdWd0RRZWw0bUdISFVMWFpBZUsvNThrUjRPNEtaUEk0MkZrYXpS?=
 =?utf-8?B?TEE9PQ==?=
Content-ID: <ECB6A1D65C27C541894A8A797B0C0B3E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 88u/bS9g6ILcK2dbqGILY6XPqomXXbdvNX9jd0uAZ3ve+WZAz5C6Jb5NicwfiEYuhF/cfGRO+ng5m9jyEE8CILoFbo93shpUM5TCAnB3UzhNweN/GHpuzYQksn5Ac+bZDEsmrRvDjmECkPQTt8ZAAMVOvHkifGCHhHCFxsl/lLiOiLFwj0wfszLQteMqol80V+mxc+Aah4hJhP1qhPElFXv8t5FPHnW4ivOa6dSUpTVJI7NI8Ymbz1aQuoBtU+dYALX/9fbO+LSGjW3LKteHXNFqPlhErh/zHiQjXSK4/D7gty4azvzAIlmvErVvnp48qdYsTrHmmpCTQQP0X/pmIeEa/PwkftkTsx+zMrNBTxTjWo+22pSL891BtqWE0tvFEmTz1+D/5CpHH+StEBe/vlZupj+HLUkra0pzTjdLoI61Y8nLEKGWv8xy6xG9e5R0wmtgq41VDzZyiRTdX5COZWVSJ2qsl6gTqnuFZfhNj28K+dPU5Wupd0LBfDym7V3RDH4hPc80ykL9qAI3MyJTxr9ylTOiLemZEaQIqfNHbjB7EtW7fnJ+iuCUO8R8qdHW2o63tPU0U/ZrXunDPDE0BeiRLtBIgPpI3/H7NlQAC4EuTQpBEc/vPYJVMt55cDJ9HFwdq0/hbBb+PHwXxGWq5i0YQ/9zP8D1cxuoo8nKiscpk0KROviTAi6iY8ma0e2NmC7zZPB74YsAdC4EmD38TT23YIH9tjJKGrtBQGhNIduvU2MGimPQtfbhLwQYEPOAaLkFejxamdHl3Q2U78eFiO5Zhw48rquhaPj4PT2LS8g=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c048132-1636-4281-efc0-08db192b8efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 01:31:47.5883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZ8EGNbxc3kIUlWLtltxW+/1qj3s1Sc3CR1leLbPB5a61bdKyTgr/VeanxM0hVZYaD60H8pM2cD9OWBBU+untrSdh7NDxA6zSBPUnOZyC/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8194
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mount03: flip to the next second before doing the
 access
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
Cc: "llong@redhat.com" <llong@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li

Looks good to me,
Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Best Regards
Yang Xu
> Mount03 occasionally reports failure on tmpfs:
> 
>    170	mount03.c:214: TINFO: Testing flag MS_STRICTATIME
>    171	mount03.c:140: TFAIL: st.st_atime(1677086243) < atime(1677086243)
>    172	mount03.c:151: TFAIL: dir_st.st_atime(1677086243) < dir_atime(1677086243)
> 
>  From Waiman Long:
> 
>    Looking at the mount03.c test, it is reading a directory in tmpfs, sleeping for
>    1 second and read the directory again. The test fails because the reported atime
>    didn't change. Since tmpfs is in memory, access to them can be much faster and I
>    believe that a race condition may happen that the two directory reads can happen
>    within the same atime even though one second is supposed to have passed. The same
>    test pass when applying to a real filesystem. So I believe the assumption made in
>    the test may not be totally correct as the time lag can happen in different
>    subsystems inside the kernel for time tracking. I believe it is more a test problem
>    than a real kernel problem.
> 
>    There may be some slight discrepancy in how sleep and the tmpfs file system is
>    keeping track of time. If the first access is right at the beginning of a second
>    from the tmpfs perspective, the 2nd access may be at the end of that second, but
>    not flip to the next second yet. What I would suggest is to sleep a little more
>    like usleep(10 000) to make sure that it will flip to the next second before doing
>    the access.
> 
> Suggested-by: Waiman Long <llong@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   testcases/kernel/syscalls/mount/mount03.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
> index 60f9963da..98d5933b7 100644
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -122,7 +122,7 @@ static void test_file_dir_noatime(int update_fatime, int update_datime)
>   	SAFE_CLOSEDIR(test_dir);
>   	dir_atime = dir_st.st_atime;
>   
> -	sleep(1);
> +	usleep(1001000);
>   
>   	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
>   	SAFE_FSTAT(otfd, &st);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
