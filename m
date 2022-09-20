Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0448AECAAD8
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 09:55:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CFEC3CAAE5
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 11:55:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D2483C0204
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:55:12 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 161971A00E11
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 11:55:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzviTxKhDQRjWNhNTLJriu+NZ031C2Zk75PE1kstN+btGZqqC2SRgx6dA2+bNRO2LDQgSSl8NL1Th5iU8roE/gwk1zpwXvB8i5QExB+ZWEZ65g7yLP9SJDlnUQHuxjo3cQb/0/toyG0wUm66YY33hl3Z4TxoqctsGC9Aknf8A9GH4FGZY4EErKuhZkfwMglW25Nt7qkGZEHrNUUDYi+t/Cnp29dPqJcDOipXVKkTylNhCiLZzl9mLLKgo2K9Q/EaH4WyRydGZYWrt2Gr2pZaWo0FHujxF5xeYlUF+usCgCYmvxGAHQ/P6YboXDE7dSR8p1PZzmZO2PX0z/v7c2mGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMHO1IecFqPVIeQOWsR05LQFV8Nmz85MFcniAK2jxJk=;
 b=nskkZYqOwDHY6HXyEV5Z3ngX4Gh9YKC4W0f0YilidGerERKOPhp+ZmJWdECTRzXCaDWs6+mdHAB3QpF01c6wKD8PfdB8dBrhKaNPaP0o4Bm8dt/+64JUK0MrNLEgtJ13nTswxsRhfwCX07yrYKvupRjnlprCq2RqtTeFW8lKz3Y3p9fpfZ2EbVkuhL2Z9N3r3s4LCCF5uceNK/8Pikk7EiiqAQ4WzILVyqX3vrT6g6H43ZZm1O8kyl4Q2ExgJqlrrJYjkvrxvhH+LZ3uONWxnaaRc0kalUnCKee/lOOcD+3wmZGofn8RFsf0QnFo7h8BN8fnwNM2jR/c8lj9aSVm6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMHO1IecFqPVIeQOWsR05LQFV8Nmz85MFcniAK2jxJk=;
 b=DQ89hXQWC3TCzRmsPeR3cLafXNny4UHgv4vQxtl0KD6gS+5by57HA7HcbxWalt7g3sjUi3S4eHiJSIHq4ahos27q0aAaWk2A5qvJBvtGOMQBA80ERb6myvHbwVBnEy9vi5tKEnv6I9jjtctxV+1StpSI4qaStF/bMxu7tKilsN7VbmKmqYYGW9Fc7FSzQ7ZG6s/plEGjJzfcemn6G66klN4p3GOA9IcqWQ1rzE6tVHkDM/yijmk7rV79BStcYPms67QzdWqkB7w+3VyP8aQOSoLeUnN1K6tSknAzhUmPVVaIqAlv9gWgrUtoOHumNwYRaYpDHd1qz0Op4xgF9g4xqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PR3PR04MB7403.eurprd04.prod.outlook.com (2603:10a6:102:8b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 09:55:01 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::41c2:c368:6f78:7518%8]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 09:55:01 +0000
Message-ID: <6470a099-8b3a-ca9f-f521-181a33b5a28a@suse.com>
Date: Tue, 20 Sep 2022 11:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Jan Stancek <jstancek@redhat.com>
References: <6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com>
 <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
In-Reply-To: <6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com>
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PR3PR04MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 395307e6-ee10-437d-de99-08da9aee2f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDao5evAI6lGIPkGwIlVJk8YYTliZnGTO6XRm5cLNXzLj7ErfSp1iHXmQTxfjAD9BZd9sKQnAx/+an2lgO5mAhezEbtQsE/6O60LH2l2sLizAzc+B9i9LxiTc3TferKfPBCym5qL1Vvg2by8azkJCgP0Nj3t7QsHp7HRLjyS8jfxlRxod75sRbx4Osib3wavjpGViQgyUhW4mCAu4Q3vmmjvOxrEKi3hVN3FxxywS0mpX0RwYgR9k93YIo5vzunertuqYZ2GqAPREy4Kx2nCBVI+VzgyZVkGHR/1j/TvH9c6/lI5nsyx77kWdgPZKYFhx3mRbfltXpei+2i5vLu20uDH0orj2UOsJVajM4tLh0ZdqKJ33fiOI8WA/h3snnBAKMrhmekaLeyBfyTTGuGiPGkI6PLs9gDKokGhzKzxaBo016jvnwS6gKp/7RzviWIV1pkTOKVKFIajR1i548bztnCZ5QaOSgrNmljq1o3mSfmhZIBVEqiGOdv29xtg4eiF07hqOcVumwf1KHdVwWxZ0aSvFD1VMeRgTp/K/FWTyH9l235eaqdCTPIPQoxSdmEO0Gw2xjrsbea4QbwWVZ2/fepod4kGSVARcV6kC/qNRN3Eadal+1j/CZ7NXDpgqzWFnvxReZYYN9CI4MSSPHmLCvAKkaZpeddg7gSqWmqF1NyPtW/NW42vsVHtPpguPp1vIIF2bC8j3DRDyyd1gkDwRZbzFnRcb8u3ZedygD9nKcw/18mk1v09uFUEFpzNjdUdgeSpHN4nwlz5JdBBO+AhH0a2MenwVq0YPsQ8ccGXqAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(31696002)(38100700002)(86362001)(316002)(6916009)(2906002)(6512007)(26005)(6506007)(53546011)(83380400001)(2616005)(186003)(6486002)(6666004)(478600001)(41300700001)(36756003)(31686004)(4326008)(5660300002)(8676002)(44832011)(66476007)(66556008)(8936002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRzb0JLNmpoeERLNC8wVyt0K0hkd2VNR0hCY053RFFESkJrRW1FeVh3cGIz?=
 =?utf-8?B?SHRjYzhvK2dML1VQbEVST2kwR1pnVVhWSWQ2SmdSWCtzY2FJSHZWTStKZ0d4?=
 =?utf-8?B?UElxSlI3eVRIYXZPZ1RIUVRQVVFCQytDRDdqaVVKa0ZPeFVhaStZYmM0SjBM?=
 =?utf-8?B?cGtZcFpZZGNFQ1ptWHh2bmhXWncyTjhZOVJhSDBZVVd0UXF6dkdlQjdGYnM4?=
 =?utf-8?B?SGNFR0VXS3JEbU9idU9PYkw2akxVN0IwLzlocUEzYTlhSlRpUEpUYVd4SVRL?=
 =?utf-8?B?MXZyUmFzbmljOHE3S0tsZm9udnJaakNJODFUaG9ObFlLNmRTeDFqRXUrb0pz?=
 =?utf-8?B?MDM0d3ZocGRjS0xYczkwTm9Seld3NzNHMHMyU0c3Zk1OTXZ1bTg3eHg3Sldk?=
 =?utf-8?B?UVpyTXh2a3g3b2lkV09KM1laRHFsTm1TT29sUERNbm5nYjlrT0I3K0RRTDRY?=
 =?utf-8?B?WUZiVmJnQktwUS9ZbzNNK3RBVGUvVGtwL0RJcDFpdURYeWJTa3FKNTYvdFBs?=
 =?utf-8?B?d3BkSHo4MEhjWlVOL3NlT2dVSUpIRCtzK1M4ZjV4Tk5EUmNWQW5mRjh4VGs1?=
 =?utf-8?B?eUpwY05yeSs1QldqcGVMc1lNU3NpNjkvNlN0enBrMEVwcDBmU3hWcGEycHoz?=
 =?utf-8?B?eDNWanRicnh2NHRmN2U1Y2RMK2o1V1prdkN3cVA0emtDTjdoWHQ3M2dHRFNm?=
 =?utf-8?B?b3BNYTducTdSWjdZUTQ0VVE3bDVCTmUwcmVjQW9kR0Q0SllFYUJ1VmJFYVBM?=
 =?utf-8?B?YTRLenJYMVRVK3hNdEpRbjVSaWpUNHFQY0xFSzhVdVN2VE5OZXFqUEh5Tzg2?=
 =?utf-8?B?SXBmZzdvY0ZQS0YzL2lJaHN1QU5uMCttdHJRcnJzUlM0UWVVcEJzWU9SenNQ?=
 =?utf-8?B?aGVtTHR2VjY1NGtKa2NiS2hFVTZPT2tEUlYrMDdSMzl4Qjk3TmplTm94dTR0?=
 =?utf-8?B?dzY3QURsa1NFSUZWME5iNFlNNFhreitxSWV1b2thOW9IMUFZUVduZStDVE9h?=
 =?utf-8?B?NmhpZElFVlhQOFdBb0NRTmRJaW1NaDZVTVVjWm1zM3I3SFRpVkVIdE1NMHZW?=
 =?utf-8?B?VzdCS0htckFGVlhWRnVxK3hUWENZSXpSbXJpRmtxVGhncmxOUjZtNFprYjhz?=
 =?utf-8?B?T0VnSDRlSVJabHhkNWQ1UVhIZzVvb0xHdTQzczZVQ2lmTW45UXdQb3ZlUlZN?=
 =?utf-8?B?UWJSR3dTRmpkNVI0MlRzb1UrOU5TV04xdjhjQW12TEQ4aVZyTG54SjZwR05B?=
 =?utf-8?B?Z0NYS2lhS2NUdjZsTnBSZEVXMHFQTHNYaFBXeGNWV21YVjBMc0dPRnFwZXRT?=
 =?utf-8?B?N3YxS0Y2VkF0elhkMFZRMXhoeDAwMFhoNDJyQnJDUEVPc2FMU2UrRnlpR3Yr?=
 =?utf-8?B?VW5OZE02Nno3TGQ3SGJRVjZJRUxZWUdIME0wN1Z6dWdPL29yZTNoZDRIMG5V?=
 =?utf-8?B?MUoyVTF0WVBxR1RMWGc2NkVSRXRCcERuOXFRc1FGZWc3WDRaRTFMcEpOMlYz?=
 =?utf-8?B?djlSeGkwK2hLb241cUtvWFFkdDMydVJKSTE5eFQ2a2tFY3ZxMVlNbEhjSktB?=
 =?utf-8?B?dnp6RDV5Ly9KVUlCaEZDcmhZWVhZMkt1SXJCSTI2V3hPdi9jdGZLQ1d3YURT?=
 =?utf-8?B?ZWVMd3dib1g1NUM1ZG1YeEpRR1daSVp5aUFSZ2ppVXhxYllybUw4OEMrSmM5?=
 =?utf-8?B?YUw1MWFKNXV0M0Zic2lqQ0szTTRTQ3A1NE9HR2VuUnhESHpqSDdIaWRyWWsz?=
 =?utf-8?B?Ry8yMGlXK3BSQnhaWnpjaDFUYTZUWTlNeTB6MFJRbjBZL2tXYisrWGIwT2tS?=
 =?utf-8?B?MzNMekIxN0ZXZHBCZXR3TjVnYUZ5b2E3Um1JbDdPZzFQYmxycFo4c3JGR0gw?=
 =?utf-8?B?TlR3eXY2ZlppNjREaGpTOFh6TmIyNVc4cFNhTnJtQ2t6dlRmNkIvZG5VRnI4?=
 =?utf-8?B?eDErNGFZNjNFZDdPc3h4V2htWjJ4ZUpDa3YrWlB1dmlMVnNtNURtelpaeE8v?=
 =?utf-8?B?eVcvQ1AzQzU5czRmZHNtL3N2a3hQTDRDQTJMU1VISGliYll5c0V4akIyTUly?=
 =?utf-8?B?dWoyU0RtdDlxMFk2ZE43L3g5NzgrR1Fjckh1Y2IvQ0swcGVaUHRzZmtXYk53?=
 =?utf-8?Q?e3j4U5NjQCWPIJJ6uLvybGfJP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395307e6-ee10-437d-de99-08da9aee2f2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 09:55:01.2559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0G6aLeC4nlN4xpmNX7mjedkRF2jhmNc7vOeb3eAio8knNK5HnNoawrGQeuj98K9vxbl5wopN79FjboUCURe6nCkvuvygY+fTP2cHRFdTcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7403
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/futex_waitv0[23]: replace
 TST_THREAD_STATE_WAIT with repeated wake
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA5LzIwLzIyIDExOjIxLCBKYW4gU3RhbmNlayB3cm90ZToKPiBUU1RfVEhSRUFEX1NU
QVRFX1dBSVQgaXNuJ3QgcmVsaWFibGUgdG8gdGVsbCB0aGF0IGl0J3Mgc2FmZSB0bwo+IGNhbGwg
ZnV0ZXhfd2FrZSgpLiBmdXRleF93YWtlKCkgY2FuIGJlIGNhbGxlZCBwcmVtYXR1cmVseSBhbmQK
PiByZXR1cm4gMCwgd2hpY2ggbGVhdmVzIG90aGVyIHRocmVhZCB0aW1pbmcgb3V0Lgo+Cj4gUmVw
bGFjZSBpdCB3aXRoIHJlcGVhdGVkIGZ1dGV4X3dha2UoKSB1bnRpbCBpdCBmYWlscyBvciB3YWtl
cyBhdCBsZWFzdCAxIHdhaXRlci4KPiBBbHNvIGV4dGVuZCB0aW1lb3V0IHRvIDUgc2Vjb25kcyB0
byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMgZnJvbSBzeXN0ZW1zIHdpdGgKPiBoaWdoIHN0ZWFsIHRp
bWUgKGUuZy4gb3ZlcmxvYWRlZCBzMzkweCBob3N0KS4KPgo+IEZvciBmdXRleF93YWl0djAzIHRo
aXMgcmVwbGFjZXMgd2hpbGUgbG9vcCB3aXRoIFRTVF9SRVRSWV9GVU5DLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gLS0tCj4gICAuLi4va2Vy
bmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dhaXR2MDIuYyAgICAgfCAyMSArKysrKystLS0tLS0t
LS0tLS0tCj4gICAuLi4va2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dhaXR2MDMuYyAgICAg
fCAxMiArKystLS0tLS0tLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRl
eHRlc3QuaCAgIHwgMTUgKysrKysrKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNl
cnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4X3dhaXR2MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZnV0ZXgvZnV0ZXhfd2FpdHYwMi5jCj4gaW5kZXggMGEwZTJiNjIwNzVjLi5jY2VhNWVi
NWU3NDUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRl
eF93YWl0djAyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4
X3dhaXR2MDIuYwo+IEBAIC01MCwxOSArNTAsMTMgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkK
PiAgIAl9Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQgKnRocmVhZGVkKHZvaWQgKmFyZykKPiAr
c3RhdGljIHZvaWQgKnRocmVhZGVkKExUUF9BVFRSSUJVVEVfVU5VU0VEIHZvaWQgKmFyZykKPiAg
IHsKPiAgIAlzdHJ1Y3QgZnV0ZXhfdGVzdF92YXJpYW50cyB0diA9IGZ1dGV4X3ZhcmlhbnQoKTsK
PiAtCWludCB0aWQgPSAqKGludCAqKWFyZzsKPiAgIAo+IC0JVFNUX1RIUkVBRF9TVEFURV9XQUlU
KHRpZCwgJ1MnLCAwKTsKPiAtCj4gLQlURVNUKGZ1dGV4X3dha2UodHYuZm50eXBlLCAodm9pZCAq
KSh1aW50cHRyX3Qpd2FpdHZbbnVtZnV0ZXggLSAxXS51YWRkciwKPiAtCQkJMSwgRlVURVhfUFJJ
VkFURV9GTEFHKSk7Cj4gLQlpZiAoVFNUX1JFVCA8IDApIHsKPiAtCQl0c3RfYnJrKFRCUk9LIHwg
VFRFUlJOTywKPiAtCQkJImZ1dGV4X3dha2UgcHJpdmF0ZSByZXR1cm5lZDogJWxkIiwgVFNUX1JF
VCk7Cj4gLQl9Cj4gKwlUU1RfUkVUUllfRlVOQyhmdXRleF93YWtlKHR2LmZudHlwZSwKPiArCQko
dm9pZCAqKSh1aW50cHRyX3Qpd2FpdHZbbnVtZnV0ZXggLSAxXS51YWRkciwKPiArCQkxLCBGVVRF
WF9QUklWQVRFX0ZMQUcpLCBmdXRleF93YWtlZF9zb21lb25lKTsKCkNvcnJlY3Qgd2F5IG9mIHVz
aW5nIFRTVF9SRVRSWV9GVU5DIGlzIHRoZSBmb2xsb3dpbmc6CgogwqDCoMKgIHJldCA9IFRTVF9S
RVRSWV9GVU5DKGZ1dGV4X3dha2UodHYuZm50eXBlLCAodm9pZCAKKikodWludHB0cl90KXdhaXR2
W251bWZ1dGV4IC0gMV0udWFkZHIsIDEsIEZVVEVYX1BSSVZBVEVfRkxBRyksIApUU1RfUkVUVkFM
X0dFMCk7CgogwqDCoMKgIGlmIChyZXQgPCAwKQogwqDCoCDCoMKgwqDCoCB0c3RfYnJrKFRCUk9L
IHwgVFRFUlJOTywgImZ1dGV4X3dha2UgcHJpdmF0ZSByZXR1cm5lZDogJWxkIiwgcmV0KTsKCj4g
ICAKPiAgIAlyZXR1cm4gTlVMTDsKPiAgIH0KPiBAQCAtNzAsMTYgKzY0LDEzIEBAIHN0YXRpYyB2
b2lkICp0aHJlYWRlZCh2b2lkICphcmcpCj4gICBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAgIHsK
PiAgIAlzdHJ1Y3QgdGltZXNwZWMgdG87Cj4gLQlpbnQgdGlkOwo+ICAgCXB0aHJlYWRfdCB0Owo+
ICAgCj4gLQl0aWQgPSB0c3Rfc3lzY2FsbChfX05SX2dldHRpZCk7Cj4gLQo+IC0JU0FGRV9QVEhS
RUFEX0NSRUFURSgmdCwgTlVMTCwgdGhyZWFkZWQsICh2b2lkICopJnRpZCk7Cj4gKwlTQUZFX1BU
SFJFQURfQ1JFQVRFKCZ0LCBOVUxMLCB0aHJlYWRlZCwgTlVMTCk7Cj4gICAKPiAgIAkvKiBzZXR0
aW5nIGFic29sdXRlIHRpbWVvdXQgZm9yIGZ1dGV4MiAqLwo+ICAgCVNBRkVfQ0xPQ0tfR0VUVElN
RShDTE9DS19NT05PVE9OSUMsICZ0byk7Cj4gLQl0by50dl9zZWMrKzsKPiArCXRvLnR2X3NlYyAr
PSA1Owo+ICAgCj4gICAJVEVTVChmdXRleF93YWl0dih3YWl0diwgbnVtZnV0ZXgsIDAsICZ0bywg
Q0xPQ0tfTU9OT1RPTklDKSk7Cj4gICAJaWYgKFRTVF9SRVQgPCAwKSB7Cj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfd2FpdHYwMy5jIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93YWl0djAzLmMKPiBpbmRleCBlZTc5NzI4
NDc0ZWUuLmM2NzRmNTJkOGQ0YyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Z1dGV4L2Z1dGV4X3dhaXR2MDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZnV0ZXgvZnV0ZXhfd2FpdHYwMy5jCj4gQEAgLTc0LDE1ICs3NCw5IEBAIHN0YXRpYyB2b2lk
ICp0aHJlYWRlZChMVFBfQVRUUklCVVRFX1VOVVNFRCB2b2lkICphcmcpCj4gICB7Cj4gICAJc3Ry
dWN0IGZ1dGV4X3Rlc3RfdmFyaWFudHMgdHYgPSBmdXRleF92YXJpYW50KCk7Cj4gICAKPiAtCWRv
IHsKPiAtCQlURVNUKGZ1dGV4X3dha2UodHYuZm50eXBlLCAodm9pZCAqKSh1aW50cHRyX3Qpd2Fp
dHZbbnVtZnV0ZXggLSAxXS51YWRkciwKPiAtCQkJMSwgMCkpOwo+IC0JCWlmIChUU1RfUkVUIDwg
MCkgewo+IC0JCQl0c3RfYnJrKFRCUk9LIHwgVFRFUlJOTywKPiAtCQkJCSJmdXRleF93YWtlIHBy
aXZhdGUgcmV0dXJuZWQ6ICVsZCIsIFRTVF9SRVQpOwo+IC0JCX0KPiAtCQl1c2xlZXAoMTAwMCk7
Cj4gLQl9IHdoaWxlIChUU1RfUkVUIDwgMSk7Cj4gKwlUU1RfUkVUUllfRlVOQyhmdXRleF93YWtl
KHR2LmZudHlwZSwKPiArCQkodm9pZCAqKSh1aW50cHRyX3Qpd2FpdHZbbnVtZnV0ZXggLSAxXS51
YWRkciwKPiArCQkxLCAwKSwgZnV0ZXhfd2FrZWRfc29tZW9uZSk7Cj4gICAKPiAgIAlyZXR1cm4g
TlVMTDsKPiAgIH0KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRl
eC9mdXRleHRlc3QuaCBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXh0ZXN0
LmgKPiBpbmRleCBmZDEwODg1ZjMyMDUuLjUxNWI1MTAyZDRmYyAxMDA2NDQKPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Z1dGV4L2Z1dGV4dGVzdC5oCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleHRlc3QuaAo+IEBAIC0yNzcsNCArMjc3LDE5IEBA
IGZ1dGV4X3NldChmdXRleF90ICp1YWRkciwgdV9pbnQzMl90IG5ld3ZhbCkKPiAgIAlyZXR1cm4g
bmV3dmFsOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBmdXRleF93YWtlZF9zb21lb25lKCkgLSBF
Q0hDSyBmdW5jIGZvciBUU1RfUkVUUllfRlVOQwo+ICsgKiBAcmV0OglyZXR1cm4gdmFsdWUgb2Yg
ZnV0ZXhfd2FrZQo+ICsgKgo+ICsgKiBSZXR1cm4gdmFsdWUgZHJpdmVzIFRTVF9SRVRSWV9GVU5D
IG1hY3JvLgo+ICsgKi8KPiArc3RhdGljIGlubGluZSBpbnQKPiArZnV0ZXhfd2FrZWRfc29tZW9u
ZShpbnQgcmV0KQo+ICt7Cj4gKwlpZiAocmV0IDwgMCkKPiArCQl0c3RfYnJrKFRCUk9LIHwgVEVS
Uk5PLCAiZnV0ZXhfd2FrZSByZXR1cm5lZDogJWQiLCByZXQpOwo+ICsKPiArCXJldHVybiByZXQ7
Cj4gK30KPiArCj4gICAjZW5kaWYgLyogX0ZVVEVYVEVTVF9IICovCgotLQoKUmVnYXJkcywKQW5k
cmVhIENlcnZlc2F0bwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
