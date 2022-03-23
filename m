Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D46C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 09:47:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A2033C93ED
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 10:47:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AA053C07B5
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:47:03 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F3E1600ACB
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 10:47:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1648028822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMtRhTqTGY4MtWBMag/llzWOIxfbdqJRmgz/U3hPmGY=;
 b=PvENikh5p6NKqROgU/baZaKUf26sSH5TKaNfzy8qj3pMZCLTncWHVbqRcf6iLYPFsv9d+O
 tk2WnfGLVXYYfNI3JzgFPXmHQkF37vtOlb3gpCV7RovooeAaNJ1i7m9aYGGTNDydl5IDmI
 RRaUkbkb+3jHWUK1jLIV5Ae/BaqZyGA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-6AjQMn58OSmeFPzvY4SEWg-1; Wed, 23 Mar 2022 10:47:01 +0100
X-MC-Unique: 6AjQMn58OSmeFPzvY4SEWg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1AMfZZ7aUkGA7fbNTC5AgNyClOvsxaw+XEA3ArsqjmB7Gbyodu7Zth7u0+D1JkCYDS4Ejc28gAGzMcqq7aY0gEiWKFZ1GAPCu4+UqTzSoQO6TbyUQ1LscUorL9oqxlLvADoj68lf8h4GSvCAFKLxfjFSU4FvXNcBNW7jI3jeEuJ6GPPhQiOMebaWCuGUfSgXdJvyTNdaLKokGckdK9aj/Fwe5CUXxF34uh8twmJZy9XcKyJnm+kTwS05LRbPhA8mW6ezoUOkfngPEGfRUydCu20VSlcMU/AC4GtuQ1QO7aQtME7MDcLbvkKbPVtzBwJTEoywB+bJ0u3RjxHjjKJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMtRhTqTGY4MtWBMag/llzWOIxfbdqJRmgz/U3hPmGY=;
 b=iwUMr5kBTTdJ66Dwl+BoJLxkzFzldUaF9NYnbxxo5y9WQ2tiZd06yJy1DUO+I/popkOEWfO3BnF5E0x+1sEETMri2LitQpVcguLVbyyAVKCGkdcatCfNwxqIix9qm+Bcjp4qA+6yWPVqBa3RPYQ5XgyGwaRMQ8LDG6AleFCsvJ8Ozov6UXMgkRZYLbfnNE+KHTkQAvwAwMXn05QxQYxY9DbJ7KgqYIcKUrxgpkLKyNPP1w7hvA4kGnTBxTEzdCmQPwo8+UKK3mZzhJiDhVB8inKG0Z8g+59r2pWNKHqVIxCERBiD2hOX7TsPwS0gqjTj56/SzLqXuaz6nmC/cXGgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:47:00 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%9]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:47:00 +0000
Message-ID: <65c1031f-3121-d9f1-dc00-faec04ba6f93@suse.com>
Date: Wed, 23 Mar 2022 10:46:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-9-andrea.cervesato@suse.de> <YjrqO8Er3NqOG8uc@pevik>
In-Reply-To: <YjrqO8Er3NqOG8uc@pevik>
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fcad5d8-fee6-47f0-0744-08da0cb2138f
X-MS-TrafficTypeDiagnostic: AS4PR04MB9364:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB936445644A1ABA2B29BF1582F8189@AS4PR04MB9364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhY5kUnpcJr+fcw1iReAYrR3q2ZjC4sGAgV2dHlwNbB9Ctp+plnI3dt5xLOfk2wYiw+HFZQk6Qv7Ec3DOYJtX7AfpsjbI5QyRUROjytF0gKuwfZdTZQ7WCb8zBAE/F5+I4UchZRutQWqjqSa4uaa5/gSYvonVOT9Gpfhs4kJJXu4pVSKuLG1LbbHIKH0fYi+kJZaQgSymqWiLnKvEDWEB5jYmizBXKiyC1qsyxxsIgoMEn57c0u2WwW7hl84t06U9SEwZGc9QZZ46KLM7JfaHmPlr8++UvNGm2GNsNk9vqqQ57ZDoAe5QoK9j3m51ZhEV+tbv7M7K4bDNqyvlXwCJ/ZBrAUtpygFfY4xghensjPxDLJXIyQPdIZM7ONLVyJiH753WUHluXlwCKNoJagNmhOEiAwd0+28vz9eT4wDJ3R20HJkT6txfji93/HUWPSvH5XUFkESBioHDpzP1A/z1ctc7YVHdv+fW6j5AwM/PcLxdDS0BjWFQyiBZRfR4KZaTn7tLpuca/REE+1qiy8sHg6qja0VZ3ZJZ6r2MBThFobwX+WjpviuKYnZ7MkJWs0piY0TMijgSiWspxb7kdMK/eRhxUMOychGWbWaDLY49NYffdD7a1vCS722UZWJqCnv2Xcpx4lAIFZhiXAj76Qw7N7z0cSRc4tgrOH/aZlgeUGKDCgyi5vN+AmE7qSxNzjzoyusK1+1qsIKLjyPDJvndintn+kxJbgBNks8yFiAOY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(31696002)(4326008)(44832011)(86362001)(5660300002)(8676002)(83380400001)(110136005)(6486002)(66476007)(316002)(66946007)(66556008)(508600001)(36756003)(8936002)(6506007)(6512007)(2906002)(38100700002)(26005)(33964004)(186003)(53546011)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVEZHUzY2MraG5BcTlZV3ZzL2NEc3ZDaC8yWDhxdUJ6QytSZ0xwbmZYNWxF?=
 =?utf-8?B?RnI1bGQ0NXVELy9WYTBuYXZEek9vUHk3OGJzZ3FBeGtyUHJFSWExNmFTRDlZ?=
 =?utf-8?B?ZTRMaGVYNzFSWGlQTmErQ1lTY2lYM0gyMU8vR0dsYlhlcmNzVTY0U1FpdmpM?=
 =?utf-8?B?Um5vYnA0UTFtN21kaFBCU1pPNDQzMjlLVGdsY2l4R2pwbmVOZ0FYN25udThk?=
 =?utf-8?B?YnNUZXJNY25WdU5rdlNzYlZ6REZtQjk1RXdKM0swTVFwQTluNlB0S045VVE5?=
 =?utf-8?B?bm1LeTd4aVBYQWJnaUlEWHFLaVV2S3ZtblhCTm94OXFFT0dSRFIzNFZUOEpi?=
 =?utf-8?B?VjM5Tk1BdEZTZTk3TUZGL0YwSEhaVmVxYUN2K1hXbDZLOVFhY1hZN1JiSHFP?=
 =?utf-8?B?MFNHbUhadFErTHkxbjJrLzVEb2tTZDFhVXplVjBrYXFYV1Q3M2tOU1U5T0Fx?=
 =?utf-8?B?bG5HTFUxQ3l1Q3B6cmtMMFNiMGtTZU4xSkhaOGRnY3lJdHJRdkhQdmxwcHdu?=
 =?utf-8?B?R1lTNnlnWEl2TVlBM2F3Yk0vdncrME9qOEJ5Y2xDckgwRmZKV1BOemRTcG1I?=
 =?utf-8?B?Y2k2SWkxM2pwL1FiazFyYWprMEtjTHdaaDhZWFVJVFQyL2tLNitYK242UVY3?=
 =?utf-8?B?cVU1SUE5eS9DcnZkTXFob2ZmdDZVL3htdGJaR3N0Ulh4TjVwSTVVM3lVVDZj?=
 =?utf-8?B?RWFvV0dRSm1mNHRoOWVJcTc0VzVsSDlOWWNTazc4RXlqRUVybFdVcFdmU2lM?=
 =?utf-8?B?V2I2K0ZkcTd2MnF0eDNab29OVWJhc3RPWkpUa3JlSnJRRzFRQ0NRTzhMZDRQ?=
 =?utf-8?B?cmIwT2RKUjBNUkphbzhobkNFWU8ySzJWSWVKVlV0MzdWWkVZQmV2aHZ5eVVL?=
 =?utf-8?B?cThIcHp1L3g0bTlYTGh6T3A5N1RaRWlMY0hSMzA2NGI3ZDQ3KzBVTjBvYnV2?=
 =?utf-8?B?TmFnNWhza1VQd0FEdFZyOHQya2M4QWREcmxQRU4vZHYwdjc2R00zbURrOEtU?=
 =?utf-8?B?SS8yMVBkSDJBMGRDT0x6S1B0VTdHeGxCYmowbFFmcC9vdzZGQ0dQSDRFMEtO?=
 =?utf-8?B?WWdmcC9CK0E5Ly8vemFHNVRsYUJHQVE2OHpnZXNtenhGSGdudm1aQXkzVHRn?=
 =?utf-8?B?NXptMWNoeXBrd0dOSXdtSjcrQjZBenJHbXRiWjBvWjd4WUpEVmpVcVFZZkgv?=
 =?utf-8?B?SE8vUVVraUMwSURuNGpORVRZUEdCWG10T2ZBL0tNSjNsdzFjbkpkUXZCL3dy?=
 =?utf-8?B?MGlia1g5eFJzUk1xQ2JsTjl2NDNuQzA3ZnpETGZrYVREZ0c5cEx6VExDS1V5?=
 =?utf-8?B?SVVrOVgyQVNCc0w2ZWIvTjR2ZS9CQklqdmNzam5PeDVndk9NY2hLd1VuNEth?=
 =?utf-8?B?TjRuUjdvN2dPQTY0UWcwRWZraWlEQWFxc0VDbEFQejVEdzVTbDJrNXRmVFhP?=
 =?utf-8?B?MGw0bzQ5WHhBd1loNHl1b3NwdVhIOU1wQkh2NnE5SlRhWXh2QmdlZ0xVeFJS?=
 =?utf-8?B?RVlCMnNVdVBObVBJNllwK1hhNlhabkJEKzAxdXIyTHNZRmNVUkJSQzFyZ25Q?=
 =?utf-8?B?ZVdxSXNoMjBGUFlUV3ovRzl3aFk0aWJLWk0yQjhzb0JtdkNIRnZPallwd0VU?=
 =?utf-8?B?bmRScVdYU2tvMnVZZTY3V296UWw0b0FiSlVHNkoxbzFyRzltY1N2Y0ljRzFM?=
 =?utf-8?B?MVZ3TThIQ29pL2FoRWg3TlUrZXlwelQ4SXFhVFJsRWNsK2toVnBLNEtQeW1L?=
 =?utf-8?B?RXRSeE83QlhQS1RKZmg4ZUE4TXZaS3ZSR0hwNnJYNXlEYnVXZGEyNkhRTWNt?=
 =?utf-8?B?VFBqYlNuT1lFQW5hMFltMzV0UU80bEdVR3h6Sll5K3pXZ21hWm10SHdobTBV?=
 =?utf-8?B?eW43azVSV1lZRlRtby83akNIcHNyL290R1ZBaVc2MVY2Y1FNQjVJR0N0Zlc2?=
 =?utf-8?B?bkRDalVSU2xVYnlnM3JMenRFUkhsWFZEY2MxYXJjcWxSL1pyN3pyM0dGcitN?=
 =?utf-8?B?bTZwMi9mUjBRPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcad5d8-fee6-47f0-0744-08da0cb2138f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:46:59.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZeP3QfQcsFnAdAqaY0tibOZaD5L3ZeomOqqPbYJKSi0cGlNDUQoPzlVR2/UnMSCz0OY+gPe5YWz2AuT/K6wLj08azOPXkN0Ov5t8JS47ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] Rewrite userns08.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============1746391097=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1746391097==
Content-Type: multipart/alternative;
 boundary="------------Ym0La8Av2LuLZFslnqMsVl6I"
Content-Language: en-US

--------------Ym0La8Av2LuLZFslnqMsVl6I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

this is really strange. Thanks for the review, I'm going to check 
where's the bug.

Andrea

On 3/23/22 10:36, Petr Vorel wrote:
> Hi Andrea,
>
> ./userns08 -i50
> tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s
>
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:36: TBROK: clone3 failed: ENOSPC (28)
>
> Something needs to be closed after each run.
>
> Kind regards,
> Petr
>
--------------Ym0La8Av2LuLZFslnqMsVl6I
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">this is really strange. Thanks for the review, I'm
        going to check where's the bug.<br>
      </font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 3/23/22 10:36, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YjrqO8Er3NqOG8uc@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

./userns08 -i50
tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1456: TINFO: Timeout per run is 0h 05m 00s

userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
userns08.c:36: TBROK: clone3 failed: ENOSPC (28)

Something needs to be closed after each run.

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------Ym0La8Av2LuLZFslnqMsVl6I--


--===============1746391097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1746391097==--

