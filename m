Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64502C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 05:29:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57C9D3CC2C6
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 06:29:54 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 099333CB604
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:29:39 +0100 (CET)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41C6D1A00907
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1701235779; x=1732771779;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=EnPQfvfS6lKRcok/DFJTVmbMZoPL5kN2adxISFPkBwE=;
 b=Cez3t4PB0xj8fw1x/RPQ0BZyPzuxRk0+7g87qFQn5LUkpNZZkDTtIQmD
 Qu6FFWUchwXRHM7yNrjsXd6JCNIPnd/R9F+RFzhzsp3bJsfraieyICXzj
 3mJRmlvPZ/aIEZBqokmnQvXA8WxK0bw2ExmwwqU7bd4GIZnKAHlwdEd/U
 x5Z0RrOkA9IE7y65mySmqpl1gu046Y7i3UefD5UqUR9aVti1dJiIojPj4
 L9BdOqQAGg6CfoQrlLLuWlvixqL8ehC+oFgomLfNIl6z2G37nPjvwOndO
 o2ZPm8xhYiEa0/SyTiaWzH+xVjwlccFjqbl//fnqgB8dYeAXJbKtrIAZ5 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="103876335"
X-IronPort-AV: E=Sophos;i="6.04,235,1695654000"; 
 d="scan'208,217";a="103876335"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 14:29:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC4aNI6ZQH1zdORKlOgXMTnv7GSp9PJiJohIi8sT3NGu9DmQh2jPQNc6f71GE5U3iA8DbwVc5e5ca+tBhm7zc3yct7PFPumTK++BpkEayvoWF05NbQMu8IdA+t8VRV93gif85e4pINDNTNOOoywWq9NvbkK6xxHpGTzdMibcyq2vgAzT1x0IGmjGqBk/euSMG4ampKveCjI+pgUnzxwEwnlimp3EQ6op/iQ7tHpUFyt4BX5GR7AAAlWXm9NdpORO1Y4hzorCHDklreE0Pm0sXKsS+wCiAoXCZyD7TYXgKbK2Iev2MeN2nrScqtV5i/MFoe7DW7IeYXiM7NWjjel7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnPQfvfS6lKRcok/DFJTVmbMZoPL5kN2adxISFPkBwE=;
 b=Rr2vLlCNzmihIklQGqvnUJ+ld5UK0h0qt2l0SYQNaA8y1+0GBK5qLZM2oYJEnAmoAhhnIzndSCbWBr37mES46HxCyZ2QnKHsN9+Qin+LyL8MwO4f4uuoHx7vlo3ayWevR8cELJs69/srOwTgZqtY73A8ueOFI/qF1FwTraBw4CDNZYeE8xJXdq5MrO/tqxdqRHf3/Kc599p/AGgPKXVM5AB+mw31vK3+YVuDprg2U+4BIWMuosgumn2cB9iKivrbsl2mDgx8bwdFNq56RUBVyG2Z4xqzj4lL/QP+zCBN4KIBflDeDiQwFS7WPEnKYnNCcBRS3yHC8naYRuRikPQBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYWPR01MB11749.jpnprd01.prod.outlook.com (2603:1096:400:3fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 05:29:33 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::eede:9a21:dfae:c0b4%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 05:29:33 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v3] Refactor and merge symlink04/05 using new LTP
 API
Thread-Index: AQHaCKrHlq7TEpEDUUy1a6k6Ya2GebCPcp0AgAGFcOk=
Date: Wed, 29 Nov 2023 05:29:33 +0000
Message-ID: <OS7PR01MB11839681238BBCA9C0332CA14FD83A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
References: <20231027071236.51779-1-xuyang2018.jy@fujitsu.com>
 <22adad8a-0462-32a6-4777-9ae7eaf60253@fujitsu.com>
In-Reply-To: <22adad8a-0462-32a6-4777-9ae7eaf60253@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-11-29T05:29:32.868Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYWPR01MB11749:EE_
x-ms-office365-filtering-correlation-id: 15176233-0cfe-4d80-508c-08dbf09c2b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZICrbRX/XPnGwiPHTSwEYOe4pjeUmr3u+TWoV5Xmm06HynZexR/bhE/W/Rt3/TVMVhb4jKY7Z/Kbgindl45frGyV/AY5A21EWaAb7vyPVMXZ1BHNvfhelO7UwaQ6M6t+jhjQigJhcITsIfWHNm9rBUxmUh4z2vV/IMwnI9ZO+/2LHTGeLEQb1YIxGg4Nz+yVPXC0GfG7fbFNAVLa4yWOyG+X3seIGIi55WupJtqQbXAGrWPL1SO0ey0SG4zve0ol7LZxxXBN70IlkjAwi8E2ZCw0OgJyfryTdUvr5o7LwEfxJr5Gp9piLcRAkbrv+B7UPBGeVHPIWqg/WuO5R/KFZqo2UnpBnPXI+bcbmwB7L9YkIBgSMZuhf8X3GmdyvHLdqLtwXM0wc8eQsGpqHccZ6IABPL0fJe/AWan3dzDVuPM1q+7yDYFzrBFQJ0MqVmmEzkiAjX+kG5fI5Wcekip2OHpdw325wm1GidV7uZ5K9yyv96DJTBZhriJFT9cyvwe1t9xaUSel94r97baq8CNScU5nS9kWXrw9f1KBzci3ITtjl+tDDYj2asyD+rkYGvkNCD/nqIP4uYP5w+xv8lphZTjyIg2nPKh8jzMDL/MLXJVKV27mhbmPDAfUC58/muz21XVGCbRtczj08Ofd5iqWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1590799021)(451199024)(186009)(1800799012)(64100799003)(19627405001)(55016003)(1580799018)(9686003)(71200400001)(478600001)(26005)(82960400001)(85182001)(86362001)(122000001)(38100700002)(33656002)(38070700009)(4744005)(2906002)(5660300002)(41300700001)(83380400001)(6506007)(316002)(66556008)(66476007)(66446008)(76116006)(64756008)(91956017)(110136005)(52536014)(66946007)(8676002)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WWhPVU1xYVpONUJTUmhWUjQzOVNBZXpFRmJra0MwN253d3I5K3l4RVYxcVZn?=
 =?gb2312?B?aEVJMUt4WjY5N2Z6dDJJSm1tNmY5NjNwbGpJRFRpbHQ4WUp1T2RMTDB2emln?=
 =?gb2312?B?c25yWmVPU2RhSFdHZWErZll0Sm1iQ1I1U3QvTzRrSzhWY2lXR0VXclZhUkQv?=
 =?gb2312?B?d0RUUll3MkJHRXAyRTgxNDZjK1VWRzV6b3QvOURtSktFU1VIMUZPYm5LSWNi?=
 =?gb2312?B?Mjg1S0RqbUN3V0ZzTm0zSER5SnlGcTMrdi9aRFhnNkc0eTVDeFFKQ09VWUhz?=
 =?gb2312?B?UWdUU2JMK2JzNmU1K1JpcUlIVDdQTXFZUVpxcHk5eHE5V0NlSVZSVzZCREpw?=
 =?gb2312?B?TE8yZ2s5SkdPSnFNU2FOY3VFVUhHZEdmU1J1dFZoclF2NjJkejJSNlZKc0VC?=
 =?gb2312?B?dGJMNGlnb3F4OVJBZXF4WG5mRXBzL2NhVk8rY3NmWDJSWlRCaFRXdmlZM09W?=
 =?gb2312?B?TTNqR3orT09YcUZUS0JiRWxDSUk3RTFNRVZEdnBLdDVlcTBmOVU4MTZQbGQz?=
 =?gb2312?B?UFRBdG5xUVdpQTBqdDFmRU4rZld1bEJhT0VOUU1ZdzBYSWR1dVFoTzV5UG5o?=
 =?gb2312?B?TGs4TnVPK1hXd2QvWlB4czZ3S2tOSTVEb0FzWkNXSlRGemE4L2JURG9rR3VL?=
 =?gb2312?B?TFVwNVpYaU9KSG1PQnIzazNVM3RkMDlPdlZZaFBmSVBjcFlDb0NTZkJtSGY1?=
 =?gb2312?B?dHMyUUpXQjlkTXAwYjY1TE9MZnBpdEZUSDk5SFhsbTFQUnRDWjFVSk82YXJp?=
 =?gb2312?B?VHBIL0JuOXp3V000bDEzMk5UdVBIV1RjODRjUkFmWmE5MmZ2MkFaWENJODZj?=
 =?gb2312?B?dkdNQmZiZkVCbTIwbEdiOW0rTkZWWDB3QkViNmtGbytDTmVFdXBWaFlNNWM2?=
 =?gb2312?B?bVFsYmdCZjA4WlNCKzJUa2lyTkVvMjBSejdlKytXRDRlZDBDNzg3S2h4c01T?=
 =?gb2312?B?bTJoczhXbHpEU01NTm43a1RIYXNRUnRIYXJJNlhhYmp5dGp6SG5qRUlYbUx6?=
 =?gb2312?B?VUZXdm1WV2E2ZkhDazBFbktNNEVydnRSM0g2ZFNHK3lhQVdGRU1iMTE3U2ly?=
 =?gb2312?B?MWp0UWhKRXltaFUyZCtWQVd2V2ZWSUJNOWRwNGRjdzk4VUxPdTJGTkJ4VGxk?=
 =?gb2312?B?OGlWYlNhN25mWTh0STFxaENXZnZsTThKZHd1ODZGRDAyYXVSRmYyYlNGZmQr?=
 =?gb2312?B?WWFKbkZyQ1ZQK2NkcGVvclpqK1IrVkdCdm12anFBaUE3REhDdDNWdmpkbDFi?=
 =?gb2312?B?cVdXUFVUNHJBYkF0UXMvMmNGSnh1S0dRVmdKekt3N3k5SWt3QWd4VzdjcFRa?=
 =?gb2312?B?UVpNaUZJSnpYUW5qNFdWMnRna1NzeFJXc1ZNbmpVbmlVbDZVNVc0SVF0RjRQ?=
 =?gb2312?B?Qm1PNlhnYjJiZVE2STRmRTBLWTdTZHZybDZmMzk4a0JYUUp3REVBazVjYTY1?=
 =?gb2312?B?YWgyWHdqdXY5SkRJN1UzS29xbHdQV3A4eFlYanBZOE0rb3ZWUzA0QmtsMFFI?=
 =?gb2312?B?dHorbGp3V3NRUmMxSDNyQS95NVNKWkFPelJ3d3dVdUQ1VW5LM1NyWVMyZ282?=
 =?gb2312?B?dzFoUUNsdGN2ZnhuYm90cWpzaUQ4TUZoWVIwQzM1ZmxuNkNLQXd6blVOWSt2?=
 =?gb2312?B?N1Q2clo4dHRZUWw5NTRoRG9BcU5ZRm9OeElqbjVJVm0rYUp4WEdES2ZhRGpL?=
 =?gb2312?B?Z1FWeGxGK3hnL3BCY2xmc3YrV21yN1o1UVNBYXBWMnRiczhnWm96VUpLS094?=
 =?gb2312?B?V3pESDVEME8wSGlWOXIwald1WmswVlptVXErSnhENWRTaFAycWxKR056VkZF?=
 =?gb2312?B?VW02S3ZqTWxRMVRrSForVzVQaFFWUHJxVlhUaklYdHhNZ3NNdUlNTjZXeVBK?=
 =?gb2312?B?RkN4ZEhLaXhtbVZDaWFlaXMyS0o5cWRzQnAzS1ljWVc3UnFhOFQ3dzFXNDM2?=
 =?gb2312?B?bjlyRXlKRjdtcERHWlZQUHROZXVqR0htQkJlMDR4d1ZucktuUHE2eTBNOUVC?=
 =?gb2312?B?TmNKdGNGTkxWYjBiL0d3WjNRKzFqQ0tYWHVOa3YxeWZUUGcyYUt5Z2s3czFH?=
 =?gb2312?B?L1paUWVDMkt0VzY0U1VZanJGcm8rc0RNeXByUUVGMWxJdjkzOEN0MFo4SzJi?=
 =?gb2312?Q?Zg4tMLr+tOshf9hqCgkFANF21?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /PwjL68d0fRYlKIz1eJgE1dd8esskiGWkFQbztff7Jrrz8kdwwsaqurprvJYwFN4HtNeIzzkBIoG+WLVGc06O+HGyATpqhTlUjOFXEz8QwYUAjcx3K3SNzuuvKHUmMx+5MS/sqjhgq0n/zBy8tFVqWeUEI5sLaYuBzP74PpX+c5PGuH8pVb1ROoZ1PsP7mNyuBU76FNOGI1LwQYmkVNe7bfUCs/erVa7gjyVikZSIg1abppR+XIUtsJZk5bhNhYgsJRERI0gTMDKTZNrsknL/WjB3t53AIMnI3kAjPzVYa4T1fSgXTLmFdt7b9pwZKLnyTJfHID0SeLFa7yL2a9qIV6DrJDJPevwSuqfWuYwu7QKDmDX5FkH3qxO1DBYvzbaUmnz+zhF7rqqdV/3QxH0hmAXLxMNtM6JZp8VMkv/JL4LlruJzCA4dQewZedSs/rIysfccysmfQ1DrujZgQIyUvoUnkgU95IF7BtEcurqMiuSZK1OjmsDCft2YbCuO2wVzUocqvzlz88CwG1yCz8FDm1w24hlyIziGDWj+pFIEIkKf+xYe0sM3dChPw1r1me8xIy4JPC10uNI1ga0Wr5p3ngP9/0iBC0tp9SFSAmWVxPsuhmvB9ukXwZ5HtAp9/5y/+xsJEpMW//CuKRaLPfQ4bCjEJdaiMwlkF+GumhRM5Y/UNn+KT/lrHmSxAUw80Oy/F69nlFn7BSfFUSV5oTRZTl62ppmdWk4onmFsnz2dJtjw9N+S++ob8du+BKZu9Ix/HtEmFr/juDrtg4VVqItKQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15176233-0cfe-4d80-508c-08dbf09c2b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 05:29:33.5601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjJAhCHeFWhWZUi0YVo1MVCnpGROZYmTn04CMz+Se/5I2qdZWLsOUrcY+kPnQMXLM34Bt6V0giaX4E6AuhAzA1ASoJS11pES3lTLwpJ6c8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11749
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Refactor and merge symlink04/05 using new LTP
 API
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

Hi,Xiao Yang

>On 2023/10/27 15:12, Yang Xu wrote:
>> -     cleanup();
>> -     tst_exit();
>> -
>> +     fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);

>Hi Yang

>Is it better to call SAFE_TOUCH(TESTFILE, 0644, NULL) here?
>In this case, we can drop cleanup() as well.
>Other than that, it looks good to me.
>Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

>Best Regards,
>Xiao Yang

Yes. I'll update it.

Best Regards,
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
