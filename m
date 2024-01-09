Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C54CC3DA6E
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 00:49:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80CB93CFE37
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 01:49:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC9A3C0645
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 01:49:31 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.34;
 helo=esa17.fujitsucc.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78D30600C82
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 01:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1704761371; x=1736297371;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pJg6cDAN5zFcK37GA6ziVfd2p+ZyFa1blcnihsZPnLw=;
 b=Dt/LGHIjFZOP2Oc4dApOYvntFxvNIGXxD+EGRnYBN5anwGOF0yPSVIKW
 7qK0C2o9B/FEC6lEYEumCAtKPPXi8CjLHPc0cvSczEKPemkH/j6IU+PfF
 WnqQWJueJMbngtct2jPDo4zRibIGeP/s+L7XAlJWsyPtjiAAnrFpQ39ct
 VVtmI4jRNVHgc6woGDq0NnukBZjarF3Zwj/n7/0MwT/mpTjZMywXXYkFe
 6nyOXwRpWriMNjBQHqpAwy7psehI9ydkZEvGNzJhUeY43+F1LmELcJDdB
 qTqVrhFq8GpMdcQU9Y9BHIsO/Px/e2pByxs6zsOhhk0NuPi/4cCH87stj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="107533676"
X-IronPort-AV: E=Sophos;i="6.04,181,1695654000"; d="scan'208";a="107533676"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 09:49:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qci34acScxNP4YjRwHsR/j88VedPU2i1e67iPNX7oogTnbsC967QH9sUnESiDM3j5mXOqZID17KoJbHaTURb7Gg7GHT6QyISs1WbvYxw088DDSZ8+RH3InvZRGmXhqcZMxg6RJnEnNGzgpTirlfF+bSgJbX/PnObjiU1XBFfK0jkneH/iouTILUKpJWGf04EA+0QS//FGVwWXd0Jp9GkJpK1t9JOMxlV/XIoWEgEXM1pLnvaRmcSoe24UEZCu5YjwehdsOWK5YeouROfq8cCdb0ImV1ErnWqu85bEg9GnU/qKHgixb+QOQqjt1f2ILEUgsQ/KCUbmGvNj0ZtC4LvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJg6cDAN5zFcK37GA6ziVfd2p+ZyFa1blcnihsZPnLw=;
 b=Qzg9UOMfO4bN6xJzLmI/FwjJLtUZncy83ao3dxgC/89r1bGRwG3zIg60KmEQ0pe1lJOH/XZz/zzR5DLlnH/J8MjrTWYEI3tBeWVKZkVRY8B8B8WfHTq0n7fYiHxvRJIxtnnU3SV34OZW30ZIzl380DVNxz7qirDja3eVz4901rb42jPue++48a6OorsN3kzmnJoyRohxCBcSHFB55X6VsWWH+U786laMEggFzMGQjEAz7L3EvScdusa/xOuY+U2oF5DlU8Jt6pjttCj5TmFEpsQKVZMCVQkzVmrnoBOzSbDgMB4HdBCeaZEyXCAhvO98Z43fKowUR+wnJOeyB59e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB10825.jpnprd01.prod.outlook.com (2603:1096:400:296::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15; Tue, 9 Jan
 2024 00:49:23 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 00:49:23 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
Thread-Index: AQHaP6jo5lyhHc2qOE+as7f+xycgN7DPqTwAgAEC0AA=
Date: Tue, 9 Jan 2024 00:49:23 +0000
Message-ID: <c8ed8b7d-8385-4d25-bb8a-8d367ded16d8@fujitsu.com>
References: <20240105072843.2098332-1-lizhijian@fujitsu.com>
 <CAEemH2ddinSLqF1kKdG2Nf__aa3jraH+NtV1aSFO0=u=MgGtTQ@mail.gmail.com>
In-Reply-To: <CAEemH2ddinSLqF1kKdG2Nf__aa3jraH+NtV1aSFO0=u=MgGtTQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB10825:EE_
x-ms-office365-filtering-correlation-id: 18b6deeb-a78e-4784-31e8-08dc10acd2d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2+yaVbXdQSiQc8zknEN/0kyVS3K9hHY+3bn09mOtyG/J46vOeCSDevhdSEXpMIg9LZFTFFxLk26tZJoY6Spku9MuRhI7isiQc6I4qeCHfHQdKfz1/KSPZAQq9cG0fVzXbjcZrXd7ATs2nEhIPQGaqUDYAYOOkOc8d5GCAWMY1eBbHbgqWbksST6V/72F+W4iVMowwFsFWo2QtoU7J9UVcVTDOp9Ahlc1Xxk4FjU+LH8Pt2ER9rOJRbrpi6xCGfz4vJUPQgN4tdFAg8PWY4GOAzXjRuc22K4rdEcEim0HTtmszGuXUMd6NxyQnhbd2cJ3hg249pGETADvPu+q4sRkhUIGVPAMm8zDa3mnM0UWw6G4m/YIhiVb4b1L/xutOWJZiHmpuG56sYtGm9dsl5TZpWBihKiz0s/jWOMif+U+Yj8I/OhK0Ln6j+nSXbGPsWiJTUbY3XReDIxSw4/x45HIFjQL0znRAzovoxFn+Aml0KNe87byA7k0IfNSM/4pfH2HwTNyVeb21DRQOx+qOmM6l8ad9fibcXTEjYNRDf3yJc57YtkSfigmFLXKNGaDfpRgE5ltmk0rXLyn43eymYZQatI5UZ7596zGjByHTFGzm4OKNPX+Vztv/Kj6FZQ1VsLZ8Gl+NqFm2ukNGmKAxNYvmnOjhgNlpANQg3GVPSjlP5RcuH+XNg9JXGwbkJ+V4VL3dCpvT1hzuwchVgv3wKZmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(1590799021)(451199024)(64100799003)(71200400001)(31686004)(478600001)(4326008)(6486002)(6512007)(38100700002)(76116006)(91956017)(6916009)(66446008)(64756008)(66476007)(66946007)(66556008)(8936002)(53546011)(6506007)(8676002)(316002)(83380400001)(26005)(2616005)(4744005)(2906002)(5660300002)(1580799018)(122000001)(82960400001)(38070700009)(31696002)(86362001)(36756003)(41300700001)(85182001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1g1ZDVkYkRaSXI4NWxramxCVXhPRjN6M29JUkNkTjUxYjBCdDN6RCtmR1oz?=
 =?utf-8?B?Vlc4Y2w0TEp5YmZjdjRjWU5IeFQzVXhXeFZXQWVMMzFJZENLSTdyanA2ZXVC?=
 =?utf-8?B?YVJjRWVlYjhJZDk1ZlNwdTRGNHhaY3lzQ2YvQm1oTGNFcGVVVjdpNXpqSkdz?=
 =?utf-8?B?UUZEQVQvL1dxOFlGVXJBcUZnZkx3TXFIQm1ENHhFNit5NGhoZTJwR1dOY1A3?=
 =?utf-8?B?RStYeVRpNmplRnpYTHZuaG4rK2lBT2FyN2J1UThXMjFXNC8rK080d2xRWVc2?=
 =?utf-8?B?SHlSMGY3UXJWajBHLzNnT2ExOGtLTUF3SDVCQzAwSWs0U1hMTWRveDNiUlBn?=
 =?utf-8?B?bzBWQTZ1Vk5pZUF1N1Y1b05ZdG93L2dQdlk1R0ZaREdPRDFLOUwxQTZOalFT?=
 =?utf-8?B?KzFGemdobmtrc21JR0lKbVBCUWdXZzZ5Nmp0cHoxSlpjK1N4Rlkrb21VMUIv?=
 =?utf-8?B?bU8zTlYxOEJxZkxSYVJDVnhYRnYxR1dqM1RCcnpnNnBIV3h0bFptUkdxKzAy?=
 =?utf-8?B?OHQ3UHZ1UGZtQzNMSDkwRjVWYWlGTi9IRUY3MXFPaTJrZHhSanc4aVhzOTMv?=
 =?utf-8?B?QWh1TEhSazd2cHhJdzFNR25XVVorMVk1cVFWc05ZNUxYWkpONm9YaU51eFBa?=
 =?utf-8?B?VGN2YnJpRzdjUlE4VmVpWWg5TFZGSHVxR2ZTUVEvWUJZWjNuc29EdnhUdUJX?=
 =?utf-8?B?bEF6OUdZWXFIbVd4ZXB4SVlDZ1A5WkRKWHpsZ05IYXY4NjNnVGZiOWNjb1dk?=
 =?utf-8?B?VGJvQ3JhL3RzdTFtN0NwVWZYaXpRbWxHN21jUlQwT2ZSdGZFM3QrSEc0anJP?=
 =?utf-8?B?T2w2bHNpYjduK0UvM0tXU3dKLytEKzRDd3hxZ2Rwb2M3bXlKM1ovdWxna2hP?=
 =?utf-8?B?d0E5eG4wWlBSTjRUTm4yL3hPYXhhNjlLWUhKZVB0VHBOVmJQdVZsc0JMUUZ6?=
 =?utf-8?B?aUJyTStuQXVZR2xxTEtMT2FGOEhkb3N2Wm1MVHkwNS9TNnEvWHdaMTgyOXBO?=
 =?utf-8?B?UVVvMjk1MHU4OGZJV0M1Y3o5dHp2eXJWbkNHY1JKTlZ1aEpBQ2wrSjNJejlX?=
 =?utf-8?B?V2NqczlnTTRGYzVrS0JyZGZWcWtobDFJeDh2MkYvenp2azdQZUt5WitZTzgz?=
 =?utf-8?B?azZzK0RleEJNY2svQ2pyZ0g4YlJoR2NNMHJkVjRxTFQzSi91UWtBWEFUNk5M?=
 =?utf-8?B?MEJrV0ZSK2tJYXRiZHgzSFF5YnRWNFk2aUtsSHhneEJlcFVwc3VGcHgyYXdY?=
 =?utf-8?B?OGxKZEFnTEVkWkhZL0cxYUJPeWhqcC95UlRScTN2MXM5Wkpmc0VOb0ppNEk3?=
 =?utf-8?B?c3dRYWwwQzZuN1Ntb0IwSGJtRDd0ajBpaTFGdkJPSXpydXd0SEdmelR5blNE?=
 =?utf-8?B?a3NyeFdsV3JKYTY1NXU1VEExTnhWUXRWWFR3czFwaWhzSEE0dFZseThJRUVL?=
 =?utf-8?B?bUV4RGVSMDJPTnBhVjZsVWx5TWJYQmVndXVoaXZlVm5wZ01Kd0NQTytESFNN?=
 =?utf-8?B?ZnBIOG52UFlKaTRUS3lKZU9XZE03WW5SNVRpU2M5d3FxMG42UmM5eDc4ejcv?=
 =?utf-8?B?RGlJb0dTd1BRTDFDZlhNaG1MMi95eDNWVmE2T0hBVEhzVVRRM09NUEpxc1cv?=
 =?utf-8?B?Uk9odFZ5RzBqZ2VVZ2U4Zk9zRXlBZVB4WUpFUU1zbVRQRnNSMmlqN3lSTFZa?=
 =?utf-8?B?YmpoN3kvRXdhTXYwWnZkY1E5ajJJUVJYNXdHOVF2amNOME5ENDR4enJUVjJQ?=
 =?utf-8?B?bzlncU1xMUo3U3VtdThjL1htYlVWNjRIUTdxdEJhTTlDRjl2N2VTb1V4bmJY?=
 =?utf-8?B?OXhUOEhGdkhiWXNTRTVlV0pWL3RwREg2Y1NoRmZzM3ZmdVhyY2JHajlhd2hM?=
 =?utf-8?B?ZmFUZ09IZzBTdm1TU01RRUZGek9YcXc4V0V0ck9FUkpxU05jVjAwa2R1Qzhl?=
 =?utf-8?B?Q3lVVm9Xbm1ySGc5VFAzZWlhTjVDTXVSOEJkQWIyVEl3YzNISTljQnpqeW9D?=
 =?utf-8?B?TzEyUzUyRkg1aDUva1VSMDNIWmlHNzBVUTBreWIydjMxdTlvNk02TWVvV0Nr?=
 =?utf-8?B?WXRDdnFwWHgvb1NFNW9wc1FWS2Q2dkFGUkw0QklxWFYveWdSR1RYMmhmYmM0?=
 =?utf-8?B?TG1haER5YU45bjdWaFhMY2Y2eG1BUHUvMG5nRUQ4YlFMRVM0WmsvZG5ONmFX?=
 =?utf-8?B?aFE9PQ==?=
Content-ID: <674449D976C2CB4590B3FFE5F07DB37B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RxDa7b+6MiP9teh2+EoLPVL/SjMNUyAweRiLPuEqtYruyVAfITvlXELTwTG65htKwRFG2vaiVvw6F4Y5qqcBm+MVcKAc/QSDhLZmlpefEd1y9KOQXc51LhmtVBM/r6DZvODs7vnVkXos84RZpHVeyeuBLH2JZDhyy3Mpv+JS+0D6DqDd8Pvoz8quaprwu9U/UlA30KvYPlWdwcS3n0WebEd0xJzzeP/oU4a1b2XOnx6a3d7peYK1ABgNUtu6o86H6Lo3+MQ9eHaQXHKabZamqSqSEpkp7dshJL2S5TOVFK7mvyzn73X0RGmI3sxLIvbFOh11XqZEoy1N3dpByDHAq5n4YM7rhautC7YfC3yXgO0dEPV+bN1bolmqMZ0cHUW4qtiZMCvEqk8iMv08beswODpOCpHj9PENOUHWOXE8r1pWpklmYgjDN4F2Xkf/13rP0PKzT2YmGrlD56V218tgORZTbGCPU36/MPsSFtAFS8ioZiav6PQaouCB1mh7ry9crbJ1z5mOP2mOlTbOVdo5JDtd21qzGsPZ3086/l/bwUOQZr+5ZBSuDB8Uka87mV+FRDHrVt83qv6WvXRIsSVBPj04eCFwnTF0YOMjRQNkG/0XHLlmbpTLbqErTAEwirxg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b6deeb-a78e-4784-31e8-08dc10acd2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 00:49:23.6910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxnF9t5K6jFbTYkdXRyE2Tlx3EGiCzWSAR1wmRGa33OoQxz7tBRsX5ORhdK/9i4EYNgMCB6ErbUsveaMDmYsCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10825
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
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



On 08/01/2024 17:23, Li Wang wrote:
> Hi Zhijian,
> 
> I have pushed the patches, why resend them again?

My fault.


i had not subscribed this mailing list before sending this patch set.
So i got "Post by non-member to a members-only list" at that time.

2 days later, i successfully subscribed it, and i'm not sure if this patch
set has reached the mailing list. So i resent it again with "RESEND" prefix...

Why it takes 2 days...., i didn't see the confirmation mail until i
checked my "JUNK" box on Monday.


> 
> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
