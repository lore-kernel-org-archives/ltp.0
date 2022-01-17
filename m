Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B2C433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 21:39:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00033C9636
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 22:39:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB2333C2DD2
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 22:39:29 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDFCE10005F9
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 22:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642455564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53R4dVWB6BBJsJVGVxliGbF8XOCwblCRGhbGft5EjFQ=;
 b=NO2pRlqdHq+fltx1vCySKeH+BmyCPV4GoYNChbSEB+Lsphh1I9Uk5WDWyIIvwof7YYouqW
 aoboAtAj/TqcoyhREg39spFRmm7QDo9Do1HP5F7Mws8SHPhYv/Q9DwM/doxHhVsi07OaIu
 fsSvV/fPTv71w/aW1fMK7t+r4/pcsjc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-iJOmQxGxPVSzdgn2URSSzQ-2; Mon, 17 Jan 2022 22:39:22 +0100
X-MC-Unique: iJOmQxGxPVSzdgn2URSSzQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StZxcI0xNsqbG3xTddo49ZrPPG69DaojuNYw1b9HAM/tAS94VPPGBvy8+RQtDpA6QNfDChEsIbRHk2JCSut88+pYWzl3zQpKFDAtVhYwxhVSB8DOfQptRILPF7eSjkEH3zunSsO9DTeViv5d3I7f4rQtplkDzFULnS38LWPnG5n1oIBuXlCnI9Snf/ZCSDAxwFgfhHrmohsILZK4m0UrxURatNXRYdSY6X+fQOWDrSvv36Ou8mr9obQiUVVD2haK6cVLqtt/TlCxCYbuWlcLFTfHRMfZ97YBXMjcI35VPqBzFnGDxMxYXzRV4Hfc9OORLy7Cabyv6eZOprE0wzqAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53R4dVWB6BBJsJVGVxliGbF8XOCwblCRGhbGft5EjFQ=;
 b=aetZ/QtfB+vEIjnDEYVLnLaY9DzFkCpghqqhJDmC+0/TzCHJHcvcxCFnDElay5KcO9BoscnL3n3arA2kWUtALOBUfq18jrsJQ7ilykwuZ7UzqRCHFt1E1ORxU5vgBAjvCDWE5h3rqPe3zVt9+39T6HnI9Wv4L0RG9KeX/9qU7uOGS1Xin5tX6L42USzLSQ0y+4wLN0PlXky2YbZkGFKYcy1j+9la5mfa0ZaUoarmYRTU+9HFAOlMi0pHW2OKTFfN9c4RdVDpkvH2TfA3DkHe4Xcb6HdNo5Y3J2arkag9cZlsVov4YBz1iwyevOcodw+oJ7HlGu+a9nUjQb8IX6jy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 21:39:21 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d%3]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 21:39:21 +0000
Message-ID: <9934fdcb-57ed-c73b-9007-c20ecb3453af@suse.com>
Date: Mon, 17 Jan 2022 22:39:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220117202354.20785-1-andrea.cervesato@suse.de>
In-Reply-To: <20220117202354.20785-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ca9327-de02-4cdc-4329-08d9da01d235
X-MS-TrafficTypeDiagnostic: AM9PR04MB8322:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB83229F5611F7F139A77DE1B9F8579@AM9PR04MB8322.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q+cSAoiaBpin3r4Bm95yVqCDIgmWXh0uM0jF6S0r/bjASct9Rcskb9DrOPWShCgCBhLUMuDxLtn6g0Jh3Owe5216Nn0uX+fQ6Z5VRkhrULiTc75PMkgAkIm37HE09TssKdx0LW1aki6jedUweXIp+hUOVhPomYv3Jy1iEFnhNIQXtTpUQMM40PDtJLFyi0TV+DALqSnyUD1j3uwMb5n6cUvUsVdVl71vbeWl6w4WzElGQlUY4NaxobDr0h9GuTkwPcJEIpQ/jo5yD2ojjE7SIhvI1pAU+w/rTUSe3KODAU4XGm+J2QkPSLmo6OvdBrHxZYZbIRQCziUuGfsQCNXnfRnxBUTvs0AQXZx8MP1QHepf68XbQeIITrjsRTrRfZcYTrcbJ5Npl8E57hKU4MWbp1E4cueWPWN2Kek/OyfenpM+fBZN7MJmuZQI8ZjwY56uHyZqOpBy4PbinBbIS3sjn59TLvShQyJq82OybLeSRsrvuEvKgz7aNMtKjkhQZgt37Hph/fyj+PORSTAUwpX7Cl20mKCzcGn1PvizjYGXMols6kNh4VY6wpo+UDTAgTR4Cu7d30AsZw7E/BkGzc0N56E5L7iWnh7cETjZxQ8Fl9XU5KDIbFwgzS26j7vkyke5H0WNglmaBOA141F44RFEp9W0Jfj7jhg38bc72CMwJfCspMsHUrOwaT6o8nG42SHKNQwNdGCuVP+GyEaKsqtWTwGTmvcPgTJHoPQR65B+9cY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(6512007)(5660300002)(83380400001)(6666004)(6486002)(8936002)(44832011)(2906002)(2616005)(26005)(186003)(31696002)(53546011)(31686004)(508600001)(66556008)(66946007)(6506007)(66476007)(36756003)(316002)(8676002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklQT1FPeWVSNlc0NVptSGFTT1U3ZXQ5dmVheUpGZ1NVUURnK0doamxHMlFN?=
 =?utf-8?B?YkZmWUJxNHNtdWFJS2FzdHpOeFdOMk1ncDlLWlk4WlpTSlhuVHNPRllHNlJ4?=
 =?utf-8?B?Wi9EeGZCVU1OcUUwVHNwTEVOTDlrbkRHZnpTVzE5elhocVNJK1NJZTdhYVVt?=
 =?utf-8?B?dERrN2FaTUlHVVBDTGlPckJDZjR6aWRXMjZyRkpNdExxMG1ETkFDMTdnQjVF?=
 =?utf-8?B?czlBRS9nNUtwUmxHL2VtcWhQZENFallBRUpXZlJkaS9tbXBsNjRIOTkrVUVs?=
 =?utf-8?B?RWd6Zm9zenVGZ2lES0svMjMxQ1AwVytSUVBydWtETUpQMEtQNUlyV0tlekJi?=
 =?utf-8?B?em5rNnhUV1hKbWpwblBEVW5YcmVuakNDYXhocVhlZ3ZTaGd4bGQ1dFhqdTU4?=
 =?utf-8?B?SG5mZktJTmJ1V3liMTYrenBSUENLaTNiek9BZzRQTWFDSlE0OU9FZjhOS3F5?=
 =?utf-8?B?K2gwTXNjdEcxVGZ5dFdCcnNERVRCSmsrd3pob0laSkFrT014VTJUVGRrVTFB?=
 =?utf-8?B?VFRUTnB0akVoOHByYU9ZZm83dWlwVFkxeGMwaFJueUZ5ZnI3YmRUeUpZeVIx?=
 =?utf-8?B?a0VLRlRLQWJuSnhnU08rVzBwNkxoNjNIK3NGb1VybGxEeW1CaEdaR09hMmtD?=
 =?utf-8?B?WVlQSVRjajJBbXBZQ1pLa0tDZE1NRnFEcVViSjgwLzVGTmF1elNIR0w3Z3RJ?=
 =?utf-8?B?UVBHbWoweDh4UjBCQ242bE5lV3FiTnVMMnFIWVJncHBkQmJ4alFYUG5iZ2xZ?=
 =?utf-8?B?NEMwTXp2SHdoTjZhcldYcXFMY3dHekVsZEYxVDdTMFQrWUN2YS9yZ2VPWk5U?=
 =?utf-8?B?RHUvTGpyeElacmtiVlQ1VERjL25aR01kWVRDVkxNZm5HR01oc1MrYW1hTWZT?=
 =?utf-8?B?T3RlQlRPekFocmVzS0hWWFNmTUNuVzVqWE41T1V6NWJhRnZWakhlKzBiN1Nw?=
 =?utf-8?B?WVpJOGt4RHQ4TlgyNHVwbVNlV0NheTJkYzkxQzk5OEZPdCtiUVB4dkhEK1FD?=
 =?utf-8?B?dERHOHRHVlVySFZGdlNrYjdCZ25lSnREdzcvS0lvbVJCL3dJazN5Zy9YSFhX?=
 =?utf-8?B?QWFra21YdG42OC9rWDF4VlBqblJnT3g2bWFwbzZlOW1BdjMvZ0JNOEV0S1lW?=
 =?utf-8?B?Mi9sK1FyRXFRVnJYaXhrMW9qK21wdVh4aGcwNzVuS3I0UlZWZmU2RjB6YzIv?=
 =?utf-8?B?UUFYYXJQSG94Q2d5ai9SUThYL1R4anZJNU1iTFlYRTU1UVp5NitYb05nN0Vi?=
 =?utf-8?B?Y0tvL3d1QWtDYks2WGNHeUxCeVBqRnVlYUtDdDBRcTBDS3ZLbWNGdE4wRDJR?=
 =?utf-8?B?MUJjYTJCWkxTd3dHMklGa2c2dGJYMlI1dlRXWWNMTHNzYXpLYUNyZE5oN083?=
 =?utf-8?B?NXg5c2JvdUVnYy94S2NkUkZkZ3kwZ3RoUVpzbVd5ODcrWWozNW8wN1VlUkc3?=
 =?utf-8?B?a2gvZityamFsakRXaGN0ODhZZFcwTmVIdVUyZzROdjVSYjA5dk1FaXgyNE5I?=
 =?utf-8?B?YVp2RkwvbnR6bVNVZEowTTVTOHF2YTNVQkZDWnFUWGlDcWt6QUs3djlyM29p?=
 =?utf-8?B?bThUa1JTcS9qUlFFTVV3UExkWUJDOTVIWmhzMlI5RjB1OGpYUlg5Q2lsTnZW?=
 =?utf-8?B?SklwK2wzbW45ZGZEamkrYXdjbUhzT1AraW9QeGFXbjJjMW9WMFRMcTA0RUxr?=
 =?utf-8?B?QW1QRFNmN1FqcGc4MkJaVGN6Y3ZrOEtIMmdONkJEcDlDckNqVDhveHE4K202?=
 =?utf-8?B?anNNeEE0U0JYZjNnUit0bm9LeGJpRzE5ajcvbE1TdStYc3BjYm1ZTEduQ2F2?=
 =?utf-8?B?UEpUaEx5Q29yN1BnenI0SHdIYlJvKzFOcWVxZmVsNTVrRDBRcmh1bXYzRUhU?=
 =?utf-8?B?N2o0NU12V0JNSVhBWDZ2RkEvQmVOY1poZzVQOUd6L20xNE5JQS9sNDZ0K21h?=
 =?utf-8?B?UGV2NlUwc1dBNmY3RVpFb3BsNE1IaDJuSG5zVEZLanJaQ3lWTFdxYWRyYS9N?=
 =?utf-8?B?enlFNm5XQnBWSU5icXZ1eUFmWnFBanpPWjJ5THFZNUkvTCs3RTV4UjYvZ3E3?=
 =?utf-8?B?S2F6NDZqR1NGZk0zYmtaaUlaNjNyMTc4R2dNbXZ3azB3bFFJQ2ozcklIMVp2?=
 =?utf-8?B?Z1JpRlU4S2x4RjNPNzBGZmdnVUZTZzVwS3Btekp0WU9TdEtJK3M1ZVNMRUdN?=
 =?utf-8?B?TkRqM3FsTXJ0NVVScjREdWNHaVB2c0t2Ykgwd2FnQy9SZTF6T3I5MFVpNm5V?=
 =?utf-8?B?STJ6eTZ2TTZNOEhKQm5hQXVKc1FnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ca9327-de02-4cdc-4329-08d9da01d235
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 21:39:20.8976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NppPqCGRHETeQmufkliOF0m1tUR/x2Gsw+eA+I1orRBPonKf0mvH0YMaW6SawdAnXZ25qEDw+Q28s3ITCqyjsclnHoqgs4ixJxuNusRR1NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/2] Add futex_wait testing suite
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

there's an issue with this patch, since it's not including 
__NR_futex_waitv in LTP just in case futex2 is not supported. Please 
consider the next version instead.

On 1/17/22 21:23, Andrea Cervesato wrote:
> futex_waitv tests have been inspired by
> tools/testing/selftests/futex/functional/futex_waitv.c that can be found
> in the Linux kernel official repository.
>
> Andrea Cervesato (2):
>    Update lapi/futex.h fallback
>    Add futex_waitv tests suite
>
>   configure.ac                                  |   1 +
>   include/lapi/futex.h                          | 178 ++++++++++++++++++
>   lib/tst_checkpoint.c                          |   2 +-
>   testcases/kernel/syscalls/clone/clone08.c     |   3 +-
>   testcases/kernel/syscalls/futex/.gitignore    |   3 +
>   testcases/kernel/syscalls/futex/futex2test.h  |  23 +++
>   .../syscalls/futex/futex_cmp_requeue01.c      |   2 +-
>   .../syscalls/futex/futex_cmp_requeue02.c      |   2 +-
>   .../kernel/syscalls/futex/futex_waitv01.c     | 129 +++++++++++++
>   .../kernel/syscalls/futex/futex_waitv02.c     | 103 ++++++++++
>   .../kernel/syscalls/futex/futex_waitv03.c     | 111 +++++++++++
>   testcases/kernel/syscalls/futex/futextest.h   |  56 ++----
>   12 files changed, 567 insertions(+), 46 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/futex/futex2test.h
>   create mode 100644 testcases/kernel/syscalls/futex/futex_waitv01.c
>   create mode 100644 testcases/kernel/syscalls/futex/futex_waitv02.c
>   create mode 100644 testcases/kernel/syscalls/futex/futex_waitv03.c
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
