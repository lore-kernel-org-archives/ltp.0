Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33E1C433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:56:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEE713C6FEE
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:56:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CF963C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:56:30 +0100 (CET)
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com
 [68.232.156.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BCA010005A7
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:56:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641549390; x=1673085390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QEHf0jXCfComN6B+ncz/1zQlpKfyaSzsEWBMMhrZKzc=;
 b=xGiSBziMbBLUwP5OtbVNk5VqYkS/YNxFM2MnaOH3eN6lhBreOCaJD8Ej
 CGu2Pp/0J+dgrEISrnJ4nNiJVfGscQRC0IEU05d5/qcmIDeot3JmpsrxR
 UQJ4PGu/JEmRxH45dKlASZ7XutCTjtbVb73sZts5qdg/jof2EbcMX24Ds
 sfLc+HFbcADDFyMioqQYLk9mKT9tYIaiN0ZLfDR4UxVZanDD3c1j4Py1T
 gxeVQBqcgdT1cvKvlj1r4yn0HYy+yqEHsxHdQ8VYIXJz8wyiI6sQaydvc
 G4m0po4gnaGT7MqBTgxV4/VEKFqHRFpWDcia/7HAUswl1r1ocyzMFquXW g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="47157419"
X-IronPort-AV: E=Sophos;i="5.88,269,1635174000"; d="scan'208";a="47157419"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 18:56:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/3PqmFVy/p0Pjyao0DDBSSORfVxtog2T7DjUWUUfF5+0/jNN91uHKfB9z1mq0qbvhT3IhaXWarqcAnKrk25bJFUHZfN+P+q3chML6cYk5hVSG251qSY9YLhtueNVGu5BMRCRwsWoeeEpIM/2kzAkRgi6OBvZhbqyCX6d+U/ViHJuEbmemixcQYY/0OcGOWuWYvtU/1PmcsAi16DiaReES9lfT2uzEggQECDXoSA15nvsmJbXlZyYk1x67dm0QfilsPL1BGGzsuy8gNAkHs0NK/iaXVkBpcklaWZljc6aAkSF+4ADK0rNUuBLS7SmuuyXO99E8GOoyBtp8YRypWxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEHf0jXCfComN6B+ncz/1zQlpKfyaSzsEWBMMhrZKzc=;
 b=F8tykWkQOTZc7mB5noehtlkQonu/X2PZIgrJ5auK/B/XmLzo1vbhZasM7d6eUqrfojOlWpkY8qjfQKgAHHzK1RaWslQg/AAxNEoxQqyCCcranfpp/cajG/8qHaYF/tHXeUld/8h7qKs/O8wNTm+XVZEh6YOqCFudH8brHqxPHwYMgTBtRdMSHZO+Dh3mVC4wBTQ7DgPJ4vkwdmDow5UwMm1cOR7/kTtxXPW8+y6LZ5CFp+AVaZo95QRepYtVAgUOAEkG7PUPh5KIO1A5BAS+ST7BGUUi9hvokTCvV3PcucBnPYllI/pEaLZXTlEB3re+HCCbERKsrN2U+fNsSZHPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEHf0jXCfComN6B+ncz/1zQlpKfyaSzsEWBMMhrZKzc=;
 b=bJ7fXLq89ko8Dv/uY7Nh+G0S0pG71XGIvhcFeX6wbJiO3jSupPlkvNuj3s+cL5BD8J7HGWTpEHXf1wWI9LbNnFOwjIV/6oJo8CVMBBPn8LbHouLxqYM5+VwfJQA+bKcSajv1u1sKIzKjMUPJZR5bYHjRT/BS6xyU4+IrkGUFiMY=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TY2PR01MB3564.jpnprd01.prod.outlook.com (2603:1096:404:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 09:56:25 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 09:56:25 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
Thread-Index: AQHYAt9Ym4q3iJDhlUyEGKaxT+lELKxV2LUAgAEWM4CAAAQggIAAMLkAgAAXlQCAAAOiAIAAEiOAgAADAoA=
Date: Fri, 7 Jan 2022 09:56:24 +0000
Message-ID: <61D80E73.3030105@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
 <61D7F9AA.9020401@fujitsu.com>
 <CAEemH2dryR-JbgK51VUvNbZbGgw_kK0oA3ry-W29zkBd7uR8ww@mail.gmail.com>
 <YdgL7VPflx6N5BfZ@yuki>
In-Reply-To: <YdgL7VPflx6N5BfZ@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fd80ae9-47b7-4eb5-3ac7-08d9d1c3f779
x-ms-traffictypediagnostic: TY2PR01MB3564:EE_
x-microsoft-antispam-prvs: <TY2PR01MB356415B72D83E9776290845FFD4D9@TY2PR01MB3564.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eywsKDepvsQ8d03vmd/tZUfTfQIGe/RkU3hitEYSEVISEtAJRhhga2rTc96huiPn0uuxhvy86VckY+MRFvaQ1RSw7y50/sVz1cfVTFTmOgZ162DU1gaasyLs9Pu2kuYynVtndAxDg1ha81WdyE+/5JwsiKZLrumNiCkVOSV02G330PzgaOlc1e0I6oTdAxE1a2SeTg0v0+kgJb+DESUzfBrKAwvSdqscF94CtAUprQq5Z0pmKl+1R8GoHAglRCo4QBAoh4y8vHnBEqGdyrwawfpNNz11rnxWSFfVGtmf650rdRTIGitjMR/KIYPxsjRsAevRYvrUzfvMhdmVB0NSJ7mZEWrvetwAdsa0FZlP5+euaUr8sM2UHzocPq8HAVDomcgXyIrROwrubY9YLurflnEmsW+FfE5Z9TzUvXu6htMELzn70UXwZGsemDDDP9WX+gwkc4wm8im6Yy7SWsKWzKLfighl0q5M9bB/JHSJK34TEy0pzijb7dqZyMTT7XcABb27Sfb/pb7q+Pa+LqJ8IdrqMNXc5F3VBt7l5BUxGDXnyYxhAKDknJ/CYW8bdu/pWO1VJlDlA89O809olQ9iIVLDQqAB6Y311+G1hRcWWPxIDgJLvuD31aIA2TseqpIEEtrI754vtTIEJsi5y07/4MurmghD2oMQv6hKxeorFQ7ml9XtQAQY10mn9wOavtmlhgBz1GJm7mF2XcU43b4l+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(2616005)(33656002)(85182001)(54906003)(76116006)(8936002)(186003)(2906002)(8676002)(38070700005)(36756003)(4744005)(6486002)(26005)(66476007)(66556008)(6512007)(316002)(6506007)(66446008)(508600001)(66946007)(71200400001)(5660300002)(87266011)(122000001)(38100700002)(91956017)(82960400001)(6916009)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OXpKWjJOVlpMOXJGUWU2U2kwclBySjROenorUEtqOHh3QnE0eXd0cDdwQ28w?=
 =?gb2312?B?d3JqN3N3K0FxNGxXd1JxUld4Q2RkTm05UGhEcTFJWGV0UHJDVG92Tk1LNEVt?=
 =?gb2312?B?RDdSSE5mYVNpcG44ZE1QT3RIL2lWY05sSk1wMXUyMG5sc0hybVZiUE4xemtt?=
 =?gb2312?B?L2l3c2hZa2pQZnIxQkgxT1lXT3dvZEJyMHNPSU1KelMvRjFDYm9UK3RnZnJz?=
 =?gb2312?B?enJDdUhVNEJtTkRPQlJxQzVPV01qU2dTQVJZU3JSeFBrcEtIMDJxWWF2aEh5?=
 =?gb2312?B?STkrM2V3NE1LVXdzWC9IZWoraTM4aFpQUUZiMlF0clJNQktLdXBQY1VnOUxu?=
 =?gb2312?B?S1VnN01kd1QrbW1mUWZtZTdIT0doM0h2MG5WTTlFUnN5K1pJbGY3aURjR0RH?=
 =?gb2312?B?MFpMY3RzTGZoVmU5S29ab09HOGhidzlYVnZKUWxTdGsvLzlnbWRYYVNra2w4?=
 =?gb2312?B?Mmd3M0RVSFRrNUMxcnhiaGIzWTBnc0JFUG9uOWZjb2VZQUZEdjUrWTZyb2ZN?=
 =?gb2312?B?L3l2NUt6L3liUlZuNWFyVURNc24reTFoWEtSUEFBZHpnSHhOVDhFTEVQNVgy?=
 =?gb2312?B?RXU2eFJrcnUvOFF5dkxmVWRmZXZXbEZPMmRNWUdOMkN2elhoMW5FeVoyQjlJ?=
 =?gb2312?B?dW5VTUswNHU0T0Z6cjZPcTBWaXRHbzM5NFZDL3o4T3k3cmhHRk9zdFdCZ3pR?=
 =?gb2312?B?Z3BJbjY0TTBKcFl3Q0VqTzBxbm85bStVMWliZ3d0YkNRL3BKOGQwSmFkSWpn?=
 =?gb2312?B?TXVLWHdsbTMveXlXWjUxMm5PWFBIbVRuM3NSL2JHQ3dXckZUVUZMUTNnOU5J?=
 =?gb2312?B?T21BcURQOGQwRy9nZWpYdWlTaTRvY1RFMFl2Vm9kVUFBNUVDRjVsbnNXNG1E?=
 =?gb2312?B?clAra0ZYZGJsd0wxdnltYWdMR1V1K25NRFdiRkFWL2p2bWVMYXNtYXdzbk00?=
 =?gb2312?B?dGIrVVpWeTAxUDUzWVNYVmM1dnUwcnp4MDYvY21wTEFQTXVSbjRyZHZNcnJL?=
 =?gb2312?B?aWlVbTRURjE4OWlYZXQ0V1lXaXozZ2NocytkdUZFOVAramtUMWlFTmc4b3Bx?=
 =?gb2312?B?djNtWjdGR0lnMExZK05WWFNCSE0zWjBtOWIwTk1uayt5OStXL1A0TmhlQXpO?=
 =?gb2312?B?L1c5ZXRaNGNzTzM2MzZNblNlMlRxUU81N2ROaGN1SmJWTzBGQ2NqdjFQV1NQ?=
 =?gb2312?B?eDNMMDExdUxlVTFEaWE1MGdSMlBtcmpHSngrVHpnWkE4dFpNMXRkRmlucjJj?=
 =?gb2312?B?M2NqdDhSRkxmcHhxMVQwdWlOc2tjRjJnL2g4YjcwL2Z1YVFQbTdpbVdzcmNy?=
 =?gb2312?B?c2krWUdzQkNEdkhHa2h4KzVRUUpVZ0VGVVh4Z0tsYnV6dVJFOElRVnpCdzlF?=
 =?gb2312?B?NlFXNy9wMkttQy9JK1ZlQ1hTb0lGd1I1bzJWU2RMWnZ3aVF2Uno5UWkyOXZi?=
 =?gb2312?B?eTFSeDBrMDkrK1UwRmhPUldmNFZLaWdNeWVodzc3QWJoTmlRV1duVWJ3Z0cz?=
 =?gb2312?B?bXZtMS9QbXhWZlVsUXVPQmhHV0w1Ujc3TWpKZVBFZndpTTJwV0NCZHhBYzMy?=
 =?gb2312?B?U1BPTklKbkVwM2c3amMzUTVLcmdNOVlyVU12eS9oODM2WVlHd3lHL2lJRSs5?=
 =?gb2312?B?MTJ0a0NzcHEwazVSOUZqZWt0aDJFRmZvZGVudUpNb0x3UWtYVnExSC9PVFc5?=
 =?gb2312?B?dDJRai85dyt4dUt0SFpRQzNrWTZhbkFSNUI4Rkw1elZFTkx2K0ErSTg0dUh2?=
 =?gb2312?B?VE1aSnIvc3BFL3QzZ3NLa1EwT3NIRkRFWmxaRjJDYkdKTjZQOS9XbW1mWVpu?=
 =?gb2312?B?UW1hcUhDU1N1TDFSbXpQd0dybW1tV0l5VmhhUEVBYmR6L2EwRGh1dVI3SUJK?=
 =?gb2312?B?dENCZ1hWeWFMUCtlQWxHT1BxaENhUVJFS3pVTkEyYWNteVRYTVRNQ2hNM0py?=
 =?gb2312?B?dlVhbm1HVFloRGg4TEtaYndkMjZ6RXdYUVlEdmZkUFovSXFOb01GMG1zRzl0?=
 =?gb2312?B?TnZYWHdYc0pUNVFIbzJxTXV4bTRGQkNEK1psK1NqbnloTmREY3ZianlIOE1y?=
 =?gb2312?B?ckhUZlNmK2g1c2hWZXdnRG1LV0JsVHgyQVJjQzVVelBzK2FFdURaSHB3VW0w?=
 =?gb2312?B?WEZmaktIOFRiaGY1dURuL1psWUlMUzRhZ0x4c0NhalNYcGI4NXBjRnUvNVZH?=
 =?gb2312?B?d3hYU040QVFKcDh0YURMTExkT1RpdHo5YmQzSUpHaVk2cG1EZFppbHhORllw?=
 =?gb2312?Q?rMOKsvGVYnkmhULGJUHQU2MzlfQQuj4wPCD47gXqus=3D?=
Content-ID: <0480B5A804A8A44A8D89B9B6BDD7C5F2@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd80ae9-47b7-4eb5-3ac7-08d9d1c3f779
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 09:56:24.9443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybn8KJynJOLROKxm4LjAavAU3KK0Gv5SyXhg/gRIyWg76N8y0dbH0X3VyW8XPU0gFPnsWL+P9Ikr3OukI1JN5QGeLUPiEMO+iFIRV+FcSMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3564
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hi!
>>>> Maybe we can combine the arguments into one kconfigs struct and
>>>> just do once check? something like:
>>> Yes, it works well. Thanks.
>>
>> Btw, seems const char *kconfigs[64] is not enough for a long
>> string combination, you can dynamically allocate memory
>> according to arguments size. Or, just raise to a big number.
>
> Just loop over the string twice and count the occurencens of IFS
> character in the first loop.
Yes.

All,  I have rewrited this patchset, I will send a v3 on next Monday.

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
