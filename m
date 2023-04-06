Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB22C76196
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 04:58:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21A23CC726
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 06:58:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36BD03CA360
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 06:57:50 +0200 (CEST)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB8AF100035A
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 06:57:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680757070; x=1712293070;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EvDTQeAZuMr25O2b3ZLcGFwnEB3/rh0z2vx9+mOEzuM=;
 b=KWODZKXE2QMTuAbu4FGIfSKn2xfzmD15iTnfaBdepxSbY1YUufEPZCx9
 Thkp9FbAJSM6NDH3wvNHsL8ahD3MY8BEu7EmFnPSeN1FS8McAVoIYulNE
 SyZsCqJqfFKogl4qeyFt4Fy1kP+qFH2Uw6OinfKwpKSK0e0BGdSSEo4N6
 T0AgQrRNbHv3KsBetijLj4uLvVgDm1g43pMmWMn+tOEb62vVxMnFyIll5
 0qPr0FTP+589waRwexangvmMLzoUS9NOo3FdWS6di5t90Mt+BOwq50zY3
 6JZOZz3JYNWk5bUfLmd/SR0MZR5euqwX8OUnHusLGL6Ijrh5nB1ZvRZLs A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="81403614"
X-IronPort-AV: E=Sophos;i="5.98,322,1673881200"; d="scan'208";a="81403614"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 13:57:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0clnFMoo5DbFkth9PPvUQ4GWy/sGHZ9DYe+UsbQ7orXth8ZZwFT2pRbFo2M4quC4alFAh78BvzJ+kimEUUJ21yp1vgcKDpfcPyirJ+5MPPe92duTttTirDa/AU7dhhPRFdynx6awYw6VEtTxJK3oyFeIZfbWrO8oo7MKwaGxyuZbTYmDJT+3k8w3qkqij9tVMfVntF6UOYSBZEd/zvSLmj7vselUlC3x52FtkQrANBIqd54CAliQjwllIxqJ42kjFwh2XXD5s2L2u4Pzg2Insrf9kdDGCB+Ma40jMo6KVOuOYI40flH+ksTKXY0WDrVJnohI25+n2PdOTTINVVfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvDTQeAZuMr25O2b3ZLcGFwnEB3/rh0z2vx9+mOEzuM=;
 b=O4RUlYdg1bYZqds0Bby60Si/44Z3Aob/FFzRZV8RS/LhSyvfsYy/acO8Rki9N+6O8nxfkpQkGvXnlVagRHN2/XdQjOg07v//R3yPSL3utFC+vrDNt/YzSLgaF/ZcsKU6tOR5i3nbeKl3JEnD6ajRjKz1dW1Beusbc/2Ly57Lkf+KQhYbDNGsL6dEeDpVVUci9QgFIpEYo3J+4PixPCNjbD/zuZlB9H8Y2bLK5SjO4Pedl44vuL54WIf3hYwnC+EPzZ92MDPZcnUNTJS2DQoR40FaCanxpqLwpxbiIhBIvyUvI03N1iamIwoa6FftIGN50TXIustzsydzlJsbBOQIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS3PR01MB8366.jpnprd01.prod.outlook.com (2603:1096:604:191::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 04:57:43 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 04:57:43 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v3 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
Thread-Index: AQHZZsd03dWC9gsqmUGo2s8XSTtCb68bs9kAgAIHOoA=
Date: Thu, 6 Apr 2023 04:57:43 +0000
Message-ID: <100fb209-5cd8-2c92-b82f-8a241d4dcb61@fujitsu.com>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680593430-14728-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230404215918.GA1893@sol.localdomain>
In-Reply-To: <20230404215918.GA1893@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS3PR01MB8366:EE_
x-ms-office365-filtering-correlation-id: a9ff6e3b-4fdc-4c82-5812-08db365b74f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXwovzLwjmxDBhXPeIfhqPyEA2/NdtCS0K0y2VFCNMaS43T/gf/uPBuo8XfCzCjBZE8T3viXMmu24emVdfzj6uRdIt4bHg1djDVHd1VcB2A+jE21mmt8MOBiQ78lbhXIr/UqUUDYEyvaAUirdc4fl3LvjHGp7oCApr2u98/Zwk+8dcAOKIqWAB2PbZMoHlyQP7IzbURKcBva4hMYW1howD5xDNV0VvMdNbJXwxLOoqpezvVXBR6YyXr/0OKsJ6/J+XjP/VGidOUBBZQ8aPuzcMNHkwFTTeUG+Q0F35QPn1ZVhBIH5P1rjzxkFomT5wv/+4riG0WgQa4dcbxBa0zeTteXKbdOYFT60lyg8ThdUCqIaXbtKdvOkP8r/eB0tYWZTeqS463jvX8pxWJVpN2VJZQOOFyFwTdCDNjRwB9JUzhT0ZRS6Hda9ac+BqrUordg+zQz4fm7wYe5BPqw952s2Tb3Wocr83Z1UKKxx/Wc2PEoUXw9L13XxpjdzP0J4peeQJP3Xp7C0Lv4a7djs/ILjw7rXOpugv59WhjXlpqRW3kdiV2eA3OvqiZZWuBChiNo83ZOQlFbpUiYUm887YIoi/kV27ZvS48781+KcnzLtikD2PZFbEF2wMhqd2wQCuGDa2fYt1g+Ktp7xerQDIfVs3uz2YGu9iziK/MItkSqy+yzgzi1/YwA3b37JS/3PO0s
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(1590799018)(451199021)(2906002)(31686004)(83380400001)(5660300002)(8936002)(1580799015)(82960400001)(2616005)(41300700001)(122000001)(6512007)(38100700002)(186003)(8676002)(4326008)(6916009)(64756008)(66476007)(66946007)(66446008)(76116006)(66556008)(6506007)(91956017)(31696002)(85182001)(26005)(38070700005)(36756003)(316002)(6486002)(478600001)(86362001)(71200400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elpuaFNQd0hsbjZicGNjcUxUeE80QmFjTk1ubnZ2ejVtMlFteGZxNUhjb1F2?=
 =?utf-8?B?NHNlQmdvZVJRVHJsZjhsdWpRYkVrRkpYdkM3cU9uUi8yMUJFb2JGVXdZOWlM?=
 =?utf-8?B?SitaZ1FndnJrdC9rVTJaVzVLYVIweEl5c2ozNVlHUGxsczMzcWthd2Z1Vm9a?=
 =?utf-8?B?UCtJbEI4b1AvY1E4OE5PazVScWg5c1Q1VjdYRTRzM1liK1k3Sll3K2VLdStj?=
 =?utf-8?B?RVdoaG9wSXRUMmRSZ3ozQk1jNmw1aHhsQUZia1dKLzJaMXRiSFdSNHJLNmdh?=
 =?utf-8?B?TVFuUGdkMG9MVjlHR1ZzMHFBSGFRbHZzSnR6UjIwV0pUZkJTdXYrYk9IdytV?=
 =?utf-8?B?MDUwUXFtMDZkdXg5STBjNklDT0ZONmlHamptdTE4aXVNTEN6aUZGc1NNbWNj?=
 =?utf-8?B?V2lqT0hnZmJ5b3hzdTV3TEE2QUFsV2FBTU1ZRkY0QkZ3cnpob2RLWUFLVVNN?=
 =?utf-8?B?eUhYdVF6VHZSZFlxZjNqdXVBM2IzRzk1OGR1ckhyM1F0TytyWUhDTWhPSm4y?=
 =?utf-8?B?dFFIQytmUUpyQndQbUxqOHQ2dlNpT0t4OWJZWmUxMlM2b1k3YTZLczBLSDR2?=
 =?utf-8?B?anNNN0s5V01SSTZHa1hFSVE5cDJmdm5rbHg5Q0lhSXFSamk4MzNxRmk2YUFp?=
 =?utf-8?B?dURJK2pHUmkxMGU3OWFGRjlZN3VROWdSSjJHTWZoU3h5dkNzZFlTU2JuMm4r?=
 =?utf-8?B?YXNxYVM5NkJ6U2JtS05SczFpVXR6bVJWbHpWWkcwK0M5Z0VBbUN1YitjYUN3?=
 =?utf-8?B?cmdpTGxiVUNoZ0xsWG5IMG4wUHZsRTE1U2I4c2wzYXZuOFVlQjlRSzdFeWZ1?=
 =?utf-8?B?cWNVeGNwc0Z0LzJOVXJ1Zmx6dVdabVBUTTdRREpSSURQNlY0WFVqUEszNmFY?=
 =?utf-8?B?ZUswOUtvcjBsbExPN3lISGplc09STHk3S1g4L01aR1dDTm9SelRkRmJxRnh4?=
 =?utf-8?B?WVdLMTVjTTJNK3BRcEx5ZWRweTRrY3oxR1lYMkhkR1hOSDV2emlnb09ZQWpL?=
 =?utf-8?B?b1hPcDludFM1aXRkbFhWOTQ1ditROXMvUGdqeXNOYXAvdEFnQWpiZ2tyalJ5?=
 =?utf-8?B?ZXlnS2F1SXFMekZKRnVyRVBRVjNmTUthQlJQWG9RamU1L2ZlMWhtVDRKR3FH?=
 =?utf-8?B?K0JCNUlhbTF4QzhGbHhkSVdWc29xS2E1YnBPSzJFQlR4MVBIY3VWM3I3UDNS?=
 =?utf-8?B?WnY4a2I5ZkRPNVR1bVNwQWZaWUhRRzRpMnJJRnBDWUFqYkxpbnJKWkp2KzQz?=
 =?utf-8?B?Z3FWTHVRVlZYbk5nWjFsSFV5SEJubmN0RHNnZmFPWW8xOVBNamZZbGQ0b085?=
 =?utf-8?B?UUZXQlZ1aE41YWpPTm1vMVlqQ2JQUjlqekJZS3VJTmJ1RFlmRy9LcEY0MzA5?=
 =?utf-8?B?WFZ4RDZMdmdEQ0dLdDZ6MW43T0lWaFhPaDRlYUdzTUxKdWVVMGUwSjVYdnUx?=
 =?utf-8?B?UnBBOXJTNW1jUnBodGVnb1RkMDN3eGtURjdrTVNrN1NYSFE5ZjdGVm1mYmJZ?=
 =?utf-8?B?NU5UR2tpMkJEOVh2RENPOTczSGZoYzRLWlAxdCtWdWhwc3lkK2hZWEwva1FH?=
 =?utf-8?B?QVdWbUdVRmNvZjBGMmxTVE9yS01Qc01RZk5UbTlyQnVVUTV2L211VkE5UnV4?=
 =?utf-8?B?QlhqV2xxV0pUY0crak03VlVobzNPSDRrTlM3ays1bzhQaWhxQWVJalRhaWQy?=
 =?utf-8?B?UWZFZXNOOVU2Q0pZRlhzZ2N0OFBkdlBXSkFNZnFaK0FsbmV4TmNlemRyRXEw?=
 =?utf-8?B?YzEzK2s2QkZXcUpBWE53VUcwNmZSaCt1dktxako5RmVDL3NFa0xWNjFFR0Z3?=
 =?utf-8?B?bGR2Z0FTa1hNN040amt4c2tmeWZUTURSWWQzdUdpUXhmRTZzSk81OFE0cVlP?=
 =?utf-8?B?WUpENCt3N2Q0emVPWlhIdHY1ZWxJRmpDUld4bUFFM1NpL1UydFFYQm9pWHNB?=
 =?utf-8?B?d3h4QTBCaDg4WVpDdFVUQXk3TzhUZUZtRVhpekc1Yll0UVg1NDRuRHFra3FF?=
 =?utf-8?B?Ymt6WjdvWVRxM0dBWU9mZHN3V1MyUDJhRnc2eFp6NXpsTVIzYjBhOHVYckRU?=
 =?utf-8?B?Z3Jmbmg1OEVKWFJXZkZGSnJmSXB6QmdRYTJ0bXR1SjVlRStJdndrL3VzMGZu?=
 =?utf-8?B?RDNGSmV3bVBETHduR3l2OTlISjIrMHVYYTRJK2hKcDNORGlZK3B2Ti9iR1FW?=
 =?utf-8?B?OGc9PQ==?=
Content-ID: <2504DD048ED5D34D91809E02519DCA8A@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: spHM/GHejhRlCwhvRM9/MTEXRy5dRpCmAucGCy9d+imsfDwxJv4XrkZBQMUyqPiMRV3482+GfgCITN9Qul1AU+YCE6duls5NyFx9dTi1CFrmDQ8OcxUDGn6Bfhz+6rk2KXB28zjTuyay+27Mi4G/Eqd3B5k8xQhvL4FQkAe+YJzZZA6Y/ldylpa2Tf7TWe437hL2u0Yqj7aMmJ4MgTjfNfHa3IctBimdpqRITqql6f8tIFEv+0oTWnFxkbVHusEuIdqztmQGbxUzfsyE8q71guRX3doosHwVGOZspUV850k9scfphjjnlys5MYDx356Ldv5wQD9NtXCRUZh3HcTKkqIUbTfYTNdZ7IMb5H+G4WooatO4LDybpxzriz8j2HmSniCmHGIZgvYgtOGXjscEpV15GQtmAjHs16aeApBKTMWOCmL5GcwStvBJ+D4QVPW6GxFVgZ4TtICl6oVDEVVCt9bLLBABF9/liA8uA/dAMncWeXWian+BELq9+CU8H8JqrOfh72dU8c5ZFSKvxG851JpvENZtRZCrmDrxDW2QtdWEehTCjAJXjpRXnzyWp8SCmhHqedgI4uMSzzSZJYr4oMXENESn3K5yOSJodMxLlaUez0tTFj3SkrSYRt0Srt3S9KKgXm0oypiTdlTS+2COwTyaCiiD270f3kUsgQyvGcV9ax2wEk8lcV9mwC4kYjNTAhie434eAbT3ayiRAeFAuOJgcEkCWSZt7eME1kOul/zRVuQ2ZIBy+LTbx2vcy3iNRhsPKrNTz41cueEp5RtWjxEZsyKJ1py6jH6DldRYgpo=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ff6e3b-4fdc-4c82-5812-08db365b74f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 04:57:43.5098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mduujR3JoivfXouEaV1AxzHR6JofElP9hHCEn+dVAsYrnUIKydC/UFo0ooHmpwctOnWvr+dLkVpM+lKcjE59KGFO1KGIqDUQdtbuSvR6v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8366
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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



on 2023/04/05 5:59, Eric Biggers wrote:

> Hi Yang,
> 
> On Tue, Apr 04, 2023 at 03:30:29PM +0800, Yang Xu wrote:
>> +	/*
>> +	 * This test is tightly coupled to the kernel's current DIO restrictions
>> +	 * on block devices. The general rule of DIO needing to be aligned to the
>> +	 * block device's logical block size was recently relaxed to allow user buffers
> 
> Please don't use the word "recently" in code comments like this.  It is vague,
> and what is "recent" now will no longer be recent in the future.

OK.
> 
>> +
>> +	TST_EXP_PASS(statx(AT_FDCWD, tst_device->dev, 0, 0, &buf),
>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
>> +	TST_EXP_EQ_LU(buf.stx_dio_mem_align, 0);
>> +	TST_EXP_EQ_LU(buf.stx_dio_offset_align, 0);
> 
> Like I mentioned on patch 2, this is not a valid test case because the contract
> of statx() allows it to return information that wasn't explicitly requested.

OK. Will remove.
> 
>> +static void setup(void)
>> +{
>> +	char *dev_name;
>> +	int dev_fd;
>> +
>> +	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
>> +	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_sector_size);
>> +	SAFE_CLOSE(dev_fd);
>> +
>> +	if (logical_sector_size <= 0)
>> +		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", logical_sector_size);
>> +
>> +	dev_name = basename((char *)tst_device->dev);
>> +	sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>> +	while (access(sys_bdev_lgs_path, F_OK) != 0) {
>> +		dev_name[strlen(dev_name)-1] = '\0';
>> +		sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
>> +	}
> 
> What does "lgs" stand for?

lgs->logical_block_size, will use more meaningful variable name.

> 
> Why are both BLKSSZGET and /sys/block/%s/queue/logical_block_size being used?
> Don't they provide exactly the same information?

Yes, they provide same info, I will only test for sys file instead of ioctl.
> 
>> +	if (access(sys_bdev_dma_path, F_OK) != 0)
>> +		tst_brk(TCONF, "dma_alignment syfsfile doesn't exist");
>> +}
> 
> syfsfile => sysfs file

Good catch.
> 
>> +static void cleanup(void)
>> +{
>> +	if (fd > -1)
>> +		SAFE_CLOSE(fd);
>> +}
> 
> What is the purpose of the 'fd' variable?

Sorry, I copy code from statx10.c, will remove.
> 
>> +static struct tst_test test = {
>> +	.test_all = verify_statx,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.needs_device = 1,
>> +};
> 
> Why does this test need root?

I remember I have removed this, will remove.


Best Regards
Yang Xu
> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
