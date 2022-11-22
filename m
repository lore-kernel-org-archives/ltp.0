Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931F5C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 06:40:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC533CCAE3
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 07:40:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9040F3C1B75
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 07:40:02 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A4AB91C24F8B
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 07:40:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1669099202; x=1700635202;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=Q5sn1XeoCHFj1Xf2FeUjBaI+Jw5KWNELw4bn8yzFGIo=;
 b=kPeaAWdQgoRva+blaTGKQNVSxjRcQedoZeNasDF4lA515PgvgHgsOXyE
 hghBmBnIgkFjQFDiOf4Hl7SuDnrtV5tyy5T7e+Qi29VcSAXyX/Mkz0C4S
 ztwVPO8i1GVAfBCf/l4xhSPFa4RFgt9BLLBTyeNm/r7SpG6d6zXfqT8Ow
 BASx1swkCCOL2aFs5uy1+IT3Ujx8MYTpT7KdKEUOTqhPL0/Vw4XSSX6tD
 i/0PcTlYx6thYgbQvyDNvGUebHUcdSh3ynY5GwXLvde6Gy/jMv5qdh4+q
 3D3rxHrmVuDq1iCVo2DKH4H5FMrACnhvtBTs2b20d0s/DNrA3ILyNIoT5 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="78838059"
X-IronPort-AV: E=Sophos;i="5.96,183,1665414000"; d="scan'208";a="78838059"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2022 15:40:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNxtiC85qiaya4Znl3YWEamwsW8IgAujD1jOmHkSv9TdcveJVHVm2Yk6fUXzJI448nEBoJ9NaGdq8oCVK/UAmX4Kw0moNTx3q3g+EI5z7eSFYX9kT7YPWu0d6TEF82hJ8P2YFIsxgmONjAWJhMg+ndrTw3asAevrlTJLGxH3wlsdCNHZ3wz3tQYad91WWofK22qVM1MhRFKUUIzPZDOOcU+MeNITKRC8rs1IZ8BUOZyGQ1FXSMEOP2CXnjpsewWwoqfkFoEugVN4vYi132RcwIVBQKYJPJ0WxdIa9gee9hfHHRWFzvsztfjVtgbFA++rqJ+ul4bNXW84VjzVLn3klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5sn1XeoCHFj1Xf2FeUjBaI+Jw5KWNELw4bn8yzFGIo=;
 b=DcYHwHRGFBllQCyiZ+eeQPXIe4pBuTBUkrWlx2HMPpSoBvMJ/AlIEuN2EHeNnqRLfq4WsmSctKZTgxPGRuBHpDygFUDCv7sdL+RhN5zcla2hfQ9YxeyOHOHb53lwlcpE2zpDbS+W6yRs+JdVo8cAlVY+gmuEGj3DYdsw8mDsP/yVldibnWt1QnWsfSkbJYCrLyNeiTZrg22dSz455aBHbNmJNpaJd2Clxv2BaWsUXNL7UFLce4tWi3Y+FCZkcPdGwyA7lQEv7rSO31FyQmnYoWYwTbwxhUIY0gCXM/zHPBZp1yShsrg63RY3YMXSaYBxOoFVolh6Q5WXSlcweB/AgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB6288.jpnprd01.prod.outlook.com (2603:1096:400:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 06:39:56 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::969a:5a0c:6455:b5%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 06:39:56 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: He Zhe <zhe.he@windriver.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
Thread-Index: AQHY/BfLAOaO2YjL00ujcKutjhlrY65Kk1aA
Date: Tue, 22 Nov 2022 06:39:56 +0000
Message-ID: <792cc0e3-07a2-3d5a-bdf7-2c2f56a80165@fujitsu.com>
References: <20221119130619.10107-1-zhe.he@windriver.com>
In-Reply-To: <20221119130619.10107-1-zhe.he@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB6288:EE_
x-ms-office365-filtering-correlation-id: 39e04ed9-52ed-480c-6cd9-08dacc545eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkQcLRIwg+KMfJ/dJ1oNEXbkFcKbM9ONLWu9AmEHjsLQSClJPY5xWjeS4RwrIePlb+OM0mLhJ+lB7wR1VssCrjdgl7VPGPl808ddfJwU8kGa87/yOy8UBXaz/w36N2o5mvE/yVI+Bxu6ZxVxnTI2kCEY5t+UvHqROH4SsV3RGbJFg/kBHoGZYvWl24cQWmFuSeca1rI2NebrVXlsJg8XjLbbwFarmyzLf975k671KgdeDwmnStitI7K89eW+gF2sBKAJ9vf5bLVwTj2dsIRCzCXcGdGK9z5Nf31EFO6VVX4BT0GbzGdAmtpSXTHimD6yq0iBOc4V6OcRajMgd+vIkO2kmxB1t5mIXeqJbpuEl9Eu8OEz9cite49RDC7eqATNax0lsYCxocm7j4qyVLt5seltEgAIQn08GS5CyaO9aniWJ6c1YITYKhBTA5GYYfTLDbLTGTkh93ksJYxA6sPHtVXWH0b1EPU/J45XeWiQAdY96YXcnEw+oYLNG4PPoEODIW6vddAGbDTMX6pFBC05e5j8gqhETkTiWcBBHL9G7iILDOHFIegtctMMj2brDXo8oGGULJq9teIicVhfm/N9xa9rFCM0ZTcMXFT6N1tPYeop0TLnRdQQCKvL5fGoDq8SOwAp+arWP8tJSJm4rnNal1vc0ip6P31AeHKm9H/xQIi3HNI/rY3lwB+QKzUN1F3aXtHpJ45NWBnR0w4z+C4wkWMFfaQwTnLgwJ5IFkobJNo9IJkvqFWpXZYriSXA72eqYlHCVWlSeUpqnu4QmvUgwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(1590799012)(451199015)(82960400001)(122000001)(38100700002)(38070700005)(86362001)(6506007)(31696002)(26005)(8676002)(2616005)(186003)(5660300002)(316002)(6512007)(71200400001)(66446008)(478600001)(76116006)(64756008)(91956017)(110136005)(6486002)(66476007)(66946007)(83380400001)(66556008)(8936002)(2906002)(41300700001)(31686004)(1580799009)(36756003)(85182001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBRekQyMlJaNDY0YmlyYm5NWU1xTE9GNWdFMkNFOGd0d01aL0lMWGN1bU5t?=
 =?utf-8?B?KzRGbHYzM3ZhS2swQU0yWWhoc01RbXh1djZudWFIM1lTVlBSTUFwT1Fualp3?=
 =?utf-8?B?emxyUmlBU1dGMzNyWGJ5TjVHNXFJVXJSRGFNcVdRbzdMSGRkL3lZNzZnaHlH?=
 =?utf-8?B?bkkzaWNlb0Z4NVZSRFNsRS9CZEkvVU5iMFBjUFBBQVFMY3NZYUU3bFFkRnds?=
 =?utf-8?B?ZFRqR3hyRCtFNjZ1RzRIeTFUaFdzZUpUZXd2a2ZzSndoSkRDUDNNekdoOTFC?=
 =?utf-8?B?VEw2c3VXeU0xcVpiL2UvR3RtMWptak00SllCRDJDNlQ1eHZyZGtMTjBiZFNa?=
 =?utf-8?B?V2pVdTdYd3l0ZnY2dmtDaU9qR2s1QktteGlicHB5eWQ5eERFdjZ0RWxTWWcv?=
 =?utf-8?B?MmxmT1N1MnIvdGNsSnBOZEJMQW1wakhjRmlPRUl1aHBRUzAvQzdnQ3gyaWlM?=
 =?utf-8?B?ZGgzQlFCTEZqWWFCbkhNUFhyVVJlT3A2MDhHOFI5VFdZemJxQVJsMDU3T2Nr?=
 =?utf-8?B?RFlUeklnOUtMQjNnT0xSU252bHNzZzhMQklseFk1SDE3UUNCSlNrNWlvMExj?=
 =?utf-8?B?SEd0NUhkbks3c2FIbUc0d0FaVWo1eWNKOVBpRXlHM0l3YnFjUlh5MGVYVXFD?=
 =?utf-8?B?RnUyVnQvVXNTSDVYSjVuYThxaDhwRzQ0WXIxZy93NXNHZGtKbTdFekhVdzdj?=
 =?utf-8?B?WHVtOW9hdWcxK0Z6bVN2bDM1WTFWMTNoUHlDTXl2bUorTDhYVlJ5eE5lR0xw?=
 =?utf-8?B?czVuTW1JQnB6WlJLWDh1NGszTzVOSkdCenlzWWFUUW1qV2NtaWV0OUl4bnpI?=
 =?utf-8?B?YkRHamQrVXBiMHFNQ3oveE04RkoxM0hjdW1vdFFTS21wSXBRS1JWazBOcTdi?=
 =?utf-8?B?bTlWZ1dwai9VNjZqU1ZsdFpVWG85bDRXS0ZxemVJZ2JrNk9EckdBaGNTRFlJ?=
 =?utf-8?B?d3ZxYnp4UWpXdlRwNU95Znp2NFRXVUErd2NXVjBoOURHaE1PMG9KYytTaXNF?=
 =?utf-8?B?TlBmMk1QQzAzUXdnS2laeStjVSs0UklXaEhLL0RSYWh2SFYyZmRTT3F6ODZu?=
 =?utf-8?B?bC9sUDc5UDRoNDBmcHhUdGI4YzB0KzMwNGptdWdUQW5VVGIxemliWGFYMXoy?=
 =?utf-8?B?NStDcDJsSTdjYVdvTlNPSW5XM1paTTBEWWo4V2pFSFQxU2F1Sjc4OUkxdHMx?=
 =?utf-8?B?VjZuVHVKck9IbXN3bjlHdzh0SEYvdHZ0eDlxSUp3UEY4Vm9ETWRtNUhIQzJD?=
 =?utf-8?B?RXFyZUZQbzFta2l5clVUK0dHR3FEejhUUG1GNTU0L1ZhR3pjQTMxclFNZjJt?=
 =?utf-8?B?TStHWGVad3VQb1pzZ2tvNTJPVmhaRTliZmR3M0xsK1RWVVhOWHpmZS91dmxC?=
 =?utf-8?B?Y2IzTHBUcERMVTNjMXVrVUhDYnFlV2MzakNrYW5OSjB6SDh5Z2UyMFZURnFV?=
 =?utf-8?B?dnZhVzM2cFV6Z05YZVFCcitPMWZBQmZUcC9LS1p0T2paUFBUeFp3STY2b2dm?=
 =?utf-8?B?ZG8zeTI3akRMdmNCUVpJNzZNMFhKU2M5VVh6K3BqOXBwcC9CQkU3TVBjMGFP?=
 =?utf-8?B?bnRGcHo2V29UL2lld3lodHF3MUtRa0tIWGVPQVplZnZkbDZuaVM1TndDR0xm?=
 =?utf-8?B?Ri9kWU52aFdUMjMzNENHZ0dSRWcyNURZdk92VUtMcnZJUldBUlMvY1BubC9o?=
 =?utf-8?B?YUxrdHR4NzlLRDd4ZTdaQy9YODNBWXE2cy9MaDZlMWlEdkgvVUhkbE1RZjFM?=
 =?utf-8?B?NC9xby90R05UQ2hscnZZZkVvTmZBRzBXdVhtV0tvRHJMc1F4eDRGUmxoWTBF?=
 =?utf-8?B?WnN0MmFhdm1nZnk0aDZZdCtvVkY3Z25FeDFtOGJGanZ6M1AwK0c1NG5XWk52?=
 =?utf-8?B?UVlOUmNIUDIwV0xMTXVHVytBSnN6YXVZSi9GK0NZcGtGV3BabnVNakJrMUhH?=
 =?utf-8?B?L0RpUEZYdHJTdU5PQ29oOFNlMlRnRXZIdExsK3FETThmcXAxemVDeXJTb1Rj?=
 =?utf-8?B?NjFBQ0tjbTQzeWl6RHQ2c0dYSlJ3aEdLWnBzRldQa0FQZUU4dVRoSTVvREZZ?=
 =?utf-8?B?YkxGbzBYQWpOWXJLZmxCQmhYSUxUOFNxRmxUL2pmcTdGd2FVam9mN1RpV3VC?=
 =?utf-8?B?ZFBzcWczZkRTVUpJODlwNC9IWnZhcWJ4RkdCT01tSnVXb3VZbVloOERaUmZ1?=
 =?utf-8?B?RXc9PQ==?=
Content-ID: <A8E08052AA3CE54B9001191276BEA865@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qeWc+armN21OWF3zXtfxGzlE5tmi7RUkeziWJEuOqayCCa+8YdCCgQhfHUwwxtxT0SZWhwltlAtO0TQsVwfanHFjh5d3Y6FPH6C0Nwsp8COVmIuploj08kcIkfD7PbB/inzH396jpCRJhYkQdnlNe0Bp3CKdKEXMLZ6UMnmhqQXcV76A5Zf4EpAVjs7DotP6kA0LoifEZxHsXPg8Rs70H+P5A4s8xqAcLGOSf8CT4UMScabkoHAzUjAB2/VAXMRYZAp/rPKYvk5zh1XeQM80XGGOMlIWI/JFlPBgxCzVXEzChJ62ggiz1NTJoofOBaYM4s1jhXGPQLpuoq1hObjcEkvPznREJ6pXPlY98enEwBYm4VSa+hYLfaUz1p9G561x/Enl4v/fxwIwr6flCjqlJYRYSJATU2nQsNqbLD+yXbbFoGWj/kdwml7EMrKshrkPxJ6fzMme91RfI/NcTyWWJDmhUDN4mSNL9DFdiI8aGZTj9EaAOAgUwqnDCtBXVSPEksNPh/Y3pPZA97l196jvQ66Cb6TvVrbgNAhZEal5xss8GwbdO0VElMZtVN38EaldcZAzhmgllR74gUzWrxbH8wbmZXCUbdLFSGxwLdPlEzOc4w1uy4MS3WfvYl12JT1+wcjwu0yJnhppo/wgAtjAWztyirYy3jlW2Q6m6bLo6ZRJPBNayjsE2GOlYZm2UVPBn4047H7rXlPho4yqQkMSM/EswbEDuV3/8MjGMq9N6GVzgiydaeCLESiEkaBPZh9ERMMpSgz3A0HgxJ6h43jtgU39UgsCiPsoswfhNkIpOswQ1/+shN+3a9YeB3CzWgz3
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e04ed9-52ed-480c-6cd9-08dacc545eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 06:39:56.3751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AejlzmFoXv+H1GzaYznrdZ8GVNqB4K9R217xGSrDG4BHDFYsci2Ga3WJGDooTjV9nwh2axK9HFPWlMoee8obIoQAtQhLrEuVxu7Y9wvPpxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6288
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi He

> The child process really should not receive the expected siganl, SIGSYS, when
> kernel doesn't support SECCOMP_MODE_FILTER.
> 
> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
> variable to record it.
> 
> Before this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> ---- snip ----
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> After this patch:
> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> ---- snip ----
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2: Add a variable to record the support status instead of exit(1)
> 
>   testcases/kernel/syscalls/prctl/prctl04.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> index b9f4c2a10..94e8db273 100644
> --- a/testcases/kernel/syscalls/prctl/prctl04.c
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -93,6 +93,9 @@ static struct tcase {
>   	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>   };
>   
> +
> +static int mode_filter_not_supported;
> +
>   static void check_filter_mode_inherit(void)
>   {
>   	int childpid;
> @@ -158,9 +161,8 @@ static void check_filter_mode(int val)
>   
>   	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>   	if (TST_RET == -1) {
> -		if (TST_ERR == EINVAL)
> -			tst_res(TCONF,
> -				"kernel doesn't support SECCOMP_MODE_FILTER");
> +		if (mode_filter_not_supported == 1 && TST_ERR == EINVAL)
> +			tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");

I think we can move the mode_filter_not_supported to the beginning of 
check_filter_mode_inherit instead of here because we don't need to call 
prctl again.

Best Regards
Yang Xu
>   		else
>   			tst_res(TFAIL | TERRNO,
>   				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
> @@ -208,7 +210,7 @@ static void verify_prctl(unsigned int n)
>   			return;
>   		}
>   
> -		if (tc->pass_flag == 2)
> +		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
>   			tst_res(TFAIL,
>   				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>   	}
> @@ -218,7 +220,17 @@ static void setup(void)
>   {
>   	TEST(prctl(PR_GET_SECCOMP));
>   	if (TST_RET == 0) {
> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
> +
> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
> +		if (TST_RET == -1)
> +			if (TST_ERR == EINVAL) {
> +				mode_filter_not_supported = 1;
> +				return;
> +			}
> +
> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
> +
>   		return;
>   	}
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
