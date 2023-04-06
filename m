Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49850C7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 04:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1BE23CC75D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 06:52:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF11D3CA360
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 06:52:39 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C182F1000A43
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 06:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680756759; x=1712292759;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NdF+WHYyawL74nvixH95tA23q9FIne4cBLwMH/FKaFM=;
 b=cR+4tUglTCDc7EIU8qWLcWlN7uEqQoUcDeFExV+Tp3as2JKTuCY6IuR7
 WS/aIOXDhOH1QDRPFhjje2ySmf4RDg3wuVbiefMccXEdt1sCsFjRrzGWc
 hAaZ1e3hp/2awC0WAcG8It8So9K5Ss5oqOV6ctWBEhYYC4xEyykpuxfLe
 ejv8o333le/rFM1sgswVvWgWN3pR61mIwBn56evKXpM2G7PKlu/UEC0EL
 nTUpEDv6MlB1rQwgilzEC2FuH5hB+sG92mZcpyHSANv2UyUr+WKKtCIMg
 XsyTQag3f/YeCx/WfzmOtWhxsFLDfFpl+q9bHYs682Bodo40MrJr8/bJs Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="81205706"
X-IronPort-AV: E=Sophos;i="5.98,322,1673881200"; d="scan'208";a="81205706"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 13:52:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDdM+4cAUHPMN0xjd5sjMfetOJ1aA/HGWyNLmR2QOLnwjVq7p/lOum8IZo2ZZ+aTGUT9FZVokbGtl70ExJLoSanJ3Uu+hiVaRXDVfj+dsAXgd6DPOAWER8JlyQlRAnCxsSV9Hf6rTi3eNtBWNIp+HoxK0xN02k9bm6S67dBcgL+aZuC25ADN0qAYmHBSDf27I4sMYdGyRwwxn54l0MXL6sHAirbEHHlyvsIXC5XcfarRxXxOWOtw2rQ+x6fTmpoWb8+E0gyLjaP9CW0A9igwsyZ3uRQBxDYnCK4aGIcBsXtGa+RZb5npq8OU0akhS0lj1NWbaeWOJ3ali76oHPU7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdF+WHYyawL74nvixH95tA23q9FIne4cBLwMH/FKaFM=;
 b=HG8JbQ1KSpbHGfJJoIzFJQoT5hSWYMV44UXT7uP8hQAOW40yfeyDIsiueFFSmNe7z5bLoICbHBg1L/52HgaBlxoUHnGtRv0sKlXEpeDtb0dHr7owozQ/n21Q0vi4gAYOB/a/DXs/x80tfTIioWV7KFBR50FC1werBL2SGxYR/b3lOiKQsi489UeKnuDUuvbu6bR7XiZDqmayZgX0fJ63FY7RViwS5RGx2xCLmf7mMvXx3tVBgvD8/2DAisTnejq3SWEv+GJncI0zj5593A5VVuKjmusOhH3TTIsWkDP0cszCts+n/mHWy6WBpGfQq7DBWBu+JZF3ZV20xbaEXOeDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB8366.jpnprd01.prod.outlook.com (2603:1096:604:191::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 04:52:33 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 04:52:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v3 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZZsdz0DLISSCHr0Og+GVYTaNlpK8bsfOAgAIHrwA=
Date: Thu, 6 Apr 2023 04:52:33 +0000
Message-ID: <8012318b-7175-d685-f24e-e0feabb85d2f@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680593430-14728-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230404215231.GA884@sol.localdomain>
In-Reply-To: <20230404215231.GA884@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB8366:EE_
x-ms-office365-filtering-correlation-id: 4d75e584-2dae-4e08-362b-08db365abc3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBjQ2O/HZtjNLrpVxBwe2Zh12SmwTx0TMrb/4wcih4w/ReyDFJL8tTlV7vK28OUemOX2lzkNCEqB5S1rOHT0z0kwOaatAvYsen1B0KsqruTLHEmBnSzvtOBQroGlpadI257WN5ITYpxepoFxgPmJFzIfef9n8+XZDZmOiKUoYFUf0HpWIQih9NjSP49p7q8RnWZu8P5Hsw1W5Z2U9kf5PC1ZZFLyEtB7uOVKFF9pCc/2/dyBBb3dVtOvaC/n+eQHYeLsFxZvgQYzE3EzxzZYWvO6Zb3sxrDXb25n4SaD5mnTDeyM6Y/9zkVFu4UhFMHV62lUaN8slDhfPS+scd0eWlC5KuoIbaQND1sjEJanO0vcbtPLT89srgA8c7m59NNiydda51Kd7E7A+J2ndDvJu2pEPtxTonEGTmj+iZ9Ffee+iskYU/BoJNyyANsc4yDAVFQnpRCl/DLa+K4t3lcv/ErJRIagrspGcKSTGbkuFulAaiDu3Ei1oNdKY9qECq7nx9I3eiI1eojrsqFd+ConmVTwtGbLZdgbAXe3mTeSMHC3SUP/tcD+S75jzYR+ijrJmxU+sfBVKAtQ2nPQf9aHTy3vxYuMTftVzya8qk36dDICxMgyY3GQttSw51UicjIsspFdRV3hfkeLXgZcvpTEc3RwzVrQusBbXAJsUWkr75njWrgP5Xx2RNrs0xdT1Z4P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(1590799018)(451199021)(2906002)(31686004)(83380400001)(5660300002)(8936002)(1580799015)(82960400001)(2616005)(41300700001)(122000001)(6512007)(38100700002)(186003)(8676002)(4326008)(6916009)(64756008)(66476007)(66946007)(66446008)(76116006)(66556008)(6506007)(91956017)(31696002)(85182001)(26005)(38070700005)(36756003)(316002)(6486002)(478600001)(86362001)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWo0ZEZqKzd0cVF5dDdyNlVhWUg4UzFyT2F3QW80Q2FUMnlqRldKMzE3MXM4?=
 =?utf-8?B?cUp3TmJZMVVBdHV6QnBQUEhCZ1pVcDhBczh1VUJlZHA5MFB4YjM3Yi8xSGRm?=
 =?utf-8?B?Tmo4cURBMno2Z0xNbEE2TXBrN2YwNjNrTFQ2b0tRaHc1ajBzcVczcXBTYnBQ?=
 =?utf-8?B?Wmczd3B5OXBBUnZVelRkSG56V0YxUVJ2YjhJWmQ4dHo5L0lJdkFHWms3akdj?=
 =?utf-8?B?czhXUTdVUHBpbUVaamZpWFZ6VlA3UGQ1a0pJYlNvY0RRTUpYRElmSmEwaVly?=
 =?utf-8?B?QnNWSHZpdVlrVTFFNFpxQVQ2cWxDMlJ1ZXR4eW5QNHRicDZPY2Zram4veGpN?=
 =?utf-8?B?YjA4SURlWnhTVlErRlVBSmpGcSt1TytFVE44OU8yN2xZQVY0L1BRamVTWUtM?=
 =?utf-8?B?VDdySVRnMzlhckdjMlhwR1NIKytDT0pQb1ZFYjQ2TTdmdzBBMVpPb2VJdUNn?=
 =?utf-8?B?S3JiVVdYZkVyS1FKbFQwU3RCQk9xRkNZeWQ3MUg4cExuWDR5b01vSU43YTlV?=
 =?utf-8?B?WThUV3JROVVKbnV2Qk01ZllVTDFVQVFycUhndktwTm9CWTk4WEVzdEowR3B4?=
 =?utf-8?B?NDZPR2YxVjBCTDdMelJobUxGamZpMkl3R0xNMmN5L09tRXBGOWhDZUpDWis4?=
 =?utf-8?B?OVdOSFJVL1BDazFucDYxalhTQUJzR3MzbmY3MUx6Qyt4WTZIRVFRT0tPRTQz?=
 =?utf-8?B?c3grWXZDY3kzNVpuN1ZsaHlDd3MxU1NoWnJEL1pnOS9DbUdWMmhRNlZ6dGZl?=
 =?utf-8?B?Qlp3SzlrRW1DTWNBeWNXWTRYRnBQeEoxUkVpa0t0RHcwdk5JWGdYRXZlKzIy?=
 =?utf-8?B?YXdzSXVVK3NrK01rN21ITnJqQWYyNUxyL0NxcVZveTRpWGJVNDlEbVJYeDhQ?=
 =?utf-8?B?NGZXMkxoYlNhZWpKMDBPR3Q4MlFXWldtQW1SZXQ5TmVNb2ZBRFdlRytjY2FX?=
 =?utf-8?B?QUtiSk04Zkc1dDR3ZkFLRWV1Nzh2TlpEZzN4SDVIRkM4QWRxUG1PenA3VXMx?=
 =?utf-8?B?MjdtK2FtbStiQTJiRVRZS0MxRzF5eTVQYjdldFRVdGFOOEVydnIvN2R2WkF1?=
 =?utf-8?B?dXI2MjUxdUZVOFp3dU5rc0kxaG1hR2JPYUJCUXpRZFMyVHpJdnFramhTUGRR?=
 =?utf-8?B?ekl2RVU2MWRhRUdiaEVPRllTNmFRem5sRWFhcEQ3SThNWkpqTTdCT0ZvL1Ex?=
 =?utf-8?B?MFVtOWl0bnBhZ0V5MXpJM1NKWW5vS2ROcEo0Wi9Hd1dIYlp1RFA3TEFINGVV?=
 =?utf-8?B?VGQ2Z205YXRpL242QzYzUm8wbUN5M1ZyR2FHcVFqL2V6aTJJbEcydnlNa25J?=
 =?utf-8?B?V1ZDc2dIS1I4bndaZzJWaHRJczJucml3bXBzbDBERXZrMWxHcEFMaHR0Wjk0?=
 =?utf-8?B?K2ZGMHlxZGc3RGhYUjBCMGVmei9GaFptejUvUlFFTXNVdWcvVklGN2RPYy9a?=
 =?utf-8?B?dUFJMXphcjJQTnJDU256d280d3VtbkFlNklnZTd0VS92YTFoQUd1MkNPU1VM?=
 =?utf-8?B?MmxKQUJHZENxdVNvU3FkL2gzRjdoUHVzUE9tMjF5aU1PQ2x6Zk1YNko1UlA1?=
 =?utf-8?B?L0U0SU9uK2oxSGtKMVhJOTNxK0JrUnRPVi9qSjhmaWg4RHl6ZVF5cDV1cnQ0?=
 =?utf-8?B?REZCeWpYUDVRcGdPU2FpMjJWLzlYbHNqdVUxVk5mcGFVcmlvWnFlb0JpMWty?=
 =?utf-8?B?UkZ1b3J3WXprQkwrY1EybUJkMWlRWjZoQ2VBUXp6dklJVlhGRG5iVzBKbFhh?=
 =?utf-8?B?NFlzbStRdFYxTmtyMlZvSnB2RVhhOEs3aGdKY2tiUDJKT3FBdzRHNm1tUXNy?=
 =?utf-8?B?UGI2U1o5NjlpbDVPUFZNTmVaYXVaYWRMSGRCWE02RjdkQU9NMjhQR2VXRWMy?=
 =?utf-8?B?KzZpRjN1OFZaaklCS3Y2aWZCejM4bEpRK3lVd3htNWdPM0pMVlRWSUR2N3Qy?=
 =?utf-8?B?Syt2N2lDVXlId0FaRnA2Q1VtYmNGSXVjakNTNXpIbTd6ckVYcTMxNlhNcTV2?=
 =?utf-8?B?L1VVTDJjMEFDekFycTA4U2lpRGlYc09IY24waVE2WWo2eS9qR1VZdWdveUN0?=
 =?utf-8?B?MjhVMjNqRjdWbnQ5a2NSYURYU3VnRGJ4RGExbGl1Tmc4NmJtOFJHeUVRYVRk?=
 =?utf-8?B?UUZ5NXdpYUlkQWh4RUJqSi8yOVpndlhNa3B1bnlRN0NzcEZuL2xWRmJiOG5Z?=
 =?utf-8?B?WUE9PQ==?=
Content-ID: <E8FD840FB9E8C04E958DB8EE041F6B40@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XVB6mXfWeocH1z8Gn7S6RdCQueHmAC25NqaDWdegopWk2gEnk3WP/Qw9GxseEbyQ3y1Uq1wBYRzGjQdlxTNKb+dQsJE5vGxmsxq1WkSSUlzMRsK7gvEXle3noC08MehuR8tgXVO9RL8wQBB7jpIQi94CNV7OxgzUIdpxAU6TLoi52pQHj3ptnR96/tvI4qyT+izhqHL/XBKBOnbed/97nxBNCBX7I0AHJPS2OB97JCREvsfYgM3FqxM03gXfT+fNYdeVpray9e+WoqK8YlSfyMmsNLamqFFlPWA4/xjCkAqh9AZjhM4t012XwTdOvTYdaCXi/YbL08fMZNdcR8i5yEL9pWSfjqzA3O5abrLQor8v7GASWtL74a8+RnemfaIp9Rn7qfLzlBNn0+2Pwyrqu+kkTBzhsUQ8fj9uDpasIK0O6OQ5jSkAwN7aJ2ZlsT7Z5qn33Y/QpP2jg4WcYaT7YXA1+7drFdLKs7NZh1NLuTX6oOfmEUjvbPRxat0Ag93fCfIO09nhxVnJvo3Twh/MDan+Qpg9JOei5shuOaPyqO1RNBRiwGt1Fn9HSwT09ZUNjB3FpttPTLQvnKUquBc3xUiy/Eh9M9sp3qipfmxw/083WcDdjUYfb/tM6ot4gCwAecq0ib5WS8sGRKFJH2Pdo+lyMnIk7CwyVo5om6xiXRXT9D7aeo3KQ1g4+GQDT9KJPHWD7Rz7KREbH7yzDrLXdLSGcEd2CXRF0Gj/FGk63ORrouM43JbfLgxHqMa3yIYcSBByjQ/k9RxNektena3HilbX4JS8Pzs0YIl9tiXEJHo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d75e584-2dae-4e08-362b-08db365abc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 04:52:33.5580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW0BxJcIra6wYekMS/0C9Y7mqrgqe6zEw7xlixwBn7W4FD0QYrfkJ2RZjz3n0L7XeyPQELxwL8ULcrG+6vMUzinj4+LcDcY0/37PtzJMeHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8366
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQpvbiAyMDIzLzA0LzA1IDU6NTIsIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4gT24gVHVlLCBBcHIg
MDQsIDIwMjMgYXQgMDM6MzA6MjhQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IE9uIGV4dDQs
IGZpbGVzIHRoYXQgdXNlIGNlcnRhaW4gZmlsZXN5c3RlbSBmZWF0dXJlcyAoZGF0YSBqb3VybmFs
bGluZywNCj4+IGVuY3J5cHRpb24sIGFuZCB2ZXJpdHkpIGZhbGwgYmFjayB0byBidWZmZXJlZCBJ
L08uIEJ1dCBsdHAgZG9lc24ndCB1c2UNCj4+IHRoZXNlIGZlYXR1cmVzIGJ5IGRlZmF1bHQsIFNv
IEkgdGhpbmsgZGlvIHNob3VsZCBub3QgZmFsbCBiYWNrIHRvDQo+PiBidWZmZXJlZCBJL08uDQo+
IA0KPiBQbGVhc2UgZG9jdW1lbnQgdGhpcyBpbiB0aGUgY29kZSBpdHNlbGYuDQoNCk9LLg0KDQo+
IA0KPj4gK3N0YXRpYyB2b2lkIHZlcmlmeV9zdGF0eCh2b2lkKQ0KPj4gK3sNCj4+ICsJc3RydWN0
IHN0YXR4IGJ1ZjsNCj4+ICsNCj4+ICsJbWVtc2V0KCZidWYsIDAsIHNpemVvZihidWYpKTsNCj4g
DQo+IFRoZXJlIGlzIG5vIG5lZWQgZm9yIHRoaXMgbWVtc2V0IHRvIDAuDQoNCllFUy4NCj4gDQo+
PiArCWlmIChidWYuc3R4X2Rpb19tZW1fYWxpZ24gIT0gMCkNCj4+ICsJCXRzdF9yZXMoVFBBU1Ms
ICJzdHhfZGlvX21lbV9hbGlnbjoldSIsIGJ1Zi5zdHhfZGlvX21lbV9hbGlnbik7DQo+PiArCWVs
c2UNCj4+ICsJCXRzdF9yZXMoVEZBSUwsICJkb24ndCBnZXQgc3R4X2Rpb19tZW1fYWxpZ24gb24g
c3VwcG9ydGVkIGRpbyBmcyIpOw0KPj4gKw0KPj4gKwlpZiAoYnVmLnN0eF9kaW9fb2Zmc2V0X2Fs
aWduICE9IDApDQo+PiArCQl0c3RfcmVzKFRQQVNTLCAic3R4X2Rpb19vZmZzZXRfYWxpZ246JXUi
LCBidWYuc3R4X2Rpb19vZmZzZXRfYWxpZ24pOw0KPj4gKwllbHNlDQo+PiArCQl0c3RfcmVzKFRG
QUlMLCAiZG9uJ3QgZ2V0IHN0eF9kaW9fb2Zmc2V0X2FsaWduIG9uIHN1cHBvcnRlZCBkaW8gZnMi
KTsNCj4gDQo+IFBsZWFzZSBsZWF2ZSBhIHNwYWNlIGJldHdlZW4gOiBhbmQgJXUuDQoNCkdvb2Qg
Y2F0Y2guDQo+IA0KPj4gKwlpZiAoKGJ1Zi5zdHhfbWFzayAmIFNUQVRYX0RJT0FMSUdOKSkgew0K
PiANCj4gVW5uZWNlc3NhcnkgcGFyZW50aGVzZXMNCg0KWWVzLA0KPiANCj4+ICsJCXRzdF9yZXMo
VEZBSUwsICJTVEFUWF9ESU9BTElHTiBtYXNrIHJldHVybiBldmVuIG5vdCByZXF1ZXN0Iik7DQo+
PiArCQlyZXR1cm47DQo+PiArCX0NCj4gDQo+IFRoaXMgcGFydCBpcyBub3QgYSB2YWxpZCB0ZXN0
LiAgUGxlYXNlIHNlZSB0aGUgc3RhdHgoMikgbWFudWFsIHBhZ2U6DQo+IA0KPiAgICAgICAgICJJ
dCBzaG91bGQgYmUgbm90ZWQgdGhhdCB0aGUga2VybmVsIG1heSByZXR1cm4gZmllbGRzIHRoYXQg
IHdlcmVuJ3QgIHJl4oCQDQo+ICAgICAgICAgcXVlc3RlZCBhbmQgbWF5IGZhaWwgdG8gcmV0dXJu
IGZpZWxkcyB0aGF0IHdlcmUgcmVxdWVzdGVkLCBkZXBlbmRpbmcgb24NCj4gICAgICAgICB3aGF0
IHRoZSBiYWNraW5nIGZpbGVzeXN0ZW0gc3VwcG9ydHMuICAoRmllbGRzIHRoYXQgIGFyZSAgZ2l2
ZW4gIHZhbHVlcw0KPiAgICAgICAgIGRlc3BpdGUgIGJlaW5nICB1bnJlcXVlc3RlZCAgY2FuICBq
dXN0ICBiZSAgaWdub3JlZC4pICAgSW4gZWl0aGVyIGNhc2UsDQo+ICAgICAgICAgc3R4X21hc2sg
d2lsbCBub3QgYmUgZXF1YWwgbWFzay4iDQoNCk9LLiBXaWxsIHJlbW92ZS4NCj4gDQo+PiArc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkNCj4+ICt7DQo+PiArCWlmIChzdHJjbXAodHN0X2RldmljZS0+
ZnNfdHlwZSwgInhmcyIpICYmIHN0cmNtcCh0c3RfZGV2aWNlLT5mc190eXBlLCAiZXh0NCIpKQ0K
Pj4gKwkJdHN0X2JyayhUQ09ORiwgIlRoaXMgdGVzdCBvbmx5IHN1cHBvcnRzIGV4dDQgYW5kIHhm
cyIpOw0KPj4gKw0KPj4gKwlTQUZFX0ZJTEVfUFJJTlRGKFRFU1RGSUxFLCAiQUFBQSIpOw0KPj4g
KwlmZCA9IG9wZW4oVEVTVEZJTEUsIE9fUkRXUiB8IE9fRElSRUNUKTsNCj4+ICsJaWYgKGZkID09
IC0xICYmIGVycm5vID09IEVJTlZBTCkNCj4+ICsJCXRzdF9icmsoVENPTkYsICJUaGUgcmVndWxh
ciBmaWxlIGlzIG5vdCBvbiBhIGZpbGVzeXN0ZW0gdGhhdCBzdXBwb3J0IERJTyIpOw0KPj4gK30N
Cj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpDQo+PiArew0KPj4gKwlpZiAoZmQg
PiAtMSkNCj4+ICsJCVNBRkVfQ0xPU0UoZmQpOw0KPj4gK30NCj4gDQo+IFNob3VsZG4ndCAnZmQn
IGp1c3QgYmUgYSBsb2NhbCB2YXJpYWJsZSBpbiBzZXR1cCgpPw0KDQpZZXMuDQo+IA0KPj4gKyNl
bHNlDQo+PiArVFNUX1RFU1RfVENPTkYoInRlc3QgcmVxdWlyZXMgc3RydWN0IHN0YXR4IHRvIGhh
dmUgdGhlIHN0eF9kaW9fbWVtX2FsaWduIGZpZWxkcyIpOw0KPj4gKyNlbmRpZg0KPiANCj4gTFRQ
IGFscmVhZHkgaGFzIGl0cyBvd24gZGVmaW5pdGlvbiBvZiBzdHJ1Y3Qgc3RhdHggaW4gaW5jbHVk
ZS9sYXBpL3N0YXQuaC4gIFNvLA0KPiB3aHkgaXMgaXQgbmVjZXNzYXJ5IHRvIHNraXAgdGhpcyB0
ZXN0IGlmIHRoZSBzeXN0ZW0gaGVhZGVycyBsYWNrIGFuIHVwLXRvLWRhdGUNCj4gZGVmaW5pdGlv
biBvZiBzdHJ1Y3Qgc3RhdHg/DQpJbiBhY3R1YWxseSwgbHRwIG93biBzdGF0eCBkZWZpbml0aW9u
IGFzIGJlbG93Og0KI2lmIGRlZmluZWQoSEFWRV9TVFJVQ1RfU1RBVFgpDQojaW5jbHVkZSA8c3lz
L3N0YXQuaD4NCiNlbHNlDQpzdHJ1Y3Qgc3RhdHggew0KICAgICAgICAgLyogMHgwMCAqLw0KICAg
ICAgICAgdWludDMyX3QgICAgICAgIHN0eF9tYXNrOw0KICAgICAgICAgdWludDMyX3QgICAgICAg
IHN0eF9ibGtzaXplOw0KICAgICAgICAgdWludDY0X3QgICAgICAgIHN0eF9hdHRyaWJ1dGVzOw0K
DQpTbyB3ZSBvbmx5IHVzZSBsdHAgb3duIHN0YXR4IHN0cnVjdCB3aGVuIHN5c3RlbSBoZWFkZXIg
ZmlsZSBzeXMvc3RhdHguaCANCmRvZXNuJ3QgaGF2ZSBzdGF0eCBzdHJ1Y3QuIElmIHBlb3BsZSB1
c2Ugb2xkIHN5c3RlbSBoZWFkZXIgZmlsZSwgaXQgDQpzdGlsbCB3aWxsIHJlcG9ydCBub24gZGVm
aW5lZCBzdHhfZGlvX21lbV9hbGlnbiBvciBzdHhfZGlvX29mZnNldF9hbGlnbi4NCg0KQmVzdCBS
ZWdhcmRzDQpZYW5nIFh1DQo+IA0KPiAtIEVyaWMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
