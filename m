Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF3C7EE24
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 09:27:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0350D3CCB22
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 11:27:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492F33CB828
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:27:03 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 385DB600728
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 11:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685957222; x=1717493222;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+ibkjoAg0GnYo2OPb3c1n8KhS1X6UgSuSFdB85BACBs=;
 b=fOr0GF/bDf8lg/bcHuc0TYQTKGxmYgh9KOCHQjWS2qPqIp7IB979uVNf
 Kj5ubZynEHBt0D+k+F7S/bKueJoxwxVA7I2w9+T3sOMPwDpjGiejDljFF
 aYmALLMbDUFcqJYdIOuV54VPDMMnGb69pIKeUChBMxbgzPwP0PyW06Ke9
 HXOQJ4nLeSOb42Mr8NvCFlrHb6CsbxSGx6h1vKA4MjiT1GP+GIF9Iw22M
 HW5PneqYidM5bsjq+PDx5mkzfpazMcQgOmKK3yWIM8C310SmRdjkiKSmq
 G4zSbDs6YjnrSQ0pkMnuD1X7BB3ghGFoNuNF8PbqaJC8jNll4IHwrHIu6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="86341129"
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; d="scan'208";a="86341129"
Received: from mail-tycjpn01lp2177.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.177])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 18:26:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBhTSZrdx2mAwmZV7YsV+dDCtQ0fInhxJbY9B2CObbahZoycvbaLMtTWKto6psR3anYeNN2oXLKCvxPTuJvukphVvSui+bHPobbLnquuFkv71X8NfF836prHkz6Xauuo2uwMdK+M5ir0uWwNbOnuD93mHBNnI86XQV4kHPGGZktO9WlxWkYfNSY+IUCDSRwVyyWCt6/eF+IT8njktzY/bjYGcx2LSYhegtBFzWY2QqirbFYxW7p77VaHgpoKiK7EwTxMRVsHdrD/aFco/b7m0wO+RngSbFqsWU6t6Y/o/xf6cf2doK0y5kb7lC1yriqWxFJLYiV060IT9uh6sFScZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ibkjoAg0GnYo2OPb3c1n8KhS1X6UgSuSFdB85BACBs=;
 b=QPDwXtg5d8s9Iur79QEcYK12Qj4YRa8ttUoMZwLgAIDpWF53TU+OV70lBmK8B9WOpcemeYN451vTBtklxu++DLGSxoaCeNrkhJSKVNe2YW6dcl0sRYlZPa9opyvQAsbxECoZ4yNQC+TvoX0qWKCAr521ktPJFRO0gxxRMhNQCAC1BhbDm9OFoBFMdJaTuUkBG/dZ7OC7u8CAtCWyEGpIaqsGTZFYsgVsnbwsyk6DFjrDDmg4cUoSTAv5u5dVtaQptccqiX8xMuDv2L8rReGMdGWGp1n9tVkVbekqhzOeMHKFNwKNL3FROcOh1buR5ZU+kD5QIfN4HEh5rRcnHh3XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:26:56 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:26:55 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 2/2] syscalls/munlock02: Convert into new api
Thread-Index: AQHZlTg+j2C3eGVl+keHzWUHTxiSrq97z7WAgAAllQA=
Date: Mon, 5 Jun 2023 09:26:55 +0000
Message-ID: <76939936-1660-33f4-68f0-5f2cf4614545@fujitsu.com>
References: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1685699631-4671-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2dPR8yFw7tY6G7jq2-bCO--gh0F_PARQPqX1O7EhrPtQg@mail.gmail.com>
In-Reply-To: <CAEemH2dPR8yFw7tY6G7jq2-bCO--gh0F_PARQPqX1O7EhrPtQg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|TYAPR01MB5851:EE_
x-ms-office365-filtering-correlation-id: 6e7fdae3-f85a-4bdb-bc1e-08db65a7014d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acOR3lNGZPpWETs0oaFfNPcJMbEIhXVxxFHD91ARQV4ARjWN9ktKwjZS6WOlgShjFUl6EWX5/RdzIFe6w7dEn2WpAOu1lqCcF9QmP3GeONelMoRVwEdv+OBNtJNfBPggOi9QpCuZt3VZjO7QOf0H1gvZlObJ+fNK/uVQXBBYXWlCKPInV+hoQKgCuSpGvULdOzFSHDqI/8Wffq5ekBM4GU7a60tHjLzH/zUt+tpXZ6ci5/SY3kRY4y6Qh5fHUXd7Dgcd9XkckOXny1UXnr34vpdCrbaHzDuog5CxL8arQRV8as/1n4ih4ouHwNKHwJ0UUKb2Xr97tTyvMwsm+Dgmsp6tkQhS7M37SJGuB3bl/9MegVoB2v6nsS5hZO+096eB+0/SIqzJaNW79StO+6sCN+7wUKqAS7NKyZTBM3rsC9J+8rfbLGaD44lprgsxaG97iGyMpGGy8WsxOg4VausCUG9cD38W9fElIoY5+dsv0JUfeCkF4KvVA7qVuClW8kll0rSzaqINHH+JIDIYjuKTgL5k7Y6TN2sxKQ4rUYQzG3bnirAYne29jq6oQY76AooJjhoaU9nt146HX5hFjkT1h/InUxUWjo55iPtafQO78BM6w0VNL1JjYbWJy/Uqpq2QfwFAChCxuD4lqL/I2fSprdiPLZgG7MP6HrGKRuwoSwdSosaCLKpdgvmbaWg6dawQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(1590799018)(2616005)(6512007)(26005)(66446008)(6506007)(316002)(6916009)(66556008)(4326008)(122000001)(31686004)(76116006)(91956017)(64756008)(66476007)(66946007)(6486002)(186003)(1580799015)(38070700005)(31696002)(478600001)(71200400001)(85182001)(36756003)(2906002)(5660300002)(8936002)(8676002)(82960400001)(86362001)(558084003)(41300700001)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akh2aUVLcUxlQTE1SHFGbnBZcDZWWnQwR1hUZjFOcXN0eUpxNUVvRWVwQjBT?=
 =?utf-8?B?NnR0enRDSjdYcld4djBpbml1MTBpMWNEM0hjbjJma25YNXdrdkVUaUo5YnBr?=
 =?utf-8?B?R3E4UjFLMmxranNvRU42VzA4SzhOKzRrclcxZCtzcnMxOGtHOXpISEdSelpS?=
 =?utf-8?B?YWhLQ0NMQW9Vc0IzOVZoSDJublJQcHVpMFdlY0c0MTZ0SGFHYXlLZExxTnVv?=
 =?utf-8?B?eUNGS1NJajF0MFVOcmt6Y3doZFRPNEoyMDRUbURtdm1oMktrZnFtTWpkVmhh?=
 =?utf-8?B?eTN3SERSSjlGVDdsSGVueGhNVFNIMXEyK2JicEExa1Y5M1M2T09NczA0NVRV?=
 =?utf-8?B?S2tWZG9SbU5DMmU3ejN3WWltbDVmRGV4Z2RsazB6QUNJanpNUDcvN0Nuemp6?=
 =?utf-8?B?cEhjaThIUDVLVWZ2ZXFOeGVxUi9VbWpYTEQ2djdkZmFUTEVCR25rbkU1azR4?=
 =?utf-8?B?WUhnSUNWelZyUitqZWRIQUVEbU92TzYxYXFKMHptUHZXUGhnWGFSMW9jUi9X?=
 =?utf-8?B?SVJaeTh5N0Zvc3FEZ1dCSWtucnpmRHlLQmhSbnBDZ1l0TDliMWxsSU11ZW9F?=
 =?utf-8?B?bDVBN1RYdm9WNW16VGRtZVNWMzNsNU1scFhlQmJBanoyMVArbUl4akFUL2J1?=
 =?utf-8?B?aTFFRC9lYnIvdUdTNDlOM3hVQUg4WnlVUTB2cU5kL24yWEp1K3I2cXByVm9C?=
 =?utf-8?B?S3F4c1NXeEQvbGliaCs3bUlYU0hzTU9yY3V6bkViMWQvaCtpT2VUaDBzTFNG?=
 =?utf-8?B?eFAyZ0JrMVNzY0V3SlZIdTJJRDE2NkZ3S2lIcW4wU0RpVmF2TUh0dFVsMnhP?=
 =?utf-8?B?MTFFVHc2Z0lqdkZadjlQTW5JWGR6UVE4UUhpakcxRVB4QjdjWWlRL01oNVNx?=
 =?utf-8?B?VGRJajBQUXlkMjZJVHdHcUJUMFFrRUcremNSM3dOQWdLS1ZzK1NxbDByNHh5?=
 =?utf-8?B?SE9sRS9BYURMU0dsUmZwbWZDYzhSY1QrdUpWUnNHNmpvdWNxN3QxZUZ6L1JW?=
 =?utf-8?B?UXBwNVkydW5yTWdwWW9tWllta1NpcWJpaWxldmVrVCs1K1hadUtnOFZzS2I1?=
 =?utf-8?B?Y2hkajBmdS9KNFRGK0UveUYybEpJYWtJR0xybitnZUFLdGRZeGFnUVpJdC9I?=
 =?utf-8?B?c2l3ckpPdmpTMitPNmtvQW9VM2lKNlZBK0g4NTJiSVZPamlZT0FCODNMbWta?=
 =?utf-8?B?VVhEZ3lVL2UzaEVzczhreEQ1MXpMblg5cW1IUUhqbUs0M0NqWi9nRWh1K1hM?=
 =?utf-8?B?cXZKK2p6THV1c2wyK2NraFZwd05yRGduSXREbE5kRkcrOHVkK2RqVXVuZFBG?=
 =?utf-8?B?S1c4d051bkwvMGdDN21UWXoycUcydXJubzNJR2drbXRnTFEwRHMzVStsMlBt?=
 =?utf-8?B?ckFWSFN2OGFSa2psdHMvT3FLRXV1VHUzaStocHhrTEFuRzRoTC9zR0ZQTEwz?=
 =?utf-8?B?bENod0lnQVVyU1JTZVJtajJvL3gyU010UGVhWFVjWjRnT3QzTFdaMkxOalky?=
 =?utf-8?B?ZjdyWlQvWnBrblpGeUlSTngvblpDYXFucXpzcCtCZWxTS2ZDRFZSaGN0YVdW?=
 =?utf-8?B?M2ZQMUEzVzJ3UjlxOEdGeWsyL0N1MTl0ZVRpOGV5VVUvZmhqR1ViRGMrQ2p2?=
 =?utf-8?B?QXNSelJWYUZnLzVaMnJ4NmpVRTdmRFFoQ3YxREd3OVJ6ZTh5TXBYa05QcUs0?=
 =?utf-8?B?RUxoUjZLVU50YlZCbHphRFBZc0tHMWdLQUpxUG5DbzduQklYU3hDNGN3ZStK?=
 =?utf-8?B?ZWlmN09KRWNuQks2c28ybWZsNE5uZi9ZSy9HNzlzYURqNWJFUld3WUxNbS9t?=
 =?utf-8?B?d2lvNWcrZmRvWU1neWcvVjVzc3hRcHJOSnJVbFd2YXhwbkVrLys2VEtqY3kv?=
 =?utf-8?B?WjBjU2N6YmpCRVRwb1oxYVlTWitvRU9xdWRadUxXbHZuVUV0ckhQQ29PQTBu?=
 =?utf-8?B?ZElwZTVJbkR2Q0MvaGliTi9jd1FlRWNCQXNCY1o2Vm5hNDhGd1Z6Ui9LMk85?=
 =?utf-8?B?Mm9CWkZyRzk5Q3dBcGN2NUtZVG9sMmh4TTR3YStOM05GRXBFc1U5NHBQWFBk?=
 =?utf-8?B?NkQ3ditvS2tWRjhEOHB4b0lXNXJKaFlid29oWFFvTjR1RC9mV2E2RUhJR05Q?=
 =?utf-8?B?SXJDY2ZiZndSZVR2b0lTeG4vQkpJVDFYT1lpQS9QNGlwZk95K0VaRS9ldU1m?=
 =?utf-8?B?ZlE9PQ==?=
Content-ID: <3F566115E968BD438A0184D63836BC3A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: np9i16pfEhltfZu0B34oQVPwOAqB+VGrC4XMeyRATgihcAdEYbhREo4y9Ljdr/EVgG9PW42MvlaNVqevfGyWAalLl6bw7dK6njcCSNquzThMImJV4W3kmEbZPFyB+vCCYLUrm4cRoHU0NWtOWhit/Zxo/uyw6d+klXg2afaeTnp3vVaJprVdEDpWunOW5Oh90aZHyXw+YH+9y2EtqZwsC7TE/Kak/bKhQmzBKV0MMepsw8fpSqej2dsfZixM82TfbF7OzxgBEh+jBOzxYA5fhZ/0R1Vn6B/9tvAm4j8J5WGWsLhO/8JGKOAtykuBt8iVeyF1ibxxqrkUf/geW4tv07tSwUtoCJWoS9wxEqGw8NQZIdWLd8PFg5WR2zzlxBZTlcJxTrbu3LPMVtnEG9fE12brtP/LXN0pAt/IkjaiCaTnV9UgoQnN0YzMLmzlLgmQHkprJ81ICpobvZMg0jkpQCgDj5ZbtmEuFZGIJ5XC2j7bR2582EDLcfjRAa8t+CpyqyF0AaLSc8bzzqB5kK7y6ZlyAHXztcC8JkJu8PG7XOs1OUxepafjZtkXgk0IwoslMFlQN2rnr8iQiEf+UdwHtK6XLnQtMR3m6TmrtqnAcVS7GwuulP2QPalfwPY/108YlvTvjAucMmUEElVGAU6Y8wUPAcT7j1OEtyk1LyCBJhJ02xSKyVjq2T/6E3QdwWyH5xXkncLzxDUSgc6cwJoAlL9CSwmmEZ1kETL3rZiJG4RsMCUf4mw7xTDxTIicax0iXPQvapVCL2j/Ejbgunw2fv59ENuEsPzzd2siFk/2Vdg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7fdae3-f85a-4bdb-bc1e-08db65a7014d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:26:55.8747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4hZ/c1HdDfGaQqs0s+mTWqyFXpyCr17Ks+hucbJzTJE5T0aNF68r0Sm+P2ealesAMYxwHgC6sESwSkS2GGPmzRrkP+xmCN/PsjHiWhueLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/munlock02: Convert into new api
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

Hi Li

Thanks, merged!

Best Regards
Yang Xu
> 
> Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
