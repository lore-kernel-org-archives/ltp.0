Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAACEB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:26:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D787F3CC4C7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:26:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AEA43CA861
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:17:00 +0200 (CEST)
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5BD1200392
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 11:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1687252617; x=1718788617;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZBnMOAkM87NSJ79eYAzN4XmufinNZf/2/RWB0dvBGNQ=;
 b=loKOapiP0pV5AVendc0qmktKnyDbIDTrtwwUFc+KaeH4HxP23aQDJJkF
 Emo/5O5eFjniKJDESd+z6NROY41LX1p0+r/+Y/M3qxjyTWsh+8Clgi1Sv
 VWC3b/MSvUOi8prJq/TWKGFd6oW+TJluvZqMNzhu0rbISaPWovI5WWxSG
 TbEs/8qY9SfOfd0bD/yXqDFNu2IBbdwZDfFcAieQQ32ckV/0gCwHNYQOM
 Nd9NEqbbsoUoc26WcPVlTuBDEmV5J4o+B+g/GsfZG9cvTm+6DYASFao3P
 pOd/SYwPpP1a6gBs8kt8rrqhWEMkc2GUx8ENsKc+u4oExLzruRQS5Q9E2 Q==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; d="scan'208";a="240740269"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 17:16:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juh19c56jQn44no69SnXe+s8u2C+vnMn7RrSYoBUCAqqROUqnoCnBPVHaYmexNpfS+MJYl5unqjoEHv3boZH+uIKOOtb9m1hK16StyaTQTCSc8Ic/0V8SwwPNF7CUqFgvN/BYYIuPWzYxbcf6Pk69sRj9tibe8TCUONj5U8+WBTE+sjyRXK0JxBOpLv9sUt6tISrf5Gx/ka0oHwOwAamTBk2OhKqJ6YFO4sqpYJlqjU3qFwiqMEdaZX9kPLmZy7wlB3CZD4vDPlY87Z4jvs5v3O+A7ufKZky7pZVKDUEhUaqmuW7vGzohZm9gBdfBWMURSUBjECc4UV2vVb6O/U/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBnMOAkM87NSJ79eYAzN4XmufinNZf/2/RWB0dvBGNQ=;
 b=GkCxwyNrrVt2vvDHMSyLMxzg+5b0YO6O0V7XvqC3w5hTPZLkc7i5Au8ndRtJnklCObPUYsoGhfS4/Wd8DEY6gpe/vR9Itj5F/svuCBZQfz/V5LV/BwX1gWaIGU+VxHArTkL9AFFNNMxOez1WNJ3IQKZUwhZD4CvtYRAT2DORhYql8ROHJPbMnti16fypBYLmLjKYpGM8h8STi/HCb8yZ3MSmbAI5Lk5d5F03NjSF/dX2BOUK356leaOLUW+kp/LmW9wQ/XzzbLXe2KMmAy9FMDN5ZJiZkKYsPJPfMyNiom2hBqAgBjvziJkj9Pr0PAj/6SkAt8gaLOMYuensPE2LVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBnMOAkM87NSJ79eYAzN4XmufinNZf/2/RWB0dvBGNQ=;
 b=evGgyfU//6AfliQVvB5IyYb05rV/KvOPUO7PJZmkuAUXsHgtdptyRNnCh9j9y4V/VgbkI53ovbBAaDBbqaYYC25bIKVbEfTpP87l6xrGonH2UN5iovYLXm9+P3K753flk4ibhlZm+Dojlr5X1O2hFg/c6QE7NkKS8l96TqsvOyQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7662.namprd04.prod.outlook.com (2603:10b6:a03:325::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:16:49 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:16:48 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 0/2] Improve ioprio tests
Thread-Index: AQHZo1d78K9JAcUirE+IhralZe8ql6+TaTOA
Date: Tue, 20 Jun 2023 09:16:48 +0000
Message-ID: <ZJFugRCzFlZYL934@x1-carbon>
References: <20230605044131.798383-1-dlemoal@kernel.org>
 <20230620091316.GB275381@pevik>
In-Reply-To: <20230620091316.GB275381@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7662:EE_
x-ms-office365-filtering-correlation-id: a1bebcb0-6d11-4e77-34dd-08db716f13a6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhhTljLKLOCn0vUZqIyVJczHC1RmAxxSxKROkDXN1QT8/d/UfJTFDezY8ptpfbszz5t5WweydLscrEXDSw1tV6R6HKfokgyUt9HB9QONylqsEIu+PosZUdD1orU3NaEHG/KEtrdMQVN09Fc+XmJJjRAFFt6hDYe/BrL72pq4kZfZuynay083PwicYdlq8J+CODyU41Bn7jZNtUGvWvFcYzY72L5EPoUsR+iEo5nfQG3v4zIseBLIeu00SSWaYalgzk7KAwmKzmCs3KMqou3LTOh/pCExdhsciis9ftskNI1MdcQGWrdb0ty+l90yiF85Vry2U7u7S6z19aePwfpjPW+n4ZGuGC7Tss5MO+auiLgLauJ+lvb0cgNOKSqVJvzSrne1kDura9ferqtU+5cMiJW0KhLdtkM4v1BGa6peLjujYVr7Z+vWxSW+CEp9/RuJrQ9549+2t735GzprqduMYiaXV6AJh9WyOLc1lVT9Ig8bA75AofIZAAp0CnTexQYQQ6+kd9EQFn3F+M/e8h2ybu+VGQLeczLVhajnVl0M/NEq4Xb7gzTvEekDJh2Pj1Dngn1ajBi1mLDkI6LS4MrbiO3AWb7ELTxsjGLjh6pJGo5IBcN3JwbWQ0BjWjk1eA/IWuoyjwNjN/0avDGYti0++ExnbC1knY3Dpmj4d2YhIas=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(186003)(478600001)(6512007)(26005)(9686003)(6506007)(86362001)(71200400001)(316002)(82960400001)(54906003)(6916009)(38100700002)(4326008)(83380400001)(966005)(6486002)(122000001)(91956017)(66946007)(76116006)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(2906002)(5660300002)(41300700001)(33716001)(38070700005)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tIQbs5DOkNv6V2lCwnQ8FULESHnvXPNmODUDpzjU4qvP4jUw/Xz7QZE2/DL9?=
 =?us-ascii?Q?ioLQndgFrVT9pMS+thWYrMzaPsDGVj9o6eWyc/f8qdlG0WohR7FgpeapiXRW?=
 =?us-ascii?Q?9xhw0PDhQaiP1zYaZGWQ4Yh1cOrDYKQaWXbsLT56Ui01baejZh5TB3TmyHC5?=
 =?us-ascii?Q?vxWr0U0f9WYXwo3IcfeQJ28z2WiiIfl4nfWuvRqAQRAsCvoMYhLqRP+pKEGW?=
 =?us-ascii?Q?bUOHLTHy65UW8mOJXa/biQxSGbwlHv5TQE2ngc1gi1gbM5odA7ZAQlwzND6O?=
 =?us-ascii?Q?k/CyVzr3JbChYODUqyBpztDikqJ84LiSqzwC1aEk92ozETAK6mASFmJnsyA6?=
 =?us-ascii?Q?PzPPqJZ+wW94nimuiN9DEqjxg/8YyvTY8k+xv1THbtAr9U5kNDuzgiC0s4f1?=
 =?us-ascii?Q?VLgQXMB52wni79L7yiWvzvYYZ1VtZREcCdf3vdz01t/ximv5/TqBcl4vVeGr?=
 =?us-ascii?Q?a/q4VQ3HbGLHorlF4BeWNea8eM44V46SL1hNHvdyxcSvymZ2IFbn7dSO5e9b?=
 =?us-ascii?Q?4XOkM7rFadT9V801le+Jl4dgz4MS7uY/V8Ad0jmwNMLgiao8tdZhMudt1tsT?=
 =?us-ascii?Q?sXEv1YcRh7F7+k+EGrzQw4vBnOAkfDeEeOQ4QDsUg/4wnKs3cn5/+q7YKNe8?=
 =?us-ascii?Q?pf/hSv+jWeMDyE6HqJNWwGvYzGNH1soQORRyYWKEWLU0tsmpEAevZK7BeohC?=
 =?us-ascii?Q?L3v8537yXd8bV/CEcwV2KQQM6HiUYR06mg1MEJQqsUXeHmv8qEBys2JVFwPZ?=
 =?us-ascii?Q?2WOVDpJvA5ZxL5UbckljQGJOoIy4me0GmsMdiPMAYmzEPN3wID8eLbcun+Ek?=
 =?us-ascii?Q?ylHpFOf4aXA24/QUMxwYH72WpaQRzyS4K+GU87NwRIk2U0tS1YpCn/gCCu3z?=
 =?us-ascii?Q?I9Y+ndd4KoYU/WtE+mIAxBEkU+HLhazmmRlrBLUues9aTsI5qskYenP5lvrp?=
 =?us-ascii?Q?qZWCxmwU+ONcmNon9kIziiBQEwBVZRKBo+nRzhSaN99VrdGB7L2GWaUwJBNJ?=
 =?us-ascii?Q?t988+RGme3xbJEyfkH2e6+PPyIlFzgRRov+lPXQbrqLTqlzIjqbmFKbF15ef?=
 =?us-ascii?Q?feOfLmCLHsmx6OqX+2XdeEdMaqGhzoBBEYf9bgzpCTF2SBxJaDxx3c4LCNdD?=
 =?us-ascii?Q?RWHLhX9dsvjHgzU+lE68m4wH+4rFUchkeX7sRksolfost0RaMVzIS2x14l+Z?=
 =?us-ascii?Q?4SI5RnqX1v6M52tfZuAchRyiSUjqkHye3AIIZ1oY4MxLzH6rBz+A+Tk3oAFI?=
 =?us-ascii?Q?TMHMKHXXVc+5ath2NjXKNMPTFth5k9Uaj1aEaA+MhEbK5YoQPRdhObKk7oW6?=
 =?us-ascii?Q?sRbgUg84ap/639GBWL2T2EJwg9i5kLCj97UU16N8XH7fBc4FqYseajkgeT3m?=
 =?us-ascii?Q?Sm6V58FlmTxeJvqRmB7EzrrYi0sdRCO0Lg6Hlz54R7j8mAISzkvkHTlGzfCx?=
 =?us-ascii?Q?p3C6fa781VHnYro57qKhyEPiw/MsT91Itikyy/BnaW8sFJGbA2omsjQNX1yo?=
 =?us-ascii?Q?l/sDVgKJCMI4DeSA30wpqVml79zwdppj6j9eWLkv3AWQIGa3ufMJ6V92Q712?=
 =?us-ascii?Q?Xhe8FoGCbBVHKSIHsL9zuXLyrlSykXLtBRqPbSQhAWdQYI3C+N38b4cN7RNB?=
 =?us-ascii?Q?+A=3D=3D?=
Content-ID: <64A3F36F2B4D3D439460D2956E81AF45@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p+0h8JAZdd77sPNRIRnyGWoP3o+jo60tSF3lLQQZ1gIZnYsj+2LwRWGHTstQ2xeW5e5OYMIx0aax92Gi1TLrhvIfpkhWLDKxWM74hn/fb7SAH7Mk0ExKqRDZpysC+5Beui7Zx4dItieW8AU8V0U1TcQsV+caBLhOEuqwjufz4e5tn41d0h233c6gU7ih11uVqStkGQgA+khZnTtVUc8wzWSbUS0YkI/cNJ7dUrD9+Tow0wFJJJRiza6tdS5uewt7xCpCldmYppGsrKiMsFp0VUIZptRs6ZjFpDfJ4c8ffAwIXT/TqLSauiDFBIaCkKv1LKSWMnBuvpF2f0lm8t49NcNNtt+heyk+XgpZnuRech+vzw+6Uon+SqOCm9rUuYFT4Vr8EfYoUD0ntyWJnXVQ7OL4LWJisZjR86+5JfDFVVKw1zvLliNx/uhtzpwdMHTGYQM+P4dHqg3DtmtC8BHp1sQiryGpbqqOxUE0NUff5dAbkgCuxtzkA24pi552gC888NUhsaT8JhQjU3ARPu5Jri6YZbdZhzG1JSo8IHiHveCiCmu56Lcmlw6jClP1u39KwebwhKp9m6rMbzJLMLA67q5RVwdK3F8fbgp7o1EJQTr1xZsfWN4tF8C0cV2aWHWeS0IUVTOryHJXKqzXCJM6MRoM4gPCoVq4xENfYNhnA2V8rVPu2/kRWW3paXhhtUKhWScAXXlfoiK1gSNhSaJN6mqki5OuSfY79LuXCZFbfxQtCJI8tzRv1X7XpfX/aqBSMf6hKygEVJpWzecgNeDL3nzEdkr33DZH4awZgqTdw8q905S5083UYTsgCPS0eXUT+cqXZ2ZqS4oYJ4mfcUxvtoG5oMGt2mWRwSVhWACXdtA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bebcb0-6d11-4e77-34dd-08db716f13a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:16:48.7554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OK+oxeQcNVuEkVIEVrx7E0tWnxcRhuu3bKPcNiYjChtK1S5yUdyLTU4lwhl0COEqhQ1XcaS5dCwTvUlU1WRdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7662
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 20 Jun 2023 12:26:29 +0200
Subject: Re: [LTP] [PATCH 0/2] Improve ioprio tests
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
From: Niklas Cassel via ltp <ltp@lists.linux.it>
Reply-To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 20, 2023 at 11:13:16AM +0200, Petr Vorel wrote:
> Hi Damien,
> 
> > The ioprio syscall tests rely on ltp internal definitions of the
> > IOPRIO_XXX() macro defining priority classes and levels. With changes
> > to the ioprio API to support command duration limits, these internal
> > definitions are incomplete, causing test case ioprio_set03 to fail.
> 
> > Avoid this issue by having the iprio tests use the kernel header file
> > definitions if that header exists. This enables additional checks in
> > the header file [1] which restores the expected results with test
> > ioprio_set03.
> 
> > [1] https://lore.kernel.org/linux-block/20230530061307.525644-1-dlemoal@kernel.org/
> 
> > Note: a review of this patch on the kernel block mailing list would be
> > very appreciated.
> 
> I haven't found this patchset on https://lore.kernel.org/linux-block/,
> did you send it there?

Hello Petr,

The patch series for LTP can be found here:
https://lore.kernel.org/ltp/20230608005315.3703446-1-dlemoal@kernel.org/T/#t

I just checked LTP master, and it hasn't been applied by the
LTP maintainers yet.


Kind regards,
Niklas

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
