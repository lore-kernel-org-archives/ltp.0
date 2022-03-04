Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9898C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:24:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9DE13CA36F
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 04:24:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83BCD3CA1EC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:24:24 +0100 (CET)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD5E31400E49
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646364264; x=1677900264;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9sUWx+06GflcwJgAPpWo5UXU0hrgCnjJ/ys6Z4HzhrU=;
 b=JW7jr8aUjQOz/HomxGF9hT+Q3NdTAqCvLL8da2Dyfnntct4ymAqWRrB9
 7tdQpK5uNct34vUJC1Vu1uChV2cakjNA7TP+GDM8uf0DadsxcmgebyFUK
 vIR2gdPt8oAn76g86SBuov8rkWlri9x5N7yvFfWq4ESnmfwLkZip4tfnc
 KoOoIOgleAKSzCwBnQiJjMwlM0wxX32UE+XUvyMfGOe6KCDqXmB6MTQ8h
 ibOo7NvMiox0gJvl8jtNk86wdepzb2h5W9zBHXhsZ7yxNTeTxAUoJFeD/
 ErhCupHo3mBSya6IbrWqrunXN6zqfGPPDfMQJXi81vJ/7LO+L7QE2dyrB w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="50823866"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; d="scan'208";a="50823866"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 12:24:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGBxsNuHFqhMwQ0OBBLN78Hvtay646g34Ky2k+BloXFWGgUe/qpfmx5XzFG//0bjZ9jHPn3mxAof+4nh5ccF+WBsim9PlcuUFKSM486aMKAH65meXDU07sXAtznTHNMPVKrDLPFbnIrLdGPf49GHCfQOqxExVwjXGriOtPpVrJCTF+pglLEJ9jJ6LGqJ0sCPBs9iDuXB9EYudbrheaZprZp3MbEFObenbh5uby4nRG9vDsWJS5YevC5l40h1YWITo1Mk9hdZf6B2kAFooQwhKUk6KFA0/c6mZ4FhJ6MJewn3nw7UExmEGJSDlV90DMGICH9e2SRAJT0anrVpDJIYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sUWx+06GflcwJgAPpWo5UXU0hrgCnjJ/ys6Z4HzhrU=;
 b=GDQmT8mGEqHl+bgG5SICAasZu+QF9hRTW4NxAJgLOZ19elju4VdwL+6NlffFxpICA/qN05kO6d2Vxg9ZgZ+V65wDgB3ie8vfPcvOss5fE2FT0XzwwRIAYdP1O22HYfuSnk2fTyT4oa9huTVie336NMIWZQjd9nzwNP8ALlJczRD9jmb+UwSejean+BSN2VQ5aFlEtik95iId3382TvlM9Az1qkjaDiN+uJmmAVXrDUGLVbTRct/a7w6xGM7bgcHyvqT4+ZUql83koxgxfLjWcmpEab1T5yY+6+81hhZw7fABSoZv26kvVkW4KzklQabe+YrTZ6Zd53vAeiJatElvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sUWx+06GflcwJgAPpWo5UXU0hrgCnjJ/ys6Z4HzhrU=;
 b=pBVySrKc/uUsvCQQSKcrR/yqtX/sZEr3/8vBMZBRoiK0MlDCQSeaqu+s09G1pVKZHtauQl0848J+ncman9hIOu1AvMuAg6oQJmIPUZkuIHTt6bwUwuaSXZ6CrcGVv4IxtfJEF1jtGAAuUVtIESvYbGdR5j7HNjl/QTbl3UgePD4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB3637.jpnprd01.prod.outlook.com (2603:1096:604:49::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 4 Mar
 2022 03:24:17 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 03:24:17 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
Thread-Index: AQHYLtx4CjNbvmY4GEm3jKnRYeFwH6ytsXoAgADfuQA=
Date: Fri, 4 Mar 2022 03:24:17 +0000
Message-ID: <6221869A.9040109@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik>
In-Reply-To: <YiDK7g1pwLj2aXBD@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c0fe332-4b88-4dcd-5985-08d9fd8e775c
x-ms-traffictypediagnostic: OSBPR01MB3637:EE_
x-microsoft-antispam-prvs: <OSBPR01MB36375245F26925E6D14A6C33FD059@OSBPR01MB3637.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4hOkuHmWVi1ifh7sZoZ0JsJGBkODa68hXCa22d/cVywwKkw6B2SYTxs6RM97fgywSLiUG2uumU92UX4cwxQ0YZQUg4FOLtZmjjDPq1DjGYufBVJ7Hd9gAPO7QUPKTEF/OhDxKyekBlPb36uV59UTbjDYm9FI+VF2tbxAu/6kOKfqGU0buV/9nxalGyKrqyWKc7oiA0LQKWq34n5gxaNm/7dZhcqGmQrlRmFVkqdyFOICYJY95FZrC8pm+WvMse2dB9AGiopZC1YJkzwaTOThqGy1g7NZX2BDjXJ5YYRqux11e1rXKF8ilm15a81AFS5k6lrqJUUNVYj5FqvwTZb8/fjiMcMYm+qsqWWNyeCf0xDgq/gCI5feJ8xxhnKqRJDn4zQ63N5S+Pj5rn+Lc5ZMkpGwuat0Clx26KmCAwG1iUQXIX1fLrbJOWlTlEhk5JCj5asK+lZ/5lrbOLe0PVuwZNVU16hTMuqSWNdYcu+bNZIUJ3LuGWfwG+oOLfs49J3yifaFRxbyUrQT2Lm9FjYzl4HXA/KmaAVrSSuDHpqxsWforVu+28upmNQ+vPZCEX+aWMisHt1cCMW2wScIsqWEW2emkB3wHPdn+ispu+60y3X7AyLHLgyUMcoZYV4X5P+H2x2ZYa6GM29jLvkYJCuZmlvLPg+AKP/mmaTf4RTrgh0LIY8qgmfLRHqA8KJ6tqaR7Hc/168eC+Lkq9lpckhAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(82960400001)(4326008)(5660300002)(38100700002)(87266011)(6506007)(86362001)(2906002)(83380400001)(6512007)(38070700005)(8936002)(4744005)(508600001)(66946007)(6486002)(66446008)(8676002)(66476007)(66556008)(64756008)(91956017)(76116006)(316002)(6916009)(71200400001)(122000001)(26005)(85182001)(33656002)(186003)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TE8xbnNIN0VjN1krMTZhTmtzUi81WWQwUEx0OW1oeHFkMW9pYzVJZUVpVU9v?=
 =?gb2312?B?blJIclNXcWFBTm9SbGpBVWdpaFAwM09YbzR6S0VGODFmb3FMRE1VUHJSSzAx?=
 =?gb2312?B?S1FXT0M0TjFQWnkzQXk1eSs2akxXQ01YV3VFVVFROWs3SnVtL2N3THorY0lr?=
 =?gb2312?B?Z1VpR2RWU0FnNStBb1ZvOGtKaFdJeDhYSzJteEtSL3FVWmZvblFkSXlGaEMv?=
 =?gb2312?B?b3lvMmVGQ0pDY2lrSkJEY1VCRWpEck1rWHRiNzdZMkNYUDU3Z2lMa3pxbllu?=
 =?gb2312?B?akdhRlBRbUZPdUEvOHdpTzlnSjFTOUdaaERNSHNsUUxmOEZzUGpmVFczaTEv?=
 =?gb2312?B?VkI2WlpZR3VVZkZvWEpEZkdwc2FicmU4Nmo2YjJ4VW5OeWFCNWo2UEFWMjFp?=
 =?gb2312?B?MERnUDNFbitjQnJqa3Z5cjJVTll0VUtTR1pjc0FMK2wrQkt4VUxUSENKbzd6?=
 =?gb2312?B?L2l3T254NXYyMFJRaytDS3pTY2VJSTROM2ZxMU1YUmx1cTN3S01zY3hWV1k4?=
 =?gb2312?B?VDhIMjM2VWI0YlphbnltTzVmUFFZWWpkcUpWYzdxc21PMFIwOU9YQy9QWEVU?=
 =?gb2312?B?dGRtNVRBTTFHd2pHWm1kcFNkcnhsYXdzeldkUEU2dVpDWTBkWVBCc0ROQkhR?=
 =?gb2312?B?YkxtaFdtZko2QURqZTQvUXp4THRPOTVxWGd3S0tScjcwWXR3UW4vR08rV3BL?=
 =?gb2312?B?d1BYNy9jbTQwYUluU0tVZXU4SUdNanVaWU5RdmFSRlMvQzNXa0dFUGNLcEVD?=
 =?gb2312?B?SlZOeHRud1k2TDltMjhnTG1OTlNLUTZwdDdhcnVIL0dJVEY0MkluR2VTam1D?=
 =?gb2312?B?YlJSWUxHM0JUVW9FNUJwT0YzbzhiSzhOWjVNRHpjN1laNFlIWldQWHQ4TVov?=
 =?gb2312?B?LzBObzEzUURFTU0ySUNDZkZ1b0c4TStMZklPOW1OUmw4cGpRMWFMUXVSYlFo?=
 =?gb2312?B?VUFiRGtucVJHSGk2a0pHS1QyQlNJdEV5YW9UNDk0MzM5d1F5VFVDMjVTSnJS?=
 =?gb2312?B?bGhnL2RQTVJjWkovcnFDM2lDL3RNeEtVbEdJVEV2SC9qWnhJUTJ6ZzBXc2dH?=
 =?gb2312?B?Mm9rWmM5aUdaNHdWVDFnaGpJVXVRZi9KWUlvUVY5am1MdXg4MGl0Y3FTVHlZ?=
 =?gb2312?B?MTBGMDhuS2hQbThuSWpwaGNmWUxYK3ZPbXpGR1dob2VMRDM3bTUzc21sNGww?=
 =?gb2312?B?TjE5TDlEMHdETzNGNm5RS2E0bmF6NzFLZUgyaCtqV1dTT3RjekRRaFRKZkZY?=
 =?gb2312?B?TmFlOXhhWEFtcjN1TkpzTkQ5NTdTdGkrZGRUQyt3NzVqMWttTi9NcFhDSUw1?=
 =?gb2312?B?My9idUl6ZktLemJEWHN6aHVSK2ZtRmxaTHFqL05aWWd5cjB1Qmk2VjVTUDVF?=
 =?gb2312?B?UFp6VmpFZjlvNmtVM0RFZ0YvS05TN2ZncytTa1ViaU5SNFZQQlN5aVFoTWg1?=
 =?gb2312?B?RXc4RjNQQVBvcEJsOVE5ZGozQnBNd2dabHR2S3BJaFFLc0lhZGR3MUJjYjNJ?=
 =?gb2312?B?akYwTDBlcGNqTXhBaktDSDVOWHlWV3dnVHFmRTZpNlNPVjZoK3pGcGlJSDdh?=
 =?gb2312?B?S3VpYUpCayt4d1FQTDlwMW5pTnNrc1hqMHREdmt4L1g1QmhSMEQrVlp1b2Rr?=
 =?gb2312?B?Q1c5QlhxeE1xcnI2UlNLSG9FdXQ1bFYxVGx3d0xsMk9tT0FpbXdQSlozUkUy?=
 =?gb2312?B?VVZSWU4yVVVuUnExcmwzVUIvWEJaMEtFV1FKa2xKRmFFSVNZem5BNnEzUzJH?=
 =?gb2312?B?cmp2R3ZLYnVqaDhjaGw5eVVvdWVka1A2d1YxREs1QU5EQW40MjFlRFV0Q1Ew?=
 =?gb2312?B?SGJCL044YUlGM1F2UzRpS1NSN3ExeERKdFFzTGdZd3FPdDAvMEVRejZFN3dN?=
 =?gb2312?B?VFJqcUN6UDR0VldCT1F4VGZ6TkpySXh1bkcyM1JXRkU1VGFEOTdxOHRVVVRI?=
 =?gb2312?B?UngraGp4TlBxREFTZEsrRFBVUjFOaDMxQ25tVDVTczVuWXlzdjJBQlZPNHVJ?=
 =?gb2312?B?RGR0ZlYxVGg5QVZST1lEMDV0ZnNneHQ3Zm5UT2J4eUdEN1R5ck5iSmlCdHhQ?=
 =?gb2312?B?VlR4QmlHQ250YXFiUUVOOFlRdVZiSWZUWExuKzFsNENIUHJ3TWUyZEtrZ1lU?=
 =?gb2312?B?UHNUQVV2aTkyd2hwRzhUZXNwOHcyNGppZXlCTllRTC85ekcxbmdUanRoQjBw?=
 =?gb2312?B?dXQrd2dFdVloRHh3akpRdEd5SzJlbmt1dWpDbWZrOHY2UDVaY2VwajlERlg2?=
 =?gb2312?Q?W2XPerxpxaj2kpkNaMluGzoaVpWM7ETRm5a9+8nVoM=3D?=
Content-ID: <8C461CE1DD9AA74196FCF6F70ACACFCE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0fe332-4b88-4dcd-5985-08d9fd8e775c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 03:24:17.8578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TuO/OeCSlmlR0qxwB4Ej2nEFxPQ1pU3Ae3OCFRikcI7//ZnFRVKnJwEkKZBDPoQplxyNnXU1Q3z59/1C0BIekcRpi2KwPy9cLgmWUzYIxok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3637
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
>> On centos7.9ga, I still hit another crash problem because of use-after-free in
>> prb_retire_rx_blk_timer_expired(). Since we free it when timer expired, so this
>> case will crash after we print TPASS info.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> LGTM.
> I tested two old kernels, the one with patch survives, the other got reboot.
>
> BTW funny enough the affected system manages to print "TPASS: Nothing bad
> happened, probably" before reboot :).
Yes, it crash when timer expired, so it will print TPASS before reboot. 
Also, I try sleep 10ms, but it still print TPASS and reboot after serval 
seconds.

I have wrote it in my commit message, so this should  be friendly for 
user to know this situation.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
