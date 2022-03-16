Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8324AC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 02:00:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC2263C932B
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 03:00:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8702D3C0611
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 03:00:09 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88F817DEB0A
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 03:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1647396007; x=1678932007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E8o55dxPWMowbyQYj7CiCI2bW16mMWgww3lC2272N4w=;
 b=hiwwkgWJTGmuFMWJU9elkZ8SR9YxjOYTBGThNEAuFxS36v7gMRzdAeUF
 G2I7ctqrEo5/ebSTDinTyZ7DJGX7jjix2NjrviMGqA4wthO9sSPNw5MYu
 q0cwhy8sdtTe7WyiHxZ5cilDP4WguWNEXazSn2BCaPXS4HWd68cvz0ydW
 GXIECBlm5juJooDj6/7hq1PNom/L2pt5jWppcavPjByH70h6Mk1xDhWzz
 pv6zP7BecKPZzyP5DTqTNGMkqK7TOMSVEfcK6YrknNzbYWuviH9BvZ6MC
 zghT0Wjp+J/oHJAB7WabqX1sqL45cABzLuuNuyhAl+lH9IE0TDem5gKuO g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="51632127"
X-IronPort-AV: E=Sophos;i="5.90,185,1643641200"; d="scan'208";a="51632127"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 11:00:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bihgKwUH8u7OfKPe3+YoIsyC4JK9COPkqk40vzDPV/KwIVLJaCpg6OCheXP/Y3OV7xyHN0c+90yT5qV01Q0mRxW+/AYl+h+bFHRIQPIAEGyrc98alm/zEq4GkfeoU5M6SjYToYrQi1gQkwcFgwCUcDl2YdAhTboK0bh4bTo0fiqZEsZ59mRlzwdVcEa9DKvr6m0NTx9Z+DzhjB64H36vCeNN9vopMQ2OZj9tUfOcwpN/MU14phMONfYvvWIz5cbe3mhcv3LjMJfVun3ziWCcy3LYGEAYU+kOq+nEesjpVxBFR1b2sAvD8vzSN5m5s75fxLUxscDz5A+rlkKYa/l5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8o55dxPWMowbyQYj7CiCI2bW16mMWgww3lC2272N4w=;
 b=JZL3HVT6C9K1NQMEsl8h8j2/EtTcpEnc9lv4nWX4SCua+QktgYAQMkm/xAtgG1hNHCvxbtuVFjgE4Jl9RDUf22gCITrksNzWWlH2BAANOutNKjMQER5SgD+ruVM1iSEc/opvFG7hYzTgHbhAvjeEYKn84L8vi2ARRnQF9K8QMgdfU9y47WP8+9d2zC3tF2V+WdPcbMJVuhMhR1MbIxNe3NzA4w78ccA+KWFQm7zFA8z5SYyfLMli3o+G7iv/QXOO+P1RJYTmRLt6juloJf9pvlpcVJLS+f6HW6QJZo0Bgq22oDuaA8TdjhprXaQj7oI4Ug+4bmV9vQ6Q5naB00wfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8o55dxPWMowbyQYj7CiCI2bW16mMWgww3lC2272N4w=;
 b=PZJyRC+AaPAt2BWFV7Trs+GiKRyh0qVukQsKtdW+ZAmh+/nMjNU9fkibesmKu3CWMbk99fGMlIdUiWSYNkk7/74s6WHk4+nT7Ivkr5VXp1cXtbythrN/CuUw2s291o0XLYsjJom3TxG603QwO6DQYMjsL8QkG1TtFoyAd8bN/vg=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2346.jpnprd01.prod.outlook.com (2603:1096:404:6e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 02:00:00 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 02:00:00 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v3 3/5] syscalls/quotactl04: add project quota test
 for non-xfs filesystem
Thread-Index: AQHYOJDgs60aQQN8L0CsSEoJuctsTKzBQiKA
Date: Wed, 16 Mar 2022 02:00:00 +0000
Message-ID: <623144C7.5010500@fujitsu.com>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-4-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <YjDKpuBVMuVUY/l6@pevik>
In-Reply-To: <YjDKpuBVMuVUY/l6@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 402f4a7b-50e8-4216-94c0-08da06f0adbf
x-ms-traffictypediagnostic: TY2PR01MB2346:EE_
x-microsoft-antispam-prvs: <TY2PR01MB23463BBB64BEC30ED910ADB9FD119@TY2PR01MB2346.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mSU1+0Cm1lVpEylbK6q0ryB6KANkkclGvMSmF7XhS9fTGsKdyibvHgdLTa+s2vpR68F/mQds73p/QwQsK09DbZu+rKUcU0VACkodrsHRZ0xV/j/CdnUil1I+u8QAMAQxOnlwFVWmMNuASkgZuUDJ/0AkLalPFqIL1HkpfXDcbX9SSKCYmATKVFLNR75RymE5CrgiNecw+eUo7Pev+Yurwsf3BWrrBBmC8q6lNJijI1R96BzxHfi3AZ4hJmacw8wCit1AOX8zUFIWICxH1xNmDo0BsGGI37L7y8iPKz/Ww1i+5cIxc5GUvBs7pWyELeMvjyVaf6WzMCFNV8qbzx+fQROHyBZOoWJ520uVn7pIkqW8XesCwjaSHAG0EIU5qgNdzZ+Y+31GFNEVFfBsMGfTr2nthNl2/4nuuxL9uIQK5n/RVpJMGH5y/ib2JcBaWd5ZYunxuqtvxnrGJq/JAFWJOIlqCMSmNf/gZ0iLGexzLOd1+0TDBNyVCWOSe5qzAShKQncw/ZnLN7VK6qnLBRmc0fEQpZOBO9QfRCYWhXbRxlW3YkZ9IqaF1x777zujVLePj4zk8Ls+CL1EeycOM9iZxm21UM4SyLlTcCTpaf/Cf8lhgqJMADsIlJf0kEgHOdvFOF44niL6k3SGoAAhvAV0nKfv6Cb8Y2aPWfpYJW7o40hBCwnNHQIBGtMHgUP0vCnzAkkVN6J02W4o1QrmOMS2Gg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(38070700005)(38100700002)(83380400001)(82960400001)(5660300002)(6486002)(508600001)(8936002)(4326008)(71200400001)(86362001)(6916009)(33656002)(316002)(66556008)(66946007)(66446008)(76116006)(8676002)(64756008)(91956017)(66476007)(2616005)(85182001)(36756003)(186003)(26005)(6506007)(6512007)(2906002)(15650500001)(87266011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dDNHaCtwY0RDNExIV25BeXNxVlZ0STZHcERmRFhYN3pFTE9TdGhhK09kZGxq?=
 =?gb2312?B?Mnluem14d1FuOFNMc3hSeWVBMWlpOVlrMFFiaWRzZGxnb0RCL0RKMzB1b0ps?=
 =?gb2312?B?MHhuRGgremw5S014dUJXeUg3SG1QVnhqNTBYOFFYWndNamN2QXkwOHR5eis1?=
 =?gb2312?B?LzBlcTYvT2JRemp3Wkd0ZmdKaGZtUGNPbGUrTk5Ddm15ZUlLVUlqZkVuTDQv?=
 =?gb2312?B?L3liaER2QUllS2dFckNPWmRBOFAvV1ZBM1YrOXF1bnRLRXF3eWphZ2xjMk8z?=
 =?gb2312?B?Nm5CdzlERmpoRDgrai9mSzNYVWNkMnl6UVpwa0huSUo3R1BHdVpFSCt3WFpt?=
 =?gb2312?B?bW13RTBVL2Qwbi8ybGxOQ2RPYnhJcGpOUzdyRUxWVTJaMFd1SnpvRkIyOXVT?=
 =?gb2312?B?MlFYUWdTeWo3NXVUWkxXZlRRanh4NXd0Ymt0YWpsNkhsR3V5bmhMdlN3RHlr?=
 =?gb2312?B?NlNsakY0cy9GNzRJQ2pQRWJ0VWNjNzFsYWhzNWVqUmFFcXZtL3RhWnNZOVJ2?=
 =?gb2312?B?bEhHdFVaRjBGMUlsbHkxeXJOK05yaXpqSGd5YjFUTk4rL1lEYWN3VkluWnd6?=
 =?gb2312?B?QW1DNTdiZS9ZUjVoTkcvTjNJeC9BSXB6Wnl2aHh5aXNodEpBV0U3ZmtpcWxW?=
 =?gb2312?B?WWE4enV4QTdTdml1UjREd1VUMTY5WU1TQ2dXK2xWa2sxS2RyNWl0S0ZxcnFh?=
 =?gb2312?B?SkZ6N1RocnhpTGhSMzJkN3daSm84bEtJdXNGTzQ4bjJ1TGhYRkI2a2x1ZWhi?=
 =?gb2312?B?a2Vsc0dwbkl6dUNHMmR6c204REoxa0hkU3A5WnNEdmpUN1hXcXpKMkw3b0lG?=
 =?gb2312?B?T2Rnay9IUk1zRnh4NWNYRnJXTGxFaS8wY1BsQVBmZnJicXA1MlcyeG5wYVIv?=
 =?gb2312?B?QkN3WTROMXQvVUo4Y3pGZUlidHl1MWhuTEVkdzhzZXF0V3RMeVhOQmJjSzdV?=
 =?gb2312?B?WHZrRmdDcFQrT0VpQ2kzNS81NHJkMmdockMwNVdseHRveS83aG1pdEdGSGtr?=
 =?gb2312?B?YjZnLzdNTWpvT1hqTzJKSHdCenJTVWFCV2VqdzdhWWVlNDFBY2ZpdlpBVHpy?=
 =?gb2312?B?Z3ZPMHhQSGdjekFiaGZaU3E1eVl4RkZLNUNBbHIwQ2RZWWpIOEtSdnZjYzIz?=
 =?gb2312?B?QjJsaEJJblFTelhmSVlXSGc2a3V6SEM1TDhYRlluNDNRdm9Qc1B1c01RWkl4?=
 =?gb2312?B?QjVnOVZYU0xFL2kwTlZ2WWt5V2RPaU9BQVR2MFRKdStpU0dqSGRVbVdoMmlS?=
 =?gb2312?B?aGdNVUVkUHZ6dDlKd2Y0My9odGUyTHZjZGtrd3VvR3k0eWhjY04xS2FMazBr?=
 =?gb2312?B?bmFpSC8rU0ZHWS9wWWxxVFVYUmNJaXpzU1lLN3lodVB2M04yMkxyY3QyS2xS?=
 =?gb2312?B?RUxMdStVZ3FselREb0pUUTBFcVZpR0xySXNCeUI3ZWNWQVc0aEtUMVBXUzBG?=
 =?gb2312?B?dXE4MW8rZHYzN25vQXFudE4wZ0x4SlQwa0FmakJ0SmRySkkvYkpkQ0VxanNm?=
 =?gb2312?B?a09oRjVlZGo5R0U5ZWJoL1lIam0xeklrTTRobXNndzhNb2JjRDJSNVBPZjlt?=
 =?gb2312?B?aHAxVWlyUFBNR0M1S0xOVTNVeDA5OEpYcFV5RGZEVzdTaTk3c0c1UXNkdTVJ?=
 =?gb2312?B?ZjVpK0VWUlVrQTY4R0R6elFlZ1pGcURFN3hHZjJaNUJmbHR4ZzMrS3haUWxl?=
 =?gb2312?B?MzdrNnh6L1F2dEI4MXZ3aTMwSzJXejYyeWZGZTcrcnpUOXIvaGMzbWc1M014?=
 =?gb2312?B?a3M4aTQ5eithTGZTcmgzU0ZzVmU4YXQzSE1nTE4xS0JNeGphRCtNREwzZ2FL?=
 =?gb2312?B?ZmhBb0dIK29WWXd1NFp4QUgxczFmbDIxVk5Ca3ZHanoxeGFDZFV0Q1V2NDJT?=
 =?gb2312?B?UlpKSlBUc3ZnTmRORUVwVCtCbkRSU2hIbzNKVkI5cUpVM1hBajJRUHNSclA3?=
 =?gb2312?B?WitPUmMyeFZ6eXB2VE9MMUxONHVMNi8wdU1sRDVidThWbTFNUWFERytiUmsx?=
 =?gb2312?Q?o0MCbkovDaPnmgXR4RVSO+JOECFKgk=3D?=
Content-ID: <1A2B61FC56AE624FA860190F2E37ADE1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402f4a7b-50e8-4216-94c0-08da06f0adbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 02:00:00.1871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoy7GprFPasD9q0DeAImN+x4Zk839CfglAKl9rv6rITbVoso8XcXuMJ1N/Qc7PSYPn2wMPPELo0tpV/X3n/RTmUVpFAURuHAJ5oeRCI7HMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2346
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/quotactl04: add project quota
 test for non-xfs filesystem
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
>> >  This is a variant about quotactl01. It is used to test project quota.
>> >  I split it into a new case instead of adding it in quotaclt01 because
>> >  two points:
>> >  1)before linux 4.10, ext4 doesn't support project quota
> ...
>> >  +	.min_kver = "4.10", /* commit 689c958cbe6b (ext4: add project quota support) */
> commit 689c958cbe6b is from v4.5-rc1. But you use Q_GETNEXTQUOTA, which is from
> 926132c0257a ("quota: add new quotactl Q_GETNEXTQUOTA") from v4.6-rc1.
Oh, I remember I use the following command to search linux tag
git tag --contains 689c958
v4.10
v4.10-rc1
v4.10-rc2
...
v4.5-rc1

I forgot to see the last v4.5-rc1. Sorry.
>
> Others looks to me quite old (before UAPI split in v3.7-rc1.
>
> Thus it could be .min_kver = "v4.5" for the rest (unless there is some other
> dependency). Or am I missing something? But maybe we just don't care.
I think we should fix this. I will send patch to fix these two problems.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
