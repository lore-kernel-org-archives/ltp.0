Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3BC4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 09:29:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 838B23CD13A
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 10:29:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EBA43CA363
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 10:29:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 17DCC60080D
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 10:29:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e32+lsSngmZQfcbuDrw1nGuRf2eeUMkwC6tT5LDQPkY5waiqVtKwk/1YiH64SHeSK2YyAfGPjDzBJoHmcOeCcW6anSSa0saG/sg91Y5erw+Ql50hPMB3SMH7HScgG4ZW7Z5mnvcX3nS/dOmsYsfdoooGdmwROkyOt+zJ6ldEjbjQzbV5p03jG8ZA/ldVwHQDvJF3HOv/nMXZWLTtwa3lTS5D9yCUvcduK7yGzOBkknNGKQ9zC7HmmMf6Jumb3oU60U75ADcVGluO9dtXtiwIXiARr6cWR7L1tPM/vHKq1q27ldjcoDsSXgLPHmCcvDWy9N81WU420FVzh4n2kVaIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEy7VpWFD0mUzemp4oDWkagDbzAm4AoDnZZZDNZK0CU=;
 b=VRSbpT8OCigTIHylXYhaiCeIL2ekTdIC+lIzzw56Jk0jMEuKZb7VGS/ftS4ind7TE9XT7FLUop9s0ZhhstlR4ylSCWsTUThzzqr4RtVw0PWWEWsci+rzcP7dCwU8b4qBe/F4i5TuwiNfP7hvpIS56wxh8yBek4n5QuVMC0iCFXSy3BH7jJvdfbnagpQgPktncWaanlMBkONJupGL3a0C1sLyCPVLcD1Jjgw6LdEO7mtxFBeGge3ruJn7DryLJgCVt/KZj1Me2D+/6P8QKi/grPBkjLBWrt5tRQ35LVed/jqB+7cBe3Jcv2z9ZGnVu3uh72hBLxY0fGkd0akiQCS+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEy7VpWFD0mUzemp4oDWkagDbzAm4AoDnZZZDNZK0CU=;
 b=ZbdpU7O0Mu5eEJghQk/WSHWVkLirVxKLYOLNr9wWGkBzwuVlB2K0mVXy/9+y/9h6PYTKyDbfrjRzzKSc0ZsknUHNkTfGvoQcNWsSfy9Yrsjt2R+1lN5TbAB1sjNnzT5pKUr5dbMHjJzpTOA6mXORjvYpACzKhiTt0PN7bzhK2lYwe5JOd+OzWLuV8zq7WsQcXpNlyU46V9ctHVuFwQbC0fD7ywWTsdorqiyFtBtmjioXDt/dTIoUtT3YvchZWMCIYcmV+oPmAsvlHvaEbCEWZySnOEy16tA0rJEDad8P/NTWVOMkrweP68F01smJAPA2JGlYm8rhVTWnxil7f5bdRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:28:57 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 09:28:57 +0000
Message-ID: <99df4038-69d7-7d10-3486-3cb282f66306@suse.com>
Date: Tue, 15 Nov 2022 10:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Li Wang <liwang@redhat.com>, rpalethorpe@suse.de,
 Andrea Cervesato <acervesato@suse.de>
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
X-ClientProxiedBy: AM5PR0601CA0037.eurprd06.prod.outlook.com
 (2603:10a6:203:68::23) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM9PR04MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: a74f898d-66d5-438d-92aa-08dac6ebd23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbCK7ZLSJBXuK5nkzEFE8XmuNCvYiSJKWThkMsPsaHEjgRjLlKTz0HFkQeBnM1rwEnaDmwjriT8D27/Puo0Bm4GbMHzgLRP5Cn+cfcu9WOMcEhVwIg08yHrJTxhpYP2LGEqAkcaC20ZETeoygaHP0FDOCF8CEmsuE6uUl4+UAzeLaQ21Yki4Gs6GCcKi3SZSOAT9ENAIKCiGd9ECTo211nCH4Lvq6AtYRHP/aw5tDYlN7UbfxrbRdYbhGMSeuUadIaO8zEBWHDRT0gHOTS1uihrjPxouLVMErxxHPFPVcO7BSERNOPrbdh3C6TYZxb2UbOemridiR5qkQ2hsAQDVjjPNVvnuGo6B9aQPiwTNL67AcWMe9+B+PuvRw/aGPVqzO07zS3D6Ul/3UA7iYbFnRSXFIQzC2GZY6n0zHJOOaG6ikdZskJwZJ6DUS2hpn0CqTy6FeVGzBHVsu/LEeZmx7Dq1/wR5KYgRAYu+RsEmMz7WNY9ASd4bwS0WgD4lUqC4KA+Zf/lVvkUB9XZZy5z2u7Cb8YZOmkJkdRqT4HbVVph3rbuk1cA+dDhaRDm9OQSruOoKXhHVs8Ng4JGItzY/mtGHQVZmdfBH2SjFzRoZ5uVuLvDITlJBA7YQrAUlDlZhABlZDpRPSa6zgck2FNOuPN0LxnZlPXuHHjmpmw8qhQuLR/JKTnszJ6RD2UeDze2FFNF08iGjfc3y7Hwlj1ktQ79jFgQlor2bcafFgWvkUqsX+67nMLrRglyLWuK6KO0MVFzzRauqrMLJ9Gow/gFI8b8DpRC+bxEdUFi3G8Khvl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(6666004)(6486002)(478600001)(31686004)(4326008)(110136005)(33964004)(53546011)(316002)(6512007)(26005)(41300700001)(36756003)(8676002)(66476007)(66946007)(66556008)(2616005)(8936002)(38100700002)(44832011)(30864003)(186003)(5660300002)(83380400001)(6506007)(86362001)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHlBS0dPVFNuMi9VejZKWU1tSEh6WWJWdGtTY3RDSkJaTXlOSjBTdEFuZ2V3?=
 =?utf-8?B?dk8rOVRCUXBQZmI0c09qRjVUb0NjZDZOZVBYaFJsNW5pdnJ0SjVWSVVyZ1lJ?=
 =?utf-8?B?K0JBclVZSXpnQisvZmwrYm1aSEI1UzFURGM1S2tYd0VTdmZKYWNOckNjU1k3?=
 =?utf-8?B?U2I1OUJFeXlBT1NTZ2l1cEtvR1FOY1ZIaUtsUG91NGdPdG00aWNNbzZBcnMv?=
 =?utf-8?B?Zk9zck45SWVma2pKUUsrTXo4ejFpelhmMDNmN0wyS2xENmpkb0xnMWZ0ckRH?=
 =?utf-8?B?cHNTd1plRDM0WVQwdW53aHRTUmVxNnZ4YnFVNk5pVWtKcjgwVTlBVnZwcTFa?=
 =?utf-8?B?WGdjaW9QUk1jWDFsUW1mb0k3RFJvYk93Zkg0NlNBOG5XS2ZGcXBPSGxucFBZ?=
 =?utf-8?B?VVRGUHYzQUtBTU1jeTlTenh2ZG5NOTkvcTlpczArN2dvSy9EdDcrSDdJK0Ry?=
 =?utf-8?B?MTNmQzJWK3FJQTE5UWJPNUJqbWJ2U2F6UUZRcHMzY1FWbXBhOS9qQmF1eG1H?=
 =?utf-8?B?YmpZbFcrVGtSQXZTK2o3RnlLOERVdGtMU1pjZFBUVVd1MHI4TFh4TEV0NmNB?=
 =?utf-8?B?WlJQNVVKM0xwUHZUU05PWTdOL3BUY2NJSENnc0NoQlNKT3RGa0NTc0M4Ni80?=
 =?utf-8?B?VFJlVDJXRXlPaC9hL2ZzZDh5bm5jS0ppNVVLOTRrWmhGMThoSjRXSStzQ2R3?=
 =?utf-8?B?ME80M0FaU29qRXVub1huWDFLNWtaSDIxMllBUkw3cGtTNitCbU5UWFVFQ0Zz?=
 =?utf-8?B?NWwxM3hQN1QxM1BndWZXU2VvZjd1WDZVeFRFUm1ZTjlnRkF5ZDJHWW9NcTJF?=
 =?utf-8?B?ZlZ6L0VFelJUdWk2cjNMNFZiMzhNcnAvVkNHanB0dzVTbVBQRWZlWVZ4UFRJ?=
 =?utf-8?B?bnpNTUkzN3BDTmlrbTR6RTh6ZzBFS2Y4QlBROERpeGZ1WTZXRENyTXAzN1NP?=
 =?utf-8?B?UVMvTXVoYU81RXFXa3FQVmljQmljcE9SV1FOZ0RIYXBHZGtOSHJVak5oUmVu?=
 =?utf-8?B?RG4yYnZweDlZYVI3bVdVb0R4cWVmZ1FsMjd3MnlMdWJpV0J5VzBaNWV0Slhu?=
 =?utf-8?B?WFFkWU5KL1NKNmdqVEFkMHJJZ1ZuMFhVdXg3cHVBY2pSd292MDhseFFnSGZh?=
 =?utf-8?B?ZFFDUXdoRUZjNlBkRlBiVUNDYStGeEVsZzJ5QlcrRlFiSHF2aGRQZTcvd2w3?=
 =?utf-8?B?Z240T1U3VC9wbHRZaU84SDk1UEJYMXdNMmtuY2IweUx6UkhQbGlaMC9RTWdE?=
 =?utf-8?B?WFNXbzgybTd3aHBFU1pmQU5SUCtyT1c0ZlJ0VWMvUXFobFNicEdCUG9xeFVQ?=
 =?utf-8?B?RSs3K2ZGNmpUd3RHWDY4VkhiUFR4L3V6N1NlanpwTlNYQ21ybythWFV2TEVP?=
 =?utf-8?B?eXZHV2E0K3JpMWRkcEhlM0dtQWRaS1VOYW5zckZyVTV2YTJtcVIvVGFKM0VY?=
 =?utf-8?B?MTM0dHpIdHBWSU4zRVVpRVZObkpIZWZOdk9aWDJOUi9NMmpNQXk2VlE5M1Bz?=
 =?utf-8?B?NE1TY1BYdlFJZDNiN21YWGROWGVoSmwydFhJdS9tY0RVTFRuS1pwdUZQQnh4?=
 =?utf-8?B?US9KTGJPdzcxWjQ0TXZRNXczb0lUWTJpUWxvYVRNQk4vdEdRQ0V4Y2hZV0E5?=
 =?utf-8?B?cEtyYWlSdVZwM1FqWXpoRmlYMWd4RXJMdjluS2tpcW9PTVYrOG9ySDlPczN4?=
 =?utf-8?B?b0NJZGJiSlpsTUJCUDQ3YUJiaE5ad05BdUtQbnp2Z0JpOHF6QS9XR0FUelp2?=
 =?utf-8?B?NmlBRmV1NHBKZzd4Y1FTU1dEQ0JRcHNWZTk1UFEvOXQyTFhsVW95VWdXR1B2?=
 =?utf-8?B?ZFRrUFRlUFlhc0VIUlFZWU5FUE85NHE0TitJRGpxekxLOStSWHFTY1lCTE5E?=
 =?utf-8?B?VTZSaTh0Qkx4WTVkdUZkWDUvT0M5Q3htaU5ldWZzYmxPU3dFUTRoNjRxRkYv?=
 =?utf-8?B?TTNkaVJMQjJ1NEZabElseVRNYmxZUjBhNzNweHNsbzN4NGpabGpTbmhWL0c2?=
 =?utf-8?B?b2JBNXQyTnRQRmRaeGFvUFoxVnorenFMejBRbjVNbEs3SDZQQWl4amN6aXdQ?=
 =?utf-8?B?NEIxL3BqdDVqbyt1ZThibUc0YjdUMEd4MUNBdnpNR0RPWkNFdUlIQXo0VWpu?=
 =?utf-8?B?V0YwbHVySmw2OWpYK1VoSytZQjdidVRzeFJ0RkdObVRNUFppaTJCWUk4ZlFs?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74f898d-66d5-438d-92aa-08dac6ebd23c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:28:57.4551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rRfhrio1elw/METRCEoILMAfnSuPEeIzz2/yr65S9hbCnrk9qhh5UstbOAH2r9a6MQcuaPcVNYApUjbt0KsL5CGV1kaUw+ZXudfSSUAYGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0166326642=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0166326642==
Content-Type: multipart/alternative;
 boundary="------------BvmkLYb7boskDMSOC9SBjN00"
Content-Language: en-US

--------------BvmkLYb7boskDMSOC9SBjN00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Li,

On 11/15/22 05:00, Li Wang wrote:
>
>
> On Mon, Nov 14, 2022 at 11:52 PM Richard Palethorpe 
> <rpalethorpe@suse.de> wrote:
>
>     Hello,
>
>     Li Wang <liwang@redhat.com> writes:
>
>     > Split checking the return ovalue from testing the signal is
>     > delivered, so that we could use two time value for verifying.
>     >
>     > Also, adding interval timer test by handling the signal at
>     > least 10 times. After that recover the signal behavior to
>     > default and do deliver-signal checking.
>     >
>     > Signed-off-by: Li Wang <liwang@redhat.com>
>     > ---
>     >  .../kernel/syscalls/setitimer/setitimer01.c   | 63
>     ++++++++++++-------
>     >  1 file changed, 39 insertions(+), 24 deletions(-)
>     >
>     > diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c
>     b/testcases/kernel/syscalls/setitimer/setitimer01.c
>     > index 1f631d457..260590b0e 100644
>     > --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
>     > +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
>     > @@ -22,8 +22,10 @@
>     >  #include "tst_safe_clocks.h"
>     >
>     >  static struct itimerval *value, *ovalue;
>     > +static volatile unsigned long sigcnt;
>     >  static long time_step;
>     > -static long time_count;
>     > +static long time_sec;
>     > +static long time_usec;
>     >
>     >  static struct tcase {
>     >       int which;
>     > @@ -40,54 +42,66 @@ static int sys_setitimer(int which, void
>     *new_value, void *old_value)
>     >       return tst_syscall(__NR_setitimer, which, new_value,
>     old_value);
>     >  }
>     >
>     > -static void set_setitimer_value(int usec, int o_usec)
>     > +static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
>     >  {
>     > -     value->it_value.tv_sec = 0;
>     > -     value->it_value.tv_usec = usec;
>     > -     value->it_interval.tv_sec = 0;
>     > -     value->it_interval.tv_usec = 0;
>     > +     sigcnt++;
>     > +}
>     >
>     > -     ovalue->it_value.tv_sec = o_usec;
>     > -     ovalue->it_value.tv_usec = o_usec;
>     > -     ovalue->it_interval.tv_sec = 0;
>     > -     ovalue->it_interval.tv_usec = 0;
>     > +static void set_setitimer_value(int sec, int usec)
>     > +{
>     > +     value->it_value.tv_sec = sec;
>     > +     value->it_value.tv_usec = usec;
>     > +     value->it_interval.tv_sec = sec;
>     > +     value->it_interval.tv_usec = usec;
>     >  }
>     >
>     >  static void verify_setitimer(unsigned int i)
>     >  {
>     >       pid_t pid;
>     >       int status;
>     > -     long margin;
>     >       struct tcase *tc = &tcases[i];
>     >
>     > +     tst_res(TINFO, "tc->which = %s", tc->des);
>     > +
>     >       pid = SAFE_FORK();
>     >
>     >       if (pid == 0) {
>     > -             tst_res(TINFO, "tc->which = %s", tc->des);
>     > -
>     >               tst_no_corefile(0);
>     >
>     > -             set_setitimer_value(time_count, 0);
>     > +             set_setitimer_value(time_sec, time_usec);
>     >               TST_EXP_PASS(sys_setitimer(tc->which, value, NULL));
>     >
>     > -             set_setitimer_value(5 * time_step, 7 * time_step);
>     > +             set_setitimer_value(2 * time_sec, 2 * time_usec);
>
>     IDK if there was some reason for choosing 5 and 7 in the first place?
>
>
> I don't see any necessary reasons for using prime numbers here.
>
> @Andrea, did I miss something?
>
The reason is that we want to trace input values in the setitimer 
syscalls. By setting them to x5/7 we are able to debug setitimer easily 
if bug appears.
>
>
>     Andrea seemed to be going through the prime numbers.
>
>     >               TST_EXP_PASS(sys_setitimer(tc->which, value, ovalue));
>     >
>     > -             tst_res(TINFO, "tv_sec=%ld, tv_usec=%ld",
>     > -                     ovalue->it_value.tv_sec,
>     > -                     ovalue->it_value.tv_usec);
>     > +  TST_EXP_EQ_LI(ovalue->it_interval.tv_sec, time_sec);
>     > +  TST_EXP_EQ_LI(ovalue->it_interval.tv_usec, time_usec);
>     > +
>     > +             tst_res(TINFO, "ovalue->it_value.tv_sec=%ld,
>     ovalue->it_value.tv_usec=%ld",
>     > +                     ovalue->it_value.tv_sec,
>     ovalue->it_value.tv_usec);
>     >
>     >               /*
>     >                * ITIMER_VIRTUAL and ITIMER_PROF timers always
>     expire a
>     >                * time_step afterward the elapsed time to make
>     sure that
>     >                * at least counters take effect.
>     >                */
>     > -             margin = tc->which == ITIMER_REAL ? 0 : time_step;
>     > +             long margin = (tc->which == ITIMER_REAL) ? 0 :
>     time_step;
>
>     Looks like an unecessary change?
>
>
> Yes, but the 'margin' is only used in children, and I moved
> the declaration here is just to highlight and cause attention
> in code reading.
>
>
>     >
>     > -             if (ovalue->it_value.tv_sec != 0 ||
>     ovalue->it_value.tv_usec > time_count + margin)
>     > +             if (ovalue->it_value.tv_sec > time_sec ||
>     > +  ovalue->it_value.tv_usec > time_usec + margin)
>
>     Looking at the man page, technically speaking the valid range for
>     ovalue->it_value.tv_sec is 0 to value->it_value.tv_sec when
>     ovalue->it_value.tv_usec > 0.
>
>
> Good point!! Seems we have to split the situation into two,
>
> 1. no tv_sec elapse happen, just check
> 'it_value.tv_usec' within [0, time_usec + margin]
>
> 2. tv_sec elapses happen, then check
> 'it_value.tv_sec' within [0, time_sec]
>
> Something maybe like:
>
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -87,9 +87,17 @@ static void verify_setitimer(unsigned int i)
>                  */
>                 long margin = (tc->which == ITIMER_REAL) ? 0 : time_step;
>
> -               if (ovalue->it_value.tv_sec > time_sec ||
> -                               ovalue->it_value.tv_usec > time_usec + 
> margin)
> -                       tst_res(TFAIL, "Ending counters are out of 
> range");
> +               if (ovalue->it_value.tv_sec == time_sec) {
> +                       if (ovalue->it_value.tv_usec < 0 ||
> + ovalue->it_value.tv_usec > time_usec + margin)
> +                               tst_res(TFAIL, 
> "ovalue->it_value.tv_usec is out of range: %ld",
> + ovalue->it_value.tv_usec);
> +               } else {
> +                       if (ovalue->it_value.tv_sec < 0 ||
> + ovalue->it_value.tv_sec > time_sec)
> +                               tst_res(TFAIL, 
> "ovalue->it_value.tv_sec is out of range: %ld",
> + ovalue->it_value.tv_usec);
> +               }
>
>                 SAFE_SIGNAL(tc->signo, sig_routine);
>
>
>     Practically speaking we have to assume a large amount of time has
>     passed
>     when using ITIMER_REAL. It has to be *much* larger than a VM is likely
>     to be paused for and then successfully resumed. Or the amount of
>     time a
>     clock may be corrected by (for e.g. with NTP).
>
>
> Hmm, not sure if I understand correctly above, will that
> timer value be out of the range but reasonable?
>
> Or is there any additional situation we should cover?
>
>
>     >                       tst_res(TFAIL, "Ending counters are out of
>     range");
>
>     While we are here; we should make our lives easier when the test fails
>     by printing any relevant values.
>
>
> We already do that in the above print, but it's fine to have that here 
> as well.
>
> -- 
> Regards,
> Li Wang

Andrea

--------------BvmkLYb7boskDMSOC9SBjN00
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Li,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 11/15/22 05:00, Li Wang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr">
          <div class="gmail_default" style="font-size:small"><br>
          </div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Mon, Nov 14, 2022 at
            11:52 PM Richard Palethorpe &lt;<a href="mailto:rpalethorpe@suse.de" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">rpalethorpe@suse.de</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Hello,<br>
            <br>
            Li Wang &lt;<a href="mailto:liwang@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">liwang@redhat.com</a>&gt;
            writes:<br>
            <br>
            &gt; Split checking the return ovalue from testing the
            signal is<br>
            &gt; delivered, so that we could use two time value for
            verifying.<br>
            &gt;<br>
            &gt; Also, adding interval timer test by handling the signal
            at<br>
            &gt; least 10 times. After that recover the signal behavior
            to<br>
            &gt; default and do deliver-signal checking.<br>
            &gt;<br>
            &gt; Signed-off-by: Li Wang &lt;<a href="mailto:liwang@redhat.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">liwang@redhat.com</a>&gt;<br>
            &gt; ---<br>
            &gt;&nbsp; .../kernel/syscalls/setitimer/setitimer01.c&nbsp; &nbsp;| 63
            ++++++++++++-------<br>
            &gt;&nbsp; 1 file changed, 39 insertions(+), 24 deletions(-)<br>
            &gt;<br>
            &gt; diff --git
            a/testcases/kernel/syscalls/setitimer/setitimer01.c
            b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            &gt; index 1f631d457..260590b0e 100644<br>
            &gt; --- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            &gt; +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            &gt; @@ -22,8 +22,10 @@<br>
            &gt;&nbsp; #include &quot;tst_safe_clocks.h&quot;<br>
            &gt;&nbsp; <br>
            &gt;&nbsp; static struct itimerval *value, *ovalue;<br>
            &gt; +static volatile unsigned long sigcnt;<br>
            &gt;&nbsp; static long time_step;<br>
            &gt; -static long time_count;<br>
            &gt; +static long time_sec;<br>
            &gt; +static long time_usec;<br>
            &gt;&nbsp; <br>
            &gt;&nbsp; static struct tcase {<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;int which;<br>
            &gt; @@ -40,54 +42,66 @@ static int sys_setitimer(int which,
            void *new_value, void *old_value)<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;return tst_syscall(__NR_setitimer, which,
            new_value, old_value);<br>
            &gt;&nbsp; }<br>
            &gt;&nbsp; <br>
            &gt; -static void set_setitimer_value(int usec, int o_usec)<br>
            &gt; +static void sig_routine(int signo
            LTP_ATTRIBUTE_UNUSED)<br>
            &gt;&nbsp; {<br>
            &gt; -&nbsp; &nbsp; &nbsp;value-&gt;it_value.tv_sec = 0;<br>
            &gt; -&nbsp; &nbsp; &nbsp;value-&gt;it_value.tv_usec = usec;<br>
            &gt; -&nbsp; &nbsp; &nbsp;value-&gt;it_interval.tv_sec = 0;<br>
            &gt; -&nbsp; &nbsp; &nbsp;value-&gt;it_interval.tv_usec = 0;<br>
            &gt; +&nbsp; &nbsp; &nbsp;sigcnt++;<br>
            &gt; +}<br>
            &gt;&nbsp; <br>
            &gt; -&nbsp; &nbsp; &nbsp;ovalue-&gt;it_value.tv_sec = o_usec;<br>
            &gt; -&nbsp; &nbsp; &nbsp;ovalue-&gt;it_value.tv_usec = o_usec;<br>
            &gt; -&nbsp; &nbsp; &nbsp;ovalue-&gt;it_interval.tv_sec = 0;<br>
            &gt; -&nbsp; &nbsp; &nbsp;ovalue-&gt;it_interval.tv_usec = 0;<br>
            &gt; +static void set_setitimer_value(int sec, int usec)<br>
            &gt; +{<br>
            &gt; +&nbsp; &nbsp; &nbsp;value-&gt;it_value.tv_sec = sec;<br>
            &gt; +&nbsp; &nbsp; &nbsp;value-&gt;it_value.tv_usec = usec;<br>
            &gt; +&nbsp; &nbsp; &nbsp;value-&gt;it_interval.tv_sec = sec;<br>
            &gt; +&nbsp; &nbsp; &nbsp;value-&gt;it_interval.tv_usec = usec;<br>
            &gt;&nbsp; }<br>
            &gt;&nbsp; <br>
            &gt;&nbsp; static void verify_setitimer(unsigned int i)<br>
            &gt;&nbsp; {<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;pid_t pid;<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;int status;<br>
            &gt; -&nbsp; &nbsp; &nbsp;long margin;<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;struct tcase *tc = &amp;tcases[i];<br>
            &gt;&nbsp; <br>
            &gt; +&nbsp; &nbsp; &nbsp;tst_res(TINFO, &quot;tc-&gt;which = %s&quot;, tc-&gt;des);<br>
            &gt; +<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;pid = SAFE_FORK();<br>
            &gt;&nbsp; <br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp;if (pid == 0) {<br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_res(TINFO, &quot;tc-&gt;which = %s&quot;,
            tc-&gt;des);<br>
            &gt; -<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_no_corefile(0);<br>
            &gt;&nbsp; <br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(time_count, 0);<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(time_sec, time_usec);<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TST_EXP_PASS(sys_setitimer(tc-&gt;which,
            value, NULL));<br>
            &gt;&nbsp; <br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(5 * time_step, 7 *
            time_step);<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;set_setitimer_value(2 * time_sec, 2 *
            time_usec);<br>
            <br>
            IDK if there was some reason for choosing 5 and 7 in the
            first place?<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">I don't
              see any necessary reasons for using prime&nbsp;numbers&nbsp;here.</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">@Andrea,
              did I miss something?</div>
            <br>
          </div>
          <div>&nbsp;</div>
        </div>
      </div>
    </blockquote>
    The reason is that we want to trace input values in the setitimer
    syscalls. By setting them to x5/7 we are able to debug setitimer
    easily if bug appears.<br>
    <blockquote type="cite" cite="mid:CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            Andrea seemed to be going through the prime numbers.<br>
            <br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;TST_EXP_PASS(sys_setitimer(tc-&gt;which,
            value, ovalue));<br>
            &gt;&nbsp; <br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_res(TINFO, &quot;tv_sec=%ld, tv_usec=%ld&quot;,<br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ovalue-&gt;it_value.tv_sec,<br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ovalue-&gt;it_value.tv_usec);<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;TST_EXP_EQ_LI(ovalue-&gt;it_interval.tv_sec, time_sec);<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;TST_EXP_EQ_LI(ovalue-&gt;it_interval.tv_usec, time_usec);<br>
            &gt; +<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_res(TINFO,
            &quot;ovalue-&gt;it_value.tv_sec=%ld,
            ovalue-&gt;it_value.tv_usec=%ld&quot;,<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ovalue-&gt;it_value.tv_sec,
            ovalue-&gt;it_value.tv_usec);<br>
            &gt;&nbsp; <br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * ITIMER_VIRTUAL and ITIMER_PROF timers
            always expire a<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * time_step afterward the elapsed time
            to make sure that<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * at least counters take effect.<br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;margin = tc-&gt;which == ITIMER_REAL ? 0
            : time_step;<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;long margin = (tc-&gt;which ==
            ITIMER_REAL) ? 0 : time_step;<br>
            <br>
            Looks like an unecessary change?<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Yes, but
              the 'margin' is only used in children, and I moved</div>
            <div class="gmail_default" style="font-size:small">the
              declaration here is just to highlight and cause attention</div>
            <div class="gmail_default" style="font-size:small">in code
              reading.</div>
            <br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            &gt;&nbsp; <br>
            &gt; -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ovalue-&gt;it_value.tv_sec != 0 ||
            ovalue-&gt;it_value.tv_usec &gt; time_count + margin)<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ovalue-&gt;it_value.tv_sec &gt;
            time_sec ||<br>
            &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;ovalue-&gt;it_value.tv_usec &gt; time_usec + margin)<br>
            <br>
            Looking at the man page, technically speaking the valid
            range for<br>
            ovalue-&gt;it_value.tv_sec is 0 to value-&gt;it_value.tv_sec
            when<br>
            ovalue-&gt;it_value.tv_usec &gt; 0.<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Good
              point!! Seems we have to split the situation into two,</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">1. no
              tv_sec elapse happen, just check</div>
            <div class="gmail_default" style="font-size:small">&nbsp; &nbsp;
              'it_value.tv_usec' within [0, time_usec + margin]</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">2. tv_sec
              elapses happen, then check&nbsp;</div>
            <div class="gmail_default" style="font-size:small">&nbsp; &nbsp;
              'it_value.tv_sec' within [0, time_sec]</div>
          </div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">Something
            maybe like:</div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div class="gmail_default" style="font-size:small">---
            a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c<br>
            @@ -87,9 +87,17 @@ static void verify_setitimer(unsigned int
            i)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; long margin = (tc-&gt;which == ITIMER_REAL)
            ? 0 : time_step;<br>
            &nbsp;<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_sec &gt; time_sec
            ||<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ovalue-&gt;it_value.tv_usec
            &gt; time_usec + margin)<br>
            - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TFAIL, &quot;Ending counters are
            out of range&quot;);<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_sec == time_sec)
            {<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_usec &lt;
            0 ||<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            ovalue-&gt;it_value.tv_usec &gt; time_usec + margin)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TFAIL,
            &quot;ovalue-&gt;it_value.tv_usec is out of range: %ld&quot;,<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            ovalue-&gt;it_value.tv_usec);<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ovalue-&gt;it_value.tv_sec &lt;
            0 ||<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            ovalue-&gt;it_value.tv_sec &gt; time_sec)<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_res(TFAIL,
            &quot;ovalue-&gt;it_value.tv_sec is out of range: %ld&quot;,<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            ovalue-&gt;it_value.tv_usec);<br>
            + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            &nbsp;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; SAFE_SIGNAL(tc-&gt;signo, sig_routine);<br>
          </div>
          <div class="gmail_default" style="font-size:small"><br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            Practically speaking we have to assume a large amount of
            time has passed<br>
            when using ITIMER_REAL. It has to be *much* larger than a VM
            is likely<br>
            to be paused for and then successfully resumed. Or the
            amount of time a<br>
            clock may be corrected by (for e.g. with NTP).<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Hmm, not
              sure if I understand correctly above, will that</div>
            <div class="gmail_default" style="font-size:small">timer
              value be out of the range but reasonable?</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
            <div class="gmail_default" style="font-size:small">Or is
              there any additional situation we should cover?</div>
            <div class="gmail_default" style="font-size:small"><br>
            </div>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_res(TFAIL, &quot;Ending counters
            are out of range&quot;);<br>
            <br>
            While we are here; we should make our lives easier when the
            test fails<br>
            by printing any relevant values.<br>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">We
              already do that in the above print,&nbsp;but it's fine to&nbsp;have
              that here as well.</div>
          </div>
        </div>
        <div><br>
        </div>
        -- <br>
        <div dir="ltr">
          <div dir="ltr">
            <div>Regards,<br>
            </div>
            <div>Li Wang<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Andrea<br>
    </p>
  </body>
</html>

--------------BvmkLYb7boskDMSOC9SBjN00--

--===============0166326642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0166326642==--
