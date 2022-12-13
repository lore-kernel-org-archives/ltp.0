Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29942C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 02:35:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E064F3CBE7E
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 03:35:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AD243C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:34:51 +0100 (CET)
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com
 [216.71.158.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89BF6600697
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1670898891; x=1702434891;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=N6tRVZ+HDaJB72YJPSn8tPet37LSf55dJ1l4wtYJ95U=;
 b=HR4B4q22vvb9MZnhDjFk9aqpF7Moirg5zhk/FvcF1HuTnqJ8IUQQ90dQ
 O36hUi5Rh5VbP+Rf+C7U/a7MM0Bc5MIb55HoPA0yUptHY78LtTgjAFvL+
 AmGzsCz3BZUdudCjdnEqtDlWlSL3a655HtwqCyqpcZgHVB//Kk2KWtjwX
 +HAdTXE5HEsI+mOLl/Hcqkz1vJ8xwE8qy0i8UDfu/K0ReYyaQ6wsEyYN5
 otthkxrg2FrqFnhV39aJvTU4CoQ6IfgPHom9xG9GC+X3s1JNKmPRl5QuF
 vsKSyF65a4fm9Gl9zBWgYVd9hVsXuKZ1KjMXdUVzCXOBiCNfhGKs5GRzA A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="72179239"
X-IronPort-AV: E=Sophos;i="5.96,240,1665414000"; d="scan'208";a="72179239"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2022 11:34:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duMD79MP7vwc+2/VrfwC3fD0q3OUxwXI1ZztTk14A1IShalVQAfkfp7faxnpgqjgwwU4zWxsQd92bAyMZJATVuacmAWmVFMdqTDhs2vFb1SjX2yVtOVcyiywknPCBM6GnK33FeWGbUv+QTe9A0GDAQ3AjSzmqkCHeukAlusZauI3abxmkjm4p722mwIDzpN3CRPkZb5KJvLxuH6CicNulRfxj5xuQedRZWqQyUH2gc4OCuedW2amJDznTI+aLGMAizVxM4NUYtJIv+kDrRbSrD+ALQz2R34ckP1e1XQADlZ3tcTcA+riApURqu3pMcvQwYkYn1auBZXEj8vX7IXHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6tRVZ+HDaJB72YJPSn8tPet37LSf55dJ1l4wtYJ95U=;
 b=N9NLy9MCez2F0vhurUBBCncCvQ5gHLN1wES81Sn0NbgXjV/Mg4U7AX2Kqzfu69oRLhF8Bl59BtTUJlSGdcf2i9ZmebyMZkBxwoG19sza8D+weLn1CwhvQL5JbWRtAzMGjkT2fYXHUMNqYvx5bINjtN+3B0DoYpnEyvV0IgNEqL1JHdO+o3djmwApXFq0tpdpJcTFCYl8hgbkGWooTVKHY0qSbf/xnUixfV5eNpimfzblZFiyBqUIBLpoOA4hT6NTdOcpwZXJffpsliOIvBa2FDeeRaEcqLjIEPDbXxqU/lfnar8NXDo6T5atsLSnIfDA9iFDIS2vo7ta75fp+7QVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OSZPR01MB8846.jpnprd01.prod.outlook.com (2603:1096:604:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 02:34:44 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::46b4:9cb3:b477:46e0%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 02:34:44 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
Thread-Index: AQHZDhYNQlQrgTPXd0SqHAD1TBgbAK5qYR0AgADKvQA=
Date: Tue, 13 Dec 2022 02:34:44 +0000
Message-ID: <d12448ef-92b8-c7a5-1012-8bc31fb6e2f8@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
In-Reply-To: <Y5dJDFk5DpAhTKDV@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OSZPR01MB8846:EE_
x-ms-office365-filtering-correlation-id: d5b2efb2-1996-4291-9b2a-08dadcb2984e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yu3EBHJJSlVj+Clp6lR7RBu4TQAZBR43PRnt4eu36JQCV14DTcnSwexP8nQogSg+PrjpAvPSZvsGomOGt5gyAbZ2ZzW8hwEtdRfCwuvyn4qypgIjxIcfeRp5XQSQb2DBQer04NlqwpPgV9ydbDt9ylcgEokDBPkZCCVB2DMDFDmGECZ3Oym/8VhjhnwgK5raTc2fRqq9e1UAEkBb6KsM9g1B/leEJo8SJ03NzWU4DUQ3vuGyJ/iz0cMXDA+Vmdby1BDwTwYwZ9o+3FDbdV2EMHai8EpwBh4bIHg/lkh7tnAVp2pllKsl7TpPrXAkLfOhMfdOUIFxPZuwWpSxq5RRoqjfGF8zSwFzQM/CIgSfTqQRuoOK50ADqOlIknUFILgfZmpj4+3+AwN9PoPIw1hNJ570nxZwS/zuLAbv6EIhoOEzoIQal1m1kz4Qf10aP97Bw8i30IIkMZwmaiRaggEp8UIYgj8FYXwZGZfPQnNhu+ZsZ1kr/gqR0mzVcaDcrsKP70Ysg9PyufHhucknOXeoMfAldQtvnnOsPDJy9gSqQ2nu4v92NP5OjPHu7y/hqjCkWWwo11E43Gcl/n50+VCeKctH89YQPJB3Ltmh2kSfhq7dPrZifTF4/+/ui8IgdiG9HxbTERxqnIo7O8p071kYbOyCUUQLKsvySUpEcbHfjItPx+Ktf7jhUPj3lqNjjIE+IhBiUJqf+4Z+HNBWFUCWcZAG5tUjOfjlLrs+VvLmk4iXu7PSwolqAdaUQC2xXFNwdCxEwoKZ3lMHHjFsbfOcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(1590799012)(451199015)(26005)(6512007)(6506007)(2616005)(186003)(2906002)(478600001)(71200400001)(36756003)(85182001)(107886003)(82960400001)(38070700005)(38100700002)(86362001)(31696002)(122000001)(83380400001)(41300700001)(1580799009)(316002)(91956017)(6916009)(8676002)(4326008)(66476007)(6486002)(66446008)(64756008)(66946007)(66556008)(76116006)(5660300002)(54906003)(8936002)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YURmeFhOMmVBL0RwSkpscmpONm5xbkQwelJTNktxZ0ozQ2VrMXpNSVQzRmlv?=
 =?utf-8?B?dU9yQlBqZVFvNXIvQjlrVGRycEp4cHc1K0plLzlSL2VBK0Y3SkVrampPOUtn?=
 =?utf-8?B?dFBad1g5SnYyYlRvU2Q0L3Z1WXZPbk9JNE1MK09UMzkxUUtZZ0IwQmpnVmE4?=
 =?utf-8?B?ZWkyRGF2ZDFXZnFTeVJaSWpQTjlxcG1ONW5RdzlBeDI2U0ZVZHRxZFg0M0JM?=
 =?utf-8?B?SmNxZWYvZkNiaXE5RVpCc2xzN2pmazRPMWVFZVZWbmJ2bFg5R0tOOTB6NWV4?=
 =?utf-8?B?bld2Wkw5MkNtNmwyZDJrWlJMeGloOTBycUhjVGprNXFkMThvdEEwTDQvV0ts?=
 =?utf-8?B?b2U4a0F6VlN6Um5hQjdRUkw1OWRVZTJJWnVYaThtZUc2ZTZwMkVWTWNBN2ZP?=
 =?utf-8?B?WUd3aC9jQ0NaenlrdXc5ZERrSW1naVJMOU9aSTlNVFdmM1VCMnpNbk4ySzJl?=
 =?utf-8?B?MWtWa1JJM3J5Y3dJRC9sQmlFNU1VM0dNelNTOFJPM2MwZm54OG4yaVNsNTlS?=
 =?utf-8?B?S1RCUWpLb0htbkNsMTkzSWJydk9KbWx3MjFQQm1rbEpOMHJ6L2JRZmRxMTFl?=
 =?utf-8?B?UGN6ODJ2QmYvV1FXcVF5V3dXa2lnbnVZN1o4cHM5S3Y3djRIR0tNMjJqVDRD?=
 =?utf-8?B?dlJndHpiaDh0eWNLZTFxeStqM2s5R2tKdU90R2lDZmlpc2hvck8ySUpOWnY0?=
 =?utf-8?B?RkhsRnplMDd2bmJMeXBJYUZHd3A3cWlwWnNhWnNRNXRZM0gwZi9uN2lheGF2?=
 =?utf-8?B?Vi9mY24rUTdYRlB5bW5PbnlOQTFxUWREcFFmVmFJRjhLelB1czVZK2FvbzN6?=
 =?utf-8?B?REVkVlB4M2VtSHZWZ0k4VTZvZ21VNHZXUGp3ci9WanVrQnp6bG5nbHlJb2hY?=
 =?utf-8?B?aGl2bG8wd2F3a1hDTk1ER25oV0tZcjVIYW1oMlpyRTkwRStWcXA2ZXFlQ0Vl?=
 =?utf-8?B?OWJ4OWVtT3pmMjdneGh2TFFsODJRR3VqeHVINXlDTmJDK2JMQlY4S1hVU1pi?=
 =?utf-8?B?OVh3RjZ2aUxPanJCazNLSnZaQ1hiQWkzYUM5MUl2VHV0MHpERGJVUHQycitl?=
 =?utf-8?B?VG1CVGl1WExhNHNqdTlvVmpORXk2U3YwckNGVlJWaUV2aCtVVWpTbW50N2xP?=
 =?utf-8?B?YlRXU2pScVJvV3dSK00xVDk1WkczNE40WGZBRVN5aU5OanEzQ1ovcSsxRnNz?=
 =?utf-8?B?Y2JXd3Y3d2RCVDhQNWthY3pGVjUwNzY2RUlQZXczcitnaTZObUFjK3NoRnRK?=
 =?utf-8?B?cTNEa1FhTTU0cHJWVHhJY1R0b1FuQ1VwM05paWlCWDhZR1lLYTZWOVhaSHhT?=
 =?utf-8?B?MnRsYm9GMGt5Y2J4WkhEWTFVUVJ6c20xREg0bGVYMzVURnNnZ3AvWW42emV5?=
 =?utf-8?B?eThLaHdYMjNDdENzR3FhMmVxbEtydUZlRXJWWHRSMFNNSjI2MDF5V2p1cUxk?=
 =?utf-8?B?SnZzM3pTVEZxaTk3TEllay9aWGtMSEp1bmY5ajllVFROQ3lIMTBsTUc0ZUZj?=
 =?utf-8?B?bExNSy9lM29Sc0ZsL081NlJxTS9sZEhXZTFmbUd1NllXNnJvRGpZd3AzL3Iz?=
 =?utf-8?B?dE93bGs0SVIrdU9vS1kyYURacENoMzY2WkJKdFU5ZTFWUDYyVGpJeUNtOUN3?=
 =?utf-8?B?dkJNUW1USWp1QVRrSFBTbkFWWjBDZ3hhU3VxL3V3Z0lMUlNqMzBHdDFwcXlL?=
 =?utf-8?B?WExYa1NTRjdESlE2V2dMeTEyMFdpQW5uQmNDRGlaenBpV1U4bkc1UVhGZ3Fu?=
 =?utf-8?B?N3JzV2FyY2hIZEc5SGtYc0Z2Rk9wUTdNVUJhZkJjMW5CTXh2bDVGSGtSVmsx?=
 =?utf-8?B?UG15QjdKekxlekxKTm9wczRSYXZseUkwbGtvVmNjbGxqbDdNNFNQTXNNWnJY?=
 =?utf-8?B?bmRra3E4bWFTYVBPSFJ1MDk5dHBHVG9xR3JhaVZOT0ZuR04zNFo3NjVCb1c0?=
 =?utf-8?B?Sy9uYWdFYmNXdUZDTktpc0VvSHZtdkgvZDJNYUxmOGh0QnFXb1h1ZHNSbVQ2?=
 =?utf-8?B?SUF5eWpmVmlGOFE3VGE5Y1RROUVnbHlOVXdIUEJFK0F5RENQR1pPRGxGaDFU?=
 =?utf-8?B?TFl2Vys4LzhiNzNuWlRlQ3BpTDUxR3JCTzh4Y0tXTFN6ZTNRZWpMb1YzeUor?=
 =?utf-8?B?czVnaG9pd1MySlJVTEdXc2tWdnQ4TjB3SlZFbUpOcStXREJkOG5pQUR4NGdS?=
 =?utf-8?B?alE9PQ==?=
Content-ID: <6EBD7A72C8D8D54197740BF9F0736D11@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b2efb2-1996-4291-9b2a-08dadcb2984e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:34:44.3768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dwtUZd8UZYs+O5nTUDRb1yDXQQhOWkrvee51ODJDttBPdpjBBqdZ2nnmJswHX4xhZWeW78S1HG+AWhHW+jrrbuNE5kfRoUmFkJZG7mZYyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8846
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi,
> 
>> Our travis-ci has dropped or never used them, they are useless.
>> So delete.
> They were here before CI. They were meant for using by tests
> (no CI related at all).
> 
> Added by Wanlong Gao ~10 years ago. Agree they can be dropped, but
> Cc Cyril, Li and Jan.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>> ---
>>   lib/tst_kvercmp.c                                   | 12 ------------
>>   testcases/kernel/syscalls/inotify/inotify04.c       | 13 +++----------
>>   .../kernel/tracing/dynamic_debug/dynamic_debug01.sh |  3 +--
>>   3 files changed, 4 insertions(+), 24 deletions(-)
> 
>> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
>> index dc0daa746..a01b4332b 100644
>> --- a/lib/tst_kvercmp.c
>> +++ b/lib/tst_kvercmp.c
>> @@ -134,18 +134,6 @@ const char *tst_kvcmp_distname(const char *kver)
>>   	char *ret = distname;
>>   	char *p = distname;
> 
>> -	if (strstr(kver, ".el5uek"))
>> -		return "OL5UEK";
>> -
>> -	if (strstr(kver, ".el5"))
>> -		return "RHEL5";
>> -
>> -	if (strstr(kver, ".el6uek"))
>> -		return "OL6UEK";
>> -
>> -	if (strstr(kver, ".el6"))
>> -		return "RHEL6";
>> -
>>   	if (strstr(kver, ".el7"))
>>   		return "RHEL7";
> 
>> diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
>> index fb9f5c293..c4fce399c 100644
>> --- a/testcases/kernel/syscalls/inotify/inotify04.c
>> +++ b/testcases/kernel/syscalls/inotify/inotify04.c
>> @@ -50,11 +50,6 @@ char event_buf[EVENT_BUF_LEN];
> 
>>   int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;
> 
>> -static struct tst_kern_exv kvers[] = {
>> -	{ "RHEL5", "2.6.18-132" },
>> -	{ NULL, NULL },
>> -};
>> -
>>   static void cleanup(void)
>>   {
>>   	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
>> @@ -110,11 +105,9 @@ void verify_inotify(void)
>>   	 * This isn't well documented in inotify(7), but it's intuitive if you
>>   	 * understand how Unix works.
>>   	 */
>> -	if (tst_kvercmp2(2, 6, 25, kvers) >= 0) {
>> -		event_set[test_cnt].mask = IN_ATTRIB;
>> -		strcpy(event_set[test_cnt].name, "");
>> -		test_cnt++;
>> -	}
>> +	event_set[test_cnt].mask = IN_ATTRIB;
>> +	strcpy(event_set[test_cnt].name, "");
>> +	test_cnt++;
> 
> Isn't this unrelated change? I guess you remove it as part of cleanup of old
> versions.

Yes, just remove this useless if statement.
> 
>>   	event_set[test_cnt].mask = IN_DELETE_SELF;
>>   	strcpy(event_set[test_cnt].name, TEST_FILE);
>> diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> index 4b159517b..ca6c840b1 100755
>> --- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
>> @@ -59,8 +59,7 @@ setup()
>>   		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>>   	fi
> 
>> -	# Both patches with changes were backported to RHEL6 kernel 2.6.32-547
>> -	if tst_kvcmp -ge '3.4 RHEL6:2.6.32-547' ; then
>> +	if tst_kvcmp -ge 3.4 ; then
>>   		NEW_INTERFACE=1
>>   		EMPTY_FLAG="=_"
>>   	fi
> 
> Maybe first remove it from tests and then from infrastructure?
> But I'm ok to keep it in single patch, but commit message should be
> adjusted to not mention CI (not related to CI at all).

Yes.

Best Regards
Yang Xu
> 
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
