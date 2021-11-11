Return-Path: <SRS0=2GLJ=P6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC7C433EF
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 03:26:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEEF61261
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 03:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DEEF61261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A87FE3C6EA2
	for <ltp@archiver.kernel.org>; Thu, 11 Nov 2021 04:26:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B4EE3C04CF
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 04:25:58 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D97660004E
 for <ltp@lists.linux.it>; Thu, 11 Nov 2021 04:25:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1636601159; x=1668137159;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yW434T6jE9ND3W0wnP2zBaGhnbm0brzAqlplnfZFVak=;
 b=cG0IEDpuDiFZXl5Z0WTehlMTEn54cGLvv66vOjC2lniUU81Dcy9q62X0
 YiLL4mtyViEO0J0s4Tt2v419/M/EHckewc2V58x3n60B+yOQv0Z+En9oA
 E/Nw9++lcrogwj4dfZQXzwMiTL1Jns1ISXw3luqJr8Gm6YpEV7aOKXEXM
 jtIaz17nDrLOuHtI+AKwZOk1Q6OA5rM5MW2eiEgl/DJ/Hy4Y920bTJfeE
 dZelTH/rMrLicH2+czNlO06Y5gsZZkLa0ZP9mvj4/y4SP7Q4hZ52qh5Rv
 EboAYMtScDWWVeXyI1+mJlGiWy3oeas8obCi1uXRZTMm0RvD4yzkxqlj6 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="43286558"
X-IronPort-AV: E=Sophos;i="5.87,225,1631545200"; d="scan'208";a="43286558"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO
 JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 12:25:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNfb6NRCDv1imFUOZv6DItWk94bftw+rZ4oe8Jls0aTbtjQ3G9ibrsobw1Tg1VOkjbyGjkHcsEL2yhQ+Ipr5Yz7hobVVoKPT9rIE/wIAjljrv2ioXm/NmXC5VBV1nrjl/lMaPwFVZ4a2DOgXD59dxaPDhaCJ3c5pOuGBOiG1nCvHRIAPGQ5he95EOHljFhpslp+B+yxFu5Q3WlB4qsQXZc2tOGJ60eIz6VuanVTje2Veks8EATdgk9e1LW+TaseWXi68BkDODL/Cs784tZ2g7G1w9NRsZU7tOCqz28z47MT+rYZWTZvLhU3DX2NJjp2Y8Sx7aaeXiKEyrGICICI1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW434T6jE9ND3W0wnP2zBaGhnbm0brzAqlplnfZFVak=;
 b=QbljmqmL7LqUhsbCvGvwZL+JrLSBWVucgr55f6Q1qovLJTPaAMRz4lFtpVBAOWJ42MEvgBFirhqWzTfiFCyoXD7tOdWo63aC2cV+4WHZ5ZdwOdM6RHfXe3q8W750EkSbShHyMiGO5ZyraSMZyliQzOvC3KXNgsngW7l2/YZpgI0ZOnGZozntoIz9qoMxBfG+Z4Z1qaFfw2xNKIgvUmUi1hHTqMBPb9P0Fonl9FjCLoQVJ3KZYgYQ4/CKFnAB2myQKPhGiYsQlOFew5TFzASPCg/WmGFCkSMjfiKrhxAjDUCf9YRPQ3se3G00KguKreZTuB0V1rzRYu+zzR8GyjdNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW434T6jE9ND3W0wnP2zBaGhnbm0brzAqlplnfZFVak=;
 b=l/tYrtw8PeGMR4oyVSWWtlNiY6i3rXYoUWbQJDMbsoBm1bOQCXbWEWHYMTvuPIlFxPHSol8PQzwItGZQB4Fywm5S0CYsQWa//4SdvMiEnRYDBq1fz/z0fp7q52jtktYA5J1BY4VWztWLzU1dz9wcluZdhCcf/az3ycsoYGqO7tE=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OSYPR01MB5559.jpnprd01.prod.outlook.com (2603:1096:604:88::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 11 Nov
 2021 03:25:52 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::5850:1d20:8712:7420%9]) with mapi id 15.20.4690.018; Thu, 11 Nov 2021
 03:25:52 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>
Thread-Topic: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
Thread-Index: AQHX1jbTk5TE3JSfn0mFCO1roAjLIKv9q2MA
Date: Thu, 11 Nov 2021 03:25:52 +0000
Message-ID: <618C8D62.20904@fujitsu.com>
References: <20190911124714.GA21670@rei.lan>
 <1571975625-6322-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <87y25wjf2j.fsf@suse.de>
In-Reply-To: <87y25wjf2j.fsf@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5249d0e-36ac-4492-c9fc-08d9a4c2f716
x-ms-traffictypediagnostic: OSYPR01MB5559:
x-microsoft-antispam-prvs: <OSYPR01MB5559AFDA473F062C60C550C9FD949@OSYPR01MB5559.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoTObPz1I6bSS+wIJA/9ph+RL2QvDlOZkgweU4hVfXCN96OkBQshjaAv0i0VtPQpjnrN02jIoRT1U7Qpz1UyBTepJJJuPZOweosBJhVMOmQ8OOyPjKEXxHbA5bCjJHnYOjMH4+NDeBsGsbk9pQ7g23xzhosUKcf916S/Q09ajZrt0VK3+XutuhJGywD9itiS7lXyIcZEASM141fK/Uup7F1niwa8YmMT3Kg0KqVUVTg977EQ9BkmzB1bO5cLxJEdY4GXXR3xt3VEEk8lPV5yW3mQQdAj3RPKn2WiICdbi6OWtYypB0iMf3cy4zQCbms4SYNuXsYLr8hhYfPL4XZb1tMca2dCm0wA0vYs1WCdE5uAY/hXNESZBPr7wQgan2yvuadEr3he9q8i1owsJvu9ROI/zxc7dHvlsyQ+1kfysaKkJeKs0tcj3jpZaEcSu9GwOUEBq8PG9QAGOcuMJsm56SR4vvXH8wpADSmHAKoA7oQr0LPdZzD+T3e3BFpqZdqI+31tDInfnQndtDsMY0WSZxiQd8AZ7hE9jYk1ysP9TVVc9xM+5z/VM+yLhGErMC77xhswmYESPR8xrOH9gZxtvXLbJjRsh79dRCVPongKE/kD/qLmISfYDgcyqm7KSuhJK0WJdeinXH+yQyIS3hcbRw5NSLwJzFDF5fNnhCPOpoEvlGOoe8xM0mplUKKjDxEO+poKVJLVCGC0mobBcDJaDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(8936002)(33656002)(186003)(76116006)(38100700002)(4744005)(26005)(6512007)(54906003)(508600001)(6506007)(64756008)(66556008)(6916009)(66446008)(122000001)(5660300002)(6486002)(4326008)(66476007)(85182001)(71200400001)(66946007)(91956017)(8676002)(2616005)(82960400001)(316002)(2906002)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cW5XVFpmYXBRK08xYnUrdUdJcFgvUkprb2RWeGJPcXVYZlBGNWdVc0pHakti?=
 =?gb2312?B?Q3FrMGU4MkY1ZHpsaGRiVTdHNGlEU0xvbUpJN2p3TnM2cUxuS0tTZzVZTW0w?=
 =?gb2312?B?S2c2S1VVMit5UHR0dWI3UktzLzNNc0tpdXloREY4QWQzamRFcW5CLzcvWEpw?=
 =?gb2312?B?OVBiUHIrT0MvMjFoRTRjUzMyUnlORm93ZHFCYWlibldGVXBVZ1ZSLzUyckk5?=
 =?gb2312?B?Q1pIZlhkT25WU3BUZFJxTWNNaDBQMUFUK2lTNkE4dWtZcXBJM1JkWVdLK1Ni?=
 =?gb2312?B?cWcvZ05OdlBHSzgxU2s2aXYxc2E4Y1hsN2h3NGkrUzdIVU1tL2pJS1NvT1cw?=
 =?gb2312?B?MmZ6NGZIdFhhTmMvZWwzeStmNXArUnR5T1dDTElDUmFFMUw1SzdQT1JTMU1y?=
 =?gb2312?B?dGVWbGxZbVRFckQrZGpMUnJkM2tyc3d3bW5FdWkrc1Y5OVFnR0dNQmhLQ29L?=
 =?gb2312?B?Y3NlT2Q1MTVwSGlYaG1ubEFtN0RJNU5sN1NpK3hhZUZJMVhuaFl6djFkYjkz?=
 =?gb2312?B?cXVsdEd4THhuN1BxVFc2akF0WVQwbDFVNUZ3dlJPbFg0cGd5c2VkWHV1YUVv?=
 =?gb2312?B?RzFXOTF2V2RWclpRV1AvVFdVakNnVno5SkNmT1hLc2ZMRnpRdmtJaUNXSkN0?=
 =?gb2312?B?N1VOZ0ErSGhjaU5FZUVkV2lReEJrWTk5WVZwK202VUJZZHhma1luVHJIdGdx?=
 =?gb2312?B?UEZjam95dUk2ODVRaWhKTzFFMTFWQWZnNFVEWkp1bTJQWW0zSTh1U25vVkg3?=
 =?gb2312?B?WHNBNEFSZlMra2taTjM4SzlIVmZkcmQ3UFpWOE9rMlRXNFZvR3Q3Vm5hQ0Vk?=
 =?gb2312?B?akhOTzh6QVNTUThnUFdHVzJyQWd4NFlGdE5oL0FlL2sxNStyMldRZmlSMnQw?=
 =?gb2312?B?bHhhZ3hDckY0YVA3N2EzSXFmeHJ6Y1Y2VWxYRmRNNVcyQ1ltNSt1a3c5MHB1?=
 =?gb2312?B?N3ZPZnhVdDVDUUl5RUVpVWVKVDc5dE9VK1lUOWNodldMangyMCtVMFZzUmN0?=
 =?gb2312?B?TkRyaUt4d0tGNGFjdERyQ2MxOW1USWkyN3ZlTmI1L2lla0lKbzFQOG5mcGlE?=
 =?gb2312?B?THQvcWlhMjZId2Q0SGx4azB3Sm9lbU55czUrcmV0d3RSR3ZmbUZ2dmt5UHJ1?=
 =?gb2312?B?c3dwb2tHdmxaQ2NQS3ZLK2c1U1J6NkpWU3YzWmgxOEc5OWx5elYwaFpmd0Nm?=
 =?gb2312?B?MEZrYXdYSnExeHo0Tm1MVEVVS0oyV0wwdm4vOUtFeEdIdCtlbGx1bVRlS250?=
 =?gb2312?B?Zk5wd3E0RmliR0tPdFV4eGxmZEtGSWRITzQwbkxPYlcrZVoyMzV5dVM4T3p2?=
 =?gb2312?B?KytGcEViR1k2WHQ5OFBpOXpyQ3RZQXk0a0tEVHR3RE1HcVlmeDdpWmxieXNr?=
 =?gb2312?B?ZlBiSGR2R210NkVPd0YzVmkrZEJjMStxTzRrMFgrclpWSTVBNmFXRmpucGN1?=
 =?gb2312?B?em0rZzBBWXZrMDhjWjZ4OHhSWmc4NTNzdWhCd3dSckJ1cysvTEpWUmp1djdJ?=
 =?gb2312?B?VHpZcVNRblJOTnhvTmgxLzdUb1V6a1Z0Z0xXQ3VzRDZ2TzJuNHB2VXNRcDBF?=
 =?gb2312?B?cE5PSmRNbnBBVEdJcmU0emZFNmNqU0F5dG5HKzhtNktYTGE1ZkI3Tzdjc2Vq?=
 =?gb2312?B?M2x3a1IwUVdwdEszcit0WXQ0MnpmTE5Id0d1UVhBM21oUlBVblN6NzdTcmYw?=
 =?gb2312?B?Q05FelpSK01yOGkzbk5HNkNXVjFPK0NEZWFydGIvL2JhUjlNaDN5NFVWbFpS?=
 =?gb2312?B?Vm9CMnRoaWVCZHJmS242Sm1uLzlESE83RGxMNWlMV3pENTY3aG9pQTQ5ejFJ?=
 =?gb2312?B?cmdkSGJnTXlQVmtMQnMrWFAyVnQ4cmVVTWs1TWcxQitmNFB0bFJDYWxacXZx?=
 =?gb2312?B?eHh3U2U3Rm1vU2JrSGdHbG1NZGozMHIyMWpQWmJSUURDbVoySlppa2tQTEVn?=
 =?gb2312?B?VVp5aHUzRDRjVmNDSkhkN2YxRDhNNWtXOTF1WnVqTS9GSGhEZjRsRnR4NGt1?=
 =?gb2312?B?YTN6S0swTkhKakNyTjdhdkJkNWRvcWthYW1CRWJzVlFvTTZaMDVaZldkTzhJ?=
 =?gb2312?B?MFRUOTRSQXdCUkU4Wk9uMjUzYU1FSFp2WVl4V1VhcVlKNDkxMVdKa0h2QTBB?=
 =?gb2312?B?TGExOTk1aW5hSlIycGMwWWNYeEsxNHJtN2ZObjVyZ1NQYlZ3Ni9Ldy94THZ2?=
 =?gb2312?B?Z2kxaHZGUVd5dVlYNVVZcmtKWVQ2c3NVV1FQZWhxNExLdDVEVjRMYzRhNTNC?=
 =?gb2312?Q?2rk1hk9kuPGyubHh8Usv6EzjuT6RdkT8UlM2HbAapk=3D?=
Content-ID: <3BA0B05F21B85643815502B6619D85C9@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5249d0e-36ac-4492-c9fc-08d9a4c2f716
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 03:25:52.4746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcD0bpJxLpDelYH9kgQxkF9Lfy9qWov3Cy2McYwG0mdytlBxlVFA4gxx0lwK7nqPyFhPZYpoKHxKjOMFMHa0nN/QrF89HcGXt4ZVlHGnNY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5559
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
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

Hi Richard
> Hello Yang,
> 
> The fix/feature appears easy to backport, so I would suggest just adding the git
> commit tags to the test. If the feature is required then people can
> backport the patches, otherwise they can filter out the test.
> 

I will add these linux tags into description and send a v4.

Best Regards
Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
