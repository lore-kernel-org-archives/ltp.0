Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21D3F459EF
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775839356; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CMjNdtfRTXz2PUQF8knpKAN+LdVoAnMiyjKlR2+Vmaw=;
 b=KgVl5Ca3N0eL8bXr6Z9L04XkROK1Se1V+GUVv5g8AUQCW/KN+AG6OsbMOGUwvOyao7E45
 biFoU0ehc9O3ve2SrWnW0art01vJGXjUGLooPben2EQGGzMpX73ykOuWdUq6ZCAl+epgdvE
 2CybDZUn+AthFyP63kufQP5q1dua5hs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69CA3E5FFE
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 18:42:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B9E63E543F
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 18:42:12 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E17D51A00142
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 18:42:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoHL86/8ciy7NapOJ0TD8E+YV8lQxrAA5qis9uO2bc99cdlwJsqmGR4Rv3WkxC19cR0mIS9tqwdvNJdZZTKn+1BSfGbmNyU5Oz9AhoLGUA88OFIK0j6lyLxi6PHlU7tpvyiUs6tlN+l65n5sAYf6qJHjktYf0uyeNMIkQJuqZ8HCLJgLyC95R3Jzwmm/akEV8VB9oeBHBxLSJqRVILT4/Uab1c0lyR38qlI/je5kp7ajroMRBESW9V8oIckx0HMfqexh/IldnbK00caBUUObgwnc+nA7BmdvErE2PU8wWbyie258kUN5+EMBnUPPavY17Jxdy1niVise84R3MJaM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4JOTURrteXuomcvq61aMYLhU+zbVR3hRrTncsiwDpI=;
 b=BudwGEauymNXjbp9S6u3m4KiZp/RzD0xFg9xpY8XWSLWznIt7m9J2lDs2WCYIJl0YxHT+Qs0vZx6U2rIHjQ+yYjmCfrhskbaxNlceA6A91bJVlDN4UHmaDSHerIepMvBWEpMn06GCwsVJQDp/XP0fqKxPpQ6N24AVVZG+Vus+IowwhTAFTlO08uK2c7hKgWS6fDmt/JIbhxEkS034FFdPq2wabxxfkigVSBfmtKjguO8LNJ0LvmbTGPLNqNTtinA4rYm8rv5x4oZy/0Ks5RBDWKoTP70J1i2aCf5Hmof+KPytXJBAYOY8IVJxR1Ko1KucpKsjk4jOcPNuLmAf+6lZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4JOTURrteXuomcvq61aMYLhU+zbVR3hRrTncsiwDpI=;
 b=kNG1MkuO3RACJv274jiMfGOvxKV4rMCWojRPYR6qTaTVH/LXFiA3B4Bok3eqbF2xFCS8Gu2GpmtADq3qzkM2IGihS3I4kiAtH3VG738LXgLI1qCKYO3MiRhyvhFK3a10Sb+4EinAad19yiFlpa1t6MlLYtMaNj5nJuB331olvUdbZxjzC/mus9G/5tV1Ch3vRR/2ECArJs4/S0gglaytbZ4RraqNfS6iDTAFvRTpT6f6FLG+AWL2Et7NuAgYWwr7es+GZddLGtaPs2CDBZKaMLsLTxDeU8NiLZ+7uQ3jig+EamvgFXIz2HiszdIkESZoBTkxmTCHEN9trpNtujSnGg==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 16:42:02 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 16:42:02 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
Thread-Index: AQHcx39M5lxVQj5BUk6C0HklgVevaLXWZoqAgADxLgCAALwKgIAAbxyA
Date: Fri, 10 Apr 2026 16:42:02 +0000
Message-ID: <7446645B-3D5F-45D5-B0B1-9375DD2937F8@nvidia.com>
References: <20260408174406.1572520-1-mochs@nvidia.com>
 <addjDV_wbPgD0y8e@yuki.lan> <30B73CA1-6AD3-4926-9E73-3FF5423F34A0@nvidia.com>
 <adjLGwviRoTSsbgH@yuki.lan>
In-Reply-To: <adjLGwviRoTSsbgH@yuki.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|DS7PR12MB5957:EE_
x-ms-office365-filtering-correlation-id: 6a249d3f-1795-4d2a-d191-08de97201796
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: aGEEhOYAuiUZ+KPih18kXUIImjGr3EFizpEyzTv0PQPqn36CHPF4L5MeHTjcQiNo1IKsQFBjWEl2HdgH8WdTvSuGPBf5N0Ibm4UoXxn3bGsjsJDTv9m9iaMxfnyUP+spf5YKXAFclms+iLF7bIh++Ol5pP6VgLe6z/6kFW8oGgfoJsvYj1Q7jWylNoqx8uTTwBDhDJrOd/GR21WWDXp1rm8v+uzlwSzYcTiXWlR+MgqHpWL+x9w/D2ZoYiEdXcxKIFJEYppFyamJMw57YTWqWbQ5gVosbRsoHwTMgHRcl1cU/niXVWJnVKXBOPnoOHsb3Bgi/1YkV3vOK4RRA/fZYDf+Eb0ge8UgGLI9Z0esH7nFUgAXt3Wdz5lAV1bb3MXd3EBtF03M80bGiMK3xEN24VnFXlZbU5jZ+3JS9if8nS2bfgDmwFBJjx+HEwo2FwSC2l0DzSDwbIAkR+BRcRuM/D6GQtDPLbGgS9PHC2Ad7Au9wyyDDEyFxGCRvpYtUVLTbmUUH+Bl/TE+Nv7CLoio/wS5ZvTyKsP7CjyrNWiYdBHuDx8Ee0KfyUbM7fQ7iUKgleXGEc0k29f5O8yrserAEMMccDXnhp760oK3RAVxI3uWA4cgGFVvl1iwmMlnG8Mf83bbf1Ih5JBc/o6IL1zyFlEEQ+qh+TqEeDt84mQCSWlqjZ26Tp05ioECodj/GkYB9u1JnZ5XxYs8z+ReiZ7S4Dk+wlo3o5OsFpRGux9jiFTt/LxxlITahCiSAV40zPwOZ66cI8UvizpGjLfv0PZlb6ARFH8hrtl4HtIPxzjIwOg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXZBNFRORm9OUFh1N1F1Sm04LzhPTmwxU1o5cU1Hd0RCeFJ4amJoUGtUV0cv?=
 =?utf-8?B?MGRqcHNpT3RPSU91S2FWdVBmRzBIR3l1eGZYQ3laMVRYby8yK1RCMnA3ZVhS?=
 =?utf-8?B?a1NsV1JZNWR5MkZQOTQ1NDAzMFBCemFqcHNtcmZqekZVc3cyQ3dLcmp6YzhC?=
 =?utf-8?B?VGFhdkt5ZmxFdU1xN1lPSTlvQ1lQMWh3U0FXRzFDWkVOeE1TNUF6SnZJSGlQ?=
 =?utf-8?B?V0o0cklzcUZheDdsbkpXb2lrekRLWkhVbzNnZUtyS1IvVWVkajBoYzEyMWlu?=
 =?utf-8?B?QXpFU2plVEo2T2tiaHVpcCtITUtMQ202cDIrVUt6TjRlZWRoZ0JyN3AzZ2dx?=
 =?utf-8?B?U0l3Rll2aTF6QitmTkZKLzN2YXplYktPNXhmV0JiRXM3T0ZFZUZTZ1pVTnkr?=
 =?utf-8?B?R1FnKzFnSjlvMWhTamFJd2U4V3NqMm15VkYvODhvQmN0T0ZMam5hekRJZS8v?=
 =?utf-8?B?bDQrZ1FoTUJiTFF4eGNobEZnUEs0RFV4cjlqbXpXaWd2d2ZvM1ZxMDdWMUUz?=
 =?utf-8?B?Slo4VmhvcE1hN2Z1QWVFUW9Kb1JhMjIwYzNOWHpxcmZCNE9VanZIeVdDMDlu?=
 =?utf-8?B?d2ZidnZLQmhGKzg3OWZGNXcyUjlKWmVtL3NpY1JGMytjV3J2QmhlTGVKc3FE?=
 =?utf-8?B?aGxCV1lLcXNSUGxHSVNxVzZsNnMrMDZwbTlJdnFZSnJNSU9vdE0zV3RpelFO?=
 =?utf-8?B?SGpVQ2hEelBha0kwamhwQ0RqRlFXM3M3dTBBeDlTS1d5U1YvUTFaOUtWcUVG?=
 =?utf-8?B?OTdHUllYWHFTaVVGQmtQSDZSUXpLVkhXNmlUS291a00rZmFCRWpBQ25WOE9L?=
 =?utf-8?B?amNWdEtEKzQ2WDV5K24zVjMxVnZRaCtnaksyWHlwOGtKTVlxUEQwc2NpUU51?=
 =?utf-8?B?b3diZjNCT3kzelQ3SzB0NzJ4YmdvOHZWR3FGZkF4ckFWTGxUTjJ1ZS9VYVpt?=
 =?utf-8?B?MmUzbmRJcTFQSVVzMktRMit4cHFBQW81MTVZdDdJc2RHQk1qK1pseGVlU0dJ?=
 =?utf-8?B?Y3p6cG0zbEpqVXpvTFhnaUhMTUI4WXhwWTFudE1qNVlUU3JudmdGamFmK3px?=
 =?utf-8?B?eDBqRC9NRExVdVBETG92c1l4MlVRMHJKdEY5MTFPaTcwdzRhQlQ3WTNaV3NI?=
 =?utf-8?B?VHlvcytXZ2JuNUh3YWdyMGFITmR4anZBeWZuc2V3YVZJcys1UFJmN0RaWklC?=
 =?utf-8?B?c2xkVHlmbXo5c3hvcDVwQks5NjN2YXVFbkhQT0dza0xlWE9xUVRjM0RMRFIw?=
 =?utf-8?B?MmpGQ3pIcEh3dFNaUVg5K3VpSk1pSGN3b2dwV25hZ2Y5MGZ1OFV4RkpmSG9G?=
 =?utf-8?B?VGVKcVRkaWMrWjFpczRESEZ1R1NvZXNRVUpGTDUyazl3dldNRFQxUU1WS3Yw?=
 =?utf-8?B?VER4WFNhdEF2VUNJblpwSGZ0d3JpSHdaL25SaWRIOG9BUjJIcWIvNEZxd1hu?=
 =?utf-8?B?ZTJoRG5OWkh4ZDhNdkF1Z2FLT25WZE85NEZScEtKTmFhaXcwbFNDVGdjOVow?=
 =?utf-8?B?LzJ2K2c2V1VDSDZ3L2s4QzNXRmJJdU90UFd5dWozcE9OUHd3cTY2OEg0cFNR?=
 =?utf-8?B?azhQR2huOGRMSkZ2bEhFK09XSEdlUXRxbmpvK3B3eVMvV0N6NUNNM2FpVUFl?=
 =?utf-8?B?cXhoeWxpVkZRTE1rekg0U1pMVHZwWk1Wa2lPNkgxZGZ1dlZ5MzVxYTFHQ0p5?=
 =?utf-8?B?KzVjODIxc0EralVCS3VJYjZFUW1KemxmdVRrWnNaQXVjR0pWRC9DeVF0S3Ny?=
 =?utf-8?B?RHVTelBwMTUrK0ROcm14MEZMcldMWEE0ZU05ejBKYlE4eWZaczBVdnl4Qk5o?=
 =?utf-8?B?alBSMm5XeWcrQVlnS1hTb1ROK3grdDc5VHJnT25JUlZHR1l6SitPNmpibk54?=
 =?utf-8?B?NVBVZENKZ0ppTm93eitxN1ZYQmZvaG9TZGRGWFkzcWNQSGxLbGhHMTFYS3NH?=
 =?utf-8?B?cU1UNi9ucHdrNHR3UG1WZUMyVUxUc0NtMm5ZN0IvQ2tWRXJyVDdnNHBjemli?=
 =?utf-8?B?YjhJeE9OVE9yeFRWS2Jxc3laL2NYekkrNTVPM2x4bjFzSUVyNG96ZzYra3NP?=
 =?utf-8?B?OVN3aFdpalVOUW4rNGtnbUNSV05EajB6R0pST0pLNHJJNmN6Rm5vVS9PcitZ?=
 =?utf-8?B?OXNnVEl3MVVUQ3o1TDZLYmJwWVBNNWJiUGNGL1hFRmpqV28zbWpjMysrS3Na?=
 =?utf-8?B?R2x1UzBIZm5OWENVWDN4VzhkQmNRd1RtdXo2TVJUaUJlcmZ3UGRLOGFwejVL?=
 =?utf-8?B?Vko4Z29UWlp1QnBpZSs5Y3pxOVJQam40WE1IY1RsOG8vTDNuTzBxdUVWait3?=
 =?utf-8?B?eHZzcXpwaUF0d2xyT1V5VEUxWFJtb3FMZXdsOEVmUStXWVhGeE1VQT09?=
Content-ID: <621B5F1C8AE9CE4ABD8C23F9B3AF4C78@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a249d3f-1795-4d2a-d191-08de97201796
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 16:42:02.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krynlYmw9CfvfeCcYpANVT8wdUPF/g2mMhJEb0mIriVnNZtRntQmRORWpEd7upVP6xrN9V59YTqsyxSsjwtdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: file_attr05: skip ntfs filesystem
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
From: Matt Ochs via ltp <ltp@lists.linux.it>
Reply-To: Matt Ochs <mochs@nvidia.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBBcHIgMTAsIDIwMjYsIGF0IDA1OjA0LCBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5j
ej4gd3JvdGU6DQo+IA0KPiBIaSENCj4+PiBXaGVuIEkgcnVuIHRoZSB0ZXN0IEkgc2VlOg0KPj4+
IA0KPj4+IC4uLg0KPj4+IHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzoxNjU6IFRJTkZPOiBTa2lw
cGluZyBGVVNFIGJhc2VkIG50ZnMgYXMgcmVxdWVzdGVkIGJ5IHRoZSB0ZXN0DQo+Pj4gLi4uDQo+
Pj4gDQo+Pj4gU28gbGlrZWx5IHNvbWV0aGluZyBlbHNlIGlzIGF0IHBsYXkgaGVyZS4gQXJlIHlv
dSBzdXJlIHlvdSBhcmUgZGVhbGluZw0KPj4+IHdpdGggYSBmdXNlIGJhc2VkIG50ZnMgb3Igd2l0
aCB0aGUga2VybmVsIGJhc2VkIGltcGxlbWVudGF0aW9uPw0KPj4+IA0KPj4gDQo+PiBPbiBVYnVu
dHUsIG50ZnMzIGlzIGF2YWlsYWJsZSBhcyBhIGtlcm5lbCBtb2R1bGUsIHNvDQo+PiBoYXNfa2Vy
bmVsX3N1cHBvcnQoKSBpbiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmMgcHJvYmVzIHRoZSBrZXJu
ZWwNCj4+IG1vdW50LCBzdWNjZWVkcywgYW5kIHJldHVybnMgVFNUX0ZTX0tFUk5FTCBpbW1lZGlh
dGVseSDigJQgbmV2ZXINCj4+IHJlYWNoaW5nIHRoZSBGVVNFIGRldGVjdGlvbiBwYXRoLiBBcyBh
IHJlc3VsdCwgdGhlIGV4aXN0aW5nICJmdXNlIg0KPj4gc2tpcCBkb2Vzbid0IGZpcmUgZXZlbiB0
aG91Z2ggc2FmZV9tYWNyb3MgYWx3YXlzIG1vdW50cyBudGZzIHZpYSBGVVNFDQo+PiBhbnl3YXku
DQo+IA0KPiBJIHRoaW5rIEkndmUgZmlndXJlZCBpdCBvdXQuIFRoZSBudGZzIGRyaXZlciBpbiBr
ZXJuZWwgaXMgdGhlIG9sZA0KPiByZWFkLW9ubHkgb25lIGFuZCBudGZzMyBpcyB0aGUgbmV3IHJl
YWQtd3JpdGUga2VybmVsIGRyaXZlci4NCj4gDQo+IFdoYXQgd2UgY2FuIGRvIGluIHRoZSBsaWJy
YXJ5IGlzIHRvIGZpeCB0aGUgbnRmcyBkcml2ZXIgdG8gYmUgYWx3YXlzDQo+IGhhbmRsZWQgYnkg
ZnVzZSBhbmQgYWRkIG50ZnMzIHRoYXQgaXMgdGhlIHJlYWQtd3JpdGUga2VybmVsIGRyaXZlci4g
V2l0aA0KPiB0aGF0IHdlIHdpbGwgZml4IHRoaXMgdGVzdCBidXQgYWxzbyBlbmFibGUgbW9yZSBj
b3ZlcmFnZS4NCj4gDQo+IFRoaXMgd29ya3MgZm9yIG1lOg0KPiANCj4gZGlmZiAtLWdpdCBhL2xp
Yi90c3RfbWtmcy5jIGIvbGliL3RzdF9ta2ZzLmMNCj4gaW5kZXggYzYxOWEzNzNkLi45NjFmZmMw
OTEgMTAwNjQ0DQo+IC0tLSBhL2xpYi90c3RfbWtmcy5jDQo+ICsrKyBiL2xpYi90c3RfbWtmcy5j
DQo+IEBAIC01MCw2ICs1MCw5IEBAIHZvaWQgdHN0X21rZnNfKGNvbnN0IGNoYXIgKmZpbGUsIGNv
bnN0IGludCBsaW5lbm8sIHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLA0KPiAgICAgICAgICAgICAg
ICByZXR1cm47DQo+ICAgICAgICB9DQo+IA0KPiArICAgICAgIGlmICghc3RyY21wKGZzX3R5cGUs
ICJudGZzMyIpKQ0KPiArICAgICAgICAgICAgICAgZnNfdHlwZSA9ICJudGZzIjsNCj4gKw0KPiAg
ICAgICAgc25wcmludGYobWtmcywgc2l6ZW9mKG1rZnMpLCAibWtmcy4lcyIsIGZzX3R5cGUpOw0K
PiANCj4gICAgICAgIGlmIChmc19vcHRzKSB7DQo+IGRpZmYgLS1naXQgYS9saWIvdHN0X3N1cHBv
cnRlZF9mc190eXBlcy5jIGIvbGliL3RzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYw0KPiBpbmRleCAw
YzhjOGRjNTAuLmQzMDIwZmM0OCAxMDA2NDQNCj4gLS0tIGEvbGliL3RzdF9zdXBwb3J0ZWRfZnNf
dHlwZXMuYw0KPiArKysgYi9saWIvdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jDQo+IEBAIC0zMCw2
ICszMCw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBmc190eXBlX3doaXRlbGlzdFtdID0g
ew0KPiAgICAgICAgInZmYXQiLA0KPiAgICAgICAgImV4ZmF0IiwNCj4gICAgICAgICJudGZzIiwN
Cj4gKyAgICAgICAibnRmczMiLA0KPiAgICAgICAgInRtcGZzIiwNCj4gICAgICAgIE5VTEwNCj4g
fTsNCj4gQEAgLTUxLDYgKzUyLDkgQEAgc3RhdGljIGludCBoYXNfbWtmcyhjb25zdCBjaGFyICpm
c190eXBlKQ0KPiAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gICAgICAgIH0NCj4gDQo+ICsg
ICAgICAgaWYgKCFzdHJjbXAoZnNfdHlwZSwgIm50ZnMzIikpDQo+ICsgICAgICAgICAgICAgICBm
c190eXBlID0gIm50ZnMiOw0KPiArDQo+ICAgICAgICBzcHJpbnRmKGJ1ZiwgIm1rZnMuJXMgPi9k
ZXYvbnVsbCAyPiYxIiwgZnNfdHlwZSk7DQo+IA0KPiAgICAgICAgcmV0ID0gdHN0X3N5c3RlbShi
dWYpOw0KPiBAQCAtODcsNiArOTEsOSBAQCBzdGF0aWMgZW51bSB0c3RfZnNfaW1wbCBoYXNfa2Vy
bmVsX3N1cHBvcnQoY29uc3QgY2hhciAqZnNfdHlwZSkNCj4gICAgICAgIGNoYXIgdGVtcGxhdGVb
UEFUSF9NQVhdOw0KPiAgICAgICAgaW50IHJldDsNCj4gDQo+ICsgICAgICAgaWYgKCFzdHJjbXAo
ZnNfdHlwZSwgIm50ZnMiKSkNCj4gKyAgICAgICAgICAgICAgIGdvdG8gY2hlY2tfZnVzZTsNCj4g
Kw0KPiAgICAgICAgc25wcmludGYodGVtcGxhdGUsIHNpemVvZih0ZW1wbGF0ZSksICIlcy9tb3Vu
dFhYWFhYWCIsIHRtcGRpcik7DQo+ICAgICAgICBpZiAoIW1rZHRlbXAodGVtcGxhdGUpKQ0KPiAg
ICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLCAibWtkdGVtcCglcykgZmFpbGVk
IiwgdGVtcGxhdGUpOw0KPiBAQCAtMTAyLDYgKzEwOSw3IEBAIHN0YXRpYyBlbnVtIHRzdF9mc19p
bXBsIGhhc19rZXJuZWxfc3VwcG9ydChjb25zdCBjaGFyICpmc190eXBlKQ0KPiANCj4gICAgICAg
IFNBRkVfUk1ESVIodGVtcGxhdGUpOw0KPiANCj4gK2NoZWNrX2Z1c2U6DQo+ICAgICAgICBpZiAo
dHN0X2ZzX2luX3NraXBsaXN0KGZzX3R5cGUsIGZzX3R5cGVfZnVzZV9ibGFja2xpc3QpKSB7DQo+
ICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJTa2lwcGluZyAlcyBiZWNhdXNlIG9mIEZV
U0UgYmxhY2tsaXN0IiwgZnNfdHlwZSk7DQo+ICAgICAgICAgICAgICAgIHJldHVybiBUU1RfRlNf
VU5TVVBQT1JURUQ7DQo+IA0KDQpIaSBDeXJpbCwNCg0KVGVzdGVkIHlvdXIgcHJvcG9zZWQgY2hh
bmdlcywgYWxsIHNjZW5hcmlvcyBwYXNzOg0KDQoxLiBOb3JtYWwgcnVuIHdpdGggbnRmczMgbG9h
ZGVkIOKAlCBudGZzIGNvcnJlY3RseSBkZXRlY3RlZCBhcyBGVVNFLWJhc2VkDQogICBhbmQgc2tp
cHBlZCwgbnRmczMgcnVucyB2aWEga2VybmVsIGRyaXZlciBhbmQgcGFzc2VzICg2LzYpOg0KDQog
ICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6IFRJTkZPOiBGVVNFIGRvZXMgc3VwcG9ydCBudGZz
DQogICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6IFRJTkZPOiBTa2lwcGluZyBGVVNFIGJhc2Vk
IG50ZnMgYXMgcmVxdWVzdGVkIGJ5IHRoZSB0ZXN0DQogICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVz
LmM6IFRJTkZPOiBLZXJuZWwgc3VwcG9ydHMgbnRmczMNCiAgIHRzdF9zdXBwb3J0ZWRfZnNfdHlw
ZXMuYzogVElORk86IG1rZnMubnRmcyBkb2VzIGV4aXN0DQogICAuLi4NCiAgIHRzdF90ZXN0LmM6
IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBudGZzMyA9PT0NCiAgIGZpbGVfYXR0cjA1LmM6IFRQQVNT
OiBmaWxlX3NldGF0dHIoLi4uKSA6IEVPUE5PVFNVUFAgKDk1KQ0KDQoyLiBOb3JtYWwgcnVuIHdp
dGggbnRmczMgbm90IGxvYWRlZCDigJQgc2FtZSByZXN1bHQsIGtlcm5lbCBhdXRvbG9hZHMNCiAg
IG50ZnMzIG9uIG1vdW50ICg2LzYpLg0KDQozLiBGb3JjZSBudGZzMyDigJQgZm9ybWF0cyB3aXRo
IG1rZnMubnRmcywgbW91bnRzIGFzIG50ZnMzLCBwYXNzZXMuDQoNCjQuIEZvcmNlIG50ZnMg4oCU
IG1vdW50cyB2aWEgRlVTRSwgcmV0dXJucyBFSU5WQUwgYXMgZXhwZWN0ZWQsIGNvbmZpcm1pbmcN
CiAgIHRoZSAiZnVzZSIgc2tpcCBpcyB3aGF0IHByb3RlY3RzIHRoZSBub3JtYWwgcnVuLg0KDQpB
cmUgeW91IHBsYW5uaW5nIHRvIHNlbmQgdGhpcyBhcyBhIGZvcm1hbCBwYXRjaD8gSGFwcHkgdG8g
ZGVmZXIgdG8NCnlvdSBzaW5jZSBpdCdzIGEgY2xlYW5lciBmaXggYXQgdGhlIGxpYnJhcnkgbGV2
ZWwsIGJ1dCB3YW50IHRvIG1ha2UNCnN1cmUgaXQgZG9lc24ndCBmYWxsIHRocm91Z2ggdGhlIGNy
YWNrcy4NCg0KLW1hdHQNCg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
