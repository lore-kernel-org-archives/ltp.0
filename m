Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBECAC7618D
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 03:10:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D55943CD059
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 05:10:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4AE53CC816
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:10:25 +0200 (CEST)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E2861400771
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 05:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1680577825; x=1712113825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1PY4n6Qz7mm9mQsqDaR5Ke2kLbUYcla8eNL5yaiNJJI=;
 b=w8pUz6jM4Rzl/bjA5J1jq9q9dlFjZcmEPhbdonoAAKXMRNbggJl1P7lI
 LY3MfgOzRzAejLHpmRkMmFmSjpirg/Ss7R4h9kKo6VGLix7RlvBryGPkN
 U+Z+cIq/qcIma+LW4YMdL9XoLkm3X8VOnRkMKjAtb7itjZhhu5Cq0P2US
 nYE2EDCv2sFzMdrgrY9DsECwlPMxqssCAjv4hVV9ATwZmrUeP29fQUmCf
 y8uu82IQUfHE65JpKWe1V1sDiTDNUOLJ793TIUPM7wef0yQKMGygEQ5Mm
 hseqsVOF0EpaHPtvLKPFnOza182wQYJeE/pAUSxzL8XX+NWS4Q88gnxKm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="80914049"
X-IronPort-AV: E=Sophos;i="5.98,316,1673881200"; d="scan'208";a="80914049"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2023 12:10:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwzLyXDT3D279RFR/3HKfCp3So7Meb/BtHWRl/OtlwSqj6UlQMQLZ6VA61TCDKNR1kQgLAx7rHO5lq07Xru/zEQhmp9THtNkoKAyrU7PZcIM0uQ4Vb+wRlCO95qFeCYYpKALzUN5Ok7mb8ywYqxcipfIsVoYgQ42gk5jQ4fa4aaYtP8dK3Y+JjDO8pst1Utlff8bCrkhzWnaaeeBo2zXwLUsNjgB+hW/GLjI1ZjcZ1KquxIpruHzEhPlpp9FfjLyOBMO2Hea1GyF2wQOSlYLfDhuT3LLTwYE3I8C3vYOxZcuU0EHlfxTcfNnHIz/q7I3DDP51NxqDLG3g8AmbmAJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PY4n6Qz7mm9mQsqDaR5Ke2kLbUYcla8eNL5yaiNJJI=;
 b=mjM93jaT8CoVHMigx8dy+riGe956QX597k73DVAwDOUjikvOhEwVZfDrVpTC0FRxkKxUzCN8dHXsGX1Thu/NSCymiPMhAJINoaz3D1cMHCXTi0BZmRA8T1h4c3Yf1mw+jWSNvk20rWfDq6EHXU6JXw8WNgRINU1EV8HVGHPY0PEnDA/ri2NJdK5G1MDZlOCKMpK0AZCOVMZyHX74IrIzg0Gy480k+K9VmD54MynFSpejDAAaf/USE0O3Oein+7blJc+LcVTqXQuaem8LsIzc7rYDr+i3yr0J8/R8mrTADSozJjTTISjRUn3Fip0N3J7HH3+30EO0dx0h2bdP9xOq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TYCPR01MB5950.jpnprd01.prod.outlook.com (2603:1096:400:41::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 03:10:19 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%5]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 03:10:19 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Eric Biggers <ebiggers@kernel.org>
Thread-Topic: [PATCH v2 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZZhlmGuqibfhpz0uv/+Sf8GdefK8Zz5WAgACqLwA=
Date: Tue, 4 Apr 2023 03:10:19 +0000
Message-ID: <3d4451f8-ace1-e8c2-df08-7444d6ab5905@fujitsu.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680518676-2863-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZCsGV6/JecnAfRxL@gmail.com>
In-Reply-To: <ZCsGV6/JecnAfRxL@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TYCPR01MB5950:EE_
x-ms-office365-filtering-correlation-id: 08b13eff-ef7d-499b-5865-08db34ba1efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smzHm3IkcPNNBVkh68BSh4KsLrqJxR7Gy24cbT8y3Bo3Vryu7AHhJyvmLsR17ajuGlNT2YglWktBq7CqwyQqltb9IGQun71nQ5NogckhOAIW6Mojwvm/sIsaUl1yuLOvLBRjzP9uw9P4XNpqQRP5i1J9wyW670NaJhL55Wdt/BzLKRHZzI7wySwfIoB0ZUDrEz4WI+h6rXkjL/18Wacd24C3fkuWgqOIDq7TXTo3dS8CsV6cWkJlFXf9MHSgv0BAXnpFs1MU01hCri5T0LEj2Z/5vZMQx+FaNfHE4EUFQyNJu4GjocghzF0e93ZnhxqTzN1ffOqUUrJj/oIETD3xwI4PwIiWhNc0Ailf3gEcWS1OP/IrcHtesrsHPCpIMKRN3FmxqKZHCNvrfxvdZCPjkpMQr5fyp5myZ7dBCJCY9BdziMz/yl9lJEvv9Oj+PwfR8sXJ3tm9/BQscAm8g9ZegClftP53dCT7nLMkSc7dymMd1jE6XksxnIgw0Kj57tSxDdc+g/B9djDI+ilBwbawUauzKj697GFshBeLJfWlBw6RdvX0OEGrG2luuXd2pYfbTACiQoOVnvC5v5zTscXgmkw5EuAL8R8G8D0DIBLtXUWuGl0C3A9lyHhDnKOkLHshLFdKWH+JtRot6TkBEEui2j5FobfZeriXEUS3cIa5AXPiqD6Ue4sxc7X0g/NIcMCY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(1590799018)(2906002)(478600001)(86362001)(6512007)(2616005)(26005)(83380400001)(6506007)(186003)(82960400001)(122000001)(38100700002)(31696002)(38070700005)(71200400001)(6486002)(36756003)(85182001)(66556008)(5660300002)(31686004)(76116006)(91956017)(41300700001)(66946007)(8936002)(66476007)(4326008)(64756008)(66446008)(316002)(1580799015)(6916009)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdIN0RPYUN3NVI5ZkJTRTdGQnlBUU0yTVF0WGpkRDhWTGN6SGZwdi9MbTk2?=
 =?utf-8?B?WmhBZHVTdW5MT2pwVGJkRWE0eDMrRVk2Sm5EVFpKL0E0TW1wQnFOd0pHL3Yy?=
 =?utf-8?B?c3ZoQlhXdXNEM2dlZVp1aG90V3g3eWxTcG1GTDQyY3VxOUFNenVQbCtFUlBs?=
 =?utf-8?B?UktLZTlzQXFTT2FKa1pSVEtTK0k3Ky8yd0IrRFRkbG5iaGJ1Tndsb3JWNStB?=
 =?utf-8?B?N1ZubTFLMHdzZjNjNjNuc2t0cHVKOHd0RWt1THNwYUhOb3J2OUhoYlBqVU9O?=
 =?utf-8?B?UTI5S1U4Q0c3MlYrTzM4dlNickdxVTFvR09IM1NhUzk4bFNZOFYzUTE2OEc3?=
 =?utf-8?B?SnlXNXg5UXJSVnMvbWZPOUY2OEhGRzI4N0JVcnJ6TlN1cnVsZHQ3NGhFd0E3?=
 =?utf-8?B?QjRYeFZKV0VreFhmUnVucHhjWnZZQjd1emUzL2QwT2pGRnYzUG9BRit0aFVW?=
 =?utf-8?B?S2pWaDJrWkEySDluZkxFK1FBd0tOamJ5ZVdVSW9Wc0pnSHN0TnlrQVNNb3la?=
 =?utf-8?B?Yi9SY1FlNENWeWxncE5ZWmNJV0NqTDR1eTN5Zmo4QytmZGJQVXVNaHh4V1pS?=
 =?utf-8?B?ditKbzNUN3cxLytZWWVlNFF4RFp2RFk3cGhwNVRsNnRwSnphUTUvc0I0Qlp1?=
 =?utf-8?B?dmVWN3ZaRW5XREUxSWtVb2hNTnF4dVRCVjZtVGhaQ0ZwMjhDUmkrTnZiUjdu?=
 =?utf-8?B?ZjdPUExVSTJTckRJamhxVFdDUFdmSWFsbERmbEVXNDhPS1pWNmZQMDVERS9v?=
 =?utf-8?B?RStRV0w5b3ZRNXVJbVVJNVpjRW93T1lFd2I4SFNwQWI4S0M2NTVXVHlJK2cw?=
 =?utf-8?B?eVQvRnI5dTZCOHNPZk5VbmJjMkJEcW12UVQvdHBVSng4MnJCN3F2a0tkQ0Q3?=
 =?utf-8?B?S00xUm1ERzdhYy9oT1ZLYTlGcWZDM2ZTaWNWLysraDE3UmlCMkdodllRRzZa?=
 =?utf-8?B?K1pzbUtzbFlLNlhhUE9ra1QrQmNGOE1hZUNyVmpNTFdWTkt0dFl2ZEV3NzRB?=
 =?utf-8?B?VkFVWVltQ1loVGZXTkhIYnl3dVgxbHJYUlY4SERvaWZhQnpHb20rNzJZRWRC?=
 =?utf-8?B?Y2RSVk9HNTF4SVpPbi95dnpjalV5NEJ1Y0dLclZmOEViUndYNEhOYlkzYTM0?=
 =?utf-8?B?RlZrdTZqeWNPQjl3cDRQcTN3N3Vkd1h5VytYalhFeWJFR1FXMHJCTHQ5a29Y?=
 =?utf-8?B?eGpQVEZ5Yi9tWkZCeGttZE9jUVFLZC9EbHdDM0Y3d1dSR2d1dGVDZ2xRRFd1?=
 =?utf-8?B?WUd5Sm40TEdaQ2UzRnQ4c1ZXcU0xODNFWllGQUhmZnBPbkVQZFBYTmNuTWZz?=
 =?utf-8?B?ZG5ralFZak9QdktRalBCbGhUNHdRSU9HS05JQVhZRGhRWlB2TlRFVDZ1M1ps?=
 =?utf-8?B?WE9EbXVZRjhRK3NucHhJOHdQNmdBWmZrcitReXUvMTIvTTZkTzBia2xDQ3FB?=
 =?utf-8?B?VlNIaEo1dG5pNDVpbDVYbEdKTnpUWmd0bFFld2RvMWNDSncyLzNHQUoyT0xM?=
 =?utf-8?B?WTA5Q1RYNFJUaFVqNHFSeE9yczdpcHM1MHpkZ2RJVUIvOTV1Y0gyQ3N2S240?=
 =?utf-8?B?VWJJV3FteXNuZFhlSXcwNkdEc3pTZVFFbGxwV2RnMS9HM1hPeFRtcVR6T3Bz?=
 =?utf-8?B?Q25idjBtbllSYnkrZHJzRWRPOC9IeHhxb0N2Y3RuaXZLMmo0NVYwVkxQV09j?=
 =?utf-8?B?c3BKOHBCQStLU3RLcTBUUVN2Y1VrSFNzWjBReUtLUEFoMXJGdDljU0c1R016?=
 =?utf-8?B?bklJaWVMamtoRjVLVDlJU0lXRDZlYjZsWFVFdVp1Y1BOdTVHc2tGaXprSEpL?=
 =?utf-8?B?d0NZbkU2VDk4L3FPYlpVTjA0Zk9JblRnRXNpVGlmWi80YVNJb0NlaGxqNlpP?=
 =?utf-8?B?TmVBVENWRTlsSkNlZkhZWHZLZDd3bWRZeVhCNVF6TjZyWGl4VTk5dHYxYXJp?=
 =?utf-8?B?ZWRsLzZLVWd3SE5uK0t2V0I1a2JpSE0vRUFKOUV0aWQyNGExQW9LWEZQVHlK?=
 =?utf-8?B?K1NMYlRVb0lXb1lZaERlMjdZK0hnMHg2dEF3ZEM5NlJYbURsUmNPM3ZIQVFN?=
 =?utf-8?B?dGVWK0M3c21KdkVDMEdyMFhsaUpmWU5BSVZXakdwTVY3WW5ZeWMzYXVsdXUx?=
 =?utf-8?B?QmFPN09JdW1QOHVwNlhsTjEvUE5ROXRqcXBodzBhUGp1MXhJZGZZSWdGTG1Z?=
 =?utf-8?B?U1E9PQ==?=
Content-ID: <64A6931C49836E4F88480915C2F178E0@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bAW3v1GXXeY6VcBMm9fz3WYGQBxqZJF7JOl1k3l9VvjYdHgo0nsNsP6m3yjnHqf1qWasrKhh9mU9ghntpR/FEhGVuoZFDp0fp8U8LSCTGkWb0XbOgAHDOZ9f18qseEmUUmfojrRCk40QRDgeruOVGR+hXZQjMjUajgWDeyVZC8bzs+CGq5+GJy2ynFyPh3s2lipnKrhBlWP3OmZA/JZz4bmt0WW4xnezOr3jUze7w4zKxjHbk7vCcDdLnM+AakT9+VVR0XsKp1Y6k3RW9fwNk6tdzDGRNlIzcXpd+0TMdRBc6yQbaavjuiilAt+Jq+TjyFcRR8enb5wCAo6OZA+mKg+PjMB1jOvZfW0NVCd0g9PWa2SoWjc4aS/rxSMoCYPAW9gjuR01DCz1+N/UCnbc12FN0qBg7+JwyqW2RPn6r4M3VSo39Ah/Aq3pFNws10u7ReXiNTaqULpROVDF158j3QdNUG4LpmtD9DIg5VY0Si0XPMxqEl+2OCE+duw2hzUMl5W4i8LnAnvyi4H95lLc0+akugBFz2jaW8aw906hNdLzOwM9QcFx2aJA/VPf1HpF29zMGwvPX+55dZqy7LrTt7K/lEG+WsOBp7VKM8Yoc6MAie2CEVpSenD/xcqWlB+wjbn5VMqfdcax91DENAM38PRcWN0qeT1QUKAN4BkMOLZWC3STpk6Xv70f9QY6SD581K5ug5rKLz7/emNuogHUDwLoxkka6UUMocDIHlMuRwYuwECKv4QpnPS/MFK3nM974hiSn/7Yb08Ei/emmgewSqJ9CpLYS96slXiaUi9vBqQ=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b13eff-ef7d-499b-5865-08db34ba1efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 03:10:19.1083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qct/sA5lC+fcDHZYW1zKimUn0lYhTjkl8An3AK4C5UXr2qMJJBXEH3vYzHPfGEDfHGd9fqWfZM4ePWblSCdRK0lxD8y+fmZ7EKGKLSLHGs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5950
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/statx10: Add basic test for
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


on 2023/04/04 1:01, Eric Biggers wrote:
> On Mon, Apr 03, 2023 at 06:44:34PM +0800, Yang Xu wrote:
>> +static void verify_statx(void)
>> +{
>> +	struct statx buf;
>> +
>> +	memset(&buf, 0, sizeof(buf));
>> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE, 0, STATX_DIOALIGN, &buf),
>> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", TESTFILE);
>> +
>> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
>> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
>> +		return;
>> +	}
>> +
>> +	if (buf.stx_dio_mem_align != 0)
>> +		tst_res(TPASS, "stx_dio_mem_align:%u", buf.stx_dio_mem_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");
>> +
>> +	if (buf.stx_dio_offset_align != 0)
>> +		tst_res(TPASS, "stx_dio_offset_align:%u", buf.stx_dio_offset_align);
>> +	else
>> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	if (strcmp(tst_device->fs_type, "xfs") && strcmp(tst_device->fs_type, "ext4"))
>> +		tst_brk(TCONF, "This test only supports ext4 and xfs");
>> +
>> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
>> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
>> +	if (fd == -1 && errno == EINVAL)
>> +		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
>> +}
> 
> On ext4, files that use certain filesystem features (data journalling,
> encryption, and verity) fall back to buffered I/O.  This test will fail when
> passed such a file, as it assumes that DIO doesn't fall back to buffered I/O.

Yes, I also reproduce it when I  mount a partion with data=journal on 
/tmp directory.

  mount -o data=journal /dev/vdb /tmp
[root@localhost statx]# ./statx10
......
tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:59: TCONF: This test only supports ext4 and xfs
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:59: TCONF: This test only supports ext4 and xfs
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf) 
passed
statx10.c:48: TFAIL: don't get stx_dio_mem_align on supported dio fs
statx10.c:53: TFAIL: don't get stx_dio_offset_align on supported dio fs
tst_test.c:1634: TINFO: === Testing on xfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf) 
passed
statx10.c:48: TFAIL: don't get stx_dio_mem_align on supported dio fs
statx10.c:53: TFAIL: don't get stx_dio_offset_align on supported dio fs
tst_test.c:1634: TINFO: === Testing on tmpfs ===
tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1074: TINFO: Limiting tmpfs size to 32MB
statx10.c:59: TCONF: This test only supports ext4 and xfs

IMO, If we use a actual block device to test instead of use a loop 
device on /tmp directory, it should be ok.

export LTP_DEV=/dev/vdb
tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/vdb with ext2 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:59: TCONF: This test only supports ext4 and xfs
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/vdb with ext3 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:59: TCONF: This test only supports ext4 and xfs
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/vdb with ext4 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf) 
passed
statx10.c:46: TPASS: stx_dio_mem_align:512
statx10.c:51: TPASS: stx_dio_offset_align:512
tst_test.c:1634: TINFO: === Testing on xfs ===
tst_test.c:1093: TINFO: Formatting /dev/vdb with xfs opts='' extra opts=''
statx10.c:37: TPASS: statx(AT_FDCWD, testfile, 0, STATX_DIOALIGN, &buf) 
passed
statx10.c:46: TPASS: stx_dio_mem_align:512
statx10.c:51: TPASS: stx_dio_offset_align:512
tst_test.c:1634: TINFO: === Testing on tmpfs ===
tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1074: TINFO: Limiting tmpfs size to 32MB
statx10.c:59: TCONF: This test only supports ext4 and xfs

> 
> How is it guaranteed that such a file is not passed to this test?

Since /etc/mk2fs.conf doesn't enable data=journal, encrypt, verity 
feature by default and ltp use default mkfs configure , mount option.

I think we can detect dio io support before mount.


Best Regards
Yang Xu



> 
> - Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
