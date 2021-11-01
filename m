Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E72C433EF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 18:28:40 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED0760F24
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 18:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ED0760F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A2453C7057
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 19:28:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4023C6A6F
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 19:28:26 +0100 (CET)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C564600960
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 19:28:23 +0100 (CET)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19VNrAQZ031331; 
 Mon, 1 Nov 2021 18:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=1PvCdLO+YofKM973mqX2UlLNXybpeWiCbWs4ZRBk5QA=;
 b=hcKS+jmWxCZdzungQ8JJ+juFyBOdq4VWSVTZlpQHxazyf8zF+X7ZPyEfijp84y/tDee9
 eryyoN8vOQEcO4P2dOdkzYblFHqDE3OrQ7TK0wStbjNHv6cVt4mkeZjHML4HiKWVQbJb
 c+3PafFh0/0PWdD0kCIFHD25LJh6iGC44TN4ZSGP0+UGNM/jTinoPO38Z5oxo8sg0bRg
 vb/nhjNqvFT9mtMPnDaBrwLm6IHMHmjE8XcUO4AdeHmW8/UY972/n8UiWmOgARzUoOhf
 xiB1E4+3NIF8OnBgo5n87ILhPMdeQRLROMRDnmvHL5lkO1f5dAsl/LaamjMfRWF1tbvo 4Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx08-001d1705.pphosted.com with ESMTP id 3c0vu7ty5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Nov 2021 18:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQRhzZJl7be2HjwZdS2wOTmR8xJGZ1sMnam3Da9y4otFEpeP52q6QXWcUEZi0RaTs87DDuZm6FwqE/1gqOO2Y4NrpPUt/PHYqiVkveNSrrV/PURnubqYmwQQiSrADJXPMvRGBcj9sLyQaW3lYYWBU2Auo5ksU5E8xcd4b//v3eTwr18pNcerVYvYwNa7ksMhKNuvj/E7p2qzBOFTQ9EcFyxLMDKXgrVOVIV2crxrSxvHlMyfhZHozX1NsYPaDEc4eub4uITZfv8UGIyyxgxXQiKQKFhGNvUYvZoxUYdR+5HfAHpvVi+qB8s1C2dxgwbDMsaUeg+EfkMBXS4AckwLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PvCdLO+YofKM973mqX2UlLNXybpeWiCbWs4ZRBk5QA=;
 b=k0gjMQzzS/2GiWnisN8ytbkWOpOP588BzRGP/bhbOy1SqFHmEUeiKbGzZ2R9bijvzw8qL05P7O5dxID6A7cP7LV7ow2EyeTQtvGVPRFOG3vPESKuWG4ocMOli8bysmZeHDTSgDfhvSbnP+BHYB0tRZEAfAe4z09okC9xjEzbvg4P3FqLdo4NSd3uhZ3HR4LB3TO5LQ5zjACjXLqit3f0KDE19XZunDj5p86ltATDP1LM+wr6ExlVTWX+QSQCBwi0rT4g5IXVzYsZWdHgGEUUUOgrdjwDGWBIU+8tQNfW8O59Mlt9l2vI8ckxXNEWsMUliZS0NcrneKTmIWqMjLURLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BY5PR13MB2934.namprd13.prod.outlook.com (2603:10b6:a03:187::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6; Mon, 1 Nov
 2021 18:28:18 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f544:a41:f814:7be9]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::f544:a41:f814:7be9%6]) with mapi id 15.20.4669.009; Mon, 1 Nov 2021
 18:28:18 +0000
From: <Tim.Bird@sony.com>
To: <tangmeng@uniontech.com>, <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH 2/2] dup/dup05: Convert to new API
Thread-Index: AQHXzs5v9UgJwG9CXUSLqi/lOhsO7avu/mCw
Date: Mon, 1 Nov 2021 18:28:18 +0000
Message-ID: <BYAPR13MB2503BCAEED46290D8DB265D2FD8A9@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211101031240.29791-1-tangmeng@uniontech.com>
 <20211101031240.29791-2-tangmeng@uniontech.com>
In-Reply-To: <20211101031240.29791-2-tangmeng@uniontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: uniontech.com; dkim=none (message not signed)
 header.d=none;uniontech.com; dmarc=none action=none header.from=sony.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 401ccb00-3bbf-4d5b-c769-08d99d6560ab
x-ms-traffictypediagnostic: BY5PR13MB2934:
x-microsoft-antispam-prvs: <BY5PR13MB2934E703F8C8B8364CA48FADFD8A9@BY5PR13MB2934.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JxsK0QC0AByM8YYKnJUD+vAlvyGCWKbV4lydm+BWrIUqMMhFwoXyQk+GX5UisotiMidC7losB3FaK/uHI6YalNhHh4ScLRrCi5Jt2BhBFL1fpZsgFRiR10q40BYSayfD6h052qbUFYHNfFPT0ksSXaCli0EX/qMm+vkZkr/dYlLPEMfs/kSaMPmsFtCZs8sAsNQ0oIMB8+FPk58tgeaTvIafKiZWSVu0FH4R32Nk86f5kYXte4t0nsIZp35PleAAdordJ1exOse0u25w8a58MuTXFlRhSOcp9IEfVl6iILXH0inK15jPf4HhezyLjNyYrkrwTAa/e4zdj1YFSEJ4yzOEeQP868mZyRjGf1YARQSFKhw9iVtDW54MGIRXxSffQvrTBG40U66Sw4G0T8XISGLYA9kS3KZBjX7xCU6ZfHgXVvvmM6cG5CeJ8jcaJn0om7l5WYLE78x1zM6R4/05kkHpB5RlLsg3BYXlRjdkdFNntTxDWpfYC5zSAfF5OlixrZj7KWOfHVi6HPVAKXkXV5JmRCJ8j60WzwWW2GfRvwnAv5m7ScfqMB/k+0XegR2BBXRDMX5sHMw3/Wybmc6uwIyXcAnNMMIILWiiFR8uXfegB/BvpqVdKfBG6gUz02gXDC/1feEzCXMvsWS5CcnWU7eCT4KXro/wrC4hQtjJaSA1Hub9xkB6nxi9fzXuihHsqosNWm8MutCIb2dB+e1Pdb2YyCGeBSa0rE3WcmXMcRC2jVC+VY6+VZpb5iXfauybBzDJeQ5AMBiFI+zcKZ9upqUOVyYc3rce2ljvXJjbediYJaROcZZuFUP/o8Ar+Hye
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(66556008)(186003)(5660300002)(66946007)(82960400001)(76116006)(122000001)(6506007)(64756008)(66446008)(2906002)(38100700002)(55016002)(8676002)(26005)(66476007)(8936002)(83380400001)(52536014)(86362001)(38070700005)(33656002)(7696005)(71200400001)(508600001)(316002)(110136005)(966005)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W8REwb91mqaWDNOWN8G4oOhdGF/US6hkfv1PVQJRQRvPEPqmHvPX+lDswcjM?=
 =?us-ascii?Q?jcjVoQ4tQep17JOfxYLO+DMWcjIahJfdnnqEcxmYIth2MRG37UZKzOR980VR?=
 =?us-ascii?Q?smPHuJqrpoeLREer23yYNkvh/uUFVlep6vURLLJjx/sz4h64P0ANE6qGRpa/?=
 =?us-ascii?Q?ISLNvy1e3mV5YYKpPp3R4bAN+oVKusvSyp+fTYgk23CgOwXt8rlxEx8eeZA1?=
 =?us-ascii?Q?E94H1Ch72VPCm9JszZv9qnNi2RkSW/Sl+AFzMSICCXNs69Fs9+svGv49ckqB?=
 =?us-ascii?Q?orBh4effZTP3ufoBqbMtWCZRCu41ddqMFbJCDyl+ToLduA55/IIgLGCXXUxG?=
 =?us-ascii?Q?SoyeFLBZ3d55kgqh8tmFtEXiCpEpixAgF0OubYjchBgASRwXn5IGjMICYWAR?=
 =?us-ascii?Q?OXl6vof2tpifYhD7dVHINjgyeoVi79W+xxAaYi3GZOvTNZi4RMp8nK1idE2Z?=
 =?us-ascii?Q?sbamMfNUpNpBspzonPvULO4cDK/NKRsXDYptwEhxktbJnZQUm3y5nV3Kof79?=
 =?us-ascii?Q?z72KYA8ShNGygbN3GuGe2P4T9lKfDz07bIB5jyXhdvAoWt0HgQMcvE6VYLtW?=
 =?us-ascii?Q?u9vKEqxwY121BuimLf8ahTZIl/7ARSCtJDvvE/y+957JinyakNEZr5PJgKTg?=
 =?us-ascii?Q?aaI8ljK2nhWMoconmtmv8GxBY6hwZIpbsD+6aazm3Rg71wYAtqpIRm4EssSi?=
 =?us-ascii?Q?dWYro+5SCsf2GjpImPe0w8bcnpdEjyHPgCYMH8yesqRudyrNtvjQQAycf08V?=
 =?us-ascii?Q?9ykpogII9ILyVFMqI7I3VUELc8qi0xQhJfDrnQg5du1oZV2m49LXts0oK4n6?=
 =?us-ascii?Q?WAfxv2g7XOewqXq+XcM9WTRMRFtBQ5swkFjarqWZm4FPsbEIKkxGTt+hxTNx?=
 =?us-ascii?Q?d8ytAlSn6ozW78fojSehzUzsKjsZuRCvVKe7YoJ741dnp+K2fV47m3IlGneV?=
 =?us-ascii?Q?HnGk2Z6zKbvHkCCezJJ27StR4qZ967xjmTYtZTGI4QlON/faBv+H0vZUC9g9?=
 =?us-ascii?Q?lft9yIXmmpKrAz+EDUQXEHrQFEAnoB8poiIjkeVzc0THnbmz8ZroaY4DN2M5?=
 =?us-ascii?Q?Spe+2AA2U+Cs2XfQ7ShwWwxGod0f0Aeu6MFjusMXYDQYh0Kdo94uXpplkCFL?=
 =?us-ascii?Q?2s+5bFVLzaY3WHw/5QQAFRFiRSPPRKzpZ3yjCsyz3HljfkoLI6FgkAwu0Hld?=
 =?us-ascii?Q?EGMmtHpYwLsk4jhTOHWwEXUfJmdW4GJ8v5C9IXh2u1feR8A+GGBRjGZbma+G?=
 =?us-ascii?Q?21Sq/VP94LbNNYYxUwcEDY4gY9FVPrQNfxW7U6NwTgYrZxLfKw7yF08b/PJr?=
 =?us-ascii?Q?oxCfYOWR5k9XB5K89V8DNdbmQX4rH8sbtaU5DWG7pWieI0x4IzVv76RKydTr?=
 =?us-ascii?Q?iXH5qszDZvpEoxtaJnt4QZIpsC2ldcnIQiGzRMa9uGCYj6/9q1gK8WGphzPf?=
 =?us-ascii?Q?aTZARTEejVP769OW55AiwaFDkpGw9f8G/q6337E1UZv8WFHbQoBD3KY8G/8D?=
 =?us-ascii?Q?2mvCfcXvVFpVhywaxOsedNAPIbtRa05EjJreHD6A6+8i+ZiNBPD3Cl+htc9K?=
 =?us-ascii?Q?cBFg3JvrA4E3pSG+/QOHzGKUi733pH5RV7XpWrJNzbRumz9O8eh+MwPTIrG4?=
 =?us-ascii?Q?arQz1X1raVjDUhepvVHB5p4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401ccb00-3bbf-4d5b-c769-08d99d6560ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 18:28:18.7454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjLlBJpMatCnoxXtPUVkA6MXmCrpR90D0CJ7Iz6ws1qyXV32MUn4mFSBBB4WRhSksHOSKJ3HA64Oe2Oa1N2d2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB2934
X-Proofpoint-GUID: q9Ab2BVp9eg7OFJqBfHSgpMdS92RNhBr
X-Proofpoint-ORIG-GUID: q9Ab2BVp9eg7OFJqBfHSgpMdS92RNhBr
X-Sony-Outbound-GUID: q9Ab2BVp9eg7OFJqBfHSgpMdS92RNhBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010099
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] dup/dup05: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of tangmeng
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  testcases/kernel/syscalls/dup/dup05.c | 181 ++++----------------------
>  1 file changed, 26 insertions(+), 155 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/dup/dup05.c b/testcases/kernel/syscalls/dup/dup05.c
> index fc0e1f1d4..f4f341962 100644
> --- a/testcases/kernel/syscalls/dup/dup05.c
> +++ b/testcases/kernel/syscalls/dup/dup05.c
> @@ -1,183 +1,54 @@
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

I don't see anyplace where the license for this file is retained.

Shouldn't there be an SPDX header or something somewhere in the file?
 -- Tim

> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
> + * 06/1994 AUTHOR: Richard Logan CO-PILOT: William Roske
>   */
> -/* $Id: dup05.c,v 1.6 2009/10/13 14:00:46 subrata_modak Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: dup05
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for dup(2) of a named pipe descriptor
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: Richard Logan
> - *
> - *    CO-PILOT		: William Roske
> - *
> - *    DATE STARTED	: 06/94
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - * 	1.) dup(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - * 	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    OUTPUT SPECIFICATIONS
> - *$
> - *    DURATION
> - * 	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - * 	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - * 	None
> - *
> - *    INTERCASE DEPENDENCIES
> - * 	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the dup(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	dup(2).
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> -
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -#include "test.h"
> -#include "safe_macros.h"
> 
> -void setup();
> -void cleanup();
> -
> -char *TCID = "dup05";
> -int TST_TOTAL = 1;
> +/*\
> + * [DESCRIPTION]
> + *
> + * Basic test for dup(2) of a named pipe descriptor
> + */
> +#include <stdio.h>
> +#include "tst_test.h"
> 
>  char Fname[255];
>  int fd;
> 
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> +	TEST(dup(fd));
> 
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		TEST(dup(fd));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "dup failed");
> -		} else {
> -			tst_resm(TPASS, "dup returned %ld",
> -				 TEST_RETURN);
> -
> -			SAFE_CLOSE(cleanup, TEST_RETURN);
> -		}
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "dup failed");
> +	} else {
> +		tst_res(TPASS, "dup returned %ld",
> +			 TST_RET);
> 
> +		SAFE_CLOSE(TST_RET);
>  	}
> -
> -	cleanup();
> -	tst_exit();
>  }
> 
>  void setup(void)
>  {
>  	fd = -1;
> 
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
>  	sprintf(Fname, "dupfile");
> -	SAFE_MKFIFO(cleanup, Fname, 0777);
> +	SAFE_MKFIFO(Fname, 0777);
>  	if ((fd = open(Fname, O_RDWR, 0700)) == -1)
> -		tst_brkm(TBROK, cleanup, "open failed");
> +		tst_brk(TBROK, "open failed");
>  }
> 
>  void cleanup(void)
>  {
>  	if (fd != -1)
>  		if (close(fd) == -1)
> -			tst_resm(TWARN | TERRNO, "close failed");
> -
> -	tst_rmdir();
> -
> +			tst_res(TWARN | TERRNO, "close failed");
>  }
> +
> +static struct tst_test test = {
> +        .test_all = run,
> +        .setup = setup,
> +        .cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
