Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA9C636CC
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 03:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50CF03CD0B6
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 04:25:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB65B3CB13B
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 04:25:28 +0100 (CET)
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com
 [216.71.158.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE89F10006CE
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 04:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1675913129; x=1707449129;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CrfKR2gO4xyJwB2WenYeo3Bi2c7fFob1524TzvQtBvE=;
 b=fxbS1bxx/CrUa6hl2A7r5mJFcd8zwV9ucPYu9FHSsFLH8mToe5O65EFL
 QCGeucPyAUQfYKDmhfxwDIFwgCT5AAP8ui6GJ9z0WFwb/OcqTBiMhC8yT
 VBGmBCkzOFnunHPdan3jTeLcIv7LzIEf9uQ7ET+WOeq2dq0vkL4tioh17
 eZijy3+MENz45eCtM1uTgrj420VyenHtiIz6fdeTT1vREHpFCPooE4dMA
 SpmxgSd5tjU8yB0TX5da311mjbNsTztOR8pgIXgLx0mOjX21RZ8NpDM9a
 /LoxKYAD+t3WyTcOBifoi+3vpBWmPXo17dOAOdMbFP3tRLAEYrFzBZFf+ w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="76444317"
X-IronPort-AV: E=Sophos;i="5.97,281,1669042800"; d="scan'208";a="76444317"
Received: from mail-sgaapc01lp2112.outbound.protection.outlook.com (HELO
 APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.26.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2023 12:25:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7TSkW0gyMPoYd42iKoHwYlhdb08VfIZLmdH+9mRysbq1cBGfQ73IuBmQWClMPE8YTf1i/OGKQCtKx1Wn5HzrTQFMXhjM2Tidug0MhdvWV1VKETdPIV62Vsx9Z7HrM2n6rEuqxpkU0ozBvM81equA6b6+t8GKXzD7wM6dvf30ueMRMpzSzvb7u9ymcojqM9Hi5T/BEl/rE7fRnKls+ACx1MDS01R1I8VVxmHY6NZCkTUkPBK54Rr3l+/4a5sQvgQSsVQtHH2jva7uG/EGbxZScIgldxPnIXFq4fkiNin6TQvwEDRnTo210kDvOdIl4Me2VfDW3kKwAtnnnjYhiC1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrfKR2gO4xyJwB2WenYeo3Bi2c7fFob1524TzvQtBvE=;
 b=M2pYUhy7KSn+HBdJ0p+IkcwU3FHuzNQ83s17D0qQHwWDTyimDdh72WfeBgQyYw5SCpMiMHbiVGS8kzVueX3sx3D/b7FgL2fd4BuhB7iIqTvVtX1KsapDtwV1+kivMkDbPeA1idubKEilRrH4WTId+w0wvSfOBAYsCgtxiy9LRYblHYdpa0Ougs2ZaLsT7A5KY5GWr6MtgyRBavY3EbIjgyqv3Zgv+oRCNoJakpsBop3IucrPhqNEVxOcfzhr+agj9sekqV3U7gdDeQxGwt+6/mKdeM8FdDZg/HFNxQU5Brb7qqfcmhx5pcmMeSwygyZNRfQONlyhD7v7+HGPJpvupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com (2603:1096:400:166::9)
 by OS0PR01MB5937.jpnprd01.prod.outlook.com (2603:1096:604:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 03:25:21 +0000
Received: from TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad]) by TYWPR01MB8313.jpnprd01.prod.outlook.com
 ([fe80::f3af:c36e:e093:fbad%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 03:25:21 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1] syscalls/mount07: Add new test case for
 MS_NOSYMFOLLOW
Thread-Index: AQHZNVRHGtIC8KAzh0SlNuoVjUGwxa7D1L6AgAIs3wA=
Date: Thu, 9 Feb 2023 03:25:21 +0000
Message-ID: <afa911b9-b862-d644-a276-ea3f15c96398@fujitsu.com>
References: <1675156318-14860-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y+KUfW2BYCddeZcY@pevik>
In-Reply-To: <Y+KUfW2BYCddeZcY@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8313:EE_|OS0PR01MB5937:EE_
x-ms-office365-filtering-correlation-id: 9fd8e70d-b419-4dec-8f0b-08db0a4d46aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVyWsLg0QjBH0sYpXqCnjykBbUnGtRNseQHEbk5Ja/GWXGoIqT54vgi1bDqYpyMki/knRaYa5Cc7HQWmkmFlQjmgdNhpYvZdiF4K4wxE/3jt71g3P/ktDuESOc7gy7dMaJZ5u+dzKQoxFSyzcTHhN1e8dargTfoKwKojIUnxtg6ox+Vq8tnWcpb4ppMQptUF9Vpla2CU5sA9BPeYhsYGW9gc1fNVOxR4eDvqSy8sGXEIVtALEjgndW+SKnThXhbBZo0ZQxZiXHpgGi5i2r+/pdCtoUFC6pkHn79GhIFuNNf5aUzJH58W+J9EZcdkTxQt0Jmo6e1fFj8lIJaKtbqdU6qC7z3rTjZSzrzF879vbDOhsf2OprKfRb3xe7GiZgIgvTuQYlVRdrIicxMY6btQJ19HK6c3ME9bNZc/6nerHXbJTUZ80bTFtgFNX4ZqbbyWO80d2coECU5DuW4JUN4+zeprSHeZWZcryppXSvogOiUnVoOca3M1plGXGoYhVdEi/yur9O55ZAx3pqzESyvEx4urCpt7NkWXlsEM9q4VvEzlr0xtaVl6S2D41JE/yuPf7oZECIp+7gYup95qk0oKspeBp6zWgp7mxEQRFfQQL+GlfSy8xaA5VsJCbX1tOdKcEdO5UQn6S+E+e2wobMBsEJ+gG0QW6yYIog3g78PhHRMHlBLwXsxmZUqm8SnzD+apOdOwby/C4ROJMJTGNLzSJgqR1hgMAkk4ndIF5CncV26A5BzY7v2KtK7EK8HWWcgn0balKSM9gjGNnDIHQqXqjKPWVxDIlPedXk5u2nYpCIo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB8313.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(1590799015)(36756003)(85182001)(41300700001)(2906002)(6916009)(71200400001)(122000001)(38100700002)(38070700005)(6486002)(26005)(2616005)(478600001)(6506007)(4326008)(186003)(66476007)(6512007)(66446008)(66556008)(66946007)(64756008)(76116006)(8676002)(86362001)(316002)(91956017)(82960400001)(31696002)(5660300002)(4744005)(31686004)(8936002)(1580799012)(45980500001)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckg0M0JvRVlQd1VZenRIYkhlOHlqb1MwNE1xZ2xRNmtSV0F3ZWFETzVZeTk0?=
 =?utf-8?B?S1lCelNNUTY3UDlsZHJac3oxUEJuby9lUjR5cXlFRXoyQWsyUTR3QmsyVEky?=
 =?utf-8?B?M0d0K3AxMlRQVm1jMUlCeHp6dXU1WUdZa2EwN0lMVUU2TnpJd0p1Ly9KZ1BD?=
 =?utf-8?B?Zk11eVE2SUtFMFllcjVzeVh5ektpR241Zy9zS1d2TkJoZERXeEZDZllTRDh1?=
 =?utf-8?B?VllsaDZINHFidnU3NHVkT1hpNm1mcjIzNmdwMFNYQWZCWE5YdDZKVTkzNi9H?=
 =?utf-8?B?NmkvazZhTE1jSW5Hb2NoQXlZVHNMNmpsbHZUYXhpRWNVZERLenByekVDTjU2?=
 =?utf-8?B?YlMwYjZkSFc5V25RZ2JUUllnSXMrcXBhMEhNNUkrclZOczcwN0VLRVAyMmUy?=
 =?utf-8?B?OTRLRzdCZFF0REdKaGhlTU1CRTVaYUNGS1R5bEVqYzJjN1gxa0VOYThUVHpZ?=
 =?utf-8?B?UDV4QWRBdGhZb28vaXBZU1FPNVZpWnJVSXd0UzRIZUErSllSNXM0d2lNV3FZ?=
 =?utf-8?B?VW51c2diZFlZUitDU04zU25tTndPQWxmN2lGZlNZckEzUC9GUHZtUFRzOVor?=
 =?utf-8?B?dTdwREZiTUxlbWtzRnBKUzZibTVuYm9obnRyQi9wTzlLVGN2YW1nYXhFbXpC?=
 =?utf-8?B?aVhqNm9PTm8zUUNnamdrRENrNlZJY2FVaFpSVjh6R1ZEbE9QTGdPTmZQYVUz?=
 =?utf-8?B?UGNkSGZRSEpERHExOHRyRWFCSCtZTG9BQng1ZDMyY05VeGZ4Q2pTdXZTaGhH?=
 =?utf-8?B?N2xIT1poY2ZNTzkzL2dEd0s5RHRDYllpdWxVVjlIRFg0Skd5MEovMGdxT3lv?=
 =?utf-8?B?eGZCdG8zdEtJcTJweE1SUXE5MU9oVjJ4TVdYUFRVdXZCbDBkRCt2TUxOYVg4?=
 =?utf-8?B?bWtOSW9GWDgrcUR6YTErbGtxRS9jTlhSSWRjeTlpUzhvSTkwTm52QUlBcGVR?=
 =?utf-8?B?bFVJYUhwb2g5NGZmT2hkVWxnOEFyUWVmZFFXNUhISGNVL09vcG5DR3FHMU5t?=
 =?utf-8?B?UkkwcVZrcmJ5YnNRcFJDU1VWYlI0ZHJ5Q1ZUZzI4YU41TjFpR0RsSTBUWERw?=
 =?utf-8?B?dWh4WVNMOEZ3NDB0a0dEM1cwdlRLYTJDbDlXMDIyNXFybzVqKzhmOXoxcjNo?=
 =?utf-8?B?SmJySWs0WU8vbGJSUWU2RzhlbUluTitnNlI5VVpYd2d3SHEwdXdlbFAwTXBO?=
 =?utf-8?B?NWcyZjcySDRoSXl2Sjl1Vmg5bnN3a1kvU3R1NHlNYnZTd1JJL0pwUVM2aGFJ?=
 =?utf-8?B?c0hGdDkxY0xNQ1VpRysvR3VFZmhCMWZNZjBoZ095Kzg4ZzhnNmN3VjVYTHNO?=
 =?utf-8?B?NCtsMVo3Wk5mTzNZY1Q5U2hVMEJ4bkNQRUt2eEZ5RHdWQ1o4TjBhWmtYdy94?=
 =?utf-8?B?eDhObGlNdWVpK1c2ME03MUErU1d1VHo2d2ordllic1JBT2J3R1V0c1hlVk5E?=
 =?utf-8?B?cWFjbVFuM3VsOVN3TjFEUUpuQ1Irck5GS0JMd2MxNW1XZU9qNjl5MS9FWFZX?=
 =?utf-8?B?RE1sYThBMWtvUi94a0NxNWNaMnVueG5PM2t5WU9aWm94eTFyRW0zZG44dEcy?=
 =?utf-8?B?UTY1LzB3WkVBWGFTdE1oZytlY0pLNmFjQUQvYytqTDZxLzdsNzBHZW5OUjBW?=
 =?utf-8?B?cVIwRjE1Z2pOeHFieGF3WDc5YUNveU5Ba0ZpbzRRdXE1N1I5aHlLbGpLTFpU?=
 =?utf-8?B?NmsxMEtpU1lNZjNyN1IrQUJkeDNTM3FrbEE5RnZCekFpWEJIQ0JDVFFITzZz?=
 =?utf-8?B?bW9qRnhPN2FzeGhISDcxQXF3MWRvV1AzQ2FuRzFXV2VrelBrRm1XNlhtOWsv?=
 =?utf-8?B?djBNQnlVL3M4STBpcHBJaVJBMkhXNVJEcG82a0RrOC8wTWR4b3ROTElIM0NT?=
 =?utf-8?B?OWRYT2pvL281MWhXNEVNb3F1RlpXWUJ1NVYyZm9sVVpibHNDL0NBNFBrODFr?=
 =?utf-8?B?Y1VkOUF4RjZXTGVRLzJjMHVkano4Q1Iya0huakFRb2wwRkg4cTNwN0lldFVs?=
 =?utf-8?B?a0REblUwckFOa1l2MW9sQ2xSU05xVzErdnExV0pLMnc4TVowMW8ycnNsWUs4?=
 =?utf-8?B?d1kvZEJxb29TMzZCUEg5UXk3a0FsUHZsOWc2V3JGRlI5MXZnODF0UjNNUGRm?=
 =?utf-8?B?T29NcDJjSW54bUpUWmszYXBwZ0RwQnNKb0E4TjdrUU5JWGFxRVhGUVdROTZh?=
 =?utf-8?B?Vmc9PQ==?=
Content-ID: <120C8F118E9D9B4987494204E96DDBF8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OLbU1RieobqkKCQ1/CsTHLIVOb8ha/kDdafElq6pJhEucXRcDoJFWcnQyTRZSlTQVgF/l2i+qfqB7gHVbGozT8TaxF/6vBycDVxuDAqulN1nojwLh2OyKUrQiwZc4y/CA9L/fad2Cg+7l6MxDlGefTvy1uPHQTqxXt/JzrErQoumcQfJ+BQJYveHSoAQzLzNza7LZUmAjQvtYIcaq0K0/KoVZg9Qo+GowofSjuwkbNeDgzZuM/81rWdl3xjpkD9G+Ws1PdFVR0QJp3a6DgyjKd0t9Jwenx9YDJuDP5S7/2IawKIUurV2JKBx+quJ7zZKvX2XR2EkfXfrieJqcn+0t51zxg35PirRHyvjD8sSN2XOajFjiogzMouBTOEfBeEX2XA9of3VuqPzcdUaJbNCt8u9fcLIrQnmcRjd8aFJ61MWs8t2VfgXIzz8HyhFIe0B+Whco/WVdHCuBg0zCczFqgk73blwss+l5RijMTGJ6WVpEXXrahvKrMnov6z5ciqvEJMM5EVFnkr7pUInBD2aWIk+mJfwNfsbxCnWI5jaErmgijJpt+xx/cHzfzPp+39BCqk86DAKpZ0IO2VQjgE88Y8G7wGvtOeTu3atJX+P8aYpd0smffhPanLL6eCSOg6L1lEi0pYn52Lv4r6DbX2XlHxvR2ahTNnKDBNZA+gu1PbG4Vk2QqUYab40JMCI13IGCxGfcW/7j5k2X/tlvGElZtJZLoZC5M8ANLxtqBhAaXQSucCfbtMZh2DY3te9ftbrjgy5jBroe0fCJAZ2iE6pDZQcYZHmOqFahg/SIKn6fto=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8313.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd8e70d-b419-4dec-8f0b-08db0a4d46aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 03:25:21.7087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjZ9dEaXQniVfBW5W0KFGQDQVHX6k7TE1yfyiYuk+7cuE63wL3L8YsPG1d+wxOazkH7Ghwd7dHLg1VG6zt23MAMgtXGp9U8M2UqKJq/aU3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5937
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/mount07: Add new test case for
 MS_NOSYMFOLLOW
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
>> +static void test_statfs(bool nosymfollow)
>> +{
>> +	struct statfs buf;
>> +
>> +	SAFE_STATFS(MNTPOINT, &buf);
>> +	if (buf.f_flags & ST_NOSYMFOLLOW) {
>> +		tst_res(nosymfollow ? TPASS : TFAIL, "ST_NOSYMFOLLOW set on %s",
>> +				MNTPOINT);
>> +	} else {
>> +		tst_res(nosymfollow ? TFAIL : TPASS, "ST_NOSYMFOLLOW not set on %s",
>> +				MNTPOINT);
>> +	}
>> +}
> 
> I was thinking about this:
> 
> static void test_statfs(bool nosymfollow)
> {
> 	struct statfs buf;
> 	bool st_nosymfollow;
> 	int res;
> 
> 	SAFE_STATFS(MNTPOINT, &buf);
> 	st_nosymfollow = buf.f_flags & ST_NOSYMFOLLOW;
> 	res = !!st_nosymfollow == !!nosymfollow ? TPASS : TFAIL;
> 
> 	tst_res(res, "ST_NOSYMFOLLOW %sset on %s", st_nosymfollow ? "" : "not ",
> 		MNTPOINT);
> }
> but your version is much readable, thus forget the above.
> 
> LGTM, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your review, merged!

Best Regards
Yang Xu
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
