Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1808FC32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04AC83CA247
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 16:10:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BE0B3C98BF
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 16:10:40 +0200 (CEST)
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com
 [68.232.156.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 308FF1400E14
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 16:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1660918240; x=1692454240;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ie5uXDsKYvAmJholK+YMqXB2ShHiVZdRbC1Hj1vM9f4=;
 b=x3DZnna1SbtImeF1gmqz/zlh1GCC2XY9oikjy4fdBdhnC63HRoXW3CrT
 R8UJDjUynAGCfXPIDKbY5ryZtXR2HXeexAd/bTK/+1n1BiMuR9FRCOUpm
 hVoTHYbUEz948kHsu2i7F8up9cKAf5x7vHRjfD1s3RRI7S48VqN7Ny6mh
 ous/BjxxOT13PVxC+j2fVJbTVQlJVV7g6aDDK7FmohtgLZZTJ29/SZpar
 SWHsawtLEIB0xOyFVhNEs/BFwhviiaYlZXc64t8MlKg/zvS90NTvbjQxC
 74F7L/jW9+RlVSh9Nbrjmf5/erUAmOnS+vFlsCl81dtMi0Mv5p9QsCL5t w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="62818180"
X-IronPort-AV: E=Sophos;i="5.93,248,1654527600"; d="scan'208";a="62818180"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2022 23:10:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO/SNT0tNXnwAKJRqXTOwwkHy+kBSzz3+C9GWjJ5GOnaOnBMNqE24k6dNVIEAMjqIBhyHrupHKKE4e2uNf7I1Ip9ZKm21NdM3/PkPQ/JkxNPF1xoTNLNb/ktwqXDMInel9SdpsQ7PPjHhIe6MlQsVMGHcZyNCqmXqMTaEXb0fpjECaDMCpeWtrnNWYgtrARKBSrsPdQgSqgO+6jf7qpd+QhpFQTGMZJE6qJpn75xllcwoPEhRs5ymtOYh8XREeZ/zDAOneMCoHX48NMh/z8DhjWpYTshADYHASDn33IOJphVZ/clGVcYNnZfhm+DFAv1E8dKItiDERfTc6dZha9BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie5uXDsKYvAmJholK+YMqXB2ShHiVZdRbC1Hj1vM9f4=;
 b=a/LJNfcmsZz2a+omo1PV/4TYvdoYJciHA6m0Gw1zLqx7lsZcBjBZ9Ll6/tqB0g/TzQIXD6oWPdwcEmCJzzfm7F5GugQJXKJQLtI4ACDCOQDYDEyW4leQOIcCfPHwrwx9z6nTWE7X4zBwNgqI5PyFuAPFgSJMGZet1qK1+gBwglTBU8GzUU4niJhsOsat7yDeV1emXJpnIWCwGO1dIc2dP88zqNsGFT54F58wCqaK/0zOOxqhP3GJNk+uChSl7STfFt2taKwRka0giX2mPBM7vR8e8p4ydnMUVZamh88rsScPyNGE3gZlkiwFi2DQ2hvB8KOag03z2NFyMxsvQ14xcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4851.jpnprd01.prod.outlook.com (2603:1096:604:6f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Fri, 19 Aug
 2022 14:10:33 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::2440:60cd:7bc9:5d48%2]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 14:10:33 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Li Wang <liwang@redhat.com>
Thread-Topic: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
Thread-Index: AQHYs6sbVtcKUuJd90ucFfHvyztCDq22D0YAgAACLICAAB05AIAAJecA
Date: Fri, 19 Aug 2022 14:10:33 +0000
Message-ID: <75b595dd-fdcb-73db-0e71-d36d665bbad8@fujitsu.com>
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
 <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
In-Reply-To: <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43fb196a-3c86-4471-3134-08da81ec9499
x-ms-traffictypediagnostic: OSAPR01MB4851:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah+x2Q7Prj9WkfXg3xBG2oCOG2jrV8KkSYcZriePpxmrsTw6cFXbXrbT6vAxWgTiq+pIepNxFf/vqUhso1TX/vlJj2V5b82Yi5LrsyerXuDmOr58X1Ue6ArS8wi7+Gg1AD6XZmo86LG23YqQW0oORpKYci9jtZ/eDj/WHOBzNm3tcjZswTLYh+oIix92wKl+cLg0cuHDHtQ2EFCK7nY9/qRHwD/vO9QGJs112ZPqI4TnAw2Wm0siBuJBVDfG0sP4ZilAhYHl/WNNN9Wy+XwneqW5+FpUMWw+DyHnfWp7zJJ0oz3vXQdlL1swxN+9MSuyB4s9nJXsdIYS5yyGcBYl74r8mXzL0lnODrgEi7HScWme46lVAPGCydXWAng2doaOff+nRzPI88WwuXaB969pAkPhe6/3ZtJlokdDrIWQJGLYaTcZR5oNfUaIOfcvKkdfbqCaZJLJU7S29JGLxdgk5wzHFMtD1OY46i3hIWJSEYK+V5fxz4Mk2JBoU1CT4bC0NMqrT+iQN1LGECzXjWw8bhHkBYuFb1xuZpreZ7XUhcPYBY7kgjFA5UB3WSj2o34QbMHol7Oh9GWIqSpif3BLYlt516EX0Hxi7Try6MqowZyYlLxWFq2VZvXXXHpp9I55RUL0xW1lPyq1dWroD9/GrRHob5CFIKa5cZrWmrp59GLPOfdJgR2tGmjkO40QTt6qRyBv/eAfcPupkIjVCUrqNrSSZr7eRNo873aF44+IpwhDIeBcK9eUZl2H4smsRaAUZ0XXqeW2XTqVKcl5d46zTrg5KXuaeaBIWOiZonewM+rYmrfi56yZwMgYXGwnghCa2AlG4hvBV6CdnYSXriBvjvzqc6O57QXAyw+OuJ11+MaIWUZSWhdQixrla7JJUJ3FOxNgNxo63CRDPELoHdom8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB4427.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(85182001)(36756003)(31696002)(86362001)(31686004)(38100700002)(6506007)(83380400001)(6512007)(186003)(1580799003)(82960400001)(2616005)(38070700005)(26005)(54906003)(966005)(6486002)(478600001)(41300700001)(71200400001)(4326008)(6916009)(91956017)(64756008)(5660300002)(66556008)(66446008)(76116006)(8676002)(66476007)(2906002)(122000001)(66946007)(316002)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDF0ZVA4WlRwckFpeDdyWkgyQ3pYbDcvbStPZ2xGYnlTR1FDaDExYlN4YXQz?=
 =?utf-8?B?bytkZUVNWXZCR3NzVDhGUjlVb2t3YXliWlNMRHlETkdubnB0aFJGRFlQRVRN?=
 =?utf-8?B?NHJkYXg2anZqME8rUk1ySVNuUnJ1b1cxRWZFOFUrbXJZanc0VlMvK2Z5Uml6?=
 =?utf-8?B?ZDVPdS9KK1pUa1YwRTFIOHRXNzdDZm9RRFhSeENXeHhQTHlsMnJ5dDdxTWJo?=
 =?utf-8?B?b3BWajExTDlkRlZWZDZXZU9teElzQmxabksxWGg1RnAvSC9tWmZrTFhsK0o2?=
 =?utf-8?B?VWZPNTVVbk1aMHhxRTlvcWtuYzN4UnVSZzIzQUUzL0lSMXFyendsdFQzY1JP?=
 =?utf-8?B?NWRZSUR6ZFF2WFA2ZFo0ZEFOV0daOGZWeEZnVFJIME45YThRalFkQWVzbzFj?=
 =?utf-8?B?ZGZzeWxwek9Pc3NMRm85QjZ1TnRkTHltV050OHB5T3ExUVZSMGRkK1VyZHVS?=
 =?utf-8?B?L1ZBRFZKZVptQkMxVTVrZVo2VW9Ga3FiVXR6MWxCN0dFdHM0dE5LWjcvNWgr?=
 =?utf-8?B?eHRMUFVOK1JtTUQ0OWZIZXFCOUwvZlp5aWxlS0tjYlhMMmlobU1IZ1NRN3Zk?=
 =?utf-8?B?QTZIT0I5UzZhMU1qMTFuTy9rK1lNU3ZScUduQTVIei9nZ25RR3R0VkxpMUpN?=
 =?utf-8?B?OHRiZFQwNXQrMlVFUnVGRWREWmR2eHVmeStpQ1RsOHdqajg4NlNBNS9VeW5h?=
 =?utf-8?B?MGFUSEZ1UXUvTTAwUDBMQnA2Y0NBNVVrR2ZidXdSVlM3OEdlT2gwcWR1UDh0?=
 =?utf-8?B?Vjc3Z3kvZ2ZRUW1Vc0VVdXJ5TVhYTkhpTzlyM05qV1htNFJIdnlVRmFJRzVS?=
 =?utf-8?B?MkNkVDNEZ05uWUtjT1ZEaHlEK1FKekFyRXBNb2VHQ2NQSVhXUlRmbE8rU0Zj?=
 =?utf-8?B?TVlJT2IyQ0pUVG1Wc0JNNHE4S2ZWUy92Qml1VUpTbXpIRThqUGM0Yms1cjNw?=
 =?utf-8?B?RGlKSzNsSUxjODZ1Nk04SnZYdkt3eFAxWGpwQUtJNmVWUktoLzM2UnNwMnhl?=
 =?utf-8?B?aWU2SS9CRTlabks1UU1RS2dKU09lK3BnRjZwcE9QbFFNSlJpQnJ0dmtNZTBR?=
 =?utf-8?B?UkNrcUpvQy80T2FIRkphL1Z2Q3ZsNng3RWt6aFBpWGVKa0NXZW5TNzJ4SkJh?=
 =?utf-8?B?bEl2N1lvbXJFcnNpc1E1eHo1TkVRT25YWGxZZTZjaWJ3cGtPMC9LM1VnRkFp?=
 =?utf-8?B?ZklWWVg2dC9ENHQ5OUw1TzVmRE41MW80MmdNeHlhRC9oUERLS0NjTlBIck5C?=
 =?utf-8?B?eW1oTXBjZjIyRmljdHo3UGdBempRUjBoZ0JjQnFVRWgvOTBXTmxmcldXTXl0?=
 =?utf-8?B?Q2F2Q1ZmcCt2OG52cGpjeDVTcVFRU1JwamlpejIzempFNCtYdVkrT0dPSEI0?=
 =?utf-8?B?bEZYK3hadTB4WDlIemRzNUJFWWFsaEdVbXBoS3A0VklhbEZPemNiZFZ1ajFM?=
 =?utf-8?B?TDRrd084MzhzTjh1SGxNdTBhNjhkb0lQTkFBd202V3VGWkVuN1I5OGcxa3V5?=
 =?utf-8?B?NDUyeXEyR2ZCY2grZnlkNzlXaHJGMk16WEtTNVB3RWZuUDFvVHpkV2ZTcHhu?=
 =?utf-8?B?NTNtM0tjc2UrWkM5ZjMvSGIzaTFrV1JsNW03ZjRlSlZQL3VIbXB4OUN3bGlV?=
 =?utf-8?B?dUtqU2phVHZ4SXBQakdKbExuVTVBRWROVGd3MlJrOXZsTCs3OFV2UnRDT3k5?=
 =?utf-8?B?WEtzcDkrLzQvZU1KKzI2aytzclI3MUlzcm1Cd0libE5VU0Vwa3JkaUxBZWpv?=
 =?utf-8?B?SThSa1d4YjliNnRtZjVRcFhXaWdjVDhRMmtQMGt2YUM5U0RLeVIrd2NiaHBD?=
 =?utf-8?B?KzR2em1lMDk5TDJad3BmYWM3b3RrbWd4dURPRi95Z20vMm1aQUpMZDRsbVli?=
 =?utf-8?B?YTZucTcrMWt2RGFSemVGWXZWMk0xY1RjUG1uc1IyQitLeGljYVNNaGtmN2xt?=
 =?utf-8?B?Vjg2TzVLSjZ5NmJvd3VxMVAyOG9WSkRxMFc4NDR0YURTOXNjV244NnRZUkhQ?=
 =?utf-8?B?VTQ1T00xY0NZRVllblBIekExMXJaak1jTHpxMndjQVFMQkF3RGxBUGZvamJW?=
 =?utf-8?B?azZ1eUtPQzgxWmxCb2EwcHhtcWc1bDg0aFNVYzhVQUljNHZLVkMrWVNLQnRS?=
 =?utf-8?B?THJBZ3RvTlJrb003dUNCa2dTYkFRK0ZxMjNRNG9oczduZ0xLdG1lWEdHMVVo?=
 =?utf-8?B?b0E9PQ==?=
Content-ID: <E99A124188A13848952C4C473D674F30@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WBGnA27TfT8jlUWaInLcC1ZKZW2kQXEaIJKHv8RP9sqyMU4B7vKJSHsGquDsldiwiiIl2gSuhIRWLeMOCeIO1n/NR1aqlCZWDc3QMNelWs3afx0LP2l3P8PJQPZ71Bzgx9QNzhFeS9BFW0Bwz/hwE5+onKiQRn2GcZpNUCKYjDE9zW8nhv1n06xIzgX99+b/iPJO6fhDHxj5L+6wbeUBmL203XerD4M9Vqhq+3qFcmURNJ77aS0shZg7lyAhBxa6eZLpxZ8Iv0AKNaaRPauszDwY3u5Z6kQWYWtJ0HPF55UnyD95QabaDMBAIJDZJnpU7b0QUSpQnuabFGbocDMMCNRRTrFDXrJ+2+TARohXtTKmeJ9nXXqFf0L3YMTozCLfRTQY85dWAVW9WJYrUBmD96CWoV+jxcGTtu0GAiDYNGJq4FcCLB9mu4PVOpP9NxybPdw9gFCcl6WD6K/J4BqZwxKMiIbST6SiNF6CQrclfPLePViGNXHdi2k02e6UIMwl2mAQXXRTieMPFQ5q0tCicyr21XjbBri5OniZpxNZpCrRD9f4vIQbryBAlNmUawf38535mj5yEtyys/5suXup43As90/sXPF7A91pXkyiMxRj2tovB9zB26GtLl30Y+pP7MItrEe1zWyl+kL3wUq2cgE6rCWUj5CjDJ2Ik9kG/dNmswqIUDLc39zr0R2diMkZghPmykVELllXo5ZQK1/mXowTqe8avcvAw8vNuNDFlskP3NMIvd8vabFZyh+oNtQecsPKqfEPQ3dS6N+3kyp+nV64BMZmGhuTn7//RWlyyEPPCoHuJ6zz27k43tlgSK1scBigrfjvm4FCU2H7XvVsnOXlJXc5B5iN5QXYFc5kjXU=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fb196a-3c86-4471-3134-08da81ec9499
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 14:10:33.1366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UkR+VANrWnwoQbs15QE2T7YR4uy/ByEOOpv2eupFJlLSXS064bEcnLD/4U4flZ3Yh3W1oPb236iIcFD1wWK3TxXSQzgXhj0mMcEkRHoP7V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4851
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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

DQpIaSBMaQ0KDQo+ICAgICBTbyBmb3IgbWUsIElmIHJlbW92ZSBrZXJuZWwgY29tbWl0IGluIGRl
c2NyaXB0aW9uLCB0aGVuIEkgb25seSBzZWUNCj4gICAgIHVzZWxlc3MgY29tbWl0IGlkIG51bWJl
ciwgdW5sZXNzIEkgZ28gdG8gc2VhcmNoIHRoZW0gaW4ga2VybmVsIG9yZy4NCj4gDQo+IA0KPiBO
b3QgZXhhY3RseSwgYW5vdGhlciB0aGluZyB0byBtYWtlIHBlb3BsZSdzIGF0dGVudGlvbiBpcyB0
ZXN0IGZhaWwgd2l0aCANCj4gaGludCwNCj4gdGhlbiB3ZSBjYW4gc2ltcGx5IGNsaWNrIHRoZSBs
aW5rLg0KDQpJIHJlbWVtYmVyIEFtaXIgYWxzbyBhZGRlZCBhIHNpbWlsYXIgZmVhdHVyZVsxXSB0
byB4ZnN0ZXN0cyB3aGVuIGhlIA0KYmVjb21lIHhmcyA1LjEwIHN0YWJsZSBrZXJuZWwgbWFpbnRh
aW5lci4NCg0KU28gbWF5YmUgd2UgY2FuIGFkZCBhIHRoaXJkIGNvbHVtZSBpbiB0c3RfdGVzdCBz
dHJ1Y3QncyB0YWcgZmllbGQgIHRvIA0KY292ZXIga2VybmVsIGNvbW1pdCB0aXRsZT8gVGhlbiB0
aGlzIGtlcm5lbCBjb21tZW50IGNhbiBiZSByZW1vdmVkLg0KDQpBbHNvLCBJIGRvbid0IGhhdmUg
c3Ryb25nIG9iZWplY3Rpb24gdG8gdGhpcyBwYXRjaCBiZWNhdXNlIGl0IHNlZW1zIA0KZHVwbGlj
YXRlLCBidXQgSSBqdXN0IHdhbnQgdG8ga2VlcCBrZXJuZWwgY29tbWl0IHRpdGxlIGJ5IHVzaW5n
IHNpbXBsZSB3YXkuDQoNClsxXWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9mcy94ZnMv
eGZzdGVzdHMtZGV2LmdpdC9jb21taXQvP2lkPTRmYjcyY2ZmZDllMzI1MTE0OWQ5ZmEyNWRhYTk2
YjJlMjZiNjJlYWINCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+IA0KDQo+ICDCoCDCoCA1OAlI
SU5UOiBZb3UgX01BWV8gYmUgbWlzc2luZyBrZXJuZWwgZml4ZXM6DQo+ICDCoCDCoCA1OQkNCj4g
IMKgIMKgIDYwCWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTkzYmM0MjBlZDQxZCAgPGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9j
b21taXQvP2lkPTkzYmM0MjBlZDQxZD4NCj4gIMKgIMKgIDYxCWh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lk
PTk5NjUyZWE1NmE0MSAgPGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTk5NjUyZWE1NmE0MT4NCj4gIMKg
IMKgIDYyCWh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTA0YTg3ZTM0NzI4MiAgPGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21t
aXQvP2lkPTA0YTg3ZTM0NzI4Mj4gIA0KPiAgwqAgwqAgNjNodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD01
Zjk1NWYyNmYzZDQgIDxodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD01Zjk1NWYyNmYzZDQ+DQo+IA0KPiAN
Cj4gLS0gDQo+IFJlZ2FyZHMsDQo+IExpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
