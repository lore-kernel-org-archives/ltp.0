Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CC7C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:40:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905023CD4CD
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:40:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 070B93C88E3
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:39:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6AAF91400E43
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:39:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1411/MNoxPevymFIv79w2NpjvJlrY+JZXlY9xKB5eUvwhgvfVcG8OtTmF9Yc55Z9Cbw5SB3wxbHSEJEZw9WXSGSoy+fI4tju9f9jz5hq/7D/pCzArDA3ikL/z0W+TAQ3/5BpXwK7PFFGZ00JFKlcOl31qHb/B/EU92XCvg51+ldzKRZ0sByl+YXR39AFkEHLBQHs/l8rg5cuBQqWbu2rbYB2efDrpanqxzrkroL9f2IjEDrm8WFGn4nkeL5UrKlnC/0DmqvPhiHeuW6bxsn92KU4MXm04vJ4VhldEkUPF7oFOiIkLuRSi9VD99pt2yB7HmEayz60ckvFQsoa6YoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gliQ2rwmXZbODjTEKOG3A2DvnoPyon0upXMZqGDUdtQ=;
 b=noDOT+yopefT1njqxAJZd7GIYNPihEtRoP579AcKH+tTpwZViv3WDgeERv6YozMyrAgkjWPgID803oSgzEeOogu85GAF10XwAQquXPKwmequQPp03q7uDbofWR54a+atZzfwD6UfE3/W2l2DUIdOnG7bYzx1EG3UUOIpm98ziTVX901Row3rRAtdJdsXmVQ7j/J2A0AIOWOTNhuoiRuS5xns6kFb130/ybYct8GyqactONWhGFRMkJ91d1uuG+MAAaTtGm12mAxupRJkTjrgYS0P81elj6/nJa9fbk/joZTKgb5mE2j7/TsxxrNmzJEwCz2CdCqdbV/DLQzUhtwIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gliQ2rwmXZbODjTEKOG3A2DvnoPyon0upXMZqGDUdtQ=;
 b=Tb67wIIFOO17J/0Sp7tx2g4lPqj1Xomh0j3gMkYnuvyP7sJIxT4iRwSSqkqs+1K9fnKodysI16lzE23GHlX7WT3QZRtoIV9CbN3sLp0nmXd5l/8331In45dWrdXt0fHcgdS0+8N3TQo2XlGmZrwmMx9/F/PP+BuN84ljvKeW9Rdnmh1KfAciHokQXPW/Y/oUlnmeikYswzhM9TvlFYpbUVDSquqD95BeMtMYT2/uC3a8t0DiwV8MLP+wBIX60LUorJextfEL4FH4kb+rv8jlLj2g7i62bddtN1TKwv3Okk8QfxsVyqkWELmWvxembNC1rmZ9BQFxrRKY5AbmVvEEpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:39:52 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 08:39:52 +0000
Date: Wed, 3 Jan 2024 03:39:45 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZUdUXAXNCp5HfQC@wegao>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik>
Content-Disposition: inline
In-Reply-To: <20231227132144.GA740736@pevik>
X-ClientProxiedBy: SGAP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::34)
 To DB9PR04MB8204.eurprd04.prod.outlook.com
 (2603:10a6:10:240::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DBBPR04MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5755c081-e3b6-4d97-e0a3-08dc0c378dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lkq6JwTTJnl/OVDj3/PkPk1Oze/9GEamjX9t2iSmRqH0lyZxZJgstxNYolfrOnXbv4cO+uYE4Ck6KXP/yx412H2/ap9yPgv72LvvwCDsWK7tdMv+X7Jzc9MhUsRr6DYJ3ZOIb3D0BSctWff+hARWYvH/CEM6mW7dUp6njpOEHjHGyrtDBIoeYdIYO86ptUtq5PApe/rr7tgfS+m9vb8clyr0yORgKu6k/eqp94gcM5W0/lvjUs++0V5LYEFMo2x9X27kI8aGBL7PFKh7G2H/kxxcf2RPgztNOKDdSnrLOAzmkuyMQ5rbeM0g31hK+Dq4wztG7AVSyi37NOg+pyh+CvUMWsmBwwActXyI5/xHJOK5IMksPa7o8ppfRUKh+Rm0wJqqv7wgZOmBOmt9Pdqc1rM//mE81kfRjeQw3niPQ0gmKZ7wajcQ+N8Lhx48EGOKvxiIxEQZBPa6k+SDvDSLTvOxMd5cdcmyGGPBfvYLitJodELp+fohKEfx8bkERZM/21UTboQaQzNgk4sP3sKJ9dqTszcXGToYfIvnGBAoMvjPhuwZlVqLS2HgBzfx74ryNWNq8PRe8gLnGUpT6lbYzlxEWy2BvuB1jDOSDcnwDDgVun40SX/OdjQFQIrulyi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(41300700001)(26005)(33716001)(38100700002)(6666004)(66556008)(66476007)(66946007)(6916009)(2906002)(5660300002)(6486002)(478600001)(86362001)(316002)(8936002)(8676002)(6512007)(6506007)(9686003)(4326008)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h9xvnZqTXhCJkzjsVmsQ3mO6c8rWHvuRM/tlGIjFyA+KadRVljJObFGV7cap?=
 =?us-ascii?Q?/9JriACa6CSpyvftHkVPMTmh2JLgptbuaXckpgoFTELzR2RxCzm1yA2w2hB7?=
 =?us-ascii?Q?pG+sd9CiCmNYpbY54C3Yv+WlkUqnk8E9xEmK/WRLRrarKahP3u1AgqT5d6Ce?=
 =?us-ascii?Q?JndO/hXBs8y0AX7voD/WEJPXHNPUz7iZJPTJKGZVfn43+Embo3dMJKQ8rIzj?=
 =?us-ascii?Q?30ckTH7tK66XodrUK9qZyX6HJthKLjl3GqaMZRr+IDkJImaXqwPF8vuapn1l?=
 =?us-ascii?Q?Ymefowkma8KKh77pbu2HOFw+dMTN1t/wACrzDH0CYgCVFD21YVwhTbm5ko2n?=
 =?us-ascii?Q?UlgcUho82HY8pKYAy3q9kuRDEhm017h7dr3bWCwzUscdqhYdhzJ9EeVeRWSF?=
 =?us-ascii?Q?tmqnG7ysdM/9o/k8qqq6bwk38Ct6xn0Cc1Z25QBNKb6OJeRMuO/a4rARDGtQ?=
 =?us-ascii?Q?d8GEcYMqijIEFV8HWEbuG5+3og5ijqvxZooQ54ACG8p6KIcDhTEmlhUNNCg+?=
 =?us-ascii?Q?f66th+Nh/EpXq4POOZn3RYHuFUpWTnaoRV7wRQQ4i5BoKChgqwYmoaiZuwTx?=
 =?us-ascii?Q?MMYhpIoEc+IOOyKYSo2EdeBgEpIxNRBONYnkmWPO6XMx7XFh40cytRrpONZ7?=
 =?us-ascii?Q?wpT8zKQMV1oeMzhxImOnTlMcSRGQo0fXJJndZ6VVwNRSKOs4YhWUhtD0UB5E?=
 =?us-ascii?Q?Ww1g6BAdFAV0yQLIw0ZNXISiqp02DSxViIIcplJMnf672rXLs/Fl9/dj6TkQ?=
 =?us-ascii?Q?/40Nt2wO7BSLk6hLXN4CqX6q2jeukzgbRD44fjumlGts5BkP/CEecH+QDv1f?=
 =?us-ascii?Q?FqGEBiMLeSDXbN2838C7unRA2oDgMTtsBLwltCDVwipM952QV6YPkbR/L6oj?=
 =?us-ascii?Q?Jld40i04l5XTl5HN8zOTX9BdNea35mY15hQAeWIL7dHO0PEfSHfV+03P4CRB?=
 =?us-ascii?Q?nSyzd7B0ycDEmMb4kw5vKA+XC072u9XhUwYGPlysLndsKJC73S8oPuxkXm/o?=
 =?us-ascii?Q?vttdL8DqXe7mNsqwnu29tFMW11aLCakw1AJSbmOYTXMFY5XWnsAbBvQI8AKJ?=
 =?us-ascii?Q?b7FZrUyBinqNrgyAZKCZUue/aNfUYRMpj9jY+ltJ8XCkVXmSS3Vau8zlVGr5?=
 =?us-ascii?Q?/dhexFin5xaCFOFCWt8F0x4w7tFbfVQJX9iiaLHovJfEHj+L14F9O09JeURt?=
 =?us-ascii?Q?CpNTX8BzxChVpmFl5I9nMCmpoTFq40WJsVAiNEsQ08e0Afi4F4B+XKkQnPN2?=
 =?us-ascii?Q?mgIBixMGSDz04OKPgOjT4v2i05glSHUr681nNp0Wi93HvCTEvQLrd1y6jP3f?=
 =?us-ascii?Q?Mpm3w/6iJI8aBaCHU+tQfxLWq17Sek1r61D8cjuErOaDKskr6+ruvleHR0rx?=
 =?us-ascii?Q?s1iAUAJqJIuNOcEySsJPycVz9hnHH/OXeJe/Clwdx2gG+vNdRc1XhvaeVm4L?=
 =?us-ascii?Q?uctZ/L6zFNuw0FMhqbh4UE1SRSB9Thh4QiHJYk6P4b4ijznGTHfJvt3JTBRg?=
 =?us-ascii?Q?cWsr4TUsRfevLtju8RnY9kam8IGMUVKVQJfsJ7SsZPqLzSsROBs9tZzcxMrR?=
 =?us-ascii?Q?RRPqOdeuJ0XLu18sEC8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5755c081-e3b6-4d97-e0a3-08dc0c378dcd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8204.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 08:39:52.7344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sv3wINy+ZPqiB58vd+ItmyB9W7hPwqZMZYpiLYnt+i5ZuNW4ivFZ1tm6G3U5nDXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Dec 27, 2023 at 02:21:44PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > +{
> > +	char *res;
> > +
> > +	errno = 0;
> > +	res = getcwd(buf, size);
> Why so complicated code? Why not just use TST_EXP_FAIL2() as you do in
> tst_getcwd()? That would be way fewer lines of code. There is no problem to use
> TST_EXP_FAIL2() with libc syscall wrappers.
Current TST_EXP_FAIL2 can not handle getcwd (will return NULL). I remember in another
email thread you mention maybe we need TST_EXP_FAIL_PTR.
> 
> > +	TST_ERR = errno;
> > +	if (res) {
> > +		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
> > +		return;
> > +	}
> > +
> > +	if (TST_ERR != exp_err) {
> > +		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> > +				tst_strerrno(exp_err));
> > +		return;
> > +	}
> > +
> > +	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> > +}
> > +
> > diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> > index 218bf4ef2..6decb961f 100644
> > --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> > +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> > @@ -13,18 +13,26 @@
> >   * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
> >   *
> >   * Expected Result:
> > + * linux syscall
> Well, I told you several times, that list requires separating by blank line
> otherwise it breaks formatting. Could you please add it and check generated
> docparse before sending a patch:
> cd metadata && make && chromium ../docparse/*.html
> We should check for it in metaparse.c or in testinfo.pl.
The original code seems can not correctly handled by docparse since format is wrong,
so acutally no any description item will appear in metadata file, same issue for 
getcwd02/03/04. I will update to correct format in getcwd01 next patch.
> >   * 1) getcwd(2) should return NULL and set errno to EFAULT.
> >   * 2) getcwd(2) should return NULL and set errno to EFAULT.
> >   * 3) getcwd(2) should return NULL and set errno to ERANGE.
> >   * 4) getcwd(2) should return NULL and set errno to ERANGE.
> >   * 5) getcwd(2) should return NULL and set errno to ERANGE.
> > + *
> > + * glibc
> FYI #ifdef __GLIBC__ means glibc and uclibc{,-ng}.
> Also, again missing blank line before list.
> > + * 1) getcwd(2) should return NULL and set errno to EFAULT.
> > + * 2) getcwd(2) should return NULL and set errno to ENOMEM.
> > + * 3) getcwd(2) should return NULL and set errno to EINVAL.
> > + * 4) getcwd(2) should return NULL and set errno to ERANGE.
> > + * 5) getcwd(2) should return NULL and set errno to ERANGE.
> >   */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
