Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BD6C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 06:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB8B3C0EA4
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 07:08:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF1B63C00C2
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:07:50 +0100 (CET)
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com
 [216.71.158.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0DC8A1000224
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 07:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1646892469; x=1678428469;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=d/3zi7lS1MDMUbEF2H7p+wLgnN4BSeD9KBj8nKDz9kg=;
 b=d6DNDuOK0k+490P5WzTYJAuXXkBPnZ0/kkLBlEGrtGf+pyRJHGzNQwu4
 560hWg4qLRfg5y5QfnXslnlLpKCmpuPmKha7KSTW0KJFkgiz5CuLAnnHt
 02KQATk4/xtkUdIPGcpTCroHDJGSG5V2zL0qaOLPz6zOKvPyKMMrQQYI6
 PSkq8q2t9dIqQtumNXkH9mSXYAyaH3JCh9cBgCgx1acnbBZOLsSxtL/25
 sWffSk74I/kjsD2NaaXZ91x/AHtHmp2DpPQgOXntx2/12YhEagpRQ9XNo
 j2yDLPdENBG2aS438z6jLKYFikjnnBOVUsAEjSBKfF0kk4muIp49ogDvS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="52517775"
X-IronPort-AV: E=Sophos;i="5.90,169,1643641200"; d="scan'208";a="52517775"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 15:07:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVEg4Ekn9UE1NUTlLLoj7gpmks6OV6ofIwGdxWtfbS5Zkb8R2VhMLFsL97QM0Sld24Tvsq/kaD1NTB7zu5smAPHO/wu3t+aQoUjdXFiQYk+eQHILZZFabeJ/SSoyikyQ6i3Nm+RGNGPnBsxLN0J7w5aK7dmH1FAj3B5AOauMNcJrHqMKYNrUUB4sGPX8+rZlaUS+XbVp+UVP4q1K6EMvqQfr4BgT8Pt04IFikcdPbBhqUL/Xeh5kjQz/p6Z5j0Bp8V8hkgIFaPQmEdhRiUN0KVwSG5H4MMG0uvZCL8gtxTbV8TkDNVu0tiHnsEE+aZPcUtOgLfb/JZuFkRW88z81pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/3zi7lS1MDMUbEF2H7p+wLgnN4BSeD9KBj8nKDz9kg=;
 b=E6HdGj9g3iOOreoN+cv+2Ih6BFtKYcWnDY6iv8k3zBlhTmhVZwsZSxx9OEVsDWYVxu2FIXLYifduaip3i12l1eHzgIB7Mxm3+6lKB6BT8HZhvMfRK2n3vTvoAt1X55xaUmKtetNhVvWw1c6H5goN/scvXNxylk1IJcsWzy1H6adAJrvsR31WrbJMkJScd5o32KTZql0fjuikL2jR/3WSQAUziqNijIMaQjJNRNI0Hy06pHVNFPaVYUELGxZOfrJvxpeZDBqPpHUpSgMOVGcWPlaqiEt5W4Ifou8938f5Qv1SKujBraDdLRKVLOuBnLZHSVHKf969KnqsW5a7wUYojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/3zi7lS1MDMUbEF2H7p+wLgnN4BSeD9KBj8nKDz9kg=;
 b=hdnFnMOroJDl8Xosgdr6lMpof7lXFvGRVrCSFYd/NqzltTwFMHkUUPu825e6GfcAJfjC4CSAPqEgNTJSaf3uJnYiMbqKJxnhi4ElZrbi7VUkxd0BEnrA6vI1SwFIjh18v/1JkVtMfiujuXq1MOn9PylmybwwXMc4MsIc9lO2RI8=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY2PR01MB2506.jpnprd01.prod.outlook.com (2603:1096:404:72::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 06:07:42 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 06:07:42 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Martin Doucha <mdoucha@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
Thread-Index: AQHYLtx4CjNbvmY4GEm3jKnRYeFwH6ytsXoAgADfuQCABsQqgIABAMMAgACTgYCAAUMwgA==
Date: Thu, 10 Mar 2022 06:07:42 +0000
Message-ID: <622995E1.7020208@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
 <3c946010-2f96-e8bb-e7ee-0d48d482d729@suse.cz> <62280B08.3010502@fujitsu.com>
 <c25c192d-9848-d7cd-d4a1-4f1b924f67e8@suse.cz>
In-Reply-To: <c25c192d-9848-d7cd-d4a1-4f1b924f67e8@suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f63cf8-b1c2-46ed-6412-08da025c49cf
x-ms-traffictypediagnostic: TY2PR01MB2506:EE_
x-microsoft-antispam-prvs: <TY2PR01MB250635E1B288E9432BEE180AFD0B9@TY2PR01MB2506.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +c87cwPsxQVfKh3K/2BcCAp0gRnpfJPl/jXzhJWySM8sGlwwAokXchnGEil2AMhN/3vZ1j4mGlthkCNHSv/bmillmw9q9HY5RRc+YWqjTrmbfs1EkHUlPxCEOrr93XhIlT5e9Ys2gm8UWuHh+uT354G99EhoXDL8LoYKa8EVCCDtYMnfanYY8kWJgWnXDb41NA7fFZkYQWHUBfa6LBhCUxpNgWYmRULwUmArVJTOfmVwvQZGYDMY6/Zl4mXLaVd9gOXBE3gCmjX7keuGNX3SXP+yIfqTzBhhW4OHYkSFinL4kO7JUDR06POBimQ35MZhLT9Ob4FFxj98pvlwvQfkHYANNqs05hYpd2teyODYF/F7BFk5nZv0cA5Aip/hUSTftwXpADr4IMIk0LZUFMglIpDmO8BSSm1y+vSsJjhH77m91ZCLTHjefXrV3CgXrS+9lVV5CAADg65JeHxXXg921WY6WMj9OYZo1NUt+NQ4vz8wvhiAiF6nCCv6JgNFynrwGbwXs+doMISTerXkRd+axGiV7IelRxC+q0yiejaFJNONEgzYNE+JfIu2IhVfeLmAXTURDaKsNnrAEiUT+csquX++bvbZ0sYfIuyziz4458NUnwPqe+/WeSbUavVdHSl4uW89S4DVU45ZJpKpgp276bY5oWghVAsJlhliEEB7jwH3TTTvvlLnxK6Tu2ECbgZA93RsuL0CVzn25wbiLbWeWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(4326008)(6512007)(66556008)(122000001)(2906002)(2616005)(6506007)(508600001)(33656002)(87266011)(5660300002)(86362001)(8936002)(38100700002)(66446008)(38070700005)(4744005)(83380400001)(36756003)(316002)(26005)(85182001)(82960400001)(71200400001)(186003)(54906003)(6916009)(8676002)(76116006)(66476007)(64756008)(66946007)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHZjSXFFMEpQaUFtOVNVdUhORktvbWs2ZzZzNVArQUpqSDBlUXZwZlFWQi9R?=
 =?utf-8?B?enM0MXdZL0R6TmZ1bldOUVZQVEFpVjVjRldvVlFuTm4rcDFpeGZtc2pkdSt1?=
 =?utf-8?B?NVBYSzBEMEIzT0RPSnRWYkNzYzhDZHVaLzdUSVZTeWR6cWpUMDgzbU9PWUN3?=
 =?utf-8?B?enJrREVOWXhVTjhoc0txSUtkNC82VDQ4Y01wMzlXbU03UUhxaGpUVzNYTW42?=
 =?utf-8?B?cUNnb1N5WWFIeVd2ZklBQW16dlMxSDZQeXA3TGU0OFJTR3JMSGxoR1FyemNq?=
 =?utf-8?B?NkRNejNhYTZkL3hjM05xY3JFYlVFYVJRQUxicW5oa1F4Wm5vZ3UrRGRVSWNH?=
 =?utf-8?B?eWdLcmlqVkc0TTVFVkNxcFZLM2xSazZydFdnZDlpQjhaZUtaa2lhalViUWI5?=
 =?utf-8?B?YXZLL3kwWndVak5jdE5lc2Qyc3BUVkhBWmdST1NTQXFJaTUvRndpK0xUL3Bt?=
 =?utf-8?B?dTViZ20rYmU4NDZCb1BDZGgzZmNzeHNickpPYmhhdkVnalU0RHJMZlhPdUJr?=
 =?utf-8?B?cnhhQzBOQVN4eXdDUGlmajNScjEwR0lQMnhKeTJSWG1rV1Z0a09SanhDdDJP?=
 =?utf-8?B?Z29aWFM3aXNjd0dMQ3dmcWZsTzRVNWhMVW96YVQrdWo1K3d3NjNQbkg1eWQ4?=
 =?utf-8?B?a0V6cWc4Z3ppdGFidEwwVTBSMUYrTkhPVEluRU9CWm5vbTNGN1U5WWVoMGdq?=
 =?utf-8?B?NGtBbnF1OHVGNTlTbDlQRGM5WXZCSWQ3bCtpcUgvY2ZyY2dYUlYyamY3SlpY?=
 =?utf-8?B?eTdGUmtSNUxvTUU5dFR4TmNmTkZ3Q2lNWWcrNjBVdVNNeW1OOGh4MkZ0Nk1a?=
 =?utf-8?B?M3RCOElReXJ4SE1mRDdoMFd6eTFBTGozUmh4UTFlaVBNcnlPUEZyczZMci91?=
 =?utf-8?B?VWtZNVJhM3VCYzcxWUI4d1NMNVRrZi84dGZIb0U5NklPOEpEU3Y2bDFteC9E?=
 =?utf-8?B?K0NvcXltY3liUWRueVFSVVkyVjR3TGFHWndvZ25UUkJOYXNOTjFNRkR2UEN5?=
 =?utf-8?B?ek1ZVXdKOWlSa0pFdEFTQWNqdTkrZ0hGazd3cWRKN200bUduN3B4Vlo3NWNw?=
 =?utf-8?B?OVhjempJNDVLbDhRc21Cb2dDMXdpYUdsaVlvQ0NzT3lJQ2E2V0t5LzMvT2Fn?=
 =?utf-8?B?U2Y2OGl6Z2cyZ3doelI4ZnVES3R1bGF6YUQvQ3BiSUpVNHRDb2puT1VnaTJp?=
 =?utf-8?B?c21rVjlhUUMydUMwZnF2UUswM0ErTE1TMWdxcHFheTRxTXZzYkJKSkwrSzEw?=
 =?utf-8?B?TFArRWFRWVVZYm91aDRCcktXVFNFaUVReU9oM3BHREFLcy9KSlRNeTRjR2R3?=
 =?utf-8?B?dUVkOFlsWGZnOEJXTmdwdDFuRXVuOUZsdWhINURpRURDL0J0NkttbHlINy9a?=
 =?utf-8?B?VXBRUncxMTVYdTk1QmtqVGpHeElsSllKaml6ZS9yUHlvelBIRDRLdExSelZs?=
 =?utf-8?B?bEI2dEp5c00zM2pBa052d2RVQ3VTOVRtdm9ZOFNrTGIwZWJYKzVsTFVyVVdr?=
 =?utf-8?B?c0cyL1RYbXJRenZlN3NSajA5c3BySWNxeEt3RXFzYmUxNEE5TjRST0dScENZ?=
 =?utf-8?B?NlA0dE92eGI1UEMyWmZaUy9VVVYvNmNFSlZJbkczKzJadGpKRGhoZGFkWGZq?=
 =?utf-8?B?ZGloZ1oyQ1pzOW1PbmVRQXg0TmZoMzZqRU1meXR4d3FreXBlVFhTSlFwN1Ba?=
 =?utf-8?B?YVNaRTFHVG1GV1hyOTVZeXFRdllVUjdFM2pYOW82RzdMWGZUWnRpYXZQRFdD?=
 =?utf-8?B?dXBoTm1WTWpTQk5xbkpzbVBlbCtrZWpDQnVQK05xVXhmTmVrNFlSMmF3Mkly?=
 =?utf-8?B?K3YrVjNBWE9vZ2NwZFkxRTVOTnlzSFBnWGtQektqTmhaNmZzMUVPQzZOMGNl?=
 =?utf-8?B?bmI0czZvUnpkSjNZeE5wSFFoeXZCZXZiRlhFaEZtdzEwN3VZSlo1Tm5ZTW55?=
 =?utf-8?B?a3BBaStDOWhuSGVkUEVJbWthbHc2ZEJ5UU9wdXhGWFZaQzY0YUxaSXJTdWE5?=
 =?utf-8?B?RENVeWk3THF4UjZVMnRqK3VKSHBuV1d0ZXd2dTJjTEJZNEdDS3ZsVDlqVDNZ?=
 =?utf-8?B?UjVzNC9SR3RTQXhHMGUvZzRyRzdQSmwyNzhSaHNQSVZPSDJoZWVZUkQyelJx?=
 =?utf-8?B?Rnh4bXJ5dUVxOURoakJjeUdsck42azE2S05CZWpJWG9qVUpJbEVBQlE2cHli?=
 =?utf-8?B?S2sxUXcvQk82T2hxVUx5UGliQjdXM2VFRjVwMFU4NTZiQnFZTnh5d3NSazNT?=
 =?utf-8?Q?uV+geRQC3Q7npvQjlU7zyXwiYAlKD831YiW/X6Zt0A=3D?=
Content-ID: <8F3A3440F7B7BD40A171C473D049E1D8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f63cf8-b1c2-46ed-6412-08da025c49cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 06:07:42.3827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtqdO3OD6Pnk0ZO5qT28hN0o+ebhJbL2X9wn+UTWDpwVi6GjK+82O2ZkexlwS9WuWG5+pM1/zk9pN2C7FbbHgMxWeH9a6t8GuFyht7qFwz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2506
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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

Hi Martin
> On 09. 03. 22 3:03, xuyang2018.jy@fujitsu.com wrote:
>> Hi Martin
>>> The timeout is controlled by req.tp_retire_blk_tov and the value is in
>>> milliseconds. So usleep(req.tp_retire_blk_tov * 3000) should be enough.
>> I tested this on my vm, it still can't ensure hit the old crash before
>> print PASS log.
>
> That is probably expected. You'll need make a taint check after the
> usleep() to detect failure. See setsockopt06 which tests for similar
> use-after-free in socket timer.

I add a sleep ie setsockopt06, but it doesn't detect the kernel tainted 
state in time and doesn't report "Kernel is vulnerable".

Best Regards
Yang Xu
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
