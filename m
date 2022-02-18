Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D911C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 03:24:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91DCF3CA10F
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 04:24:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9358C3CA0A9
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:24:28 +0100 (CET)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7A82201207
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 04:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1645154667; x=1676690667;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bu81sWo5BHANtgHVga33TlkLx5Wbp1xfVgSuliJzNcU=;
 b=rfNCLllNihKRp8/8MuXHm3zy0sq3sUC1ZzPLb/KttJ0xxj7NphiJL3oC
 hqh1fHYpuMj+zbYhmYqQ2/LTR/LbBs9n38ngmhUNfdf9pXHYmZ6cJMMdu
 1w+cLDeC0aXEsvXfdR2TNqhwSQZnMcOFZEA3/uxfkFokg11UfpBZf04VY
 U9ad8DEzHy95BfuC79X/HSaec4R9r8/qrAKlWVUThyFwfvDy/5W5QTzMB
 ke42Wg6Op4p1QhLdBYOXhCgCzSIJA8cLo4KkvaCGcLNc2rlKYBrwkTXmR
 kDrIisz+h4uIMRwne7qkc9B19GE78nxGWRMLC7V/GyJTIPklRDPx0srM/ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="50005808"
X-IronPort-AV: E=Sophos;i="5.88,377,1635174000"; d="scan'208";a="50005808"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 12:24:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im0DrlEdnwIOpL+fw+MhCuVgHCwtnhdyOEh77MQOm466zjpY3MBn3xA+APJxIqMDJXMkAaKH2UVa38l4ijN+qMV4I/+uazmjFe/zdZtVUlKFGpJiTBRQk+gMIhyzGr1H9bUXXHocSbdriY0j3ua9rEcL/ho5CKTfpqzfTfWpwqg6oFjUnuQ+BgLn7eFImuT/GbEqYSgEYrR042N6e04/HE/jg7GI9xeX5leyBTX0oj5AisPtm/ILzph2j150jJBizdGVMzOtUVUz/TDNy3zD5iq8ofkoj8A8/1WR6wGQtoArN5O1TK7rF4JAvp9JlLSyQUOkSft4bmReG/JEN47+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu81sWo5BHANtgHVga33TlkLx5Wbp1xfVgSuliJzNcU=;
 b=jgY4On/h3Qsw/VtaTRJXazrZ4maL7WGB0XUZsY4SkUv0dTBBaev5tVqnXbChprkapzvPIIG5JqRbZofYEoDG/jL5Gqv0SedkNR+5cK0ZXgxuOvHeTZyABmovV6uOMm5vDBXwktDOxkasK6I6dE7cDvXu55uuEbRZ6aL9YRP3ZBDHfrZdWm+mdwiHo/nBRHbzLOgOUoCbRYkmD7uz1bmZS9N/LkjkHgQuAkpmPXCBiGyTsKec6uwqBh4tm6/hAfY6kasIgInudu7er6IUSffbAdbyLe+9b9f3Q8PSdkCsR4+5Z9bvgGu1LRgAWp2nIdvqTeX/v83FnOndjV70a0RAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu81sWo5BHANtgHVga33TlkLx5Wbp1xfVgSuliJzNcU=;
 b=bEfmmQzQxik7Q6/MxgQ9VmWjVXiXR+ceIVmjtu0Kiu/GAtC7E+DuZN9tqDPw3Y7fUIDEpIPArKqB7X794WuvIRNbRTRlBYvA0SgqNsf/GpScCrAOcbPjyt6a51RjaYF2rfcAvJX5+mEYSEYhOn+vKiL55WUW9zOf6EtI6VzWq4U=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB5798.jpnprd01.prod.outlook.com (2603:1096:604:c3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 03:24:21 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::787f:42c2:70b:1fd7%3]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 03:24:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
Thread-Index: AQHYIxyo0AgRBKwaoEiby0F40YV9n6yYIIkAgACHeAA=
Date: Fri, 18 Feb 2022 03:24:21 +0000
Message-ID: <620F118E.3070306@fujitsu.com>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik>
In-Reply-To: <Yg6f6p/rdFTfzkoR@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b52f13e3-4136-4710-7396-08d9f28e2790
x-ms-traffictypediagnostic: OS3PR01MB5798:EE_
x-microsoft-antispam-prvs: <OS3PR01MB57986E96012F6B5D2874D04EFD379@OS3PR01MB5798.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2ziWUtm/eEllZ2r0Yx7zQEnLgDwC6YjMpsCKlfDHdz+479K0WxrS36OWbN2LXa/cAaxaxt5kGg2bf5ySmEz+TqarP1I5FVwdYBlMFRrYvWrad6OIyNArt1o1Sjkp0k6OV6y7C/qbdewOnDubQ8JOcvIHEW7syfGUYnhc/ri98rSQwZYTZ2PM6rvBLtV7WuesCNdemOeYIdA4vismAJxDPlsLCAOG1aeCsBIdIk12uj5q5WfhYPUzWM5Sz4FWXC/y8phsgqidZBkoRAvr3ieS+q/KaQ1xugrJYpfTFddlLn67mrjxfHcAVAdJMldfNOIjDW0S7VsUjC9eqoYrNEAUrJD+olqjVbAB2FbnUv4o9zErhayrdnNmuilOh8DfHYxRWNhnI71tudXEuuku+Xm/kFJwZNNnLE0EzSxSxjHGQiKNrUZsTcKfXA+EjfuD7xxMXPHD1nYEjOKV1RaxrcmwxKesTlkzRyWzi162u/P/5rntWho9Uxf7MXBgqx9L9+4iMiKkf/2o/QCjEG5GI5gs6tNNnQh0G+aLeCPoufv5hppKY1Mp8iBp+4I4iMutbHRxj3r0Osb4dzuv6DuE96I8FeRwX10oenw0l/DQzXOrUH2mjHulyW9/oUoM9FcArYgNG9fxzdEK9BZGsoxbGxFZbpDagb4V9+lTIvI1Rxfcjb9nxlk1pJO496+/9t4w4aIIn729juxF83tsFz5G7ViAKKLFyijK7v/lo5gFqQL+A0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(8676002)(8936002)(66446008)(4326008)(71200400001)(26005)(66476007)(64756008)(2616005)(186003)(66946007)(87266011)(6506007)(5660300002)(86362001)(36756003)(6512007)(38100700002)(2906002)(122000001)(76116006)(33656002)(85182001)(82960400001)(83380400001)(316002)(6486002)(6916009)(508600001)(38070700005)(91956017)(3076002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Q3RUWXl6dzFyd0VsMXAzTVlMVWhZWDJzcGZXYk5HM054bVpkNGR3WjZjMWRM?=
 =?gb2312?B?M3NuTExGL3ZtdFpoZXl1TWtKNDhpYktBbXRQRzBkNHh1cFk4S240cnhYd084?=
 =?gb2312?B?R2s4N2R1T1FtZ2xiM2Y1ZHQxY0hub0I4OXJxRGNrQlhNekw3TnAwYjdHUGpP?=
 =?gb2312?B?TDY1RkVVd0pwRWswa3VvVmJKamJLMFlqK3RvZ1BYSGxhVkVtVGhucWc0V0Vv?=
 =?gb2312?B?cnliZklPTzBVdFVSVDlNV2N5NmkzWlVpSGVscWh1Y1lTOWdXWjNna3Z1clUr?=
 =?gb2312?B?dkF2dzl5ZFVxMXB1QXhsbTRLUHRSNmtqU3FYcy9Pb2lKMldFUlUxTVoyM1lB?=
 =?gb2312?B?dkZNME0rT1FnenB1ZVdwbkpRZTFRSW9NK2d2N0tNMTF4a1dHRGhsU0FxRWFn?=
 =?gb2312?B?dnRIcCt1RWhNaVVHcFk1b0QzN0JlbmFWYmVRNE1DSXFkc2doeEJudjZDQ2c0?=
 =?gb2312?B?OW9JNE1panVma2dEdUI5VWgya0FibTZiRUp3SVZqZjYxcnpqQmhsbVluT2lk?=
 =?gb2312?B?NVk4TWU4amg3RzljRkRMMloyS3lSMnlHMEE5b0ZGd2IzOWRPRnF0cmJZNDJy?=
 =?gb2312?B?RTRDOWpLZEtBd3pneDcyRlhhUUN2TkVYbjNxcTgzMTNwNUlyNjFadjRNa01l?=
 =?gb2312?B?a1JpYTZ4dHFnWjh2dWVyWnBXM0tzc056S0pPNGNid3k3aXN6NzRjaUpzUlZF?=
 =?gb2312?B?ZlZBUTVTUXhzcDJUR2ozY2ticisrTEc0bzFsc1FxVlVrUWNkekJJOGRMbjlQ?=
 =?gb2312?B?RVovMFNra2dFVHVoRXJJWlJkVmRXaVEyODQ4ZDJraGRkWWRUeC9zUm1PdUUx?=
 =?gb2312?B?SDNHTkhPMWM2WVk0UWpsTnZadkhZMktzZCtOMlJYNml6WlkrTm9oa3EwUkJU?=
 =?gb2312?B?c1hMTnVvZ0RRb3RIQzRpOFdhbmNoUEhiZzFNTXRYRkhxN1VXMFNuMTVuU2or?=
 =?gb2312?B?VnJ4Ly8rSldpQnZTaTZTZTZKN0JKR0FTazhmcHpDQmpiQzBxdEY2S3NFUzJD?=
 =?gb2312?B?RVIyMDF4QVQyV2VJVXpRSFc4V0ZLZ1RKeUN6VXBqQTZvTDB1Wk83TjNOeVE2?=
 =?gb2312?B?TVh1Y3Q5VVlLL1Z1cWx6clJQNEV6QWZaTHQrcmZYa2lnNXN6cU55dVdFcGdM?=
 =?gb2312?B?MTdwSjRTM2VWVE9LUXlsbEFEZGE0UEJTR21zWHdJUTRGUUJJZmZ4UWVLdWxr?=
 =?gb2312?B?YVJYcGlvb0tDZVA4QXhGbDVPM0dLUmwwbzBENGkvWW1TN2hSTFdqLzNUSEtC?=
 =?gb2312?B?aDd2OU5QV0hOWXpZUXM5cHhWVVZtcG1TYXZCaHZTNThXSzlpQ3haWG5wbys2?=
 =?gb2312?B?ZE5kY1dNM2hxTVREMzg4am8rUDlEaUdLaktSaGZWTi9qMFJ4ckhweldYN29Z?=
 =?gb2312?B?eFBUblJha0pjeG5RZnEySy9OYWFiZXlvZnR0ZHIvTmpPbXRILzJpSUE0ZEhp?=
 =?gb2312?B?VkRzeEM0anBVclNGYS92TEFOQ2RZc0NYVTB4N1AxaExGNmZxbXBNcGdJTDRy?=
 =?gb2312?B?eWNPWXVJa2RZU3J4TkpEaWN1TkwzUmszcXFaVDhlak5nOUM0eTRiYldDUGxX?=
 =?gb2312?B?aDJONmlLczk4cnpoSU5BeVArcW95L1RuZVg4Sk9UNlorNm05aXVYTTUwSVZQ?=
 =?gb2312?B?bkNweHBMd2tiNXIwanluNkUrMndKb2JFYVIyV3ovTjVXaGpkdDBaVWh0bi8z?=
 =?gb2312?B?VUhGM01hOUc2RVNRZlFSOUxxRlY5V1duMzJiWW1CckJIS2l5emhMVmo0TFoy?=
 =?gb2312?B?ZFBXajEzbi9Vb2syRFlyR0tNMVdMRG16WjJyOEpIUi9FUkN2VEV2S1Nja1Ax?=
 =?gb2312?B?LzBHWndTbDZFUk1mZXpuYVU1TlBpZms0ekhyUk96NEhYWTN6Lzdib2JISVNN?=
 =?gb2312?B?cXJUZ1duRkkwTVhoMXBnRzFYQjVJSHJyT3RFKzQ2cnJ6NW1DRGdIUFkwN2FQ?=
 =?gb2312?B?YnlRNkZINHBWOCtmd0J5Mm9zVFJKcWh5Q1pBQk1TS3liZCtRZ3VEcFJFWTg0?=
 =?gb2312?B?emhyQXJKSDlXVGs5SFdPTmV3WFp4QTZMWC9vSEtMSmdMb0RHcXl6ZldKK21G?=
 =?gb2312?B?dTlRN2dISlNZbXhwUUkzQldOc3l2SXFuT3NDWlM5OURTcGVYRU5pcllUTnB4?=
 =?gb2312?B?Y0VVek5Mb1h6MjlhRHlEWFFUbDBianE2MWVMMFdBM1hxL0hjZ3BJNzhoYWtF?=
 =?gb2312?B?VFZTSWx1dGZreVFZNmpHMlRodEZvZ09iMlQ4bG9DZ25wcjlPSDJnc0tYQ254?=
 =?gb2312?Q?gLd1nfvcMS5rOrEQuZISA3JBq6Q2XYz/vkqtyxNZag=3D?=
Content-ID: <7E6F6F365E16DA43ABA1357BE4A5F503@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52f13e3-4136-4710-7396-08d9f28e2790
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 03:24:21.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/DLxi7zGABFWc/4IpJcJlGepCToC4gEILgPuAXlV+h0moZoJAeM8FyfLPYVm8b/DXRuqOLbRyepTFWLkjBNqAdAWvZCQGJDW0AXRXYANec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5798
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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
> ...
>> +++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
> ...
>> +	remotefd = TST_RET;
>> +	flag = fcntl(remotefd, F_GETFD);
>> +	if (flag == -1)
>> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
> Just:
> flag = SAFE_FCNTL(remotefd, F_GETFD);
Yes, I almost forgot we have this macro.
>
>> +	if (!(flag&  FD_CLOEXEC))
>> +		tst_res(TFAIL, "pidfd_getfd() didn't set close-on-exec flag");
>> +
>> +	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
>> +	if (TST_RET != 0)
>> +		tst_res(TFAIL, "pidfd_getfd() didn't get the same open file description");
> Maybe just:
>         TST_EXP_PASS_SILENT(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
I think we can't use this macro here see below(kcmp manpage about return 
value):
0 v1 is equal to v2; in other words, the two processes share the resource.

1   v1 is less than v2.

2   v1 is greater than v2.

3   v1 is not equal to v2, but ordering information is unavailable.

On error, -1 is returned, and errno is set appropriately.

So 1,2,3 are not invalid return value.
TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
if (TST_RET==-1) {
	tst_res(TFAIL | TTERRNO, "kcmp failed unexpectedly");
	goto free;
} else {
	if (TST_RET < 0 || TST_RET > 3)
	tst_res(TFAIL, "kcmp invalid return value %ld", TST_RET);
	goto free;
}

free:
  ....


>
>         if (!TST_PASS)
>                 return;
> Although your version is more descriptive.
>
>> +
>> +	TST_CHECKPOINT_WAKE(0);
>> +	SAFE_CLOSE(remotefd);
>> +
>> +	tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
>> +	SAFE_CLOSE(pidfd);
> Shouldn't be pidfd closed in cleanup? In case fcntl() fails it's kept open.
Will do.
>> +	SAFE_CLOSE(fds[0]);
> The same is for fds, which is already static.
ok.
>
> These are very minor and you can change it before merge.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
Thanks for your review.

ps: I merged the first 3 patches, and will send a v2 for the remaining 2 
patches.

Best Regards
Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
