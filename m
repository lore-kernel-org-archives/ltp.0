Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B86C7619A
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 07:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1B83CC808
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 09:04:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E182B3C03AE
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 09:04:39 +0200 (CEST)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC7586005F7
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 09:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1681196679; x=1712732679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QhLiG7IiE2BML3OF9PY2jPCVMg5ckS6iyXPJXCzsp7E=;
 b=Tj8cZ99wKHxZqoBd++ypNdLVyfrrbNp4qTL5DACdcgyqOoAUzj/3Sh7N
 elDjXubPIX8AYjND7Qkz/WH8swCyKwEY3d5totMbjMqzrvlAuQWfZ6/Cj
 7GGZ48QXnX22YO5N+ZVqoGb0zg8uNS8sr54gqpYaPOLMSSYoHeZuDQx15
 CwCcpt07zoS0TKSYeb/U411BMbo7KYAa0dx5fiYJ97yPhfXcPI3X5hUos
 4Bt0mO0pBTxHjpkr44oc6Sx9cCF0tb/UGCVOiw8A+Dgg0gYFfhvui9rJS
 1GlUYkMLhDmT6KhYqDw/wrZRskA3uIlynKHMazShU7V8Ku+L/tJnbz8Yu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="81965900"
X-IronPort-AV: E=Sophos;i="5.98,336,1673881200"; d="scan'208";a="81965900"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2023 16:04:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3yrRuTArqaqSVOD+3t2GdOyPN1aWcQUixKODax+riyKN7wVMRfyXGYCz+5D023X3uKxIdHeYnDEVNuscyJ/x9cQ1XXzoWDEc7ubMkBvP5IJEWudVcz48WzcNemxmIJ4V/eD3kUjTn00u2beIZo0581qaWjj5Vkd1iuoryRrbYOIIPQz9MgsLDClMUoNGcV60lPHVIE2YsjLylcEVpfe0M4OPwOk7q7e2bRTPbaofE9Wz1azxqHmtjyHQ5zoonq7bKaa/qGVfSs997gwmxK3cokp0i4oRNYmCHE+WGF80CYAzm0fynhLiiMjKao4SbPjVDk7m8aNsIwSiItIxOWDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhLiG7IiE2BML3OF9PY2jPCVMg5ckS6iyXPJXCzsp7E=;
 b=KzSRBaqS4t0ayf0wnhM4C9aoUVsSkT0Y4H45ZjX5zJt0AVVtE+Iexyh9S1Yugm+ERWvUiwL/qzrpd/LNSMEQoEYEPqODsjaQNkRPXfmeZVDBXd0Z6Q6EdmJZUScng7HLyh0ZeKAaY0UwAZcn2wjx4g9GMtOBc5/kTdJw198cVkWJrUnSAqKfqddPK0wAHYabZ+88An0TXp3WtWoEQHbYTSTJeISIDO5ar/k77dWWSsXrIr9opNdosuOTmwfqqLTcEWFJzbCFXdkvSaekFqhdJV5ucbTLW7Bo6BcSrWDHZUh/qDaLhbP68S+M09hWCAGQef2US+iabOzT59GNGDHmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by TY3PR01MB10221.jpnprd01.prod.outlook.com (2603:1096:400:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:04:34 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::b09b:8bce:a0d9:d3dd%7]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:04:33 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/fcntl06: Remove R_GETLK/R_SETLK test case
Thread-Index: AQHZa1CJXu2NK/txJEm/plIvEF8q268lpraAgAAKYIA=
Date: Tue, 11 Apr 2023 07:04:33 +0000
Message-ID: <e8cce0ed-4b70-c92a-4de0-9dba768374a5@fujitsu.com>
References: <1681092133-28614-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230411062721.GA1737346@pevik>
In-Reply-To: <20230411062721.GA1737346@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|TY3PR01MB10221:EE_
x-ms-office365-filtering-correlation-id: e976ca98-b4f7-4335-145b-08db3a5b0131
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAhsl3PJnrnsoGV9B3DX2x3FtyrYR2n/1E7ohvJjwbBi+6rrhqdICSJHEhhZ3G9lQsY8sphpP0BpfrqYNAt7u616mXXP19Aj1/gqT2hjMt7wbdPwvzpfMGhKgXcx05r+h1vM5jdHSIoWR7FqOCo6HU1JbqQuo7z6ufrud3v0Vo2CW4B2qKomz6xWbh7pPlOhFSWuT1EtegDNbEWg0VKIN+KOrlVk+lr3/S5YdUukUFS655rPegX4/JDlvTapEFCdgGzrjQLxrZ11ggOjaU5r7rHhDz6fd9HFzZvZJXixEHE1q72sA3xCcl+KT+FLmhj9OiPL9LgdtE8ro/GTxFuoM+pXc1IJQaK/t58oc2tKbqRIuWNTu4pYadeHMwL/gZAee7PBeBZ11lAAjty+w59iV9QHswwtX71smeEAv3bFm3fM/GPU/OMWwEHk/HQjZHA903sb+orQXkWOJaeCjcKev6RJ688Sw5jzsQysK2th/Z2VM5/wc2gpX3LjAqGuvt3z+vL9vZSRbTmLuSlZiSDUatnLVFQoIAmNmt/vr/rgvVzx+Oik87CbKRLRIZrqy5DJcnU6xvmz238KRFD5ReNCLJeP9EVArjv8RMmsd9t3Enn3EuvH5TdmJusMDi15Tb8dkbnkGwm41JGZ9uXe1mRYZaTdfYXW75lUk5s3KLITHuo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(1590799018)(451199021)(91956017)(76116006)(41300700001)(478600001)(31696002)(86362001)(31686004)(316002)(71200400001)(64756008)(8676002)(66946007)(66556008)(4326008)(6916009)(66446008)(66476007)(1580799015)(8936002)(6486002)(5660300002)(38070700005)(2616005)(85182001)(186003)(36756003)(82960400001)(38100700002)(122000001)(26005)(6512007)(6506007)(83380400001)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEM0RkVWT3g1UVVlNW5HMWRrSEh3ZU9td1dQS1hwNmVSY0svWkQxcUR1NjlR?=
 =?utf-8?B?c1grRG83Rkl4UG5mbmpzclBYN2c3RTVDckdZYnF0d29aOHU5dmw2ZmliWTFG?=
 =?utf-8?B?NEJkT010cXcxblppYk9ZVHZiNG5RM1IreS8rNEwvd2FRTTZWK3ZZajRRUFJW?=
 =?utf-8?B?K3JnbEEvRm8rL0owV1UyNldISElqcEFOL0pQd0dHdysyMkRsVXB4L1RBZVpo?=
 =?utf-8?B?VjlWY2ZxbXkzcW5zL1VPdEpwb052cWdPQUpSZlVIbGVvUlJEY1A5YnV3TEVB?=
 =?utf-8?B?NWZadGxWditiVXE4Y0V1SXBiMEhPYktGNzRoUHM2bThRc3J2VFlrWU9iS2g3?=
 =?utf-8?B?Y1cxeGJ3RnRHdVBDd3MvelRHQUgzQlNJcm5jSS9UNzVwcklPM0FNTDJZaEZi?=
 =?utf-8?B?WXFRSnlyd0p1TkpBNkZuSi9OQmVMcGxmb1IySit5cG5vVE9qeWhsYmwrTXVm?=
 =?utf-8?B?UHp5T0VKYXVDU3JPZUhwdy9Nb25BVnpIMXlucE5hZVNHR2g1V3Q3R0krcE8x?=
 =?utf-8?B?eklSTFM5MDZiRG5PS3paaGE2elU0L3hlM0wvamFpMzJQYXNZZGV0STFyZXVz?=
 =?utf-8?B?Ukc2VlZES0Y3dzN2SnI1UWJyMEtWZkRQNFVXOVpSY3p3MDNmUGNnU0xuNTFR?=
 =?utf-8?B?bTRKZDJONEhWWGRlZ09wRFdmcnoxbmFiN2wydFovWEV4WGNUWVZpK3N6d1dy?=
 =?utf-8?B?cVczZlJFOG1BL2xpNE8wb3RmTSsvZkpQbHEyYTB4b1ZZSnlQWVdidFg4Y2Fj?=
 =?utf-8?B?OHdCTG5HenZOOXFnOE03VEhhUm5GcWtqQnBkNHZQdWNUWXBlalVGT1hCTmlK?=
 =?utf-8?B?b3cweWJNcDNBMFg5MXpjMGxSZlpiRU1ua3hmTTBSNmtqdTBlOXdzOXdwUVZp?=
 =?utf-8?B?ZEJyOWZyZm91T21SRUZnblBJV2UwdGlFeDRQdmxGN1BhcE9PWGQ0N2NYVkdk?=
 =?utf-8?B?amVlM3ZwcXFzMFUxYWh3dkd3Y3Vra2pSaUduelVnWElvZ3pWMTRKTDk4cWNJ?=
 =?utf-8?B?aXpWZ29OR3k3TlM5a0RSR0lFUmc1UGVNemhRMldKcFA4SFdqd0s4Zk1SeG1X?=
 =?utf-8?B?VytoeFM1SXZkWlFvOStHYndFakRzUjdwWjJ0S1FmeXBWRk1rMVFUR211WmhI?=
 =?utf-8?B?YTBKRVpQWmJ2WVhFUWhYSTZYb3RielU0RXRQT2dDTzFvQ0tuQlJuakZDQ0Vu?=
 =?utf-8?B?Z2lnTTl5T0poOUljUDBwTTBudTB4TFgwQUh5dnpZVE0wTUR0a1U1MEswOUlF?=
 =?utf-8?B?bmw1bmpNemZNYnVuWk1Ic21lUi93K1dsK3JDWlJ4RFFnWlRvL25PckY2eHgy?=
 =?utf-8?B?V3FJUTlkSkFtSndoNDRLM2Y5ZmFPNExZSGI4YlVxbFhHaTd4bk5CeWFVL2RQ?=
 =?utf-8?B?cWRuYkQ4SEovNE5acVVNOXcxbXQyeW1GcWZqbEd2UC8vQjd1SmFCbGtTeVUw?=
 =?utf-8?B?bVhHOWJKQVNhQ0xHaFFaWW56ZG1ac2FTY0pGTUpuYktvc1FzM0V5Uk5QRlJR?=
 =?utf-8?B?WHZiYXpyMzdwY0ZFWUZKY09SamNxdWdUQjg4RG5tb0xWRmVLUm4vMXcrSTRa?=
 =?utf-8?B?WGkzN0JIUUQyaThVOWU4T1lUUitqRkFVZlhEdmZwWFlmZFZnbkpwMTRwaGhz?=
 =?utf-8?B?a0NzSXViQUNhUURyckM2VDVwQ2FNZ0Z1d3RFdWM3a1hSQVEvbHRRcEVLNkZY?=
 =?utf-8?B?d3o2Mm5udHh1YmliVTBpbERkTDYwSnVVbzMrZTlEZU1yREl1ODlHcU5Wb0x3?=
 =?utf-8?B?NzdxaDhoVjgvRUFrRklCbWsrYnNhaDVpUW5NYWVtM3pFcUVrSTQ4dkptYURt?=
 =?utf-8?B?M01uNDlEcm5XRkw0SzNvQTlxb3RQK1ZVVW1ETjZLWGRnVnpnMEpaZ1A0UUZV?=
 =?utf-8?B?azJwb1lwR2xxbE92Mk9JVU5sV0k2V21xVmIyL29RWDNCZHBmR0N4RVhGQVdJ?=
 =?utf-8?B?NENzbmtrS3k3T3VQeExBK2dKeE9neUVBUC9tSlpwYVZxTlkwdnFQZmUrNGpN?=
 =?utf-8?B?dC9xUE9aTkJGbVZheVU0bXpCSHRPT0xhWkxXU3A0a3hkdTViT3dJbHJhVGto?=
 =?utf-8?B?c0Juem9PTW9FMDFvNnd5ai9KZi9Hb0JLQVo4TFYvTmZtNzdsZVhjUDNZVEtM?=
 =?utf-8?B?UFpxcTZGbm5zWjdSYUxzeWJoamZLOWk2YzBYMXEzdzdVQlRMV3phZVNWZ0Zs?=
 =?utf-8?B?bVE9PQ==?=
Content-ID: <37F76377640A624E83E3E60E245FBDF4@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NF0yHOrIOup3wuV36RdHt25lSXFey49FjtAzzdETafbwAasNHG5eFsNY+b1uUSxMWDU+3rWRmTbxuftfQPQJO7Gb8Q3zYXXONI651TviwgyvbX8+y2yZU/dMhNmQ5Gci1V+4QEyZFyoRBgUYwpzLpzIHYAU5tBIroQTpNtnoH/Kc1J6Tiqzklce2MkHSyrcJV/KQVUuuKf5tHhkEa7E1FVuEpUQWVssbl4nGKYjjcTg+5p3gqeCsuIzMoCNFXEogz938nsUivHUYK08S8cJ2MxfvhT4u9yZPjE4lL9A4gyZoQq+rbjN+FHZr3rAo++TdejEuX7d1icLLx2xP8tUJaf/95rKpF7qG8LJ83E47Ca5nerxbFBH8Vuqhp25i7e2LuYENg4FM36UwI6o8gl05K2z9Lni5v6rWohh1KRnkvxZ9+UGXgnvipfDCJbHrawWYfF0ftHI04UAjnp83YditevvwVHF9Rt4PQ4jG2wq5w69Mp398AhtwjtYR94mqZe8D9Wc+N9EAlmAXjA+8gTVinJKVnI2I6298vYfIAR51tKWfn9aIiFKbkJqfuCfbU11QBw1lRCXOrhMEo4hbBH7n2yVaLb3IiAAebMKuG+wyzXH6gwQVTHpMMKfNSeBvsiOcj/XD21TxocFk2Lvq1VF9HIUqthPIkTIOAhhJEYmjXXj3F+6X0jjdRbGKSVgTsnKgXFFqj04dwGnGXRCtbBKW28VhiPMZVKWwFLKGSLnnSal8Q+L8v67muzW5Smf1SIJ1cuhl/EQwH+dWqmcwEMiO/JIs/5eJHxyuW2nc3pwA/BM=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e976ca98-b4f7-4335-145b-08db3a5b0131
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:04:33.9340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZTQYX8XPyRwaMw/yBWTbvWEP4jx+U1TqE2+IeGef5ED5m9i3s8yhFMLdejY00o+IYYQBO7QHtjkgRUOuvlWDM63aFkqpHfpyhn5d6HSJyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10221
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fcntl06: Remove R_GETLK/R_SETLK test case
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

Hi Petr

> Hi Xu,
> 
>> linux never implement R_GETLK/R_SETLK facility, so this case
>> is useless.
> 
>> A twenty years old email[1] also mentioned that we should remove
>> this case but leave a bad gap number.
> 
>> R_GETLK/R_SETLK facility only exists in the IRIXones.
> 
>> IRIX says this pair of arguments are for use by NFS lockd and really
>> doesn't go into much detail.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
>> Fixes:#1029
>> [1]https://sourceforge.net/p/ltp/mailman/message/7574937/
> ...
>> --- a/testcases/kernel/syscalls/fcntl/fcntl06.c
>> +++ /dev/null
> ...
> 
> - #define F_RGETLK 10                /* kludge code */
> Kernel and glibc/musl does not define F_RGETLK (it's from here),
> and I haven't find find any flag with value 10 in libc include/fcntl.h).
> 
> Commit from 2003 4cf809678 ("*** empty log message ***")
> removed struct flock tl;, therefore it does not compile with
> -DLINUX_FILE_REGION_LOCK.
> With fixed code it shows fcntl() always return -1 and errno EINVAL.
> 
> => looks to be safe to remove the test.

Thanks for your check, merged!

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>> -#ifdef LINUX_FILE_REGION_LOCK
>> -	if (fcntl(fd, F_RGETLK, &tl) == -1) {
>> -		if (errno == EINVAL)
>> -			tst_brkm(TCONF, cleanup,
>> -				 "fcntl remote locking feature not implemented in "
>> -				 "the kernel");
>> -		else {
>> -			/*
>> -			 * FIXME (garrcoop): having it always pass on
>> -			 * non-EINVAL is a bad test.
>> -			 */
>> -			tst_resm(TPASS, "fcntl on file failed");
>> -		}
>> -	}
> ...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
