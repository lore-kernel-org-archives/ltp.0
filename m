Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80C0C433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 06:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26C673CAE60
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 08:32:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D933C9600
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:32:38 +0200 (CEST)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A240600756
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 08:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1665383558; x=1696919558;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ySiyu3DEml0wRnSiRnQjqTWicOyfW0DK3q7Qv0vJBDk=;
 b=TlHeeGq8EuIrzpFrjQRmznGSL9GRzzGdSCbI4z7OcmfJD2hJR7KanoRF
 tumZ3cZR/BrFWlNXhXnqGKPkT1xd7yFoE9W8ewsOWnkrlAOdqp8g8T85X
 8r32AeQcL3Rw2dpA3NrYNAO5Sji6heW/ohUNqRiE1NL/VSQKI1cbgpbNL
 wQX/RkcaB84yLDDFnnVxXQC2D9mbrPKC1a+u/2BtxkhIPDK2nU+hnyEXC
 3XNTJnYdIRtThime5GjzDmRGIuhbU4wcTKdGisQzdK9TtBO4sHG0GoHxG
 knjqXCKr05CNne0umeapWS9LHrlMgy/YCh8Ti9AnRwlSlAUXO6MQVLlju A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="67038104"
X-IronPort-AV: E=Sophos;i="5.95,173,1661785200"; d="scan'208";a="67038104"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 15:32:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWWMgdrTpKIdrz2becacIgsWqQc2oUDDYksO5KOxBIYg3hD3yD5cBcOK2VKUo3IGAlKHaDh5b7G1PPHCQYXh4zIayy59AkUNal7G94m+yOEMCQTFxZibfiJm9qV/vhhlCUBm5eY2EkU0XIU7MN3AW8gxI4xb9HHWh4cUF0eyryVYSI6eObPMRKwvmg//XUi4QQWhr6l0gneEcL+OP7dM1SUorhu34N2CvIKMCH8C06shkGFGxYu8Mzu3d0hKso5CRizzPAWO3U0LLwmnSm8tLhrJ5V8gX2NIfh/elxIRgF5kKIbTfqxN6mLxbDSnwGeRpkXoJ/yvudK/QmmZVPcQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySiyu3DEml0wRnSiRnQjqTWicOyfW0DK3q7Qv0vJBDk=;
 b=RQAfnQwfy7pC0fooCBWrWuzle7MSO6ZwAc9vSEiqHK6pz3nbJglH0sOPOSNhXv0LOK4mgSa4hqdFMYWroAexMgUIk5OTxr06d+EbtZBOoJlnjsE6PRG8BN52vjWTm6rgklFQxGwozZR55SAGTAxzm+udckGMr+GLHFMZDDMFqxxPFhs5wOkpMxTYGsMYt164XBvPj1H6xUF4y8v87GtiQN55Twb5ux3hfXMV/sM8LoxFHvhh86FcxCxIPNekAMHbuBXgnoiXuqPvuZPEZiFUVEn9Qk70/OmjKFxoJUUbdrE6MlKatcpZ6feWPhZ46EtdSLz2QN3KxGxnGrcDpZGH+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB5734.jpnprd01.prod.outlook.com (2603:1096:604:c1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 06:32:32 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::c4fe:de8c:66e8:5c93%6]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 06:32:31 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Christian Brauner <brauner@kernel.org>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
Thread-Index: AQHYyAlViPga5eQsB0uSM8Tbg4syU63rMVSAgAAUR/D///V0gIABoySAgAQ44ICAFk3yAA==
Date: Mon, 10 Oct 2022 06:32:31 +0000
Message-ID: <fe724d4e-905f-6b06-06ca-593ee2b104b2@fujitsu.com>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1663143142-2283-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YywiZckfyJIk1/Pf@yuki>
 <TY2PR01MB442734C41B2B574CF05B8AE1FD4E9@TY2PR01MB4427.jpnprd01.prod.outlook.com>
 <Yywqj0orkajkDZt5@rei> <20220923102753.4vu6id33obfi34qa@wittgenstein>
 <1a7955bb-5c22-4746-eaf5-597c00c4064c@fujitsu.com>
In-Reply-To: <1a7955bb-5c22-4746-eaf5-597c00c4064c@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB4427:EE_|OS3PR01MB5734:EE_
x-ms-office365-filtering-correlation-id: afa64017-cdfd-4ff7-aba2-08daaa8935d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFIGV+F30Q87UEkgw4OncN0IJA04x204jgqI9d9O9h5VRLQkRcyr0wvojFNYaOB6Ey1upPREMtbYtly5PczEt5ax4z8YGO98YE93N2x0ANuAEZLfWM+nyh8fHwkBEykbknqwpum4MCim0GIfk3jYsuo9UZEkSLbPy+uUzzi/2H3L1+S35H7WiAdzf/J8pasptdQUu+38e7kQd2ySbLQ3Pe61KCi2jWKQ1nU0tOUkQrMC/spo8/qMuJ3TPjW02o11eTfQjL5nLHkXMGLWLATMxz9WDScqz6iI/MkiruXBW5eX8C0F2BCKyHWfKR7a0oBX2URYhClPYg6iYelQL4gcLQ8cpMxXegeGzM1IXZDzFgv6YIB5ErkuFmHq1aW4HNhUXjSbaVEliZPCUkDX4qn5g1QflUFIsmpOAuhBfWtH/uB65Lrrk3U0qjrbFiI9F29BrV997AjTh2DPmMXL8qw8xxnv9mjJnavu+t0mTL9qnCLxWmNYaOdU/KMmAg8H6Xb2tC0Qj4cC2AYofM7yGNQna9i3hqHyFu0VcDDKNXNnOvlf+RH3REj/3G6gdKKiYIatb3ruhaa1npT3005jZWyp3PfLZztm6k/3HEFqvdCVkA9LP7AwbQZWnd0FY7qVZK4yEMmZI259/RSmKJW1LOxa8ifQSsDWVJrJMbOcO8hUFXCFZBQ8s7bUBWxy9RAEBhWYjNyEw0uGBwoNqmSh6jdIOLUsqmTyIvEFM2NAsP3fNLUu7FVDTSdj8sQpgWX34/X/za1P5Zx4+SMo1SNWzgCG6dL39uXv4tsgAJYDXylNn4cbLFvS3uwZZj2HB3trnZ8IW13Ea6xRw/Byj/3ONIjiBnTv8FZdr2GTSOqMrcRXmj7wBrFzEMaqBlSJrxZe6n0IJ4Qlh+IpvMQQFowDmQYL7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(1590799012)(451199015)(1580799009)(2906002)(31686004)(316002)(66556008)(91956017)(66446008)(64756008)(66946007)(8676002)(66476007)(4326008)(76116006)(71200400001)(478600001)(31696002)(110136005)(6512007)(26005)(41300700001)(85182001)(36756003)(5660300002)(8936002)(966005)(86362001)(6506007)(2616005)(186003)(6486002)(82960400001)(38070700005)(38100700002)(122000001)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STJwZUg0elZRdWg2d0pUMzJFWi9WRFhidFFxN1djWU1oZkN4cllneDZjNHdy?=
 =?utf-8?B?alBjMGZpRkxHUDVxZ2t5OFNyRzhWV2Y1b2dSSE8vaThNWVFOZHltTDlvY29X?=
 =?utf-8?B?dTJwajRPM3lTVktXYkh3cFdtYjhCMzNWN1oyMk82a2hxeU0xSFlzTDI2anNS?=
 =?utf-8?B?MFZPSkY1U241WWNlbDFQVUZvbXlOQVB0SUhLSmQ4QlNpbmN2M0ZKZU1XdDZM?=
 =?utf-8?B?VmdnQUhkZkdLVHlGWEIrbWc2ZmZ2eVBPV3NwTFRWMC9TdExEeG1LY2t1VFNh?=
 =?utf-8?B?ZjZXaDI3YVVzYm42ZTY4bFNGNGUvbFNMQWtGYW84VlB4ZXo3TFZYNFIzaThr?=
 =?utf-8?B?eUdzclNrYzRLTGNxM3ZRM0Q1SzFxK0h3dmRuclNQOEFMMzdRM2ZQRTJpWmZ2?=
 =?utf-8?B?ZEUwQkdvN0FiNC9keHpNNnNSOVJtNWIzVWFpYi9WOW5wb0d4L2x0aWZ5My9N?=
 =?utf-8?B?LzdQaW9sR1QwMHFzOCs2ZzlsUzRabmNGU3VaeCtzS24wNGJmUGNoM2F4QW9n?=
 =?utf-8?B?L0ZFcC8wWXorZEtvVTBJNy9BZ241ZUxXMDdTaDdWTlRUa3M4N0wwNFZ3c3N1?=
 =?utf-8?B?TG5OM252WlV4WldONEtsV08yZEZiWEdtNmJPWlBNRG1NbWsxYmgzNXRnV0w4?=
 =?utf-8?B?YU5SVHZQQk9pTlBBMnlwd3EzT2JldmxLODV5NittQXlNSGw4TUszclpTS1dX?=
 =?utf-8?B?QWlsVHpRdFNGSlV5cG1hcnVDeHNWZE9xcWJ6MTMyMWRFQzZuaDBnNmNha1Rh?=
 =?utf-8?B?bHRwUHl2RlJYbWNEVDZhVXFGZTV0ejBvV1Z1UFlROU5WRVJDNGlmL1Q3dEdX?=
 =?utf-8?B?VWQ4dmtSZmltMVp6NnJwd0xqZHJna2JZL3ZVVS8wc2lIMk1kS1RQbWp6dmlK?=
 =?utf-8?B?cGlqNTlYOVRlWUJXK2g2dVRCVm5RdzFrRzYzYlZSRll4WGF1YUtyVEJUOGdr?=
 =?utf-8?B?NDlNOUVFcjkva2IrcHdreVViZXZHUnVqcGpBZ0xISEQ2Q3ZQTXhiei85VUlZ?=
 =?utf-8?B?aHhyZlRnbWtGa2JhUnZZdkI2V2pDNk5HUGpNM01BQXpzU1RIcy9oMkR2dmVN?=
 =?utf-8?B?aUJ0UjVBcHYrQUoycUovMG9HRi9IS0hPNU1JbjFJWUZaNHI4cllLUDZKS2d0?=
 =?utf-8?B?cjNCYzh5b2R6MUZyTWxrdFVvRXZZYWlrTldLcjF4SG03clRBdTBrc2JWQWtt?=
 =?utf-8?B?UHFyRFdGelc1aFVpeE50TTBCQ1JmOWVkNU5CbFhDeWtWVFFLSEk1UnFnODR0?=
 =?utf-8?B?Nk4wVnN2amh3bml5OUl0TktjbytyWFEwWDN2and6YWlzYkNsbjlZbnA5SXd5?=
 =?utf-8?B?dUhQM2tMVkdPeWNaR0R3Vkp6LzZXdm1ObFNzaUFUTXdBS2t5QWt0QVNUYXp5?=
 =?utf-8?B?a1NyWjUwQmpHdm5MRHhNM3MyRUVKRm5mMFF1a21IRnJDeVd3SXN1K3BkV0dT?=
 =?utf-8?B?WFVGcWVFODQvZmZlKzU3ZTUzbndNeWJ2dzNVM3NWaEhxL3g4QmJ2aTJ2NVkw?=
 =?utf-8?B?OXN1aTJabzJ4YVl3aklKaFRuVHFVVE9rSVBSLzJtK0RCUGkrOUFlbGwzWjdl?=
 =?utf-8?B?Yk03SDdLQ1FpWEVrUDd4OTF5Ujg4SWNxY3BOMThhNjVEdExVYXNFbzJxS01i?=
 =?utf-8?B?ODNQWnVVVEk5a1Z3VCs2VWF6eElaTTBKd3V1RFI1NGlIZHE4YjF3K2VjMUpz?=
 =?utf-8?B?Q3puTzQrckRUTkxqMmIvSlVNWTVLd1laSy9YTVRhcEJ2NUE0bjNtallsSk5J?=
 =?utf-8?B?Z3d2aHo2WVVjU1dOUnVDdmplWEhNZXo5K2N5czlza05NakY0RG1vdEg3dFJy?=
 =?utf-8?B?dUxWWXc3WmV0MjhmdUdLUmJBVmxkdW5yR1BPcDd4WTZDTkNGM21zSmhWcVBV?=
 =?utf-8?B?V0dtKzRIUGtRWEJuTWYxbDhOeElkVmIwN2pXZGlxLzE4cUpnVWZMMzBFZWll?=
 =?utf-8?B?bGpaRmN3OS9LZnpwMkc3MzN3TVJ1MzYzWXZXdUJhZUtSVzBPaG9wZ2hncHdw?=
 =?utf-8?B?TEwrNklJNU5ieUJGRjVvN1pnbDQ4L1pjT0taZ3VXSXNZQlFLeE9LenpSSlhX?=
 =?utf-8?B?SjRCRVNBZkcrM0crSXhxOVIrOEF4UGhPc3h0bnZLQjdWN1grdDFqUld1TnRw?=
 =?utf-8?B?TWRML01sdFRtcThtbnU3UndJVnl6RnA5bEdYVFdjOUNrK1gwSlRvSWRiRzh6?=
 =?utf-8?B?dEE9PQ==?=
Content-ID: <912D761A8EAF8142BB8873FD2CCD7CB6@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa64017-cdfd-4ff7-aba2-08daaa8935d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 06:32:31.6118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfVzm532rhG8+NiSrCtzbKb+UODqHmbjsTIwmusjPUJmyor5EEXZldlyO87OHPO5vcSvf3uwyMDaRIWPWlQMTvX4rsskN7eaW/7htsHJ0sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5734
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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

Hi Cyril

> Hi Christian
> 
>> On Thu, Sep 22, 2022 at 11:27:43AM +0200, Cyril Hrubis wrote:
>>> Hi!
>>>>> And this one is probably missing some kernel commit tags too, since the only that that is attached is supposedly in 5.19 but the test still fails.
>>>>
>>>>> I supposed that we should add the 426b4ca2d6a5 to the test tags here as well, right?
>>>>
>>>> Yes, BTW,  I usually use git tag --contains command, so I know this kernel fix is belong to 6.0.
>>>>
>>>> git tag --contains ac6800e27
>>>> v6.0-rc1
>>>> v6.0-rc2
>>>
>>> Now I'm confused, if I do git describe ac6800e27 it says that it's a
>>> second commit on the top of 5.19-rc7. So shouldn't the the git tag
>>> --contains report 5.19-rc8 and newer? What do I miss?
>>
>> So, ac6800e279a2 ("fs: Add missing umask strip in vfs_tmpfile") has been
>> backported to kernels since before the dawn of time. But the the all the
>> pieces that move setgid handling out of individual filesystems and into
>> the vfs proper are only >= v6.0-rc1.
> 
> I search the commit mesage in the following url,but not find c6800e279a2
> commit
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=v5.19
> 
> @Cyril
> I guess git describe ac6800e2 will serach the commit id because it is
> merge request"Merge tag 'fs.setgid.v6.0' of
> git://git.kernel.org/pub/scm/linux/kerne/git/brauner/linux"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=426b4ca2d6a5
> 
> then it will serach brauner linux fs.setgid. branch
> see the following url
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fs.setgid
> 
> so git describe ac6800e27 it says that it's a second commit on the top
> of 5.19-rc7.

So do you still have doubt on this?  I don't think this should block 
this two patches.

Best Regards
Yang Xu
> 
> 
> Best Regards
> Yang Xu
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
