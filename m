Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF71AC433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 18:47:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8B283CAEDA
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 20:47:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A7E73CADF8
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 20:47:42 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E01E81400BEA
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 20:47:39 +0200 (CEST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CIeW11004287;
 Wed, 12 Oct 2022 18:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=DU8yhMhR7c00o8QCK8RJ1uSMl2t1o1j//kCtN1oHboo=;
 b=Z2E6dkY0d84hSe3E31yUrJmoijTuGzmfZjPVSc7dXTh060GrvQEwVxsbnCmyPHl1N/Mu
 9lAMJLRkZWnHWGzozy6nt8iTHBOLSSNeUA1yYo1dYoXiN+QIGqgoVgFwapM+ens1pIWo
 gdDM7jfOteqOwIrvd29q2OYqaYO9Glc0KaHletHrIOXp69ccZ8mdg9Ovp1cfn9C8WYdG
 oi1AZTV3vqCb0jEILOR9gulTpkF7aA5TmjcST/AkWSapCnrGWsprIguQ0ubGTCIgVpnL
 u7FICjv1YXTl/osKX9cdOT8GAZoR9FJt0VuhmEqZR1IcPLij32zIjxI7uxEpmqSC+ACV Zg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3k2xm5mhrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Oct 2022 18:47:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPKN6gKW+YoarljVSkFhtBj94WPibjH8lVZjtHuXDRtEDI5bVGg2kc6CPw3aGnVlWpgDHPJlcXyDYv4cFQKd4H8rTkfOz/9+Ls1dLivItT7Jk2IXokmCU4jcDpu19giwLw/WByQYGcI1tcXqcx6wHj0/gcPiMgeNlfout2DlYz9cMKJQ9oPx+snO7HribEKukmmjCUO5/MaTQFvil4fQSeaajFEDN3/wjKQXnfYkbZEZL3TfA6z4shdU0cj5epmY5ZlxWn3TJ0cG8imyWR6ZAwfD3Ayc4eqaHBzZcZNBLSlhyouJNJkVnJxETw17+6bVxyvaDgxjG1xSQi9WREG6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU8yhMhR7c00o8QCK8RJ1uSMl2t1o1j//kCtN1oHboo=;
 b=hmmJ5Qeai68vbyKxEf6cfBUUiUY4KK/aXP4SViEnw0qvQdsB7VC/FImn0krui1twe7xrGBzvPXbYPZ1RrnCqdmLJJKdqv4Smb6ZiRr/gZ9DLUttvbOqfQl2S1tnDq3nXhTyk+P0xKycB56Kgw1J7mFoqi1zuaSdCk1WLdmWn9+IRmcxqQCQNfE1m3CQDYd33V58CMiOIpVTHhJBmMfeFR81q9ArvcnNcLO779l17G/yqaTR8QiMDHTFL46d9m9sQfBH8fs/9XjvaDdhC8mbmQX6zrnOAyzXPBwomPeJUHZjgekcD1IJen2pmoiXjtvSocmiNwstdGd8ttV14Fgmlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BLAPR13MB4580.namprd13.prod.outlook.com (2603:10b6:208:326::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Wed, 12 Oct
 2022 18:47:26 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::330d:5063:9079:2771]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::330d:5063:9079:2771%3]) with mapi id 15.20.5723.016; Wed, 12 Oct 2022
 18:47:26 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Petr Vorel <pvorel@suse.cz>, Zhao Gongyi <zhaogongyi@huawei.com>
Thread-Topic: [LTP] [PATCH 1/2] lib: Add checking of needs_root
Thread-Index: AQHY3hu92leCL4fMkkKz6FI/Kv/pNa4KoKEAgAB3cmA=
Date: Wed, 12 Oct 2022 18:47:26 +0000
Message-ID: <BYAPR13MB2503DBBBDBB055C42B36DDB0FD229@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
 <20221012091526.35373-2-zhaogongyi@huawei.com> <Y0al/lzocpDw6hBb@pevik>
In-Reply-To: <Y0al/lzocpDw6hBb@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|BLAPR13MB4580:EE_
x-ms-office365-filtering-correlation-id: 69e19e25-4ac3-42ad-55ca-08daac82355a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkWHvDCll0ny+KTGXPGyRB7T6i9YptrFrZ3zkT2YMIeJIvBqAGlIOYKDMXkEHNE1XenxqcPqYTVrXJ9MQZyixdMNb+8xwbsegEyzTS3vDP4iuIcNQLqmZKgfwl9ZnJio6/S9ZIHn2KTY0Aveh1UjqVSSCnoOcvZ9NpoC7222JjK2wIiAE7R/henCY2fNauk3veSlsl+9BaaoPpB1sK1BlHuuhGTAnCn0qZXnRwc5u84ZnSzvY+b0kXykiVJA2J47S2QIr2kl3+rC1cmBcNttahodD5JPRZoTogqTvuxKubbsP2nbweHhzm7U+Lc1nlib2GuZYiQYsKcQfQh6Rb9WYDLAyXEaH6TO3EFGgjXLhcLGQR6yjtIY4ooUoevDQZP2uWD9vGUEw4YbpLPVDeXux0Lmoj65DnJUoRmUgFkA6dJ9zNBsyzMazEs9VGFbsRsp2z7Zuw78pFKK86Y+EotdSYn/QCeQKtn/xzR+xv16jc/DWruYxzrPNRzd6ohwdAfTEnxK/o3xwu363wKVnA3P7tUVoQAwI4uORZi1kBcYAk4qVXl1vGXDq7g1VBRQBIdcs4c0C+AVkvSMjth1DNiZiQHQIyjdJHxxPTcnMzcDsealh7zOvbNvJg8XKWbXkh0DvI38FxiE8BXjJrlV52mRXJiz+g2IZQOPZXfgsCaltxvSf1I+nGpkDNK/zv7MZm4l3J78OP/MizDvJuU76Wm0Mxd5TyPvuXwX9i54/22CadU+HIAzoEMUTch9MryThpVu7w813YHZjQP9tfMEPfqYMHRHjcFRWCt4aQDNL/qE2nODOnLJEmg1ejqA1MsX8vN5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(478600001)(83380400001)(186003)(110136005)(2906002)(33656002)(86362001)(52536014)(5660300002)(38070700005)(8936002)(82960400001)(38100700002)(55016003)(41300700001)(316002)(26005)(9686003)(71200400001)(7696005)(6506007)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/UMV6GLI0GGZkagELe9VJm/gCWgsUuFyMC5qF1I2MbeGtsdIVeIZRa3znQ7?=
 =?us-ascii?Q?nzIR01Mbzt9Dck9fNibKimNqtguU3wvXGO3bA2HmuET62TNB3jAmv70JBlR2?=
 =?us-ascii?Q?3nz8jwx5AUBjchRFf3RIhwBBhSbZxBQTC2dxL97OoHlvozxRazK8kTx2MqD0?=
 =?us-ascii?Q?aNPOkks3tPAQH2iQGws8wDxm4cg1GliGhQ9G9gHLLs60m8cRSt5ShprIuzlR?=
 =?us-ascii?Q?BPNnYMPdxjaNSsygvHw4Io4UCWZ1Jv4y1ezZCAvouaQIq2BjYBvVj7a6g7gB?=
 =?us-ascii?Q?G8vvFv5h/ud7UUxcQhd0fbZ1T0zgSlhqpYmsdjFZKuZLLn96H17EvtJvNJ5p?=
 =?us-ascii?Q?5LQ9QojgUI3Ec6/UgV3waE5sGXVXwW4yUvBNfd+X12zUMOCILARklAjUuqS5?=
 =?us-ascii?Q?Nr79/DFVlAngocawK+vW2ydlgdGofg6AeeH7+EXlA57g7DsdqYVOZ7/d3MRp?=
 =?us-ascii?Q?GdiO4833uC9w1jfZqZiBQ2M+IvzysCuI0L+k9zjUzZ5MLMB3CGCquM/5sykT?=
 =?us-ascii?Q?0A0xFIn8exYuWx1Ca2bqVffk/M3/YaHxRNUct0tLzssk/IwTZVYP1f0Pn6oa?=
 =?us-ascii?Q?XDFvHZmBESUWikZVvkK66rF6KvrV+4aChn8/cNBzbTVxiW1weJgID/gu0QuF?=
 =?us-ascii?Q?6J0iqhNZ9aeFUSYx9QLl0Fy+TkdNohr3ZJ+KtOYGVMx8g3RFIi8EzCp49bAT?=
 =?us-ascii?Q?Mjz6azSupDd48lqyZ4SxXJBArA4T6HYFSCS4nlyW1urHbUmeNUkfBkwr/Gb2?=
 =?us-ascii?Q?R70tV/0c9nYuEVIPUWzK3f7jislnjiU4VbaUnf8GDqE1QJP0WJRHDRTxTR4C?=
 =?us-ascii?Q?5DS20XaToj80iLzt1wQgs2pGrfst2wpCQoi4FisZ+j3YP37sJ5KsoYLH/Cbo?=
 =?us-ascii?Q?Hg8/cs3gzPZIDBvFbll1aUbb96XEV+GOJmUGFD+tF2k2OydOXecNj9G9daMA?=
 =?us-ascii?Q?9LxtwbomKsVbRfaaqT4uMbhSD4LSPRnrE6EAazCxa8IX3WzbvktGnT6IvHv3?=
 =?us-ascii?Q?/EH2uEIMKv2EGOlZ+9x/tkV0uitgroQ7T4fDQBRQG23mkGdW/2ah7PS3WUHn?=
 =?us-ascii?Q?KV8XpJBEa6JqllmU1xxd2KJ8WVw2tyuSkIt9ePk00IsI/+VBciWyh++vMfu+?=
 =?us-ascii?Q?uxo5DMEjHVVITp7e6jR+MKAO4D24Roo0mEB3AxxbY5XJ5Sq9U0XfuwQ2uAD4?=
 =?us-ascii?Q?io0MvNav768qesVk4dbMWP9Df/44Ua+HizghhM1TdGU/OUzg5QGhxqJFjaoT?=
 =?us-ascii?Q?laXKRk8ccLdq2rIS3ej++sImuvBrrT9KCabgeqab5KIJunvGz5q1u3nR/89d?=
 =?us-ascii?Q?kgIZnXI7vn7Ma2cJreDHjjsefFu50+6xYe4MiYB262H+ucrg6AcRlqjISMt7?=
 =?us-ascii?Q?HP3a9NVwA+5hY3VEyOeev5uHgg7W0c2xRbwrEq8N2Q2aIOO8S7Qny8puo3j0?=
 =?us-ascii?Q?2L9QM699EgPJSEVKfq5kQWzsLRqfo9MCA2FZA/pwAjkYSol0V43OM5dbXKhb?=
 =?us-ascii?Q?xCIXwEjdKFG24rvHUTnsEX+oyQxPKUtWNjk68JaTJfU/Hecoe5EdpCzuoWtM?=
 =?us-ascii?Q?VWpUs/F8g/kxCoUm/ulLEvyrjFrgGGt6z+kzxsL2?=
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e19e25-4ac3-42ad-55ca-08daac82355a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 18:47:26.6560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fOZAivYGxaTO0qVcCfKcclnyBE1iZ1owGJzHVPhMNDsm99jhS9HZ5llhvhjN5FD3BIJwLY0r/XX9Gp/bXybKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4580
X-Proofpoint-GUID: FZRzoTBOte70m0OmAhVoMeybceiuYVSo
X-Proofpoint-ORIG-GUID: FZRzoTBOte70m0OmAhVoMeybceiuYVSo
X-Sony-Outbound-GUID: FZRzoTBOte70m0OmAhVoMeybceiuYVSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Petr Vorel
> 
> Hi all,
> 
> The subject "lib: Add checking of needs_root" is a bit misleading
> as it does not mention at all that it's for the loop device.
> 
> > We need to check needs_root is set when tst_test->needs_device or
> > tst_test->mount_device is set since access the /dev/* need a
> > privilege.
> 
> FYI we had some discussion about it, quoting Cyril [1]:
> 
> 	Well technically you can be added into whatever group is set to
> 	/dev/loop-control e.g. disk group and then you can create devices
> 	without a need to be a root.
> 
> 	So the most correct solution would be checking if we can access
> 	/dev/loop-control if tst_test.needs_device is set and if not we would
> 	imply needs_root. However this would need to be rethinked properly so
> 	that we do not end up creating something complex and not really
> 	required.
> 
> There is also possibility to add custom device via $LTP_DEV. That might allow to
> add permissions which allow to test without root.
> 
> I'll write to automated-testing ML (and maybe to LKML ML) to see if people
> prefers to test without non-root.

I took a quick look at this, and don't like the change.

I didn't investigate all the affected tests, and what device exactly is being protected.
But the overall sense of the change takes makes the authorization checking for tests
less granular.

Fuego often runs tests as 'root', but it is also fairly common in Fuego to have a
dedicated testing user account on a device under test, that has permissions
for things like mounting, access to device nodes, etc.  This change
would cause tests to break for that account.

That's my 2 cents.
 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
