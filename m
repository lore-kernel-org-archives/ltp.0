Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEBCE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736417750; h=to : date :
 message-id : references : in-reply-to : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NAFTl/STaLoNh8KIeLmoECJ0AUxGUnCzkZDZTB/XkCk=;
 b=RLyi+yY++Sy/umhvjzpq3iJpMYRBR31gepLobCiHZv6Zn4e/ZsKyu6ZLc9KeW8MNkIoBa
 dVthlMQS6/Xe2IQiwwe4dP15cRPeznSnq/1NJ/t1seNsR3GZfZoz0iJz3MIfYWR897y6KQ2
 Gyp2sLPk1AfNsCOFkojlZdh+AGKB43Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06A13C20BA
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 11:15:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19FF83C1E22
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:15:29 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.156.121;
 helo=esa11.fujitsucc.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com
 [216.71.156.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 54B51601564
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1736417727; x=1767953727;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ewdkNuJB6v8LTCUlotsnnUbX/wnvlj9qLHNrLDaPpwM=;
 b=cOSu5fw1sHsWvgTpAz7plCPz9oxpGjtsIZpxKVvVfM5rML11LQpTdXmh
 H7hyknNoOZ3p2hic3X69AsSH21tFEXxeLbwYSF1LMjV9+pYsGMm0dh/aw
 xOfphXpa7LMUDNJ5rtku+lyRBlUaisZllPiBY0pTnsA2MWQ6ziixXn0CH
 xWPd83g/9BKxQ08d9ekaDsZ2unGqwpnk+MtDTciIhdeXI6QczOshBkQSg
 YXj41T9HQIvM8Kd5zbiZ99NPK+lPehQuDD3b2JLfIwmXw4hztC3sr74t3
 jUmDNbWfgC6rxGtUpEDLw1DQcAI7P7AFZ2G5QHo8gKOPgHaf/zGjo//a6 Q==;
X-CSE-ConnectionGUID: EwUzxxN3RFu7TR4L7s29kA==
X-CSE-MsgGUID: fhSXFwikTuS5Wjj195bfgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="143237636"
X-IronPort-AV: E=Sophos;i="6.12,301,1728918000"; d="scan'208";a="143237636"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2025 19:15:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6irM1d6f7b6j0KvJm4zc2hOwkxWz0CV3hapSnE92WYDgar+05Ywu4Kd+trO6G10X5J86yZwdF8Tbp5UF2wGK7W1O6xL8dmSfQ+M0sOFLQx3oEHXO9x1+ei2ipeaREIreL7yl6geUU4GPt2BHuv6KBgjb+tIwFpjhaBiy/zNlNjk0mb4f/h7nMG/Mje4rZJ7h0JIYFH/nWe+bCCRWLtxfo8plz5VDnmBMx3gBNLshNw+fbmREks9HtHhy76Rl28kkPHhXk0oEftWc7aCR4fVY7VoLSQDtwA/xO80AGZuyNbOPp/ZDTef1fWXjik+AYZnbJdAY5RIHhBjWmQuFl7cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewdkNuJB6v8LTCUlotsnnUbX/wnvlj9qLHNrLDaPpwM=;
 b=q99YGdKLU0/Bitrbbc2biKHz6/T1+j2TWns+utd2CkZH2d7ueIKkptgnY0WSwiB3mW6ovieF/FTlvlrmOg67UkKvsLl6nhSvOGwlR/8XfFKUTsy5j0ixSzbGtXyBm9btPeceLECXvByInE09L623YL4fVVhiVpIsQvAlF7MSblKyfYCPQq3p9/atXt5uPPjPZh8gHrf3srNUKUMvKKcy62R7+NV4YZBCYcdw6KCU6FXIBQbzqmIN9X5mvifC5SU2UEdiWK5f6Tqo0YtqHUEIpl+GdpOMtjYeY7jHFwS56oFvqI1Kv0NXng5ldO4qINv4/Ugl+c0oXawNQHfgaNRDWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 (2603:1096:400:3cc::12) by TYCPR01MB8899.jpnprd01.prod.outlook.com
 (2603:1096:400:18d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 10:15:21 +0000
Received: from TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9]) by TY3PR01MB12071.jpnprd01.prod.outlook.com
 ([fe80::479:9f00:f244:9b9%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 10:15:20 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] rt_sigqueueinfo: Add negative tests for
 rt_sigqueueinfo
Thread-Index: AQHarA3f/hSK3c1I6UW8YvJF6PNtG7JcW1eAgLNC9YCAAAdxYA==
Date: Thu, 9 Jan 2025 10:15:19 +0000
Message-ID: <TY3PR01MB12071EE8DF7FA90BEEB2BA549E8132@TY3PR01MB12071.jpnprd01.prod.outlook.com>
References: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
 <Zuk6k_8ryjwZqpO9@yuki.lan> <20250109094523.GB184406@pevik>
In-Reply-To: <20250109094523.GB184406@pevik>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=9864b231-af6f-4138-83e9-77ec55052376;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-01-09T10:12:24Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB12071:EE_|TYCPR01MB8899:EE_
x-ms-office365-filtering-correlation-id: e5eb717e-260b-4b60-418c-08dd30968536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?gb2312?B?TGVzN2Q0eFlZWHRhb0NLa0E5WHdKRlhaN3VQcnVLc1FTNlZ6ajlrc0VxVXpE?=
 =?gb2312?B?Ry84bjN2dnhDUW1hM3MzTnY1NW16dDRwYnBqM1UrbDNOVXhiR3pEVU50bkts?=
 =?gb2312?B?ZTlHbTBJSW1aa29Wd293Y3BvcENoRlZkckgyMkh5UXB3UGlIS29yMmFtRHBh?=
 =?gb2312?B?N2VkeUllRnpOWWN1QTRSK1NnTnBHUzhIU1JoQWJyaDhoZ005c0tVakxIWHdR?=
 =?gb2312?B?VjdtbzliOGwxZlZ0Y052SGEyMk4ybjJHTFpiSWhiclJ6WDZ5UDU0VGFGYXhn?=
 =?gb2312?B?ZVNsd1dmRXVaRnFTdFcwSVVQd2p4RWczTGU4Q25aa0YwVkFkWjJFY1lVV3NS?=
 =?gb2312?B?THd4bUQ0MTNzY2xXbFFpSzRQc0JBd3JmNU1UMW51Z2VnMXI2V3RUNkRkV3o4?=
 =?gb2312?B?Vzg4MDFYMXNvdkV3RHBTWVVTblEybXMxWEc5b1QrYkZNclphTGNOSStWemVM?=
 =?gb2312?B?TUt5UFNaTXkvV0VVdUVQc2pETXhRYnRicjYzQVUvSzNvbU5UOC9FZE9JdDF3?=
 =?gb2312?B?MTVmcUlrTjNWQmtHTlhlWDJZbGtCYjRUSktTRnJJQm9LQzZDbzdPUDhGTC9E?=
 =?gb2312?B?bVZoM2RqdEVaNUhlS1ZhQlJjNkhZdDJ4RDNkQXpxREFnR015bFk0cDJWNXJa?=
 =?gb2312?B?Z2FXMU1KKzRrbVdoZFp6UUhpQytEM3A1b3loVmNha1Rrd3k0bzdxc3hMQWpP?=
 =?gb2312?B?SWRxUHY3eGdGRlp2VFlFZ2tleHN5OEg0dEthVmFYL3lKbERNY3h4RVRaRnNz?=
 =?gb2312?B?YjRvV2JrbDRjSGg1blU2L3FCeE1xUGpLdExydjNES25PQ250b2k5ejJObUNi?=
 =?gb2312?B?RXZ0STRvVDFwV1NNaUg0SUZ4RmNQSzFHb0VKeWE5UWk3aEo0RUQ1ZVErNmx2?=
 =?gb2312?B?dTRwamhsUmgrY2diNThEVG4xNThDdU9uYzBQWHF2TUZaOWlLVjlSOWVMRXZR?=
 =?gb2312?B?VDhUWEc4eDlwc0JsL3dlVDVrQkxVN1g5WUovVHBPL1R4TGdlbHRzYTI2VHA2?=
 =?gb2312?B?K0NJVklYTkpOSUlIbk1VUENEZGd2Vk83SXYzWnRmSk1QT3RoZkhIckZjY2Rh?=
 =?gb2312?B?Q0VSYlU3NXN2SWh1TWlyZmxhMHZCWTMwODNqSCtsY2ExSjhEeEMySXVadTcz?=
 =?gb2312?B?NmYvZGgyTFVzaHBIR2RndWxBSWNKWHVaRVZyNnMzY0haZ2Y0T3FJQmhObURh?=
 =?gb2312?B?SCtJelNYeVNoSXhrQ3BZY3A3SEthTzBGdlo4L0NSa1UzaTZKNlgvcFF5aGlr?=
 =?gb2312?B?MFZ0ajV6R29tejU3M3Nva2h3R0VmaVJUOVpkVFBQakpHRzNqY3NIUjZjTXpu?=
 =?gb2312?B?L2FySjFoNGt0K01hM01FWlFIVm80WWR2ejNRRFpPVUp6Sm54ZFpIbEhHVisx?=
 =?gb2312?B?UDEwZHdIQ01tNzArWFB5YjRrMmpKOGRBQlVLejhmYjh2RkxQYkluTHlSdElv?=
 =?gb2312?B?ZTdFWW5kNkRUU09IRkNoWjBMQVN5YzVyMFBZcEF3b2hNZkRJc1N3eFA2dEFQ?=
 =?gb2312?B?ajhYZHVUY2xUQ21WS2NXSkhMamxiY1pWc2hsZkhYd2FHNExmeFhSWk53OVZ2?=
 =?gb2312?B?QkJHSzE0MmtPVkZCRHdTTUJPRWtFZDl0Y0prSGdxTDFzZFJHRTA5UC82ZFlm?=
 =?gb2312?B?YncrZ25ZRjFmbXJ0bW1zYi80MktVN1QxeXZML1VMOU55UE50N1ZURzI4SGNY?=
 =?gb2312?B?MVhrR2JTd2NrUVZqZDFrbTV6T2RVVkhIWlBLRFNvL0gvU0t4MWlDdGNOQzhP?=
 =?gb2312?B?aktQUk5VeFRjeDNtZG93VFdXNXJPc1F0UHBKZFNEMnV0aDd2aFZnUzF1TUU3?=
 =?gb2312?B?N21nUFhTenZzcURmMlNHOFdpMVFaeE5ueGkyUGhzOHBLWnF3RVhuMDluamI5?=
 =?gb2312?B?UGFHOGI1Q0JEOXV3ckRLSlBWaTdHY0d3MUIrcGRvdkZNNnlNV2VLQ3JyR2hh?=
 =?gb2312?Q?zbJLmSkzPVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TY3PR01MB12071.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bjkwU2ZaNVF4b2Jad0ZaRmhRYjVkdHpkQkxCa3dkV0VmUlFTTHdLMThyYkg1?=
 =?gb2312?B?NFNBZzQyZGpydTMwdHBicWFHd1RNYlArWEh5OURnOExFbTZxSFcvZnM0VnhB?=
 =?gb2312?B?RUh0TkRNQ01Ja1RYU0dJUkpzOG53bVhSWERJY0FyYjdjRkZlUEUvdktVMVpB?=
 =?gb2312?B?Y3FDNUkvY09zMlpESlV0R2lyZHd2NWtra3FkR0IrSkU4ZFpEMDRHNFQ4OHNG?=
 =?gb2312?B?Qzg5WnY1ZHdnVzVPcnh1UXBOY0pQOGxpTUxsUGs2NUsrZ3ZpaWZmeVNxdVFw?=
 =?gb2312?B?bGxJNTVkVXNMR1J3UUFMb01hL1draHBsME90ckRkVy9QM3ptbDQrd1dUV0x0?=
 =?gb2312?B?TkgxTzJYL1lybDNkZ0dINC9ScnZoTndFdFExeFJheStHbzcrZWV1ZTFhWjVa?=
 =?gb2312?B?STJhL3lHdEt4dWVOM0FHVFNWZnJBMUZTWmwyczdvSTRWT0pXbGkwdG9hM3FQ?=
 =?gb2312?B?RWlneDFxQ2RLN0MvRTNNRVdXMHRPZzA2eU92bU5QUGJhLzBUaU1xNlFiN0Zx?=
 =?gb2312?B?Z2IyOHhvcFozVzRDNGxYRW1RY052YStxVlg4N0tzbjFZQ0hxc3RPdjUrWnUr?=
 =?gb2312?B?WmcxZzdLQUgvQzhJQ0ZSOXRiQWNaNG1MaWZOS05mTFVVazdWWXpFbDgvRUpW?=
 =?gb2312?B?VXE3OG4vRTl2YnRvNWxXaEpUZG5hek12emIybDRaZzZ2b2M5MmlPSjlqZFRo?=
 =?gb2312?B?Wm83QW9Zb3NaRHFKWFFiUXF1QVNhb3VudlYzNlFBSyszRDdsM3ZmNFQxL1Ey?=
 =?gb2312?B?TzB0d2VXR1Fod3hhRnp2dW93YjhPTVE0WUMzMDYwWmtJTHRnZkRCQlg0VTZF?=
 =?gb2312?B?OHVPQU05WVNsTVhFUWxEb0tYbGJwbkJkaXBJemQvZEVEZ3hWcHM2Ujk2NnU1?=
 =?gb2312?B?UUFUUG9xQmpLNUhuVmlVQ1dPYW84QTFUZ2xiVnhlbDVpSmhZaDdqaUpmdlhX?=
 =?gb2312?B?TkNOWDZ2NzUwRm1PcklSMi9jNjF2OWxKY2hiME8ya0FiYTlWZDBmOVpVTHZt?=
 =?gb2312?B?cFA2OC9ncXN5QjhuME9vdHhaa2dod3ZzUWM5aDRoWU9SSUlkZHpxRCt6VGdB?=
 =?gb2312?B?ekFLQUViM3Z4QTBodXJ5VGUwVHRXYjZscEM3b0JoUjBWNVA2eVpaOWtIa0hG?=
 =?gb2312?B?dzcxUDg2N0tlRUluaFFFbHYrS0Q1Y2FFTGllUXdaT3BCQzRVYXlHdTN5eUlp?=
 =?gb2312?B?UDV5cUVwVTdNVE1HdGNxVnd1azZhdzZ0MUxyemJ5Z21SRGhHOE40L0lhY2dY?=
 =?gb2312?B?RU1hMkxwZkVnRGJxb003d042cTgyZjZ2b1JvaGZyMFdRQjErU3dhY1FNQnJh?=
 =?gb2312?B?Z0hKNGNRY0w0a3hPdmVrRVllV0lGaUF4ZHRFMW9mUmlEbTI1ek9ITUtCQXFV?=
 =?gb2312?B?Q3psZTdZNnFyRVBJVDAySzRKQ3F4R2dFakhCdmFLR3ZPdnBHRDZ2L2I2S0lT?=
 =?gb2312?B?WkRVd3J0UE1xYllsTlJuTmVtQ2c2eDk2U29FZS80dU1Nb1dkcGpRaStOVmN6?=
 =?gb2312?B?ektiTyt1Qm5LNU9ZMm5lOHdyelZCSldRa25UV0NIOEZ2OGt0cGowazRaYWcy?=
 =?gb2312?B?OVpXQmkybElNRlVXMzFURFJlSVp4L2hRMXdWMXdqcUl1S0Irb1dqUGpEcGpa?=
 =?gb2312?B?ZFJUUWtFcEMxT2k0Y1dmWjlYcUM3RGw5L29zQ0JTbnRQTlpJeThDVVVwVUZ3?=
 =?gb2312?B?bDNPaTR3Q213SHJ3WTVINHUweGc5K1A0aE5HeG0wTXFLQWVBOEUzamFKazQz?=
 =?gb2312?B?L3RHNnR2RWcvL3E4ZW5aL3BMdTdHNC9zVjZTUzFjekdLMUFTQktETEtUcmhI?=
 =?gb2312?B?TjhFR2F3QWVXNGNXNWh4Z000dGp4OEJMQjNxeGFlYlo0SnU0dmFvZFRPZHQv?=
 =?gb2312?B?V25hT0o4bkR0TjRjUmJpakU1QitqRUl1TVFrSDlzdmdlSmI2ZGQ5SklzT1ZG?=
 =?gb2312?B?dnVBOWVlVFFzOGRvcDY1V0RVK3RTRWpwLzNZdFRDZVg0dHFKQU1MMlJVMWVT?=
 =?gb2312?B?emNqa3JJa2U5b1YyRHJQTlJrVkdXdlFNelgwdHNBVmpGeFpWQ2c4d3ZvalEv?=
 =?gb2312?B?TnpXYmxIcEVHZ0o4T3pTajFzeTZNdnpTT1h5ZTdhM3VjVmxoMGU4YmQzbzcv?=
 =?gb2312?Q?cTELwXkCt7u6KpBQrEULPpC+f?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BkVUQbC/7Stv598X7Mk7cMYqqs69ualreKmXjW/CWgeWr3fzVjB7HgpYj3Ft0VOvvFpmjrwTFJ3OowMkIJc1xEBLrZMduSTCxqDGwRxPYkO7rLV8KhUXr4RjmRBsbqu3oivaYhshMZ+8rlEKFO/65CIWOrhtQwsK0/a7VGf/Ykb2A3YFwevHjhnbY+OsF7bV2GRH4Ese2jUiGk+r2d5y4Nv6gU/q17bltU/U0RdLUKSBoKVV7k2tr6MxVWHJsonbUq7wEblsWc0vg5Bzm90oWUzAu41v16aQZxeHcskQ/qfr0Jv6mHbRRiUjbuCAe1duQx9YF8GTxNBU+kzBx5CPqKg6Kke6RaTj7Roo5SCPFXKBusLYD+Zh6YZ2W0IwNmT1YLvRsecobN9ziKrNgbz++S9WdLkrvzhkf7vJ8aDbm5GFJfJFZDb44g8FRsXpR1t3BcWFwbkMGdvZ+RDjBWpaxrG2TmNQwSrqaTmoWFnOZ1dSXu9qpDwHa6WvZsIMMKqSmREZX+4vIaEMlLSjPU11SwX4fe7XHEtKKtocwA43ndVGfazRtAoC9K2WJ1MqO4NCSBbEu1KE9df8DLRVTFhDr/qF592J8Nd2XK2VGyQdYdGjbGrbbDQVydTWH+vbs+ev
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB12071.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eb717e-260b-4b60-418c-08dd30968536
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 10:15:19.4214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J49WnwDv7GMqLbg22cIVg16dE0qYofjy5E0E1OSpBpsz8afUyqWDhHSJQwhUtajD0G3sFVXTxgxUpfJ8l1nH1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8899
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?u9i4tDogIFtQQVRDSF0gcnRfc2lncXVldWVpbmZvOiBB?=
 =?gb2312?b?ZGQgbmVnYXRpdmUgdGVzdHMgZm9yIHJ0X3NpZ3F1ZXVlaW5mbw==?=
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr

> Hi Ma Xinjian,
> 
> Gently ping.

Thanks for the ping, but this patch has been merged into before.
https://lore.kernel.org/ltp/Zw587CW6NtzV8es2@yuki.lan/

Best regards
Ma

> 
> Kind regards,
> Petr
> 
> > > +static siginfo_t siginfo_einval;
> > > +static siginfo_t siginfo_eperm;
> > > +static siginfo_t siginfo_esrch;
> 
> > Ideally these should be allocated as guarded buffers:
> 
> > https://linux-test-project.readthedocs.io/en/latest/developers/api_c_t
> > ests.html#guarded-buffers
> 
> > You can have a look at signalfd02.c and the .bufs in the tst_test
> > structure initialization.
> 
> ...
> > > +static void child_do(struct test_case_t *tc) {
> > > +	struct sigaction sa;
> > > +
> > > +	sa.sa_handler = sig_handler;
> > > +	SAFE_SIGEMPTYSET(&sa.sa_mask);
> > > +	if (tc->sig > 0)
> > > +		SAFE_SIGACTION(tc->sig, &sa, NULL);
> > > +	else
> > > +		SAFE_SIGACTION(SIGUSR1, &sa, NULL);
> > > +
> > > +	TST_CHECKPOINT_WAKE(0);
> > > +	TST_CHECKPOINT_WAIT(1);
> 
> > The child will never get any signal so all that needs to be done here
> > is to do TST_CHECKPOINT_WAIT() so that the child exists while the
> > parent runs.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
