Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4B7C4332F
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 19:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E9DB3CCFD8
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 20:26:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C683B3C62CA
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 20:26:10 +0100 (CET)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0D282B20FF
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 20:26:08 +0100 (CET)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AHIslc9032031; Thu, 17 Nov 2022 19:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=/W2tW0oiCCXYmCxU/idX/iVzDgF/nV7f8UDSTXEoBwg=;
 b=YP/p+vejtQDmm+PCFSqe6qL9QvttQxWOADkoziVYruePh65fYZwfMdf3xub70AxNScou
 ZbOziJ2croVgn9Qu+olB1abJz1yU48Qj+FkPJU93GV/KKkm3Vg6xKVfx84hIGnsKOY36
 jp2qYOMplohStYXKVi+3oKYKPNJ4ziXFa/qHbQffPBp9cgwjycX3rAdBz2vgJD7fTT0/
 jhtaAPI8bFnAgTM7ykhHMAr0GgVnVSiHH+qFYuml5keggVXyaI/uDAcSdDPOqGmJ6KOi
 0JSHh+lH3eV3S0rZnY/XuG1Nm+6fle/afUilIjngFljszNOcKYRnRuOsRHylh2FpOwOP 9Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kw29psbsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Nov 2022 19:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcumUSUp/BFhbyrYnYb4FxX4qdyDNyHDb/TILKxlagQ4W1kovZJM3ifCwiEo+4o8v/8n6IgPXPq58V8kbslv2RkZZxro3N8x12ztKOEkA0W1XZo3A9KkZhGS3HhS0egAGj5yjuvgiFbEkfWaGIz42EZMt8eIuCCrFz3xck+Tz+NEL29xRSC1ONCzHGiQbIJRDxFqOP4kkk/ixMLOJHR8LqmPnHjJzMuhSTIg9+kbohan+uV37kGH+GyCzaaCJDMHljuGKNDPDzLbCO08XVZhZt6UdpuCU4XUwpZa6naB2h4KdrefHblXz+SQFx9jmIVViZu1Po21g27wofro9QsPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W2tW0oiCCXYmCxU/idX/iVzDgF/nV7f8UDSTXEoBwg=;
 b=LBbDb8lJJ4wcstSIv4FfsaznXokzrExt83xfnfnWxvBdkFNgIPEgUBhqz7uNQN1A8g9X81m0rOtSG8Amwc7fyjqPkNZTYpS9elO+gAxr1AW49J8LkYeHUZvuCDFEi/0v7G7khoymtX5U+3V4fRmP95xm3WueiCddmn5333Rhn5felhbTD3wuSr3KBFvMAA8I4P1ScW+kgTAGzBP8PXeGf64CEHJuMlU/I09dectzyCAqATJXa1wRVlGSc6ueP8oU56vMcBXIE94r4l5Xf0lYBicCHozBC41rfn+qSbB+43oqUwosRrIP8LzusovxjHvs3IzhApDSd76naS6srIJEeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by BL0PR13MB4515.namprd13.prod.outlook.com (2603:10b6:208:17e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 19:26:01 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::d478:3650:b65c:8787]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::d478:3650:b65c:8787%7]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 19:26:01 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Thread-Topic: [Automated-testing] [RFC] Include runltp-ng (runltp successor)
 into LTP git
Thread-Index: AQHY7T6K5YT99Q5CukKZRxZtW0anhq5Dl8Pg
Date: Thu, 17 Nov 2022 19:26:01 +0000
Message-ID: <BYAPR13MB25032674327E22B588074DE0FD069@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <416608e6-10ac-c943-1fc8-a3944286f193@suse.com>
In-Reply-To: <416608e6-10ac-c943-1fc8-a3944286f193@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2503:EE_|BL0PR13MB4515:EE_
x-ms-office365-filtering-correlation-id: 467925f2-8ace-4e18-e1a7-08dac8d18fd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lwoJO32P8lR7V0bCkHohx+qHRk7cbQYqTFrGgoXLg2qwIgZ9abkHFmiCgDjP5FG1UuK7qIxOUg9JrLGhMNW+FqxR2QqSOwQ3isipye0B+03iLxFS+fLtXOOw9N4M2y+LtRecOpXbyURKL+G9wjFZMk1FA9yL4G7nnGNl/YQNKrBaLj1UzKvqDide7u+UDI6zsq4WEw5KZLzQpIXpx3MbwPXa9fPUb4eDBywtCyQjP/Juu38VmvSGJDopfXB5ZJ97J30lDFXyPcFP8lOc+rZ9q7jsxsTOa/XkfyxtBNQtQME3Wthhu6w3EFVmY2CU/BsEPh/aqTZuoDLaCovhymH5q1N9s+nBleVSPbjRDrM0k4Yxs7Hwo1IDY0RBEwyICH5++jXz02m0TtLxWDdcuMDfyWmAI9ChrqSynX7vUdd8/e11/t9FBlhClWGpMOXesOtt968oZ++FFINTDb2wRa6M9gWGSA8AWiIUInhDs9yULyeWP/d7B+rhvB9FxJYapDzBi/XeTfcgSqwq+S6qSA9ZkCjF7CHWEdW93/2qqNtMQsfRa/x4P45/qpkh1l2UnvziULYHSnMmN4mGxmRjddSfrMk3M/MSFNOQlZvZV8zQmFXUhq9sNBF7NC05rzVBHYC/L7OmrwPZuMQgJ8M/6aqDaBYt5bXpr8HtTimtVwKZe77sZ08OrxYgy70k1mDmQZdva6kMFDdjKLDtUVDVKdEkyzMa8tXvNsg0cjmE3jzD9zPJGJcuhKARyAO6WrnqDUda8Rl1iOxFlNL+YoXN6tR517rN2p34nKJWFlvYPULA4OB5r7w9vZVs6SBp17CR60v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(33656002)(38100700002)(82960400001)(66946007)(2906002)(38070700005)(8936002)(86362001)(122000001)(83380400001)(316002)(110136005)(186003)(966005)(478600001)(66556008)(66446008)(52536014)(66476007)(64756008)(8676002)(41300700001)(5660300002)(26005)(6506007)(71200400001)(7696005)(9686003)(55016003)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEdCNmZzNFNQWG9acjhLWlZ2RG4rZ2JWTVJHLzE0bld2QW0vK2ZKTzMrNzZX?=
 =?utf-8?B?WXFYcVlZS3E4VjJ1VnR3K2NqcGhsUzljNHE2SWw0dDFGc0srOVhOMVEzbTBz?=
 =?utf-8?B?U2F0TUZrNjZUZnYwQUtlanVpR09hTzhIQ3VMRUc3aS9uRU1BRXN0eEdhd1dL?=
 =?utf-8?B?SkR6MU9nNHNEc2xrRTRoeEFFWFVMK1JlaXR1ZkUrdVRZdUhVU3V3QTdCRzdo?=
 =?utf-8?B?eDJDcWFTZlB2UWtSNW9tZmFOVy80QnZ2ekU1QmdSb1gvQ2xvT2FlUEN5VXJa?=
 =?utf-8?B?UmlxRVBraC94Njh4ampuaXhqNThOemZYV1dMc2kvUlZ2L3pMK04xankzV25T?=
 =?utf-8?B?bXVPMm5kSVZlQnZoZUpCMDM5TDZ0T0JCYlNPOFNUMzBVTWJNa29rWWQyN0Y5?=
 =?utf-8?B?MG1BbFI0NHA0R0RrWkozZTE1czRqbzBncGFnNmdmQnROUm1KZkZGams5MTJ4?=
 =?utf-8?B?TjBvQ2hLVGFqdjRycmhJVUlJeGYrVjNEbGNGUmpvYzVZZ2pKWDFsWHBpa3JS?=
 =?utf-8?B?aW1oVW9sck9wM1NPeXVUSTNacEpvK0o3MThPK25xakFuNzRBZklqMlFsbVBU?=
 =?utf-8?B?YXRCVy9OWkhMTWo2bjN4NmJXbzcyYmRvWDk2TFJBQVdnZU81bERac0htbDNu?=
 =?utf-8?B?akp1dzNzRnphUEROaUpKdnZKVnRlbHdPN0tqY1cyRTk4MDIrSnlGd1RPYVpu?=
 =?utf-8?B?TDFRN2RHdlUvTllKZkxjN2VLeXNaRWxPRWNjR0NyczJEdmxtNmJqK1ExNEZv?=
 =?utf-8?B?NFF4QkxsS2dWek43aXl0cTlrdElSZEN0R1NUcC9KWWRPNDNiREZhaXd4VjBV?=
 =?utf-8?B?TXlEV0NHMFFpSStqTy90RHlqQ3A3QURlMHBBN1Vzd3pCZy9Yb1g3cFk5UEp2?=
 =?utf-8?B?WGRoRDRubW5qTVpSK2JKTWtqWFZOUHNYdHpyNWU1WUNFZmZYRWdOeTZCN3Ra?=
 =?utf-8?B?c3ZrN1J0S2k0d0NyU01kM0lyc3lTbnZSS1pIRHpjc2pLc0ordzE0K3kvTlFr?=
 =?utf-8?B?MVRDVHlFb1JlTUh5SEJkcFMxcVh0bWFFNHFvdzdCbEVoVlp2VWZ3d0JUU3Zt?=
 =?utf-8?B?djRteHdPbkorUjJWbEV5YVB5djlyQWZuL0Z0a3U1NkNYN1JvYkVLS3R2S29o?=
 =?utf-8?B?QVFEV2Z0TXhpMHp0dDd2ZWVmNklobkF3RjgvckZ6dWxkcEk0ZWVDcS80L1ph?=
 =?utf-8?B?aHBzc2tMaHJIc0srd2ZrZDNSOVAwY0pKUUdDbmFCQWlEMjkvTkVpUWJOa2dJ?=
 =?utf-8?B?cHdVZE9yTjhhYWpYQ1NxYmdlUTdML2Z2VU1vd2VkVFVYeUFrVlVaWXpRbjd4?=
 =?utf-8?B?UWh0aG50NExYZ3k5bkFFbGpQZ3VJVWU1VE5vMW1jcTZYbnlHQkJ5Y1dmUHNk?=
 =?utf-8?B?Y294NEtaWEttZWlaYnZ4R2xLeTl1ZDl4VFdnTndVQ3plUzBhUFpCOVlENVhz?=
 =?utf-8?B?dlcyRStPR3Z1K2oyTlVKanIxQlpERlRJK3BGUm9VdXZ3NG14SGhpR1hlOGND?=
 =?utf-8?B?VTBmK3RUY1F4TFU4M01SSDkxei84QnhaQ28wa2QvVWVDZWoxVFZVMHNWUllL?=
 =?utf-8?B?aHNuNXZrRUFMRkVqd3Z5V2Q1RmR3aGpNK1I2ZWQ3V3o0aEQ2VSt1MVpkRXFT?=
 =?utf-8?B?Ym5kMDUvNXVHQ2l3Ujh0NWdCNW1zWSsxRmgyWmkzN3pwdlNEbWt4MytnSHpQ?=
 =?utf-8?B?NWxqZnZOalFTTnUxbVNSbDZBWkc2RGNrQ2JQcGNqWmhLMlV4ZkNoekRzWmhZ?=
 =?utf-8?B?UXkzMlZUOXdHV1hqRThnSjgxbmVvUzAwUWVnTWQ3RGN6bDlSOW9zL0w5Nk5u?=
 =?utf-8?B?cDdmQ2FweVNPR05ORERiUEJqYmVLTkNEZUswdnQ5Vkx4RFl1QXkvTlV6TFQ0?=
 =?utf-8?B?amNoKzNvRTVCWW1wUUFOdEZHZzd3ZmxPMFMzN05KcmI4MlZYbExSSFB1T0ti?=
 =?utf-8?B?S05UYkJoK3Z5cjZmemtaaXp1My8raUU2akRLS3NEUVNoVWRKVmFQN2w5a2s3?=
 =?utf-8?B?U2ZtOU1GTytveUNjL1EwUjB3aFNKVlljQytMRkNxemVmUWhpdVNTTTdpaUtR?=
 =?utf-8?B?RmJUUjlkbUVQUzF2UFBtUVk3ZW5zS2gvdXB5S1hmWFpHeE5SSDVTcnZnUDFV?=
 =?utf-8?Q?bKzySeRK/m3f59DhS4iUWqM/t?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7sE467FZR00ozBQZ6D3zlxMLKb3epjSwOBzduz7hSZk6ZDaK+5TIfw5Ul8QZwd3zWCzsMCEcpxYKWWZbeDvSnqP3xttYbULPEbTwh6PhVdA7RmBx4H94Kgh0h60eumpl5RB6KdpNfxPJsGsPX5PatKbVTKaybNU5z1VI1wmgLLKsAmmJkSvn/DNmfRd+Kf6oNP7MayGbzKq12A9imUD/l2T8hw9FtN+603ha8Crf9noxNfxOU92wil2HM1JlqKzFO9H1PqfbMptiCdqkgbKnIDMAU2H9IEYyvMuqHk2n35TzST5Is7WtHmjv+gh8WhZgnyTGwj6oLS45Y1I75QbKahe8NwS+Z+h01SCW3d5xULb6svbPPJDgFSiw3wcaaRLMLxYOGOpIIoiLmX/4zbDS5NALQVtCR3qpD0NRV2+6Wv1O5vTwL6xz4KSzFHM4UoIHVTPvv5QaAt8MUqXgEgdvNhTFnRInEUyET9lLdVM6IO3mlpmxGIFBGAfy8urV6Iz66/2IgSPpsldI9440/3YQXOMCHluU80rqd29WiV/Rln3LvnH117eOxt6pUGRNws4sH7jSNCCcye7S9iWPqvSiulSTaek+7+bse/rAMxBMl9wt0DuAr5S2s50PHW3D64QBFrDHpMVpyl/38Xtp6HGQ120PN/tePGBBsDaX1YCBYcGoBvNB1Xosy3bHlO7TgpQCoiDis5jQuHpW4cW2eO/ZRqEbKW55JbYBzBbEhPQT0p8GHE4gsxG9FD5aQCtwX0TSvycNt63phVwtOymvN3P05JVi5dH4VlBCW6GDffUdG9raMdQQjIFQ520xAzzX2PWomOGQ6MhoKSVXrEvzKQqy131RS/bZDGrISfNbIjehmgs=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467925f2-8ace-4e18-e1a7-08dac8d18fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 19:26:01.3331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BxA9m9LtMfwVlo6kS6zZdeoYQTKJbB09I9nwvs1ZCHpUVeBxzHmvYQCfYv1crKg+Api9MiRpV/DqvUpsj1w4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4515
X-Proofpoint-GUID: 9cbqatEQKiubvAEEDxP7aajxoLINMsZo
X-Proofpoint-ORIG-GUID: 9cbqatEQKiubvAEEDxP7aajxoLINMsZo
X-Sony-Outbound-GUID: 9cbqatEQKiubvAEEDxP7aajxoLINMsZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC] Include runltp-ng (runltp
 successor) into LTP git
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SnVzdCBvbmUgcXVpY2sgYml0IG9mIGZlZWRiYWNrLi4uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYXV0b21hdGVkLXRlc3RpbmdAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
ZyA8YXV0b21hdGVkLXRlc3RpbmdAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IEFuZHJlYSBDZXJ2ZXNhdG8gdmlhDQo+IGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gDQo+IEhp
LA0KPiANCj4gYXMgeW91IG1heSBrbm93LCBydW5sdHAgaGFzIGJlZW4gdW5kZXIgYnVnIGZpeGlu
ZyBmb3IgeWVhcnMgd2l0aG91dA0KPiBwcm92aWRpbmcgYW55IG5ldyBmZWF0dXJlLiBGb3IgdGhp
cyByZWFzb24gdGhlIFBlcmwgcnVubHRwLW5nDQo+IChodHRwczovL2dpdGh1Yi5jb20vbWV0YW4t
dWN3L3J1bmx0cC1uZykgd2FzIGRldmVsb3BlZCwgcHJvdmlkaW5nIGFuDQo+IGFsdGVybmF0aXZl
IHNvbHV0aW9uIHRoYXQgd2Fzbid0IGNvbXBsZXRlbHkgYWNjZXB0ZWQgYnkgTFRQIGNvbW11bml0
eQ0KPiBkdWUgdG8gdGhlIGNob2ljZSBvZiB1c2luZyBQZXJsIGFzIHRoZSBtYWluIGxhbmd1YWdl
Lg0KPiANCj4gRm9yIHRoaXMgcmVhc29uLCBhIG5ldyBQeXRob24gcnVubHRwLW5nIGhhcyBiZWVu
IGRldmVsb3BlZCBkdXJpbmcgdGhpcw0KPiB5ZWFyLCB3aXRoIHRoZSB0YXJnZXQgdG8gcmVwbGFj
ZSBQZXJsIHZlcnNpb24gYW5kIHRoZSBjdXJyZW50IHJ1bmx0cCBpbg0KPiB0aGUgbmV4dCBmdXR1
cmUuIEl0cyBjb2RlIGNhbiBiZSBmb3VuZCBoZXJlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vYWNl
cnYvcnVubHRwLW5nDQoNCkkgdGhpbmsgdGhpcyBzb3VuZHMgbGlrZSBhIGdyZWF0IHByb2plY3Qs
IGFuZCBJIGxvb2sgZm9yd2FyZCB0byB0cnlpbmcgaXQgb3V0Lg0KDQo+IHJ1bmx0cC1uZyBQeXRo
b24gdmVyc2lvbiBwcm92aWRlcyB0aGUgZm9sbG93aW5nIGZlYXR1cmVzOg0KPiAgwqDCoMKgIC0g
Y2xhc3MgYmFzZWQgYXJjaGl0ZWN0dXJlIGluIFB5dGhvbiAzLjYrDQoNCldoeSBweXRob24gMy42
Kz8gIEZ1ZWdvIHVzZXMgYSBkb2NrZXIgY29udGFpbmVyIHdpdGggYW4gb2xkZXINCnZlcnNpb24g
b2YgRGViaWFuLCB0aGF0IGRlZmF1bHRzIHRvIFB5dGhvbiB2ZXJzaW9uIDMuNS4zLg0KDQpJcyB0
aGVyZSBzb21ldGhpbmcgc3BlY2lmaWNhbGx5IGluIFB5dGhvbiAzLjYgdGhhdCBpcyByZXF1aXJl
ZCBmb3IgcnVubHRwLW5nPw0KQ291bGQgaXQgYmUgYXZvaWRlZCBzbyB0aGF0IHJ1bmx0cC1uZyBj
b3VsZCBiZSBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGgNCm9sZGVyIGludGVycHJldGVycz8NCg0K
KFNvcnJ5LCBidXQgdGhpcyBpcyBvbmUgb2YgbXkgcGV0IHBlZXZlcyBhYm91dCB0aGUgd2hvbGUg
UHl0aG9uIGVjb3N5c3RlbSAtIHRoZSBsYWNrIG9mDQpiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBh
bmQgdGhlIGNvbnN0YW50IG5lZWQgdG8gYmUgY3JlYXRpbmcgdmlydHVhbCBlbnZpcm9ubWVudHMN
CmZvciBiYXNpYyB0b29scyBhbmQgYXBwcy4pDQogLS0gVGltDQoNCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
