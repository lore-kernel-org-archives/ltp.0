Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C62C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:23:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 621573CB558
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:23:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6253CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:22:58 +0200 (CEST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6636114052DD
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:22:55 +0200 (CEST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39P7PQfK017960; Wed, 25 Oct 2023 02:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from:to:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 PPS06212021; bh=BiWqT70MOak9WFYTQH3kY3Yd+VdNd6FpnkzJ+VLNVp0=; b=
 dlHjFr6Q+LqpjD88mvPDw+9S4rrleFIEoYHkr6WpDK1wwK6AyFmbS8RTGw2+5P+9
 mGRloRzwpBcFZ1qPL2lTbAzfUyNI33oilIOoG4owb5Umm9l4hCM0u/wxwp7y4S12
 fSM52mEA5K2QZFIweYP0rGym1rjs/wL/S+NeCb64KFINHupEdJUYEqJO7XOBCrqJ
 9MyrmvzZN9YUBJ/CXGRtN89VjAtEUniQgjszqsBwpdDkBSA9l8zdzNmVC6AgWFa2
 XLnNDxk9S8xlgtYgevP+kEFs7PKIcEDcXMtSZBOdXmfAh5Yt7RiptQ0H6Q/C8IJ+
 5P4jC/wLAil9TyQIgCgObA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv9x045t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 02:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLaQauhkW2767CrYYYPJR0QVFXz7otePqBOuEZD2+xnxI8IWKINzAxZko+xMNIhHNBeSh0RbFNmvDlpGPSca/D1rPO9l35YdHDQMnWIb7BZ+/4m0wzZt55T0wP/9jOc7ySB+pi1N3Q4abEV7H9l94Fw88++HZ/77kyrDPzN+HyyZlHk6NLYz4MVypwofROJJhxQSMVhdQV7z2XwWhlPqmmgadRdzH3NBR3rUkieAYEcipgx4R+VdTRKOivqRlV8zv9RH4vX/JK5LDG+K71Uuzja28z+gQrzmk4aeqCgLX2nkkq9Ouk4Lv5O018uCBhHo4Fn02i3SJZDIuY0epaxPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiWqT70MOak9WFYTQH3kY3Yd+VdNd6FpnkzJ+VLNVp0=;
 b=cH9coetI9GVIWF683MxxMGnUbFWNM98ApM8Vea63dxsNKEuaj+SgCmGaXs9HrK5KPrtoLJAa+jUjdLTm0k8VW7n+8bv8p4/7kjZXGl2MZBAvxE8z8A5bfguei9I8WGu8/TkuEYytijsamWh9yVUopYC/fvjk1AdR3k91ZCSB8XbbbizkmNkO5I9fx67sZkCXM9VvfkVKZhxoXBvm7a8mlqYLUQAUz8HaoHSPPhqzNjdrPah6bYRqug8lb7O/NEuo0Keli8aJm9D9bECKH4hH0eS/YKwyumv3jqPmaoRr6HVTVMF14TkyA1SrJRg+4D86yqvdAuQORMq+xczius3P3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:22:48 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::9f52:2999:c2f5:729e%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:22:47 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
Thread-Index: AQHaBxk75siQdpS6QUeOlAojeQf0dbBaOm9w
Date: Wed, 25 Oct 2023 09:22:47 +0000
Message-ID: <CO1PR11MB4979036FAC09BF6D92FA916A95DEA@CO1PR11MB4979.namprd11.prod.outlook.com>
References: <20231018014832.1632063-1-Xin.Wang@windriver.com>
 <CO1PR11MB4979DDFD87F04B88FE28AB7B95DEA@CO1PR11MB4979.namprd11.prod.outlook.com>
 <4a52b7ad-5cf6-43ff-86e1-b02b2cd143a0@suse.com>
In-Reply-To: <4a52b7ad-5cf6-43ff-86e1-b02b2cd143a0@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4979:EE_|PH7PR11MB5862:EE_
x-ms-office365-filtering-correlation-id: dd79cf10-de2c-42a6-f7af-08dbd53bf40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sKziCGvt9qQWQ/P3wZOwzNgHrSCkkF+9n/YQWBfXw+ilcuWqidgBWJcE1An5EssCL/b4xD6M5g2Ndz8RpeKqPUnd6DMZxm8Gvym2wcNxyf755vqQwxzrkBaqXb3guxzThfOCQg9p3rUkD9o2ga34lbEeWD4ta5RcgpHggF7rVLp/egZ318omjs8sDa3kJnzuvHr8jEmCuU4gKAj5mD40UdDfRR/lj6E3QymJ4aTAqqJPhapyPFi6bN8oPKlotb/VnKPKGq6bg6TY7xueChkty9T1vkxMLzimXMliL9MCE6rzX0XmftA68hGI0Z+cITrPtemm7W+zADMnRRs5QOzw5q/v++qttY8OSZ8L5CR2LC6/Dh5sqps336mFQMGtJ8LbOTM+TIcs/pws15j/bYwtJobEg6mUZUztilj+2pDdzKSW9jrfZMgUA1G7spJsaID2zQrQFKbJJqMb1b4WqbazkeGHILl2sIl87rMheQZnQgUxizonbuW6IL3xih2upf+fQHAYOQXiBHKKQ4Hio5qaBTvMbitzSK6RVJ9+YCha0obqNeQu/VLC/FSAoMUR6ozV/2CY+tApXV9cLWieQtiHfWZaE2DtckoHOc/of560gA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(136003)(39850400004)(366004)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(71200400001)(2906002)(52536014)(122000001)(8676002)(8936002)(966005)(53546011)(55016003)(9686003)(5660300002)(41300700001)(7696005)(86362001)(6506007)(316002)(478600001)(110136005)(26005)(33656002)(64756008)(66946007)(66476007)(76116006)(38070700009)(38100700002)(66556008)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBOUmxxYmJBaXFRMlIwbEw1Qy9la0M2cDdJOVlwTGs4ODdnWkNsRkZsQk1r?=
 =?utf-8?B?TnFSNUt4VUJzTFpHSmZGcS93QjVaRDQzK2U1Qkh1YTgrMGxjazgrdndlMDBp?=
 =?utf-8?B?dGVTekl1QWRSSFZrSy9NSXFTVXVuWUtTdVZTU2dldjJtdWdrYmRnZmlBT0pR?=
 =?utf-8?B?VFVDQ2poYXRqUkVNRnJzcDlHbEZUVmlvNGVBNE9CSEpDTkxULzhBOGlBUkxI?=
 =?utf-8?B?alA4WUlLWklqeDFIcHZEQ0lJTzBiQTJiV1BzUW1XVURtNkpKalY2OElhV3l1?=
 =?utf-8?B?SnVrUUc1QlM1eGNPZUh6VnBDaGRkcjhUdFlrYjN1eHdGUWNFOWs5M3ErYmRu?=
 =?utf-8?B?VGQreHd1eE9CK2ZDVEtPbFlKOTdkRWVsMnhwdWN3V0I0Q1FTeGhZTkZyVGpi?=
 =?utf-8?B?bVNvTkJBNVZYZkFoRXY4VHNsL25BUlp1bG4yRE9kaVF0NEpWVU4yTDhJbVJs?=
 =?utf-8?B?dHJoeWRVZ2dSV1AvVDFjQTVuRXpEZ0Vab1dCcHE2MXo4dHRDdVQrNnhISFU5?=
 =?utf-8?B?c3d3VWl2WU5LaGxPVTJhWG91eVpnSlc0cHd5MGlJZ1VqRFlKT3ZneW5FT250?=
 =?utf-8?B?NDlVMnFDU3VZbmFDampsbjZDbHg0Wk11bE5qLzFEZUgxZUhXaFliMWY4b0RE?=
 =?utf-8?B?Mk0vVEZEQzhGTERmNTJUdGpUWXd3OEFTRXNvcW4xMlpCUlpmMEY0RzVNM0Zz?=
 =?utf-8?B?aXlPVUZ5NVVlQWFLRnk0aG5OdFZ3cGNwSUZ4dEtCYzJqcWtYdEd6M1YwQnN5?=
 =?utf-8?B?eldwWTJ4bDE3UkhjaytaRk9JakVqQ3dpWnhhZ0MwaU1LdWt1a1p4TC81d0Jx?=
 =?utf-8?B?SmFYbzJnbi8xZVJCWk9MODZ4eTNiekNJY2VURmwyNWJHdUZUdEYrVHZHYlky?=
 =?utf-8?B?VXBwWkMxNzA3dnBsZGR4ZDUxUHNIbGVJYnpuelBmczU3MFVVaWhjQjJ3TmZF?=
 =?utf-8?B?R1V2dnArTEYzZjRSQXBGWkdYUVZFYlB0V0VMYlB4RkxmVEV4RmZuWXhIVlBI?=
 =?utf-8?B?KzB3QlhiRXAvMHQ2Tm4rOUNvWUkxRU5vY1QreEZuQ1JsdnhIVElxYTUyczh3?=
 =?utf-8?B?dGJ4aGYzbVY4NVQ2WEpEdlZxS0hqRDNCV3VmVjhiYlBrTVp6Q2REU2dDU1NX?=
 =?utf-8?B?MXlPL0hyRldDVFNHd0JzbVF5eVBvV3pPeXRzUVlRdU5EdzkzTkZRZldlYXBB?=
 =?utf-8?B?eGhKUkx1WU9oV0JUdEN3VDlwcGgwNk5BTHVRcUl3a1pubWcwT3cyM1k3S0xn?=
 =?utf-8?B?THYzbUhBV3ZUNlE3ZWMrSDd2Y0FKZGcxTGNkUCtwQkxQR05kbXFRZ2Fad09U?=
 =?utf-8?B?akh1N3REbVlHdFYzY0NJVjRXQm5PM1RFaTNoRXJMWGxjdyt5VytlTG5POTRv?=
 =?utf-8?B?TE1CYTBXL0tBcndlaktLa211b2UyL2VhRXVXaTB3Qmp5STYvTWZlR2VGUkpi?=
 =?utf-8?B?RWR2YysvSWVJSmtzaDdEaFQ2OWJIMDdHbmFkTFJUWUc0d2Z0SE0xV0tydmpZ?=
 =?utf-8?B?cXVoempiWDV6cGd3N2NmL042Y0R1R2x4WDE3bFpzblNJUnRCV0hHNnlpWlRB?=
 =?utf-8?B?eXZKc0svTnBtTytoV2MwUWlZbTJSbHd5ejZ3V2pDSWl2QXJEeCt2MVYxV203?=
 =?utf-8?B?TmVWRUtISk5CdzdmWlBFRVFzUVRlQkg5cDd3MjdMTDZoWlFIRTRabVhDUXNO?=
 =?utf-8?B?c0c3TWZmMXJpL09rTDY5ZlRLTFpCV0M4c3ZvaGhQTWVYKzIwUVcyZkJqRlg4?=
 =?utf-8?B?MnNZbHF1SjkzVWpJZ0hTdGF3TG9pdERWRHZ1ZWRjajFCL0J5dTRuUlRTWkF6?=
 =?utf-8?B?VjNEbTJxMDEwblpSRzlTUDZxcUt6L0lYZVdvN0crSGhwL3ErbkU5Tk1xdUVY?=
 =?utf-8?B?MDMyM1J2ZEVjclg0c3ppb25Rc0FIejBaRnZXbUZkUzdQd09HYWhaYnZvWEtT?=
 =?utf-8?B?V2o2UWtOK3ZDWk1QZXpxNFVrL2pRbTR4NWpTdDV4Y3lIL014bGRkSzFxRHJj?=
 =?utf-8?B?ejVqb0swOUlJczRWc2lNUTFBZExhaWZqdkJtVnZpdXkzblNJY0pRUXhuRUpp?=
 =?utf-8?B?OHdJTENWcVNxWDNTMlB4NDBFTnRsTGUrSXc4cDlBQWJkMm02Z1dVQWNpUXdk?=
 =?utf-8?Q?4MXT77YbBdpneUOOcfh2txUxA?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd79cf10-de2c-42a6-f7af-08dbd53bf40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 09:22:47.6955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/fQtqaiz+QoyyWAfXK0NX8aQvWgFaGFkBvZIN66eZlZ5EdS42HmSKy2DsesmqylVrEuQDjujx2YIs+pNdzOGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
X-Proofpoint-ORIG-GUID: 5ve4Nw_uSs4mLpc0xtwJPS3fq97c4qIa
X-Proofpoint-GUID: 5ve4Nw_uSs4mLpc0xtwJPS3fq97c4qIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310250080
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/1] enable fsx-linux.c running on VxWorks user
 space and add measurement of execution time
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
From: "Wang, Xin via ltp" <ltp@lists.linux.it>
Reply-To: "Wang, Xin" <Xin.Wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gQW5kcmVhLA0KPiBIaSBYaW4sDQo+IA0KPiBPbiAxMC8yNS8yMyAwMzozMiwgV2FuZywg
WGluIHZpYSBsdHAgd3JvdGU6DQo+ID4gSGVsbG8sDQo+ID4+IEhpLA0KPiA+PiBDb3VsZCBJIHBy
b3ZpZGUgdGhlIHBhdGNoIGJlZm9yZSBmc3gtbGludXggcmV3cml0dGVuIHNpbmNlIHRoZQ0KPiA+
PiByZXdyaXRlIHN0aWxsIG5lZWQgYSBmZXcgbW9udGhzPyBUaGVuIFZ4V29ya3MgdXNlcnMgY291
bGQgZ2V0IGENCj4gPj4gc3BlY2lmaWMgdmVyc2lvbiBvZiBmc3gtbGludXggZm9yIHRlc3Rpbmcu
DQo+ID4+IEFmdGVyIGZzeC1saW51eC5jIGlzIHJld3JpdHRlbiwgSSB3aWxsIHNlbmQgYSBuZXcg
c3VwcG9ydCBwYXRjaCBmb3INCj4gPj4gVnhXb3Jrcy4gSXQgbWF5IGFsc28gdGFrZSBzb21lIHRp
bWUgYmVjYXVzZSBWeFdvcmtzIGRvZXNu4oCZdCBzdXBwb3J0DQo+ID4+IGJ1aWxkaW5nIExUUCBB
UEkgbGlicmFyeSBub3cuDQo+ID4+IFBsZWFzZSBjb25zaWRlciB0aGlzIHdheSBhbmQgcmV2aWV3
IG15IHBhdGNoLiBUaGFua3MuDQo+ID4+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IFhpbg0KPiA+Pg0K
PiA+PiBYaW4gV2FuZyAoMSk6DQo+ID4+ICAgIGVuYWJsZSBmc3gtbGludXguYyBydW5uaW5nIG9u
IFZ4V29ya3MgdXNlciBzcGFjZSBhbmQgYWRkIG1lYXN1cmVtZW50DQo+ID4+ICAgICAgb2YgZXhl
Y3V0aW9uIHRpbWUNCj4gPj4NCj4gPj4gICB0ZXN0Y2FzZXMva2VybmVsL2ZzL2ZzeC1saW51eC9N
YWtlZmlsZSAgICB8ICAzICstDQo+ID4+ICAgdGVzdGNhc2VzL2tlcm5lbC9mcy9mc3gtbGludXgv
ZnN4LWxpbnV4LmMgfCA1MyArKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+PiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gLS0N
Cj4gPiBBbnkgY29tbWVudHMgZm9yIHRoaXMgcGF0Y2g/DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+
IFhpbg0KPiA+DQo+ID4+IDIuMzQuMQ0KPiA+DQo+IEFzIHNhaWQgaW4gbXkgcHJldmlvdXMgZW1h
aWwsIHlvdSBjb3VsZCBwcm92aWRlIHRoZSBwYXRjaCBmb3IgZnN4LWxpbnV4IGJlZm9yZQ0KPiB0
aGUgcmV3cml0ZSwgc2luY2UgbW9udGhzIGFyZSBhIHdheSB0b28gbG9uZyBwZXJpb2Qgb2YgdGlt
ZSB0byBzdGFydCB3aXRoIHN1Y2ggYQ0KPiBzbWFsbCBjaGFuZ2UuIEkgd2lsbCB0YWtlIGludG8g
YWNjb3VudCBhbHNvIHlvdXIgbW9kaWZpY2F0aW9ucywgc28gdGhlIG5leHQNCj4gcmV3cml0ZSBz
aG91bGQgc3VwcG9ydCBhbHNvIFZ4V29ya3MuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmRyZWEgQ2Vy
dmVzYXRvDQo+IA0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nIGl0LCBJIHdpbGwgd2FpdCBmb3IgcGF0
Y2ggdjIgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KIFhpbg0KPiAtLQ0KPiBNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHANCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
