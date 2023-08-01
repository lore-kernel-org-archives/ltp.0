Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C8AC001DF
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 11:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3958F3CDB95
	for <ltp@archiver.kernel.org>; Tue,  1 Aug 2023 13:04:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A3A23CC397
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 13:04:27 +0200 (CEST)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F1471A00FA7
 for <ltp@lists.linux.it>; Tue,  1 Aug 2023 13:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1690887867; x=1722423867;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=mqMdy/+kCE5l0YrlclAH7/CG//oZKGYBPkhp8d4gWYA=;
 b=YUdzYJCUOJhJceFyyYQNU915Mgs5wqbiCTgamK2rYGpf+F/SGL6vqfVP
 4U1BNacELmDekTAlmvyTXIECziOd6DUx3wmrTYxIKNmO1FkEz55R+L/a/
 CWWrZ/y09+mmCoETfjzI3CmJWUOXH8Qvim7+WFBQ3TTXQ854hGa28Xx4l
 FdqWJlshQcOmLCu0DW2SA2PDvLXBqfTiJ/8/qj2VDC23bxJ4/gAwivrId
 RYSRrOuZZL2U9JfiZHjFm/2bC1w8xgac6g7VaLHEmsm5bgf9nk2PSwvfl
 6LVQOZXbfQqJu/SWpZRHKWSSFujmKbyBb5tcRd4XHjK0AASVvgoPdhdIu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="94100599"
X-IronPort-AV: E=Sophos;i="6.01,246,1684767600"; d="scan'208,217";a="94100599"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 20:04:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBUsO5Z20KSYJfjE9bgOT8l6mr3Ez+5YaWcCu6UZ8pWIGniJbcUwzDeze6DFJvr0B5P3VAYfXM0YugX3QOPg2gBCLGll/Vsh57CUUjD+7pic8PeHsJtJHzSFUOQVMI3RpO4+XPtzLMiQNaTDw9vTANkumzMYfDtgobHDt4WhGLO5TJJMU8cFO4J5rt+Sn9lQjav5m7aLvpcLFV7VDbZXRVevT9AY2EOgknZtt8fm6j7J0zlW8AdaTXmIu/DSKFGAnNt3XaD3AeVgv1ZdwJw9QW9Pob2mKSKnb0xjj7ukq2AmVCZRpyDN6+w3eDw2Rq1AATlg8tmCL10bk9LNFljDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqMdy/+kCE5l0YrlclAH7/CG//oZKGYBPkhp8d4gWYA=;
 b=QLKNtTAiTEY7CFumUPPv+Jf+Ga88vS0hkNNN3LjPHUbEe2HqvhvuJc6qp8Vzilv74bCq01iyU0TW3wA9sJgy2byAZWyhRhW3O1qYCxRYG3BtaORfZaMOVabGe6gfkA5flfRzzrSN9CKBNOAL8umih7GI5H9trEBuo84niSLXK4Yuew6AP7N/NKIQU+652BgEpTgm3pa5bRMgQWk3vFOi/sWfpVvwAc9jouS/ex76bPfq7jcoobRbP9Hmng0kx9TGhiW93pn+ZEJarwQOgvrZrbzsuaCqqe1yZxKrQM4eYRJCwd47FEFJI0eTTF1EDWUS/GOJZGqtWdCXt4BkXPUcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB9878.jpnprd01.prod.outlook.com (2603:1096:400:20e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 11:04:20 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::4362:cc0f:5d7e:dba]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::4362:cc0f:5d7e:dba%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 11:04:20 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
Thread-Index: AQHZuie/X7uu0dWez0i/2SBfh7GOEq/MC2YAgAlQHoA=
Date: Tue, 1 Aug 2023 11:04:20 +0000
Message-ID: <f850fa93-7c08-6dd9-8330-67639a962a4e@fujitsu.com>
References: <1689760756-865-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1689760756-865-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZMEWwCwC0DPrtdAi@yuki>
In-Reply-To: <ZMEWwCwC0DPrtdAi@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB9878:EE_
x-ms-office365-filtering-correlation-id: d1bc6d25-0d5f-4b58-dbf0-08db927f0e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFJ9G9Vg4t5I6H1SpY6qrfuQXP0QqQV1kYA1Np8IM04R2aoQ0ADmzSF7XxPsXY9+OKK/W+tBExxYONOQdOLCXc4+BHM6tnOwIdTJoPIf5XCR1Yqx3TR/VcPGNlrp6WQcfk0tg30pTYMdPycTQQm8S+JWd27hnZ3WFxqAOelcpc48bw5YvU0Ct62t3CxxXb3fz8zKBDOVicYwYpNC+xT9V3bOgq8aKh9y02qRYUCKfdNuRll0g/nuxSS4xme7p3TqylxbVUjUDTSK8IKp+NDaG3Sidc2gXEAXBnd9M5JieiJzHH6I7nr+GgBG8RGqxKibTmsA6JonM3ueiQNPqbvXilX3NzS0CkgoWqr4NRh56l30W2IGV9887TIfyuQA+K7zX/U3Nglu1rPFB7zIdV+OgI/4rKgqcJw2CTlCcc0cWEEUZtv4zv1zM2vBKFprqmYdLhV+2bD6SCjs6QrBRe4aBB08wGh+/bWLsq3D1tm96GhGBeYGBatTUJZAZAkLVX1Ixfw0jXoYZekKsw/sJqO/fgJTHCCc7/JaB0W1AXgO0kgVcCm6P+X2DuQXzcEDmeo2Wkgn5CSftaX8l16b2QyUfd1dF3oj934y0D5VkjjYPjsqEe8ZbfzBZbGktQA4fDsNlQx1+/k+k0H+4fbd12eSi9W3Ni0em0mv/bhoLjNTUhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(1590799018)(4326008)(66476007)(41300700001)(5660300002)(8676002)(6916009)(66946007)(91956017)(76116006)(8936002)(31686004)(2906002)(478600001)(1580799015)(316002)(66556008)(66446008)(64756008)(6486002)(6512007)(966005)(71200400001)(82960400001)(38100700002)(166002)(6506007)(26005)(36756003)(2616005)(85182001)(83380400001)(122000001)(38070700005)(186003)(86362001)(31696002)(45980500001)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXpXcC9vZDRWZksrbnhPZ0d6UGp1MWN3L2x3a0gzM0Qzcmd6amR3QnBQRld0?=
 =?utf-8?B?WHAwaGt4RmZWWVk3SFRVM01MM3lSVHliZUZLZzdkSDFRNExLNjVwOUJjMVZn?=
 =?utf-8?B?ME01eEFEaStIck9mT0diWk5aOVhmaVF6UW9QdXRUd1A4b21JcDRIKytmb0Jq?=
 =?utf-8?B?TXhHWHczZThkVkZnSElnVU1nbU1zakhWRXhEdUJvaUlaMWxRVFVwZXh0R1R0?=
 =?utf-8?B?Nno5b3VGWXp2S0tlTjIwK294a3VIR2lqYXZtdDlleTg0eW1PMUFvNUt5SWlJ?=
 =?utf-8?B?T05CZERzU3YvWGVkMW9NZkY3QjZQNGRFQnpYK0NEK3BxVm1mU1NlZ1V4bThY?=
 =?utf-8?B?WXJDaWxtbFFnMklxWFh4bU5UNzRCdmVwbEFCTHRZQ2hrK3NMa0N3b2FjRjZY?=
 =?utf-8?B?bXJobFRMQ1VmNnVUbnlSQk1FUjBaSHNQaUJEZCtQZ1pKVEVBOWJ6b1VVNDVk?=
 =?utf-8?B?YWgrV05qbDlVK2w5aTh6N3puckVNbHNVNlFaamhGMTQvQk1TL3A2WUZwVWFw?=
 =?utf-8?B?bjFSejJhUDcwN0loUmlMNzR3OWMyRGFpa0xnL1JxbzFlRlVnTG1HTGZwdUtW?=
 =?utf-8?B?WGJJRW9aVEJjYmtFeVRqakRFNUR6VEFYc05iZWR6NEFBeE9pVFNOTVR0Mktz?=
 =?utf-8?B?SFliZkpXOS9lYy85eEpCeGJjN1BVUzVpTHJneDhJcVdicFFlcW1KZnJwUy85?=
 =?utf-8?B?eEZjakpLRUVtVFlHeWt6M2ZKdDNPZ0pKOTV6UmF0ZzVlVFZtRXZyMXFPTlZt?=
 =?utf-8?B?ODYvUDRsZjVuMTBmSm1IaGJFZjZIWTJLaGpkdUpxdU0xck9vbWswWnZMOFVT?=
 =?utf-8?B?SlhQM3c1bWZ4clhpcmJra1gwbWJua3ZHWTR3VXBCZlpMSVA2dTdpOVpLcVVk?=
 =?utf-8?B?QitOT3hTTG80bjZaT25RbjJiM0xqRmsydkxzVDNxVDhTNjNpWWN0SnVJVjY5?=
 =?utf-8?B?U0EvSWF4akVvVlRQRGs1YzdlcTk4cGFQM0hTUjFwQkVCMDQ4ZklpcDFINUZC?=
 =?utf-8?B?eHp1ZS9UVVRvVitEbFQydlRNL01WTDBLMDNnaHh4bkYrT3R6V2drZXAxcDhW?=
 =?utf-8?B?eElQTWJGNWFtUHlCUU9pdXJwdkdxa1ZPMkdHT2JBbklNSHpSSElwRXBmNjg3?=
 =?utf-8?B?OHJ3eS9yUE1GOHE5VWF1UkFnbUtUbWNROWsyODkzU1F6V1lubnJvWHZvYjFM?=
 =?utf-8?B?OTBCb0QzWWlmcGN0WnpHNWJtUXdaOHFUSmU2RFU5YzlvY1ZyU0xSWG02RmFr?=
 =?utf-8?B?Qm1VcWNsN3RnZzkxLzFSY2dnSnNtT08rTHEzdmNONHdWUjJRcUQ1LzVTbnVN?=
 =?utf-8?B?SzNoWExkeTZzdGdvbXVYeC9aOG95b2VzM1hxdXgzd2VVWlduNlRzQlhiS3Jx?=
 =?utf-8?B?M3hPZ25qZ1JCTWprUlh0SncyK3ZHL0dPMEcrNWc1SWt0VE5UOXdPb3Bab213?=
 =?utf-8?B?UDFTQ1lEeVZEeHViZG9KYzg0eHAwSnYrNVFuckZEN0NjRWt1RDcwUDk2S241?=
 =?utf-8?B?OEc5VnVockd6ZGU5MUNyLzRNcGF3dzE0d0pxellMc1hpU2lwQ1B6RjhvQ3di?=
 =?utf-8?B?cWpUeUtEN0d4VVVkTjJDWlpiYmhPNEJWNGpEL0t2aTlsWXpQelY4RzM1UTdi?=
 =?utf-8?B?VE9oczc5ejU3RUlSUzRUcTJhTzkvUkNRTUUwRVV6THBSV1hoK0FDakdjanJt?=
 =?utf-8?B?c0c2b1pBNDlDSHdXc2t1Q2Q2ZmZRK0czWTFjd2d6dk1rd0VUTGJaajl1UXBW?=
 =?utf-8?B?SjhXZDloaVRtZmxoaEpDUTFaczk5SmF5RUV3Y2IzK0dyWWIwRmlvZzlLWCtu?=
 =?utf-8?B?RWFFSzBGQUMxM0RDRWJRTDZSelh5UUZvV3drekxRRFpmeEgyUHl5TmpvUDYv?=
 =?utf-8?B?d1pBV0FDVXJDTmxJSGpFaUkzTUtPTjVuTUZ4eHkyZkNFUjg0NVpBR0J3aU0x?=
 =?utf-8?B?alJJNmx5cUVnY2dkbVpabVVWUVR0V0JLWGdIZGdWTXhOTG1maWxBamNnWnJt?=
 =?utf-8?B?NktiVThLMU8wSHZFMmxpUk1CYXRaSE1xYkVyd2tXSHUrbllML1BVTTNKOGRS?=
 =?utf-8?B?WWltVkRSMmRVQ1d6S0p5NXZWRVJFMUs2b09GeEd0ZDRhZzN0cE43MVgydnFz?=
 =?utf-8?B?TTJwM0RFUmttbEUvQU5ROHpYb0NrRmN6VlRnbjlDeHBvdEh6VEtKdWIxc3JY?=
 =?utf-8?B?RVE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 03juhQr3FDGyARKWpdtBJrxQziZNXOUZ8df1R0ZG02A5srqRlzhkxyYFc0nLeA9QGKv+5XBM6RI4CzeGMmSnvbRZKu6gF4YcY8MFJMbBLGZI/0MRk502im96cIUobd2GgOFkK8R+QViGiTEZN0HRg1g8l02OJgDMsz7tDBTAHi2AZjOTjFG1IN+iWld1AJJuzYVBfCYik8F4+BmCfClYK01tziJ7km9gcMp57wwVdpb3OdfCG/84vNEd3RPwkYHau/noMdsqPnj4lGK65iGMgM0jYhjT6u1qZWf4vWea27FAw1o/nR9jrkF0Bt0EuFUxVjQO160gjMeEUKT91DV9OA57T4NSXH71/QdJwsYFeIrD0UtiHIpypCGG0jg7whP2FQ27Oeb36JTNQnt9LepWg/+OGTs1+p6XrzaK5c+Y0TLAEh5T7qJWTUeuqYiL+u1ue+lnybSI7khLDj+eVMa+fLIhX+zxnclTggQSvu2y9URMAiUeNVda/sB2m8NsBwhat8HNITOOzqV2djAN6gqC8uLVS71DZYUVLD2iuDCu9h7EYjaTVpVoOXEGh+SvS8OS3SpJXJWcSMHpmTvdTJd3/OkegohCrXCRCDeAY4FctlCkPyHfu1TkvJDoIlPUL8tHHgxj7+ATs/IBd545qCMKkjaaTwUSoBQklAZ6kMbsq0FB2yfnRXtoHwvXOPx37sy+xin880QVghZ+8+tvIzoHrlbtLz1nYikcVff9+qJQaKSAd1+/R/ClbqFLuHALUrLzT3ijmUYKjkToGlW3lqfF1R601z4EgBw5eRknn1FSP80=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc6d25-0d5f-4b58-dbf0-08db927f0e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 11:04:20.2712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV5nmlypQEMcNOjivJGZ60+XRG/FELtrEEC3bbjMSnpEkFp66sOTgTdsqiWbkFqFIxYBoR6vD5bWBPDWI43pl5WOJ31wxLnXSPhOAjotkQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9878
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/3] syscalls/setgroups02: Convert to new API
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

Hi!


+       TEST(SETGROUPS(gidsetsize, groups_set));



TST_EXP_PASS(SETGROUPS(gidsetsize, groups_set)) ?


OK.

-       setup();
-
-       for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-               tst_count = 0;
-
-               /*
-                * Call setgroups() to set supplimentary group IDs of
-                * the calling super-user process to gid of TESTUSER.
-                */
-               TEST(SETGROUPS(cleanup, gidsetsize, groups_list));
+       if (TST_RET < 0) {
+               tst_res(TFAIL, "setgroups(%d, groups_set) Failed, "
+                       "errno=%d : %s", gidsetsize,
+                       TST_ERR, strerror(TST_ERR));
+       }

-               if (TEST_RETURN == -1) {
-                       tst_resm(TFAIL, "setgroups(%d, groups_list) Failed, "
-                                "errno=%d : %s", gidsetsize, TEST_ERRNO,
-                                strerror(TEST_ERRNO));
-                       continue;
-               }
+       GETGROUPS(gidsetsize, groups_get);



TST_EXP_VAL(GETGROUPS(gitsetsize, groups_get), 1) ?

Also I suppose that we should make sure that the groups_get[0] value is
not equal to the groups_set[0], expecially with -i 2

So maybe:
        groups_get[0] = ~groups_set[0];


I will update it, but the results we assume are equal.

-               /*
-                * Call getgroups(2) to verify that
-                * setgroups(2) successfully set the
-                * supp. gids of TESTUSER.
-                */
-               groups_list[0] = '\0';
-               if (GETGROUPS(cleanup, gidsetsize, groups_list) < 0) {
-                       tst_brkm(TFAIL, cleanup, "getgroups() Fails, "
-                                "error=%d", errno);
-               }
-               for (i = 0; i < NGROUPS; i++) {
-                       if (groups_list[i] == user_info->pw_gid) {
-                               tst_resm(TPASS,
-                                        "Functionality of setgroups"
-                                        "(%d, groups_list) successful",
-                                        gidsetsize);
-                               PASS_FLAG = 1;
-                       }
-               }
-               if (PASS_FLAG == 0) {
-                       tst_resm(TFAIL, "Supplimentary gid %d not set "
-                                "for the process", user_info->pw_gid);
-               }
+       if (groups_get[0] == groups_set[0]) {
+               tst_res(TPASS,
+                       "Functionality of setgroups"
+                       "(%d, groups_set) successful",
+                       gidsetsize);
        }



TST_EXP_EQ_LI(groups_get[0], groups_set[0]);

At least that will produce TFAIL results if they don't match, which is
missing here.


Sound reasonable.

-       cleanup();
-       tst_exit();
 }

-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Make sure the test process uid is root.
- *  Get the supplimentrary group id of test user from /etc/passwd file.
- */
-void setup(void)
+static void setup(void)
 {
+       user_info = SAFE_GETPWNAM(TESTUSER);

-       tst_require_root();
-
-       tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-       TEST_PAUSE;
-
-       /* Get the group id info. of TESTUSER from /etc/passwd */
-       if ((user_info = getpwnam(TESTUSER)) == NULL) {
-               tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
-       }
+       GID16_CHECK(user_info->pw_gid, setgroups);

-       if (!GID_SIZE_CHECK(user_info->pw_gid)) {
-               tst_brkm(TBROK,
-                        cleanup,
-                        "gid returned from getpwnam is too large for testing setgroups16");
-       }
-
-       groups_list[0] = user_info->pw_gid;
+       groups_set[0] = user_info->pw_gid;



Do we really need this? I suppose that any random value will do, e.g.

        groups_set[0] = 42;

is going to be as good as anything else.


Agree.

 }

-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *            completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+       .test_all = verify_setgroups,
+       .setup = setup,
+       .needs_root = 1,
+};
--
1.8.3.1


--
Mailing list info: https://lists.linux.it/listinfo/ltp


Best Regards

Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
