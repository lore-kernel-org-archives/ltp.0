Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F698C001B0
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 11:23:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D8A13C65F4
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 13:23:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B241F3C65F4
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:22:54 +0200 (CEST)
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com
 [68.232.159.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB18C200963
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692012173; x=1723548173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HZz9Ic5u0EYhSzQ858WUaAcVuZ0t3EH/fU/g8eRXHyo=;
 b=FlSI0TIpW+xrtJh2LXe0Ar/gvKEufs4rrKcxzN7lSZ4rH1LNFHBie3p8
 tDCMddCylB/6iWLbUkyQBpDeNdzN4YhsmadMY/WQOZ1gkfTSywStwihIR
 nc4F5LcwZaxQGoRaE6dtNsh/p4xVsV7r8z4je13tMZoGKK955WCt1/42l
 W9H5WBUUwmtWqTYCT6hT3eHGgo4EA75BgFSRc/iW4SXxbP02LVQosNU/h
 dWgJ67vyIwsDcfsocQSiTlDl4AO6es9OcRQLlRf+bJD3H8hTc7Fskigah
 fvMsX0EtcRzV/2B1iKhnCAjMsS4mOjdeA6EjUElucLsN7RVCYUmLX0bM8 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="92356257"
X-IronPort-AV: E=Sophos;i="6.01,172,1684767600"; d="scan'208";a="92356257"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 20:22:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndOlTPFZbDogy7XGrxXOnhPJ9tnFgke6Ly+zsPREApTg3DAGe6DPmm/KBzX6OQ9JG5tVM/1Kyrd7ci2rw6YNmoYTCMu88bvjBv2ApSkycUNpXSOUiN4MGolUGFsycz1mFry4kDs4Ni8WNnOU3LAXDs5OPlJwSZoRJzfMMrj6/birouqrQXaM9OkAY18qa9wR9ugldmfN+CsQuifyfYZp5szFszO8J6TwuGpl+8SUC65xCrehlmC7zmxrtz7Tqwiy5/pyYVfHfmZdneFIgeX9iq9Kse/wwmx+3glIxVy35R7OILFwr8L9x9+xo3qnoaUGqCzxN0MJHQlP8Z7VJCYHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZz9Ic5u0EYhSzQ858WUaAcVuZ0t3EH/fU/g8eRXHyo=;
 b=W5KM+zXLzjcxQ/vyASkMp+MRZ6S4JfMPz3M8ZQtHvi9xqPUowB2MN1metpYgvE97oz0k4h9ceDOroVD3XmAJ3fj+QumbM4Gdqh8c6K/rm0SMY8wClnbuy/CEtqdA5gz/ehrHGlz+q6j+r7s59dzAHVlybFdTq6BLrZBuFZPAuXAhNCZ5J0Fu17L6QTE41AT2z9+LD5tQXFXZYUVg9UaeotHre/lmEYkhyy6vVaWVhJ/W+Nc7CS0FoGtdZmM/tAujREJhUQwhjsbO8vRuSFvLXgUaF2JYeJShUDzyo5GMQSy2/HwFpO1qohNFqvlSZ6W9oO0S9ygvX53s2h6J45SpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB10431.jpnprd01.prod.outlook.com (2603:1096:400:247::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:22:49 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:22:49 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 1/3] syscalls/setgroups01: Convert to new API
Thread-Index: AQHZxGhhUuj88+vTeEKpDamLU+yH/6/ezRsAgArtYoA=
Date: Mon, 14 Aug 2023 11:22:49 +0000
Message-ID: <b80ef019-6c2c-5f74-5243-282ffbb728c5@fujitsu.com>
References: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNDj6o3UViMIbvkT@yuki>
In-Reply-To: <ZNDj6o3UViMIbvkT@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB10431:EE_
x-ms-office365-filtering-correlation-id: f5183440-bc84-4ffe-9831-08db9cb8cab5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+Z9md40BDcDUBIy2QC8PYYCjuhqOITjTG2YqlvjlCXIF9V153fjyax6v+w1Fi78/rvip4USku/chlB3/4azQR1RZbKxgjuHYfZ0NFQhtMNpvlcUqTHqoZ7T7MxQ++Gj7YyUxB9+bsVbYQGOIGmutu0Y6vyLM0h3JhwhclhxYRVnQdkJM1EWPfnSUo5mEN7a+nLTIjo4WCkUqrtmCmqgl+LfjYUf20NR63btLz6iVLVMebajv3dYpUZ/CqfVI2+oZl6A0oe5avUvnr0McXxGwfhPmSk13i/hco7kzDAZ0K33ccEle1tpreIvAv5CJgFfPDwmpWrEO8Xq2ImY8j05UEupjXBJX7mWPWWFKzXFoj4xOh+sX7ce3LdkHv7Vkm3n7j6R1IRxpz2dvfPF5YK9wRzy/aOZfP8Rt4O7dD9RMAtgogWxRWEvAbzbjpslRpfBxMJL0mSn9Og0utoTnIT+AvhgNOOQ5mXTI5A52zY7qEADJwxup+M9kLCjOle4tBkIkCwWnvLBVI5BisVLQaxJ549Wqn0En+hyiRzfg7MxTueAkoUirs3bMZnIBzDDUvp0di0Hq9gmuaeBD/KkN9ET7qCnWzOPcqNfF9/BWkFfp6v1gLY/1xpB/6le46cIoFB0qKU87Ogs84bJ4r2OWgv/avRN1R/KFVGJ3rM2853SiPldWBLCrlTQ4xG+BaZbTrtI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(1590799018)(1800799006)(186006)(6486002)(71200400001)(6512007)(6506007)(478600001)(2616005)(26005)(2906002)(83380400001)(64756008)(41300700001)(6916009)(91956017)(316002)(66446008)(66556008)(76116006)(66476007)(8936002)(66946007)(4326008)(8676002)(5660300002)(31696002)(38100700002)(82960400001)(38070700005)(85182001)(36756003)(86362001)(122000001)(1580799015)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WSswUHBsU1pRdW5KVFBmNVhxTFpRTmx4d0VseERFMHJOSElIRnM4RTJvYlY4?=
 =?utf-8?B?UHduS0xpYS9kQURNZExQeDVZdWpleTZ4Z0w3TWoxYTh6KzFiUG5rR3o3MU5x?=
 =?utf-8?B?WEdaS29NMXpRQ0pUbkdDaXJyZFYyU2l2dWtiZ3U4T29nTzJhZzVVYjNKR0g2?=
 =?utf-8?B?TnQ2YmZHWWZYZngyOGNFWXIxSW5XTDM1S2VIdlVTV0t6bDJSOE4wT1prVFBZ?=
 =?utf-8?B?RHVrMkd4MmhWTkhoUzQreEt6NGZYS3dyTGR2WEpIcUJYazIyNUJUSFZtelBV?=
 =?utf-8?B?NDNaYWF4NEJQSHBuM01ON1BDRGhlbzAvTEY0cUVkbUNKNXE4NE85T2dMQkJS?=
 =?utf-8?B?bURWeXdRVHNHdUpUM2NIeFBTUko3a0hQdGMyVU5yY1ViQU5OclI1WEZneTJ2?=
 =?utf-8?B?T3NUbEN2ZkRlTjF4R3Y4aFhUUXpuYVFQblJPQmdITnl5REdmT2Y2blpjaTJP?=
 =?utf-8?B?YTNUWnoxaHI5MDlHNEJWN1ZramppRG1PNmxVT04xQ0NrT1lzNXVLZW5rRzdL?=
 =?utf-8?B?bWo0TWNseUhObTgxNWoxNTkvRllPUkp3bzhqeE1BY2ZVNWJQUFExZmtISmFm?=
 =?utf-8?B?R3k1ckkzanBKT0dnR1NHcU1OQW1NcjJSSlpzS3VFUkwzMmY3UWxBQ2FRLzE3?=
 =?utf-8?B?M1dEdkFWd1ViVlRIenhRNlBuTkpTbnNJQldCNTUyYXNiSXRUVVlMbHF4dkwr?=
 =?utf-8?B?ZytUR1VaUmdzQVFoOEZja2VFZXhJeWNGdEFsWTk4elhiZDk3VVFCcGRsenBT?=
 =?utf-8?B?R0pYV0VJSUg1NU5mZWJOYi9od0FabHBrN2tNUytvWWJMNTBkQ2xQRGdKNkZ5?=
 =?utf-8?B?dnJ2S29oayt0RXVibEFwUmdWMlNSRElEQ3p0R1A2bjRXOU13b3gvTUk2TCtu?=
 =?utf-8?B?dDhMU0NqdHZyMFNRbHk0ak84N3ZKd00vOGFSWlA0RmgvL0k5c3hRdVdkZGRX?=
 =?utf-8?B?Y3RUNXYyNWZDMlF6ZnBtdGdaZXVXUzZ6STA5K3VMWm9VbVVLWSs5cWllM0dk?=
 =?utf-8?B?SEJnUElxY1hmbWxXbWVONjRGVmpMcmRibXZ5UjNsYVNCVVBIMi9vY3J2RkRS?=
 =?utf-8?B?ZGNHUzhoQTNDWGF1elJ4MFhmcjVxays0VnpMQjFob0Q1TGhnSDRZWC9OcUxP?=
 =?utf-8?B?K29YeVhSMzR5RmFZbkFDUXFrNUFwZkdDaUVPVjdoandWZ0lGR0ZjekU0WGtW?=
 =?utf-8?B?U2tMTzlQOWEwMEk0ODdiTlVockdFSVo4emN3U1M4SHc3Um5mNzQwZDVnRUZV?=
 =?utf-8?B?SHF6NlUvZzNZRTdVYndNS3YxblBNWjM1L1dFUVBrZjVuZm5CR3NhS3ErTXdt?=
 =?utf-8?B?MGNkM3lQdTRaTWVmMW5BdER0dXNCSkhZYmk2cHVoemNLbCtOdmVzbUJDWndR?=
 =?utf-8?B?c2lQOVBFTTZab0ZUWGhja1dKeG1Xakk2OC9KVW5iWG02Y0ZUWVZBY1dEOFJ2?=
 =?utf-8?B?bnBLODM1ODlFb2g2WjRza2t3b2JBQTB6dWJIZ0dVb2FLU1VWQkZ0bXdvaWlY?=
 =?utf-8?B?Vm9aZGdzUTNHWEdnVThWaGdOd3BTZWVzZ3dZb2NLMmVtejhYbmRycGp2bDNV?=
 =?utf-8?B?c0MvVHRHK3cxbUs3UmM0M2FnU0I0TVRwSGNFUkZGd3J6ek5MSEI0cDJ5ZElt?=
 =?utf-8?B?bktNdEVDZTB3WndINUUzbXEyS2RKRm4wWHloSFkxcVhRcG1heS95UEtlSUFU?=
 =?utf-8?B?R1NCUEh2RStrTUNKbzBOZVBibkF5SUYxM3VVTTNKRVZ2eFFvVHQxKzlkVDZR?=
 =?utf-8?B?c21xcnU5NzZpeVNFelZnM3NBR3YyTUY3SnYvNHUrUmtyWHJzZlh5MExJRGpT?=
 =?utf-8?B?U053REFUbVVjb05rQVluc1A0V2pwS1BDMWErOW9Ec1VNeEhMSjhFN3YyR0pm?=
 =?utf-8?B?cEZFcEhoSHlYRkYyTEJQRStZTkI0eEVncE9xWGhQZGs5c3MvdUc5cEoyL1pY?=
 =?utf-8?B?Z3lUYlRvL2daT2o2a0UvcnBXdEptOVRiaFpMRG9QTXc2LzJ6Yk10TmFSbk9S?=
 =?utf-8?B?b003MDRjNGsvQkpGd2hsQVVlRWZ3MUppdlR2MU9UZ3JyVXNueFdFZHNlVEow?=
 =?utf-8?B?SE1xenhBS0dQalg3VjNuZzhVUUpHUE5Ea2pMSkZobFBaQklxVVRqNmE1U29Z?=
 =?utf-8?B?N002M0d5c05CK3dMTHVLcjB0N2xCQVBqdnJYS1hDdTlvRS9XUWphK01MZUU4?=
 =?utf-8?B?ZWc9PQ==?=
Content-ID: <1ED887ABDB6AE14FB52ED69ED6A39A26@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X1zhR137trzvwRtvqlIf471V8sOyoet/bc9jGieK2Zj6bqKSmyWzzHksLo47qoVzz4KJnl/lGv/xIGU4Z+esFMlejlDxrpl/pEYDDMlABhAoGVAbtIzIqB4sU/fz1c+ub/YxfJCkaBtDyqCdJSLm+OsqU8Rm4SMjDLaaMMYTLXhEnzeYchA2CKRzJFWrxYQXZZP4/YRqp06cAwPE5IFdlgwIv1TMu/FSevFVz0gpEga3Q39FcdqwzyyIoBVqBr8TROI7uWy+7X3UHBmI+NhkMGh8QnyyUryGQqMf+QcfNN0qziWVJmAhNkJa9wM2MeOXuSAA3W10EEzet0K0USzJYvx7WZRSV+Ed0K9gR92AXPsXB6KxxNJtEFRaYaEdvrUFfc1EJogXOVRCd0075m80S7IRo5wS4FLW/WghIKYPHGW0qus08V1ZVuNlLbC0Yrcz221NJxTqEwZJbxACSy+65af2n554BPsE8kh39piqCd0NFAPBkSq6NSjMr6qwl3UEpxn8zLpN3XlGa/vLKDG6s5PjCY6ebjpG//2+Y0EYdGPr7sOBs7yRqR/YmAohsZ6tLH9/oEFM2N4YSeroCI+kIXVGZrPyRUly/nzurjaMIFq8E0JF+bbfp62AVicuq88k4uKii6qTY/qOsuhkNqqurjIkuijcYk6r3NoiuiES/45qiVvJ4LKMa8KqreSkd5AiCfh0guy7bwwThYwRGP2v/hCJpFnFjJYh3Ouw7xUESaS2vSxTHqSN6tjVrJznHGKladJUNpeyz/i0GWd20TP3NI3LIhBktY9UIoXq19iCk7E=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5183440-bc84-4ffe-9831-08db9cb8cab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:22:49.1328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /X4JAdYQtAv3C2SVaUIoLx20Qwy3AU8HlM3xbRSVKepCmvMWCVfZ8lhf/fGKMj6Npo8PCZJmY4Ywe4f7g3WmicKeezB2GtClv9NjmS7D9sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10431
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] syscalls/setgroups01: Convert to new API
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


Hi,Cyril
> Hi!
>> -#include <errno.h>
>> -#include <string.h>
>> -#include <signal.h>
>> -#include <sys/param.h>
>> -#include <unistd.h>
>> -#include <grp.h>
>> -
>> -#include "test.h"
>> -
>> -#include "compat_16.h"
>> +/*\
>> + * [Description]
>> + *
>> + * Check the basic functionality of the setgroups() system call.
>> + */
>>   
>> -void setup();
>> -void cleanup();
>> +#include "tst_test.h"
>> +#include "compat_tst_16.h"
>>   
>> -TCID_DEFINE(setgroups01);
>> -int TST_TOTAL = 1;
>> +static int len = NGROUPS, ngrps;
>>   
>> -int len = NGROUPS, ngrps = 0;
>> -GID_T list[NGROUPS];
>> +static GID_T list[NGROUPS];
>>   
>> -int main(int ac, char **av)
>> +static void verify_setgroups(void)
>>   {
>> -	int lc;
>> -
>> -    /***************************************************************
>> -     * parse standard options
>> -     ***************************************************************/
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -    /***************************************************************
>> -     * perform global setup for test
>> -     ***************************************************************/
>> -	setup();
>> -
>> -    /***************************************************************
>> -     * check looping state if -c option given
>> -     ***************************************************************/
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		/*
>> -		 * Call setgroups(2)
>> -		 */
>> -		TEST(SETGROUPS(cleanup, ngrps, list));
>> -
>> -		/* check return code */
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL,
>> -				 "setgroups(%d, list) Failed, errno=%d : %s",
>> -				 len, TEST_ERRNO, strerror(TEST_ERRNO));
>> -		} else {
>> -			tst_resm(TPASS,
>> -				 "setgroups(%d, list) returned %ld",
>> -				 len, TEST_RETURN);
>> -		}
>> -
>> -	}
>> -
>> -	cleanup();
>> -	tst_exit();
>> +	TST_EXP_POSITIVE(SETGROUPS(ngrps, list),
>> +			 "setgroups(%d, list)", len);
>>   }
>>   
>> -/***************************************************************
>> - * setup() - performs all ONE TIME setup for this test.
>> - ***************************************************************/
>> -void setup(void)
>> +static void setup(void)
>>   {
>> -
>> -	tst_require_root();
>> -
>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	TEST_PAUSE;
>> -
>> -	ngrps = GETGROUPS(cleanup, len, list);
>> -	if (ngrps == -1) {
>> -		tst_brkm(TBROK, cleanup,
>> -			 "getgroups(%d, list) Failure. errno=%d : %s",
>> -			 len, errno, strerror(errno));
>> +	if (GETGROUPS(len, list) < 0) {
>> +		tst_brk(TBROK,
>> +			"getgroups(%d, list) Failure. errno=%d : %s",
>> +			len, errno, strerror(errno));
>                               ^
> 			     use TERRNO instead of printing the values
> 			     by hand
>
>
>>   	}
> Also after this change the ngrps is no loger set and we pass 0 as the
> number of groups to the setgroups call.
>
>
> The rest of the changes looks good.
I agree with your suggestion and I will update it.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
