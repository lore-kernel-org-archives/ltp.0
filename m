Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1693C05027
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 07:48:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE6773CB454
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 08:48:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41AD83C18A6
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 08:48:06 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 685EE600453
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 08:48:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqdUTBx6o0jo5LHFqpw9+/INb+QVoN/iqMrYYJP6bp4rRYWMSWjH9AnpBkxo9daWS9JzZTvOCAt+2f9BPp0yrEiDKyHW5b7htLLGwLlZD/svEJyJUul3dh/MiZWZ/HqsUk9gpklytUo78VZn182TwmwuAuoYEogUdWjOK+aBxP318jgQbbdJDA1FLKDcWVjW0uPN/+j60zsMl5qyczrFn9eGeIUTc2QQ0/L4mLKutf3rWrzD6sWubCu5QpHOFiSwL7skrcGHSckv8gNpwFkYzlgzr3c5ewxw5LivgbVj3XOy9GcN/kR1sDiZnOjctM+aPflApZ9wBGlKRI638c+BCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5fPHNFp4cAKvDvEyWZJ1Vg3fu+4JCrRpSfzBeDOkWs=;
 b=CsLmErBivNh+r5IybhlslaFGgsI3r1brjoOyICpebqqrRkbNUs2UhQu3Fm6QA5jCZoLvaeS7/K9vw6etjDRi0ArKAVNlcB9lVR6qwWoxX2dYBOE4lON8JjaqgzQtt0djQRgl3fTs8oSMe5ARdEiMdFUkCXtc2H7R6WcuB24AmemkKB2WMttgehIkeEefoPBg6UtvhQeILhYx2icIlcRHVLvjk7fZh1jwTDT6P6EUvxuig/lxoedBuiwvbFqh4rfaMVoOvcfT11a/bMZ2PrJVForNdaDnIGmMFQHSGu4q15Dzt4dbGVG620wlmpDqddHdaCaLwnI+PKr/xMzwg7crAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5fPHNFp4cAKvDvEyWZJ1Vg3fu+4JCrRpSfzBeDOkWs=;
 b=BiZ+cpeezNeELjXJlxKz37he/7dHhiTYc8kPtmL6QS2nrObGR6x2kjeuqd71We+x9MJJ45y0nI/Wkffbh5mPAE6Db+DAIyBFvfmIt637SV4UlwWmUU1DnvH93Na/5c6EgkYysKcdNBzB4gu1iqjAbWkNDk+VwkJV8qfcdgfr+J08jffqj+vMPte9rPO1mdDUvscfr7SIeMFILAHf/EgzJZJp+PC1aWMvsQc56X9d8aCZtx94QdwUoG3n5ImhZpa38nTaYJvJV3aAZjEbVuh605krLPFJ+ymSgrzCPjFjo40aw3XEeyyLWEXB5rD4IKwiEj/LRVmZHjjotyy8lLvrTg==
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 07:48:03 +0000
Received: from AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e]) by AS4PR04MB9433.eurprd04.prod.outlook.com
 ([fe80::7f5d:f7d9:47b1:cc2e%4]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 07:48:03 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1] io_uring02.c: Check EOPNOTSUPP errno
Thread-Index: AQHZLJY+biU/hurzbUG65QkPOCvmb66m7ZAAgAAAMKA=
Date: Fri, 20 Jan 2023 07:48:03 +0000
Message-ID: <AS4PR04MB94335A70FCC77357AD1F931ADEC59@AS4PR04MB9433.eurprd04.prod.outlook.com>
References: <20230120061247.8361-1-wegao@suse.com> <Y8pG8LJURK9ysW2p@pevik>
In-Reply-To: <Y8pG8LJURK9ysW2p@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9433:EE_|DU2PR04MB8982:EE_
x-ms-office365-filtering-correlation-id: 0eb69dda-b1cf-4593-6e4f-08dafabaa927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dcOPp05hs303R2iYMb0PfPxnfEpF6Cu5fVg9nXzdUQteiuVG4CHAktoy7FAnMlT1N9e3tMesbVzOf+aWDhK8S6myZDPzNyHnG6DMlMQ6VdX7KgbzbJaF3GIdT/iq8V1q/IEL/QwjYLhXFJAoTC8b984THqwrDWHjW+2lVe81gVO0xwb1DGXvdbehGE41Q2Sp+rGZ+0IgBhHZQBDpcQT5XVxJjr4mEbkpJ0y9RbrA8sgwXP+ynjmSUNzMRYVv070WcrZ05rXuX2YWvMkepf5K9eIOzeb/nxdwJfQt5Ah6Vw9BBT7kVQeeAWj33PsiePh8fC9yCl0vkvp4wmvYpDjagqjbSTOVMWU2w8XI9IOVSxio/TQLFvzBMjkKysenhdHrY+X2I8t8zBMh/Uc0FnmWNyNmrSB/j03lS00MFiGv+stfb3E0mD/BFAv3u9FyfuLEhrCFGKNWWOqAEaSZ1GB6M8DErKV+ELzKe2Rpu50kWApcAbjLPHAhDnkSOkz14xKEn7CANVw7rn4KmXv4TxbXedFF2YFvEdfmCRlm0/ehx0Et5/Hg5EjwdotWf1SBcdKj+/mTsqdCoGgIQVrSu95M4TuvAx2HfAnZFGUF2J//kEJN0uOedsxFh/ORDEVS0qb6+ZBsmK+G3c1v/Etqci81ZdpxdPhXkVPFKQ1u9L9m3i1YHYGKobBaNIlAiyLUHdpb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9433.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(38070700005)(38100700002)(2906002)(5660300002)(55016003)(122000001)(8936002)(52536014)(41300700001)(86362001)(66556008)(66946007)(76116006)(8676002)(478600001)(9686003)(33656002)(66476007)(6916009)(64756008)(4326008)(66446008)(7696005)(71200400001)(83380400001)(6506007)(186003)(26005)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HU3YORySy1/jI/WeB5q/h8q5NbTWVf8oWwBSKLzTgNKRGZbnB0IBDK42F7WB?=
 =?us-ascii?Q?ca4wkB1oOiefGKfvOgioPr+mBO5bl0Qtg8y8o246vxcdNLnNP/EOkgv7+Yeg?=
 =?us-ascii?Q?ZWduczOwRL5VJgL2lpNzxHEyK3FCobST88Q0yIuOy8gUJ9UEyqg8Z1JXCY65?=
 =?us-ascii?Q?8je1EXMbY7zT4l6b5Cs65yvDoKx+hneHpho/OjSVYYNo8YIAdAPvdg7ofnBQ?=
 =?us-ascii?Q?+o3wHJ6MkJtzRdFyUb/M6T7YqC3UIN8ny6mQSmXy37HBefDZtc7icT6VESE8?=
 =?us-ascii?Q?JHNJ+s2CLW9YrOd4sqnl3L1B1SuiQQxOOze6iCetB7N8rbZfjTI17dfAV/4W?=
 =?us-ascii?Q?ttgE0LMcDevaGPQ7x/VAZIbmxuF1KvxqVtSeYq6KZPbIAThNXGRndM2fKbZU?=
 =?us-ascii?Q?QiSyAuXCDEREDdl/lVNm8VSWv5wWihgf+nchnXguBGaRCPY3PDLrm1duNnqn?=
 =?us-ascii?Q?C4slT73r70JepN/zrm+r3pXP9ro8jGOkHZyx2VPI4+fx2g2Q3i4bxocJHa/K?=
 =?us-ascii?Q?D+0LR9TGQ5BC3zEQBe13UqVdYO+/y1AsqnPzlpsxkyvF7CXMuwm5AXct1qlh?=
 =?us-ascii?Q?ev6xP86tEL9xSJnh+mVCFHBDHLHKwHLj9IJyaO+N7CzdN2lIHZmSHsn8z79O?=
 =?us-ascii?Q?ut0IfJRpq9BWnSQiBPHx35vEZ2yNrDslgE32p8CG02mrNjgU9Rv1+nYypue1?=
 =?us-ascii?Q?gQC4salZATWMczvDKG1NowAEwkXPYLZsRVSX6cw40aVpbed9dQMMBKc9uiXP?=
 =?us-ascii?Q?019eT4t+ioyrBUF8f2uRRDbmkiu9J4sinua6im5n2WiA3ywYNT+UH/sOe7wC?=
 =?us-ascii?Q?Sqzm3rIT6I+vSYsTTRCbm/Pd1sYUBw3urwezdcLVaYOW8Oe/W3rYG9uZyCAH?=
 =?us-ascii?Q?wBqUnJ1l4oJ4vVFSvtPKMkcjnmZJcsPLFOQ+9OdGfrmRB+dOhJLE5LMjQiTw?=
 =?us-ascii?Q?Iem1mLDbSTMcrz5oK4bHbmgRZ1Z5W8kia0BaDWHF3BaG1VKGKQJclRUpAlTT?=
 =?us-ascii?Q?B8DQkBWukaCDxiZwxdYFDMpyrBY+r7XilDRhs58tAuG7UBSd4oeuCYIl/2/l?=
 =?us-ascii?Q?8LsA9FX1PbW+33WcGtlfzBzY+ft9W54+LWudmjOI8fwEyRgIdvhdxdCAjLLv?=
 =?us-ascii?Q?+qeL/6S6h7s7vKeCMZnFUtyPL2rKeT28jq8C50RDsca6vgS5GWWOKwoNnLJo?=
 =?us-ascii?Q?OB85ZX3W5RMTzEQpAGZZYqUshbM8eGXC5soyDCcptWoNJFlbvup/bZBD7kI5?=
 =?us-ascii?Q?s1OHNZhW0Y6kdxFo0vM55RbsWlESGkZSyE1B1eGLuIR0DCbZR97TD50GOMGt?=
 =?us-ascii?Q?Bf6o/ov7LXWKJ29X8n/Gb0hTdGIXn/FHTGCY2LMS1lyvjo90aEoA0jRWSNk7?=
 =?us-ascii?Q?KkuV3iIyBL0hLMlNhHtOAdk2PyIa1OYwYhKXIeGhpCACXMFpghc+IW6ws1ct?=
 =?us-ascii?Q?54PYCWw4yK5s0rF0V0iIBdhAYsOeLa3axHz/G2K6C6JIlt79KNMP+k+0zWKz?=
 =?us-ascii?Q?t9QikXE+Q0c2jXncSTmhBaijQYgJzhfePCDb2bYBJ7/M4NUHJaQYRkdUULmK?=
 =?us-ascii?Q?IEod+oPkSns+OB9hnH8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9433.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb69dda-b1cf-4593-6e4f-08dafabaa927
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 07:48:03.4828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8AA7nbF+LSgePdrhzEahbf53R5+OBoe1KtWtivyCdDJTKYSCduDOy5F9ENKDy1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] io_uring02.c: Check EOPNOTSUPP errno
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

Thanks a lot!

Regards
Gao Wei

-----Original Message-----
From: Petr Vorel <pvorel@suse.cz> 
Sent: 20 January 2023 15:47
To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v1] io_uring02.c: Check EOPNOTSUPP errno

Hi Wei,

> Add check for errno == EOPNOTSUPP and quit with TCONF instead of TBROK

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_safe_io_uring.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/lib/tst_safe_io_uring.c b/lib/tst_safe_io_uring.c index 
> f300fd38c..923c3e43d 100644
> --- a/lib/tst_safe_io_uring.c
> +++ b/lib/tst_safe_io_uring.c
> @@ -15,6 +15,10 @@ int safe_io_uring_init(const char *file, const int lineno,
>  	uring->fd = io_uring_setup(entries, params);

>  	if (uring->fd == -1) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk(TCONF,
> +				"io_uring_setup() is not supported");
> +		}

I merged with these changes:

		if (errno == EOPNOTSUPP)
			tst_brk(TCONF, "CONFIG_IO_URING is not enabled");

* changed subject to: "tst_safe_io_uring.c: Check EOPNOTSUPP errno"
* Adjusted commit message (no io_uring_*() syscall will be working due
  CONFIG_IO_URING not enabled in the kernel).
* simplify if style

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
