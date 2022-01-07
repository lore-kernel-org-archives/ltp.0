Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10BCC433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 08:28:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 259573C6FF8
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:28:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E9073C12CF
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 09:28:15 +0100 (CET)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7B43601239
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 09:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641544094; x=1673080094;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bGJsvjZh8Wm0L3bd9DlTrYXuNzKVXj7SbQ+YTHzAYEk=;
 b=yGAsNGf+fraeVX8i+WUUIw9V4+65Rxbxb4XCRuxsKiaEeAk6bg6Q0ls2
 DenJznxC/GCcD+vVZPB8SBXASxdLyl98V5Tk4qSt0V7ebp/CdWPnyn+xH
 omwOlKU4oTle2ImsKcA8wXxcgG3TFnepxPeV1JeFSxQfn6erE1N9ur9zp
 uMdlLyLjcVqVKgDBQfdcEl1SQUVOwqKHUiVb+Q0DPUcM5I+7m1gD6Yz+x
 H3SMBk6gwYW0r0OlhCS/sxvYqIUJdWRlkINuxLecRt1Os7JdQmlrIq1WE
 Bjy2UmKncQJjErkJeIaNlhD2xFr9izpWRTRVyHMbWpcM29668Vj6dc7SL A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="55287116"
X-IronPort-AV: E=Sophos;i="5.88,269,1635174000"; d="scan'208";a="55287116"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2022 17:28:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evZwePOdNhr2/VmO86LW804LzCiriL1p2ISDU51EmI7r2gZzpxVQ7adVqjNlGN7zznGA18010mgtD48usjHt12FxZqTjil6zBbH3z9aFn2Cm/huYrL0HXcQsbXeRgQtKyueoEvko7U573jlaUlHSse+UrMPGECBwW2JuNbEH1i3DPg6iPTdJCsh991ukU9cC2epw8E+KeGy7rwO0HoCBccPEZ23szuzJemdbANbYRenXmNrgc7mUkunexvG2eBXmsnnmm64y8KIZ4NGwjQzHnTmxSEjJacEvI1JAqp1kyfdmoR/er0ayAEPVvLzKyREL6C//jDjoZjPOQAWIBie/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGJsvjZh8Wm0L3bd9DlTrYXuNzKVXj7SbQ+YTHzAYEk=;
 b=IEI2u/cPmdoGw3N4L1YeiVA5v+sGPJQvMlp66IMRit2gcVqC/TCRPEJspHOSoge6GmtOhtmHsEsLWxGvYKo+g2R9EaboYIUzayFePqsEQ7Y+GnzaQie04N02MTMHHwijEYebZfy3DTo1ktvK1fw4esznFBiit3Up618Tp8LBOXPFP/ERMkY4R+wvw990Pt4FEdoWxjpswyzFacX2+sa1x7Wz1oxJtcDDKlLtX0AoU6mnJunb0Dbk16YDN6cqHS7fkl/r/N9HreCivm8DKjbtoj1fJWeIgKkW7ZJvsxaQevfUfcd+YnMRvg4o48PuPdGCwBizbJCiQEKgOzJ9VYRHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGJsvjZh8Wm0L3bd9DlTrYXuNzKVXj7SbQ+YTHzAYEk=;
 b=geLVpAP7/eP6knExKiMdKaH+NfUAGgG0rwO+zgSh07WO8ZNrQry8aRSVSZZMH3nOFNT6rDMHLA3kF6RLKuWYc4Rzy+axjEBrQLD48VrGEoBHETpQK39wGyod5jXsy5r/3kiw/xaTExwIV0w+dIVN8BFvjYJ46ymU+ICWSaUjK/w=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2445.jpnprd01.prod.outlook.com (2603:1096:404:89::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 08:28:09 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 08:28:09 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
Thread-Index: AQHYAt9Ym4q3iJDhlUyEGKaxT+lELKxV2LUAgAEWM4CAAAQggIAAMLkAgAAXlQA=
Date: Fri, 7 Jan 2022 08:28:08 +0000
Message-ID: <61D7F9AA.9020401@fujitsu.com>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
In-Reply-To: <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 742d6c6e-e094-4a1e-abc2-08d9d1b7a2d0
x-ms-traffictypediagnostic: TYAPR01MB2445:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2445142C4A8DFD55484C251FFD4D9@TYAPR01MB2445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmfrgoI45S6c4NUfdMbns/zfAxgG48kTeiCmlI0heVRWOgVjL4hklAUwa6ttFF77vFRr/PZSnTeseRDHwDuUftY1/EksV2LwipMNntN/X9Q1H8PYLoUaBRX1rI1jeY17U863jkiMiF1LEpH3s80dt46SEixxnAdoShZ3IyVIYvHEB95KBPYEW1qsrkf3DuLAMvGl/J7CWHFhn0gwXfX6YcB/nGkrInAs9LtgfjniYok6h2xwIoWpT4t3ilf638ITNgsuJskfi0hjTP4QiasObXzNcWBqTO9YZPaKHg4sBhwfvi98H18fA8xk3NnNHDXuRPn0jpn0xqoTayMIVSDkh+JgZ1PHUoPuMJ2fAVgnluoT8mArfk6Mgh22P9yPDrrrNrGtmNcMasWzngMGIpx0d9LEG92BdguYdAGmy4cwfyU4o5IwoqO7aNSnpLc3/EMR+6A4TWfImuy/RjC1UcE+mKGQ4VprDWpW7VUt81bVj7PR/FFcc/LDM5m5w7TGlx52wFAC839sPEYeIiIPNLC0Y47Kw6oLVLwZ254bXP+Pm9YN6yy/M3Kta/MhFY64l1U7BAikWNk8mYN8CNpWUcOj24YabJFRcQE+ytVug0PMLVKGI2FK4jcgWYrQHg0S/2oLEcBDfNLVV77kDS9NVRqMuFrsvRayByqUCeL8F4ddLEwSdJ18I5buI/u9yqSpzLI1l1qBmGmev5TYtiXC3pP0Sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(82960400001)(6916009)(66946007)(66556008)(2906002)(66476007)(71200400001)(6506007)(76116006)(122000001)(64756008)(508600001)(87266011)(38070700005)(86362001)(91956017)(5660300002)(83380400001)(8676002)(6512007)(66446008)(36756003)(38100700002)(54906003)(26005)(8936002)(6486002)(186003)(316002)(85182001)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OURoRW9pUmlXVHJUWS8rQjJUcFZNcWZhN3dzZjV0TndQMmY1Q2ZHaFVZZ1ZN?=
 =?utf-8?B?T2JoWW9VQnZLd3ZETVhpTnhWYkp6emt5MzVJWExSRy84TGtGejhMY1FSNDJZ?=
 =?utf-8?B?WXJLYlIrc1ZuUzVJSUlhMnAyalRqQWIwc2h2V0FsYWZQVTVKVmZLVkFFMURr?=
 =?utf-8?B?aXJsTktYRFJhNnVSSjk0QlpPTlBGOWlONnE0YWxtM2VLOTU1dEhSWFJ4dTJM?=
 =?utf-8?B?MmNWbkQ2R1N3eTdZcXJXSkR0dFdSWGVtUlpPR1luSEZpTThKWGRyOHV6Rjcz?=
 =?utf-8?B?N3ZwVU9CL0RQVHgwd2lrZzN4Um1SalVzNTJJNG9sME1BQyt3UVBzeTBVWFl4?=
 =?utf-8?B?OEdvUXhGZzJzS1NoSnU2Y2R6ZGdsRTJiZUJZNjVCNHg1WXpGRVJiTm9OVklP?=
 =?utf-8?B?MkRreUlkUVVLODJSdyt5a2haU0FZZ3gyZDBGYnpXOUI5L1JDNGl5YUhYVVN0?=
 =?utf-8?B?OHRJbHF4ckN2K1FONzJOTFBhMkdOemZlc09SdkxuVXg2KytLNkZyQ2k0djhi?=
 =?utf-8?B?VmRJblJIOXlaSjFVemR1QS83SWhRMjJDZm9SSmFPZWJVaHU5aStFMHlzZ1l5?=
 =?utf-8?B?bERHWkFDbnEyTVpwNm9iZDR2VDV4ZlVSVkxlU0xINmFlbXgyMmF6UWw5WGpX?=
 =?utf-8?B?RHRxL0NoQ2RiQkJ1VFRpWitUT09kbWhEcnRTaEdld3p4eGlpUjl2ZWllc2ZM?=
 =?utf-8?B?N3BqTnM0VklLNUJjdXd1K1lYbk1VbnlLM1drL0NzVitiRWJjMDh1WnZEemli?=
 =?utf-8?B?dFVUNkFuYmw2TlFleDNYZmRDMllpVzQyTk11Qm5OU1BOanVxdXpRY0NOVWU5?=
 =?utf-8?B?VTJmV0JWWHAxRUZCajlyMjZ1LzV6WmttenBJY3ArZzg4a1Z2NzJJaFlEZng3?=
 =?utf-8?B?MVpBUy9IU3FZS1dueDhMME4rUHkyTWNtTU1Pajc4OVJGTTRtVHhVQzhVVTlW?=
 =?utf-8?B?U1dKSERaZUtWUEdVNEs1cTZkeHArbTZ4RlpVMjJsUlg4SUU1VEJ4ckNieFA4?=
 =?utf-8?B?TmVwb0pYUzRZUTlRRG5INWdWZWhxbU00WXBTV2JENEFHd0VBU3ZkV2VKU3ln?=
 =?utf-8?B?UVJzaFdNbzlqQ0xJMXdReTgzWmRFUnFjNUhGQXREcHdSMm1xbkJSS2VDOXpq?=
 =?utf-8?B?SkZwZm1GdGJuRzFjcHh1VjZJdERmUnJWWlR5MmF2TzZhSjNBbTk0SFkrbFQ4?=
 =?utf-8?B?bndUTWdHL3U2SEJzQnlqMnNzalZrbFFvWEwzRGplR3BtR0hVOW8vRkEvTzZK?=
 =?utf-8?B?STRtRTJuZlJrY3k2R2xkcllBRDRIblBaYURlN3Evb2N5YTMrRklRai8yN01k?=
 =?utf-8?B?bnNkVmdkUkdCSlo2dzVka2ZPTjBycDFtQldBOEJEUEtjWFFmcERIa21oVlB0?=
 =?utf-8?B?OXFSYU55NUtsMXdhSmlvbCtNVlByNmJBUUN6cjZ5d1I0dDZqbXdaRG1tMStE?=
 =?utf-8?B?UCtDazJtWUt5bXBzVWFzYno5NXNKbWdRRS9mKzJya0ljODJvbk03UTZrYlJs?=
 =?utf-8?B?VkN0RUdHdlVKZjE3bExLSHYyQ2xqd2xDc3ZhTm1TbjJVZW90dEcyTHZFVFNF?=
 =?utf-8?B?MmdWWEpRQSs0NFp6ZVUyemEvWG5NaGR5U29ad0xSaS9yNXVhdVk1a3VVUk9y?=
 =?utf-8?B?eHZ2eTdMK0NucHg0bVpwOUJhNEpYa3dDWnp5cGE3bUdsYUJpL2F5ajZ1emxG?=
 =?utf-8?B?ckJOSU1uMGM4N2ZDNS9YL0dUdEJyMlRCU3k3ZGIzcVRqK01TNTNIYk91SS8z?=
 =?utf-8?B?YTYxcTlEQkhvUHQvVmVOZmhYQ0tLVWZBTmR0RVpBaGtnVExuTmRHQkY3enNu?=
 =?utf-8?B?eGkxNnBqZlNKMzV2MlF6eUtFb3F4VXlQMU10L1ZQY1BsMlp1b2FQbXR4T0tI?=
 =?utf-8?B?RWpQeENBUUdiMjQ1bHhnNC9nRTdtN3R5bTN2and6VGduYnhmeFg1RkhPd1JU?=
 =?utf-8?B?eG13TDU1RFhQejkzRDNyZUlrQ2hMNGZ1NFUxMG9oQkQzVXBvczBMQWNuejVk?=
 =?utf-8?B?UkdSL1VxVmV1QVV1anhSSFBKTjZYaWUzMEpic1ZpREkyS3pMcEpGczVIVEo5?=
 =?utf-8?B?ekpNbVpPL0JhYkUvSTArZlVUSkhSYXVKK3VJNnVnbVBzM1NzM21rbW9LakFv?=
 =?utf-8?B?Uy8rbXM1eEZkeEM4Vm5sRjFwdHQreEFGUE10WDE5VGdXZ0FGT0hHeW5VR0N5?=
 =?utf-8?B?K3ZvRDVuU0VXcUNFbzdLTUdrK0R0NExuT1NtMVdwTTd0YWtRcnl3MldBUTdX?=
 =?utf-8?Q?xc6y0r8cBr9TqfmImofapaZBVmD9uFTcYhImw61pJ8=3D?=
Content-ID: <496222D584D64943B578CB47A2465A2F@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742d6c6e-e094-4a1e-abc2-08d9d1b7a2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 08:28:09.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZOcDPeP1uohiKNgQ1zoFqyvNpogkQCr2OdCvQSKyhH/jLp+9FgAM5CRMNva2j2UE9uxObWx8zq3uFjbe0h1Jxep392TmPdH+jxrhm2VBkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2445
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hi Li
> xuyang2018.jy@fujitsu.com<xuyang2018.jy@fujitsu.com>  wrote:
>
>> // SPDX-License-Identifier: GPL-2.0-or-later
>> /* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/
>>
>> #include<stdio.h>
>> #include<string.h>
>> #include "tst_kconfig.h"
>>
>>
>> int main(int argc, const char *argv[])
>> {
>>           char delims[] = ",";
>>           char kconfig[PATH_MAX];
>>           char str[PATH_MAX];
>>           char *result = NULL;
>>           char *next = NULL;
>>           int i = 0;
>>
>>           if (argc<  2) {
>>                   fprintf(stderr, "Please provide kernel kconfig list\n");
>>                   return 1;
>>           }
>>
>>           strcpy(str, argv[1]);
>>           result = strtok_r(str, delims,&next);
>>
>>           while (result != NULL) {
>>                   strcpy(kconfig, result);
>>                   printf("%s %s %d\n", kconfig,result, i);
>>                   const char *const kconfigs[] = {
>>                           kconfig,
>>                           NULL
>>                   };
>>                   if (tst_kconfig_check(kconfigs)) {
>>                            fprintf(stderr, "Kernel config doesn't meet
>> test's requirement!\n");
>>                            return 1;
>>                   }
>>
>>                   i++;
>>                   result = strtok_r(NULL, delims,&next);
>>           }
>>
>>           return 0;
>> }
>>
>> But it must call tst_kconfig_check for every kconfig expression and
>> print many info "Parsing kernel config ..." because we need to create a
>> NULL terminated array for  tst_kconfig_check.
>
> Maybe we can combine the arguments into one kconfigs struct and
> just do once check? something like:
Yes, it works well. Thanks.

I checked the kernel config, it seems comma can not meet the CONFIG_LSM 
situation (Petr mention it but I don't notice before).
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

so I think we may TST_NEEDS_KCONFIGS_IFS variable and default value is 
comma.

Best Regards
Yang Xu
>
> ---------------------------
>          strcpy(str, argv[1]);
>          result = strtok_r(str, delims,&next);
>
>          const char *kconfigs[64];
>
>          for (i = 0; result != NULL; i++) {
>                  kconfigs[i] = result;
>                  result = strtok_r(NULL, delims,&next);
>          }
>
>          kconfigs[++i] = NULL;
>
>          if (tst_kconfig_check(kconfigs)) {
>                  fprintf(stderr, "Kernel config doesn't meet test's
> requirement!\n");
>                  return 1;
>          }
>          ...
>
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
