Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF5BC7618E
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 03:03:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F32733CBCF0
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 05:03:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DB83C288D
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:03:30 +0200 (CEST)
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com
 [216.71.158.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BC5660057C
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1682564609; x=1714100609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=somQ7W7rHCvoxnojJrY+TbXDAkYLr3EQHmNd5eEsJp8=;
 b=io6Ej/ZrMxJCKk4wcqR8/CSJ9xioe5kR5sgHQkkpDSl8cfcpmNzOwl/6
 U1jpOjGVJQBTwpf4jC8UCpbioWz1sSSB8lIOBb5trVd8f95hDHMQx8UJt
 iA5PFj7+iGPahNulzhMa+3pYmIcr+FqDP11fNVJTob6KR4jq5Dwanv4vD
 WU44w7Stkdeo4tWzQ5DnWFrM1YSbVBtgm8GLSoNO+pAbQzbTlpyW50Dy8
 VneYkOF7bOaOiLWPiOCzHfFRfjwYp71SYikppesKgkNzQJ/NSW38y1SrB
 xLyat0O5PVYVOGfwXOr4cBJyxw3m3z7moLfuJOwJCQe+gayaNKWzAEhjc w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="82692177"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; d="scan'208";a="82692177"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2023 12:03:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESCRgx9UjOnbzP73jVhi+uBy55NCmUxh3budFhcP64gblT17t7R19SOyKkHR3aeYSMWxdPrNwluj724EN9L+Pw3DwbUt1wxAUU/TWZPImyrW/xRO1fMWoR0Z7FdDDSK5t6DJvfDqbTKqheqzAUD+GJp98sQeRz1QwboAwbXXdjRDT4XacUZRb+aBgUPWBTmBv3a2qEUwQNLMNDTuz30JlppOAKQKkT58aT3royaaP37vmJGfxs2xyh0WQJW1GaX5pav8dcfSHNal0VS3Run+YLxJ0M86W8SSBP3TawCRT3RkgxH8LpczL1G0h6/DT5ySSZRgfD9o/jKCsrVkBBI2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=somQ7W7rHCvoxnojJrY+TbXDAkYLr3EQHmNd5eEsJp8=;
 b=U79WsX94wAOf+FmbP2Wq+GugEHia9mkccisCFFUPCfYcdZw9atD8iqZwbitnPhG3wNKXTxprvrSkQ91Nk5pZBewhXCnErHTOQVbEJ8+Kl1N8W4nh/wPHtSqJclW/lpJIbfKPFjY0y4XhSTLl1/CuidCMrjmKhybTyEXZQWklXMm4eDzR5jBAKto+ts20P31qgz+PCTvf/UshqRDSV9tSsgUFXSSCup7qu5SW0CCxlVdRKuYbb8493+8t4YBCXkT8XLY5UMZpto4d0eg6D1XC98OIWo0e/tWvV0nn3QhzaNQj8T5ghPd45LlzoBkRbqMllYEY/xIg6D/2+d+4dyqXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OS3PR01MB5958.jpnprd01.prod.outlook.com (2603:1096:604:d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 03:03:23 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 03:03:23 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v4 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZaEpelwVUoZfRMk6Q/iAgJbfD1K8+Rj0AgABS04A=
Date: Thu, 27 Apr 2023 03:03:23 +0000
Message-ID: <b1f3f7ee-6f90-172c-520a-fd6ddc23363f@fujitsu.com>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426220654.GD58528@sol.localdomain>
In-Reply-To: <20230426220654.GD58528@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OS3PR01MB5958:EE_
x-ms-office365-filtering-correlation-id: 2b2c07ed-8814-456b-22a2-08db46cbf6a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2t6wb25OS/y2mRLHC/VmlRozsqylHfC1ifhL+upCuz3Hln11WvfVnKZwP2+C09B1IRNtUUvLgjJeCHQk09nTSdxGdG+jBQGgw2utf31zbrnSvwsL3kdRc4W//oq6W+GLWaIrPPUO8EAvOZCbh8VLRSL7n2+LHMoRPA2eSLR6OZiJ4pzkv5H5tlA8qPwklJPHjcWY0m3s+C+IaQ8are0PQzYS14b96GbivRrvv+DlpVum4lAbTXJYN1PlGPTunOMP3N0KAVkLXLjUZjadifRSco5TKwAogJtGZrwvUljDaf17lMsU/O3yI+Lmb1+qNTgi/dDqPU5kqkWRSN3vNBIFYPP/zgRoMDq3VKzNtaShpVoW8wYg1UuEdqrAsjGogl656fSsBoX8CCeiLcZYRrbRo2D1waaDl3d4ZRT64FCCOpuN4HZYd7CcInG2mZ4UfEXFArN1oIrw0qs+g15uDjakss0W3wnuktPyZw8c3jkCjTMbE0SFLKOKbR5X9zq36bR0ffllUQ73QHBVWMB90mGA2/gWw3iiPhqO8ZsllSunehyvSVbp3sVBiloQ3YkUFQAzq39u2AIT2X8CbWPbHJ9Hp8PMKDOAVQM8kGLFpnZkTgEtTR3ocaqVq+OAZT0zNwHKiLJZJMAbtbsuauJXYhJqiLjIrt71qSkLVmHB9/m5S4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(1590799018)(451199021)(6506007)(38070700005)(1580799015)(316002)(186003)(76116006)(66446008)(64756008)(66556008)(66476007)(91956017)(6512007)(66946007)(26005)(6916009)(4326008)(966005)(5660300002)(36756003)(31696002)(85182001)(8936002)(478600001)(122000001)(8676002)(83380400001)(6486002)(71200400001)(38100700002)(86362001)(31686004)(2616005)(82960400001)(41300700001)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRtMU9sbmdTY2J5ZjhYTEtIYkpvZG16Y01DMXVuQU5YRkRZUStWbjJiNjJY?=
 =?utf-8?B?T0E5UGIvS1JUcjZCci9IT0lGR2Q5U09tZUVUcjJ2UXNUZlRyWVhpOThFc2pX?=
 =?utf-8?B?YzAwVEtWVE5vdVZlOXRCVHRrb1VYeWlrSlUyZnQxYXZwUDRZbi9Vajl1WG5m?=
 =?utf-8?B?LzhOc0Z4UXM3Qm4yV2pFejNLdUFKUzBudUJ6cGhlQjEwVHRtTkhiSDNWTWIr?=
 =?utf-8?B?WDF3QWVKb0tWeWZxekxVRU9tK3lmOXczNUo2YUVRNmREZW5rQTZsM1ZJYWpQ?=
 =?utf-8?B?MWRBS0RsTks5cUluVXlzM1hPdzA2UlVNRlJaNjBBcXpBZ0JPSXpjOGxxNjc5?=
 =?utf-8?B?Y1ZuQ0R1VktESDd6ZFBRM1pTT3VnOXZCVWg4Zmp2U1ZSOHc0NlNiSlViR0lz?=
 =?utf-8?B?Z01kbzZUWWwxcThSOFBJcE1EaUw2VEdNUkVvZGNDbjF6aE82MWZiRXI0aXdu?=
 =?utf-8?B?QUxLemRWM1o3N2xaaG5malhTOUZQTlV1SW5jNzJXeVBHaHRsZFJzTW9xMjE0?=
 =?utf-8?B?UE5NODZLdXRLOXFhR1FHU0Q5S2tLczJsNHdOYnlkYisrU0l6eGVYdHd0cEFH?=
 =?utf-8?B?L1BPVWVGdElyZTUxUHU2NzFVRlZzcVo0czVZazI2Y0oxRjdpZzhxNTRvMi8z?=
 =?utf-8?B?THVSWFM2S3Bwc3VnaXJYV29uQmhRcEk5Mk5XbDhnelY4NkcvRHFiOTVXbHVU?=
 =?utf-8?B?MFJ3OFVsV3NoMll0L2Z3T1E4ajFZUnVRYWVjMXh4N3FIZGxib3QyN3Q2T1dp?=
 =?utf-8?B?OEw0djlhc0FuMStIQU41Y05Qdk1MUXNpSEFkZWdXeTY1SDE3bld5VWdkS2U3?=
 =?utf-8?B?SGdzdVpWbjMvdTdOTXgweTZBU0JNOS9RZkVycFZmbUV0TEhBYVVpcU4wK3VQ?=
 =?utf-8?B?Qzk3Y3JVU3pxYmpKZzNZT2NYdjl2YlMweW1WK3hDc1FYRmF6NVk2bnlnQ1VT?=
 =?utf-8?B?a01ETElRMUtlMHB4ZXpOWDBwT3Q4WTVtazJrRjVVR1NIWmlEQ3NERFNFSEps?=
 =?utf-8?B?L203QVhIUG1UTW43TVhYSUkrdGhoSEV1SlpWVSs1bmxNWU1xSjgzUXRRa3Qy?=
 =?utf-8?B?TGtpblNoNy9nNklaUUtnRWhOeFlUdHd2T3hLZ3lsdGxkV3VVc3Z6aE5EU3Rm?=
 =?utf-8?B?VTdSa05IQTBRUlNxUmJMa3B0dWV4T1kybXBLK2d0eExDQUNQVEUxL3pXNjg0?=
 =?utf-8?B?L1lKNzJ4VlJMQ0lzcGhCZjVic2NCU2xHMVVsNVhZSzE3T1pwVE9OeHRtSUlK?=
 =?utf-8?B?T0VBdFRzZCtZQzhjVWx5eFhPZ3RBalByWjBJcGpXejhQa3NZRTViT1FudmlQ?=
 =?utf-8?B?RlRKMHlBYTl1RVk1WUNnRGhiczRoc3d6VFd1VHBGY1dGYk1SWitVakFCN1hY?=
 =?utf-8?B?TzJFdDdLWnBMWGJMZW9yeElvSHI3RzBVNWF0MWdCeVMyQjgvOWVYaWlXQW9N?=
 =?utf-8?B?OVZxY0JjNDlrNUZadVlqZWpjUHFQQkExMVJGQTRud1dNMFAyblg5TkVWcDhK?=
 =?utf-8?B?S05ML0FtNnMrMzNCTUZLMVREY1ZoMzJqRlFmajZIZ1FVVXpwV2NWRHIveFY4?=
 =?utf-8?B?a3lYUWxnM3pzRlNBd2tIbGpMY0R5ckNGSi9uUld0VnlqSmhtZ29sZ2E0enVZ?=
 =?utf-8?B?Wjd2SldzeGcwRVFzVFhTQnh0dStjZHFjcnNOZmJBK0tpSVRxaGFadWw4azVo?=
 =?utf-8?B?VE0vNDdtVnpTeEhHS2xQQkFnS1NSRHAyWFg1eEtaN3l5MmJRUjFONjVMQWZp?=
 =?utf-8?B?MjVWeXc5a3NJb0Z1K096UmN3U0xGWjlyVU5rSEYvR2dPVE4yelhOSFgvc2Yz?=
 =?utf-8?B?VUVuMVRFbklyczJWMUlYeEtXeWQvam5MN0NtZncxNnpCUkgwZldpTTZ2WnNy?=
 =?utf-8?B?SWs5dW5DNmI3WGhKS29Ma0NVVmdLL2xRb2hLMTZtK0ppVEhoeXhHSzVVR3Jm?=
 =?utf-8?B?d25zWkZtWk9aYytZUllaUXFXSjRRZ08zWGlYejNEaHNld01WbEtZRmZ1Umsx?=
 =?utf-8?B?S3F2WWg1MmF6aWUvU2Jyb1JjT01OTE94K3pINCs5SDF6TXdvQVhSV29aYkRK?=
 =?utf-8?B?N0VzMGVOUDhCVFA0elhKS2IzUW1NY2lmbDBBUG1wakIreU1EQ0xodGhSSlk1?=
 =?utf-8?B?LzlFcEsza1gvUzBwdC9RMXpqUnhnY1dkM1Q4T1p1d3gyL2xDbzBPcVUzbkdC?=
 =?utf-8?B?TXc9PQ==?=
Content-ID: <9D2A0D7200C7C542A876BA9145ECEB85@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J46k0c5UsW3XrsiydaYLqTHWfYl0+a/Sruc5RuHOMfkPI3ja2CTTg/xTnEsLGaw9R1/ofjKftdYG7ueMAP9k+q3z67WJwpe25jAm5Bc6C7IgxAxsLYZG3IhFvFYpWFIdqxNn4JVDFE/QqgIUEpgDTsR6YZwZk7Q5I8KzIDKn8PrsOsRX2o7tfhp3OLp6R2Cf2/Ntrp35dfpm4TK8DdBL8IpNg4KTdkApccDTsOfNhJFPFiGlNW7k0MaE+SKEpTShmShJllJ4zDd7Z9FEuZydHtKGUypS0UPSyEuRntntI1W07x0puee772qpKaqbEjT+j5Pd3NA+XXmxF48nOdJ+Uk0NfTfub0I3xcHnE5mgXuk58/O9b8Ms7uCQxxOv7C43W58oIPB4JRVL1OBnUrUit5LzUUw6fLkB8DNmTPPu40Hkvcrlu5Z7TzO6FXlrpcxcETSJL2uDIZftg+nLDNRQSpN7h6AZBzxa+75RUjAuliKLsLlhPmvIZ4ZbktxMGYDN1p5H8znFhS8Y334nN5OG1ThV/HX0U30IE/HRskaNA49aeTbA4gTRJQrPbsE+/TjqilrGODCRFreXRVFludozDkzi9sAJZ0aRCUuDYOW9N2T+jbOWWRpSe4Bhl+8GWTrIwOE8Gmta67ad776GlyeNXHmYqyeTtJlx0Z+RkiahF2eUe4vp2U+e1GNHuXVSsHSC6TQbYjMl9JBX5jEG3XfvkHPeebaN0tb1VwXrXnoQuIs8EDQ+fGLtmJ2p/WxFZE9NjGm3XLEZitgsyutr/3U/SnJbGpUE0puOoToLeq6xb18=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2c07ed-8814-456b-22a2-08db46cbf6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 03:03:23.3194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UY5Ll+3UiB0R6a+jLLkxyInpkd4PUyIyN2oRHj5ZW080ipR2sjTnXMPypPgYbWafb7XUhGZE5Cq4zeZ46HwkUHtPngOgZGsyMxb2rf17Oyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5958
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



on 2023/04/27 6:06, Eric Biggers wrote:
> On Thu, Apr 06, 2023 at 01:40:20PM +0800, Yang Xu wrote:
>> + * On ext4, files that use certain filesystem features (data journaling,
>> + * encryption, and verity) fall back to buffered I/O. But ltp doesn't use these
>> + * features by default, So I think dio should not fall back to buffered I/O.
> 
> Does LTP create and mount the filesystem itself?

Yes, I have enabled mount_device in tst_test struct, mount_device usage 
you can see the following url.
https://github.com/linux-test-project/ltp/wiki/C-Test-API#115-testing-with-a-block-device

If we set block device to LTP_DEV environment, we use this block device 
to mount. Otherwise, use loop device to simuate it.


> 
> If not, then it wouldn't have control over this.
> 
>> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
>> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
>> +		return;
>> +	}
> 
> "Filesystem does not support STATX_DIOALIGN"

OK.
> 
>> +
>> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
> 
> This looks wrong.  If the system headers are missing this field, then the
> definition in the LTP source tree should be used instead.

Yes, usually, if system headers miss this field, we should use ltp 
definition ie some macro.  But here it has a little difference, it is a 
member in a struct.

see include/lapi/stat.h

#if defined(HAVE_STRUCT_STATX)
#include <sys/stat.h>
#else
struct statx {
         /* 0x00 */
         uint32_t        stx_mask;
         uint32_t        stx_blksize;
         uint64_t        stx_attributes;
         /* 0x10 */
         uint32_t        stx_nlink;
         uint32_t        stx_uid;
         uint32_t        stx_gid;
         uint16_t        stx_mode;
         uint16_t        __spare0[1];
         /* 0x20 */
         uint64_t        stx_ino;
         uint64_t        stx_size;
         uint64_t        stx_blocks;
         uint64_t        stx_attributes_mask;
         /* 0x40 */
         const struct statx_timestamp    stx_atime;
         const struct statx_timestamp    stx_btime;
         const struct statx_timestamp    stx_ctime;
         const struct statx_timestamp    stx_mtime;
         /* 0x80 */
         uint32_t        stx_rdev_major;
         uint32_t        stx_rdev_minor;
         uint32_t        stx_dev_major;
         uint32_t        stx_dev_minor;
         /* 0x90 */
         uint64_t        __spare2[14];
         /* 0x100 */
};
#endif

the ltp definition only can be used when <sys/stat.h> miss statx struct 
instead of statx struct member.  It seems we don't have a better idea. 
Or do you have some idea?

It seems we think this question more complex, if system header miss, 
then use ltp definition, then we can not figure out whether fail or we 
just on old kernel.  Except we add a mininl kernel check in  the beginning.

> 
>> +	if (buf.stx_dio_mem_align != 0)
>> +		tst_res(TPASS, "stx_dio_mem_align: %u", buf.stx_dio_mem_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
> 
> For the failure case: "stx_dio_mem_align was 0, but DIO should be supported"

OK.
> 
>> +
>> +	if (buf.stx_dio_offset_align != 0)
>> +		tst_res(TPASS, "stx_dio_offset_align: %u", buf.stx_dio_offset_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
>> +#endif
> 
> For the failure case: "stx_dio_offset_align was 0, but DIO should be supported"

OK.
> 
>> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
>> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
>> +	if (fd == -1 && errno == EINVAL) {
>> +		SAFE_CLOSE(fd);
>> +		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
>> +	}
>> +	SAFE_CLOSE(fd);
> 
> The open() is not checked for error in all cases.

how about the following code:


fd = open(TESTFILE, O_RDWR | O_DIRECT);
if (fd == -1) {
	if (errno == EINVAL)
		 tst_brk(TCONF, "The regular file is not on a filesystem that support 
DIO");
	else
		tst_brk(TBROK | TERRNO, "The regular file was open with O_RDWR | 
O_DIRECT failed");
}
SAFE_CLOSE(fd);
> 
> Also, this is closing the file descriptor even when it is -1.

Oh, my mistake, sorry.
> 
>> +static struct tst_test test = {
>> +	.test_all = verify_statx,
>> +	.setup = setup,
>> +	.needs_root = 1,
> 
> Why does this test need root?

When using /dev/loop-control to search free loop device, we needs root.
see below:
tst_device.c:108: TINFO: Not allowed to open /dev/loop-control. Are you 
root?: EACCES (13)
tst_device.c:147: TINFO: No free devices found
tst_device.c:354: TBROK: Failed to acquire device

Best Regards
Yang Xu
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
