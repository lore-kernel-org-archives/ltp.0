Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B266DCD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779806381; h=date : to :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rOUd2R533G5f6s22kOoQyY7zxeU4TleFmsoUCEDqhS4=;
 b=BQXirdZFFa5EgqUNi4SjdOJb6cZyUiKa1Nk84GPO4ieCxDjAd+Is1tPdzvtEzsBfXQQhr
 SQ9eGlKJsXhTB6OjVZClJGc5vraGVRIJckHlmQZcXivJuSBfDNMR300K7mbDiVglc3lvfd3
 UNQXGqCnEMsY3J7YAeH+5xkFj1Og6ew=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E88573E62BF
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 16:39:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7622C3D01C8
 for <ltp@lists.linux.it>; Tue, 26 May 2026 03:21:12 +0200 (CEST)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5E8AB600857
 for <ltp@lists.linux.it>; Tue, 26 May 2026 03:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779758470; x=1811294470;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OS3DwN6lrZ9fWSNLN3YZLShwTUi3ueMKIjmVfiFFmV0=;
 b=ptbCnNAYtVW02oeHIF3o9gjQ2T9JYPn4Lci3QwW7+zCARwLAcERwhDxl
 hx6Lwg6MBshyhMH+rDattKxGwnwlrpo2/y0mYaT8d0oYtHhLg2Oz9CxD8
 0nHqMILSCrFLK+19M3cXcBHMPcix1B71uVaBCVMgyrCTpJQPD/9IXDokz
 6Tb1I+XJjqr2OXfpy4QHeJ8fqLV1wEc/0MMEZ/1o1RcnHeNcC1WEE4jEP
 5Hkth+4DjGLBYeiinVBhrpbRhrw3bJddvbxbZoFH+f5lya/a8IynBAyBw
 Wp4mWiz+8ObThqXUWmVEMRXGQo+2Sv09Me9EGGYi6mFBJW7Z6m+4i6P+N Q==;
X-CSE-ConnectionGUID: v5n3pYOqRdi2pMnPOqKaiA==
X-CSE-MsgGUID: fiFB2BCzTE+qDyXVs0hsng==
X-IronPort-AV: E=Sophos;i="6.24,168,1774281600"; d="scan'208";a="147378964"
Received: from mail-centralusazon11011033.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.33])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 May 2026 09:21:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITKpwUD7SnAWXZohAzsBRNa6gDCYbLPsKT1pV8l/U1VV17i1Ph73gPNG6SXFgntM35JygKaMHLjXTClepFFh9Rd+EsTOjtDSxaKmpxEDY1D6uB1kOsO0F1SBpbZR9R82jViKwYf3+IrrupoXz+VM0YYFDFQOt9AIKYbgPJuq2hpE1nXR0cUPnPMaqbddbBdhmgpTELWCePK6vLkDZnnjPDPSZ/9b8y4DUpbx8AeVZQhWAGaLedqo9VEhncdUtdCLo7s6Yij2WX3Xc8EwoXgybYLYxYK8npAqvoY8G20rxWkco1/bTzj2C7+0HXyJaONt+BmiZLE+njvoSChCZ1Fd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QphhbP70SLC2t+wZlQHOUmTcDNDPzaytmMUgxcFs1d8=;
 b=bEIO0Nvp8o5eox0ZVCYNuBvkjzBP2CZOYA8gCcYRq7++erBDG27EtU1ff9k3SezjvtGp/Kd0pwd1nlqbRrhzFO5EgucceFS6NXsFCZAP8D2GFZ2FRG9MGfvHVGD0DCVjGPvEdLpg7jkE974US8kpeuIC2e4YS6zG8DXVOl2NYWTfohaSKXWS+1P9lWYB7HhvYnM81IC0HhYKPEMuofnjtkA4NRZdnsYq6EeVRNFAFw8xfuKnl2ncnFt5eZdAqCmCcONCeCFcDGSGxsw8jCI/rN7Xjm8EoRpogy10AaKPk6RJJ4nl6+R19fW/FwJMEYbyTBEAZ0z9nuyubc3yD1Ymvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QphhbP70SLC2t+wZlQHOUmTcDNDPzaytmMUgxcFs1d8=;
 b=JMvF4g9RbBuCKzbZcE+89xA2ZFoK+KRyoZuD9pJOdFwljNat/rVhA3S79130GkV7Phq302tqH7sGX4vuPi80wKUfzk9Xvgj3SRd+2aJk6/X906aXkmTfq7VhiflKLW6xN4v+eRG0Y/zq3d0CXxhDSbkxyEUAEcyXUHi00hi5ZN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DM6PR04MB7097.namprd04.prod.outlook.com
 (2603:10b6:5:242::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 01:21:05 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:21:05 +0000
Date: Tue, 26 May 2026 10:20:59 +0900
To: priyama2 <priyama2@linux.ibm.com>
Message-ID: <ahTtZMiQ52AlVrU_@shinmob>
References: <20260428075302.7320ef7e3@imap1.dmz-prg2.suse.org>
 <20260501151420.1042995-1-priyama2@linux.ibm.com>
 <CAJCsO8epT++TaOs7=NAy+jC4pQDN9tA-1n_tFy233sHKkJ697w@mail.gmail.com>
 <3191ffc7-8ff7-4b14-8bb0-934853e6d2ea@suse.de>
 <bf329b6c-1acb-4168-82f8-a1c3de600dc9@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <bf329b6c-1acb-4168-82f8-a1c3de600dc9@linux.ibm.com>
X-ClientProxiedBy: TY4P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::7) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DM6PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d96dea-ca09-4e3c-ed1c-08debac50ea3
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|22082099003|56012099003|18002099003|3023799007|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Sn9wBTz79p3WPOJwHqNgPIr53i8JKqS0x2xXL0i9PxnIV9RnFWmWJU5ICGzadpMJJT5E/IcYPs9LHkr6w4e7jKhMBmqpQP1emjYMnTSqSm3AahjKzjURtjduDaYTZlDT8Exkup9l7e2+5cYnI/zAEDKgqDFPE4NN3vRJ7VRPj9LPOEczhDL1Zdrp4rYIAHmKXeNMAjdsXRSJjXLoRqZRGk/Sg6SId1lUicdr6iKy58NkWLzouLXffXXA0F8nmPIgkbtmwIxnbV/UmVdYmmkSDxoU2+kq+whZNQCu5C58SRXXMUVtCExHRCTWxpO4AQ84GgdBTC0uIeZRvX1jTPtLeKD7ovicqwOT45/DZlL6CwwVXhZurgYX79xKFWs1XV6R+lXuRSkOxrM3GZHRT9GpWvhj6yygsWHt1mQbOmTWfNLMRT3/wC2oJt7XOQRaMC6yIXUZyOkdK7BSRUFhjocL3YFQAfvGaRFspdX1hJXh2o1RBaBUACDKU/0NbqrowZCijtj2PO4dcpO7h7AFozS3+veojyhzYuC3Gbb7gc4pR9pF2PMO38EIexfcW15r1WxUSLa9LxU9AR8IdudGxlAHeOSvHoqTKSdlJ4BDybEWpQtCOrzhkO2MiLQv9rQNAR2ITmR33QrcY7WSwxvJ4sb8NoDPZXxi/PdCLiPpqg0ezTkuFQFbyEF4l+fsh7UV6T0m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB10065.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+l3XoQI/lRZnLNhDm4hdpgD5HqVcVp6hzvT/bJy8cvWyCKMVxQwLfuwsyLi?=
 =?us-ascii?Q?PG00u6mGLgj+eBgzVDXxvx0ZZnQH3/ruRDvw3fDhc5kkbWyuF+W0CqXiV3TU?=
 =?us-ascii?Q?qJ2ryvc+LsnGtxWI6dC1TDjCsuGmuKM2EjMPmBrODSogRws0TTW7Mmjmx5xl?=
 =?us-ascii?Q?gK02dxg6Gx9hI/9g1PhYg2/UpWBw0BCIud5+YdkUOVRMgO/pbrzNixjLB5OK?=
 =?us-ascii?Q?MCt3Z8EPHnLVjbJ84A8cYYspqySjBYjXDrgLpFsZdInKYU1dZtZj0qgEzqi7?=
 =?us-ascii?Q?D9jFthLpV3paY9WsEX1P1qsnQNP2rQEg+tzY/NtH3VhoM9WQ8JJfJkY9DkPQ?=
 =?us-ascii?Q?ByWw3nMbAeJl7iY0ksqU2RhikBLufu2XRYVCW9YzK8Mk+rHR6mDjFpRmh5Le?=
 =?us-ascii?Q?5EuPGO3ROtz8rmCay+DrH5hVT/bOBBfBVQOdIFGkqoET7E64FMdyojyUfi+H?=
 =?us-ascii?Q?H9E0Jq9k5aQ0WCLMQuBLWxkCK2h97V/b2hocQ2ZaCvQCy0DzZmmx3kyzsTe/?=
 =?us-ascii?Q?8q4ZWxcqRk6Ki6FYIIQVXbC74K3sdAREKg9W/DdD18Y9ji/J3itFK+JFZFKM?=
 =?us-ascii?Q?+FE+/0FgEIvVexHiIlVpeCXoDsFohe9qdIpC5erCaUw7APBuhwuSPK+Ah/Ba?=
 =?us-ascii?Q?Z0LRgmDo8qPVbcEGzqEeO5O3qSggOZK7kP+qk5uvMeWzM0tQrgutRTF+nGHb?=
 =?us-ascii?Q?d4/72otlG9ca9QrCY0iRPzQX4Am89z3dra71I89Nr6oTZY3uDsNVj9xR9E8j?=
 =?us-ascii?Q?eV/btZ6PTobty8O5xla3c8Ua+OEwg/SRGwJ4DusjfDexVlP4wZOyvAuXCarZ?=
 =?us-ascii?Q?sBbs/iGJg2u3368dAykgbH5N7kf8sgSLvFVrc//9aZIXd27cvoPyUrUmqC1b?=
 =?us-ascii?Q?6OrUSDOgsLzZHhIu7El9Egz6vQCi3my8hVN4WrcI+JDfQb9yN99b5M28Lr+C?=
 =?us-ascii?Q?rWD8FE/lrQ5rkhLCR0LSoBtsAzdjlfg3xOA9m/NsW6Ik64AWXIih5wv4tSm/?=
 =?us-ascii?Q?N6T11Bqf4L5tX7AxJz0McwTEoQpWEGpFBd+MyRcDRsJhqDx5tHtGDGNXjgwy?=
 =?us-ascii?Q?LutD774odCg13Xr6NADw3bWworFuZRexBZhpZ4mNfkUgKg4BOS/zVZ50ieHy?=
 =?us-ascii?Q?jvXezN9rGmnc/+6rars/T8K5iJMHzKo6/EAObcMrYf0IrZ+BlNsqqol4h/kA?=
 =?us-ascii?Q?LmQwd28mUYZD5XGvloGtVH4onSVjU/KwqepDjAg/5Y3fvv2//9nCjb4T3WE1?=
 =?us-ascii?Q?XEtC9knnvyvf3iPDFqoUuB8H4QDCDy0MQt3sI01CnYTy9jiqAbT1Hqui1s4x?=
 =?us-ascii?Q?UaZXNYh6OPd6sFnVTeQj4cwLfJ5W/1FKUykNwMV8Uy9hre9jTk9meEWk5jVs?=
 =?us-ascii?Q?daYpCoU0BgRDo0LNT1VjgBATumpPq/jVx7b5PFFkaQTRm8NgRPxS0Hs3lJPO?=
 =?us-ascii?Q?6p6PwWHYCbNAo89DE2fu7RTOT4y5XCmxMkaOlxYB/CsoS/LKjRxy4OR2za12?=
 =?us-ascii?Q?8ZP289rzBJYGKqbVq4W6q5aACXbmxiaQi20Nkzrm1rSqIINGHUw99DefT5DX?=
 =?us-ascii?Q?Dpd4Kin7a9htFb0IVpz9wuR+t++ufso+L9qyQ7w/NzCWPVCtrCPGWwOBOKHl?=
 =?us-ascii?Q?JMuXJLJYzwOesC8JmKjpc7oCNWRWe1g+LZhvI/BVQFtscHtqm7FK6AIF/nkk?=
 =?us-ascii?Q?qHJqb+r5EPMyqbgTt8zY+zkrfWFFIXLGw7bcTwHiR5JD2iiAMXylNRsowyho?=
 =?us-ascii?Q?xCuhaEZQCWeg+qOb9gM/cQKGZvqdpg8=3D?=
X-Exchange-RoutingPolicyChecked: Vt6Ahx40ZTjIKeeliPBMAN3+XhYnWI92JmtpK+3TF9lknWPCU+OTkNZQI8hZJb2F9U+wZQhNCXAQEblvJcCVL9UsidpNNS6vfZh9o8MDM1VapI9vgCObV5ShFr/ovKaOPTrvAVNYHHE2AmENW5RyG3zW1AfUMtxiP89Sfr2tkFWWQ3sxtMIIiAjWMooCLW/aFpf1nRdRsxC3BrDvcmqZhnUZVWCDByz26IZFc2WTkZaRGH9vsxTvaP1hgGIhnLhepaR944RP2ITCyoSXS8g6ox/GfFTnQaWbJncYrBMbU1SDhl2pPBTahnDy+aqRJNus4MjBAB9JCguB6t5GjIVEXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iR5DHQwkpS0yGtXvLNtN4z173fPdyWV7xJJUh77bzGhvKNoWsMOX3SfkH0rVF8+LzuDNTxTBG2hY2g4uWgt5BcIfYPRfc0quGqSonRXg9D8PIqswvRQR9oJJ5EcoUZhnuhvUP9n2Wa/Zg+mASJBaXCUYbzbpxmDTshcm6K4QQdDR7V/VRNH5jA7Fu1XmSoYzWOsb8OBdiGlMzarXZRcXeIAFegLQHGVhm37sCtyOFUOQwt38xuvDQQFE6X0mdotyYg3HsT45ni54Zt0IVaYmYv6oTul5hVbx3xxJD1R8unwHgFp5ijTwDVMDpp/1nX2fErMJcqRV0r7WkcGdar6GCmwIQM3XcciuvcpMXq2JmZqJnCtsrFVbQ+DMqzCFiIDG3aVycuZV0BzF6ehZiONbx8AZ12xVOLuMSgLiftfO8ORbYWzb7KDxD4oq9v7zXzjM+cSsLB3UWE0gZX8+eX9XwT2IQ3KLJ4DS3juzqa2MWT++684RIp/r+itGd/LQhcItBq+Zmbg/Y9T4gi1SOqTcTgZ7Fqt+Qkkljy8bi+UGFeFXyUoNNf7C9GEoTJEyjUBchUa3sT/YtuWmHc3ahHlBTU450vKn30x9u9+QmZUxCThL+VjaOljMXb3z1kt4yqSb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d96dea-ca09-4e3c-ed1c-08debac50ea3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:21:05.2305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4b339MPdHhs9VtyofnkkuQRHD0XVYtpkJzaPEbW2uSh6UoZN+3D97xFBfh3psGvZkbBqbkBcETMcs6KOWmmT/PObWX7HnRz29KlFkyze0o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7097
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 26 May 2026 16:39:19 +0200
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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
From: Shin'ichiro Kawasaki via ltp <ltp@lists.linux.it>
Reply-To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: daniel.wagner@suse.com, ltp@lists.linux.it, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Priyama,

From blktests maintainer side, let me share my views on your proposal.

Blktests started as the community effort among the kernel storage sub-system
developers. It was discussed at LSF/MM 2017, and started as the place to stock
test scripts for the kernel stroage sub-system. In my understanding, the
developers expect blktests is the test set to run before posting patches for the
storage subsystem. In the same manner, I expect and hope that nvme driver
patches tested with the nvme test group in blktests, to reduce the load of
reviewers and maintainers.

When LTP supports the nvme tests as you propose, what will be your expectation
for nvme driver patch submitters? Do you expect they run both blktests nvme test
group and LTP nvme group? If so, I suggest to add linux-nvme mailing list to
this discussion thread to ask their opinions.

Also, please find my inline comment below.

On May 25, 2026 / 11:00, priyama2 wrote:
> Hi Sebastian,
> 
> Thank you for raising this important question. After reviewing blktests'
> coverage, I see the concern about duplication.
> 
> *Proposed LTP NVMe Test Suite - System Integration Focus:*
> 
> Rather than duplicating blktests' comprehensive NVMe protocol testing, I
> propose LTP focus on system-level integration and kernel API validation.

The primary role of the blktests nvme test group is to cover the nvme driver
codes in the kernel source tree. It is not intended to test NVMe protocol or
NVMe devices. Blktests can be used for NVMe protocol/device testing as just a
side effect.

  It is often discussed to extend blktests to cover NVMe device compatibility
  test with Linux nvme driver, but it is still an idea at this moment.

I guess you misunderstood this point, so the list below still has duplications
with the blktests coverage. It will make it difficult to tell which test
framework (blktests or LTP) to add new nvme driver tests.

  Said that, the list below includes testing aspects that is not yet covered.
  I agree that those ideas are great.


> Here's an overview of the planned test suite:
> 
> *1. nvme01 - Device Discovery & System Integration (Current Patch)*
> 
>  * Basic device enumeration through /sys and /dev interfaces
>  * Driver binding verification
>  * *LTP-specific angle*: Validates kernel's sysfs/devfs integration,
>    not NVMe protocol
> 
> *2. nvme02 - File System Operations (Planned)*
> 
>  * Standard POSIX I/O operations (open, read, write, close, fsync)
>  * O_DIRECT, O_SYNC flag behavior
>  * mmap() operations on NVMe-backed files
>  * File locking (flock, fcntl) with NVMe storage
>  * *Differentiation*: Tests syscall interface, not NVMe commands
> 
> *3. nvme03 - Process & Thread Safety (Planned)*
> 
>  * Concurrent access from multiple processes
>  * fork() with open NVMe file descriptors
>  * Thread-safe I/O operations
>  * Signal handling during NVMe I/O
>  * *Differentiation*: Multi-process integration, not device-level testing
> 
> *4. nvme04 - Resource Management & Limits (Planned)*
> 
>  * Cgroup I/O throttling with NVMe devices
>  * ulimit enforcement (RLIMIT_FSIZE, RLIMIT_NOFILE)
>  * Disk quota behavior on NVMe filesystems
>  * Memory pressure scenarios
>  * *Differentiation*: Kernel resource management integration
> 
> *Key Differentiators from blktests:*
> 
> Aspect 	blktests 	LTP (Proposed)
> *Focus* 	NVMe protocol & features 	System call & kernel API
> *Scope* 	Block layer specifics 	Multi-subsystem integration
> *Interface* 	NVMe commands, ioctl 	POSIX syscalls (read/write/open)
> *Duration* 	Comprehensive (longer) 	Smoke tests (<5 min total)
> *Use Case* 	NVMe validation 	System regression detection
> 
> *Concrete Examples of LTP-Specific Value:*
> 
> 1. *System Integration*: Does|fsync()|properly flush NVMe write cache
>    through the kernel's VFS layer?
> 2. *Process Safety*: Can a child process inherit and use parent's NVMe
>    file descriptor after|fork()|?
> 3. *Resource Limits*: Does cgroup I/O throttling correctly limit NVMe
>    bandwidth?
> 4. *Platform Coverage*: Does NVMe work in PowerPC LPAR, s390x LPAR, ARM
>    virtualization?
> 5. *Container Integration*: Are NVMe devices properly accessible in
>    containerized environments?
> 
> *Positioning:*
> 
>  * *blktests*: "Does NVMe hardware/protocol work correctly?"
>  * *LTP*: "Does the kernel's NVMe integration work with the rest of the
>    system?"
> 
> *Current Status & Next Steps:*
> 
> The current nvme01 patch is admittedly basic. I'm happy to:
> 
> 1. *Withdraw*if LTP prefers no NVMe coverage
> 2. *Refocus*nvme01 on system integration (e.g., test sysfs attribute
>    access patterns)
> 3. *Proceed*with the differentiated test suite outlined above
> 4. *Collaborate*with blktests maintainers to ensure no overlap
> 
> Please let know which direction would the LTP community prefer?
> 
> Best regards, priyama2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
