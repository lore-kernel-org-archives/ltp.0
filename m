Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566E3C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 06:00:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F41E13C92DC
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 07:00:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736973C2116
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 07:00:00 +0100 (CET)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CB20600AA2
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 06:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1641448800; x=1672984800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QJHWd2xA4WKq+9juWk4myTi0Pxo3z97mboemCtBKNYI=;
 b=oriVeKlwBZhimoowHWNEnFv/KqFoWbC6IgaYkP3MZYRf+oosV8GgZH8G
 8gj3wqzd81EWa9SfITl5OSX0dPC5PPy6rWu3RKsOroGu5hq3q8rqQlbMI
 MGFSofKW0KukZ0qBEziFbG+AKVEIVDRtUUOlILSjJ/jROOapwzczpqNh1
 4ojohhp4gkm/ZwaqL1juX582GcblfM/vOv7QWtMlLf82ckNCYDCjxdKmC
 1u4Enk5LAs4qX8T0K18K1cnfMmSLOYEHn6XG25ljPo4KdV5VSIv2PZA8T
 n4+16us+vBzae+uoZ3XX6/Wao+GxOKdsxXRuUoiDH9EZsLbiwdawcMGpO w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="47082295"
X-IronPort-AV: E=Sophos;i="5.88,266,1635174000"; d="scan'208";a="47082295"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2022 14:59:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i76LZowO2e7U4AVWpi2idYCR+mK7QMD+wwWlmYRkhmyAbC0RQVOqzZU8a6VRiW6VboVxcyu7Yt+gw5IFda/Z7+zUdX4zrC211nT9GWhq2RoWzP4kvllEhAV8+R3ZR+jPeUfgCzyGa4xX1wkmkOHwfLymNMFQWictQWIZ1ffP9gHDe0EIo/dnN5vIS0Maw4dTGjg2db8Rk6qTDzt4uu8MvrIYsNe7VZV5Wgf661e8Z4p2P/8OO+qupwR6jtSGNHcIlRNnpxmq19QBddOKO5C7gn5gxazgP/f+p+9sQDpmkdyyl+CIstN5SdNHDGhyfHTQN0vxQKByYEjTSloYJTB88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJHWd2xA4WKq+9juWk4myTi0Pxo3z97mboemCtBKNYI=;
 b=Op09Erx2jJ2Hv4C4d6YWZ8YjCnfZyujlACB4jiBwgfNciBmouGtPx+BqPQWL89ox0CQyWtbgJ4UJxrqUNbLkhznN0eIxAFZe4GYZ9FoAjSU8Kw6eHELA6otFiPNFhx6jkQZpn1iwB1Xn226TbhEGufQcvMbLa8cd8xSsHgUZxsKvy2iWfzWzJfa0AG9VsO3XBOEIVbiyaUdI0dpHfavGYa362MiiZHx7VIonkg/LaSu9z37UQnZDqGYG+vKWEcfoF5ngCBUipSfgUf1aaCVvPVCWpFYAfroYSMrl+xviFaW7cBIkSlCrMtuQln4QijjGb/eLM0snAEvH4HfuRGTniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJHWd2xA4WKq+9juWk4myTi0Pxo3z97mboemCtBKNYI=;
 b=o0cdVYMlKqHHRp25cYy0KhVZOWLyZ0oUSg24cwwvvpJha8CFrjBjtFHL86dmYdCtlikHeq2gfw+0tvrapSXU1nqOvZ744ZlegBsr1rzEBH8SvbVvN5nca8vBNAHqQTUwbHNayYynG5wjnA6VCmkrGrDX9pzyXYDDq8F5Znj0m5o=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYAPR01MB2943.jpnprd01.prod.outlook.com (2603:1096:404:80::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 05:59:51 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::9486:fa6e:4ac9:802b%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 05:59:51 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
Thread-Index: AQHYAThOqIvUm+MPjk2RIXi6fN05TaxSs0UAgAFSgYCAAHpoAIABAs2A
Date: Thu, 6 Jan 2022 05:59:51 +0000
Message-ID: <61D6857F.9060802@fujitsu.com>
References: <1641279439-2421-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641279439-2421-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdQpwpbyGGNKx84z@pevik> <61D545B7.7020003@fujitsu.com>
 <YdWsZpTjnBLszubC@pevik>
In-Reply-To: <YdWsZpTjnBLszubC@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37c686dd-db27-49df-e25f-08d9d0d9c147
x-ms-traffictypediagnostic: TYAPR01MB2943:EE_
x-microsoft-antispam-prvs: <TYAPR01MB2943565643DD25A058B65174FD4C9@TYAPR01MB2943.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiNhxqYBGmU59ujEoOK0IdpN+BidRP4ae69R2AvUUXPBKD2lsflpFVKN+cm6+XKabRmEMxx9/LyMVWX8JOa4Y5/O+U6pikKFffErlJLWcPe32X42/2kxaCKjVBA5Xhfj/H80qtl40EG2u/SC87G4vGair5Ua+gZFrSaQxhAmaC2yPcSQut9TQVIHHU4Wb1EjQZ0TxI9Zq1LlH+CRKWPpPQUydrkh9s1RLviFay5lj9JDGZLifddSbjYnoXSCvt64b53nm6AJgNxRyTCdK89n0Nrr5GlTXYRHbHGZ0T7P/izTJaAnqSklSPwKHWscDoxX/mHDWmoN52usienQK46P1YOZiaSEAkqGDcjHJKGLsMTzM2QGAPUuHmetwrQnexqY2nY203RgZ6xpEBXYnH3pgwBb/Y/VqaZ38ozWzDAk2zmhC4qMb8zetRNKm0ZQWayieRGg3Bou5IRnaxJNjbxc+j/07a+OjSpcQd5Ouml5dFPaqFz0AB6jUUXi2rCb3QY2cAmbw7lok2ymDQS9j7+mkndFP8ZaE41ldHaubKdTI27abXylfeaZwKJzF1j7lxK8zGyxakgIExOrDc6V/Ddekmt1jOSs343w/senDJENQ0lrcbPtKg0wp0gvc5r+zEu3pnSLAlNpPCNpKyZrolJHWNX9nCFcm9QXCb6JcDCB2rQwaCJ/5SjeNxOlGRzy8gw8Aa4HisH3Qf2O0Pouyv2nEObilX4i1bh4Tb84WJJdxaeqiqTMSVs90fpVN31CMxVbNeYoi1GNRYpTLkC7VqiSt95i067abTzpvd4ykmz5/Qs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(5660300002)(38100700002)(8676002)(8936002)(508600001)(2616005)(66946007)(66476007)(186003)(4326008)(66446008)(66556008)(64756008)(85182001)(86362001)(54906003)(87266011)(38070700005)(33656002)(36756003)(6916009)(966005)(71200400001)(2906002)(26005)(316002)(91956017)(6506007)(76116006)(122000001)(6486002)(82960400001)(6512007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eEh2SHFVaUJsOVFDcG5iUVZkajNNMmFFb1FMSWtuc1pDZm0wTGgvd0lWajdx?=
 =?gb2312?B?QVVaWDhXMVZudU50MUpwdTZydXpzdU5aUzRVWnY0VE1SWmV3T3B4SVJpTnJY?=
 =?gb2312?B?YVVGZXZXN0h2SFFFcUFpZjBCRW1NKyt1RnlsRkhvYnZxMEZpQW9XNWc2bkZQ?=
 =?gb2312?B?cVV3VXN2cUo2d0NML01oanZkeVRBYmRwQlRPU1ZIbjZRY29KV041L2Mwbjkx?=
 =?gb2312?B?NVJSYXYwNFZicFlYV1dLTFc1L1lNdytVdDRGRkdoZUlMemtBeGRISVRuU3Vv?=
 =?gb2312?B?ZEpiOFo0OWZrRHQwMVlrQUJZTk9KRm1tQnRVejhYVU9kMWdpT09oWlljUU5z?=
 =?gb2312?B?WVJ0ZFpNbXZ6d3gycUNmeWtjWm5uWjAreGJKY0lObUk2N3FZcnhGdDQ0QzdV?=
 =?gb2312?B?MVFhTXRYTk0zaDE0QXptY0krcllJaTFIaTVTQUVNcUg2UXl4dVNPNWdCMlVv?=
 =?gb2312?B?eDh3c1RoQnF3aFUzNlRoZ0pPNzFkNlJyMmEyaGZPeS9iUm9JTDYvb3FqbzZU?=
 =?gb2312?B?V3FpS3dqL2xRaEhucXNPU1JuLzQ2UWVIWVhUWnYwMUJjVDl4cVRKOWwxWnFj?=
 =?gb2312?B?ZllrWDB4amNwM0puVnRuTTQxUkFuTVNyY2FZdHBaU2doU1FuU3UvQ2tpcVdm?=
 =?gb2312?B?YmpRTS9oZnBpRFcyWGZXamV1aFlPbmsweC83NTQ2djBvRnF3dnhUVS9VN1pH?=
 =?gb2312?B?V2VSSHRhcENhWjc5djU2K3RvMUVJcDh6MFM3cnBsQTBNOE5SM0hzQkVHWHBW?=
 =?gb2312?B?TVVkQjAvUzBNS1dNdTIwTm9NNEVIU1BpSUE4bHlxditadndLYWg3c0xOUUhC?=
 =?gb2312?B?endCdEVsbUtLQ0lJNE1seGFPTHlBb3pUNUlTakl6dzNWVHlOc2lqMmdDWjha?=
 =?gb2312?B?TGpIU2krOGoxQy9GWStIbTZZdWFaa2NMUkZUd1FtK1NDMmlhNUZFNzlaU3Ju?=
 =?gb2312?B?NFM5Z1RFbFlIbzRYWkt6bmY0UTFTZkMxcDU3SUY2Rmh0WUo5eU0rZXNmS0Z0?=
 =?gb2312?B?ZEMzWklKWW1RM0hlK2ppNmxkcjNNMFlDcS8vK0ZUVjUvd1BLdHdaVmZJUzJk?=
 =?gb2312?B?STZBdmtXY1NPdllPY1dpWUIrcmFNSmZTWHRTaEYwT1RrOVpJSFkvZzk4Mk52?=
 =?gb2312?B?cGN4d2Z0enhWSlVXNDdjV3pLbDFvbnJmWmxpTWZsU3FyWHZrR2lQNU9ESGs2?=
 =?gb2312?B?VVI5UEErc2dKV0RBbDhFRlowVXAveEVkcWtxN2N4WGRNek9teHNkQ1IxQ3dp?=
 =?gb2312?B?MXdKYnNETEVJWjJXVTVmWW13Nno2bHZmcnRSaTJpU2pjSGx2RWJ0RkdvZFFy?=
 =?gb2312?B?K2lqOUczYXZnYmx4cmJPOTZsSHdsY2JTMG10ZWVlWWlTcjhaamUxWlBTR0hZ?=
 =?gb2312?B?clIrOUJKY0JjS3NZVk5KZEVpOWZ6dDBrdkZHOVBCKzNjckVZZ2RucGZvR3BS?=
 =?gb2312?B?Uk5TUERDL0xBeWIrRWVDczhlRUgreDhzdmVubkl4QytEbms5SENmd2RzTUZz?=
 =?gb2312?B?T3ZxSUR0bmVQMlpMMkQ0S2EzMkFpQzI3OGJRWDNJQmo5U0pmSlc0ZWM5aXVF?=
 =?gb2312?B?bmRGMmpFVXNyL1g4UUlQSzE1TmRMWVcra2NwK085ekx3QTJJR0tHTGlWUHda?=
 =?gb2312?B?YmVjeHBTRlF5QzFERWZMdUJQYTkzenU1WU9OZU5Fd0VsaHRDMkhRZWVOSjU5?=
 =?gb2312?B?MnJkcVp6WC9DNjlNdW5rbzVhQnJFbU51T1lXSmN5RzkwL0FlVWlhQkxRT1Fy?=
 =?gb2312?B?cjFhZVgwL0s1VVUvVXkzem92UitEYnRMOHFXbDZpSFROVWlWQ3hjcSsvYncy?=
 =?gb2312?B?UzNqZUQ3TER3RUFTMnJDaUtHenlkQTRFK0dZNUtVdGhRQzA5STBvY1J3RXBs?=
 =?gb2312?B?WXRRRG05SDhaSTQ0WU9vTG4xZzFRTld1bUhrZUsrODVUcDIvWUxOYUJ5TmNS?=
 =?gb2312?B?WVJ0YVlMbjM3cjRiby9uMEJGbHhna3FKdmZwREtSTVAxMHdZYm1wUTkxeTRD?=
 =?gb2312?B?d3BDM0JxRyttc1M5MVdWMVdWTDYxd3RrNEFrdHpUajhZNytBUzNTSHR4aUZj?=
 =?gb2312?B?eWFNbzE1WDB5NHJIMDUva3l1ZzMraHcvU1ZQNmZ6eXhoUWFsZnc5TGp5RFN3?=
 =?gb2312?B?Qm90dDE5S241VHhPdmVGRFRFNW5HT1JxZG54akFEQ1pLZ2J0WTZNWHR1Ykww?=
 =?gb2312?B?R2VVajhJOTlkN1BGbjRhdmJFMkg1Y2tQKzJHNDdMaHpNQkdmcHUreVpHYVQx?=
 =?gb2312?Q?CVvqsm1U+z04FkQ7CqWGVqbNtgSGVkqfNpf4kwL56I=3D?=
Content-ID: <5A5F5F607252CC4A93DDDB72564E681B@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c686dd-db27-49df-e25f-08d9d0d9c147
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 05:59:51.8049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkWRgrhk4OzyXUp5MGeB3EU0WRR90ViVqhtGPeLElO0/joQOyB8Pc9F2Rq1Y8gwS7u1DzOiVZ2byacONUX2EsUo4+hl5wIeNY6Pd88CLoZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2943
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] shell: add kconfig parse api
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
>>>> +'$TST_NEEDS_KCONFIGS'.
>>>> +Optional '$TST_NEEDS_KCONFIG_IFS' is used for splitting, default value is comma.
>>>> +Optional '$TST_TCONF_IF_KCONFIG' is used for deciding how to exit the test if kernel
>>>> +.config doesn't meet test's requirement, default value is 1(TCONF). Otherwise, just
>>> I wonder if we need TST_TCONF_IF_KCONFIG functionality in the test or if it's an
>>> user request (i.e. user like variable LTP_TCONF_IF_KCONFIG doc/user-guide.txt).
>>> Because I'm not sure whether test would need it, but I can imagine user want to
>>> have test running even kernel config is not available (e.g. embedded platforms).
>>> Or maybe we need both user variable and test variable.
>> Oh, I misunderstand the usage.
>
>> I should use TST_TCONF_IF_KCONFIG for non-found kconfig file instead of
>> non-found kconfig list.
>
>> I think one variable is enough.
>
> OK, but I'd like to know others' opinion what's needed.
> Cyril, Li?
>
>>> Also not sure about TST_TCONF_IF_KCONFIG name, IMHO "IF" should be replaced to
>>> something which describes what it does.
>> Thinking a good name isn't a easy thing.
>
>> how about TCONF_IF_NO_KCONFIG?
>
> Well, I was not sure about "IF" part. For use in test code it should have "TST_"
> prefix, for users to set it should have "LTP_" prefix.
When I write this v2 patch, I think we may introuce a 
LTP_KCONFIG_DISABLE macro that can disable kconfig parser function whole 
for the situation that some embedded platforms doesn't have config. So 
we don't need to distinguish whether kconfig file doesn't exist or perms 
leak or invalid config expression.

code may below
static int tst_kconfig_disable()
{
         static int check;

         if (check)
                 return check - 1;

         char *env = getenv("LTP_KCONFIG_DISABLE");

         if (env) {
                 if (!strcmp(env, "n") || !strcmp(env, "0"))
                         check = 1;
                 if (!strcmp(env, "y") || !strcmp(env, "1"))
                         check = 2;
                 return check - 1;
         }

         check = 1;
         return 0;
}

...
int tst_kconfig_check(const char *const kconfigs[])
{
         size_t expr_cnt = array_len(kconfigs);
         struct tst_expr *exprs[expr_cnt];
         unsigned int i, var_cnt;
         int ret = 0;

	if (tst_kconfig_disable())
		return 0
	...
}

Also, this macro is easy to understand and we don't need macro ie 
CONF_IF_NO_KCONFIG or TWARN_NO_IF_KCONFIG. Any idea?

Best Regards
Yang Xu
>
>>> Also this patchset is about syncing C API functionality with shell API. But you
>>> introduce TST_TCONF_IF_KCONFIG only for shell. Shouldn't it be functionality for
>>> both parts?
>> Yes, code maybe as below:
>
>> void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
>> +static char kconfig_flag;
>> +
>> +int tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
>>    {
>>           char line[128];
>>           unsigned int vars_found = 0;
>> +       const char *flag = getenv("TWARN_IF_NO_KCONFIG");
>> +
>> +       if (flag&&  !strcmp(flag,"y"))
>> +               kconfig_flag = 'y';
>
>>           FILE *fp = open_kconfig();
>> -       if (!fp)
>> +       if (!fp) {
>> +               if (kconfig_flag == 'y') {
>> +                       tst_res(TWARN, "Cannot parse kernel .config");
>> +                       return 1;
>> +               }
>>                   tst_brk(TBROK, "Cannot parse kernel .config");
>> -
>> +       }
>>           while (fgets(line, sizeof(line), fp)) {
>>                   if (kconfig_parse_line(line, vars, vars_len))
>>                           vars_found++;
>> @@ -198,6 +210,7 @@ void tst_kconfig_read(struct tst_kconfig_var vars[],
>> size_t vars_len)
>
>>    exit:
>>           close_kconfig(fp);
>> +       return 0;
>>    }
>
> Sure, once we agree what should be implemented.
>
>>    static size_t array_len(const char *const kconfigs[])
>> @@ -504,7 +517,9 @@ int tst_kconfig_check(const char *const kconfigs[])
>
>>           var_cnt = populate_vars(exprs, expr_cnt, vars);
>
>> -       tst_kconfig_read(vars, var_cnt);
>> +       ret = tst_kconfig_read(vars, var_cnt);
>> +       if (ret)
>> +               return kconfig_flag == 'y' ? 0 : 1;
>
>
>
>
>>> More notes about this variable also below.
>
>>> BTW github actions have probably kernel config on expected place, which means
>>> that most of the new tests TCONF, but tst_check_kconfig05.sh TFAIL.
>> I guess we can export the  KCONFIG_PATH to solve this problem. But I
>> don't know the expected place on github actions.
>
> Sure, for github we can find config place.
> But this can happen to user who runs the test. IMHO test should not fail if
> user's system is without config. That's why I'd like to have a variable making
> errors non-fatal.
>
>>> tst_rhost_run 1 TCONF: veth(null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.dep does not exist or not a file
>>> 320
>>> (null)      0  TWARN  :  /__w/ltp/ltp/lib/tst_kernel.c:110: expected file /lib/modules/5.11.0-1022-azure/modules.builtin does not exist or not a file driver not available
>
>>>> +use TWRAN and continue to run test.
>>>> +
>>>> +Now, we support the length of kconfig list is 10.
>>> Why 10? Cyril suggested that in PR, where he suggested to use separated
>>> variables:
>>> https://github.com/linux-test-project/ltp/issues/891#issuecomment-989712350
>
>>> But for string used like array there is no performance limitation, thus I'd use
>>> something like 50 or 100. Because for certain IMA tests there are at least 6
>>> kconfig requirements, thus>   10 could be hit.
>> If case needs more than 10 kconfigs, we can use&  ie
>> "CONFIG_EX4_FS&  CONFIG_XFS_FS&  CONFIG_QUOTAL_FS, CONFIG_PROC_FS..."
> Sure. I just meant there is no reason to put low number and then workaround it.
>
>>>> --- a/testcases/lib/tst_test.sh
>>>> +	tst_check_kconfigs $kconfig1 $kconfig2 $kconfig3 $kconfig4 $kconfig5 $kconfig6\
>>>> +			$kconfig7 $kconfig8 $kconfig9 $kconfig10
>>>> +	if [ $? -ne 0 ]; then
>>>> +		if [ $TST_TCONF_IF_KCONFIG -eq 1 ]; then
>>>> +			tst_brk TCONF "kconfig not available"
>
>>>> +		else
>>>> +			tst_res TWARN "kconfig not available"
>>> This is quite strong: either test "fails" due TWARN non-zero exit code or it's
>>> skipped. I'd prefer to have user variable for systems which are properly
>>> configured (user will make sure all kconfig options are set), but it's just
>>> missing kconfig due system configuration.
>> I plan to fix the variable usage for non-found kconfig path/file instead
>> of kconfig list.
>
>> Best Regards
>> Yang Xu
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
