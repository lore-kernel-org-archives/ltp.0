Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAEBC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 12:44:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082383CAEE9
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 14:44:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E87553CA91F
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:44:28 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C65760017F
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 14:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665665066; x=1697201066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=jJXH4BmYujM62fVbSJ7ZCR5rSsMw98Sn3iq6OI9+Nms=;
 b=Jw9TfDYzihbIi1hnMS1tY7J9RRgm2HmtGWW+iG5aH6uBLPsEEpc9rIvu
 09zXVvyEpgif7jmFyTvUh6nUaJXv+4zgFwn12TW+d8b8kQ90Nr5McWFzY
 rdqmfRrOELCR/fCD2i/hu5UIc3hSi6K3fVY1k7DYTsZ4moTBdY9+MQBPv
 T74SoBlMJtgP13EuyhJuHNTpcNSb2YiDsU/yLM4Qms/1vdLSwXXN3Ynyo
 FXLg6Gvv8Dlhn1LMxhhQedbR0TEywkjUftxysKYPgvm1dxvwvwrRTJTs2
 oT6ZsEG8VfiApQpvap0Gi0/0k3doGj3/eZ1RYhvonYvH2mI5t2yezEygY A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="331571891"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; d="scan'208";a="331571891"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2022 05:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="802225862"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; d="scan'208";a="802225862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP; 13 Oct 2022 05:44:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 05:44:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 05:44:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 05:44:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 05:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deD7wFhw7ILGC9Mdrb45c7iSx71EVxfZ7oVqkKSamqgTCalV9CLZHOZ9S3R3sc5zoBdIkgQU6lQeLPr4Q/Jxnugkd5YSBkiTr0yCVN6vFKx35ykOOY8211u8tW28sDGKr0Y3e2om7f4NoYlhfwBbpwjwVk5JDAzIVpW9XZrx43G23irxHoWHdCSosVbdXxIei8T2RNmVSN+GlWTd00BWFN9eCi2z/EYUjARsEtpM1H38j3kDF+uLtSn67/cl73IAiJowjjhgbLZ6BpKt4cFnwarXpME92RGc7g5/CiF6WyzMzUChM7RyTnSKavnNcae0z24jM9DgrcgjbeGbIq3JYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTo6LCrSuEK03cIHNcAqOMnRJfWeyWrwTQ+b5qpUNJc=;
 b=dL88HAlm6UNhyVi1pDB0Zt6Ceq3NjCKT8qds1vxRRhwBf/8vJTAGgkzETu6ZAI0eiSid/bjWexQ5SpSWiZvzWT4u18dVEM9UfI0eLJ4N/zF6L9AnwTY4jILZ4dBXfCfjrA+soWtgBn9NAVg5w4aBLfftbE+wM8S6tOx+DKORgGiFSNGMGvXe1mAB53dUqQW5wcBBFx16OROcOZNvFQL0bE0J8KeU3A2S9SapyoAxln4S6eJFKa+tPETNy6h1ATTExUDEoE8Gk8AruQfwUJLfSuTBH6O3OY6t2LHKhh9NAjQEhKMScr2Ub23L/8TLr0+PTsOO52YxdvFUNn/x0qESQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 12:44:21 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ff77:34f5:692c:680c]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::ff77:34f5:692c:680c%4]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 12:44:20 +0000
Date: Thu, 13 Oct 2022 20:44:20 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Y0gIJFLUWtwbDuv+@xpf.sh.intel.com>
References: <PH0PR11MB4839BE3D63DCCDB34ACB329C9A259@PH0PR11MB4839.namprd11.prod.outlook.com>
 <CAOQ4uxgWnsyFbZFv0ORzhHTkZVUg_frgzKBno1Wr-KUGtNh4jQ@mail.gmail.com>
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgWnsyFbZFv0ORzhHTkZVUg_frgzKBno1Wr-KUGtNh4jQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 06129df6-72d5-4c3c-19c8-08daad18a63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2XOSB5RoEZBU8uh0BJL+yazu9OzNWioMPjTZGokgGl41IoGllD7fcQ0VN9XuRRRFSK7SJygN2pCFppjR2vC9bPtU96TECtmAP7rA44Ri0kLglfBVSmOcL9h2Jt6FB24WW4tKJx2lIbY7qsgHxuZuWHelxL//NoXz2QRSgxLagDyhQEm0c+AIueRUE8Hwg+E2N5AVfY4o0Oj3DoSfM2tM0AVFwabQRY1Xl8Sys6Tg721SFQezUaD1bbXuL/VZTOVJrdI0mtTPFrPQsZLzv6JsWtEg2gpNWKaMb+W8SWp9N5KyZKPEBxjSE8e5g9C4RajVgac7NsbZYeTXK2FIk6ROXNvFzJ84U6d6q5FCbQWoSh9Z1bS/wJ70D4N8dlU1Q5rSr64FRWabas15P2zG4S/XQFtXGRQBKV/v2xnrVzXLa+DAELdvFNHAgsMsvG2kQwbS8AQnUrEKlzv0uoIKDowBNdFTsgy5zQCWMLWhsp/mX+w4+raMlJLD+x7OVSQnI8U7nVe9/Qamt1+sKVbfOrhk0z42Eo6MNknN6FjN7zueTTpswUex+P33yCa9n57Nww3LJAX8dXJghuuVNoljrPqDOnO6SbvtzMcKDual6yZZ/T3Hi7UxZs9Gc8kPPVfgn16oecxPKqOphBhP820E/JrKCZegfvrfYe9nc5OYDTg97dfGzvMSd9e3fmEJwHVq72JliLMTgUKm5tS0pkYitpkCKV36p7tdrqdaig6dgN16BvDbtWFQqTlWtFreRi4iNbW0eBFhbsMbPRNj9Ep6OHjtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4839.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(478600001)(6486002)(966005)(86362001)(5660300002)(6916009)(54906003)(44832011)(4326008)(6506007)(8676002)(8936002)(66946007)(66556008)(66476007)(83380400001)(38100700002)(82960400001)(186003)(4001150100001)(2906002)(6512007)(26005)(53546011)(41300700001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bncyNjdPeWJvZTRON25XYUhpeHhzZm5BSEswL0hLbSt6UlIvZldZUGpIaXJh?=
 =?utf-8?B?aFlPT3dKVU5yMkQ2TXVyejY1SlpiQy9tV0pQY3BhVFlrd0IvOWRQc2pxUjFF?=
 =?utf-8?B?bGg5ODZIUmJzTU1Nb3Ard0l4ZUhMS05YcXQ1QVZVd1k1ZUErQXY0bEF0VW90?=
 =?utf-8?B?S1Roa3MzSGtyNU1tWlR2YytubndsN3JnR3JJbXZqaFA0Q3RaUXJZMEc3QmZV?=
 =?utf-8?B?a1Z6UVdQMStjRnVFUHUvZTNoRUYzakVYdE5RSWVSZndnNnliRy9acFNHTWdP?=
 =?utf-8?B?RFFvUUhLcURBbk5lTkhzdE43dEFYWmJXdWJPN212aVBpcTBsZ2xMd0c3b3NX?=
 =?utf-8?B?amw3UnRMTFRWekx6VFBSSW95aXcvUkFXN29jR2FvaTVpV3VBc1AyRDBBWkM2?=
 =?utf-8?B?cnI3SmdUVWljTTgxR2tPYkFWZWw3RE9jVWY3MCt3aVhYcUwzR243WlpIaXFv?=
 =?utf-8?B?YnpYQ3NRTVFpeWtmNk1vTDY0b1NVK2VRdUpDcVZWdUg3My9XdnZFT2tzMDlR?=
 =?utf-8?B?Rm1scTdib0pwN0x4K0tpVHpJeTZoWWliVy9qL2tGOWEyaXMzMCtVV0twUyta?=
 =?utf-8?B?dTNob2pPYnBFVXdmM3dGRFB0NXNzKzdSanBFRmU4bGU1ZlhsajZDTDVYV3JX?=
 =?utf-8?B?Q2FtTDRaSkJjZytra3pMaWFtSWlINXRPbWFtd21Lb1I2TUsxS085bHRKclVP?=
 =?utf-8?B?MUlhMEpaWEdqWktmRk5DM0VEaFYwRDB1bDMzZmxLVUVIdEZOVVVKWkNoZGdK?=
 =?utf-8?B?Y3lNZERQTnRFbzZyYlpNVm9rRUdEaVMzdGVUSEdSRCtOS1R3aTRVRGRFRzlW?=
 =?utf-8?B?VTlMWjJseENyVDZhVGllSDVaL0JaOVpoM3lnSFhzckF4MUlsRDZiamJrVWVq?=
 =?utf-8?B?ZEZ5K3VBc1lUVFNDYkNrMDNLTE5tM2Vud3UxMlB3NXN1cFpjMHlJVGl1U2E5?=
 =?utf-8?B?WVpsYXpZeGplZ2xHSFlxcVZtRGUxT1pNYzlzeFZkZE9QaGdJdVU4K3B2MUJv?=
 =?utf-8?B?alAvcU83NlBiejI4dFdXYW1HNUJPV2VUdDI4eFVySmg1MTVEbTJrSHFQdUlP?=
 =?utf-8?B?S0dDbjJpczM5OVZsY3dHTkczQVBLbW5pVzZ2a3VoSkdDSStNeTV2aEtWWWdY?=
 =?utf-8?B?a014THhZbElsYmVrQUYxaENINUlPVFBGbnM1Mms2T1BSQUhBN25Da05uMFJD?=
 =?utf-8?B?RWdhMFF5N3k3elVrWUpEZERxb0xuNUhrQ0tCZE9ER0VSdEMwdE5RbndqSmhk?=
 =?utf-8?B?enZDQkNJQkF3OXJZNmM0TzV3QVRScGttY0ZrRUN3WEV0UjQ3RlpqcGFiTTBp?=
 =?utf-8?B?MmZWNzN6OGJxcVUzSkpGeUlHODhmeFZQTjdtOEVqeWhWU04yL1FaRU1PY3BV?=
 =?utf-8?B?REtRQ0VrRjducndSWDE4ZUg0TGpMT0hhRnoyajhub1RScG5XYkc0VzJmR1pz?=
 =?utf-8?B?Nm1tL1VTNjJkelE2MlhRUXYzSmZqSFJUeHdZWUo2TWhGN0hrdVBLWlhFM2Fw?=
 =?utf-8?B?THFEa1B3ekE0QThqK1MzTHVYbkMydkNhZXBOM0Rtbk5iMmx3WGZaY05McjEx?=
 =?utf-8?B?SW8rWVhhRVUrMWtqamtXelE5ZzZWZTl3SlpXY0Z5cGRDWFp5bUdFSUZwZFhI?=
 =?utf-8?B?elVZTnluTEpLdnQ1TWNhcXZ2dk5kSURFRnA0Ry91c3BJVmc1dzdpK09QNkVB?=
 =?utf-8?B?UzRvZzg2NXczUURtMk55TXFTUWY0TmhQR2tUWFVNNkwzekNiMHVtK013cVFy?=
 =?utf-8?B?YU5LRFA1VGZ4ZUlRek9PV204OXoxUFAvSUxrSC91WDErbEt3UnJuT2c2ZmJ1?=
 =?utf-8?B?MDRPWFcrRVJ3dFBQcWdyK3JsaEFWUWtZRE9uUk5aUjFrek1NYjJPR3VHRmlZ?=
 =?utf-8?B?Y1JvZE0xZEpjUyt1RGpFZE41ZXI3akxjQUdjZHJ2djRrN1lPYlhWSTlldmhn?=
 =?utf-8?B?VVFZSmFlYkZtQjFRKzVrTUNyRDNyQXVVK1UvUHA1T2FJNmEvUVB1aWx1YjRX?=
 =?utf-8?B?Y1dBY0JSNlBxenl0YUEyRXE5NFc3cjlERlZjTjRlUTN0M2xBOHg1bFlOMXpM?=
 =?utf-8?B?TWRsc3NWTEt5OWwwUlRlRzMvVFhXaytBWGU3S3R0N1RyQ3lENy9ncDV2SUlF?=
 =?utf-8?B?Q2ZuSmZlU1RGdXpDbHl0MEt3cDlZTjVaZWtJN0NrUmtSTWtQRW5VYksvZS9w?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06129df6-72d5-4c3c-19c8-08daad18a63e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 12:44:20.9222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chjoGn29hmXTJS4v41s9K/QLsA8qK8O3VdEEBV5jU6f4Og/L2qqqf3H6Z2n1BKNPPde0Bv5MSBmRBWEZKe7aFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Could you provide some debug method for fanotify10 case?
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
Cc: "jack@suse.cz" <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW1pciwKCk9uIDIwMjItMTAtMTMgYXQgMTI6MjU6NTkgKzAzMDAsIEFtaXIgR29sZHN0ZWlu
IHdyb3RlOgo+IE9uIFRodSwgT2N0IDEzLCAyMDIyIGF0IDExOjI4IEFNIFh1LCBQZW5nZmVpIDxw
ZW5nZmVpLnh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPgo+ID4KPiA+Cj4gPiBIaSBKYW4gYW5kIEFt
aXIsCj4gPgo+ID4KPiA+Cj4gPiBHcmVldGluZyEKPiA+Cj4gPgo+ID4KPiA+IEkgc2F3IEZBTl9N
QVJLX0VWSUNUQUJMRSBoYXMgYmVlbiBhZGRlZCBpbiA2LjAtcmM1IG1haW5saW5lIGtlcm5lbCBi
eSBBbWlyLgo+IAo+IEZZSSwgaXQgd2FzIG1lcmdlZCBpbiB2NS4xOS4KPiAKIEFoLCB0aGFua3Mg
Zm9yIGNvcnJlY3Rpb24hCgo+ID4KPiA+IGNvbW1pdCA3ZDVlMDA1ZDk4MjUyN2U0MDI5YjAxMzk4
MjNkMTc5OTg2ZTM0Y2RjCj4gPgo+ID4gQXV0aG9yOiBBbWlyIEdvbGRzdGVpbiBhbWlyNzNpbEBn
bWFpbC5jb20KPiA+Cj4gPiBEYXRlOiAgIEZyaSBBcHIgMjIgMTU6MDM6MjUgMjAyMiArMDMwMAo+
ID4KPiA+Cj4gPgo+ID4gQW5kIEkgc2F3IHRoZSBGQU5fTUFSS19FVklDVEFCTEUgY2FzZXMgaW4g
TFRQIGF1dGhvciBpcyBhbHNvIEFtaXIuCj4gPgo+ID4KPiA+Cj4gPiBDb3VsZCB5b3UgcHJvdmlk
ZSBtZSBzb21lIGRlYnVnIG1ldGhvZCBmb3IgZmFub3RpZnkxMCAgRkFOX01BUktfRVZJQ1RBQkxF
IGZhaWxlZCBjYXNlcz8KPiA+Cj4gPgo+ID4KPiA+IFRoYW5rcyBhIGxvdCEKPiA+Cj4gPgo+ID4K
PiA+IFBsYXRmb3JtOiBzZXJ2ZXIKPiA+Cj4gPiBLZXJuZWw6ICA2LjAgbWFpbmxpbmUga2VybmVs
Cj4gPgo+ID4KPiA+Cj4gPgo+ID4KPiA+IFRoaXMgY2FzZSBjb3VsZCBiZSByZXByb2R1Y2VkIGFi
b3V0IDMwJSByYXRlLiAgKGNhc2Ugc3RhcnQgZnJvbSAwLCAgYW5kIHRoZXJlIGFyZSBhYm91dCAz
MCUgcmVwcm9kdWNlIHJhdGUgZm9yIGNhc2UyNSwgMjYgYW5kIDI3KQo+ID4KPiA+IFRoZXJlIGFy
ZSAzMSBjYXNlcyBpbiBmYW5vdGlmeTEwLmMgIChzdGFydCBmcm9tIDAsICBlbmQgd2l0aCAzMC4p
Cj4gPgo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9t
YXN0ZXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEwLmMKPiA+
Cj4gPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rl
ci90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5X2NoaWxkLmMgICAo
Rm9yIGNoaWxkIHByb2Nlc3MpCj4gPgo+ID4KPiA+Cj4gPiBDYXNlIDI1OiAgImRvbid0IGlnbm9y
ZSBmcyBldmVudHMgY3JlYXRlZCBvbiBhIGZpbGUgd2l0aCBldmljdGVkIGlnbm9yZSBtYXJrIgo+
ID4KPiA+IENhc2UgMjY6ICAiZG9uJ3QgaWdub3JlIG1vdW50IGV2ZW50cyBjcmVhdGVkIGluc2lk
ZSBhIHBhcmVudCB3aXRoIGV2aWN0ZWQgaWdub3JlIG1hcmsiCj4gPgo+ID4gQ2FzZSAyNzogICJk
b24ndCBpZ25vcmUgZnMgZXZlbnRzIGNyZWF0ZWQgaW5zaWRlIGEgcGFyZW50IHdpdGggZXZpY3Rl
ZCBpZ25vcmUgbWFyayIKPiA+Cj4gPiBJIGNvbW1lbnRzIGFsbCBvdGhlciBjYXNlIGFuZCBvbmx5
IGxlZnQgIGNhc2UgMjUsICBjYXNlIDI2IGFuZCBjYXNlIDI3ICBpbiAgZmFub3RpZnkxMF8yNSAg
ZmFub3RpZnkxMF8yNiAgZmFub3RpZnkxMF8yNy4KPiA+Cj4gCj4gVGhlIHByb2JsZW0gaXMgdGhh
dCB0aGUgdGVzdCBpcyBub3QgdmVyeSByZWxpYWJsZSwgYmVjYXVzZSB0aGVyZSBpcyBubwo+IHJl
bGlhYmxlIEFQSQo+IHRvIGV2aWN0IGFuIGlub2RlIGZyb20gY2FjaGUuCj4gCj4gRG8geW91IGhh
dmUgdGhpcyBjb21taXQgaW4gdGhlIExUUCB2ZXJzaW9uIHRoYXQgeW91IGFyZSBydW5uaW5nPwo+
IAo+IGNvbW1pdCA0OGNmZDdhOTk3N2U2MjY4YjRhYTI2MDA2MDhjZWJhZDdlMGU0MmI4Cj4gQXV0
aG9yOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+IERhdGU6ICAgVGh1IEF1ZyAyNSAxNjowMzow
NiAyMDIyICswMjAwCj4gCj4gICAgIHN5c2NhbGxzL2Zhbm90aWZ5MTA6IE1ha2UgZXZpY3RhYmxl
IG1hcmtzIHRlc3QgbW9yZSByZWxpYWJsZQo+IAo+ICAgICBJbiBzb21lIHNldHVwcyBldmljdGFi
bGUgbWFya3MgdGVzdHMgYXJlIGZhaWxpbmcgYmVjYXVzZSB0aGUgaW5vZGUgd2l0aAo+ICAgICBl
dmljdGFibGUgbWFyayBkb2VzIG5vdCBnZXQgZXZpY3RlZC4gTWFrZSBzdXJlIHdlIHN5bmMgdGhl
IGZpbGVzeXN0ZW0KPiAgICAgYmVmb3JlIHdlIHRyeSB0byBkcm9wIGNhY2hlcyB0byBpbmNyZWFz
ZSBsaWtlbHlob29kIHRoZSBpbm9kZSB3aWxsIGdldAo+ICAgICBldmljdGVkLgo+IApZZXMsIEkg
dXNlZCBMVFAgaGVhZCBjb21taXQgOGY3MTIwYjA0ZjAxOGU5M2Y0MzgzNGM3ZGE2MzI1MjI5MGM0
YWJjOApBdXRob3I6IEF2aW5lc2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPgpEYXRlOiAgIFdlZCBK
dWwgMjAgMTI6NDc6NDMgMjAyMiArMDUzMAogICAgZ2V0aXRpbWVyMDEuYzogY29udmVydCB0byBu
ZXcgTFRQIEFQSQoKCkl0IGluY2x1ZGVzIHRoZSBjb21taXQgNDhjZmQ3YTk5NzcgeW91IG1lbnRp
b25lZC4KQW5kIEkgd2lsbCBoYXZlIGEgdHJ5IGRlYnVnIGtlcm5lbCB3aGljaCBzdWdnZXN0ZWQg
YnkgSmFuIEthcmEuCgpUaGFua3MgQW1pciBhbmQgSmFuIGJvdGghCgpUaGFua3MhCkJSLgoKPiAK
PiBUaGFua3MsCj4gQW1pci4KPiAKPiA+Cj4gPgo+ID4gQ2FzZSAyNSBmYWlsZWQgaW5mbzoKPiA+
Cj4gPiBmYW5vdGlmeTEwLmM6NTg2OiBUSU5GTzogVGVzdCAjMjU6IGRvbid0IGlnbm9yZSBmcyBl
dmVudHMgY3JlYXRlZCBvbiBhIGZpbGUgd2l0aCBldmljdGVkIGlnbm9yZSBtYXJrCj4gPgo+ID4g
ZmFub3RpZnkxMC5jOjM3MDogVFBBU1M6IE5vIGZhbm90aWZ5IGlub2RlIGlnbm9yZSBtYXJrcyBh
cyBleHBlY3RlZAo+ID4KPiA+IGZhbm90aWZ5MTAuYzozNzA6IFRQQVNTOiBObyBmYW5vdGlmeSBp
bm9kZSBpZ25vcmUgbWFya3MgYXMgZXhwZWN0ZWQKPiA+Cj4gPiBmYW5vdGlmeTEwLmM6MzcwOiBU
UEFTUzogTm8gZmFub3RpZnkgaW5vZGUgaWdub3JlIG1hcmtzIGFzIGV4cGVjdGVkCj4gPgo+ID4g
ZmFub3RpZnkxMC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1h
cmsgKG1mbGFncz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkx
MC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1mbGFn
cz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjM3NDog
VEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1mbGFncz0yNDAsIG1h
c2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjM3NDogVEZBSUw6IEZv
dW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1mbGFncz0yNDAsIG1hc2s9MCBpZ25v
cmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhw
ZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1mbGFncz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9
MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5v
ZGUgaWdub3JlIG1hcmsgKG1mbGFncz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+
ID4gZmFub3RpZnkxMC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3Jl
IG1hcmsgKG1mbGFncz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3Rp
ZnkxMC5jOjM3NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1m
bGFncz0yNDAsIG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjM3
NDogVEZBSUw6IEZvdW5kIHVuZXhwZWN0ZWQgaW5vZGUgaWdub3JlIG1hcmsgKG1mbGFncz0yNDAs
IG1hc2s9MCBpZ25vcmVkX21hc2s9MjApCj4gPgo+ID4gZmFub3RpZnkxMC5jOjU0NzogVFBBU1M6
IGdyb3VwIDAgKDgpIGdvdCBldmVudDogbWFzayAyMCBwaWQ9MTgzNDk0IGZkPTE2Cj4gPgo+ID4g
ZmFub3RpZnkxMC5jOjU0NzogVFBBU1M6IGdyb3VwIDEgKDgpIGdvdCBldmVudDogbWFzayAyMCBw
aWQ9MTgzNDk0IGZkPTE2Cj4gPgo+ID4gZmFub3RpZnkxMC5jOjU0NzogVFBBU1M6IGdyb3VwIDIg
KDgpIGdvdCBldmVudDogbWFzayAyMCBwaWQ9MTgzNDk0IGZkPTE2Cj4gPgo+ID4gZmFub3RpZnkx
MC5jOjY0MjogVEZBSUw6IGdyb3VwIDAgKDQpIHdpdGggRkFOX01BUktfRklMRVNZU1RFTSBkaWQg
bm90IGdldCBldmVudAo+ID4KPiA+IGZhbm90aWZ5MTAuYzo2NDI6IFRGQUlMOiBncm91cCAxICg0
KSB3aXRoIEZBTl9NQVJLX0ZJTEVTWVNURU0gZGlkIG5vdCBnZXQgZXZlbnQKPiA+Cj4gPiBmYW5v
dGlmeTEwLmM6NjQyOiBURkFJTDogZ3JvdXAgMiAoNCkgd2l0aCBGQU5fTUFSS19GSUxFU1lTVEVN
IGRpZCBub3QgZ2V0IGV2ZW50Cj4gPgo+ID4gZmFub3RpZnkxMC5jOjY0MjogVEZBSUw6IGdyb3Vw
IDAgKDApIHdpdGggRkFOX01BUktfRklMRVNZU1RFTSBkaWQgbm90IGdldCBldmVudAo+ID4KPiA+
IGZhbm90aWZ5MTAuYzo2NDI6IFRGQUlMOiBncm91cCAxICgwKSB3aXRoIEZBTl9NQVJLX0ZJTEVT
WVNURU0gZGlkIG5vdCBnZXQgZXZlbnQKPiA+Cj4gPiBmYW5vdGlmeTEwLmM6NjQyOiBURkFJTDog
Z3JvdXAgMiAoMCkgd2l0aCBGQU5fTUFSS19GSUxFU1lTVEVNIGRpZCBub3QgZ2V0IGV2ZW50Cj4g
Pgo+ID4gZmFub3RpZnkxMC5jOjY0MjogVEZBSUw6IGdyb3VwIDAgKGUwMCkgd2l0aCBGQU5fTUFS
S19GSUxFU1lTVEVNIGRpZCBub3QgZ2V0IGV2ZW50Cj4gPgo+ID4gZmFub3RpZnkxMC5jOjY0Mjog
VEZBSUw6IGdyb3VwIDEgKGUwMCkgd2l0aCBGQU5fTUFSS19GSUxFU1lTVEVNIGRpZCBub3QgZ2V0
IGV2ZW50Cj4gPgo+ID4gZmFub3RpZnkxMC5jOjY0MjogVEZBSUw6IGdyb3VwIDIgKGUwMCkgd2l0
aCBGQU5fTUFSS19GSUxFU1lTVEVNIGRpZCBub3QgZ2V0IGV2ZW50Cj4gPgo+ID4KPiA+Cj4gPiBD
YXNlIDI1IHBhc3NlZCBkbWVzZyBwYXJ0IGFuZCBjYXNlIDI1IGZhaWxlZCBkbWVzZyBwYXJ0IGFy
ZSBpbiBhdHRhY2hlZCwgIEkgZGlkbuKAmXQgc2VlIHNvbWUgYWJub3JtYWwgZnJvbSBkbWVzZy4K
PiA+Cj4gPgo+ID4KPiA+Cj4gPgo+ID4gQ291bGQgeW91IHByb3ZpZGUgbWUgc29tZSBkZWJ1ZyB3
YXkgdG8gY2hlY2sgdGhlIGZhaWxlZCBjYXNlIGZ1cnRoZXI/Cj4gPgo+ID4KPiA+Cj4gPgo+ID4K
PiA+Cj4gPgo+ID4gVGhhbmtzIQo+ID4KPiA+IEJSCj4gPgo+ID4gUGVuZ2ZlaQo+ID4KPiA+Cj4g
Pgo+ID4KPiA+Cj4gPgo+ID4KPiA+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
