Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289B1C54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 06:06:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C681A3CACBA
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA65C3C1BC5
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 08:06:10 +0200 (CEST)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 706D8600079
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 08:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1663567570; x=1695103570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Biwk7jyBWEAcDfvTkg/BBqk8p5WdKS/BZi4tedG4Egs=;
 b=tQHO5ED34lMyBedEA2l3ajtLdXC4cM4t6S/Fvy8mhRwTdRQRC8fyZIOW
 djSy/wnULuE9itqCwMucgym48Jk8JjZnTQ2U15Ur1yYF/SXKXZgODKKG+
 Nn5i1rJ7IpSRym79EIN5Bxh9HHltCGuZyMLm9CUqQHUmKkSiRw30GnEOk
 3VSxPmOk6+jewKSHXh1c56c88D52X4Xucjg9RdxpxXTSV8VSxc8N2xjz2
 pUs1nUzaEn4oP6H6CSF5O8Mx6PGS6rAb2eoH9NyGcnEKz6+HMo4DlzxOl
 CANU8Aa75Qqp6Re9UyRh1kqbbR076RYATfhp7PJWb5yVeBqeP9RAM+aSC w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="65392863"
X-IronPort-AV: E=Sophos;i="5.93,327,1654527600"; d="scan'208";a="65392863"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 15:06:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7c/0m+jlmFanl5ZkzwMqCqfx1BtPHMTBmdcmKZcqV9UZEMXFZlIBc8cSSdbkN0kkmw1/QQt+2k0PEuknJcnAP6LgOyRrBXRKjJ0WsOIJq4ZkrDAooQNupk4c6hIyzY9Jkt1sI5T80sEq7W2vSFmVMjh+fLSPGSdVgMdnkyh0TVHmCniBWxnaDgfooxOXcsPUv9KOCuX6tq+NRCl0ajXhIfCgarBZnkJqTlrs+eCkzAe2OFecVGRNtoks5TNiGqKvSRFm3Kth9bZ8W1nix/NBi4osFVn9bO2fcB1utmIoEyPX97toSpKOmG1CVXy2gbCF/CRgwy7SHJo0PTlesUo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Biwk7jyBWEAcDfvTkg/BBqk8p5WdKS/BZi4tedG4Egs=;
 b=m4Te7M8oJF9bXYYiKDLApugYJgV+Sa6dGsC3AMZh8H5t+eB0aTncNLl+gFweiJIY1ErMFlvn6RZCecs7JuDgBzScBduePNMsXRpy5xweZeCNAh9rXGM+njiSpBzmiIGW5yZStjRlaM4H5wu87Ihgki1twxImyTHA5Z303R8o9tzOguo2dEnkHi3Y2FbH5sA8boqlx6BramOb2pxTlw5zpnxMuOWQXJWDr9/GRm02eHd4sUv8N6Mepw3Tx/G8MmxQw7mcLtbHwkYR95rCRZR5F8a70lyC051LSy7IkdMfOT+9hUfYL0hBr3qN25C6Zjj0P5SxT/7YvVA/gibq8u72JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB6140.jpnprd01.prod.outlook.com (2603:1096:402:39::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Mon, 19 Sep
 2022 06:06:04 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 06:06:04 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: "Joerg.Vehlow@aox.de" <Joerg.Vehlow@aox.de>, Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] README: Add missing configure in openposix step
Thread-Index: AQHYvbbgEnYwAK0pI02c1YlGRwJGsa3KagSAgAFnlACAGoEdAIAAHq+A
Date: Mon, 19 Sep 2022 06:06:04 +0000
Message-ID: <d7639dba-7157-461e-dedc-fd800600370b@fujitsu.com>
References: <1662008249-2227-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YxCR7+dkGxPvCQDn@pevik> <98263d58-cf08-0c70-c642-2a95a727659f@fujitsu.com>
 <313ec802-8e48-667b-6327-071e25acb8b5@jv-coder.de>
In-Reply-To: <313ec802-8e48-667b-6327-071e25acb8b5@jv-coder.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|TYAPR01MB6140:EE_
x-ms-office365-filtering-correlation-id: 6a5060a1-b236-4e15-993f-08da9a050920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arsu3MU4Xex9XWKaFsynrCL1VEABIW2v0CsxOElni2AVwX82tMXryBAwHxAx5WGma3TOppDbPaCevtYZqv6V+oPWtt6amoAQ2+iHi7LrcbfSzFuTq/CG+Djg19DpQb4aP2O2ESZ3UdX2JJb8GBytpZedoDkqyCQZ+sj2LOz9wbfxGurcePW/xJUNv63hQtYTzRfnWJ/yScahxkhetm5ZdrSLxqj/nM56MP5cPjff5WPQ9ET3AuZpcC3SIoD9KP8bUeWu9sgx4cjh2XAHsDwtvj/ADdtSrIrUsBofJUtfs4AN608o/avsNGxwntmM1g2NBl3GOFsbN6Ja48BnLranANWNVqmc5UiZwvaryLGp3rq3V1XoBVBG0mRi2rkocx7fi+QpKLe1mmMkiKHwTVpBt4ZGLwhXC/ijjtgwajVGUuQuw3+2ofy59B6yD+0HJdYvc0S7wbj9umBGi2gi4XBEbQ0rQOGuE9RUeKe2AKjvAcDSmB8ytouIIVWesKcpRMeEl5YZIPGWIyKsJJ4jCkYRK7cFnj7prQnOqQ9/g7biAoeuzRKUxcrM7lgl5i5JMOvdg03F436iWMaxwYIq4CMk2eW6mIOM8eWjkNMHaPDeFX22GIDzj8aRJIR+nBdsE3e7dW9pLI3Xs5IelKfnFGC2PKf84SX0jbPuNG+dHFtyvAkAAnHSckuuy3OF4fhI6mGX1s9Vc5kp3A2o6+IIiMufiIbfFqo07nE7lpLETzuAUvM7gvMbg8XYbwhZVN5iZwwBlx1Ch3qVRYZSN7yK1lu7pwjP9gk/iPnjMbr8UYQS3JZCMblopLfUxpXzho9K6Joa7GURKj5XQZ0mo+b5PDlvdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(1590799012)(2616005)(2906002)(38070700005)(41300700001)(66446008)(6506007)(4326008)(91956017)(76116006)(8676002)(64756008)(66476007)(66556008)(66946007)(83380400001)(316002)(110136005)(6486002)(71200400001)(5660300002)(85182001)(36756003)(478600001)(86362001)(186003)(31696002)(8936002)(6512007)(38100700002)(1580799009)(26005)(31686004)(82960400001)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTYvOUlLWGQwdS8rT1NaQldiUW5mSW93clNUNkFsa2lnckRyMHhxNXM5ZS9i?=
 =?utf-8?B?R29QQUZvbzR3QlllSmtFazg2Sys0Mlg1OVRwV0NXaU1HN25rTkxCUWNjYkVn?=
 =?utf-8?B?RG1SM0RoKzZVajFJR0lqK0VUVTdzc0hwRkFnNEp2QjJ6MHZLQXlFYkFFaUFO?=
 =?utf-8?B?Wlkza2EyZ3FMaWZMTXUwNXhYTnFreTU3c1RDb1ZjUG1nNVg3QTF1Z0g3WG1y?=
 =?utf-8?B?N1dxTFNSY0lIUFQwT1RGM2grbzBVdlFsdlhxOERWdDg5cEtyWUwzUENzRHFm?=
 =?utf-8?B?U2YyK1Z4TlVHRUdxZXo5TGMxaGxFbmZVbXN0Sm5mVlZtMFhmcm1HanhtOUpj?=
 =?utf-8?B?K084NWdFVStMalVMV3JZMWxPSWJwYTVhcnp0NDBSb1BVWVZrRzFLdkUrRnBP?=
 =?utf-8?B?b05LMi8xSy96M01zWGtPaXB0Qko5N1pncGhSd0FqK1Evc0Jvdi9ScXNkTnd5?=
 =?utf-8?B?SGdIUTRMSkZHV1dIcWdrVktJZGFLMkwzNnpQc1RUb2ZBUnQzSTNzYmdlbmRr?=
 =?utf-8?B?cDdSeHVlT3FzL2V1VVEybTBzTVhjWVRJejI3ay80NnJjd2c5b3RkN09icXlm?=
 =?utf-8?B?Qk9TUm1JSFNsMFdCUmQva1FMMmpBQUdna2Q4WlJZMVpzSmZndjdFRWVPblpI?=
 =?utf-8?B?UmRIcjhJMnNkaU56N2FFM0lGbzRpcHNiYjg3TnlRUFBpcHNXWWlVSVJScytR?=
 =?utf-8?B?bDVCVEdoV1Z0SFFEN1RCUWN4cVZPV0xZSVByUG0xZERwTHBkb0FxZEtyWTVW?=
 =?utf-8?B?Z2N1dXBRbUlPc2s2N3FaK2dJakt4QXVCZG1LM3FYNUJ4NlhFZ2lOdGtjdXZ2?=
 =?utf-8?B?aEJTZ0RXTUtMUWlWeW9jVWNGNWR5NzkzYm1XRlpxK1NyK2FybGdOdnZ1M3NL?=
 =?utf-8?B?K1pYbUEzOTdGei81ZEdSYnRoT2ROckVHZG91M0IwK2JMTVZQR2ZZUVVuMnVD?=
 =?utf-8?B?V1RKYmlCeHJlQXlvNzQraEFpd0ZnKzgzNUl0enZ6M0xIOEY4Zm1zVHVxa0ox?=
 =?utf-8?B?TnhpNkcrc3dnNDBvb2R6SWZxdnErUGVNbmxsNjlPOVdjY3RQdGJYbHVoeHNx?=
 =?utf-8?B?N09rdGJTY29mbExKVFpGYXNiRERaR1ZURGgxdXZOUGhJT3R3dmVrMGx5RlB0?=
 =?utf-8?B?a2syUEZBSVpvSThpS2t5MVUzazVKNnM4R0xXU0xpWVFwaUJHZlNrYU5mQ25E?=
 =?utf-8?B?cUJUcUdPYmd4UGhja1pQVWpPSkVhdFJDc0ZhY0FNSWtoRlJuWVdTMzZZV25u?=
 =?utf-8?B?d1pqWE51UlRLbnNHcjlEQzNYNXYzdG9zQkFRNzlFSHpYcm1tVDRHL3ZOVnNo?=
 =?utf-8?B?ME02VHk3dW5Ga2lqWmFPZjlvc1lBbWVvYUNYSDRXVjZ5c1BDNEVYUHpTWFg4?=
 =?utf-8?B?VGJmRXFGOU1ZV0Q3R2tiWGIvRXJNSmFjZE1SNkplOSs1bDNhb244ekR0a0hF?=
 =?utf-8?B?d3d3Y2pJMGpxM2c1TXUzNkxYL2ptdVZCY0JCZHNoUk9jUGc0KzNFbTVtMjJj?=
 =?utf-8?B?SFIyZ3lSMGRLTDZHNDJpUnU5U1d0WE9DVDFMMmlmZUg4d2Q4Zjhhc2ZCY0lG?=
 =?utf-8?B?b1JtT1VVT1dJcU4ybmt4eElxVkZvM21aTTFuN2R5R044WmEvRk83N0tXZmhL?=
 =?utf-8?B?eG5IdVJqT3g1cGk5RUkzQXV0UmFmUS9jRFp5TDRxbDBmVmdWKzI3dXZhQ08r?=
 =?utf-8?B?K2gvVm0rSmRRanlQTGlEdVBPWWhBaG5ySkdZQmRjV0tZQXZTRUg4UmF5cHJH?=
 =?utf-8?B?NnRoekJBZ0ZoRUMwQ2sxR1YwRHU2MHQ1bEZRUUtGZlRreXh4dXVhQ3g0NmZF?=
 =?utf-8?B?S1pEZnNQSVlGMStCOEZTS0dnVnIyWnJNa1FidGxvYmJNb05CYnJmOFZWM01H?=
 =?utf-8?B?ZU85akkwRnJrcVF6VWtmVzZVTmxyem5MeVV4Q1Jrb29IdmdtTUdhYzFIa0FH?=
 =?utf-8?B?bHhZWHRKbnA5RkN2YTRmeFJVSUpZVmVKVmNKMGFLTUh4RlhTaWtzV1VHRTFl?=
 =?utf-8?B?N2hKVFVVNDA5d0hXSW9CM0xqNGk0YysvVkZmdHBQZkcrSzhZcmNWcVdyTkNT?=
 =?utf-8?B?NVlnSEdDRnBvelduRmdYRzVKbks3cEV6L2hXSCtsdHhSY01weDhwZmdXUklr?=
 =?utf-8?B?S0g1QWJiQnlCSXppYTNvQVpnanFFYXI0ZDZ0Q0o4MG9YWE0rNnRjOGFIdkoz?=
 =?utf-8?B?MWc9PQ==?=
Content-ID: <C6085D0376060840B5ACFA5EB85D999F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5060a1-b236-4e15-993f-08da9a050920
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 06:06:04.4366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNy7YtZjqT7f42kKoMsoCTZHI9cIENH6pNt721/yBbJlzFdLdSdYhTqrAOrMYmnAha2I607yY3mEEnbU+2hZ6dzHl2jnDSGb+cYIrVAeSTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6140
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] README: Add missing configure in openposix step
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

Hi Joerg

> Hi,
> 
> sorry for the late reply, I was on vacation.
> 
> Am 9/2/2022 um 9:31 AM schrieb xuyang2018.jy@fujitsu.com:
>> Hi Petr
>>
>>> Hi Xu,
>>>
>>> [ Cc Joerg ]
>>>
>>>> Since 8071ba7("openposix: Setup autoconf and fix installation layout")
>>>> , we need to use configure firstly.
>>>
>>> nit: there should be Fixes: below:
>>> Fixes: 8071ba7 ("openposix: Setup autoconf and fix installation layout")
>>>
>>> Then you can use just 8071ba7 in the text.
>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>> ---
>>>>    README.md | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>>> diff --git a/README.md b/README.md
>>>> index d45d1ee44..d0ca5f4d4 100644
>>>> --- a/README.md
>>>> +++ b/README.md
>>>> @@ -79,11 +79,13 @@ $ cd ../commands/foo
>>>>    $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh
>>>>    ```
>>>
>>>> -Open Posix Testsuite has it's own build system which needs Makefiles to be
>>>> -generated first, then compilation should work in subdirectories as well.
>>>> +Open Posix Testsuite has it's own configure and build system which needs
>>>> +Makefiles to be generated first, then compilation should work in subdirectories
>>>> +as well.
>>>
>>>>    ```
>>>>    $ cd testcases/open_posix_testsuite/
>>>
>>> You miss:
>>> $ make autotools
>>> as this creates configure
>>>
>>>> +$ ./configure
>>> But if you run make autotools && ./configure in the top level, none of these two
>>> is needed to be run in open posix directory.
>>
>> I have called them on top directory, but configure still be needed in
>> open posix directory.
> Did you run configure with --with-open-posix-testsuite? Otherwise
> configure is not executed in the open posix directory.

Oh,  yes, I don't use this option. I only see the documentation said we 
can use ./configure and make instead of make all in the openposix 
direcotry. But miss this  --with-open-posix-testsuite option .


I think we should mention this option in README ie


./configure --with-open-posix-testsuite --with-realtime-testsuite
diff --git a/README.md b/README.md
index d45d1ee44..7da393e37 100644
--- a/README.md
+++ b/README.md
@@ -51,6 +51,13 @@ $ make autotools
  $ ./configure
  ```

+If you want to include open posix testsuite or realtime testsuite, the 
chances are
+the following will work:
+
+```
+$ ./configure --with-open-posix-testsuite --with-realtime-testsuite
+```
+
  Now you can continue either with compiling and r

Best Regards
Yang Xu
> 
> Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
