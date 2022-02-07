Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140F7C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 03:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0B263C9AC7
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 04:45:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD2D93C094C
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 04:45:21 +0100 (CET)
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com
 [68.232.159.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9859720015B
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 04:45:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1644205519; x=1675741519;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NiQjkXooumraxwJ4+a7phpH5TtRa0hJEH1TANqUFy+A=;
 b=kebQeBssF5jP+zH6WfHIPCyQhAV+e5T8lg9BSMe53ehxOFe8yCibsdJx
 pMWD5QRig5WsDmdVNRWWhqEO8fY+lgLSntzhtJ0xmWKJ6PQr/lNurs62E
 J3XacN1lCPM7aGbxeJ6Z5U8KOG3NVXlEbimivsn873OSfczM9WPScnfZi
 qax+2Rr66YaTWO3GQgsAIy//u5QaoC3zO0pmdOaJMns9/pg7rtTij3Idy
 Q1r7v4v6dqsPIhMUDLFJsSaTBAnKu8nK+84mZWElRJhGxgcUIvFAWrLU7
 pNX8YgUoBmpW+kpu+LdvGN49cZ/zOdPSd7vS150s7qyzMX/AWB5O1X1MW Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="49289921"
X-IronPort-AV: E=Sophos;i="5.88,348,1635174000"; d="scan'208";a="49289921"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 12:45:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAJys4KkacVxk5b70qNL1+TaNFED8lDdjjH8OeFU28x/MvutWBwA36Pjx1SBMbe3tgUF4iT6gNBb1NcEo9+a/M8GUIE+5EIXshJlCgWYVs7I8Ba8ikPXgWt++u/ZxsPiQtSTKH8pq9I+gXfq9q+tXjdI32x12WGAKRErzcc+LeE1iVIyXk1vs4lpwXXkpmY4tbvYqvbkOjopT+YEUAwNZSgxSxW3SF7kU7eJ61L47AUr7WSHYZwSA/vxdSsZlJ2dFUMJ6NjWlsSEnFBzJiQKHosNnbSTLCmkJGBPZx624vN58YZkhv+Bnp/8glXmLiERX8W3jUV60tp44FAPg1W/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiQjkXooumraxwJ4+a7phpH5TtRa0hJEH1TANqUFy+A=;
 b=nUKwBd/qsoRhFqqQFeDYMiNqL1xVS6Ljohvt9fOYYyIbaVSUnLWQ0YkdFxdUsdLp6brMVYBsSSnbcmHYvPOm5DL+W7DCeZmCMaP7k6iDt9W3cZXOEN+hUPe4Qx5lUfhqbQzydTCe+RftAaT4B2ABYRHcvYZEUfbOZ08cQqe9Z6gvw3k6+TuuoxK41UKj3d422OPKoPxiwpOnUI1jfrxiFGiygVQZDZ+v2n/NI0ZzU5xkji+jO1HxbracWuAuXjH1QH3T28Odr5H7A8lfGqrwWcMkDN5YpXEonNQzY3SXdVcsrrTHnzXYE+I0lRupRks2Y5gYt01bWTAypK4fkGx3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiQjkXooumraxwJ4+a7phpH5TtRa0hJEH1TANqUFy+A=;
 b=GOjdl/hctUQJpLdExO1xBhL38im4wiNLlMSONFbBrqwjEv7G9rXdQetud/d1IfVd3xH7LGnCvaisNjlWA9ATZVORgbfJC+j9v2UcKJca8D3XEQhuNxJMqoDH3pIBOWXhHzNj0cvCPwT0P29D5dxeTh0EHxQovV+vVt8tTueEAEQ=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB2529.jpnprd01.prod.outlook.com (2603:1096:604:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 03:45:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 03:45:13 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
Thread-Index: AQHYE6F3Ale6YWSYm0uorY3IlIxrwKx68E2AgAHOsYCAAfhUgIAARpwAgACGfYCAB/62gA==
Date: Mon, 7 Feb 2022 03:45:13 +0000
Message-ID: <620095ED.1040808@fujitsu.com>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
In-Reply-To: <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c7a0be8-f09c-4be3-821a-08d9e9ec3fb1
x-ms-traffictypediagnostic: OSAPR01MB2529:EE_
x-microsoft-antispam-prvs: <OSAPR01MB25294AA93BF6F543BB398C73FD2C9@OSAPR01MB2529.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFkXyyut6NzaREzaYnB7NwwrQIfUAeXYWEk5GNAEhsUElhrKjLAfjJdzIc7/+BL2UasLbk1PHXVPnb6oncLCtgw/Kscc4uik8FbczH1RSoVrUj1HS1SPBRCZjRjborO+I0MqEjw14PMFoCFFW5ezavPi8JsdqVrC/pJ5WReZ1WFoFTZGNZghS1nBRnR9yfEL+OjgEVXejA2kis9DPOZUfLrY1CHhTR1HtRQrCdZwYl8N/fiMm5McSG5yYZ2FZIVwo6z4V55QHeytQNBfhfsy3Qahk+NlnRsl9oERqQ3BpAjLZu00zSGNG3tXKd8srw4SL6zNGJTSLoBTAa9T3S6Q/aFAsM8bUeLJ9JpTXxkyVOmO/PQ2d9da7eywlcOQI14erDzOk8sBmqiAE5FGisOqABCu7yWHBpyAiQDl9MF7NMTmepWfAkuITBqQo0ZekGsrEl+2828B4tOBdGnGikE7K1X1cZ7+3hVxTRydFotTSliUqfSE8L2anyfzdOe0sBIfc8mrmkzAT3xE2iYEBEU6WHetlXCf5rKpZa8x9LdIplpmTMA8fZzWx4SLvWz4SCa1qPIGYxKJMPCGvMcuBrjZob46V5KLOvDH9lruRZ/kANWuWr8GZV0mqpjPoO3LkyFXVUubr5DenmCYktDdiRb7RYKEE3XV/DQwvkhcTQHRB+ORX55fGeKpbwlpXJjSbfIXiWMxVrLT0HJhm1ru6oh5dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(8676002)(33656002)(5660300002)(186003)(4326008)(66446008)(6486002)(91956017)(66476007)(66556008)(71200400001)(76116006)(64756008)(66946007)(2906002)(87266011)(53546011)(6512007)(6506007)(86362001)(2616005)(36756003)(508600001)(38100700002)(82960400001)(122000001)(85182001)(316002)(6916009)(54906003)(26005)(83380400001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnJkWDQwdmdzbERxNmxDQWFWcTVUWWdPQW9JVHJtUUpqZy83UmRkcE9uQ0dy?=
 =?utf-8?B?YWNSZjBIYVpsNXp5SnJxQmNXbVNGYk80MUduMGRaSElJWnpoZVlheEwrN25y?=
 =?utf-8?B?M3ZyU3UzM2pKSldBdVgycno4OUlCby82U2hrbEpLcXllY1ppZVNVcUlMY0FL?=
 =?utf-8?B?cUdNT1U4S0piWWFYU1k2MXBQUVhJTzlWM3BDVE9IeTY3ZHJCZFE2ZGZiV1BR?=
 =?utf-8?B?SmZ0OStOcUhYOTg5Y0lzakxvVVQzakVjUVpBUWp4Rit6dW9jMUorT0NkU05l?=
 =?utf-8?B?ZWxLSy92dnQ5Y01TRkpuVmlMY3FqbnM4amFZVEQ1emp4b21pdzR3UklFcSt6?=
 =?utf-8?B?THl0MXBLKzhxcDViT3VKQkNzMzVUMUF1cXBxWWlMZXJEb3hMeFUxM2g1M0x1?=
 =?utf-8?B?NDhicUVsSThWYlk1VURZUVkvQTJFSUJnanorYlF0YmZ3QTQzZFZubk9KWVVj?=
 =?utf-8?B?dHBpWkJkWm5YTUxhOVlobllQbk1JSjc2MnZIR1NNQTg5VnY1MGJ1cVprMWhX?=
 =?utf-8?B?R2IwWXR3ZFhGUVFma0IvdE1pOWNDT01VMnBzejRLSno3b3JFVTBEVGdiMWtj?=
 =?utf-8?B?cFAzYmtOZWN1YmF5ZktQMGZsM2tYNWs4dndWS3FiMjJMWEZ1OGtPc24zYjRF?=
 =?utf-8?B?MG10N1BiUmF6aWF2MlF1K1FhUTBkYUt1OFVHSFJ5QmxJNVVqdnlBOHEwSjNF?=
 =?utf-8?B?SHVNRFNEZWN3Mm9ML0xRUTNldTRjSFU1QWlaK0JnUHpacjlyRGFadTlQT1pw?=
 =?utf-8?B?cEwyd0loQ3dNQVVncks1aEIxd3RvWjFOK0lWY05YRTlSbUxDS25ZL04zVXJQ?=
 =?utf-8?B?MkFDRE01UW5VMVNqQlFiSlpaWjJQRjRhYlg0UWJuZ3dMenJaN2QrOStoMXI2?=
 =?utf-8?B?RTFEQTFBSU0yTGE5dkVxZEhxTGFCK2EzVy9raFVkeVZPKzkxUWROZUE4YnND?=
 =?utf-8?B?VzhNRTN3U0NBRVNGOGlOZFZkbWlZOEFaR0VGUERBU3R1Z05BSGRiM3JNN20z?=
 =?utf-8?B?T1lzcWtha2gyOFEyRk9RWGlhWFZIR0FsVzlNZ0JyTDRuT3hRR1RNdlFRbk1F?=
 =?utf-8?B?VmFjU2JPWjgzRUtPbThqMVRVY1k4TTA1UW1rNDhXL25VR0M0MGhrVTk5YUtD?=
 =?utf-8?B?UkVZN0hwRzlETWdqZDdvbGI4aXd2b3hlTzhyN0Z4Y29kVTdNMUwyT3J1OEdW?=
 =?utf-8?B?Z29ybjFBNTVsRFo1aGNGYlE4SnJDNGlKVnFxbThaVlZkVVdwSUo3MU9iYXJ6?=
 =?utf-8?B?bUNmRGcvc0t3cFhLbS8xRG51OWdKUFhqU1RLM291TGUyQlJLOGcyNDdtWHlO?=
 =?utf-8?B?N1Rha01FMUFsUTJVUFFSUjFqUDVIdVR3dG9RNzZLRGlUbXlCSXQvdDQyNG0r?=
 =?utf-8?B?OXZ0amo4MHZQamhGbmZEdnh1WHhsNXRNb0hXajdiTDZYM2p2bW9mMnNpUkNN?=
 =?utf-8?B?S0kwdzUrK29VRVlvVkovNEFvcVNRbUs2a0NxY0VvNkVtMXhLNlN0SWxZR0Nv?=
 =?utf-8?B?Ung2Tnc4ZjA1VGJFMk14QmZUelFSMEhzSTVpQi9sV1ZrWFhGS0laZzNKSW52?=
 =?utf-8?B?K3lreldyYithWEYyN0c5dVg4Njc3c0o5bFVOQjFoNTF6dGo5eFViRm1GRDJR?=
 =?utf-8?B?enFRa2hyeDA4djQrZjhiTHNXajZFUzNHR3IyVjBwK1M0dCtDU2I4R3JXREh4?=
 =?utf-8?B?dUF2cFk3NnZOUmhFK0lINklLL3J1NXZzMFZkM21GbkJkb1FTVk8wVzVLR2Nm?=
 =?utf-8?B?a1VIZFpKY2FCN3BWbS9XU25TUDg1QkhycmZmZTNtdTM4NlZ0eEorNXJHVUNP?=
 =?utf-8?B?eVNkMmRuNGJpOGR3UE9ZN29Yb2p3b1kwM2tVdk9CSFhObEV2Y0tkUThzR0kr?=
 =?utf-8?B?emJXaEhFMnpTYVY4bU5sMUcxTGY1S1k0NjZEYXlycjlMV05hSExPYm51M3Vh?=
 =?utf-8?B?dDN3bUcxajB3cGdTQmY5SGZ6bjQrVzJYUE5YTEtISWxRVEFXS3BsOHQwdlhq?=
 =?utf-8?B?dUQxNkpPWFlTanFwQzZGdUNkeDVzNHBBM2NSNHBKYWxYY1B4T0tRTWFnQnJ4?=
 =?utf-8?B?ZGsyd2lKZ1Z6Y3YwNWRicndUbHVZZVRUQmw4clQ2RklUWmQrOFJwV3hTN1VF?=
 =?utf-8?B?OVdaVERaOFZyYndPVVg1WWRuUzE5NHI4UCtIaFNyMmoxcUZCWUJGMmVjT1dq?=
 =?utf-8?B?MVU1WXNTcWNsSno4ejRhYWZmR3ZaNHFlL1REaXhESjVIRWJqcnRuTjhSOGRY?=
 =?utf-8?Q?XZiDWwLBu3hGdN4fP5xmBl3HdDdll5DNzoUVi6aeWU=3D?=
Content-ID: <3264D91A78590143975BF603EBC935FE@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a0be8-f09c-4be3-821a-08d9e9ec3fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 03:45:13.9006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ao6v0Pr6zFWx3QquJwW40FRNk1Eszzt1cNv6pEgvSTvEisXK4ZRIhtxOAePmQ/gcwBjb86m7LLosjQttKRfMCyZ5J8CO6SZQ2lOXQE9vr4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2529
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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

Hi Li
> On Wed, Feb 2, 2022 at 1:39 AM Petr Vorel<pvorel@suse.cz>  wrote:
>>
>> Hi Li,
>>
>> ...
>>> Yes, I understand. So how about this way:
>>
>>> --- a/lib/tst_test.c
>>> +++ b/lib/tst_test.c
>>> @@ -785,6 +785,8 @@ static void print_failure_hints(void)
>>>          print_failure_hint("known-fail", "hit by known kernel failures", NULL);
>>>   }
>>
>>> +static unsigned int test_variants = 1;
>>> +
>>>   static void do_exit(int ret)
>>>   {
>>>          if (results) {
>>> @@ -811,9 +813,11 @@ static void do_exit(int ret)
>>>                  fprintf(stderr, "broken   %d\n", results->broken);
>>>                  fprintf(stderr, "skipped  %d\n", results->skipped);
>>>                  fprintf(stderr, "warnings %d\n", results->warnings);
>>> -               fprintf(stderr, "not run  %d\n", tst_test->tcnt -
>>> -                               results->passed - results->failed -
>>> results->broken -
>>> -                               results->skipped - results->warnings);
>>> +               if (tst_test->tcnt) {
>>> +                       fprintf(stderr, "not-run  %d\n",
>>> (tst_test->tcnt * test_variants) -
>>> +                                       results->passed -
>>> results->failed - results->broken -
>>> +                                       results->skipped - results->warnings);
>>> +               }
>>>          }
In fact, we don't have mandatory rules that TAPSS or TFAIL only can 
occur one time. a example ie memcontrol02.c

Best Regards
Yang Xu

>>>          do_cleanup();
>>> @@ -1529,7 +1533,6 @@ unsigned int tst_variant;
>>>   void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>>>   {
>>>          int ret = 0;
>>> -       unsigned int test_variants = 1;
>>
>>>          lib_pid = getpid();
>>>          tst_test = self;
>>
>> Yep, ack this one, works well. Will you please send a proper patch?
>
> Sure, but I'd hold this until Xu Yang review. In case I have
> something thoughtless.

>
> Ps. He might reply late since now is on China NewYear holidays.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
