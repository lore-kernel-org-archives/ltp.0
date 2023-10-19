Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51488CDB47E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 02:40:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19433CF55B
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 04:40:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEEAF3C88A4
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:40:07 +0200 (CEST)
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com
 [68.232.159.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C754E200AD8
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 04:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697683205; x=1729219205;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=OWDUmEvNPamATf4oMt0ieL8Tvi7LuDc0cu74bX4dwPg=;
 b=k480nKhLcAqhB+MUk6WjFSI+qMGDjgX4/wgY87AbxZT+UcrzOgwYPN+L
 ejVQAM0kemzDzoSfcb3IHt8Q+CsX07lCmUtzG2L7ji/CUDTNJ/wDHNXzU
 uPqiGXttR/501BhF9jT/XWdM6JJrj0YvtPdOdyUeGDH7q90WWbWTgt5xo
 0bptyfYyggJf02v+ZkODSvLgo5gISy8u6zF4uuk+JN/2BOIa8yIG6q6r9
 tdN2a0tP+vDQXIf0vhv7CdiGMVV+QhIjgrWSQua3Lldu+ZMc9XbX3bV/G
 K2yVmxBFXpQM6ugIET0/37osMRQMx5q9um+yauytuSXgjFYlERAu4vV59 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="99778140"
X-IronPort-AV: E=Sophos;i="6.03,236,1694703600"; d="scan'208,217";a="99778140"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 11:40:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLNpyTWrxgJ+ZhlU+fWcI865uPxKj4VojNA+GNrVRpsl8/ncXlLyh52qYwhorROJ0TXOKkdGOBtXJdnojNjpxkD7/wm4pMCnQnKcHq55G0HRUpysGC5eW8yB3sTZwXRolNmebX0XUr5kP3Vfe6bYdqPSRUXK/qL90fbg4wFTqRnTfMR8ecClBYQ6vOcFQ25XfPGov/3jZzgLNMA6tdjy4lgUQS89cReFC0csRpFL4khYjPh99XMxvcCi4a85Wcv0LJ3wD7aRISEosZRqMH3AhNJcgsmy2iHklCMYWoHCdlR7aLkFV46+28zwTopMg6O0e/HrObX4Hgnngv++eA3MAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWDUmEvNPamATf4oMt0ieL8Tvi7LuDc0cu74bX4dwPg=;
 b=RT1ShxKiTLwBUGfljw4kOinlc7XEkaLa0NGZLyYpoGo9CCutFzaMqA3GVbranwZwIHMpixOq5SvKB15VBZOiyWTo8Zd144cFiBW9Aq7nyoS/WqiUbwL1BuhNhXwA4fDXiAO4/l8VDurdS5OkS/rHU/bIUyYxMb9Y26pnFQXq/4eaQXYKPE20mhG4OMP2Zu3Fc21lFWRKfmvmxGfD1WHjGysxLiW8FayL63cnfK+gnKfmsfWYJYx0G7KpDyUIY1CWh0Co8RVrTJhVNjsepRaLIz9A9LrOVBvPWvvkYOnSdX/Q8DHQlG1cY8DnUbIr6vaAazryrBHCcUsdsnfgSiXipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com (2603:1096:604:23b::8)
 by TY3PR01MB11929.jpnprd01.prod.outlook.com (2603:1096:400:407::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:39:58 +0000
Received: from OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a]) by OS7PR01MB11839.jpnprd01.prod.outlook.com
 ([fe80::a5d2:bd3a:8420:bd3a%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 02:39:58 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/2] syscalls/fchmodat01: Convert to new API
Thread-Index: AQHZ7Eug9Be/6P4hYkOuIbSsVyDmYrBOE2eAgAJ/GoA=
Date: Thu, 19 Oct 2023 02:39:58 +0000
Message-ID: <b584341e-2073-49a7-87a8-0e059579853c@fujitsu.com>
References: <1695273748-4607-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2dPkt8pTpf3b2i-s6Qaem3z+Y-7w9rVbOtrPNdwuTC4+Q@mail.gmail.com>
In-Reply-To: <CAEemH2dPkt8pTpf3b2i-s6Qaem3z+Y-7w9rVbOtrPNdwuTC4+Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11839:EE_|TY3PR01MB11929:EE_
x-ms-office365-filtering-correlation-id: 5ef4c68c-173d-425a-d91b-08dbd04caf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vQF96Vy/8jeNemB4EJ1kNoTtLASkqxSPTgjrht5gr84Rsmr+KPg5tq3LMCgedsrAI50P5uJQ2lTKetPDjKuvFWkWU7eQtTUR19Xj3tnw1/OC+sU9w1jbOsLkHu4Mx0pQ4j2KoFUe6Q7wCAIgvjUVieeXtP50YgsF6L2NL7N0LC+5dqEJ5qnl1w4/6MClfQDLOyiajBdT+6cyX9oeRJoLOI3TNuI5Pi2vsES9oiteGNzp0h0Er87XiCoTMpEsFckRXi9nkARXX2ieWjxOZCX2PQ8Yc2JeeW9vIyA6ND/SJYcLdRDCBYWM2qMeg7iO2Cey3R5QMnxmrfW9Sq/WOLVQclmxLmbiJjidIrnk2HF6RJIY+pU3A4E/8PGpGOL4BKFSMzGh9bQ39DhrC4o7inCyFE1AXi2Rp+UR4lFCSiHdEaob4kvq/DBOqGFqrF0+iQM7yNWFgwHvEsnv/BJoh5dSlBxqVONKJU6wzF86cHrWP9pFeGu5HkXDfyK0k97xkD0h7HmaV6nGd3VC4DxGkJIRAW/UDeVDbvKhoG9LTSdeOalVibHyd5IgPbAZ8Rd22jjPWHEu7KGzFsvixH4lXo9iLCPcImGNdaf290URh9EK6qSziHoFD0QWQd9nuYHI1108m1cxjNSxS4+m9jZEzsMj0mBl4pMhVrd3jt549Kx5hz+grOZoBjQKR0e6tYdSCpB7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11839.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1590799021)(451199024)(1800799009)(186009)(64100799003)(38070700005)(1580799018)(82960400001)(38100700002)(122000001)(86362001)(31696002)(36756003)(85182001)(6506007)(6512007)(2906002)(64756008)(26005)(2616005)(53546011)(71200400001)(8936002)(8676002)(4326008)(31686004)(5660300002)(478600001)(6486002)(41300700001)(66556008)(66476007)(66446008)(316002)(6916009)(91956017)(76116006)(66946007)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3ROY1RVVWJGN2JrYk4vUTJRVmVZWmxRTmEremp0L0VrdkhCR1Q4a0s2eUdH?=
 =?utf-8?B?anA1bEV2WnVkdmt0RXd2MkFCemRTQmo2ZHV4eGUreFZOTGFWeldHY0p0T1BP?=
 =?utf-8?B?VHg1MUtTOU13TjJsYWJvL29OMDRPZXFmR2R2OUVjVWJZZHlkUXdvcUFmMGhM?=
 =?utf-8?B?U1VGRmkrNVRKUkdBYkZVa2dyTElYWE5Ba1JpVStwOEt3bldXZmcrUmgvNkQ4?=
 =?utf-8?B?S25qaGhGWlBaci9pRkhlZitYeE1yeEtVQnVVWG9WSlJDbm5xb21jMWxPdlVt?=
 =?utf-8?B?VjluVzBnemtWQVZvbW5kaFpoSWhUdS8zKzg3T1RVMEN4WjJqalVhNWhkOGpG?=
 =?utf-8?B?c3Jpb3Erb08vSzBzU2hDUTQ0b2pVSXIvY09JSk52cytQQitpS3hLMUlDOG4z?=
 =?utf-8?B?M3RoV0E2a1d3SWJNdE9EeGRyYlpXczZFMDFqY0tOaEk0VzFUN29YY0N4MG1h?=
 =?utf-8?B?aUJucjJ0QzdVWG9uQkYvdFFTVS8wRlJDRHZpVG9RRlByOTh0ZFprQXJiMTVk?=
 =?utf-8?B?Zmo1aTYxMWtidjBCanljbDJ4ektXMnErSlJzUkxPVjk0K0Z5TWM3N0hpWHkv?=
 =?utf-8?B?NGVVVmNjTGo0REwvVWs1NGhHellFMDdoZVMvZDBWRktNYVVQV3BGOWVSZVpw?=
 =?utf-8?B?alFtTWp2bzQyelpESEhTZDRwSGQwQ2ZONnJvdVdkbFp1T2tWZzlxRk5VY2Fh?=
 =?utf-8?B?ZXNFU3c5TXhvT3hKeC9JVU1USkFPRWtGajZRZm0vNE05TjN1TWgwc0VTTTZk?=
 =?utf-8?B?VUswM3doSEVUQWJndmxod3ltcHM0MExIN3NCWUZhTm01NHBqUnF5OFFTWTFi?=
 =?utf-8?B?WGJQRC9vQUFPVjZrRW5IZCtITGJQYzkwTkg2c1dVMmttdVp1ckZoMjdYcHNw?=
 =?utf-8?B?bGdYZ3d4OG42eTBoYTgzVSszK2JQS1hxZittVm1qNmR1SC9oU2VGL0tPK0lS?=
 =?utf-8?B?VjZ5UkxMMitpbUpuN0JKUCtzMWhyU1V5RUNRekNSaVZzaGp1T1B0NDJJU0hP?=
 =?utf-8?B?QXZzN21hUGZNWmZjeGtYOWsvWmJrM05rYU1KSUcvQUpOMC91Tzd6dzN2RnNW?=
 =?utf-8?B?Nk4raEVOSEZoTlc3NTdIdU9aUmpscVlFUVJkL0ZWU25qOStGMlNPNC9VY09T?=
 =?utf-8?B?YUNmQlIzS3BXYkxUbDFFL1FiZnZMYlRmajRtSVZReEpjYVNWaHluVnZzL2Ur?=
 =?utf-8?B?dFgvQnlMMEtodWtydUVVcHVoRklEWHowYTJ2UWNPdHU5SzZiQXRmMjNCSWF4?=
 =?utf-8?B?RlRzUC9MeEg2TEdnSUFIV1BwbVZ3WE5kVjJrLzVuZmNKcmprNFhoN3RaVC9r?=
 =?utf-8?B?U29QaThWa1RjME9uckpjOG5uQUszbHpkcVE0c3pKRHZqazNCRHRQZDFJVDBK?=
 =?utf-8?B?REVDSU44N3IyVE5wWm1zZ09QMUQvNXUrVml1bEwzZXJSRmNkTU5zZG9RM3Fx?=
 =?utf-8?B?T1psdE01MUZJay9NQlpoNE0rSHE3T0RRd3IzdGZYUHVFLytlZjNnSGpMN1Y5?=
 =?utf-8?B?YzE2akhURjZFSXIzN0ZyK2M4cmNEMW1TQ2hxRmprVnFTTThFQ05sNzRKTWtj?=
 =?utf-8?B?MUp6NUlHTklIQW9KUHRYeDlxd0RZYzZ6dDZIZCtZVkM4QmpUV2M4S0wwam5a?=
 =?utf-8?B?WHpVak5iQ1JOS3lVanhqVXFBeXBhUXFGR3BKM0duUjZXRG9oeFJ0cXA1V2VF?=
 =?utf-8?B?REJyOEtQQWJiT0JKV2ZMOHBNQTdzMjhaWWZVNDJFMGhYNDZPNWY1TllEaDd3?=
 =?utf-8?B?T0MxRjhLZ0IwU2xVdWoxeDRlNjdrZFp4UEIvb2FYVzZ5MzJ2U0JzQUdDMXV3?=
 =?utf-8?B?QmhEYWx1KzV0UncycWxqb0FBVjkrdnpkYkdPT0JwVFM2VkViTUNZWW5hanJZ?=
 =?utf-8?B?RS9PNktCQ3U4aFh6RCs4RDhHLzZpU2ZKWDhRVHdHbmQ0T3NRL25wMEk1NlFF?=
 =?utf-8?B?bjdoWUtVdHJDSkFoRWlxZ3hUVWpsbjNlS00zcVZqcGNsU1BnSnhkMmJtclE2?=
 =?utf-8?B?U1hUcE5rNmlUb3prMzVTbEJ4aUF4N3JyWHJsRmVqd2NFREd5MWZneU9ELzZh?=
 =?utf-8?B?U3lFQjJMRFFqZUZLbHg5eG5PenBrZFk4MUNjR3Joc01RZnBoR09kcWgyRmEy?=
 =?utf-8?B?azVXQjI1cXcraHFQMWVBRkZ6QVhwSmNLSUkrdEF5c2lxTGh4S0FHcXJ2cVRm?=
 =?utf-8?B?RWc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CtsRj2yGJg7BoOiE9DgDc8wSPlEm4CZ/2BjthrSSlyhGCjoqBQJm/qmPnGBm3QFroVPsWxjd6VULwI9w4ImHi6p4LzDZJR4JXAODi0+MBokQY1fMxKMuiVrWvwJsgP3AL3GED/a/adN+eoRNHekftSs1SvP0nHQpfP17WegRw/nwvdsIFw3faIAgDlHMw3ZK9WwdESBYrEwYKTnIFLgIiXcTt5UNtauT0W/9iALJKG8ShrIFRN1fNPoTXtCdAHwGNr6QUJk6nd8vPCWTlAoJVcW7yFg4AitwSVia0VXHX9Trmb4GZaGU3NQaavxYHp7wkB7ZLQYbB4jraJgHBRp2952o0eo60nQjw7EPcxR/waMOkiC7K4Bj6Frcoz4pTa4pMF7eIXnfociFkq38CpAnjexUAeKNEuy0lxInTSYBmkLmX9qsSBg5CuBP6D1hjK+jdpNIar8Z4gqo3XW0GdVjGcPYKD3uINXEQbJJldigKGyOq/opH95G3ACiubsDoL8l8yo9rX5P2te6MKKbH+HkW8vspGBlU53lMvgfMM0txcd243qT+NPC+Y2jPPrim4DRN8LJ7/9Rl4YT6q2JFAugErnI4PiHP1nx2xHvpTu0Lmv6YAmpaZWYCESsmOoKb3Q1hZwOAeIY4fEtQGqGSH6prhCV1EYlX2MdJ5ekZ6nPw9PNE7l63xvBI3VhbDrP0jnlIrlZOVYT4FNjK5m92cds5jx6X7r6TBTyY7Vr/Exy8L9LwNKM/ogZm5sD/EAgmFP2ahyxnpDbfKOLouRkRSM3v7d0L97ROYZdtGJ/qTfTTfg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11839.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef4c68c-173d-425a-d91b-08dbd04caf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 02:39:58.4642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fc8ajlKENKtyD+AcbLEIYoNkBbDU5ZEaTSEuedCqFazRxrR9YsSGVGOkKum138UMmpPhGlI8iquODEDlYkblOOI3OrhqSOfiYGwExZ2u8ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11929
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls/fchmodat01: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksDQoNCg0KT24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMToyMuKAr1BNIFlhbmcgWHUgPHh1
eWFuZzIwMTguanlAZnVqaXRzdS5jb208bWFpbHRvOnh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+
PiB3cm90ZToNClNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5j
b208bWFpbHRvOnh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Pg0KLS0tDQogLi4uL2tlcm5lbC9z
eXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAxLmMgICAgIHwgMTAzICsrKysrKystLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA2MSBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNobW9kYXQvZmNobW9kYXQw
MS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAxLmMNCmlu
ZGV4IDNkZWZmMGViZS4uZDlkYjRlYzEwIDEwMDY0NA0KLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mY2htb2RhdC9mY2htb2RhdDAxLmMNCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmNobW9kYXQvZmNobW9kYXQwMS5jDQpAQCAtMSw5OSArMSw3NSBAQA0KIC8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQogLyoNCiAgKiBDb3B5cmlnaHQg
KGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDA2DQotICoNCisg
KiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAwMy0yMDIzDQogICogMDgvMjgv
MjAwNiBBVVRIT1I6IFlpIFlhbmcgPHl5YW5nY2RsQGNuLmlibS5jb208bWFpbHRvOnl5YW5nY2Rs
QGNuLmlibS5jb20+Pg0KICAqLw0KDQogLypcDQogICogW0Rlc2NyaXB0aW9uXQ0KICAqDQotICog
VGhpcyB0ZXN0IGNhc2Ugd2lsbCB2ZXJpZnkgYmFzaWMgZnVuY3Rpb24gb2YgZmNobW9kYXQuDQor
ICogQ2hlY2sgdGhlIGJhc2ljIGZ1bmN0aW9uYWxpdHkgb2YgdGhlIGZhY2Nlc3NhdCgpIHN5c3Rl
bSBjYWxsLg0KDQpmYWNjZXNzYXQoKSAtLT4gZmNobW9kYXQoKSA/DQoNClNvcnJ5LCBpIGNvbmZ1
c2VkIHRoZSBwYXRjaCBJIHdyb3RlIGVhcmxpZXIuDQorICoNCisgKiAtIGZjaG1vZGF0KCkgcGFz
c2VzIGlmIGRpcl9mZCBpcyBmaWxlIGRlc2NyaXB0b3IgdG8gdGhlIGRpcmVjdG9yeQ0KKyAqICAg
d2hlcmUgdGhlIGZpbGUgaXMgbG9jYXRlZCBhbmQgcGF0aG5hbWUgaXMgcmVsYXRpdmUgcGF0aCBv
ZiB0aGUgZmlsZS4NCisgKg0KKyAqIC0gZmNobW9kYXQoKSBwYXNzZXMgaWYgZGlyX2ZkIGlzIGEg
YmFkIGZpbGUgZGVzY3JpcHRvciBhbmQgcGF0aG5hbWUgaXMNCisgKiAgIGFic29sdXRlIHBhdGgg
b2YgdGhlIGZpbGUuDQoNCkkgZGlkbid0IHNlZSB0aGF0IHRoZSBzZWNvbmQgdGVzdCB1c2VzIGEg
YmFkIGRpcl9mZCBpbiB0aGUgc3RydWN0Lg0KDQpZZXMuSSB3aWxsIGNvcnJlY3QgaXQuDQoNCisg
Kg0KKyAqIC0gZmNobW9kYXQoKSBwYXNzZXMgaWYgZGlyX2ZkIGlzIEFUX0ZEQ1dEIGFuZCBwYXRo
bmFtZSBpcyBpbnRlcnByZXRlZA0KKyAqICAgcmVsYXRpdmUgdG8gdGhlIGN1cnJlbnQgd29ya2lu
ZyBkaXJlY3Rvcnkgb2YgdGhlIGNhbGxpbmcgcHJvY2Vzcy4NCiAgKi8NCg0KLSNkZWZpbmUgX0dO
VV9TT1VSQ0UNCi0NCi0jaW5jbHVkZSA8dW5pc3RkLmg+DQotI2luY2x1ZGUgPHN0cmluZy5oPg0K
ICNpbmNsdWRlIDxzdGRsaWIuaD4NCiAjaW5jbHVkZSA8c3RkaW8uaD4NCiAjaW5jbHVkZSAidHN0
X3Rlc3QuaCINCi0jaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIg0KDQotI2lmbmRlZiBBVF9GRENX
RA0KLSNkZWZpbmUgQVRfRkRDV0QgLTEwMA0KLSNlbmRpZg0KKyNkZWZpbmUgVEVTVERJUiAgICAg
ICAgICJmY2htb2RhdGRpciINCisjZGVmaW5lIFRFU1RGSUxFICAgICAgICAiZmNobW9kYXRmaWxl
Ig0KKyNkZWZpbmUgRklMRVBBVEggICAgICAgICJmY2htb2RhdGRpci9mY2htb2RhdGZpbGUiDQoN
Ci1zdGF0aWMgY2hhciBwYXRobmFtZVsyNTZdOw0KLXN0YXRpYyBjaGFyIHRlc3RmaWxlWzI1Nl07
DQotc3RhdGljIGNoYXIgdGVzdGZpbGUyWzI1Nl07DQotc3RhdGljIGNoYXIgdGVzdGZpbGUzWzI1
Nl07DQorc3RhdGljIGludCBkaXJfZmQsIGZpbGVfZmQ7DQorc3RhdGljIGludCBhdGN3ZF9mZCA9
IEFUX0ZEQ1dEOw0KK3N0YXRpYyBjaGFyICphYnNfcGF0aDsNCitzdGF0aWMgY2hhciAqdGVzdF9m
aWxlOw0KK3N0YXRpYyBjaGFyICpmaWxlX3BhdGg7DQoNCiBzdGF0aWMgc3RydWN0IHRjYXNlIHsN
Ci0gICAgICAgaW50IGV4cF9lcnJubzsNCi0gICAgICAgY2hhciAqZXhwX2VycnZhbDsNCisgICAg
ICAgaW50ICpmZDsNCisgICAgICAgY2hhciAqKmZpbGVuYW1lczsNCiB9IHRjYXNlc1tdID0gew0K
LSAgICAgICB7IDAsIE5VTEx9LA0KLSAgICAgICB7IDAsIE5VTEx9LA0KLSAgICAgICB7IEVOT1RE
SVIsICJFTk9URElSIn0sDQotICAgICAgIHsgRUJBREYsICJFQkFERiJ9LA0KLSAgICAgICB7IDAs
IE5VTEx9LA0KLSAgICAgICB7IDAsIE5VTEx9LA0KKyAgICAgICB7JmRpcl9mZCwgJnRlc3RfZmls
ZX0sDQorICAgICAgIHsmZGlyX2ZkLCAmYWJzX3BhdGh9LA0KDQoNCisgICAgICAgeyZhdGN3ZF9m
ZCwgJmZpbGVfcGF0aH0sDQogfTsNCi1zdGF0aWMgaW50IGZkc1tBUlJBWV9TSVpFKHRjYXNlcyld
Ow0KLXN0YXRpYyBjaGFyICpmaWxlbmFtZXNbQVJSQVlfU0laRSh0Y2FzZXMpXTsNCg0KIHN0YXRp
YyB2b2lkIHZlcmlmeV9mY2htb2RhdCh1bnNpZ25lZCBpbnQgaSkNCiB7DQogICAgICAgIHN0cnVj
dCB0Y2FzZSAqdGMgPSAmdGNhc2VzW2ldOw0KDQotICAgICAgIGlmICh0Yy0+ZXhwX2Vycm5vID09
IDApDQotICAgICAgICAgICAgICAgVFNUX0VYUF9QQVNTKHRzdF9zeXNjYWxsKF9fTlJfZmNobW9k
YXQsIGZkc1tpXSwgZmlsZW5hbWVzW2ldLCAwNjAwKSwNCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgImZjaG1vZGF0KCkgcmV0dXJuZWQgdGhlIGV4cGVjdGVkIGVycm5vICVkOiAlcyIsDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRTVF9FUlIsIHN0cmVycm9yKFRTVF9FUlIpKTsN
Ci0gICAgICAgZWxzZQ0KLSAgICAgICAgICAgICAgIFRTVF9FWFBfRkFJTCh0c3Rfc3lzY2FsbChf
X05SX2ZjaG1vZGF0LCBmZHNbaV0sIGZpbGVuYW1lc1tpXSwgMDYwMCksDQotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRjLT5leHBfZXJybm8sDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICJmY2htb2RhdCgpIHJldHVybmVkIHRoZSBleHBlY3RlZCBlcnJubyAlZDogJXMiLA0KLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBUU1RfRVJSLCBzdHJlcnJvcihUU1RfRVJSKSk7DQor
ICAgICAgIFRTVF9FWFBfUEFTUyhmY2htb2RhdCgqdGMtPmZkLCAqdGMtPmZpbGVuYW1lcywgMDYw
MCwgMCksDQorICAgICAgICAgICAgICAgICAgICAiZmNobW9kYXQoJWQsICVzLCAwNjAwLCAwKSIs
DQorICAgICAgICAgICAgICAgICAgICAqdGMtPmZkLCAqdGMtPmZpbGVuYW1lcyk7DQoNCg0KSSB0
aGluayBpdCB3b3VsZCBiZSBncmVhdCB0byB2ZXJpZnkgdGhhdCB0aGUgcGVybWlzc2lvbnMgb2Yg
YSBmaWxlDQpoYXZlIGJlZW4gY2hhbmdlZCBjb3JyZWN0bHkuDQoNCk9LLiBJIHdpbGwgdXBkYXRl
IGl0Lg0KDQogfQ0KDQogc3RhdGljIHZvaWQgc2V0dXAodm9pZCkNCiB7DQotICAgICAgIC8qIElu
aXRpYWxpemUgdGVzdCBkaXIgYW5kIGZpbGUgbmFtZXMgKi8NCi0gICAgICAgY2hhciAqYWJzX3Bh
dGggPSB0c3RfZ2V0X3RtcGRpcigpOw0KLSAgICAgICBpbnQgcCA9IGdldHBpZCgpOw0KLQ0KLSAg
ICAgICBzcHJpbnRmKHBhdGhuYW1lLCAiZmNobW9kYXR0ZXN0ZGlyJWQiLCBwKTsNCi0gICAgICAg
c3ByaW50Zih0ZXN0ZmlsZSwgImZjaG1vZGF0dGVzdCVkLnR4dCIsIHApOw0KLSAgICAgICBzcHJp
bnRmKHRlc3RmaWxlMiwgIiVzL2ZjaG1vZGF0dGVzdCVkLnR4dCIsIGFic19wYXRoLCBwKTsNCi0g
ICAgICAgc3ByaW50Zih0ZXN0ZmlsZTMsICJmY2htb2RhdHRlc3RkaXIlZC9mY2htb2RhdHRlc3Ql
ZC50eHQiLCBwLCBwKTsNCi0NCi0gICAgICAgZnJlZShhYnNfcGF0aCk7DQotDQotICAgICAgIFNB
RkVfTUtESVIocGF0aG5hbWUsIDA3MDApOw0KLQ0KLSAgICAgICBmZHNbMF0gPSBTQUZFX09QRU4o
cGF0aG5hbWUsIE9fRElSRUNUT1JZKTsNCi0gICAgICAgZmRzWzFdID0gZmRzWzRdID0gZmRzWzBd
Ow0KLQ0KLSAgICAgICBTQUZFX0ZJTEVfUFJJTlRGKHRlc3RmaWxlLCAiJXMiLCB0ZXN0ZmlsZSk7
DQotICAgICAgIFNBRkVfRklMRV9QUklOVEYodGVzdGZpbGUyLCAiJXMiLCB0ZXN0ZmlsZTIpOw0K
KyAgICAgICBjaGFyICp0bXBkaXJfcGF0aCA9IHRzdF9nZXRfdG1wZGlyKCk7DQoNCi0gICAgICAg
ZmRzWzJdID0gU0FGRV9PUEVOKHRlc3RmaWxlMywgT19DUkVBVCB8IE9fUkRXUiwgMDYwMCk7DQot
ICAgICAgIGZkc1szXSA9IDEwMDsNCi0gICAgICAgZmRzWzVdID0gQVRfRkRDV0Q7DQorICAgICAg
IGFic19wYXRoID0gdHN0X2FwcmludGYoIiVzLyVzIiwgdG1wZGlyX3BhdGgsIEZJTEVQQVRIKTsN
CisgICAgICAgZnJlZSh0bXBkaXJfcGF0aCk7DQoNCi0gICAgICAgZmlsZW5hbWVzWzBdID0gZmls
ZW5hbWVzWzJdID0gZmlsZW5hbWVzWzNdID0gZmlsZW5hbWVzWzRdID0gdGVzdGZpbGU7DQotICAg
ICAgIGZpbGVuYW1lc1sxXSA9IHRlc3RmaWxlMjsNCi0gICAgICAgZmlsZW5hbWVzWzVdID0gdGVz
dGZpbGUzOw0KKyAgICAgICBTQUZFX01LRElSKFRFU1RESVIsIDA3MDApOw0KKyAgICAgICBkaXJf
ZmQgPSBTQUZFX09QRU4oVEVTVERJUiwgT19ESVJFQ1RPUlkpOw0KKyAgICAgICBmaWxlX2ZkID0g
U0FGRV9PUEVOKEZJTEVQQVRILCBPX0NSRUFUIHwgT19SRFdSLCAwNjAwKTsNCiB9DQoNCiBzdGF0
aWMgdm9pZCBjbGVhbnVwKHZvaWQpDQogew0KLSAgICAgICBpZiAoZmRzWzBdID4gMCkNCi0gICAg
ICAgICAgICAgICBjbG9zZShmZHNbMF0pOw0KLSAgICAgICBpZiAoZmRzWzJdID4gMCkNCi0gICAg
ICAgICAgICAgICBjbG9zZShmZHNbMl0pOw0KKyAgICAgICBpZiAoZGlyX2ZkID4gLTEpDQorICAg
ICAgICAgICAgICAgY2xvc2UoZGlyX2ZkKTsNCisgICAgICAgaWYgKGZpbGVfZmQgPiAtMSkNCisg
ICAgICAgICAgICAgICBjbG9zZShmaWxlX2ZkKTsNCg0KV2h5IG5vdCB1c2UgU0FGRV9DTE9TRSBo
ZXJlPw0KDQpZZXMuIEkgZm9yZ290IHRvIG1vZGlmeSBoZXJlLg0KDQogfQ0KDQogc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0gew0KQEAgLTEwMSw1ICs3NywxMCBAQCBzdGF0aWMgc3RydWN0
IHRzdF90ZXN0IHRlc3QgPSB7DQogICAgICAgIC50ZXN0ID0gdmVyaWZ5X2ZjaG1vZGF0LA0KICAg
ICAgICAuc2V0dXAgPSBzZXR1cCwNCiAgICAgICAgLmNsZWFudXAgPSBjbGVhbnVwLA0KKyAgICAg
ICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsNCisgICAgICAgICAgICAgICB7JnRl
c3RfZmlsZSwgLnN0ciA9IFRFU1RGSUxFfSwNCisgICAgICAgICAgICAgICB7JmZpbGVfcGF0aCwg
LnN0ciA9IEZJTEVQQVRIfSwNCisgICAgICAgICAgICAgICB7fSwNCisgICAgICAgfSwNCiAgICAg
ICAgLm5lZWRzX3RtcGRpciA9IDEsDQogfTsNCg0KVGhlIHJlc3QgcGFydCBsb29rcyBnb29kLg0K
DQoNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGllbnQgcmV2aWV3Lg0KDQpCZXN0IFJlZ2FyZHMNCg0K
WWFuZyBYdQ0KDQotLQ0KUmVnYXJkcywNCkxpIFdhbmcNCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
