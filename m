Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C39C4707B
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1704964904; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CicHMo0CBV5euDu65MVhxd5CfvBhp5pdZy0V/SFwhDY=;
 b=mBr/PyammH/jdCcoSgFu4MHKUJMd3LqzzloURCpAr2bF8k+ujge+vKs/HWJ/i6yEs2WKV
 d5Mv0qd8dUKWolB8MIiW7SGZOFn6/2TfPiYQzTw4Gr7Ho4/YI8rj/3py7exut5tr/kL6RMz
 TX66AMSCD7LVfohFPcpTybNOwKRnMZM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7AB13CE45E
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 10:21:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFBFC3CD0B3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:21:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=wdc.com
 (client-ip=216.71.153.144; helo=esa5.hgst.iphmx.com;
 envelope-from=prvs=733b38e6e=niklas.cassel@wdc.com; receiver=lists.linux.it)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E8A76140B4D7
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 10:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1704964880; x=1736500880;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Tp40nZEBMOrW7oyH1gssww6z3JdInFrMpkyypG8GeHc=;
 b=gOvs7RtPRM/JE2BjNAyuL5dLeJPcFF+115nowi1sEQ0vFUtqRLYucfai
 8QFBRjyQnwJY5RbspT249kvIE58SsSRduivw3l0htrYFCmEvn4E1ZDyPe
 eJnFDgvvhGdh9P5ASnF1Uk7PcGkiLRFzqo/yIHf9o6HFslDt4SphLakw/
 1Zu+8Z0b95Jt/rrN+XIGNwNUi3FXTjnJREjxEJ3YdcIBk/+cEeioLyJ/W
 /8k/XzvQ4K82NVYKxyNJXy1nDW2UOsER7Eszu7lE/Efhpm2e6jG5tzAcY
 HnIP92N2mQZu+FaMPdP3GiUk8xzaNTgM+00Apa+MY3sl5IuwgPP+tU82q A==;
X-CSE-ConnectionGUID: LZZpp6NGQb2Lqr6A8gjeJQ==
X-CSE-MsgGUID: +BZdlo4hRa2aSyVlfRre5Q==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="7117659"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 17:21:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFjdmOoqhCMno94N5ZfRyEUtRvwyOA+PQ5dfGOZuci33h1ak8IFWx9jMtGOeWPG/tnow9U6qh337f60Tpd/qaSh1XfpV2tITQCfEMDgcywwsFzW4NepmmZgGZrsTRmEMN5eNVGwWmRfvk4a/pim67DkAMJOqPJ2CJK1WdmjpkStZ1z9RrNue6KBBfSUVL07daU0GaZAtoNkVzGLoClyl+4xngvx5TQy1lVcEz4xUrcxR5MxYsQvDxCMfhohICnJx9X9+9yxj1EoAc9GGMGAP7AVDq56RS+LlMiGhN3Ah3s3XKAE97jsOwMM6nvMFbc41MSLaq5sab6a4mlAUI8FHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp40nZEBMOrW7oyH1gssww6z3JdInFrMpkyypG8GeHc=;
 b=Fj36YtrFP5ijMbTqf7jNxspm+aqO2B4Be04Ggc/zHsQU6B51EK60w1ouNTiiM8buqBeU+jAhr8vhG2zbvbhZrdQ+lKQk3OVm56CXaMVoT+36yJ6/w3gK+cgamcQxE+ChschYScux8Y4UCaS4Hv/uMJTIHqI9qLX4DKRaekimIFFarEBAQq06ylDJsLnmwykgTUE/IkHrDimPu0pTcS+sn+kjDWSF9RSt0LNN3AHcep6lm2jzqok2G/Tiz5BI25vJehGDQW3PeaaV+lRaL3P5VTxyV0rT05llHWAlQTXMEAX4S2Aql9C3XTXQbIu6DJBMa4U60WG2R2FIoOe7XkezCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp40nZEBMOrW7oyH1gssww6z3JdInFrMpkyypG8GeHc=;
 b=d5CJnWAt8ZhuQBhPUlFDNRm8gw7WoxEzTHL7HGph1npXld1WGLQvgiiwnupmkfi/M0zlUCPhmQUZhi5CUW2p3ziRNYMxDRdBk+1Zb3p94N9fRPp9h03Q/7TGdmq9UNAzDulLiZt30KX3pmiuFb4075YM0ojDVkwVhj2amMZFVaU=
Received: from BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14)
 by BL3PR04MB7996.namprd04.prod.outlook.com (2603:10b6:208:347::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 11 Jan
 2024 09:21:13 +0000
Received: from BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa]) by BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 09:21:12 +0000
To: Greg Ungerer <gerg@linux-m68k.org>
Thread-Topic: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Thread-Index: AQHaQhGbMR/7MaUknku9yjrZLvyb+bDPsNGAgAO+XIiAACGIAIAALXKAgACcvoA=
Date: Thu, 11 Jan 2024 09:21:12 +0000
Message-ID: <ZZ+zB29hRhpjiOrh@x1-carbon>
References: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <ZZ8JbCPd3rq4u7iG@x1-carbon>
 <7e348eb3-bd34-4c66-9ed6-b5108da80486@linux-m68k.org>
In-Reply-To: <7e348eb3-bd34-4c66-9ed6-b5108da80486@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB4850:EE_|BL3PR04MB7996:EE_
x-ms-office365-filtering-correlation-id: 65807b6e-69c7-48f1-8d17-08dc1286a7b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SBNNz4U4FpU6wuaym0UIGe3iBdWo547K8CBWJbpggH+QhgNPYC+lVgZWdUq1/s9xzMYeeM0IHSmmuYfT519b1rwUObpPK8Aw/bF8AjhWz2gl5gAUkF5tBRyC5Vekk62FPySMP7VeZFnSu8ddpv5k/1VXAkGv2vjE0AQGzjxgZq/T0pNEPYrsNiXYgoSTPKyd60a6W3cUu1QYBLvI+wTqmbkVnBMY/7IOjdx8ha1ZRfmAiMScZ50ho5moQqvaWZdT8VukTuiQV6zdTDmaAzL6U/VpXh39wT44BzdmR+lpBNc60jRZ4rGzvLE3r+jb0vHiYgQgM1ayQV9rOChPTwNSQ1Q0FHceBmiyYvkE6QLbEs3J5i57DZ6dqr4MkI0/979rx2W7RiEQNnRvKWH2EXmFrNZxYVLiyPYm7towvEjSfbLU89bmDMGfoZA3JbqmjC8tV4pHRAxcoNAyVyDpcsSOWjmGGtT23eiHbaVLgipLt5Pi4frzepTiTYnKh0Hz/uVn/kZ75pfyl5LiB651Yq3oykl3tcfne6BEOwMfyhtWzBvQnbH93qGWvdQDEp1wNofgPJCOlcqFoBcZsqendNXI1Db6eqBQpZbz+okS3rCtcg9RERKlk6rqVVPWtPMcWt+Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB4850.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(478600001)(91956017)(966005)(7416002)(5660300002)(4744005)(2906002)(53546011)(316002)(6506007)(54906003)(6486002)(4326008)(26005)(6512007)(9686003)(8936002)(8676002)(86362001)(82960400001)(122000001)(38100700002)(64756008)(71200400001)(76116006)(66946007)(66556008)(66446008)(6916009)(66476007)(41300700001)(33716001)(38070700009)(67856001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KJmBL0EA67teCjeznFlQ56mTY730OekpzlzUzake11ATLnzJsTyIOID9iEVM?=
 =?us-ascii?Q?KI7XSLYTORsDliFTu9jS7PMMkWjw0eIngPKjDLt4a9MKgJS/xtzFq3g9CDG3?=
 =?us-ascii?Q?dQhk8ZUmqsPwo8XSm7MKqGvar3taK82/mmQ7RYvKgklgv2V/2/EshjhM3WMi?=
 =?us-ascii?Q?/6HCdvd0jdWUCOI1741ndMSjqGBSlQvuHS6ABaBqqZqIJ/WGOVImFYAfnUht?=
 =?us-ascii?Q?KXCk2Qj1mQjZrm6iFl+snWrAQ89oO7M3eN2hIHrisxkXzwGnypezN7gd10eR?=
 =?us-ascii?Q?SqaGGOQnicnLiaQ2/B8jAbgtWfwnU9qF9I6ZYTVoo7nWIjAdFkTHquyPHFev?=
 =?us-ascii?Q?JaXOk0fzPrsVKjTMzAy5OsXwcrdYVCKqXiNkmlXWp5alftQD1DY2pIQKS0S9?=
 =?us-ascii?Q?SF2jDi6uktaJaunkcHXQ71EFlzpezQuo9uKCDYkk1iiCfJCpdoidSnnkX55I?=
 =?us-ascii?Q?K8e/ZRG35U8/Y37vngA8iuucvt6jq5CquBfFqPyg/0rQK21sJ1racWu6Icop?=
 =?us-ascii?Q?ygcKIwW03DqZO4eLOWtVNdbZLMtR13jktYAsuUX8/XYgU4e8kOOHuauH/k/I?=
 =?us-ascii?Q?GUYeDsUgpyIJecTn0kxkawHlRMuEzRoPWrnfX/hVr6Hc1LzgqxFFvFt7Z2Pp?=
 =?us-ascii?Q?ffq4DlOGOlX4u2qotFfG9uL9jx6yWsr8DnVNO8vDQiYAxMABfRHQ4Eo+D9Fh?=
 =?us-ascii?Q?7T53wJdDbQsk7S4tL32r2/CO9gkyJMsKHjnC/oql6ZmkNt7u6Bv5lW78v3Ox?=
 =?us-ascii?Q?JUyl15v7tNBSwPvSI81/WeG/I4lLXwlz3ufCAsWOobuFbLoyJh9pg3y1q3Pv?=
 =?us-ascii?Q?4vvwQrA4SGJ/jiGKqRQ8/O3PtpUkNvR9dbNYhypeqgiQrvYkdgGLApuXoAEP?=
 =?us-ascii?Q?WF5h7m3B4bRDIpF2gwnbI6dyGzeCaPPr+KnkJxE1yzQm/lJqJ/sAC9GNK3Z0?=
 =?us-ascii?Q?lSj8/nmCIJCVZeaZkDpVZVZlYn5ORehXoNHA3+FLiPeSdNEbPzynJfsYOvLj?=
 =?us-ascii?Q?9J5ZkOoU6FInIxgLWEDiXw9R91wl/k/OoGmjO8Si1EIFO6T8AAQv1hzQPOx1?=
 =?us-ascii?Q?m0SVEkOW3bDdD5cVLEQYT2snIECKqCs75ibDNcC3zfXcE5GTo9ZHN4QB/6EM?=
 =?us-ascii?Q?zCXejGsDjMOLGTgV1L92Pb14t2+rXYyXGL6YjuPbAdqQZ9qpbrNi5Y4RtPj9?=
 =?us-ascii?Q?jhcXoYolhG+mTH2zgJweozYtInGgn6/I7yd4uV840TJhNucHyNrBHOS7pp9e?=
 =?us-ascii?Q?xknVNUg/J9biVowafpljlkM43fc67X9O4kPtuRBWNX1K8CRE3eZVZk7/pO+G?=
 =?us-ascii?Q?NxaDaDYPZsMlron1DLnStr7hbZduJPioV0v2LO0K0CZjYQGGLifMm93XcpXV?=
 =?us-ascii?Q?Bt9AdKuQ9pvIx4OFzcGwvJYH9Z+x7xdOXWUzXp1oviInRSab4GP1tHTSD4pm?=
 =?us-ascii?Q?441VxTj+RQGGy+w3UR/Y7xuXTQkWrAju3fTrYV8ceZdp6tbyl8pF02KBhovE?=
 =?us-ascii?Q?bNnJS1c9Gnhx6xR8vVlBaYoLXD6sNQWZsFa/b+t5x5MFCqdZeYJlsAQWFJhd?=
 =?us-ascii?Q?OIgE8XIq9S7toDTHAd0jok06eXj0BcELsp+4GVsRvMp+redO83urytGN0d8Y?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-ID: <12B10F2B10EDCA46923469645F06011E@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8ZatEdcqQWR/z7/xnhZug+6MjLuIe7uUxLNgZEEmA/VyG1w9Gj7AUGhMmcke3WY4hE26GNSpXOJ+Bf/fNOFixb0Ld49GV14Mt0tIHg/vIIPuoiiCJaX+fU5tcRk7dxWt1Lw2KVAXkeY3W27Xsc+CPf4XqoyK2VzeXFY/bqk8zr9UqMkP3w8dHDGuB/wL53EWwfpvDLBckdyre0eErxLz7pO/Czd/FbEH2yXlCvA44re66NVgB4O+K3Y6j16vBrmq1HkIDaIFlxvDfln0HLM7S8wDEavWCorSAIwVAVyA7SVo+QBs5GzzfL5qEQFtF+4ICzkQVp6faIs5Q2xjaSVjmxRRZKYd/y91TVEc3c8l1g5goMdk5DE/qymmEexqw9sFHlqj+HyuxFwu5jP++blcH2X5pk0me6hO7mIj0Z4D+Ml9Ki9Y4JKrNNb6yMul/KSbhR4AzBung0QymOFkHi9z6czLYGcGp+To7IaTcOmjXEkG40+XKG9oxnmz6rrvoi1QO82q5If9cOceAsiJTAKZBikfIerAKwtqdZi/85V28zBN6v3H5N4BAz+tkVM4EIBS/tvL5qN9Ur7LWViDb3Uw2CIsUsE8Diwl3ZyR3JLHWztLay6TSLarY1+bTML5+zcY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4850.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65807b6e-69c7-48f1-8d17-08dc1286a7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 09:21:12.8071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFFGaIbxLVyEn2xc5FMEMmWs4YS4pNnSQIz5XDqkm1N3dKAA9U2cXaMfrEezUlzFal6yYQEEv+ye3dDCJpRzug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7996
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] Call for nommu LTP maintainer [was:
 Re: [PATCH 00/36] Remove UCLINUX from LTP]
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
Cc: Rob Landley <rob@landley.net>, Jonathan Corbet <corbet@lwn.net>,
 Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jan 11, 2024 at 10:00:11AM +1000, Greg Ungerer wrote:
> 
> On 11/1/24 07:17, Niklas Cassel wrote:
> > On Wed, Jan 10, 2024 at 01:23:51PM -0600, Rob Landley wrote:
> > > UCLINUX is a long-dead distro. Linaro died in the dot-com crash and its founder
> > > Jeff Dionne moved to Japan for his next gig and never came back. On the way out
> > > he handed uclinux off to someone else, who didn't do a lot of work maintaining
> > > it. Most of the actual support went "upstream" into various packages (linux and
> > > busybox and gcc and so on) before the handoff, so you didn't NEED uclinux anymore.
> > 
> > s/Linaro/Lineo/
> 
> Lineo was not founded by Jeff Dionne, see https://en.wikipedia.org/wiki/Lineo
> for its genisys. Maybe you are thinking of RT-Control.

Yes, Jeff cofounded Rt-Control which later merged with Lineo.

My main point is that Linaro is a completely different company,
which did not "die in the dot-com crash", like stated above.


Kind regards,
Niklas

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
