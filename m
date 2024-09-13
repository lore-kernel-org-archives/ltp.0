Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756F2EEE27A
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 04:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726200483; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nxVc/ID/MUP+OOQgF1CzSmTGN2qRdgdDeCJ0mdImW9c=;
 b=JOJuLu1Xuv+BptfEiyP3bLE7GEDVmJQ2qyRFYQuvc5A3CvJ0TVQiIhCgyEV9+6FkxdkyV
 a+wYUdDy8IKRXj6DHIhwpF4FN3L0bZJxBvgekZPuwkskl6okdUBuH6CigLV1bnO+5O8Lu5w
 tNEN7FetzxI8AUjtUFeb9hzuP+0Wl6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA6AE3C27AC
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 06:08:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE9243C1B8E
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 06:07:42 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.159.87;
 helo=esa7.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com
 [68.232.159.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7955A1000BDD
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 06:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1726200461; x=1757736461;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Yl48eYK5lWpSCToro0tDrUnLvyHxixllZvB0EwJvZwA=;
 b=vsZUX5O4GT4TeJmDRQFrKV+EICeA6tQApRHQBUSFlOjV3eLAUObViTx7
 SZ6A9Xax+sQt6L6rqj1XsrgWWkmqkxZwfThc5rfpm0U65AI5sviDJiYVI
 UB++o+4Rj355b7Kvk3kfyblQ+RX86lPmPuCMw+HhV5vK9I7ecnf0ixrLd
 DCRQHilJiFX4OEM+AjOG/yIrukeNZt2lrt22virVnUNQITtxz+zGPCFB2
 t+Au9PBuH6w6808D0O25Q+YATpXSP2aPy3G7tKaPLfPOg8sFSrVl1VoFg
 FBZw6TKW4OAQ7YB8TMyZtPa/BlZPUMBKWw3zQ4H8N6Xdly51QVEKtWZqx g==;
X-CSE-ConnectionGUID: AHpYVywKSIusuxSsieZkaw==
X-CSE-MsgGUID: NSvn7A5wQoKccZ1T7ouo/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="130641976"
X-IronPort-AV: E=Sophos;i="6.10,224,1719846000"; d="scan'208";a="130641976"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2024 13:07:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn+XiExhC0l74PajxsO2XWW5ahed6AekhQVp+1Svpdg5hC70ndyL+heE17G08jmm+gFUFGhcLuXhV/qQ172QGptGV0pLUcRmpbuZ0/x6bRhdTRaS/2cT7O31lnJ/p+Rc1KuopfLyIM9EDBkaisJWSFPPPUYg3I+GpgCJYjqAxfClwFVRVh4u8R9GlmNpr8H7qJcHXM8yHanPJo27bYBxeeIGHsR0XaUwGj42Z+u1PunwBj0prerhVN8kJ2i1ROBmEFXiRU/1R1zl/h76HmhtHI/cSG3ZsEONrJt5buos1iZduo50g3b0w/Ha2rqDYF0nSwgiHV7Slt+2nqdIHkW07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl48eYK5lWpSCToro0tDrUnLvyHxixllZvB0EwJvZwA=;
 b=y6/E2P0uJcyKStt81I8hgTSILIdZ8DJYfdxKLQbUgjVS+vkWLoe4BUxwGa4LYMnvhn20pO9dK+89J+OPF+u0lJ+vYwN9nC6I3lUfET8E4RxaxYfpOu+G9hzVKgmmVu+9Vk2qspTJWGBMYHZlDcBEQSh6j2331LGq/Z1OVuUHWAidoqVNHLcN9kdid+xsC/exs1e/CwEra2UtAjRsuAqngC9YZU+ZlXVjBQf9bZn46Lud2/EuHOhi7RSV7DZnvICs+l+0UfYkxxPWhDgoyZdBzK2kWRHdC1y2rc9s/uCS/bhV3ZBIZmu1le2fI9M/AMVzJGrva/bWi95nAhaoiqaGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by OS3PR01MB6070.jpnprd01.prod.outlook.com
 (2603:1096:604:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 04:07:34 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%6]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 04:07:34 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
Thread-Index: AQHbA2ZRm04n/jvQlESf9O3e/SgVLLJQzOqAgARLb6A=
Date: Fri, 13 Sep 2024 04:07:34 +0000
Message-ID: <TY3PR01MB12071A725A400AA4C08040DBFE8652@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240910094755.57438-1-maxj.fnst@fujitsu.com>
 <ZuAbaUHY8ZPjN5ey@yuki.lan>
In-Reply-To: <ZuAbaUHY8ZPjN5ey@yuki.lan>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NWIyNWJiMTQtOGYxYi00ZWUzLTlkNjEtMDJmNzMyOTQw?=
 =?utf-8?B?NzgyO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTEzVDA0OjAxOjI2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|OS3PR01MB6070:EE_
x-ms-office365-filtering-correlation-id: d2086707-07ac-4e8d-e79a-08dcd3a998d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?N0FhOEd3Zm93UVU5TzM0RGQ4VkZUUGZOc3pYTGZEaGJBN2NuWmdISU0raWJZ?=
 =?utf-8?B?NHFxWTNodFJzZ3hLNVdYQlpiTE9EWE1FRnBTSDlYZmZ1N1JhSHhSa0N3SnFM?=
 =?utf-8?B?NEc2OERjT0luVk9NZFZ2bFJnSy96K0JuTVJvcVVyQVJMaHdmVFplQmozcThP?=
 =?utf-8?B?YWV0bEI4SzNoa3hlU09UUEF3TnV0NFIvdk8wcS9nUm1kanZvaWJnckU1VmtN?=
 =?utf-8?B?WkNDUTJSeHNUSEVCNWFLdWpNTitmcmxyQ1NPL1ByU3ppc1lONm90dmI4cFBl?=
 =?utf-8?B?WHJCUk5YR2U1U0FlRmVodFlWWGJHOUkyZGtiK3lJOVVIQ3RPVU5zbjdYS0d3?=
 =?utf-8?B?a2ZHVXFsbjBLNWtsc1V0QklBM0NwUENIeW1FS2pVT2t3VEJ3bHVKUS9tdGpz?=
 =?utf-8?B?NnVHUXdMWXkySTdubjVEWmNVU3dEeXQ2eVJjUnEyeFpKMXBQdFVFRmo4cHJX?=
 =?utf-8?B?SEpqMjRPdm41eTdvQmhJZW9mZUdOSklodXNtM1JsRGJhenNKd2lubW9WU0VU?=
 =?utf-8?B?M3lpaXJuejlrdTBYWE41THJiWVFIRU1WcFUzUmFKSVdLNGFjTlJFaVkyWmt0?=
 =?utf-8?B?Z1J6TmVtTlgwajJMVmZaYTdrNTBhbzZvdkk5aW4yeXRlek5ibDU0b3VPWllL?=
 =?utf-8?B?MVdZdW1mWkZhdDlOdTdEa1hzWFJ4aEhXSnZZeFNTL2JOMVFVaUhOOGxqazE4?=
 =?utf-8?B?NHp5NW05UFYybUpDRGs1ZXlmZzlhWGhsaSszaW16ZC9hRWk4a2tpUFJaaWty?=
 =?utf-8?B?TTR0ckV3dlF5Zml2ZkM5VGhJandyVy8rZERodXFEVjNuYWdGaXhMYWhDK1Bp?=
 =?utf-8?B?MUR1SldPRGF6aEhmZEx4b294aW5OQ25IM1cwcG93NXVMV05zY3JvaHRoaEcv?=
 =?utf-8?B?ZnJHWU5uWXJNeEJhNmlGTmUxTC9rWHY0czVxbE0vUndzRHVGcUdudDFBODV3?=
 =?utf-8?B?c3p0RVpmblZIeU9aQnFHYmtiQlArZ0VPRlZRaSswNzJXNmZRZ0tpUE9vaHV4?=
 =?utf-8?B?R3BLMSs1Q3JLajRHclc5Z2hOOFdmekV6Q0VhUGtkVkluRWg1WEhHRUVPVU80?=
 =?utf-8?B?NHhwNE1HazhUSXl0aVhUUklUMHA4cjdlWGZpTTJ2NjZmMFNoNEp5OWI2VDU3?=
 =?utf-8?B?RWZTZXptS0NOaGtiNUt4YTRMTzA2MUxQQ3Y5K2tkaytLVVdZZ1Q4MTRqMkdU?=
 =?utf-8?B?OWtIazIwVUNueFRDMU1SOU1Gdk9Ea0lRY0Zxbk5Xdy9SNlRSeW1GYVR0WXRL?=
 =?utf-8?B?VTIvYU1oQ1NVVzVpcTVFRVVyV0M1V1JvNGl4UGs3a3JJVWFhcEoxc3J5dFFO?=
 =?utf-8?B?NmYrZGZWajhaYnN5d3I0d0NMcCsvenZpd0N1V3pNc2pPYTZjTXJaUVZpODBE?=
 =?utf-8?B?VEdJRnN1VnE0aVk3QUhQZXdlS0NwdTdhalkrcGhON0p5VlkzaDRnRVJva2Jv?=
 =?utf-8?B?T3psdkJaRmhETVUzeFVBS29wdEdTZUtwalhkaWQxWkFRNzRqbUxoWS9yRysv?=
 =?utf-8?B?OW10Wk5mb0pNNnNzY2tncUpyMmc4NHlOMFRkTnMydzFhdmY2WHNEMmtEbGh4?=
 =?utf-8?B?QWVLZFh4REpzZmhkMTBxbkJyWHU5YVhSUWdxRmp4dFlkU0RrbTRxR3NYWENm?=
 =?utf-8?B?U0JWemZ4SkFEdGQyY0JYZkM5bHlDbkU0dnRzRDhwdFc5aWxKWTF2dzZycjJQ?=
 =?utf-8?B?TWRjQVNISWF3SldyOGNFbXREbHpiV3NBVmxWNUNNcjhNc3Zwc3V0aC9TT2Mv?=
 =?utf-8?B?L3EwQW9ISkhMYVJVdjk3aGZPdGxJaCs3V2RaTk0rUUo5Sk5rZVljMk95b0V4?=
 =?utf-8?B?ZDJ5SmYvVFJiMEt5ZFJ2bmpNNmpsWTJiclQzdStrYUVYQzBiWnRSZ1g3Vzk1?=
 =?utf-8?Q?41goJrPhO5PWp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEZYWjM5M3ZaNUJHRllCSmV2eE1hdG8wVXRKc2tIUE5vNHNQZDg3OVJRcnRU?=
 =?utf-8?B?S0VrL0F3NWJXYWRKdGJHVStNd2VxQ1ZYMGF6MklDbHRjbTNHbXAzcEJLNngw?=
 =?utf-8?B?OWlkcjhUanBXUCttdld6em1FTGZjTkNKVU41bks1TGJGeEY1OU1RZGZRSkhE?=
 =?utf-8?B?dm95Wk1vclNQcFY0djFyT3EvaTN2YlA2Q2pDSkt4NVZMTitGMGplMWN6cHFF?=
 =?utf-8?B?c0ZYZ1lRTWEyTVd3UDNLMGo1TEFQK0xReFo4SEhSZEFSZ0lWajlvUGdzeDJP?=
 =?utf-8?B?YWFycExGd05KNDJuUy9rRVBrQW5GaksyZHl4Y2pJd21Yd1F6OGkvdGVlWGJM?=
 =?utf-8?B?NjFVY1FROGw3RnV1RjcyRnpsVlpRdjdlWEdHVW1WMnFqYlB1OTd6Y0VYb043?=
 =?utf-8?B?NFJBNnNYM3dQY1ZtQzVYZTJ5NVlROS9GYi9rRjFRSVVpT29sbE1DRExwS1F4?=
 =?utf-8?B?ZmhGQ05JMkZwR2tYQlA3dWpnZUlOTWFlWndEREFnWUhLbmhKYi9sZmRlSEFJ?=
 =?utf-8?B?Zkh1Q0lONG5mNHV6bGcySFhaeG5UK1hZTENhNGlTdldSQjBCeTlSdXNNWGpR?=
 =?utf-8?B?QjRuTjczM0xSbGRyRnJmWEtSQTZpWW1IVWRiWk9PMGhuK2QrOFo5ZjJWV01K?=
 =?utf-8?B?RmxDREJLWGxrK3FPdzh0aDkxVHFFRmppRXJ5ZHBjNkgrWmJJcmJHWW13Qm4y?=
 =?utf-8?B?cElMME5kMjFPZHkzbnRVSkIyaHI4TnN1MVBmTUlJT1g3VVBibnlkNy92eXo2?=
 =?utf-8?B?NG0xaUI3RzNlRU5lMGNIOGNYRnZvbDRRNXBpN2Z3VlJYM0MvV1hpeXpMUkVz?=
 =?utf-8?B?M2oxSFBtRS9TR1NWK2t1TCt1Y3lSTDhhQk5YWitPeWgreGZBMkVxSkhKK3VG?=
 =?utf-8?B?d25jN2FVTE53akcxaTJteXBxSTdYdGgzaWQ3S3BBLzQzZmI3WnNwMWFBK0Jn?=
 =?utf-8?B?ci9oVkF1M2Zua3NwekJnZE9QMkdDVDZyR0RHUEVWQVFuaEJWWDJ3OEp1MmJM?=
 =?utf-8?B?N3l3V0IzY3d5ZE9xSk1qT2ZPSWNwbjF3TU9aTWhPV1lFUDUzVDVwVUdZNUNC?=
 =?utf-8?B?R1pUMmU3VEUwRzRmdHMwRmkwOXhKQ1NFQ2xYTG9zcW9zVkpMcnVwWjZNUHIz?=
 =?utf-8?B?V21tN1Q2TlQ3VC9UcTFKMmRwdDBkTXZkRUQ1RFBPL3dDRWFXeFVNYjNiWmpT?=
 =?utf-8?B?dWFvSlhudFkrMFJMZUowOFJnYnpZSFN3aHlLcjdWMmlvY2VJTDNaNzVrUllX?=
 =?utf-8?B?QndMeVJyZXYyeDR0aWpsWks0TDFyeHZNa2NESk1hQjA0RmFxbHoyN1FMK3Bh?=
 =?utf-8?B?SmhUK21vYkhta0l5T0psSnJKeVZJL0g4eXJSU1NPMDF2K3VOdHhSZXlHT3VH?=
 =?utf-8?B?UUR1R29kdTEwS01aQjlqMFpiOGs5NlFoOUhPVzladEdTdTRlL1ZXQmtDMHJY?=
 =?utf-8?B?bXRRSnlDc1BzVkFWL1FKSFZvKzBTNzdoV1RjaFZjZUNwNzVDUEVCZy8rb3pE?=
 =?utf-8?B?V0xreGJ6L2tLQnp6NXdMZDZ6NXR4WnF2UlRnVSt4N09sOU1oVzFNS1RrVnhW?=
 =?utf-8?B?U1ZBdG1BZnZ2RFNSR3BEdHJyWjRhRkdKZXdtSkJvMUVYU1lyL015YzNWRnc5?=
 =?utf-8?B?UWg3TkpKMHpaOGlWdFEyVi8xRHpMWk1iV1RiT3NpelNXZDlvb04rMDh0dVF0?=
 =?utf-8?B?eUxqdEk3M3laa3A4WjJtL3dPc1l1V0tRUFdCQXZ3S2F5M3crcU1nLzhFOFFj?=
 =?utf-8?B?cklCL2VmSVJudlR6YzZEcVlXc0lUL0VOWDNLZE1yekxwR3hzdHNaTmpnMjF5?=
 =?utf-8?B?dk5oRmkra0ZpUnFtR1phZDA4VEx6NHFkVlhPM0VUeWxVVmRyTExzNTlIaHc4?=
 =?utf-8?B?b0lheXMzektVQ24rR3FVQW1US1U5QzRudnJnU2g2QjZ5THBnYkZJWFdEZ3Fx?=
 =?utf-8?B?MW0zS2laVlBaQnFHM2wvc1Y1NU45VXRRbHArMjVxdXBJNlZEWkpJVjhVbkRx?=
 =?utf-8?B?b0FGUENwZ2l6c0hSQzYzWU43WmJiUXl1RWtKem9TRVlYOFlnS2duUW1rOUpJ?=
 =?utf-8?B?RlVjT0dVWkZMUDJwaTEwZUxpKzY2NkpFYjFTODc1bWdFdFdaSU13UytsUUJ1?=
 =?utf-8?Q?Z8WUwtR4F6gfXSliBhYEAezvS?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mpozbjM5frINu1fgDCzNB4AEq9OvlB2BNW6FSrms77qGF8tpx++RcDrClhWM4Td3qj8aTaN8h6nxH0filuxzo/UuhOce2V5ZnIwvVtaGOqY3s1h1vApQpI/iSBMnr439EzNGgK/AUFnkhVZYpyjLrlT0eBFLe31/d7Hcjv56PBupvsbC56EYIb5f98l/lT7SR69Ft4MlzM5HWwj6yWFvE690AHLNIoqP+jjPKn96DHsZgfXb17YnEqLDMD3mRchQkVLUzOh616WO1+lxvp0hiAWyaDt2PN+i5ctiko0UK3woLltQSeGtfDEqXebhdYfx8byPveTZfDhw3ALkG9LbBj1Yrm/ADQyVGIU339P6WeKggTPx6Pdn034xgYTlo5wPAOur2pzsScuG4oFZqJuz/c1bKn6nGjlzQ9RipJqS14JaHdfggp9J3qM5DqbNv6ebanvh8SyfwhShVDWukU0xdRt+JpuhXBWZ8iQPnyMQcFcp/TY4P72+uA2ErDU9ubEBWXTjTGvuM2FTmxsnMia1Rs/LXhdJPfU3i+OVUkmJFDFzoObRWh7aT+dsvC3yQWD9MMpKHQ8POze0arpC/rFZHmSS5+/jliKeHOw9Pws+Y+zYEBoYhl3itqdIcxVCloCj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2086707-07ac-4e8d-e79a-08dcd3a998d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 04:07:34.6425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXZkMdpEUGRq4N9svCU/3WZAMEq6sD76mjlF/m7lnkx/eVQJaY850u4ZVpVjeKcARLDi9jMfajtLh7Zqw+UrFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6070
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 add _GNU_SOURCE define
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
From: "Xinjian Ma \(Fujitsu\) via ltp" <ltp@lists.linux.it>
Reply-To: "Xinjian Ma \(Fujitsu\)" <maxj.fnst@fujitsu.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwNCg0KPiBIaSENCj4gPiBUbyBnZXQgcmlkIG9mIGVycm9yICLigJhNQVBfQU5PTllN
T1VT4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzDQo+IGZ1bmN0aW9uKSINCj4gPiBv
biBzb21lIHN5c3RlbXMgKEZlZG9yYSAzNywgZXRjKS4NCj4gDQo+IFRoYXQgZG9lcyBub3Qgc291
bmQgcmlnaHQsIHRoZSBvcGVuIHBvc2l4IHRlc3RzdWl0ZSBtdXN0IG5vdCBkZXBlbmQgb24gYW55
dGhpbmcNCj4gR05VIHNwZWNpZmljLg0KDQpJIHNlZS4gVGhhbmtzLg0KQnV0IEkgdGVzdGVkIGJv
dGggb24gRmVkb3JhIGFuZCBVYnVudHUsIHRoZXkgcmVwb3J0ZWQgdGhlIHNhbWUgZXJyb3IgaWYg
dXNpbmcgdGhlIHBhcmFtcyAiIC1zdGQ9Yzk5IC1EX1BPU0lYX0NfU09VUkNFPTIwMDgwOUwgLURf
WE9QRU5fU09VUkNFPTcwMCIgZm9yIGdjYy4NCkhvdyBhYm91dCBtYW51YWxseSBkZWZpbmluZyBN
QVBfQU5PTllNT1VTIGxpa2UgYmVsb3c/DQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9z
aXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3RpbWVkd2FpdC8yLTEuYyBi
L3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3Nl
bV90aW1lZHdhaXQvMi0xLmMNCmluZGV4IDJlY2E4ZGZmNi4uODNkMTg5NGVjIDEwMDY0NA0KLS0t
IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMv
c2VtX3RpbWVkd2FpdC8yLTEuYw0KKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3RpbWVkd2FpdC8yLTEuYw0KQEAgLTI3LDYgKzI3
LDEwIEBADQogI2RlZmluZSBGVU5DVElPTiAic2VtX3RpbWVkd2FpdCINCiAjZGVmaW5lIEVSUk9S
X1BSRUZJWCAidW5leHBlY3RlZCBlcnJvcjogIiBGVU5DVElPTiAiICIgVEVTVCAiOiAiDQoNCisj
aWZuZGVmIE1BUF9BTk9OWU1PVVMNCisjZGVmaW5lIE1BUF9BTk9OWU1PVVMgMHgyMA0KKyNlbmRp
Zg0KKw0KIGludCBtYWluKHZvaWQpDQogew0KICAgICAgICBzZW1fdCAqbXlzZW1wOw0KDQo+IEFs
c28gTUFQX0FOT05ZTU9VUyBpcyByZXF1aWVyZWQgdG8gYmUgdGhlcmUgYnkgUE9TSVggc28gc2V0
dGluZw0KPiBfR05VX1NPVVJDRSBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgZ29vZCBzb2x1dGlvbi4N
Cg0KSSBjaGVja2VkIHRoZSBodHRwczovL3NvdXJjZXdhcmUub3JnL2dsaWJjL21hbnVhbC8yLjQw
L2h0bWxfbW9uby9saWJjLmh0bWwjaW5kZXgtTUFQXzAwNWZBTk9OWU1PVVMNCmAgTUFQX0FOT05Z
TU9VUyBgIGlzIHNob3dlZCBpbiBHTlUgZG9jdW1lbnQsIGRvZXMgdGhpcyBtZWFuIGl0IGZvbGxv
d3MgdGhlIEdOVSBydWxlcz8NCg0KQmVzdCByZWdhcmRzDQpNYQ0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNYSBYaW5qaWFuIDxtYXhqLmZuc3RAZnVqaXRzdS5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV90aW1lZHdhaXQvMi0xLmMgICAgICAgICAgICAg
ICAgICAgfCAxDQo+ICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29u
Zm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGltZWR3YWl0Lw0KPiA+IDItMS5jDQo+ID4gYi90ZXN0
Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fdGlt
ZWR3YWl0Lw0KPiA+IDItMS5jDQo+ID4gaW5kZXggMmVjYThkZmY2Li40Y2NlZjcyNjEgMTAwNjQ0
DQo+ID4gLS0tDQo+ID4gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFu
Y2UvaW50ZXJmYWNlcy9zZW1fdGltZWR3YWl0Lw0KPiA+IDItMS5jDQo+ID4gKysrIGIvdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2VtX3RpbWVk
dw0KPiA+ICsrKyBhaXQvMi0xLmMNCj4gPiBAQCAtMTEsNiArMTEsNyBAQA0KPiA+ICAgKi8NCj4g
Pg0KPiA+DQo+ID4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UNCj4gPiAgI2luY2x1ZGUgPHN0ZGlvLmg+
DQo+ID4gICNpbmNsdWRlIDxlcnJuby5oPg0KPiA+ICAjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ID4g
LS0NCj4gPiAyLjQyLjANCj4gPg0KPiA+DQo+ID4gLS0NCj4gPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHANCj4gDQo+IC0tDQo+IEN5cmlsIEhy
dWJpcw0KPiBjaHJ1YmlzQHN1c2UuY3oNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
