Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6CBC4332F
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 09:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC383C8F9A
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 10:42:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90A073C8E31
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:42:29 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE2681A000A7
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 10:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1639734149; x=1671270149;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=C9cW71kE5f40fnzJFId3VJHnoz4zVUvQUwGOtWWxFZ0=;
 b=KzfY3fJNjZkA65y0Q12qVD0+CBpE8PfHcT3cIeZ4zkPWlIFeTHgnLOSe
 1ABJ5iUIIKPAXkoBUxiSzzfDTuSlujLSbZ/ANkkifBN4l7XSSkNs9jg2g
 XwSGxXihJUx6KlR6vLtFr+eHLB4BlFKewBWMV5Sz6usbdL206XEbQNT8l
 IgY4lckCwG08jNX40uz2W8Y+BbClAnTFqHInsU0ai79VFiI8crBhVEzeZ
 7X0Vp6qBpKYkLX8zMjOF6r+POUeJZhMlHK08aCI/TubQZp0J50srk0gFR
 z+c3EJwXtT1UsO4ZDenaJ028idPM3HxrOygzJ38mruXAdl+mvJOCB/q7r w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="46133621"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; d="scan'208";a="46133621"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 18:42:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBlRrz7aLGRkFEz4jRlGG3mCQO7ljg7cc9agnZ1rBf5urgt/PRlyHcCnckZfl9nfcekLnqNBB09zc/k84+LTT8iO7t+NQLuB/nJEZx5s2zXCxX31jZ76Nbt95EYO9Y6JEepZc2tATR654MsXa47WuUkFNWRR4cMyJsDysXXH/ne1Md1zUjOMqHVWcqBgNIHp0DhHP17srBns5aAOV6+rGYYtOz1twGJXzsrElsqaHD6akTPa5HjNmbuppAc8UxIgMixi96MLDlGBu2T7aETd3DjJXv7yCeK3sfrl2aXpNQGDr0puyKmYHvqCxzrFyUKhXQtBSbVCaa1Rrhve1eB/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9cW71kE5f40fnzJFId3VJHnoz4zVUvQUwGOtWWxFZ0=;
 b=boP8Oa7mq4b/qrGVBeKxzhXm7jDvW98SnedN8fCN6Z9Zvz1Hat3bmyFltH0GbKsJgZqPLPVAa+WhBtoWzGBGDanQ4hKrlvCKr2BexVpaXrlbUdMgcT7C9Nz3fH9BZoKp12xI95Jzq+i/suHYICBEX60BHXKelcnsgENo9UNtAKtY63bxXYFkiEbFCaHtSW+daqQ3nPQb5qXUhY1l4yLLMfQTSBBFwDZbxdTB1kKQJ2H37Et4v6jsOrAqGTWdbpm51Cs9ADj2zj1azLrkbPkFgoL+U19IC87bpAbMXr/+OuU30Z93qb6rai5MxJ2fpbqU3Iju3waG/IxyurS8oS+H6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9cW71kE5f40fnzJFId3VJHnoz4zVUvQUwGOtWWxFZ0=;
 b=ZlGvwiZOOg0TJNw2k55G9ABOE7dKkksxDtSK4OiT2qPH12qj28sooWHnkqt/xi4Fiu7Qf/Xiy2qECsDn8KzT2FdQSmg/ywTS+d4NQTd6KBmir73I251ZruUBU03hqsaAi2ihyBeOekGvoijs2t58IJnQXLBF+FH4aOrSQUxcPNI=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB6009.jpnprd01.prod.outlook.com (2603:1096:402:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 09:42:23 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%9]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 09:42:23 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/4] zram/zram03: Convert into new api
Thread-Index: AQHX8YRPtDeIzrMYE02b6p5GeIUhdqw2W4KAgAAWRAA=
Date: Fri, 17 Dec 2021 09:42:23 +0000
Message-ID: <61BC5B84.6010701@fujitsu.com>
References: <1639552849-2251-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639552849-2251-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbxI10d517WiDMHW@pevik>
In-Reply-To: <YbxI10d517WiDMHW@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72da50d8-f64e-4496-e995-08d9c1418768
x-ms-traffictypediagnostic: TYAPR01MB6009:EE_
x-microsoft-antispam-prvs: <TYAPR01MB60091049314575463C2C725FFD789@TYAPR01MB6009.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZCc5hbumnj/TilzStQ+Ak1WOyqEzlHfxVLjdwiTFVXRnIdFkMZ54dmZntB5/SVnaFiwDc8PfNMp1nBbzdyXXDwOs2F3ZefF4hqVGGarF9t+U7m7026GZoZcf8a3XxYlwJKJSQQsEscqKzri45kqcs/VBz0MZdbMeNyMDtbpaDY/h0J0nPSowyCBjqnbYlngfNlRI9vAByI53AP4ktIL5NGJb9WVWGm+XoNgrR6gm2nNz1GemEtJwrf/rfxAzaueqegLmHAvKA0/veQa3YfThJsJDIlmpbAjlNxMoK9B0TlFNY3V2tnp3RatlPfqxRFVGXUIbkAW7mb3a9S2xonqd+BpRz7PBNedL+ly0COkXU5fb/ljhhTAx4Gb/sFUGwUv+t02PR/UingG5NUMATaxhUaeIOkc7uP7hq/p8ILBIHkhtyYuGR9nuUNHsGmiGhyzD/U4v4luwaF237L32wJL+d5XSfIf+GmecxX9Cl9STLwbBUr53egCSdVBC6DDNmKX/SkiFuHhNIw1agka8I2vr6W7D97zE9bpizzVbxH554o4/6zf1fgXdeeRMVJrgYaGc95HT9oIFlZb6vdeziSkdMWBknajKE3vmSB7C0yVDVPlpyaH7/ol8ZKS6AG308TqtMAS/rwESD+MDZpKj6unbLQllnEwi6dJnm4okkud3EBym/HGdu9mJdrvPZH07WN2ymMxJyZIPKdfM2gcvqzVOTPGylCqxrmEQGSkyVJBZqk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(82960400001)(71200400001)(4326008)(5660300002)(33656002)(66946007)(66476007)(64756008)(6486002)(66556008)(6506007)(66446008)(8936002)(38070700005)(508600001)(2906002)(87266011)(76116006)(91956017)(8676002)(26005)(6512007)(6916009)(86362001)(2616005)(85182001)(83380400001)(38100700002)(36756003)(316002)(186003)(122000001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U29oVGZrbWsxNnlyN2t2UjZnVkZEOUFQSlloZ0NIdW1lTjVUSWdoc3dlTStL?=
 =?gb2312?B?SzhaYnI0RW5UazdwUFNhdzRKSldnZGZ3SmlMVXQ4Y1VaelU3MG02RFJaZlpE?=
 =?gb2312?B?VmMxcVBNMzZsVERMZ0JyQ25KWkdkZFQxTXp6ZkhJRU0xNXBlWVc2L1RhZTdT?=
 =?gb2312?B?S2tIdXlzMGQvYjA1VWxqNEtNQjFMZ2VqUU5XUU5naXl6U1RXR3VuM3VkclFY?=
 =?gb2312?B?ZlJvdWJBbXdPMmZzWkd2YlBOc283VHJLeXN4SU9KcUM2ODhOZytLRlZoMnJh?=
 =?gb2312?B?U1I3S2dNSzZhQ0x0K1NRSEFiSEsrNmcvWWMyQUpCZDZJM3ZGVVRacXUzUm9M?=
 =?gb2312?B?aHJxc1pjOVJhN2NKL1NEZkFuMVBVOTE5WXBieVdTYTB0V0xvUzg0bVByblZw?=
 =?gb2312?B?c2NiRTRjUzVFMXdaTldWWFZyV2FuODhBLzUyT09NdU1qYjV4bzRSUDJXdU11?=
 =?gb2312?B?eTQ0dEdOUTJVTWZpSzhOeFJkaE4zTFF1VHB4NnB4M1dEb3lFQkxPelBwUm5J?=
 =?gb2312?B?Qkh4Z0ZSMTBSbkxBNlh1Rk4rVVVXRDZEL1dmUU8vWE5DcG15L1RhdjV2UjBz?=
 =?gb2312?B?dDMyNmluT0c2aEdWRW5JNUsxQTV6bVNudmdlZ3M4M3VzUUNGVXpWZ0JreFZS?=
 =?gb2312?B?QjRhT0NYOUpSbmxRNlBsK2JLMGFHS2p0UGxObVM0K1ZEclpYUmZiK3N5a2lr?=
 =?gb2312?B?TTNCK0MzUTg0M2NPQmp4bHQ0b1lJdHVZR0ptL3pCRHJSN2FpR0kwNVFPYit2?=
 =?gb2312?B?UU4xZnFXTTU0T2dlTVBLYWhuRjVneEc2eFhVekhoN29yN3ljazcwOU5WamUx?=
 =?gb2312?B?aUFGYnN0ZXBCTFhlb2ZTZVdUOUpQZ29sMmpDL1o5VTNWWDJaaW1lK2NHTTEr?=
 =?gb2312?B?TEkxUDNpclBLV1BVVFkvVDNjUC9pVDg3KzlRNUNlSytmZHprMktvSFVEZFZE?=
 =?gb2312?B?cE5uL1ZleHdqekNuT2liSnVNbFl1cVBFaGdINTJINzFNTkZLVC9jTzhKMWZM?=
 =?gb2312?B?OFNmdzArR2hGMkJucnhQUzFvWTdKTTFicjBpVUlSZTI1NEpCNGY2c2lHTzZ2?=
 =?gb2312?B?NjVycFd5OHUxUUF2V3g1TzNLWS8rSDNIc0NoUi95S09zd0tmWjBjVGUzVUZs?=
 =?gb2312?B?bU9lczg0a3B3OE55OGxhSHhWaVc1ZmkvSzZNeFBncUh5ZzgvQWZnL2tjN3pa?=
 =?gb2312?B?WHFNYXVLVmw5MFdqL3UvaDYvK3VjdXZhKy8zUEx2M2NFKzhkMVhDekpDUUtI?=
 =?gb2312?B?NHdCbDQzTmNTVVdJUUEyb0pMSHNkbWFhWTl4aWk4NEZ5Y0JEMElmaTVYNHJP?=
 =?gb2312?B?blBTdkNyQUxBaTFZNjlQclVvQkVYRmJhb1hVWDNYWVVyclpiaG85eS9PcXJh?=
 =?gb2312?B?VWZ5VXM3cXR5TFl5TURIQWxQN25xTVhEeGRDNThFMGFSa1YxT3FSdFQ1SXlt?=
 =?gb2312?B?eVdtaENqeWZqRlN3a2pnVE44ZFVySy8rSkwyWTRTM3RJQnhMTW5QNXlITmNO?=
 =?gb2312?B?ZlBzbGFBS3I0TWV5Uk4yNFdTVmFSbVYzTlJhTDJNdHlRb0s4bHh1VlpMV3No?=
 =?gb2312?B?Z2w0cnR6UUxtNnd2R2tocXd4NHBkVWVlT2pNd2ZYbGQ2ZkU0MkI5dWlHYUYr?=
 =?gb2312?B?cnhLYmpwL21qTVdISDZqNkJKZ2FhUDVYRjBTMmNkT1VGZ1lieUFEdEtIeEhQ?=
 =?gb2312?B?Qi9aazVCVDRDY1Z5MHZRSUxEWDdaNEViL1MrazZpZk5OVG5waEpuWXVXQ081?=
 =?gb2312?B?eDA2SitHUDNUaDZYMHF3Mm0rWTNuZEhsczE4Y0NRZzFIeEJZd3pkYklQRS9o?=
 =?gb2312?B?U1E3TWJ0bjZEVCtKVlN6SlEvSGc5U3l5ZUZoa3Q1c2lKd0YzWW1kWURQaHht?=
 =?gb2312?B?cnNZSW1jejF3dlkvOWdEbWVyQmFkMURqNXoraE5HM291RzN1NTVZMXZVVm00?=
 =?gb2312?B?SXRkYWtzV0pxSkJQa0VnaUtEWjlFUUN4VkovTnBxNUJRckxIVHZuR1ZBZVFx?=
 =?gb2312?B?OURML0Eyc0xXQU4zSnVsYWJEaWVaT3VFK3ZzYUNjS1pIWFI4cCtSTDdxZitF?=
 =?gb2312?B?eHFOcUJ0QjhVUUl2T1RrcXZ3WkpWT0xxQmxFK0FXQXg2c2ZWU3A1ZU1xVDVQ?=
 =?gb2312?B?Ti9vRmdxOHhEbzcrWVh3WkRIam51UzZmK2dpY25zZ2orRzZBUzJCRUt5cjU4?=
 =?gb2312?B?OVBXekJUaFVabnpFcTV3cHc4SWh3c25DQVFpZW5QSk5RU1dCUmljMm81c0NJ?=
 =?gb2312?Q?4LJIh1pNYWM5o345R1iyzLnRBZGrgj1MSQieHDGI6g=3D?=
Content-ID: <6E9E81333324F14DA7E563A68EB2827E@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72da50d8-f64e-4496-e995-08d9c1418768
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 09:42:23.7912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atHbLacP94pyRKTZFYng4FRD/C9Qk3bM21e1dXKthTYF2Kc5p+IUDWHb5a5XZ5//tVnEvd2sPQzDypsReRKuA4PYKOwRqyOSGfJQYjpb1Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6009
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] zram/zram03: Convert into new api
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
>> Also add hot_add/hot_remove in setup/cleanup, so this case can adapt the situation that
>> zram module is being used by zram-generator or zram module is builtin.
> Very nice. Again, I like you added both CONFIG_ZRAM=y support and simultaneous
> run.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
>> diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
> ...
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write the Free Software
>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> - * 02110-1301, USA.
>> + * This case check whether data read from zram device is consistent with
>> + * thoese are written.
>>    */
>
>> +
> nit: I'd remove this extra line
OK
>>   #include<sys/types.h>
>>   #include<sys/stat.h>
>
> ...
>>   	if (i != SIZE - 1) {
>> -		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
>> +		tst_res(TFAIL, "expect size: %ld, actual size: %ld.",
>>   			 SIZE - 1, i);
>>   	} else if (s[i] != '\0') {
>> -		tst_resm(TFAIL, "zram device seems not null terminated");
>> +		tst_res(TFAIL, "zram device seems not null terminated");
>>   	} else if (fail) {
>> -		tst_resm(TFAIL, "%ld failed bytes found.", fail);
>> +		tst_res(TFAIL, "%ld failed bytes found", fail);
>>   	} else {
>> -		tst_resm(TPASS, "data read from zram device is consistent "
>> +		tst_res(TPASS, "data read from zram device is consistent "
>>   			 "with those are written");
> nit: I'd join this line (less than over 100)
ok
>>   	}
>
> ...
>> +static void setup(void)
>> +{
>> +	const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
>> +	int hot_add_fd;
>> +
>> +	if (!access(ZRAM_CONTROL_PATH, F_OK)) {
>> +		hot_add_fd = SAFE_OPEN(HOT_ADD_PATH, O_RDONLY);
>> +		SAFE_READ(0, hot_add_fd,&buf, 20);
>> +		dev_num = atoi(buf);
>> +		SAFE_CLOSE(hot_add_fd);
>> +		hot_add_flag = 1;
> We have SAFE_FILE_SCANF(), you can use just:
> 		SAFE_FILE_SCANF(HOT_ADD_PATH, "%d",&dev_num);
Oh, yes, I forgot it...
>
>> +	} else {
>> +		SAFE_CMD(cmd_modprobe, NULL, NULL);
>> +		modprobe = 1;
>> +	}
>> +	sprintf(zram_block_path, "/sys/block/zram%d", dev_num);
>> +	sprintf(zram_dev_path, "/dev/zram%d", dev_num);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};
>> +	int hot_remove_fd;
>> +
>> +	if (hot_add_flag) {
>> +		hot_remove_fd = SAFE_OPEN(HOT_REMOVE_PATH, O_WRONLY);
>> +		SAFE_WRITE(0, hot_remove_fd, buf, 20);
>> +		SAFE_CLOSE(hot_remove_fd);
>> +	}
> Ad here
> 	if (hot_add_flag)
> 		SAFE_FILE_PRINTF(HOT_REMOVE_PATH, "%d", dev_num);
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
