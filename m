Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D435EEB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:32:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4C83CE100
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:32:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1453C3CC497
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:51 +0200 (CEST)
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F6891000640
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687264309; x=1718800309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mkcGAZYUmtZux8dW8AGm4XzI2b9KG4PCuN0eWu9r+oU=;
 b=M9LlG34hHw4AIgZEc6+t0cFsgVeTW79qRZyaxmnb9+yXOukzkI0IX6WH
 BHIgUB7lUH2L1M23CxHTIDQMcdhqw/TYALdVuU9HdZQh7EfO4xEvjK2jS
 AuBqC//77gITGRmHAh6A79Gek5GEbLBMBB5gPHN2Q7CJS5ogh5eTZp/Wa
 Pv//mQN0rgy4vPpshPu9eAsKZbg045/3BvA6dxsrHEqtPFbArom1gvoh/
 X9rMc1UHy6XInrt5SouoRaa4+hsa+UIwXwZz3JvRBEWOvlPflg0jrN1IK
 0wX9jDBGBVSy+k1avXjZtgCtSIdMPrdE0X8l/JY3PGo0EXLPDXiUlZxjf Q==;
X-IronPort-AV: E=Sophos;i="6.00,257,1681142400"; d="scan'208";a="234462020"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 20:31:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjD9B8qGFiSSum3SCAi1GZG02EMTtfpZh4N4AbLh4vPBccbUIp9BjXuJfO+9fbIN9cEbsouL7CPrwpLFmKmFwracyMrtH4EY88M/2YXFiIZ2uNz0cXeCbqoRIKpO7GHN/L0dFcI+1IfBmOu+2pYiv4NBd0r0Emt0qNVB/VJFgvPHXCJBlmkWPaRHL+5QgWKbjGerijHYMsgj7IblM29TKrWfzDOCelooYIO1W1YnFM1XgoSp4PFhviSAn0/EOKGzZuHtzl3pNzStjuZxzQX02naUcSYXxkTiwghxBqGjMEcrDGiS+V+uJsnfoKr05bdMtdZRzfWqDbX7HSD1DVeX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkcGAZYUmtZux8dW8AGm4XzI2b9KG4PCuN0eWu9r+oU=;
 b=ZMjOfmbmrNnL2Ap8fFE01v6GPPTyyxkOR9qjipUZTACkI3MVmOKIIsNmkiZjaN3UzTcZzu7pCLGd4TdFU96gFsX4xKf+0T6cXuVc7r1+KVrjLXETpgzrtbDBURMdLl0CkLjRB1FgXeSgVJccpcz6q7wmevCpZmSi9dnEAhG4rPsDO15JfvKl/ZKd0tzYMxnTTDVlJNUTvfxmEBeW6pukPtlR7cvHmlxNxU+lGaxVYxjDdox8GgPqVM9OAI+QZc6fvFZBFLtJZEmZGuYV/mYxTFcQzc73x5YnUuTxfMVQI7WbOvamW2hFDfuM5I430MN2OguPYOP1aNPIgN3Z1kvXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkcGAZYUmtZux8dW8AGm4XzI2b9KG4PCuN0eWu9r+oU=;
 b=LrTbrhfYaPQ1tFgj+74f6zVWUPw88tXqR+XlYI91LOmJFHNUTd8Jm8OKMXYkxFyDQ3YDhojMrZphfbrrA6v1bTyFbpPKNuAi/E9lJAV+O6cZfDDQ290pDyrBgRe4wOQFSahPakPI0lLtq9Q3PiGgj0trWXPLoWztGLKgsMQ36Oo=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6877.namprd04.prod.outlook.com (2603:10b6:208:1ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:31:41 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:31:41 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH 3/3] utils: Remove unused ioprio.h
Thread-Index: AQHZo28KOdaSZDoxY0qwYm6KfudQqq+Tn3SA
Date: Tue, 20 Jun 2023 12:31:41 +0000
Message-ID: <ZJGcK7zu3cLZK8YO@x1-carbon>
References: <20230620120159.320052-1-pvorel@suse.cz>
 <20230620120159.320052-4-pvorel@suse.cz>
In-Reply-To: <20230620120159.320052-4-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6877:EE_
x-ms-office365-filtering-correlation-id: a7c7d1d4-3d43-4b64-b3e5-08db718a4cf9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vEtegfRdSTEr14HQKXx/ZZk3OWkRmOIUqOTvQjgxfVrO6HIMIegVtz6F/q/We5RKwslfJAvxuFO/BWUAs2xYyADvpQJVGoggxxEElVzpkTHWGYSyBvpO59YZNLjIx+JWrl7BfS4ksJQMPghyj8XSRSaojdPAGbi1hhGvF4zNhPeai0eeeyRuXKLjdEt2pfDky6XVKNVK+n4KAp4Jz4m21Bt8p4b3qd1bFQnz9LCY5qiPPkVNiO9xB7ai7iHBhDsIKudDZHw+e4c4PkLPOert61wd0dpqBMspJ0dS8bhXtb0ijBEkZzztSbaZLIx4w4+HvfLUDwFzTQa+lIAgJf+BduWLndsejI2dXMmgU2Cz/hFbFrMlLhpeVIgDH5uIZWe8tfOyPJmumAM7Zjwh4VX9ev+859Jl2KUvIYqMU5gnVC/AyaHbAYrkHtv0Tg0JRVC/y8xMiq569DeLVi0t6/BnQ/TIeS/1EFMQygcPrZAfc0qV/l2dQW626N/flgs/GaE6vxkcNmxoiKqvcB1WF5MdinDPQuMN29L1c3RCLxidX0ftYq7rN8N9tARfJXMadClyQAVVvFkQr5bqKGF/M79A6az1oQkSPrwjiw/PFZdFnF3GbvJ+Ypb6iQhQQIAqsfjP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(6486002)(478600001)(71200400001)(54906003)(6506007)(6512007)(26005)(186003)(9686003)(2906002)(5660300002)(33716001)(558084003)(38100700002)(122000001)(76116006)(91956017)(66946007)(82960400001)(4326008)(316002)(8936002)(8676002)(41300700001)(86362001)(66476007)(6916009)(64756008)(66556008)(66446008)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hTNLWF6YSnw6y1khiVfryGaSWSnGOoufbdvqLtuxHFsGcc1bcGFHk6xaGc+?=
 =?us-ascii?Q?kJrJ38Hw7dRCsd9d0SjPgSMDquzwwU7ubaLXIE07Kd8zXdpPazSMQ2oZkYya?=
 =?us-ascii?Q?AAx+xEOrCKRFjWf9Lulyl/ulO7/KGk3KtMOn+aUD2vOsHiv2z9+d+j7SXXZk?=
 =?us-ascii?Q?NsZSmAzgaiDEDDAXEMVo7mAyvemYsl2o8vcnk3yjI78A7MvpRvW//l+KrtLd?=
 =?us-ascii?Q?6FvrpYtnCZU7q7sgzpLC5hI3pJ5GGdMjDIFSO44FtrlibmDj3uHwy/X93E54?=
 =?us-ascii?Q?v3nQ3lAqrRw2f38WO1Lzw+Yovzidm3DmMV+mKynHWLjXeJwiWaY/0MJhPIqx?=
 =?us-ascii?Q?oTb8l0151Ue+uouw9L2C+GgJc9Pm7ZehWKDy+R1pop6slKOVrHISMbjfY7f1?=
 =?us-ascii?Q?xdka+0Q3q9Ab0TRKEJ6aL9YxSJFcsYSXciZVvKOzhBkz6QSvSLrRH0Ol/VTk?=
 =?us-ascii?Q?nRV8MdMGAyaeCOazlHxiX0HAXyua8uv81mPlQbkdG6F8ofFtbL33WGHWKiHD?=
 =?us-ascii?Q?fukgZ+Ker0rkpNDb2XqNBmMonZhLYrTS2YxdvLSzQRthrrN9MNsZ+ydNqX2z?=
 =?us-ascii?Q?9CVoCzMKuFRtdWYxHV/WF1upoimu0OzNBJNUwjirXRIprBOb2KMlYq0g/ZZB?=
 =?us-ascii?Q?fm/E34lXIupkObBsLscsuMFf1mHM1YfhswpNCsuR16MLSFd6N/Keiy8tWK2g?=
 =?us-ascii?Q?DxNoRlHhq+XTSGjtbIztj+kZtR2I1D4JulbfBHEds9KSuIoaerT7m5UZtRev?=
 =?us-ascii?Q?KCJ25ainXjOwzMhR6reYV4PO3ODfv+EXdXzeksKbkH0MfJqDE6/W5XhXCWT4?=
 =?us-ascii?Q?7r7Es2+n2OU1fh7MZZgqz1YyXO4hnA3kRvf2AdK04pmDHvlHa5+O780C4zPc?=
 =?us-ascii?Q?+1KGoKNHsQPN6oqpAz5zF1zKW664JjqRf4bzpMwglYFmqwczd5ND/V0nfyEu?=
 =?us-ascii?Q?7NXDHEpYKW2Ah+YgQqCjivKHZUllQ4L0K0xR801mNXmzs9aAjRrg/8DxgbFi?=
 =?us-ascii?Q?MnqDXFEHK6vJOfpk8nCdqgBfu47ESXuNxf0/zgrX5bBWhrn9Er4f0EbAqUwk?=
 =?us-ascii?Q?8Ty0Qq5fAWwJtgOSqFiqiYwyLuQiCHytcrS6dUlZtCjRSaVySnBH1DbwODZg?=
 =?us-ascii?Q?I8o2NRks2ABBB1kmgRLww07eqfZGqVy+XOcaz3aOtpTH4mwPKJCRDXOwYHos?=
 =?us-ascii?Q?owSVaGzo+TBclnJU8jZvVt1vvdY1xhuIYh1VhLZcWolDzktBEsWdP9/RBe1i?=
 =?us-ascii?Q?8woPRM+YK2hjNM0mkDLKPf+SumrCqPmcowxDwPBpmBgmKNXEVjRfO4ctemch?=
 =?us-ascii?Q?8K5M5CJuJfFceBJ30e6D7cx1hy5Gg5rD9E//XgL+JEUXF4xO90IKMukm8MLG?=
 =?us-ascii?Q?up9ZqJOK0rnpefee5tEZmI19ftXHUsuK8AAmBFPbPJtdetpOuAJWuAG+Rpyw?=
 =?us-ascii?Q?rQgryF5a6fEx0D4479KO8LxmMmopwnQ7GKbIhcDSt2bcZ3rz/sss8l/YXigp?=
 =?us-ascii?Q?fxBTdoCtKNyBNh/0/XrM7wTEqF7ZPa1tN2n12F3Lvp3LXiI3S8dpk9LPq6k4?=
 =?us-ascii?Q?YvF04DOPC/Z1Dobtuh5ctCphEENb1fSwxFo61W+ZDz0FJ9hPDIenobTJESo0?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-ID: <73D0BE5882BE734A9480073521AA83E9@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: booEdObowdHPa/SlX3Wa5rTqsNbcV9oIyF9I+NlipwF2rvWCOnYse0Fc6TQD8/KVhdQWt2xUXlnisjJqIXw3pznGAiQI3PEABCbOT0V1u81Ky5H88K5e4nQMe/5/270mQPr1sL5yek+MA7LZodBNpAFIazTBMTTX3IXswXd3bkZKKBAPT+ox255ecZekIkGMzi+GFc50ES0T2YLZkZGdOvBqXGJJsX2f2447Qa4B0Y4OLuWR9jb4wkHsr63Zica2ua01xIhW8RTCGAZ3sqlmuDZUD0MD5ZVfh9HFfElSPlnqcIpdcIWB7hrSW9cFRUoyCVb9Q3E5UQmZouUTALcJSWmiy47gTphNoGEOW6U/37ZhQRPn4KzgT9qTebZ/ZiH/ry0oZz3SJl9fKabwsg+LtSNrD0ASBWtw7tncVGV87QB/ZkzyIXjm8Cg09yHMDknsYHwh3g7bd15hXpmtjcO+sBqpE7LGZkauMm8lanMfxOfFkBc0VlpJbFHuvMrb70p5LbEITLVsiVqumZbRwupsiI1rPQZwc3hIV6B3+B67sxFOTxH1PUgYViVXnE1Q7R+u7NotEuW6KWp+qe7HZoIgupdHyNXWAqD6w6kHnvjVHBfGLs1bhOavOyv6XM5zBz21RBoY6002JJr4UTLHTTjiDHJ0iHO6WSRqsw5WrzL4SIdwhgSlzm6TcnZ+zQEh/UGoyCR6DTowo6LrhD+H9d2qnhfhj9ccBbBiC12JqDl8RpBpt/2Hff6dPM2PKcn8qieqMKB5BaYUEnkFdgIbbaPMb7Z4/ScZQ38gKPseAMSSXg9AFhwnzSgXX42AasJENUb5q1jhbg8cPW+2ZZMotopgrA2VJAL1Hkxd4zyNOT10XPg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c7d1d4-3d43-4b64-b3e5-08db718a4cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 12:31:41.3334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6GsTR5nFexIy3gXv10FL4u/BRvmvnNorkL9ArxImWUumnlpNuzh1RUn4Lf5i2tQIOwgaKJhTXVAq10ZYGHPMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6877
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] utils: Remove unused ioprio.h
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
From: Niklas Cassel via ltp <ltp@lists.linux.it>
Reply-To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 02:01:59PM +0200, Petr Vorel wrote:
> It was added in 0a1e45f09 (in 2009), but even then it was not needed.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
