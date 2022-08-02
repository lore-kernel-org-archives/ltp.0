Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C51AC00140
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 10:10:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C56D53C917B
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 12:10:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D3D63C62DD
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 12:10:26 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 222D12003B6
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 12:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1659435025; x=1690971025;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=syTx/bY/e5VXV46rl+d3jjUiyi2o7oSgnvY9MKAKOhI=;
 b=Tqnpth786tMzmKXgg4UwgDwKgaiB97sC0A7GneuatMedl4h3NCkw2toQ
 hwKP7q4Lz8mJZIFsIHh/gVLAS/qs0y/AB+0V+RJ1lT+PiKgi9cFvrZo3N
 4XymmNqZ+/3YejhCVZ026TZ26ttiFDtDhel1hbz9a6k0WYUP4RBPa3KFC
 2BgBjTwNtxXyOSgA9eCGjny11tA49+xswO2rdwBbv+LoDN6GrcnQNISHr
 W7kJaGDU1mQpnsW/+mZlslpdkQIWMCGZRX8tY+G9qmwKALVgzWo3nU7wE
 UaHdIkFwFEZ+UoQuz3N+a9xUVw+I6+5QEbmqMC0AxKttNLRtbouxtG78s g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="61649117"
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600"; d="scan'208";a="61649117"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2022 19:10:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvgdceRg8HoMWHlNeB93XevlsZ7oVS7VmgRnQhw+Z0Ja2ucpz7U4/r2lG7KkWBcr71mu95qfCddZdLpZRRM8uYiN8pj0XVdsffrGEZMj/8umgKr6UWT7WdFVQNInk2ZAY8Vici6V9d85VKQHAg8k5nLKSZwMTNaCExWGspUmHK6X+NSvZVH2ZAf70GYCpgJBqQOM5QEFP1RFnnyWcsxKJ8g9GS+U/+i7iX9PAl8Gg6aO87rYEE4pELpM8u7b1Ien88ldpJKYve0XubVK2pHYlIGKf7+iaDULuWpq0y/om9yNzmJMv6bFssMTUtVpRNXdWHYVXyT0+v+EEtPhqVtWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syTx/bY/e5VXV46rl+d3jjUiyi2o7oSgnvY9MKAKOhI=;
 b=U2PwhyUrQ5Am+QY5QbAN/JJ3qImptzhsjN229dDu0owcksIKM0X1HeW9C3JBliRGazUp4gLHKn6tSEEqqKXF3rUeakYeoKWEFRTn2O08om6VaHXUZd1jcZiSPqdsf0VTa+t4a/IDBrDQ1AZLazAMMhQosqCFI5Lw+iQwr3OX1L5BJn1MSxOwgFBwnwDM4P2owDvGROgAYRh1l9Q5vMoyRau6Kvnc5mNHJGAm/kkdanhKDl0gq9zs5KlXUEYv1SXTwHNjmLvrLtBR1tICVRwdkVUCUfNI9dogBEEJaUimP9IGM/1VKMQwn/Ut9Dg+bCqr+XmFb64es1HH6c3JLLonYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7730.jpnprd01.prod.outlook.com (2603:1096:604:17b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 10:10:19 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 10:10:18 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "rpalethorpe@suse.de" <rpalethorpe@suse.de>, Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] Do we have some simple way to get the current cgroup.procs
 path?
Thread-Index: AdiXT1u4fxhXw+J5TcO+wfpeq4Xq6QAHJHSAAMVgfwAAAf7QAACHCAMAAm7APwA=
Date: Tue, 2 Aug 2022 10:10:18 +0000
Message-ID: <0a40be08-279f-a35f-1933-f44da14ca273@fujitsu.com>
References: <TY2PR01MB442719179C60B4DB6D275B5CFD889@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <CAEemH2fMfQYhfaV5_LeZCxfkCY=FKCqXc+SrZzQLVjzTf4yf8g@mail.gmail.com>
 <8e16d91c-8307-8ea4-bde7-28ef093c1205@fujitsu.com> <87tu7eivrm.fsf@suse.de>
 <435ce78f-df1b-782d-75f2-2794a5b23f90@fujitsu.com>
In-Reply-To: <435ce78f-df1b-782d-75f2-2794a5b23f90@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60612981-bf1b-440b-31bd-08da746f33de
x-ms-traffictypediagnostic: OS3PR01MB7730:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JfaUPxXJMKa3MH6EBF/nw//7MCYTc80fUWcTB+tRYAmo//ZJX9u71Wdwb+UhaRc3D+pNjzlRF5fsF5ZahCmigjA5wjTuzEjXLAiq4R+JXRhyDzIFlKskiT+2JGv/6/VAxFg7oqSdyD/iuZ23bOBAovoecrJUKrbJaIIDhRekwXVeLp7k4scVjucbMtRs5pKHuGd29APpOFH8KXrePDLOnwornx8dDgk7BzTcx+5jdJMZqvc1POGRJkNUt4lvawgUJgA1Nr6upLm4qiRe05PMxdAMEqtCNX1jYkUlrBQ0mwGitdf1nYOOxeHQXb293Ur0gGjaTzi74Kbivu9Ul7Hp1UHl5CClb4AgwuX6zE75iMcofQW8UI7q/bD0vLH+pL86YC6KMl3/rEswHfW9/l7O5Ud0gTdJNOKkNUv24IDc7qZQSAWm17lEZxA7gaoJGsx6Rw9SY3ZU6yNrs7IVBURzQ95dQPqvjGs8dLrPoxn47g0W+4DSkBOe9s8XELsDeY0TP6Y/hSZ71F3vpSlamawLRJElMtQ+ngSvqSsBWwqlwFdwQzjR0NpnTltdd0OsoQIwZP5Te1ROYncmTKID0zWIzqCkzHirodDKYZ/M/pnmuWI0SAQ5SdTPSFO9Q/zoil6kt3K5zMaBitVFVKCJ/8QW2c5bJBuCXbfTHLQ9fYyGiCj1Rjvfzk04eL4hv7Xrp1xWaoDqDba3vFHxZvoXievWW7+/vXYihmgXXH7U5D1pmNUIRf7q8J+D/Cs5+72O8iyv3QUgouzPprF/MeN4O0T8zHQTlOMSD4HdZcnRAUVQZaOOZWq+fgGUuxDrwNm55NjpoF0ueflIa0UfySrn50ddImmhSOvfGdVIHYhlcAzxGYJ7Z1XaGE6r38MKqQTNxvtT6tWJlYrh+BCeyzfp6SIsU6eFs3aP6zLa8MLoohioqvk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(85182001)(76116006)(53546011)(36756003)(186003)(38100700002)(6506007)(31696002)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(91956017)(2616005)(71200400001)(83380400001)(8676002)(6512007)(26005)(31686004)(4326008)(82960400001)(110136005)(2906002)(478600001)(41300700001)(5660300002)(8936002)(38070700005)(966005)(6486002)(122000001)(316002)(43043002)(15583001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmtPdDlrWUFQdlN0T0h4eWlVdmg1WXk5ak5aTmF5RkIrWC85Und5c1BFeWdL?=
 =?utf-8?B?N3VGaXkxMXVRWTI3cy9pVjdPSDlvNDlublVVRVVLOFVUY0FIYVlNWWR3LzZz?=
 =?utf-8?B?SU9xbzNhWGJvNnd0WUJ0WHZGMTlXMmVscmt2Z1dOTlhEMXZJZnl0T0tFN2lt?=
 =?utf-8?B?VUlkN201Y01FNTZBWFNNWlFKamZmTjUyWDI4MXUzSkNHVFlQaFN2eDFSRldv?=
 =?utf-8?B?TTRLNytmMGNCR1R0bzRuTm9VNk1HQmV3WVlwKzZWSmNYaUxlZTUzeCtwTVZD?=
 =?utf-8?B?WVdwVWpqZVRlcTJwM0p1dW9ZVFFwU0ZWQVoxb05hUHZBVGp6MEFTUXY2VG84?=
 =?utf-8?B?eUJ2cDcrWTF5c2NNQzJjK0RFL1ptdDVpeVU0Nk9JSDFSY0JLbXNpdGJ2VFNh?=
 =?utf-8?B?a3ZtdlhjRzU3aWEzQ1d4MjFaTWNTaFR6allubGR0QUs0djBkMW5zbjJCc2pY?=
 =?utf-8?B?ZWpGU3kxYjNLdFN6bDB1UmlIR0Fuc3hESWhUQ2syMGgzMGRPVVVIbXJ4Ui9D?=
 =?utf-8?B?N2hINGtweUZWVHZqd1VDMG5JVXlGamZjOXpQL1IyOXVWVmNhMFk4WDVTWXN2?=
 =?utf-8?B?N0VTNXlWQWZzRmYxUmRmMXV3S0NBMndHK1kxb1dOS0szRHM1Z09ROEc3UklG?=
 =?utf-8?B?cERpbStIbFgza2d6dTl6NTdRNjdyZzBDZEJGNVFLazF6WDF2SVB0N3VsSVpl?=
 =?utf-8?B?VjQ1dGYrQ3dkOWZFbEJBWEh0MWd3SHRmejA1TEpRM0RtUklNUHEwYWtmN1Ro?=
 =?utf-8?B?N2d6SnFKcEVhWFVaQkRCZWtvYUw0dlo5dTRaRFozczN3RHp1VDRCbG5xTEdZ?=
 =?utf-8?B?ZEZJaHZ4d3EyV1BYMmRpZUlsSUIxcnhKTkEwaXBHSnJsaXQ0RTFVenJCMVBu?=
 =?utf-8?B?MkhETjNhTS9RY1Z4UDlkZENSbXMxUmdDTm96UUtReE00S1ZoL3U5ckwrRGJl?=
 =?utf-8?B?aDJCOXIrZlZBUmhwdjFKSzJjNGpnUTVISjQ1Q3N2UXUyMzluRXRCN2ZHRTJB?=
 =?utf-8?B?ZmUzUXFVbExGSHM0S1QzTGR2MUJqdWZJcEZFdHluTEhZcmNxZy9Ja2p5UEo5?=
 =?utf-8?B?YnMvbnJGMWF0cVU0OHZidHNNaTMxdGw4aGR3K3NZSGxVWEp0OEN0YUxOU3RY?=
 =?utf-8?B?NGp1QzkyMENreHBiWmdZbVZ0aVRxL0VLUWs4cXgzaTE2dVRNQ3Q3L0ZTNk5t?=
 =?utf-8?B?Y1VMU0E0MG1RL2tnUkpDSGxKTG5CN1JsK1ZWYi9VYXdNdjRKTDdSdnNScFJk?=
 =?utf-8?B?YWRpZnJrMUFKZUxPclcyUWhaN1ZoUFgrOExzWXI2QnZjVGhDVDJvL1hVbWh6?=
 =?utf-8?B?RVljTExFTjhEVHlVUldLdDI2VmM5dkp0MDlaZlFDVTVMRnFYTDNhWVlrSTYw?=
 =?utf-8?B?elN3V1U4djNoYkFod2o2U0NwYVZmMjRUeFA3UENCN3RBNlFzcWNQMnFIbXV6?=
 =?utf-8?B?TkZ6NXc2Mk9jMlZDdlBIS0JFZWROYkxSN3pPS1ZVazdWNjFBQXBzWXNpYisx?=
 =?utf-8?B?cHNXeGpCMFh0UkNFbXNPeVlNMlZMVUhhUmpDczBnZTN1WENsSXNpclVwYW5J?=
 =?utf-8?B?SVEvand1VXRya255OU1yVytVQ3llTkxUQnBIbzAybVlBTkRmWXY3N1FZbXdl?=
 =?utf-8?B?MkMwaHRRK082SCtvRTd2YnBzdDhNQ05vbDRtTUZmRk1TaDZ5TlNQU29vUzJp?=
 =?utf-8?B?eERUbXBrUnpNa212WWVlYmtUVHp1R004M0V3RktxR1RLQ05tNWwyNWJoR2tr?=
 =?utf-8?B?YVhJMTYrcDFoandNR2pEMUZUQmYycHcvUWp1Mkh2cmxGTEZmVzc0OWVnY3VC?=
 =?utf-8?B?TkZ4L2lsMkRXSUpENjdpRE9FbGF5RUw1RW9FT3l3NDNCMWEwTmxURnBiMEky?=
 =?utf-8?B?VW12R3NLMWRuK3BobThoTVNack1Vdk5uSVNHS3kyY1RpbEFPOU5kRmRTcnVh?=
 =?utf-8?B?MTdheWcwdW9TQXBtT2xjaW9sV1FvbGNOQ2tkc2xpSi9UZ2lNSUNmYXVuTk8z?=
 =?utf-8?B?VnpQZVJMUmY2Q0Zockl1bzduVTkyZk5PT29JZ2tLWUF3UlgvOE9PSEM3RjV4?=
 =?utf-8?B?dlBiUkl1WmQrdEdPZWxUV0xOME1xdFErMFNBb0cxRHBjcWZTSjlaVGNQblp0?=
 =?utf-8?B?K0ZibGVPQTFCc3NOa29QMTE5ZVVuU202dW16RU9paG5MTkdacXA1ejRrbTV1?=
 =?utf-8?B?RXc9PQ==?=
Content-ID: <69912113A67C8B41861DEA5DD1FE5089@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60612981-bf1b-440b-31bd-08da746f33de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 10:10:18.6269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13Mo+XwaQw/FyhTsprvnAvvSo7lFfPUmtYnd2fCcH/5hOVwUqhexNDUXfD9AkTSDGYsSGs3C0c4dwgXJRh6heaGdqqGwhWRZVQntHJ6l7fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7730
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Do we have some simple way to get the current
 cgroup.procs path?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljaGFyZCxMaQ0KDQpUb2RheSwgSSB0cnkgaXQgYWdhaW4gYnkgYWRkaW5nIHR3byBjZ3Jv
dXAgZnVuY3Rpb25zIGFuZCBzdWNjZWVkIGJ5IA0KdXNpbmcgYXQqIHN5c2NhbGxzKEkgbGlrZSBh
dCogc3lzY2FsbHMgYmVjYXVzZSB0aGV5IGFyZSBzbyBjb252aWVudCkuIEkgDQp3aWxsIHNlbmQg
cGF0Y2ggc2V0IHRvIG1haWwgbGlzdCB0b21vcnJvdy4NCg0KK2ludCBzYWZlX2NnX29wZW4oY29u
c3QgY2hhciAqY29uc3QgZmlsZSwgY29uc3QgaW50IGxpbmVubywNCisgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IHN0cnVjdCB0c3RfY2dfZ3JvdXAgKmNnLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3QgY2hhciAqY29uc3QgZmlsZV9uYW1lLCBpbnQgZmxhZ3MpDQorew0KKyAgICAg
ICBjb25zdCBzdHJ1Y3QgY2dyb3VwX2ZpbGUgKmNvbnN0IGNmaWxlID0NCisgICAgICAgICAgICAg
ICBjZ3JvdXBfZmlsZV9maW5kKGZpbGUsIGxpbmVubywgZmlsZV9uYW1lKTsNCisgICAgICAgc3Ry
dWN0IGNncm91cF9kaXIgKmNvbnN0ICpkaXI7DQorICAgICAgIGNvbnN0IGNoYXIgKmFsaWFzOw0K
KyAgICAgICBpbnQgZmQ7DQorDQorICAgICAgIGZvcl9lYWNoX2RpcihjZywgY2ZpbGUtPmN0cmxf
aW5keCwgZGlyKSB7DQorICAgICAgICAgICAgICAgYWxpYXMgPSBjZ3JvdXBfZmlsZV9hbGlhcyhj
ZmlsZSwgKmRpcik7DQorICAgICAgICAgICAgICAgaWYgKCFhbGlhcykNCisgICAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KKw0KKyAgICAgICAgICAgICAgIGZkID0gc2FmZV9vcGVuYXQo
ZmlsZSwgbGluZW5vLCAoKmRpciktPmRpcl9mZCwgYWxpYXMsIA0KZmxhZ3MpOw0KKyAgICAgICB9
DQorDQorICAgICAgIHJldHVybiBmZDsNCit9DQorDQordm9pZCBzYWZlX2NnX2ZjaG93bihjb25z
dCBjaGFyICpjb25zdCBmaWxlLCBjb25zdCBpbnQgbGluZW5vLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgc3RydWN0IHRzdF9jZ19ncm91cCAqY2csDQorICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBjaGFyICpjb25zdCBmaWxlX25hbWUsIHVpZF90IG93bmVyLCBnaWRfdCANCmdy
b3VwKQ0KK3sNCisgICAgICAgY29uc3Qgc3RydWN0IGNncm91cF9maWxlICpjb25zdCBjZmlsZSA9
DQorICAgICAgICAgICAgICAgY2dyb3VwX2ZpbGVfZmluZChmaWxlLCBsaW5lbm8sIGZpbGVfbmFt
ZSk7DQorICAgICAgIHN0cnVjdCBjZ3JvdXBfZGlyICpjb25zdCAqZGlyOw0KKyAgICAgICBjb25z
dCBjaGFyICphbGlhczsNCisNCisgICAgICAgZm9yX2VhY2hfZGlyKGNnLCBjZmlsZS0+Y3RybF9p
bmR4LCBkaXIpIHsNCisgICAgICAgICAgICAgICBhbGlhcyA9IGNncm91cF9maWxlX2FsaWFzKGNm
aWxlLCAqZGlyKTsNCisgICAgICAgICAgICAgICBpZiAoIWFsaWFzKQ0KKyAgICAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7DQorDQorDQorICAgICAgICAgICAgICAgIHNhZmVfZmNob3duYXQo
ZmlsZSwgbGluZW5vLCAoKmRpciktPmRpcl9mZCwgYWxpYXMsIA0Kb3duZXIsIGdyb3VwLCAwKTsN
CisgICAgICAgIH0NCit9DQorDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KDQo+IEhpICBSaWNo
YXJkDQo+PiBIZWxsbywNCj4+DQo+PiAieHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbSIgPHh1eWFu
ZzIwMTguanlAZnVqaXRzdS5jb20+IHdyaXRlczoNCj4+DQo+Pj4gSGkgTGkNCj4+Pj4gSGkgWHUs
DQo+Pj4+DQo+Pj4+IE9uIFRodSwgSnVsIDE0LCAyMDIyIGF0IDI6MDIgUE0geHV5YW5nMjAxOC5q
eUBmdWppdHN1LmNvbQ0KPj4+PiA8bWFpbHRvOnh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+IDx4
dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tDQo+Pj4+IDxtYWlsdG86eHV5YW5nMjAxOC5qeUBmdWpp
dHN1LmNvbT4+IHdyb3RlOg0KPj4+Pg0KPj4+PiAgICAgICBIaSBSaWNoYXJkLCBMSQ0KPj4+Pg0K
Pj4+PiAgICAgICBJIGFtIHdyaXR0aW5nIGEgc2ltcGxlIHJlZ3Jlc3Npb24gdGVzdFsxXXRoYXQg
cmVmZXIgdG8ga2VybmVsDQo+Pj4+ICAgICAgIHNlbGZ0ZXN0IGNncm91cCB0ZXN0X2NvcmVbMl0u
IEkgbWF5IG5hbWUgaXQgYXMgbWVtY29udHJvbDA1LmMuDQo+Pj4+DQo+Pj4+ICAgICAgIEl0IHRl
c3RzIGNncm91cCBtaWdyYXRpb24gcGVybWlzc2lvbiBjaGVjayBzaG91bGQgYmUgcGVyZm9ybWVk
IGJhc2VkDQo+Pj4+ICAgICAgIG9uIHRoZSBjcmVkZW50aWFscyBhdCB0aGUgdGltZSBvZiBvcGVu
IGluc3RlYWQgb2Ygd3JpdGUuDQo+Pj4+DQo+Pj4+ICAgICAgIEkgaGF2ZSB1c2VkIGx0cCBjZ3Jv
dXAgZnJhbWV3b3JrLCBidXQgbHRwIGNncm91cCBvbmx5IHVzZQ0KPj4+PiAgICAgICBTQUZFX0NH
Uk9VUF9QUklOVEYgdG8gd3JpdGUgdmFsdWUuDQo+Pj4+DQo+Pj4+ICAgICAgIEhvdyBjYW4gZ2V0
IHRoZSBjZ3JvdXAgcm9vdF9kaXIgbHRwX2RpciBwYXRoPyBTbyBJIGNhbiBvcGVuIHRoaXMgZmQN
Cj4+Pj4gICAgICAgYW5kIGNoYW5nZS9zYXZlIGVmZmVjdGl2ZSB1aWQgYmV0d2VlbiBvcGVuIGFu
ZCB3cml0ZT8NCj4+Pj4NCj4+Pj4gTm90IHN1cmUgaWYgSSBmdWxseSB1bmRlcnN0YW5kIHlvdXIg
cmVxdWlyZW1lbnRzLg0KPj4+PiBDYW4gd2UgYWNoaWV2ZcKgdGhpcyB0ZXN0IGJ5IGNyZWF0aW5n
IGEgdHdvLWxheWVywqBzdWJkaXJlY3Rvcnk/DQo+Pj4NCj4+PiBJIHRoaW5rIHllcy4NCj4+DQo+
PiBJIHRoaW5rIHlvdSBtdXN0IGhhdmUgbXVsdGlwbGUgbGF5ZXJzLiBPdGhlcndpc2UgeW91IGNv
dWxkIGJyZWFrIG90aGVyDQo+PiB0ZXN0cyBydW5uaW5nIGluIHBhcmFsbGVsLg0KPj4NCj4+Pg0K
Pj4+Pg0KPj4+PiBEb2VzIG9ubHkgdGhlIHJvb3QvbHRwX2RpciBtYW5kYXRvcnkgZm9yIGNvbXBs
ZXRpbmfCoHlvdXIgdGVzdD8NCj4+Pg0KPj4+IEl0IGFsc28gbmVlZCBnZXR0aWQgc3ViZGlyZWN0
b3J5IGFuZCBjZ3JvdXAgbmFtZS4NCj4+DQo+PiBZb3UgY291bGQgY3JlYXRlIGFuIGFjY2Vzc29y
IGZ1bmN0aW9uIGluIHRoZSBsaWJyYXJ5IHRvIGdldCBkaXJfZmQgZnJvbQ0KPj4gY2dyb3VwX2Rp
ci4NCj4+DQo+PiBUaGlzIGlzIGNvbXBsaWNhdGVkIGJ5IFYxIENHcyB3aGVyZSBhIHRzdF9jZ19n
cm91cCBjYW4gaGF2ZSBtdWx0aXBsZQ0KPj4gc3RydWN0IGNncm91cF9kaXIncy4gVGhpcyBpc24n
dCBhIHByb2JsZW0gZm9yIHNlbGZ0ZXN0cyBiZWNhdXNlIHRoZXkNCj4+IG9ubHkgc3VwcG9ydCBW
MiwgYnV0IGl0IHdvdWxkIGJlIG5pY2UgdG8gbWFrZSBhcyBtYW55IHRlc3RzIGFzIHBvc3NpYmxl
DQo+PiB3b3JrIHdpdGggVjEuDQo+Pg0KPiANCj4gWWVzLCB0aGlzIGJ1ZyBleGlzdHMgb24gYm90
aCB2MSBhbmQgdjIuDQo+IA0KPj4gVGhlIGVhc2llc3Qgc29sdXRpb24gSSBjYW4gdGhpbmsgb2Yg
aXMgdG8gd3JpdGUgYSBsaWJyYXJ5IGZ1bmN0aW9uIGxpa2UNCj4+IFNBRkVfQ0dfR1JPVVBfRUFD
SF9ESVIodm9pZCAoKmNvbnN0IGZuX3B0cikoaW50IGRpcl9mZCkpIHdoaWNoIHRha2VzIGENCj4+
IGNvbnN0IGZ1bmN0aW9uIHBvaW50ZXIgYW5kIGV4ZWN1dGVzIGl0IHdpdGggdGhlIEZEIG9mIGVh
Y2gNCj4+IGRpcmVjdG9yeS4gVGhlbiB5b3UgY2FuIHVzZSB0aGUgaW50ZXJuYWwgZm9yX2VhY2hf
ZGlyIG1hY3JvIGxpa2UNCj4+IFNBRkVfQ0dST1VQX1BSSU5URi4NCj4+DQo+IA0KPiBUaGFua3Ms
IEkgd2lsbCB0cnkgdGhpcy4NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBZYW5nIFh1DQo+Pj4+IElm
IHllcywgSSB0aGluayB0c3RfY2dfcHJpbnRfY29uZmlnKCkgbWF5YmUgZml0cyB5b3VyIHB1cnBv
c2UsDQo+Pj4+IGJ1dCB0aGF0IHdvdWxkIG5lZWQgYWRkaXRpb25hbCBmdW5jdGlvbiBoZWxwIGV4
dHJhY3RpbmcgdGhhdC4NCj4+Pj4NCj4+Pj4gVGFrZSBhIHJlZmVyZW5jZSB0byBzZWUgaG93IEx1
a2UgZ2V0cyB0aGUgcm9vdCBwYXRoIChpbiBzaGVsbCk6DQo+Pj4+IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvcGlwZXJtYWlsL2x0cC8yMDIyLUFwcmlsLzAyODc3Mi5odG1sDQo+Pj4+IDxodHRwczov
L2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyMi1BcHJpbC8wMjg3NzIuaHRtbD4NCj4+
Pg0KPj4+IFRoYW5rcywgSSBwcmVmZXIgdG8gdXNlIGMgYXBpIGFuZCB3aWxsIHRoaW5rIGFib3V0
IGl0IGNvbnRpbnVlbHkuDQo+Pj4NCj4+PiBCZXN0IFJlZ2FyZHMNCj4+PiBZYW5nIFh1DQo+Pj4+
DQo+Pj4+DQo+Pj4+IC0tIA0KPj4+PiBSZWdhcmRzLA0KPj4+PiBMaSBXYW5nDQo+Pg0KPj4NCj4g
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
