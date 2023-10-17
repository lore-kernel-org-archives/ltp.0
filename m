Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CB8CDB483
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 06:21:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D86F3CD0F0
	for <ltp@archiver.kernel.org>; Tue, 17 Oct 2023 08:21:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 512D13C866D
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:21:39 +0200 (CEST)
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com
 [68.232.151.212])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB8041401239
 for <ltp@lists.linux.it>; Tue, 17 Oct 2023 08:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697523698; x=1729059698;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7vRvJ27is4OEr8ODaOu0fqAJaTWgSOlPigvbmffSdTw=;
 b=qR+v13TWJe2tsUMismExKuYET4zV7Qu1M6TR+SoaUkVil2P5ke+LtyeO
 627aiEqe07KQjNZT4VikXMfc5euk5z0Xedrl8ruPM5lP0pZjIM6toaW2N
 Dxk8xlKOk8R+Ee5gQmo7ugnkJjo5WDAD8J6UQqhkSK+tNYS4yU1THsB5j
 2/2zYWuO8iZDGAJMgnk4QSLa6i1BsQz7MoSw9HfNDnu8hDyvZM84wRt4z
 NNe+Tb6+2p1eTC31BZ3rQ5yfa6uBXO4gn9RdVMuwGYsRIijoKSdg59eva
 7Oe3yEFyYvpNXaQ6QVb/Pi4GR2nJzqlmmzEbHmXtC7EUNDDOBsXzLmo1R A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="10562736"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; d="scan'208";a="10562736"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 15:21:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En6ygaysjQ38t+IfvSbzfzNc+JpJupQIdM0l4k8GkeCETm30asHqN49iN8FvAfjBZxYu4g7h7nFCrseQI5n6ojhCCDljg2JC6XOAxyheUPVkivVRByyi3z8zLi6zBQGE2r4YRbl6H2PcfBK7RuSd0qSmE3HYX0gYKHB2UaATEBuiNOfc76GlV+HTf4dvbFxecamRGzU/8OxE/6PxVxMxnmz3MZ/CZbupbrNDdXgxX7n8Cq6Y51EdWZZh9AwNCwhYNKcHOBpDhRwd+VjKHHJAhLHhOKxuvt8blJbdKATTzbCJrvV3KxQ55iR8Tuj+XN13gb4P7igFvAqv4lrNKHBjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vRvJ27is4OEr8ODaOu0fqAJaTWgSOlPigvbmffSdTw=;
 b=KAwv/viJ91DkFXaQPOAE8bpRFmd9WGTUmGDzNM6PstnlzfqG5Wy2HXrybsrpTQrOzqmDGtCr5p7DrDoFn/ZwCOEsRCrV4WLH7By+pNLRCTnovgYtonHG7VleqhTivssSRslv1pJ2kNaIcla+oLEnHAQR26+jLzJxQtYe6zi2TeMAW6+csWSe1LjtW7oUuLecXz1KfSi5f3GSZGZoC1QsVLKnayWAu4Lkza6mY8iUyy/NUtTPrH6aI89VFIIozYZcjOH/XQkXv1GyvQKfpuxBUGfwZNHhqXVNZxHZ3ROqfzGEoHABJDeeZKv9aGL7YDiX4GXyCzE0ngip30qCqZ6PCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TYAPR01MB5771.jpnprd01.prod.outlook.com (2603:1096:404:8052::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 06:21:32 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 06:21:32 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/4] readlinkat: Remove readlinkat fallback
 definition
Thread-Index: AQHZ57g/dyvpbFL+CUa03oAgRvriCLBMQKiAgAF0PYA=
Date: Tue, 17 Oct 2023 06:21:32 +0000
Message-ID: <b9b6dbd3-f2e9-ae4f-a68f-df4781fa8c27@fujitsu.com>
References: <1694770631-9547-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231016080913.GB840411@pevik>
In-Reply-To: <20231016080913.GB840411@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TYAPR01MB5771:EE_
x-ms-office365-filtering-correlation-id: 894cce2b-393d-4101-f52d-08dbced94eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dlAmjMX/ih4TrNMfpgkuUqov/2B6wEsNX69CDIG1EOFKGoT+KW1k+TJFuSPLtjVlTURDevAy17sn4UoPrY3ak7KMNZa/CWNKWZYo/HXmXBu6FUTMbb1pKCzHSJfofYjDse9/2klyZxdQOCk0INTykKkClMQPtu+fHNbXWmq2PxgafZyPOet4epGqa3eOY0MRpxnJcsRvbC9ZRgNqlM4lNKWoPNv40wy1MRQuDCmlAdCe6AYH+xh8QjuH8ZceU2+aFCKXbmxCTABOFL/Xd2g276KfH9KrN4yvXJDsnutNtuqTfWImnsIq2Pg5Q6Fz+f7s+tkJ0eb/qlvwgtfFJzyU+9E/Ee20DmaK6Lme7dFQse8Uplj7jLsB9uMtRFvF1htaE/rrBDYBIwFKGfEd+AxWwoF4NOSvs7RZUQiDcULF4+Muu+EcPWj9v+CmEHyr7fw+x3Pey8Mop19LxX6tsbms7H/wjS5V/n1gaHJrv1qew6s40agoVVhtcoiBGhVc/nFjWSh+X/+5f3uV8XKTjwIgFjJ5o28jFkOj2JqpRDBDhRj9yLLbPe0wQi0wUm1Sr4NqlHj3UVdE/eCJ6jpkxjE++WE6/X7wJWy/JumcdOfIptjbcoYqTpJ7bG9jz7th4n4yPwj8pGnO/doEbUaTiw6SplzNljSzCBqLcsAZhtVYoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(1590799021)(31686004)(1580799018)(5660300002)(86362001)(31696002)(36756003)(82960400001)(85182001)(122000001)(38070700005)(38100700002)(2906002)(41300700001)(478600001)(66556008)(66946007)(91956017)(6486002)(6506007)(8936002)(966005)(71200400001)(76116006)(316002)(83380400001)(4326008)(8676002)(2616005)(66476007)(6916009)(26005)(6512007)(64756008)(66446008)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2Zja212dEhtWG1tcnNWWTA0TFJLRWhVTndKOVR5NmdmeHI2Uml3aGRVQzZk?=
 =?utf-8?B?Vi9LNnRENnEzcGZZc05ITExHR1kzMVFGL292Zit0ZjVPajlRaC9wVXpPT1kx?=
 =?utf-8?B?d0xDYkZGdDJIb2ZTQVQxNSsxakx1bmJSY09kdHVxcHFZQnlDQ3ptYlh5WXZl?=
 =?utf-8?B?QzlON1AyaG55L1d0Z3o3T3NjTXpUSVRDVkVza1FidE1pWjdzSzR6VmJ0dllx?=
 =?utf-8?B?WmtqM0I4aVBQMmhvZldXWW5WeVJzNmhEeERuSGQ0aXMzL0krK0tzOFErMHBH?=
 =?utf-8?B?N3kwTGhuR3ppRy9naEJ4a0V0RmZzN25GM1NaczJobjdpRnFqSzExbUl3SnZB?=
 =?utf-8?B?SXV6b1hWRHFGWVd3d1o5T3VzRjZBQ2tWdFRuWmZuc01jMDROSFhxZ3RvZnNa?=
 =?utf-8?B?Z01HQ0UwRmQ0MWtYY2NDR1JPeFRYZjUzSzB3OG5BNld6VVFyM0VrUTFBVGs2?=
 =?utf-8?B?T2VwY21NKzlKZ1FPME5iQldHZzJDc3Y2K3hGZmtldTZTZWpobEJIU3JUMXdm?=
 =?utf-8?B?OElIQngyUm5TTEJsQzdQcVI5WTErS3gya1VUSjl2cUdQUzNGOFprNnhod2tY?=
 =?utf-8?B?bzdvYisrWm1tY2MwSmMyNnNMNGtNYytoOGZLZUpZNkJ2N2djWFIzUXowQ0sy?=
 =?utf-8?B?dlJWZVVLMjR6MlN5TjZ5TEUzMjk1K0ZuM1ZERWtGYWVIcnltbVgvVW9MY2FZ?=
 =?utf-8?B?aExsS2VFbllOb01WeUNlMXV3K09QQ3daNUMzVVNIRWJlVVJ0MW1vVFVlM3Z0?=
 =?utf-8?B?WHFJNWtQdjdZVSt0dHZxRUlwdk1ZQjBiY2I0UGptbUZXYXgzWWJPRElISmpD?=
 =?utf-8?B?RUUvYktjSW9OUmRBaDc0K1IwQ3EwQzhJMHBWcTBSOW9UTHpWelRPcGRNRnl2?=
 =?utf-8?B?RFhJR1ZGTkd1MTd2cEJpM25RYnUzRis2NW5wZEs3OW9lZEFzSXM1eFY5bmNZ?=
 =?utf-8?B?aUlCUzJWbUhTRkpRSnMzVWFZMklsUWVFOE1laXNIbnRxc3UwR09mUVNnN1dT?=
 =?utf-8?B?OE1KampLZVBrUEloemhRSzN6eDZRVloxRDA1SlYzOEp2L1A0MHRydlZCWGNy?=
 =?utf-8?B?WnhjekVkQ2t1NzJZb2dGek5tc1d4MXdRRzBmb0VvTVNhc09JajNLbkF6Y2xv?=
 =?utf-8?B?MVVxdHJqMncwV1JyVlBid3ZHK2pPUlhPb0I3TXdtbmlESnN0anVYNWtkWFph?=
 =?utf-8?B?RUlpMTRoRUtuUVg5VkFTUkhwV3JIZmxobW1FekJxSWMrNk9LdnhpOE94UXN0?=
 =?utf-8?B?bEpRL2hXT2NkQitIMzhNY3M1cmRIaFR2aU55T09Gd05OWlZiaFhra3ErRDhV?=
 =?utf-8?B?V042MTc3VElCMTFvcU1PS3AzZ3UxMG9KYzBZaElxeSszaWkreGRnOFhnakFV?=
 =?utf-8?B?VDZZSzN5T1BSc2hKWjVGZUVEdHVLQkVDeWxBNzhvbGt6TldKZWRtaEJuWFZs?=
 =?utf-8?B?RUxFZUZiWjZCci9CWWVwcWhBNjY0cFBkTjB5SmZLN25kbzVxdjV4Wk1qdm1l?=
 =?utf-8?B?RlZ2N1F6Rmk3ZWxST2pwYmVoUU91QWgyaTg2NW1CdWNlVGhlbUVyZTUwc3hC?=
 =?utf-8?B?aTQyY25xVlNDWk90bVJtMXhiSCtlZGJHQitmNTNEYlo4TmFsTXUweWxKRDVB?=
 =?utf-8?B?bU9wUHlaSE01WkJwdExuZXRwVmJ2QjhlYkJVTEs1VlNIbVQ0cW45czFlSTBy?=
 =?utf-8?B?MjN2ZVRSNFY4VjFsc2NBWmxOampuU3IwU2F3b3VBMWRvQ3lvczV5Ly9ieHRU?=
 =?utf-8?B?bUNEeTh5RzF0bUVoMVk5SUhQeHlRcUlGdngrQlM5ZkRLQmxHY29hblg3a1hi?=
 =?utf-8?B?U3VodlNsb2tmU1BndGMyYXcrNGl6RU5zOW1oRHR0ZnpSQmthazlxRXY1bEtw?=
 =?utf-8?B?YXUvYjd2WGF3ZWRkTng3ZmE1ZnNKcXR3clpRMGhNOUNybkowWUIzYktjcGZa?=
 =?utf-8?B?K0dCU2ZFTkxBcUhUWWVmcHlzNGxRQXkxMHNORDBzODRUdWdLcDJwK1R0ekdt?=
 =?utf-8?B?bm5LU0JUbFFnQ1lLK3lyaTVmTjY2d0VYWVVxUmUxUStqK0xKSlJqTGJBc2ls?=
 =?utf-8?B?RkRINStCelBiRTBZSk1hQXV4MkIzNGZjeldzV3hwRmViZ3NQb0doMCszWkpk?=
 =?utf-8?B?bmdlekxRc1ZidUE2aVBQOXo2QmFMNXlUeDZma1NLd04wa2wxN3lzOUorZzlC?=
 =?utf-8?B?eUE9PQ==?=
Content-ID: <10F2892C9D462044B1B091674DCBBE44@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7fIsRZkcP7MvjNrjUBklY2TyhuRgjTieyCTLq/mZFzL/XHeY9JpaC3fmIJFQdhKgewedKm1LhCrkpeAqryZbPKqe+E9zK3VuZqoYY8jfMjhGHksp2hI5ES/WLfuPHuO7lpYDCnpoplr8mDEXAWQeKZXFSy0rixaGNhx6OmXwMY9kfpEf6z3oucAFZTWPKFcPmWruMiLC9/fdxYR92Xdp2RyFqUhS9vDKzpwpYONLGuRZsEk/+M9cPz4ag4qrAlzkZEwW33ZUZmRtN0cLuIvA7PEfT7DVSLzgvuWXnmzSePywtA29ozfNlu3E6Qzwx22UyvxmF/eP3FReH+ssHPy7mOmHGiYz1WYdxHLLcU3+C7YPkCiWlEleks2G2wt0EhWcNVQWepaoPe7P5dKqfNUBOjkzQdolGoX89wLrC7WcIBpaWd/dYicepWyBDazt599fmGdDVzbgjX6QU1ZZWb6BDKXbqjX8xtR91jsAtsGUIvHykUos7YjftqlHoq1WJh+o8K7bC9gQoyYxI797X51xhyPkA8LLpr8ZDLdTnFwGNq02SGwuKj67Ka46zVrFD3zNxN1EuRTXFMk/X4Gcuy/Pd4UgkLfhxPXEZwUPQ/LQl3ZXSB90jNyaudx9ZCB6UMG/7DaY0GDguynBHODiPiynKU8GL5Mu89p36kliSw60iD3rsTHqPFDGxk1j63AC3YMLHNf1zvxCm24LDD7MOTfwi5YtaaNz/ohl+dC3NUM7cuWjmaeIVnCybV8mdKswD1tMKfgGnMnuvSwmSMc9FYM2mfThkJ9hUTj4EPiCLoJfkWI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894cce2b-393d-4101-f52d-08dbced94eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 06:21:32.8927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSq3bP/3fQ8p2XDBgQgd9wYdbGOspZYrQPcFud6n0pmRHqovCEggQDrHGblAzxMveZw1D653sEVwd/DIqAAsxu0ifRlvYgWcZ1vXknsLQ4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5771
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] readlinkat: Remove readlinkat fallback
 definition
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

Hi Petr,
> Hi Yang,
>
>> Looking at man readlinkat, it was added into kernel 2.6.16 and since the
>> oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
>> .txt) we can as well completely drop this fallback definition.
> Again, as I mentioned in v2 renameat() patch [1], the real reason for this lapi
> function was IMHO missing glibc wrapper.  The correct git commit message should
> have been glibc wrapper was added in ...
>
> Also, without kernel support the function would not work at all, therefore it is
> irrelevant when readlinkat was added into kernel. That applies to all git commit
> messages. Due me merged v2 renameat() first, this is not applicable (patch must
> be modified, I'm sorry).
>
> This particular patch would deserve to note that since these 2 commits the lapi
> is not even used (both released in 20230929 - a proof it can be really deleted):
>
> 0959b893a ("syscalls/readlinkat01: Convert to new API")
> bcafe2971 ("syscalls/readlinkat02: Convert to new API")
>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/ltp/20231016080349.GA844528@pevik/

OK.Thanks for the patient review.I'll modify it.


Best Regard,

Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
