Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D8C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 02:59:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 265223C915A
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 03:59:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137013C6AD0
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 03:58:58 +0100 (CET)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8DA97600954
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 03:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639969138; x=1671505138;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4oF838iE18zcYljh0n44xhueeJD4ciDAe7eEguiI5FI=;
 b=WoOp315jg+0x7NAEjMxrqKzHB1g6cw4bvMzieFITCNCDhWsDh/WibFII
 5WFKu4FmsyJKjx95j9cbaCFLQgiHxJfn69lU9oLCBrsHfKGHxgGHO9VPk
 DNhMaVyC5QtCOULL2G7hOv2pKKjCbkwAizsREe95OdYlbIK0eSq+CmMMS
 wTbaUxe4gqnBtlumuRwCm6E5K38+BNYG0LP1XE7gfhbdOfA0yG85HWc69
 wbIow7qJE+6b65trDIQpj7qW1MwQ6I77ESJ7QCXR+1zbXcUVRfFNMPwN5
 PdEVLkVqQNOXGmtLTxfIc8yqb1z225cLOK1G+vKKFvOhMj4dp2uIdswDQ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="46199979"
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; d="scan'208";a="46199979"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2021 11:58:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty0Ab9nPw1ThjE9yjN02HxOSvegFAZ5vQM820wgTNsshZaOEHADtuAgxt9LPWNuO1zgUtNaraswRUaxWPXIdbAQYBMNadL1Si0gSCsEYHw0PzL1Okkq1xlfq1A4ajapYLtg6YzdEYlND+HJNdDzQFPXL1LEUu4yBXlXS+CLI9L7CptY1iJFROHKnyuOzvoNNcnxZAQgv8XJBshlib7ZeQnyFhe1zMEXyNbPKlNcu/Mxm7VJdKM1kv2UjsiHIQfQldYG1pZGla9hCKDnLsMp5ckDLgpb3YrUzIWudTvy8h9l25sj2+lprRJHrK7Bsv5HJKrNKscVupgkK/9+7CB4X9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oF838iE18zcYljh0n44xhueeJD4ciDAe7eEguiI5FI=;
 b=IbQlX/cxlrHcx3BRXsuW0V90byZKXxmFY2o/701JfITgyx/kSaLzCWNMrd+u7pH/NilccPKObVnvVY0IdaeGlQFrIa1NhXGBvalPnA0BI3q/aaL4r303toCHysr4DJEORALp2oqcExNLMK9ReKlpxS4JzwBKsw0Qvj/mm4kT8Z3IVShV8BnwkIs0cPPtAD+CWZ1KCD+MlrRyP3nWS3x3FR9XFfWxK1UZlynGnp/Of4TDp0BVDel/UW63lagNMlgH1cSAWrPXSjXTuvibYtuKKg90yTnWu7NkMibmdeqm6qIvLUbrQvkpBNk9UWFP5T5fmsew7w/n20OaHnnuhDbDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oF838iE18zcYljh0n44xhueeJD4ciDAe7eEguiI5FI=;
 b=UsfvVjD9SA/REKuINq9Uh8hh+905EILC7vmPBsnIUEJIGcohmkF0OENLUID56R+l+ZeJ/R5hKQk1j0VcTTOPEM0+BiQJs1gCw6ZyCKuvqWUE0ZWPYToiPBZ1vByLYfUeY0dRdfIs8bpm3+8R7OD/9Id1ibG9QcCu+ig95yFr0tI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3660.jpnprd01.prod.outlook.com (2603:1096:404:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Mon, 20 Dec
 2021 02:58:49 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%8]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 02:58:49 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
Thread-Index: AQHX8YRIrJGy4A3OoES5sELst+XBBqw2UdQAgAAd3YCAABCyAIAEN6cA
Date: Mon, 20 Dec 2021 02:58:49 +0000
Message-ID: <61BFF174.4060403@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxAuBpxXtPXIwYO@pevik> <61BC59C5.9090708@fujitsu.com>
 <Ybxnxs5t5lDpNS4U@pevik>
In-Reply-To: <Ybxnxs5t5lDpNS4U@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5c30525-c892-4553-560a-08d9c364a5f4
x-ms-traffictypediagnostic: TY2PR01MB3660:EE_
x-microsoft-antispam-prvs: <TY2PR01MB3660DE8517D53A1491718A0EFD7B9@TY2PR01MB3660.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+LyJ1arpJnoGMV7B3r6PQBC/NAz9vAeL/reHn1O60Gto+OSkCcu6fb+/h2WWCHX4bqIEn9JL68EKiKBboeTsUayxuzLvMkbZa+/76EglxQXr084fZTeKeI144hlfqFehb6FXZ9cici+T7r3m8GFJMK4n7dwaXskN3AlwA6QWWuy2NPFlKq1JKuScAC0jKSCk9yN4I62Q+EN9O4wkhlGmrKjxne9m2vM9LelE3ZSRGlj5Y0HPneAkNSoegGP5b3D4IiqMhHFwUIgXLNcMDG9aGGtELROJvY/iLeQSLJ808Lyqjl6lm1wAdp7txUijQ/jZjoljrRJEEZ24j1VNXJuDaiTLrPgHKeMFMOwjN72371+bTVhs4NZ72RtATrIkxNIBoGi0L7hCqKa7euHiTfhUZYB3xh9MZ933GMwRxqhWeAJiV1kP6msgVBfJE/Dr/C9YqOmQDSb/qq1w2E0eYgbWsRgB+4XvDM30/9bsjOGnZWkQqfpFUneqM8liBkgO8EBiwLhKdFxfg0HPtOWkME4CTf8fNOFlep9NVAcp7E2fTLP/CoRVC+s8WlTY+URDgWz3TnhOmDSpntAhEwD2x4zWl2lZEXwQrbv2omMwBrkXeZRGNy8Ag+eILPdtAWQLhYGGuBle6C2v33gAw5mZNvGmuRsjG0r1et2KXb2Fmkffvi0TkISX7b2mvsQYGgwBrZWG2MgfHLu/S74KVkE5wzDhA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(82960400001)(38100700002)(122000001)(36756003)(85182001)(38070700005)(86362001)(76116006)(66476007)(66556008)(64756008)(66946007)(66446008)(316002)(91956017)(6506007)(508600001)(186003)(26005)(4326008)(6512007)(6916009)(2616005)(6486002)(5660300002)(8676002)(8936002)(71200400001)(87266011)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZFp4QThUTGFnNGc5TGVTekdGR2N4UXdIU3VtL1FMU3NYYXFmMTY4bFFqVnRH?=
 =?gb2312?B?QXZsN0JkMGFHaFhBYVZwNzYrS2h0RTVHWnhqS1RsVU5Tb0xxVFNtV25rRy95?=
 =?gb2312?B?TEFGYXVKeUoraEgyd3FmNzMzc1VsQTh4VjRpTUpIWWhEdUVJYXB6a1FncXRo?=
 =?gb2312?B?dHhhMFpQM0VpUi9zamRxdGdXNDBuQ1RvVE1hQWlhNlVheUZwM2krYU5tM3ho?=
 =?gb2312?B?Z2NDVDFrNlpzd0RSa0hxa3RBMWRsYkJ0VEdiYWlxcmdhc25tVVNmUGROa1NK?=
 =?gb2312?B?SnVNeGFJUlZoM3JNdUlRMGs3dHNjSTBWNUxtLzh3TzdmQTRTVGVpQnE5MWMx?=
 =?gb2312?B?NWp3NlFlUEVwTmk2eTdBSS9oTXdWeWg4TVZsS3IrcjhnMGJIVFpiTmFWWld1?=
 =?gb2312?B?bnY4aVJlMWtpNlEwNnJ1L004blg2Z0FjdlFrTFVaMVI5VW4xTjBRdS9RdjJn?=
 =?gb2312?B?RS9aanpKaHpKK1hMdHR4TlJkcWhHTzZaNm9rbnE2UGhtZU9rVEdzVTN0U1Ro?=
 =?gb2312?B?dmJTaGpKUzYwSmJqb2lucHg3d3AwZ0N4VDlBZmpwbGtMbEZuMVgzZXlHamFq?=
 =?gb2312?B?ZmdUSDdKdHZnZ2kwRzk0UWdxZ01tTHpsdXVRWGZIUFJ4dWVhcnYrNHFKNENv?=
 =?gb2312?B?NHNBK05wSVhWK1NyNnhlUWY3eVM4VXRhektDbWRhSzNaMGNGTmlIZEdiTXZP?=
 =?gb2312?B?TUYydmJLRjd0RjR4L2YzUCtDU3NueEtpNTBNZXh1S2R3UEZ2ZGhvUUl1MlRV?=
 =?gb2312?B?SWlIaXdDd1V5TkkvYVhSSE1QbHdyNXpBU0xMc3UzS0Rpc0I3bjZHUk1wTzQz?=
 =?gb2312?B?QzBrSHdzakRrdDhNRGJuL3NqNWJWdno0YzFtUTR6eDhIRTJtdWh2bjZTd0Z4?=
 =?gb2312?B?WHpNL0s2VURCKzM5N2NVeDZOQkpUMWpNTktUM1ZQTjF4dXN5L1ZEbzJmOGNH?=
 =?gb2312?B?WlY3OU1kUytzc0lkS2tmeGFkNGhvZEJoMGVuSi8wSWtlY0lqTm1BZnBsc1Fx?=
 =?gb2312?B?TmI4N1ZLVVVNU3VVN2NBMzFJZitrVHNCaDVEMldqcy81aG5hRThOQkZwYnhS?=
 =?gb2312?B?OHVhRitvMkJMczVKRXlLTGE3cklIYnVMOFFkTVFJSHlGenlQeGhNazJXYjds?=
 =?gb2312?B?Ly9vaGtacVpxdEdZOUFyUmdTNkhwejZzS1A5MGZVdGNXcVJIMzR5QXZINytU?=
 =?gb2312?B?Z3VCVmx1U01HRmV1TUk5aVRXc0ZaWURxN2dXcEpITDFkVGYwWTR5blVJWldt?=
 =?gb2312?B?YkJpeml1aSt1bURZSDU3emZOR1pDTko4RTVZVS9PazN3OUNtWVFQUGtkLzVD?=
 =?gb2312?B?Nk9HQ29QMmVNR1ZxTEpuMTRZVHpPVTlNNXVDSE5FV0xXYkUzY0NKUXlXdnFr?=
 =?gb2312?B?MWR6SzB4MkpSbWVmRVJWbHloZmVnVStTeDV1ZTUwT0FKNHRLckliODV4SzQz?=
 =?gb2312?B?Tk1iWXErSzNtZ24ydEhzU283akNUK0phYlg0TjBkMFNXOFpQNmthQk5JZG1P?=
 =?gb2312?B?aHZic2pRa2htZ3l4UC8wS2dybG1LV28raXdIN2hVeXFtWkdLWGNhM1ZLT2JP?=
 =?gb2312?B?NysveXpBb3Q1eldRMnpiM2UrL3g4UEs2d1ZJZklJZEhwUTFvcDAxYVdQVHFt?=
 =?gb2312?B?Nzl0djQvUFRmeGNyOWNXQ3IvbXo2ZGVhRS9QT1ZMNUQyeGFjcHNleS9UTUNJ?=
 =?gb2312?B?cnhlT0tvWDQxZHhlYlZSZWEwTmJiWE5NSVpxdFVMQzV4R2lVdzlHcEtic1lL?=
 =?gb2312?B?U3JFQmE1Z0ZuNTJiRXliNGh6eWVEa1JIQVdvR0ZPL0lYZHQwcnU1V284THZV?=
 =?gb2312?B?V0d4MjN5UnBJN2VqUTFUWmdaaVJCcjdZWkJLUHVDS2NBeGZSM3BQRTk2bklx?=
 =?gb2312?B?b3QxNFpsV0ZHTFVpWXl6VmZkUm1Fb1k0b3RSZjd6U1VENE96eDdxN1lJMm1r?=
 =?gb2312?B?UEpaWFB3ekJXeXpDVVdpbFBKdk4rRFNpZWVGYjA1dXlXYlZocm5obm1kQkJ6?=
 =?gb2312?B?ZllRT2hicHlkL2FKdzNDNmZwNEFWOGxnUVk5T2lYb05ET2M1RXRabzE2WDlG?=
 =?gb2312?B?VHh3d1NJSzhvZ1NQZG1VRFpKLy9TcGRoUDBaZGZ4ZEFoK3lWVjRiMmNHTk5z?=
 =?gb2312?B?SmRXUFFicnpJRzFjanVpRDF4S3BPek5UNzF2N2xUYlMwUkltZGpUK0RadUxV?=
 =?gb2312?B?Zk5sR0oybEJaTTRRQWpwbUx1TU9tVUxFUmpOZGZHQjRtWmVSVmQrWFl1K0Q3?=
 =?gb2312?Q?AGHgu1pX+JYDiDtg/4AGPj0Su4AXTKPfYxvGbZxxnE=3D?=
Content-ID: <5C49B8404C536548AFE855129C94900D@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c30525-c892-4553-560a-08d9c364a5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 02:58:49.7139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HqvUfJUrS0P+lpcVLiF0hWsHvzPUWugllofrqmq7vxVaIKTbuTjmaEVk5boAH7D1vI1aSR5KJygjJ4ddt8a2EdXmmTnTe+RNITKKWOUbiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3660
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] zram/zram_lib.sh: adapt the situation that
 zram device is being used
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
>>>> If zram-generator package is installed and works, then we can not remove zram module
>>>> because zram swap is being used. This case needs a clean zram environment, change this
>>>> test by using hot_add/hot_remove interface[1]. So even zram device is being used, we
>>>> still can add zram device and remove them in cleanup.
>
>>> BTW this was added in v4.2-rc1 (6 years ago, 6566d1a32bf7 ("zram: add dynamic
>>> device add/remove functionality")). Hopefully anybody still supporting older
>>> kernels is using old LTP for it.
>> Oh, I don't realize it before. I tested it on centos7 then I think this
>> control interface maybe introduced long time ago.
>
>> To be honst, I don't want to make this case more complex. How about
>> adding  /sys/class/zram-control check after load zram module. If not,
>> just report  case needs to use hot_add/hot_remove interface .
>
> Would it work something like this?
I don't want to use kernel version check because the hot_add/hot_remove 
interface is easy to backport. I will send a v5
1) new kernel and not load zram kernel module, then modprobe and rmmod 
is enough, doesn't need to use hot_add/hot_remove
2) new kernel and load zram kernel module or built in kernel, use 
hot_add/hot_remove
3) old kernel and can be modprobe and rmmod, work as 1)
4)old kernel but is being used or built in kernel, then skip this case 
like patch v3 does

Best Regards
Yang Xu
>
> ZRAM_SYSCTL_KERNEL_VERSION="4.2"
> ...
> zram_cleanup()
> {
> ...
> 	if tst_kvcmp -lt $ZRAM_SYSCTL_KERNEL_VERSION; then
> 		for i in $(seq $dev_start $dev_end); do
> 			echo $i>  /sys/class/zram-control/hot_remove
> 		done
> 	fi
>
> zram_load()
> {
> ...
> 	if [ ! -d "/sys/class/zram-control" ]; then
> 		modprobe zram num_devices=$dev_num
> 		module_load=1
> 		dev_start=0
> 		dev_end=$(($dev_num - 1))
> 		tst_res TPASS "all zram devices(/dev/zram0~$dev_end) successfully created"
> 		return
> 	fi
>
> 	tst_kvcmp -lt $ZRAM_SYSCTL_KERNEL_VERSION&&  \
> 		tst_brk TCONF "test requires kernel $ZRAM_SYSCTL_KERNEL_VERSION+"
>
> 	dev_start=$(ls /dev/zram* | wc -w)
> 	dev_end=$(($dev_start + $dev_num - 1))
>
> 	for i in $(seq  $dev_start $dev_end); do
> 		cat /sys/class/zram-control/hot_add>  /dev/null
> 	done
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
