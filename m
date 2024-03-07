Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AC6C48BF6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 15:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E74C3D0020
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 16:25:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABBCF3C080E
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 16:25:41 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=sony.com (client-ip=185.132.183.11;
 helo=mx07-001d1705.pphosted.com; envelope-from=tim.bird@sony.com;
 receiver=lists.linux.it)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C06C1600B01
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 16:25:38 +0100 (CET)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 427EFCIS006908; Thu, 7 Mar 2024 15:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=BUDyOcZunBLvsMbgI79WsxN/IyTGSnTbpm2a0igBVwU=;
 b=TcuQ5VNNWn2ejKoCBShVMN44F4iidVvAFG/sG26Ca5CpEjFJeC3YVqdVzyHnaA7cLLqC
 om9uXGCJhB6VuVZqA5IMOFBuchwWlBob2r8rmrk35GrVuhuk/CdvtYg/BFEUr4KKc6f1
 Tr6gCcOhlJgfDoo+m4bLVwyNmAA3TpO+p8WSPZECNt3qgWIvFe/PfXZmXyaEHGqAEpSr
 W6u/3yQAxSwWdJnI8ApZKN8za5JGgRlXMzI9YEoiWg31d5stR1zuH7FU+vQ9ZMhi8onp
 QKBgyx4Dz4wb5HQLXsqRZHRI5ZsJ1Gqo52jsT3Wn+ewceKOJfAh2TSjmga6RtHDO+5pM cg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wku02e9sq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Mar 2024 15:25:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coqpX/7KLoLM6zUUsG8XyCpRJMa1zelDJjxozy+GU3Xoj9HLEA+Ju8QGS/o0uuwDSZ+EpKIrgKl+8Cw2U4Slz/+Jcn17ijLmlzF9nl46EgR9quMQqYM8s8V3Uv7Ot8FYjkwdPQblHmiZitmdWjkeoaDYRucy63gwhRJpMAUGHBmZXxWHHBz6EQPD8gFSxuKt4ktSmVkXoXpADkfJFvolfsBNqEcqaFu96oWA7r9zghnYZ5fapUpHZ7hdLGvbYQZdftdQJmEkBuk+oUzlS2TLzE5Q/VnZ3xP4e703Zmc+UoaeM34wElGcDND6WPTwvX3QXqEKJ2T3Xm8Xp7oBPCQFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUDyOcZunBLvsMbgI79WsxN/IyTGSnTbpm2a0igBVwU=;
 b=Sl+wfF40cK4CPRD5e/XxCZ3TfcIgkIA0cXvJehJDn0birARPLFwOD4VE5wi1uIGWTWVNblF8xGgksV2dyunqHMOjbtAsqABTdrylxDQAk6IYrpWpAxOlst3FYwXBbsdM6EPoRGZx1JAW72TIjAJ+MSCwEYLmDKUhsk2L8suWdw4g3q7Nv62hBOvHL2DWBHqnnWxr8fzOHuiH0aHtuLm9SBVOFH19x+EbT3t2Z0ZNmo9DFwfkCbWQ4YCGeI69bhcMxvBn65BZ221V5XUXIm2gsuw9XrbRTQIndJRixaPDAsroVxn5IJiOpYEEXPtBdcOoywMQNLDSuRAxa+e+HIxIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by SJ2PR13MB6072.namprd13.prod.outlook.com (2603:10b6:a03:4f2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 15:25:28 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 15:25:28 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] March meeting summary
Thread-Index: AQHab7KZ6vok0FDy6kKWFG2hENOWx7EsZ60w
Date: Thu, 7 Mar 2024 15:25:28 +0000
Message-ID: <SA3PR13MB6372DBF4B58108648780A769FD202@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <7509ec18-035e-4cdd-824f-5d8eac4bf3ff@suse.com>
In-Reply-To: <7509ec18-035e-4cdd-824f-5d8eac4bf3ff@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|SJ2PR13MB6072:EE_
x-ms-office365-filtering-correlation-id: d41c5d20-f197-41c7-8130-08dc3ebad198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWJSoFvT27TA+fyNjk+RPA5RFr0kAxUIe862RHbWPweYXCPkxZ198ewxz09/q5s57rjqhduPXWKlz/Lb7JosnHKtOztCyA0+IZImZwkrStij/7bvk8j0PUo35NIN8yZwCi8eEb7aSDoSNWhIrb3mn75KqGvRdfMB3kBVVIBhSXhV63bGpn/Lv+l06ZNypTGbOdXT1D2nYEkad0OACEdgMNq7L5NR3rHVOIfZ1zXU2Xup+Dd1ZKrebPmfyO7Qkt5TbwWPqsTqW6WNiwFVLGtItHBNOOVc3wMJtNVS9zhIPTMRhORBVCot9GiA6ZjKPAUOj41dubP5bYQWsIG+CgBsipA486pb5jlE991/kPJVJTX50EFddtARv5EMWWF98TpIw5AXoAwz3cdQWb1Lhhqpw7IctrGcWbT4s4m3DZ7/u3r1Nq6PO0C5mptVWFWxZ7kB03JW4+nGicgTc+9wwF4aYNSa3qvqdFWz6d9lMCXRLpabsT7u/9UyiUUsA2r6NA+lyV3dLj0Ib+UMVnJrs84s6GUMjr4D962Ip/vs5AJV/iNzqyHnSoCqYUYWeCYtnuIaFzUCkg4g+FTXcaanp36KSx7l9qZwH4ZSVWIHn7y2m4mH2w9p6QmqXwtksZADKS233mhfczpOZukpU9toQrUrbWgO4RKYNYbboSJd8sWIdXo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR13MB6372.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vn4+HgegtIgGVMuPZJzzBPld8pJMFMiQPXuEGimVzZ5lLFeVraQiQqU7ygUf?=
 =?us-ascii?Q?uGdZ679SRlYjgeUCoxNhXeyaHYaDgRiq2oy60tyWvFjYHBggg+Vx3LnKrlqw?=
 =?us-ascii?Q?ouSGorQN1WHg70R9BPbqiF3mNox2Ac/uMZvVu2I0peKfBEBIUOgjihEfOots?=
 =?us-ascii?Q?teW30ux4MB+NSLpSTp+t3EYNC0AuYlNpP/ydMuAY65nO5IFdI2ovCMh139nR?=
 =?us-ascii?Q?9o73254Uo7+e8/zNkdgkGqepdzY0/lJxwS2ex9uTAuJKLrO7bK9boc+WvMaQ?=
 =?us-ascii?Q?ioST3q2kXcl0gepwlxbrcx05b4nQ0pEc7L9BTGUl30+dvgz4l4fMh0eubzv8?=
 =?us-ascii?Q?O+b0A4tiz1yNVHlXG4sKTM1x5rtKMf2PIJ99SVomn417Y0KLSpkNNZnZk+yP?=
 =?us-ascii?Q?31bhkhFuWg3DhSQfjg8YGOSVykPxew5LRXiXwhyZ4DETYKf4fF/2PDS79Yru?=
 =?us-ascii?Q?Rh2BHPc7XZtsB1AH/99Ro0A3IQl5B7fdp9jfF1YnOyHmTeZ4aloxB5wWbHvS?=
 =?us-ascii?Q?uO54K0AfG8cPfGqkRVqBlE4YVhIHDcTOerYrWSHPbA6O2Kn3RiA6hR8AnBRO?=
 =?us-ascii?Q?8zHN4fMUjDuHAn4HhnBrpiEV/0z6V4jYSBajiFTvf2hXHU0YXpC3HNM/zzRG?=
 =?us-ascii?Q?r7h3XdUI1aNwFzJyTGdefvPGdlgR3rXg4d/I05C5czQu6VVpaI+08cl93z+C?=
 =?us-ascii?Q?ix90b9VS14kJgI0k2YvkcJ9PtFh6GblVB88Ik5qQzFJTHIOipyn3lKdMt6ZV?=
 =?us-ascii?Q?OzWcWajARynSQYMzFAV05AEjsa53qJ7CqRGOQ0UjYVfwj9D4bFHBk3FxrKWL?=
 =?us-ascii?Q?Aol/gzg1SM7OnmEqwdV55f6kuhzj55ShWlkB8FVhLC8RgJ4B/wwkNnM2grg4?=
 =?us-ascii?Q?WH0nMuu4UoEMpIgxLY2zmUE2OXrV3Y5MsnMP18SHGHQeZZfm1pepDndZ02gE?=
 =?us-ascii?Q?R3jwQP9mS+tsWE9/Nrv6U/jcpeEE7fO6mFSP6sOSz8QeTuaPJQJa6NDEZFFS?=
 =?us-ascii?Q?I/2AJbOoR85YuRRnGbjE0lZMfXoCkQtRedafGPd3ZSR8fns6lq3OxZnUd8fz?=
 =?us-ascii?Q?YfjCdKpvpncmJxa92oK9R49cZJSQI15RdAL5u9XOF6VTGs4H6o7rlHyU/s4R?=
 =?us-ascii?Q?vFYtB9g2FA0pkt9VyVdJJn9SUtUWoNI31Lbq3pnv7nj5k9MgykOHQi82Nf/q?=
 =?us-ascii?Q?DtmlXEly9xNZBdyVPbIuI8YGDEw1f/nGQp+2oihGLF8BDkwW/2rXrhTcsQyC?=
 =?us-ascii?Q?0e5VWpTbOf3Zcegtc9arLrVM2P+OKpT4+mtyl8IhRGsq4fcrIwh4Uus/5m2m?=
 =?us-ascii?Q?QL5rgn44DLc9Ut/L1dGh6vZenYYtAqB951oP9B9xLdq+dWzPceCNNpd97wNL?=
 =?us-ascii?Q?Hd8oJv2DSmFvXADMSoHUn1qewrx+DQm784e64nL4UNhdBw7t7pPVVpATCBOF?=
 =?us-ascii?Q?pqvbw1wCTYKsdDg2TS1iPfmkt1VHJyGR79+qfEkpekIvk1uw+qPZU6nYKeuS?=
 =?us-ascii?Q?fvJRwwydy87BTAEqeiQKH1jkjKVQFHS+dmq2Qq6yp4A3W6HVhCx5cce5+Nvr?=
 =?us-ascii?Q?0wsnlkr0DcXTYvdVq5k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ff8g806ZmchwEC+iF5XSBJdNkId5RoIVS3BgaIIt1YQXdMRMJkMtctNasbtSs64fG6VzovgQjyvnPkBUhvX+huRHk4ikuTIx4mleNTCXjf2fFWEMiMV/fgCTusNURdVTrWmYnMKhf9G6wul3780iYOR3q3q3i0VoN7ViUtv0V07gjctEl+abddYK3J/TKVv7somplVHTUOuyYCE0Rx4PDxlG7UG9i0dTEntzcc4x8YAVIe0exNPd9Jkpx1r/9r5UgXfx/B/qsLvQcw0bpK2NwrJZmjbKL4o+wO9+kUY4W+U+//bLjcBE1F8WKW3+wd2bkw0DSnH9Yys0cCKVNhMSx5XCOM7YsOi8Xve7sJJt7ur0Eutx7GuhV976+lgt/dR3c7Meg0ksB8pSxGlWZ+KR9QGyeuKzEh4G/4qzQ50ETSED/rE+JTy2pHQ/MFIi3YBzt7zxSvzomMUTOlfC6547VNWnVXoK8raO9UbQlp5KcwdlgTi3MrRsxdS/S/u3S1Cu9t7sKae/r7hozfyLq3RIXgBMUhi2hVedaIUJrQD6jyP3TF8dzkksZQCO7afot+LHlPGDyW5ScqzN7T1Kn9rukSFGCMaKX93z2nUr7/6jkCKWMSmcrLpH7aSP0Q4fR4vB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c5d20-f197-41c7-8130-08dc3ebad198
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 15:25:28.0763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dMMPzVqe1KjDdaIoodslM3hHWJsFhWha8ZiNXB7pkTm7uV33NkPxlkjQORG+BOSeWL+L3KaIdTnbdvEoVCCCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6072
X-Proofpoint-GUID: frFD9u0WbKBDVvWyIstQaa9DYZ2J_Xqc
X-Proofpoint-ORIG-GUID: frFD9u0WbKBDVvWyIstQaa9DYZ2J_Xqc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: frFD9u0WbKBDVvWyIstQaa9DYZ2J_Xqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] March meeting summary
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I'd like to just say that I find this summary of the meeting very useful.
Thanks for providing it!
 -- Tim


> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Andrea Cervesato via ltp
> Hi!
> 
> Thanks to all participants of our monthly LTP meeting. A short summary
> on what we talked about:
> 
> - we have ~300 tests to refactor into the new LTP API, which 2/3 of them
> are really low to slightly mid complexity
> 
> - in order to attract more developers and reviewers, we need to provide
> more documentation about the LTP project. This can be achieved by
> sharing workshops, blogs and documentation that can help junior
> developers to start working on small LTP tests. In short, to simplify
> documentation reachability
> 
> - to improve our documentation we can try "readthedocs.io" that is
> similar to what kernel devs are using (check
> https://korg.docs.kernel.org/docs.html). In this way we can also provide
> a more readable LTP website
> 
> - to introduce a special flag to communicate with tests runner (kirk)
> when we need to reboot the machine during tests
> 
> - we discussed about some tooling, AI, reviewing tools, bots
> 
> 
> Thanks for all the suggestions and improvements.
> Have a good day and see you the next month!
> 
> Best regards,
> Andrea Cervesato
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
