Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9376C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739355559; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=i8DD6XKqk3Go9KhDVmm7CmETx4ovSoDIcU6oUFDQURw=;
 b=bY7dGYrORiT3GFHROkog/g3G6z8ZiDPoTekGyFmLomzdnFKeKBZRrreSrPzQ5qrPqOkWw
 CB3ONigBkIVDQPfbnts6Fv8MKn+1JkfRQzSovwIzzbrjkKK8vgc2wQl+nOCUbQIWku+xxMt
 apiQtZUv3DRjiRbOaNrrfKDFN8ft2mo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 181E63C99D0
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 11:19:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAE933C9252
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 19:22:35 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3DCA3101282F
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 19:22:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXFqbbR7lAd3iBEIFQ3Hjy3UFaOVlIA+WPQDpsxdMTjjGHHQof9TdP+tBJr1D/rr0s9QaTyJZZkWsixv0WayGnIGlvj5sG7z9ZIUiribnwOkW0rKj+v/t1GCqLbfqON1PhOx+4RKrX5oYSVH9s0mk7Japg+/ju/Nb2xjMeosSy3PlwcwVZn1WtgdFvX01V9HopBCwG/54Wzi+B6raojhfTwpYbZ5zcGPaPDc1j5RZqAgsFOuXYntdZNS9YjM7UPN7bqb1/hrXsvc65pmE2T8G5Sotbtwwmqd2mmn5hAc+eE3uRUsnhzQpQza7KSvnzJe/yyKJkl/i+RTn1Rqfikhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoqZioit5Q1eK32IYLRRQe2g5CvWlgIsbSEeIY6u4XA=;
 b=OYRTURpS9nQuEgIAOfKYH1pxKAAWng49W/emaEhwwb73mGuWAg+wyxWB4Cngw5g8LBBivFRVTScAxXPp9c/hL0QrtaPcO8DPI15UdrTy0N0Gl8dZqCTN4XML1j9mM0zFEaUMku6+TY6Dsk2CEP2vMPglHyja3myT1DCe2Tz1uVtPoFhMyNwTeRXPNB0DUC+UZy8y+CuOJg4cNbF45iSrxt5HCZP6cLWRTPh6ySm3nnDyv4G3d49EJbq5jkyIDEifGtTtTiADkGu/Pj3fK0wM4GLJHONO2r3lY9FJAyB9vC1/mC4SzOWbWFk3yVTsrTmkt+PhYXm0tvi6IaeWcS2wrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoqZioit5Q1eK32IYLRRQe2g5CvWlgIsbSEeIY6u4XA=;
 b=oF5j+rKuj74nmjSitSjDiNrIeTt2SQNN0a893cZpNwhdYfmX2Rym+P2hEwig8JpbhTYy3vy1R2F6IE5cULIc8D6MsRn5WQLxhW4Ouh7OrSelI/DC/Z3xagrUdElqXJBZF4ipMsww3z5GgfusxTE0m+tONr7dpHMlF/TmjhtNWdffqRYKRr40pzjCvyJZp9kAafiQEgnbv3QFovnD2MYhN/Vejhi/SxfnfBoZBHuCVxE19bI7HjRh3VkGx+GcntMHkalzJlW62y5WoRhW3oQGbPQYw/PleO6oZfem7EdwbvYExF9n4QH7yKlVsElgn8iXanHdv3kG+sddCHG3H+OzfA==
Received: from MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 18:22:27 +0000
Received: from MN0PR12MB6001.namprd12.prod.outlook.com
 ([fe80::88d6:a879:1cf3:906f]) by MN0PR12MB6001.namprd12.prod.outlook.com
 ([fe80::88d6:a879:1cf3:906f%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 18:22:27 +0000
To: Andrew Morton <akpm@linux-foundation.org>, "bugzilla-daemon@kernel.org"
 <bugzilla-daemon@kernel.org>
Thread-Topic: [Bug 219750] New: Unexpected result from the stack_clash test
 for CVE 2017-1000364
Thread-Index: AQHbd3beceHkUxK+tUicasFiGY1hRrM5BfT7
Date: Wed, 5 Feb 2025 18:22:27 +0000
Message-ID: <MN0PR12MB600148F4EC4E2693D7EA076BB3F72@MN0PR12MB6001.namprd12.prod.outlook.com>
References: <bug-219750-27@https.bugzilla.kernel.org/>
 <20250204183709.3db159f63a99a8dc25b7d342@linux-foundation.org>
In-Reply-To: <20250204183709.3db159f63a99a8dc25b7d342@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6001:EE_|IA0PR12MB8895:EE_
x-ms-office365-filtering-correlation-id: 01e97e90-b71e-425c-7dcd-08dd46120bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oey7rc6b+u9V4HqObvz9UCpZhHB5Pd+ZmotbyJ3M2TSqskTNT7Q40zICYoqh?=
 =?us-ascii?Q?cWbMqW0a+ldZwj8ZY5gIuIP6Uo9bjPEgLtDI8T/IDjMFCJRx2I7v0ilX3O7E?=
 =?us-ascii?Q?rYbZjOnEamlbAPnZHqzYj3PgpHykAkZJTF/QMiz0SqaI4fr3M/uf16pgzxiT?=
 =?us-ascii?Q?Mw73jjKYnF5LkmKkc4QanwpI2UZEASmSO/8xcAr1RTD4WQTPrrMCmzfXm9Mt?=
 =?us-ascii?Q?/bCqg2omLGhhQkqaiEQglvcmDgn39aqWUYYN83zveKhfHu1NBoj/gwJpLYbl?=
 =?us-ascii?Q?kzZB1yaU70PgmcEMPybO3GT5ldWfOqnZFSj2VVNv5Y741nNfFQR1jP8K5jgb?=
 =?us-ascii?Q?/PHfKim2INZ2GDa7ObxheEoHm+wCv2SrVGek2vNC6lAoxWNzH/asj0U1Js7g?=
 =?us-ascii?Q?/QcIunurgC4Knmm4W3EkXl+ASQRqU7uvKqdycZG4ihsbwZcila5+4lkxUtM8?=
 =?us-ascii?Q?UXEw/6v2N4TbZUkVKB4zoLPSfUSAo3RmIoC/SiAzrP1XhOPRuDvilwaPidFE?=
 =?us-ascii?Q?2Ax6pTHdGtVy4qvpZftt1L6AZHw3oFoK68j4CLd93bSq68BdSRruKN8pVnJd?=
 =?us-ascii?Q?0ZVcDY4BWsG0kKPuxPyiAIzAnt3wjV2uRFcOZJ0OzJVsbIitwdThudx9Kt88?=
 =?us-ascii?Q?gbS0jSGu4DR5ICI/qC0vid2O02YU5ccrjtxATBoQrM6qCVzggAuJQnn696Wz?=
 =?us-ascii?Q?cxPUD8wvl+BYWo7Mfw5OuXPPnHDSmQPhup8novCTl8UR0WLs5Ej/xEoC4gOf?=
 =?us-ascii?Q?ups483xvDg0Otb59TcuhXQt+kEhEB8n5lULMFk8Amy7+OEVHj7TfGAmj6Hzx?=
 =?us-ascii?Q?0INIUflGisHYwqToKplaMpi8Z+s5nS5HpkKf7xLDBZfCQKBlYd73+BMVel0R?=
 =?us-ascii?Q?o2jjiaN0nfobO2JiaRSRc+v8eTSKmBECrvip8w/+cNF+/55to0b34mdywGhh?=
 =?us-ascii?Q?faC+ECl1Tu+AXBduyGXdI9ve5CtFzMwtgY8zvmYONOgrXejSuP9BCVFLMECd?=
 =?us-ascii?Q?4MEI4dLeI85vMweZHL23HQmNLGn23VxaktEI56+oA08JaD+os25iM0FGKQZh?=
 =?us-ascii?Q?6pGvGuZXWkBOhv0XPP2TNdFf+ryl6DYqaKJWWUsBumhCOaLIaYrmfhPJrLTI?=
 =?us-ascii?Q?mEjIcM9E2Aqi0jpi9xAitdBkfjsBaeSNPBJl/vXLUH3k4lKW55EhDQyxhauZ?=
 =?us-ascii?Q?lSLGK5KRoOPBZW2eGczmuaOI4JDa9ViHaehCpe3boSX9ieclUotdgex293NJ?=
 =?us-ascii?Q?ubKxA92zS305BDj6x8ROOT8EJlBLsh1nytI41H+/SjLi/BND+XwRyVUD9LJ6?=
 =?us-ascii?Q?3N2XWC9W4xHNbo0Baewklrni/G+/okfgqAy1yziz+kZayXDctiDoZO6AOmYF?=
 =?us-ascii?Q?sMrOgGQTMjZ9N9jHH7qkGn2d7Qq9VLa8E4283IvZ1ljO4eqxDA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6001.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4HoZeB0glrILPtDRDM9qAW2tYCvtpzcEqySZAK1mf4AxIDwlPSMqbrqr7Yp4?=
 =?us-ascii?Q?l46CxWn/UUjFuBkoD2Cz4i/ZALN2/OsZea4CVrHByOYOBF56U/v9+rMlFNEy?=
 =?us-ascii?Q?xWPDXcf3wNSe26sFqSXv0FQtF+lQBpKEXj/TogRBtVvv8bWYJ5YVDztfv6VE?=
 =?us-ascii?Q?U1AGPPOGh8NDv0agXOgTdfhvy65nrwz2WLJfnLgr0m+zrJ3KC7znYKh7nCiD?=
 =?us-ascii?Q?GhtAQ418TSoVeN3UBQtJtlLkLomew4R00j32PMW/+mGMkTgur8dJWXFYelUp?=
 =?us-ascii?Q?3JiC12RIV/MUOOwNniRLETYAU2ZVzNn74N5dxkc2w1h5Kx1+b7xjGw0EwMQ4?=
 =?us-ascii?Q?J1FUE///s1cTqRo7k8vWbl/2DBrHgH0zXRvXs9Q8/j/bbia5dnQrb2Z2pGev?=
 =?us-ascii?Q?8fSo/00vthaafUVQexMqXbrpsrQx1I3XK1VS/WAq3vthqBJ8mPHgHirjZjUg?=
 =?us-ascii?Q?L8Tle/27aA/UCoXglE5Ha+zU8tYiK48oQM3vvAU9nDQVn3Z7iDoL59boNdIn?=
 =?us-ascii?Q?fibLR9AUSxK3mZnyB4TBeczG/erGjB0HSCHFn2oCX/uVa1pOwFGdyH+OfdT+?=
 =?us-ascii?Q?ikQq+47mh/YcWX+X4/WSren1+1Pf9iI6n+YBC3gn+F/C1b2LipeXpl6Igbnb?=
 =?us-ascii?Q?OvvuB7eXzslKm07O02e/jItD4YwnxihdzhoOuktvYhJdmulzU459xihJWXE1?=
 =?us-ascii?Q?ZxvodJTjDqC2peAGz5QMrn+zHv+TeSY9QHop7de9rQ/TzxYDjSL+tApAPtPT?=
 =?us-ascii?Q?cC/9bmgq/l/fp9ikHJal1muiiwQ4r6Ogu29BuYGmLrLSk9ItJGdbHOvy957s?=
 =?us-ascii?Q?xIhPQIQXH97MwSJV5M/AXOmVsxg2oBIa2I0I4M/YiT0Be+4zavQrYCWKq8Yn?=
 =?us-ascii?Q?qaa0xjtyxIV4mZvjrsDjkKF3aH/nRuWl/uvqrN/dmZY7MIlwH/igUHZ2pLd+?=
 =?us-ascii?Q?RwS80swiV3yD3N02mNv69Q16xsEyI77Y4cJ/6QsGaGGlyxCU9uZ5CFqZzRWb?=
 =?us-ascii?Q?YW7x+s3fJ6yzbUkSB+BDa79qLxiYtVpr9ajOMQhcWmOz4H+XbGzwHGgkB7FR?=
 =?us-ascii?Q?NgQxP9CAdF7RQpgT1UE7801+kQv0+xYIsUT2sD4Wz0sfohmilXgRD0zoJcdQ?=
 =?us-ascii?Q?nYrsGxQFLHtAyVuijQM4wVQk2KRQolqm3TViBygqZADJ4/TicgcDiWptINuE?=
 =?us-ascii?Q?cogZujozNRrbOqvmrwL/5+yPZXcEt9j6ebvYu5vPm25BwRb7KnNz0TKhlSOw?=
 =?us-ascii?Q?M0x7sIzehtTYmLXT2ykPlafuTZJw08xVNZKwiYu6OoY8QER03HplBOk70Hs7?=
 =?us-ascii?Q?AnCL/+hDAEMut7VQeC3nOFicIbJUKzPw4L62EIs5vmYGUWQ9Wjed7TzjrZ8Q?=
 =?us-ascii?Q?NwD3azJfIOJbWWocetkmRTeyjxbPa8QM3q7dk/WXbS+IrG3PQIHzjOeaWW9C?=
 =?us-ascii?Q?9HVu/zvYXOfEty/ipFp01mBaS4B/c1M8slUfOOrl6xfvJwEPD0AevbAdlyGK?=
 =?us-ascii?Q?lNh0nPCg2MdVqp4AWw0SCSC0eUmUu8Y5mOH71Pt5s7BQJJzv1VLy944megTn?=
 =?us-ascii?Q?dq67udEXOrG4Wf2d+eU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e97e90-b71e-425c-7dcd-08dd46120bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 18:22:27.5719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3z/Uik4R6XIP+3xJO92cudikBYridq2sRMt7KuzgHcYPa0VfEeuWZCIcYbsp9Hw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 12 Feb 2025 11:18:57 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Bug 219750] New: Unexpected result from the stack_clash
 test for CVE 2017-1000364
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
From: Leandro Awa via ltp <ltp@lists.linux.it>
Reply-To: Leandro Awa <lawa@nvidia.com>
Cc: "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thank you for the reply.

I forgot to include this information but the test system was running a Rocky 8.9 OS.



Regards,

Leandro Awa



________________________________
From: Andrew Morton <akpm@linux-foundation.org>
Sent: Tuesday, February 4, 2025 6:37 PM
To: bugzilla-daemon@kernel.org <bugzilla-daemon@kernel.org>
Cc: Leandro Awa <lawa@nvidia.com>; ltp@lists.linux.it <ltp@lists.linux.it>; rick.p.edgecombe@intel.com <rick.p.edgecombe@intel.com>
Subject: Re: [Bug 219750] New: Unexpected result from the stack_clash test for CVE 2017-1000364

[You don't often get email from akpm@linux-foundation.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]

External email: Use caution opening links or attachments


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 04 Feb 2025 22:19:44 +0000 bugzilla-daemon@kernel.org wrote:

> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D219750&data=05%7C02%7Clawa%40nvidia.com%7C5ab5b4d3c70344f417fe08dd458dfe42%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638743198365806564%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=lCwiGq%2FLpeyLROctH6Zo%2FIYl7h5JSsbb8%2FZPmwpXuhQ%3D&reserved=0<https://bugzilla.kernel.org/show_bug.cgi?id=219750>
>
>             Bug ID: 219750
>            Summary: Unexpected result from the stack_clash test for CVE
>                     2017-1000364
>            Product: Memory Management
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: akpm@linux-foundation.org
>           Reporter: lawa@nvidia.com
>         Regression: No

Thanks.  I'm suspecting that the changes in 6b008640db73 ("mm: move
'mmap_min_addr' logic from callers into vm_unmapped_area()") broke the
heuristics in stack_clash.c.  Let's cc the LTP team and ask whether
others are seeing this?

> Created attachment 307574
>   --> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D307574%26action%3Dedit&data=05%7C02%7Clawa%40nvidia.com%7C5ab5b4d3c70344f417fe08dd458dfe42%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638743198365832526%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=FYbvvW9%2Bj9LS1usZlgAUmwWQZa%2BwSRfH9M38%2FNnHB6o%3D&reserved=0<https://bugzilla.kernel.org/attachment.cgi?id=307574&action=edit>
> git bisect log file
>
> I ran into the following unexpected result from the stack clash test included
> with the LTP testsuite while running tests against 6.12.10:
>
> ###
>
> tst_test.c:1724: TINFO: Overall timeout per run is 0h 04m 00s
> tst_kconfig.c:629: TINFO: stack_guard_gap is not found in /proc/cmdline
> stack_clash.c:296: TINFO: STACK_GROWSDOWN = 1 == 0x7fffffffcfd0 >
> 0x7fffffffcf40
> stack_clash.c:247: TINFO: Stack:0x7fffffefc000+0x103000
> mmap:0x7fffffdfb000+0x1000
> stack_clash.c:207: TBROK: mmap((nil),4096,PROT_READ | PROT_WRITE(3),34,0,0)
> failed: ENOMEM (12)
> stack_clash.c:329: TBROK: Child exited with 2
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D58c5d0d6d522&data=05%7C02%7Clawa%40nvidia.com%7C5ab5b4d3c70344f417fe08dd458dfe42%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638743198365845964%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ykZjHGwpe2I2mEf5cV1hqpGRGZmqlPXVuWW0CEvXsyk%3D&reserved=0<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58c5d0d6d522>
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> ###
>
>
> The test worked previously on 6.1.x.
>
> I ran the same test on a 6.6.x  (6.6.70 to be specific) and I got the same
> failure.
>
> git bisect testing appeared to narrow down the reason for the unexpected result
> to the   following commit:
>
> 6b008640db7355d8de6ac18f74cedd7ccc92684f
>
>
> Tested reverting the changes from the latter commit and I was able to get the
> expected result:
>
>
> [root@rno2-sim-j08-017 ~]# stack_clash
> tst_test.c:1900: TINFO: LTP version: 20240930
> tst_test.c:1904: TINFO: Tested kernel: 6.12.10 #8 SMP PREEMPT_DYNAMIC Fri Jan
> 31 12:42:41 PST 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1724: TINFO: Overall timeout per run is 0h 00m 30s
> tst_kconfig.c:629: TINFO: stack_guard_gap is not found in /proc/cmdline
> stack_clash.c:296: TINFO: STACK_GROWSDOWN = 1 == 0x7fffffffd3b0 >
> 0x7fffffffd320
> stack_clash.c:247: TINFO: Stack:0x7fffffefc000+0x103000
> mmap:0x7fffffdfb000+0x1000
> stack_clash.c:89: TINFO: mmap = [7fffffdfb000, 7fffffdfc000), addr =
> 7fffffefbd60, diff = ffd60, THRESHOLD = ff000
> stack_clash.c:321: TPASS: stack is far enough from mmaped area
>
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
