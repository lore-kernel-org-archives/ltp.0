Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E76DC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 02:36:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39E03CEB8C
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 03:36:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 038AA3CE988
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 03:36:13 +0100 (CET)
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com
 [68.232.156.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EF851400E1A
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 03:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1698978973; x=1730514973;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=49Rnv3qhZxImbusAV1j/9Rv2eCX3+t8hTOkB1DYBZ9c=;
 b=M+S5ggwM7tyY3cO+ye1S1huvoesBp3iWCSEw3P9oh9filR5pWBEnY4ME
 ivYxQ0jKab9ZrMMq8zMpuLWM96QP2GX8dElQU85o7r7DmAuRLn7s5+Lcn
 8Sd5lMHI5UOzkhILwarTw/ymkwGw+2K2flxoHcaKDp/xNQP9Up/ZB/OYs
 cvOwU2csDBw7Gwci33gX2spI9nK2FFjMh+FwLHPFNSQZ2YR4ipxTuRiZR
 oKoDtjcM4D+JQcmZvB04XqqVl0ur8CXuKe9/DQFkec8L2adXy4OjoB86j
 umRpiiLqZ4N72m9J8poHr2pXsRyWCpsaiIeepGr8k6DgugRsmc/N9qC2Z g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="100941768"
X-IronPort-AV: E=Sophos;i="6.03,272,1694703600"; 
 d="scan'208,217";a="100941768"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2023 11:36:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV51N0WGnU+TdT4kJRIKDhbPKzlyOI1CQZMQ4ecJY8A7vgzyUtqjY26u5gDu5+iP9TtPuHEm/7J0cCL9AZ9KIlg54Ah1tKno4CjBxp5Gm+afLjAghVvbEuMnwVfkq57OIGTZUyL6jimLuJDg2A03ZvKPpLhXxjkYCdChZvRm9jKTzzaIZUYlgILVDTE2nsCJBGzTp/1fSVfuT3+HU2SHEfQY/K0HwyB1JsZYGVFThqnIgzcNpwr/5/gyoEGQR8sdZO9hg7jw2MQ7+UvfRi3uT1YYKUlmmVfPVLnqzXEr3F7HPLgQ1TW/SuYtu55UXniSonyK0xEJHBiMoynSGiNEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49Rnv3qhZxImbusAV1j/9Rv2eCX3+t8hTOkB1DYBZ9c=;
 b=L14xSFnTsuzfQC/h1NYWtz8Xcu8/Dk+qjKGKTMxz4AZz8WrUtFMmpKRrofsghtT6LuezNpSE7lTDPbSq5r6ZwR/NBM91eWWXeLlMayNIjPLr3FX6qZuvETucF/AiilEvrOKxeW9NlbaGWHIe6pKnCm74Xn+SW68dzTGr09mN+24oPaX0jYER6NRg2eMBTcHsdt0Sbo15sPpZ5SE7d69PKt5f6IR2H5RLXNz+nFBLkBfqg/V11pikncLj+kF+66vFXTuIQ9s0C4KKz5JqBKuA38AXuhX2uFKFF4LTzCldiEVthaS+Q4NCkn8nNxLASf3aRi7ursI2xiV/lSMFSeSAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by OS7PR01MB11485.jpnprd01.prod.outlook.com (2603:1096:604:240::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 02:36:06 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::112e:4422:96a6:9fb2]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::112e:4422:96a6:9fb2%7]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 02:36:06 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
Thread-Index: AQHaAjfRkLYhkD9xRku7uff9ff+q9rBQcc0AgBeGhlI=
Date: Fri, 3 Nov 2023 02:36:06 +0000
Message-ID: <OS7PR01MB11839A29FC047F47431D3A88AFDA5A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697684152-29747-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2cbE5J+Ng-bC_sut1E5_M9LGgPWWrx58Gz=DKDbKWmeXg@mail.gmail.com>
In-Reply-To: <CAEemH2cbE5J+Ng-bC_sut1E5_M9LGgPWWrx58Gz=DKDbKWmeXg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-03T02:36:04.568Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|OS7PR01MB11485:EE_
x-ms-office365-filtering-correlation-id: cb9ed432-1ce8-4c80-da44-08dbdc15a19e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdA1zubojKbIcpIIHvhSYq58ZPLH6LyhhzdfdQnrbwf16uKUfZKfng18ZvpjJcrfgMzlVX7+fOEU+Gh6ExIWqj7W3WfYTzQ6vBeVTt+Buy9WnLuIcDzZRKXlUC93KBWo3jIrMdy9KIG7TwroFs4qks6UZUOx6Guk4KZNdPQRa7xqS+HFxYYDd7EIGqaINNSI20ph2RUPpE6I/rjVmk/dB/WA9SZh/0C9tVsz6OxwXF2JyrG6gcRbaPfeWWfnSDHa5toSfl0jo+WZVz1KA2rI3XEKSHjtNqYqBOrsl2/7RclNozps1LdLzPZi2ZFrnpykRj2SkOCpMmiG44NFKwh87krgbk/izd+lRzwAUvmVL9VY5BxoaB7YDNSplqrlvzvIVWfW4cUz7xOiciDY9hbEx8fgj5bxLf6nh5TwVkX/czrqd8eFNOfF7pU0OsK1B6kXFLFO3m96IW7nJIHwKNUK8W2J1BNBxrMPz7ugDdInoXf8sM3bb+YdosH+5c6mkvBQsBh4bGOWcasv6ObjNYzKsm++EJY0QwfCU2xjE/BH/PT9NSCIi11I3pnPGIlYvgNKcVWROGFXXzbA11JmgfRYuMUfu6FKEkjGeNUHnFC9zjlp7vPMF66Klws4WxaXBrTxSh363NOU/LmT0HYhWEi9Rg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1590799021)(1800799009)(186009)(64100799003)(6916009)(316002)(86362001)(66476007)(38070700009)(2906002)(1580799018)(64756008)(26005)(76116006)(66556008)(66946007)(9686003)(91956017)(52536014)(85182001)(41300700001)(478600001)(7696005)(122000001)(19627405001)(38100700002)(66446008)(6506007)(8936002)(71200400001)(55016003)(4326008)(33656002)(82960400001)(224303003)(558084003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dkc1UnZQZ0hFNGtqN1NxZ01CMGpReFVDNmpkbW5XekxZbkJyaDdXUCtLNldS?=
 =?gb2312?B?K25hVUpLb1ZCcGQ1amxiZVYwRVNHM2JzQ2pkK3pNL0pXVFRtcUUzZ2ppSnEw?=
 =?gb2312?B?UlZmUlFPejZCVUdaRFA3eWs5TklOa0wzWlc1MUt6ZURqMEYrdm9IMlhnSDV2?=
 =?gb2312?B?Z2Q4dG14b25xaHV5NmdvbFBvWDBCdmlrMmVVR1FEcVRVWmhFWnlmbExOdXJD?=
 =?gb2312?B?UTdIVyswWGtzek9EUXFZMGo5NDhzWTFiYVdWUzQrOTVOaVhEVVVjT1pBelNR?=
 =?gb2312?B?WFBZYXpwRmYwdzRickZUVVBhQTI0SW5GNkluMEdkRUhQOUJPZVh0SEV5L1d4?=
 =?gb2312?B?U1JJNzNScnZTZDM0b2tFWXBvZ2ZpZ0dLcHFGcEg2UnBocDlIdWI2aHlGTUJZ?=
 =?gb2312?B?MVFmZ2taWDJiQ1F4NzA2Q3dmcnRXdTlRK1Rxd0NRQ2ZQWGlpZzhReFdwdnZ3?=
 =?gb2312?B?eUpQaXZuekFaVWlkL2FaZjFCTUd4L3FYZUtucEwrMmFwMmRqZjUwbEhyN1Yv?=
 =?gb2312?B?VTk5KzdFdU51UjhVZTh4UE16U25RODBCZG4yQkpGQnlhYWdWeWZWL2YvcVI0?=
 =?gb2312?B?eVRDUVBtTnI5V3VMUDVENms3TVFMeWlqTW1DQjZQRG53K0VSVkhrUE15cjBR?=
 =?gb2312?B?YjZ4d0NYTDFUdmQ2cmZ6ZXZ5OWMzMlJSbXN1M3h6ekVaemtrb1BRaDBFd0p1?=
 =?gb2312?B?RWtVMm9HVm01OEZtSWl2aFJHQVM5VDkwaXNVaGRnV01rOTlvcXVGWi9sVXEy?=
 =?gb2312?B?NllSdnU1TFdKVnpZUlBKRDF1R2xlQ0hKbXFPQzU0YlRaTmtTMEFyUVpsa3RR?=
 =?gb2312?B?SnFpK1hDNjdmRkh6WnBEL2F1YnA2UVpaa3dHZ3NrQm81L3Z6eHV5endkTVY3?=
 =?gb2312?B?d3RjR0NSYkpuQU5lSno4RGgwOXVTbkNHOVhVcHMxNDEvTlN5b1B0emlYOVpS?=
 =?gb2312?B?KzhxSm5IQTRMKzZlSlJOWEJCUnBCWG40akwxZ1pxRTBycG9mTzhqdSt4SWp0?=
 =?gb2312?B?OGtMdHhMT3gvOWF2YVpDNlhnTi9XNzR1VnMvTWlWVWJHa2s3TWxMdzJVeTZm?=
 =?gb2312?B?YXhtNGgyazhPWnFJYTl3UHluR3Z0NzdGTXlwWWo3aFBHc0ZBTjV3SWdLYkdh?=
 =?gb2312?B?NGVhMjR5MHZWMkFra3pUc0pBSkxReXl0ZmVUZ1VscVRESmJpcTJmU2lZa01R?=
 =?gb2312?B?TXkzenRGNVpXcUowamE4cGJZZTQxbDNuNDJpeXppQVNjc3Z2NVhSNU5iYU11?=
 =?gb2312?B?d1VWT2FiYkFuenhEZE1uZnVJWTRJN1gwYUtoMmJNcW50bEgyYkFIYldtWE5s?=
 =?gb2312?B?Y2VYYXdFZjh5RUtyTFJxWlE2RHgrSkhEWjR5cHNHVXF1RE5TOHdkN095WG1v?=
 =?gb2312?B?eldMMDgrNTFSa21Fd21oZTlVbjRqbGZjSm1CSThabkJLdlRYbEZEa1FyVVlw?=
 =?gb2312?B?NFZGKzFCVzRTL01YS0xKTDJNSjgrMnZnMmVEc0ZKOWhVUytWeWIzK2RlUlg1?=
 =?gb2312?B?eUNTeVU4emtRUXgrVVNZd2hVNnRNdzlUWTNHM25PRDFiNHFKMXVkbVp5UjJO?=
 =?gb2312?B?SXI4Mks0dmQxL3Vad1M2aEpPMExXb3VhWTdxK1hEZEovWS9OOTE3VEdGaTlm?=
 =?gb2312?B?WEtYdkFybUl1aWdSWjNJQnZTbU5lV0owM05nMVNWSmZWZDRMdlJIakplbmlN?=
 =?gb2312?B?di9YWFFQOEJTamw3V051SnROUEJ5Z1dsTWNMdEUxditwTCtGNUJiQlk3d3pw?=
 =?gb2312?B?UGkvOXJtVm5sSTlSR0hERWwyT2lzS2NjYnZQQzhGUUVFdm1xbWpCNEk2UVEy?=
 =?gb2312?B?d0pyQitUVzg4VC8yem1TK2Y3ajlobkNTOEhFMm93akMxZzFWSElLSU1oWVlp?=
 =?gb2312?B?ZWhrZndoN1BGSEhMY2UvdnVWa09RY21HUEZFUys0Q3RNQWczOVBJWGxuU3dr?=
 =?gb2312?B?SkRoZmxpM2JQQXg2a2hZWm9SaGEvUXZXZ2l1aFNvZGZ0VUdoUXRFNXhUd1Nx?=
 =?gb2312?B?eWpGWDJPem10UmdqMzQxN3h3dklOblB2MytkaTBYeWsrUklkUnlqbWt0OWVC?=
 =?gb2312?B?R2RDV1l0ZCt4SE5nZ24wMlU3Y0FIZWJydHd0MFIzUmJJTU1EMFlhRXhydTU1?=
 =?gb2312?Q?8dAWGW8Pkxr+khQhEYjlUugSZ?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +I7VvnlvjI45z86Yge0bw8RzkrBXPP6oWZdCY75xiC/TO9N4WpVIUpqQ/UT/7o1NPi1TiQc5To9yYRW6a5duJxZA3vnTyCIrVo90ytg1y7ZorzO7G1sq+ffGfyVgoDzSU1NTLPFnOrGTxM38Z2GOrHs55+DxZWpfo9ccHfciVN0tA+UnMq1+SehVVMFbAd0LmRwqQxXsgEnApN7AumlyPBOpf1CzUYyfNG2h/nobCRtNcJQpRhb6pgApFRfLfg10iqae8JbgKU5QMdLYf4N/9OqucOz7rXxD1Ijl6/vEIYh65/Qqw+LDZutNO0F00Y7M+K15epnllmJkgxdr4jAifXNL+74ZVXu9meR8OqvO9GG7rZmuQJ+zEN1rRMK5djf2mVhsHdrCdXg/QLYQIMt6OJV/Nug+3ac+M96XEs2XB2CNXbtZMObXlS+hsIV/c9zSfYzIfrwHQPWTUMJ2QthgAV60ljyXCjrWarGgwXkLu2WP/muxbmpQt7zUGsNjyor0FbN/X6FDZRG81ucHhXmb6UlrK+MCa6MiNSWu+cSsb2ibBI8mUYwketGfI1hHucs57oX/y9MMTVrGbpWtJ+wQaviSkm0Q3TpE9+zuy/5GbmcDS1aHTrrQjAlJjOixORnKgGHHA3w0M/l2ldkJts5YdOrny3VzIHbzgB48QNJGuUnlX8E1fb5rXHOs1W0BwER7S3lRgIQPXUzrW2ZTwQ9AVJEPXGFWAAA2lWi8WMbZdcapbKRc6igcxzIZNhtaOSfg2lHKAMdGGrlkscEycZ3gQ6kFdNDt1rgDkEId4KuWRQ8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9ed432-1ce8-4c80-da44-08dbdc15a19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 02:36:06.7025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yn8djQrJHuXMoUZYhcMAUFuwQjYief1yqUIVhidRtT+fYmJk1YgS8Xm7v6JVWA3IGgp/NoG8zghvRE1F0MrJSMVhy7gzEmmZD/TSHM0UtII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11485
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSCB2MiAyLzJdIHN5c2NhbGxzL2Zj?=
 =?gb2312?b?aG1vZGF0MDI6IE1vdmUgZXJybm9zIGNoZWNrIHRvIGZjaG1vZGF0MDI=?=
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

Hi Li,

Thanks for your review, merged!

Best Regards
Yang Xu


>Reviewed-by: Li Wang <liwang@redhat.com<mailto:liwang@redhat.com>>


>--
>Regards,
>Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
