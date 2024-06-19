Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC12C27C79
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 05:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E933D0DA7
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 07:24:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B6BB3CE037
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 07:24:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=toshiba.co.jp (client-ip=210.130.202.152;
 helo=mo-csw.securemx.jp; envelope-from=nobuhiro1.iwamatsu@toshiba.co.jp;
 receiver=lists.linux.it)
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C1B3601B2C
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 07:24:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toshiba.co.jp;
 h=From:To:CC
 :Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
 key2.smx; t=1718774667; x=1719984267;
 bh=T5FTdKvchtm6vIXOm8n8Lywbsa60sMbeg5EMqrb
 4dvE=; b=Wl3WoG2x4TK33FbLLlpQAqQxxrHesQCRD2Jtmx0MsvFCTWONW25uQkC5fj9/KO1pY2594
 3sAka6OiDJV5IHwyL9d/PQFVlZVCTUoTjVfxDiihWv71c19Q/ZO0R43tEKncNcQdFp+5Oto4F27A7
 XivxvdHbY82qPD4PEn7rapiFTMtqSDipMVQq8LyrTh8sJqA5C78cd/aEciQ7Nouv2ynEe5lHNC5av
 MOgnTceRJSBznlk/WrW0Zm/MeB74+CGw6CzKm3IbBExSILNwVJTjqvFZrXdNiRg4HjhQ05PD1ufMI
 cyPK94g+ftQ6wxph5jAs/Xo6CvnRAPUaVBXZPF7oDQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45J5ORfT364002;
 Wed, 19 Jun 2024 14:24:27 +0900
X-Iguazu-Qid: 2yAbLYkr6ijD7wcrFw
X-Iguazu-QSIG: v=2; s=0; t=1718774667; q=2yAbLYkr6ijD7wcrFw;
 m=ZgH+1JSlfV9qynHjCPMotlZmOBEKysnXquKuKix5PV8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
 by relay.securemx.jp (mx-mr1803) id 45J5OQeq1695944
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Jun 2024 14:24:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoGwdMFKts1gy2p5wNbEnWcEFK2n8QeSrhA9IhXjfyyeMadkmZzi2tRsc8zxGXiI/ZyLzC93ajMBqVESgHHF6K52R6OfAH3r7L6mdiaLSELEV4T4kIPI9luuiFwgB5owpCF1mTOlUGU7w7u83jTxHHZVp8W3EixJldlrOoVh3bYi3sXM21nGr4nGciZYvb4SyrQLakVFx9cb1LmsT0o4H+22iNgf2+eDuKEXz2C/Gv0A9pR/Goteb7US2/k55ofGFPyYK1OVqwB4vRAc00Tu3sca3k1mwy0Owmgv/ofsDi/csPhkSnUJTgBaiXM5mIf6E0C7tB3RfVnkJ2sBruFcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WjsJ4Y69LwV8zLba8dp3bQzgU7WZHoSuXak1i9t090=;
 b=of6dNEyzvHrfgYeMDKxqLM14f8l2VR7NYAdXVdq6gwsXmOAo1t0qvkgVHSc7Oyzd1WUi9k9CJo4NtFoAhanVJqajmSD38lBP+EQCoii4OmjPAVBXjG4gavDIwSJ43K98hS8y8KJt+44hPJH8vDlNq28bHyEx84dUGn0voig0M++0BiJBd7nAkyTcw1gDlhCbm7KBNCEVSxm1L5v5O38KNXQ+sPxDRIwBzc/sWqKihbdJ4sElbxFMk+0d9iqYyP5qLXDPD/a4dq7TGT9CEYRcVF8tr7kUYGqy7TogRQmXGQMX/bFcXoYjov8xFHvphfGbzaKQ127Xgx2+CUkw3Qy7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <chrubis@suse.cz>
Thread-Topic: [PATCH] lib: tst_fd: Add kernel version check to memfd_secret
Thread-Index: AQHawVxjuX99tooiv0ut5Yo6NW/jt7HNTkYAgAE52CA=
Date: Wed, 19 Jun 2024 05:24:23 +0000
X-TSB-HOP2: ON
Message-ID: <OS3PR01MB639110A9BC48CA10A9D97FEC92CF2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <ZnFeWJJldj_ggKnq@yuki>
In-Reply-To: <ZnFeWJJldj_ggKnq@yuki>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYCPR01MB8111:EE_
x-ms-office365-filtering-correlation-id: 711ff995-53cf-4841-09ed-08dc90201469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|1800799021|376011|38070700015|95630200002; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?by9PcG1GZnJOMVM2WFdxeUdRRExydzNScjBva1dkU1BPcUZDamZLN2xx?=
 =?iso-2022-jp?B?a3ZweU5OR1lqdGV5WDBCSytZb0FCMVByWkxEMzNPdCt2andzTW1TTk9I?=
 =?iso-2022-jp?B?bXNJazFCTmhFdmxVcXFkTGxUM2VLK05GbFZId2tlVGZGbHRHaE1tOFFC?=
 =?iso-2022-jp?B?ZG53SSttK1FudWFkZHZyb3Fwc2M3bVJ6SmtJWk9mdnNCNVBSQ1c3dHFi?=
 =?iso-2022-jp?B?Kzk3dW16VEFXZjRIWGtkeUIrNnlFOVZGQVo1bTNIUDFmcmRaclNWd01O?=
 =?iso-2022-jp?B?bjhWalNLNVZ1eWR1Qy93RTNwUm9VaEJta011TGszQmg1UGhQd0dtZDJI?=
 =?iso-2022-jp?B?Z3h3TjROcXVwK01YQTE4VjA0RHp5ZENSVitSdHlObHpCQlVEOFgvakVu?=
 =?iso-2022-jp?B?eVd4YmZjWFFRbC9QNmJnTHpqUE5rZUxhMWR6Z3B6TzVublZYWTRhWjNw?=
 =?iso-2022-jp?B?TjhNZDQwOVIwU2xJLzhoaVlTYzZnbUlNZU10MFRSUXBSd3B1NXNwY2Rm?=
 =?iso-2022-jp?B?YXZZU1FLaHdqZmJxU0IyWCt1c0l6RzdnVGhlZGJoU3VKMFdmNXF5NHhw?=
 =?iso-2022-jp?B?d0p4UHZxcnZ4ZHRhVzdsdytXd1pqdlhZdm9ybERpREtHOW10eHBQS3FM?=
 =?iso-2022-jp?B?U2swSDdmYjZLdDFPb1dwbUpyVXJKMnZOZ2lxd0c5NU52Vm1aTURIZzZP?=
 =?iso-2022-jp?B?Q2laeGpuYkRUc1hKV0lhUHFXWFNjdkdGeTNtaURNKzM2TWFVQWVNZEtu?=
 =?iso-2022-jp?B?WllwWW54VHRFNTQvYjZRc0NTcnRRMnpKMms1RmRVaDZCWUFMd3l6dnQy?=
 =?iso-2022-jp?B?Q2d5aGVTdWhpL1B5OHJBSkNHTmU5Zm5NcFFDRXQrT29xazhYeFpjd0ti?=
 =?iso-2022-jp?B?Z0s3M0dablk1ZjNBalBLUW1CSGFKNjBsa0VST082MUNjRHhTVDFETElU?=
 =?iso-2022-jp?B?bmg0ZjNlbTd1U0JpVnZSMThYOE9UTzF1Y3NkTEV6SjFsbW1TNi9WemNn?=
 =?iso-2022-jp?B?eE5CeHRGNExoSmpxZDhBajZwVVNxczJkUmF6WXNwZHNlejdSaGpGK3RK?=
 =?iso-2022-jp?B?RGRzckV6YmJheFZRWStDRFlxblFETTMvN3pMZ1FIK1k2Qzd3K3JsanJU?=
 =?iso-2022-jp?B?aWNmS2c0cnB5VEtKUE5mV3ZXMHgwWWo1TnJiZ2w4L1JGcEZ5blA1bkNM?=
 =?iso-2022-jp?B?a0lDaTBVdklkaE0ydDRlSUkyclFqQXFFdHlWZytZeU1HSzdXQTJoWXBq?=
 =?iso-2022-jp?B?cWJ6TzdlUnM1S01ubGpjaXQvZHQ1SDRYbElqZ05keFZnZzhEbHRMVDRm?=
 =?iso-2022-jp?B?akpsTk5jQjcwUEsxbkN5VlZ2Lzg2akxLenBHUi9MR0pKQm9uOHFpMUlz?=
 =?iso-2022-jp?B?VXZUbGMrcm1Ia2lEMTdNMXNIMyt3eW5HT2pGbnRDQUpKVk1aYkovQUFy?=
 =?iso-2022-jp?B?WExBajJCK3d3TFBYM25uemhUWk1WRWlmejRDeGRjbnAzUXRJeHdFYUxN?=
 =?iso-2022-jp?B?U3U5V2FzUGU3MVRsb3I2bXpZS1pWZ1huYnZ0Vy95MzlJQlBsSGhvbGpU?=
 =?iso-2022-jp?B?SFp6dFVTRkhxV1Bhek5VV2NHN0o5ckZPRlZhQU45MXpIRDExSkQ5WUNG?=
 =?iso-2022-jp?B?UEtJMVJGRGlvWVNMWTZpdWZIZ043NVFRVkZTSXR4M0xhVDh4QXBxQjkz?=
 =?iso-2022-jp?B?QXFwQTRyVjZiK3JvdXdKRU9NbmRyRFlwU0tFd3VpWlBVTjM5Y1A0YlVR?=
 =?iso-2022-jp?B?czJoRllIVHdSaitheFp0KzZCUm5FcUEwL0pUL05VaVEzVzN6TjJGeFdi?=
 =?iso-2022-jp?B?eitLdkRHb0drLzVGSURpektoTnlCOHozd3RyUVRURHF5U01ReTJBRldv?=
 =?iso-2022-jp?B?S1NrakIxeWVZUzZWczJLOFJxY2duNzF4SFRYZFQwQTN3cFRqT01tNmZ0?=
 =?iso-2022-jp?B?Um43d2NYdDduQVF5WVorK3ZpdFo1Y0NhYllFVGlsMnpBQmpKaXRMUEZF?=
 =?iso-2022-jp?B?RGtiMGRwWm1ybHRFWVpRTlhHQk9HQW03eFhpZmY5Yk8waHZVTHJidWFC?=
 =?iso-2022-jp?B?WlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6391.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011)(38070700015)(95630200002); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NmhwakZQWTljMFRXeGtJRnBzSG1wRmR5RzFScUUwTk5Eek5DUERzcGIz?=
 =?iso-2022-jp?B?TS9KOFhDbU9zNHc1WGM3VHhRN2JTOUE4SkRkRGhGbkRuZStaQXJTQVRR?=
 =?iso-2022-jp?B?TnpIcXROS2s4K21qd3NaK20ycFFoQS9hOVZBaklVNW82UGQ4aEJHSGND?=
 =?iso-2022-jp?B?N0lkcklFOGduWGt1VUptQXZmYVlxVDNWTW9BcjdqcW5XV3YxOWRXN1lG?=
 =?iso-2022-jp?B?MFBCU3FmeUoveVh5SnYvbmRZL0NpS1pxczdXRTRBQUVzS0gxaTRnS1l3?=
 =?iso-2022-jp?B?QVFKQ2xhajdlVUI2M1dvc3h2SXBhakpWVlVzL3N2a2gxYjNwVG1aalhy?=
 =?iso-2022-jp?B?M1EwL3NQalhISlIzN25nNFVUQVRpaVYvMmdFK2s4dlhDNVBRaEw0RFZL?=
 =?iso-2022-jp?B?R3BsbEhvSkx1akhSRGEyTERFU1NSbEhJTThyMDlhMHBwdTYxOHFDOUhT?=
 =?iso-2022-jp?B?NWUveVo0YURONGt6Q2pCRTROMGdyK0lXMkdCVGViNVdOODJsQmx0UnJV?=
 =?iso-2022-jp?B?UlVydkt5V25Uc3dDU3NvOHJ4VjF1U0RaM3lzRUpQVUdVVEJGeWlMNEhr?=
 =?iso-2022-jp?B?RjIzUk01cjBtbUVnZExoRFlSM3pPNXJvVkRlS20zdXB2clpEZUJITUln?=
 =?iso-2022-jp?B?Y1Zkd2NUZVV4WVMzUExKRFZ0T3BJUzZRNFRXVC83cXFLd0NBWGRNS0hu?=
 =?iso-2022-jp?B?ZWd1RG03blEwZmRya0FEL0xIZzRJTzNlTDNyc1gzcmFGc3EyZmhDTXRO?=
 =?iso-2022-jp?B?TDNHY3VIRllKUnBFRDUvR3RQN0pGa0hGYnhpTlYrTk1IcWdZZHY2aGU1?=
 =?iso-2022-jp?B?a1dFaWtxZzE4M2c0NE9FSzJ4UHF3NFZ5OG1GdkpnSzRISC9uYmxGbXht?=
 =?iso-2022-jp?B?WkVCR2R1VUllME5Tek1HUjN5V2tvMWt2RTllVm1rL0w4STNzSW1oRWNh?=
 =?iso-2022-jp?B?NDFuSXl0anNLTzRKaVVrSXJjSVBiY3Q1VSs0NjhvU2s3YzNpSHZ2bEVI?=
 =?iso-2022-jp?B?RVJvdTdWaFh0VnY2VkpPVEVFMytSMTJKQ1A2MUpseUpJN1JiZ0RQQ2NC?=
 =?iso-2022-jp?B?QkNoK1BIRHR0QzZ4R2hzc3BFUmw1bmFWZDZNSWppWkc3aEFOcktlQVpq?=
 =?iso-2022-jp?B?R1FnQ3MvZGJMRUd6b0pqd2ZlcGExVXl3cjNibDZFYndRWCtZbERLOVcy?=
 =?iso-2022-jp?B?d2lGUWNMcHo0RFBibW9LWTd5UHJTdjNMNmdJNWFHaEppcGpQV0RQckd4?=
 =?iso-2022-jp?B?M2pTOE0xTEZMNGhsYTJrTjlLV3FrOGZSM1dnNTZ3QUZMNnRjODNpK0Z6?=
 =?iso-2022-jp?B?RlpOMUJiWWREZW1LeERQd3pxRmIzK3FHK2tlRGk1UjMzZjFNVGprd25j?=
 =?iso-2022-jp?B?bHpPSFp1L0pneGFHUWp5dkN0NDhjMHRxckI4bnVaellXQStldVVMZnJl?=
 =?iso-2022-jp?B?aGFhT0dER2lOcUd1cVVNaFVTTjBPZG5HTUg4Uk1LZjdoT2t3eFN6clhQ?=
 =?iso-2022-jp?B?MGkyYWRMbWpuckJkOUkxU0VmTGxSczlTTEtFSkk4Q1JkWmo0VFpianZj?=
 =?iso-2022-jp?B?MkFBYnhKQzJqWFljWVhlcEh0YXpBWmlTdmVwNTl3WTRSa0dZZ05SSVRx?=
 =?iso-2022-jp?B?cHdzVm0zR0RRWHg4KzJwaTR0S01ZVnNWZGhaRjVLekVnd0FaWkMxd1d6?=
 =?iso-2022-jp?B?c290eVdHR0l5MHlTcHlVazdPY1UxZ1kxVEZxTDVkbGZvMDVTYjF0Mm5G?=
 =?iso-2022-jp?B?eGtXSWkyemR6U3VLTHIwVkxNSWZBQVFWU3VBNG0ybjBVUzN1L0xTM1ZB?=
 =?iso-2022-jp?B?d0h5TWFDbnlCQWZwQS9xN0lRSWthbXNlbUFSSHBtNFV1MWhKQXBDZjNN?=
 =?iso-2022-jp?B?TktVbHVMeHFtOEdicUxRSGR6RmtFaEord0pOYTFFRUhxajg0Q1BxWkZM?=
 =?iso-2022-jp?B?S0doMklDUzZCQ2dBYVV6M0hVdm43eGMvd3dQVnBEUEtEdEwrZURRUmc4?=
 =?iso-2022-jp?B?OGRXUVlVQS9MY3BZU3Q5dmJKSDdnYldzSEFzb0ZLNlRqbGtKRTRhaTNM?=
 =?iso-2022-jp?B?UC8rUngzT0NXRHZTUHNkMEFlV0p0UmZKK010SHFncCtacHhRZ0JlOTEw?=
 =?iso-2022-jp?B?amF4R2FqTGtIZmhOTXhLMEhXTnlvNkZ5aTZsdW5udzlsMGpkQUZVVkR3?=
 =?iso-2022-jp?B?dE1FWWJBMUlFSldWT0pySnExWG5scXplVGNRaE1hYU9zeEJNTTVDWjNw?=
 =?iso-2022-jp?B?ek5pbVRCMjRsdWx6S1Iwd0gvVGxVVnpyMnF6VThyRjdhckxTY0tlRjNj?=
 =?iso-2022-jp?B?dzVyVDlZaFNpSlU5MlBFWjNtekY0OVRYTUE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711ff995-53cf-4841-09ed-08dc90201469
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 05:24:23.5183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYduD+cAKXqUEaGwaxUHZGXAHS+wfGFjk1hhsaoxbFpAgNmNsG4mm8T/jmy+VQHjZq9kwBM0jLGhxNDbwsEBi44E/WcYVZDZGvhUwb0P+YzntACGr3fjAZCNxUzxHQ+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8111
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thanks for your review.

> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz>
> Sent: Tuesday, June 18, 2024 7:16 PM
> To: iwamatsu nobuhiro(岩松 信洋 ○ＤＩＴＣ□ＤＩＴ○ＯＳＴ)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ltp@lists.linux.it
> Subject: Re: [PATCH] lib: tst_fd: Add kernel version check to memfd_secret
> 
> Hi!
> > memfd_secret is a syscall added since 5.14. On earlier kernels, tests
> > such as accept03, readahead01 and splice07 that use memfd_secret fail.
> > This adds a kernel version check to the tst_fd library when running
> > tests using memfd_secret.
> >
> > Test log on linux-5.10.162/arm32 with version 20240524:
> > ```
> > $ ./testcases/kernel/syscalls/accept/accept03
> > tst_test.c:1733: TINFO: LTP version: 20240524
> > tst_test.c:1617: TINFO: Timeout per run is 0h 00m 30s
> > accept03.c:58: TPASS: accept() on file : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on O_PATH file : EBADF (9)
> > accept03.c:58: TPASS: accept() on directory : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on /dev/zero : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on /proc/self/maps : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on pipe read end : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on pipe write end : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on epoll : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on eventfd : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on signalfd : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on timerfd : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on pidfd : ENOTSOCK (88)
> > tst_fd.c:151: TCONF: Skipping fanotify: ENOSYS (38)
> > accept03.c:58: TPASS: accept() on inotify : ENOTSOCK (88)
> > tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
> > accept03.c:58: TPASS: accept() on perf event : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on io uring : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on bpf map : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on fsopen : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on fspick : ENOTSOCK (88)
> > accept03.c:58: TPASS: accept() on open_tree : EBADF (9)
> > accept03.c:58: TPASS: accept() on memfd : ENOTSOCK (88)
> > tst_test.c:1677: TBROK: Test killed by SIGILL!
> 
> This looks like a bug either in kernel or libc.

This is caused by __NR_memfd_secure being defined as -1 (0xffffffff)and "Illegal instruction" 
occurs when syscall() is executed. And this problem does not occur on x86_64. 
I cannot decide if this is a bug or not. I can't decide if this is a bug or not, because this behavior has
existed for a long time.

> 
> > Summary:
> > passed   20
> > failed   0
> > broken   1
> > skipped  2
> > warnings 0
> > ```
> >
> > Closed: #1145
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  lib/tst_fd.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/lib/tst_fd.c b/lib/tst_fd.c index 6538a098c..53f583fa0
> > 100644
> > --- a/lib/tst_fd.c
> > +++ b/lib/tst_fd.c
> > @@ -255,8 +255,16 @@ static void open_memfd(struct tst_fd *fd)
> >
> >  static void open_memfd_secret(struct tst_fd *fd)  {
> > +	if ((tst_kvercmp(5, 14, 0)) < 0) {
> > +		tst_res(TINFO, "accept() on %s: Linux kernel version is before
> than v5.14", tst_fd_desc(fd));
> > +		errno = ENOSYS;
> > +		goto skip;
> > +	}
> > +
> >  	fd->fd = syscall(__NR_memfd_secret, 0);
> > +
> >  	if (fd->fd < 0) {
> > +skip:
> >  		tst_res(TCONF | TERRNO,
> >  			"Skipping %s", tst_fd_desc(fd));
> >  	}
> 
> And this looks like you are working around the bug.

Your point is correct...
I would suggest using tst_syscall() to check for syscall undefined instead
of this modification. How about this modification? 

```
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -255,7 +255,8 @@ static void open_memfd(struct tst_fd *fd)

 static void open_memfd_secret(struct tst_fd *fd)
 {
-       fd->fd = syscall(__NR_memfd_secret, 0);
+       fd->fd = tst_syscall(__NR_memfd_secret, 0);
        if (fd->fd < 0) {
                tst_res(TCONF | TERRNO,
                        "Skipping %s", tst_fd_desc(fd));
```


Best regards,
  Nobuhiro


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
