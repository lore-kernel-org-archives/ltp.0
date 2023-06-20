Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE5EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 11:14:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4474D3CD332
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 13:14:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF5003C9E39
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 13:14:16 +0200 (CEST)
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6EE826000F8
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 13:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687259654; x=1718795654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GGyMWlNpM0tGiYgHmFd8cXAn6cDKX7HJdQhi2KWYG64=;
 b=f3ONY45JZ3oIK465wNLWrSxWkJ07y0WvdjjgI7B0AWa/R13fUs+icjQG
 jsLMboD8f24EnrqAUiydCOfYTLIs5KPihxsc4Zn7uRDABZLQtv7h5w+Oi
 XcGaFazQoitebejHmyB663JRHouuHCFsi3RKN7Dt9CT589vPnBZdsqt22
 4Xl1JnyiB3VH/OjeBv6oo8ZyMLn9jQVUBgKDwX1KHyJARsDp2ttqo+fMD
 yTtNO3PhzTFi2s4pEHQt5/tqosrWav7oh4LnZytqOYgFY/2Hg9f1qTV1E
 xuelgNEh8yh8/cE9pwEC3MEdJBKqQsLY8c0Bc53MzfdHIzOIH/PLGLFi4 g==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; d="scan'208";a="235733786"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 19:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykw9HI/vKa6dTb+M9uC0D+YD+RT9bmXdukfKa+vto0BgqYtfrMT9bh9t4hUc2PylYK2rmqZuM44Av+uZaa4d06shfeZg5T96UzWQ/6UbHhZPoh7KeZwu/8TIz86H2Pyierrmyo5JrRa90GUiRo51C6v7B93ckSplAea3HsDPrrKdF4ytKY8eVMkZgMq2S7w+t46xl0zzwTCnvFDQJ99fw7Ey92kDg59MZR8ej0KXtXtvfY4ABC2LiQmKch9ItPrJk7VcopiNAShgA9d4Y1KiGKIFYuiO4lN5ku929XAWdpk/QeBH7Ds4YsV8XuKbFO0ySvyYvcajwHN1B7y+PJTPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGyMWlNpM0tGiYgHmFd8cXAn6cDKX7HJdQhi2KWYG64=;
 b=aUaeWPsoVu/HQxuZau118/IhNEjzrulmd6iWd+HFMX07pAecoESgPxX6FKoASUbJmDXSO12GlquBPtgvoi0ALhwjxstkMGKknDOWNqFXVdGkA5WBksPErfNpEYaWDVAtv/tgviBBbfaCAhjMFihawkL595PUOCWTOkYROu7tVvpGUKWmU+XCWQCXyFj1y0JCQH1kT27IrCe4yfXBl0HjG400CtpdMM4KyTd/u2ab00ZJzBOhPzvmltMWOM2fWD/kygRYi60ObOhWShhbP7jebpj+Y6zx/7fmrfULL/DzLhHMhRzQKzfpqGC/wRuAQmdmssp2qoT9s8kKaDi85b9CuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGyMWlNpM0tGiYgHmFd8cXAn6cDKX7HJdQhi2KWYG64=;
 b=q+HQYZAFIDZYrqIrUKA0jGyYIXhcjId7g1y+eRQKDFxZXDdQvZFOO6kF7hNtwO8R0engO6bTRRcEHeIcXsjFlmqKG1oW4K44bKnqj+QyqIqx5DZOBsHsn2HED+aX3c3a931qdxSq7i6fF0AwWKYYFBd3W4yZdENq5B3bbQrnybE=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA2PR04MB7738.namprd04.prod.outlook.com (2603:10b6:806:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 11:14:06 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 11:14:05 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 0/2] Improve ioprio tests
Thread-Index: AQHZo1d78K9JAcUirE+IhralZe8ql6+TaTOAgAACFoCAABkrAIAABYIA
Date: Tue, 20 Jun 2023 11:14:05 +0000
Message-ID: <ZJGJ/PR5+g+aJllz@x1-carbon>
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230620091316.GB275381@pevik> <ZJFugRCzFlZYL934@x1-carbon>
 <ZJFwQRo8dOZICQJ+@x1-carbon> <20230620105422.GC281987@pevik>
In-Reply-To: <20230620105422.GC281987@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA2PR04MB7738:EE_
x-ms-office365-filtering-correlation-id: 7e3ea7d8-db27-4c88-c47a-08db717f7602
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqnw8pgY1NUD6MMgGy6W4xkbhPGx/QFjT1MZ0Dv/kDOATyCqjN+kyRkb6ctS3MYpevU8pYyo/TLUWABPoQ0qA4QqLu9Jkv5PEU/HXmCFBzUTdWm30MJIplnLUvHhzTV5tAWe1jxhKG2e66/NpmgFeUxLjNHgzrCROZLKg9ey1kXt85m5VRb7vBYHhbP0gk7MXIAF4DpFn5wQG8/xIGxjtUtP1mF55vhgFexZWPUffKRyEVLAZLLoacDWhvLpVT9VeY3hmonFXKB6ux1FVslybOUdIRa9iNIeomVUqNoM3rF66jh5tlus5QBGB6+4bU5GOitjPHVAcFZ2b3E3agJq+yy0mV9sI88b82jMFffF2Q1h/TBoJl4eXMPRFSSczrVMLaaZk57m4qeQGmiGGX1z6AbFATG1/3iDrieR7D0SYNNEpxBnqeH5tVScwXRjIVYEafaAEOokluxS5lp5ue3NzrvlQe3uMp72U6mtEi+IfBNJVhM0T4169Iu6ByJB43qMBeYNfJWreBbWxmuHLllRnyb9EPinOCIGTmYtvc8nOr358DPxcBMCVVRhbjc1mNzbevnk4WUueUqodKJ3k7gmm4HcwwVa+oLfGjxiSzqLa/U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(316002)(4326008)(6916009)(66446008)(66556008)(66476007)(64756008)(76116006)(66946007)(5660300002)(91956017)(8676002)(8936002)(41300700001)(38070700005)(33716001)(86362001)(4744005)(2906002)(71200400001)(38100700002)(6486002)(122000001)(9686003)(6512007)(6506007)(26005)(186003)(54906003)(478600001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eJErPepoHQDA0JKR6c4mlt9AolXVpmzau496m79/fICLuv79ylNkL828cWqy?=
 =?us-ascii?Q?qKuZ4qCcXs2Qm4kH5iZx0eLUwzu9IMAOAB7J3Ryh+wXegLxfDeJpjbU6iSvc?=
 =?us-ascii?Q?vEo+aF81q6e7UPkEqv7Osp3X2ZPmVgGJ9dW/yp602yXNz4Fdvz9D8P0JHNKS?=
 =?us-ascii?Q?5l513NW2iHQ8T5N5DcobYkq98G07lCt9E2QghzLOgYoIuDp536KpieShMsDI?=
 =?us-ascii?Q?zRzEhULmq0tx9K4JbkzW3ZA8YDrW6zY+WspVjVXxQr6+R5hFoOMGwfcQ4L9n?=
 =?us-ascii?Q?+XKFwSNrENDNxshdU3WTCJD5XHBQ7+994ODMUzPVcV9dOs1+FdqPXM60Y3wn?=
 =?us-ascii?Q?G8EC9oJif0Ne105/AWdzz9sZcYhKT6TBqixkoAkKFR4OPi0qUADw5kbAUvLb?=
 =?us-ascii?Q?7nh78Ehw0wTPMaBQt5r3KJAx65X7EByFJHpBmw/F5YHmgYLEstvKXzvD5sZR?=
 =?us-ascii?Q?eOwaEdnGvTENswSJZ159GUriUVCPDTrdREZbn7HCdYbjACesr6AiVwrwEtn+?=
 =?us-ascii?Q?kv5uuFHd6jURYFhyotNfF4RxtPh6goQ4w/A+dxOBAQ7dDFlbcEFkDXGxlc8t?=
 =?us-ascii?Q?WcD44o5RumaeEr6ZQcMIuENuftKidrHWPJfQeFhIJW9R4sbujJCHuzFpmghi?=
 =?us-ascii?Q?FF/m6gevVpYBVZrWdJnDYAxqQPKFwglCNCH9RZzX+40fO2i4nCbwIlNXSoMr?=
 =?us-ascii?Q?gnAP9zFnaE7IuEyOxYLe6mLwcV0PgBygA4rWaQsC9zwfm0kKiRuEDizVpuzy?=
 =?us-ascii?Q?roLE4HoOX8QSZGQw9WCXsqNmuqkmRgHIEutBjke/W92iOmBZL2hLpUplBOvp?=
 =?us-ascii?Q?ZN3NQU+Zr+vtrV2xcQ3djvlIfMtPND3WjBIV/1E4gD8JyUT9gQcXRCDSGfkG?=
 =?us-ascii?Q?ne7NLneO0ZW1gqR3PI7eaALrk6nlTbzF5AGieR31gSsAlcgKzM7Ms8Un+ftt?=
 =?us-ascii?Q?/mngDmfD2oW4YQzzPWbZYxDsI1gnyrNyf5JrEFwKlWMwRT4aaOEE1P+6Vb+G?=
 =?us-ascii?Q?L2dbfAJ1sHHdRLDgm9HxrEvA+hv1WlV1t23cWjvLGZBGdr3dyI6WZTzUYSOQ?=
 =?us-ascii?Q?2TC/iAUMbAwEtkmLmW8hKZ3QZYoOuBZxFQdtNv4pE7wPnXilWTuQW3kY04FB?=
 =?us-ascii?Q?L5vJ8cVxsNLksb9J7QK/2GuyqZE/iC6ojx8FDZgBXvO5LSeBSgwoobNIHxGG?=
 =?us-ascii?Q?UnZtsBGQJQox72wzt4+YxYppvgHeDf1RLgg3v7WgesE8y607gRn8JAh2mSHP?=
 =?us-ascii?Q?SBnbA54BxdkDreJWUbQRw/IVV+9eXVDYrmSfZW8QnM9YMCzM89dGp3ES1QoG?=
 =?us-ascii?Q?/JYFhXADaCzF77B5DYtWa9JUuA50TwMLkj2WJ2m73iGyoGfoP/+JPcXqbfD1?=
 =?us-ascii?Q?jleeIWO2bgjvpwOBLd4ZFGnGgyBBb0Kjr+zJSuEcXpsxttw0FCTvRaF6jwNJ?=
 =?us-ascii?Q?6Bekkv7noNOmimjtCO/vT7MZBN+Wg1a3CvvDy5JW+sGczuaqli79bjskcCVU?=
 =?us-ascii?Q?sywwQL1dkeKoniaXMU8Swv0rGjVPSZpzu559p5VWd6XN0HHAAPaM5dAyA98J?=
 =?us-ascii?Q?eIOE02llANSdTKDgbTPQ3O3J0rme3C2x3b9m3Uq9HMGcAnVymnuiyg8cdX9g?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-ID: <38D7DFACAA28F7439506F32D7D6CF113@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cSAXEUAB8f1pRjV4ynyB5uD6PFfoFAZwJ4jcMlMHOa+CSn5o1ii9rVZ0VO/lyCdUttSgYdLm1+ERcYjuefe9WTwUBGlg40KOAfK1Wvo4fSAV7rFriWnou+bFGHqqIeafH/fnzkh7mNYZj+cD5zpZUkRDjblFWyL1rBdPRz2Onzmcv7CSe6XO2mWUfCX5gRz5bqFv7N3RMSPMB4ppo4YXPnRCxaHqEXoL290WxgaIpAPKH0+XYCJjQsg2uAl1EMpsphVopFBZPENC3eLU1mb92aRa41Am5H6GoO6tXsOP3YPdDLVN/XBbu2aGCWKMe9/seZgaXYKZJQ8Jz5s6Fwnk7WKXtedtyCdPj5GbO7YoWQA7HzQBOy8XoT8wurBNZ3E1o36Pw1kuFkXmUNFXyLy8QGG+crRZL7y5l7KvzulbttSPBu73/ZHTS48H7GTpk6GNV1P/44pSDBLjysRxM/91tm1OfZpXV1j6N36kx+VvSW79fDgAx9u19TR7wNJMHV5iqaC192kaTILhCo4/oH+WEFxihS4EZJBDWHb48gWalcjYSWBEdmvK/kNc3lgKhCqHenGL+36fFTCGNCm3sF0dimMlZfK//3+zvoBXFkBYtPIVPn8eRmSiDMVKTeb9FKKgIH8mDAI3oQM7tBtgN3F/O1UrmNNimwvugZ7CBMCYi4LIFqCa7p40/qSdH06C5RRfTu4KZ0xV1aZ1H32kVhqg4TFvyoSkuMJSQ5N6/0ND9FageyZF1yTixoTNY+1dCgTZW44HwkfYUsWmv54io8/mVj1ZJ5d7CRv6+gpFxgbxPHPjhN2AjF03VClKOOkhiY5TxL3zH54890tcbeYLRMhkZ72k68mu8wLbOuil9Mkd06k=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3ea7d8-db27-4c88-c47a-08db717f7602
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 11:14:05.7410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifUv8lM8hN76NSoAjbCOcJKFgOjZYoa1uqn3hsDYPKUo4i59DvjSHGXN+G5uWaE3UkLdRwGKMQJjzbbhYjWEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7738
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Improve ioprio tests
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 12:54:22PM +0200, Petr Vorel wrote:
> Hi all,
> 
> patchset merged with added missing #include "config.h".
> 
> I'll do the additional cleanup work and Cc you.

I was just about to send a v3 with #include "config.h",
now I don't need to :)

Thank you for your help Petr!


Kind regards,
Niklas

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
