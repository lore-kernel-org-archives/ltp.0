Return-Path: <SRS0=zuCx=QD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B60C433F5
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 05:31:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57F561A07
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 05:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E57F561A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD5A3C8707
	for <ltp@archiver.kernel.org>; Tue, 16 Nov 2021 06:31:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E243A3C6AF4
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 06:30:59 +0100 (CET)
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com
 [68.232.152.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1D7E601AF6
 for <ltp@lists.linux.it>; Tue, 16 Nov 2021 06:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1637040658; x=1668576658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=sO8FU6tk/2VEDt4904Y8tOqx3B2aEpuM/FoOoQq6sVU=;
 b=W/dZOsHpCoW1WSA/5LQIwLiegJh5SCQpX0zamcd4eMyKKFsTrUYOeldy
 umtWvJDLzBeoPRhn3hIueoMLLnUB3+cQ89Bbx6kC9nXl3xs8z/SyCX3Kl
 uoRqjOm5dLJmhzpmLqmNKPdlGdHk3/awf5vgVnvq/d1XRtZx4KYQFRQIY
 RN0Iwt2WzpSz44UQjZTCNv7tiW0TE6kglei926GupSi53jdgKsdTMqpR1
 B0CbD+mrdHeCcIcIsCnH28BjvJm324C4bKgtDPqLbgcgjhOTp/Mj9y1At
 HYGNS3yJzshAQMn047MG3JCI1ER0o06IcEKjv//cScfCYSBSAzqAYOxgl g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="51889465"
X-IronPort-AV: E=Sophos;i="5.87,237,1631545200"; d="scan'208";a="51889465"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 14:30:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnH0LPE5FbIIRgwzIxJQDUeunLpZx0Y3E2lrBUJMnUosdcqojEvPOdVdFbwIzCnpGifyGQ09LEdjngtGwsadtgylTG8RRDN8InZ6owGQgYBHgiTa6ayXAw8NrIZ4ukS2ogrYdmsyDgP7ouqsunOXrC1slmuz/3ahj3K8W3H1iK1mt9KymuwVzm3l2/e4OXc05iRPTaqdPOgDGMPHeS/qCZyemQYHv56BKwasLJjE2rr0Uc9u+rd3UDm9o4CQNS+7MxHq54jRKyC8Y4NnSf6jHiH47TvwiFPaBINS9YRbvGqoAhYRF1NdNjb/nNQMuJouM+noWYORIcf4ek65lINA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO8FU6tk/2VEDt4904Y8tOqx3B2aEpuM/FoOoQq6sVU=;
 b=P28iY7perOCm0ba26QnXhroMSHiUJ52ShzHCNR3vUHtMM0AfFJMpon+P1t+RzN4bfO4xfNFCNkxM2mmhQsbwBtPrseX2M3fF2jGo3VlihEEMV6KKk3rq5N5RtvFM1A5k359X5m57rDIWTpeLrfpP1f0Jki+Pde5rhG4TY1yObKP8OXe4/CrybQKU5WPVaI5yoG1HwK1atNguuGuFKUCSFnpXRa07D2xljZwqnFfTQ5EfvDOO+DMl90uDf9j9LRoPin+m3Y/w7vXQUbtSdvZeC3Ozhas2cO1vHyQ9fLOWwxEqsEFexQDuxZzw3sT2ddg/vRKKM1FbhPk9eCJGIz0Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO8FU6tk/2VEDt4904Y8tOqx3B2aEpuM/FoOoQq6sVU=;
 b=KA/DIvZc7kcXwJBNfIIXNuSwtYVPspgvwUnorCUJLqzTLgJi40F0ShvxJRB8GEzeibER5DSFTZLuZqTJftP/Ic9gqbwYijMa9nTGujlhwU1xaV69VqyNq9LC8Yqd7LGmB8ZYcmcZ2wBY1AKRLSKbRBUsVXc6bE7NjolS4fn7evM=
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com (2603:1096:400:98::6)
 by TYCPR01MB6288.jpnprd01.prod.outlook.com (2603:1096:400:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Tue, 16 Nov
 2021 05:30:51 +0000
Received: from TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100]) by TYCPR01MB6544.jpnprd01.prod.outlook.com
 ([fe80::4997:e3e6:6502:9100%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 05:30:50 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: QI Fuli <fukuri.sai@gmail.com>
Thread-Topic: [LTP] [PATCH v3 0/2] Convert syscalls/dup3_{01,02} to new API
Thread-Index: AQHX2pVDpega48DKpEWzUr8qnldFG6wFoTCA
Date: Tue, 16 Nov 2021 05:30:49 +0000
Message-ID: <61934225.1030101@fujitsu.com>
References: <20211116025354.2566-1-qi.fuli@fujitsu.com>
In-Reply-To: <20211116025354.2566-1-qi.fuli@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588e88e6-2f87-4a60-fa95-08d9a8c24019
x-ms-traffictypediagnostic: TYCPR01MB6288:
x-microsoft-antispam-prvs: <TYCPR01MB6288E90A1DF1B6D3377794FCFD999@TYCPR01MB6288.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0nxOrFQvw7jxkNt7eCyidQJS7QraseGGFxwHDP620FI3LQTpoT/gkkT5QjKrAAyJRc+erZXJvEOhNOfatyqDE8b8j9vGvqda+tmYZLBuOs9I5oVupbVwO0bvPc9MfhqiiFy7JrOPcPxuSsFupRlLYKypyoIiqfzaViclyqFACK0XQFCNuOXWgas77BKidQpxzaFcZWxrwEDvaxkRmDvKPNu932IVWPH1N7Axf+GRVZW/y8FZPZGq7GgfFj/c4Sy01Ov1ojEjICppdc6niKhZmBZ9qjYEUcWkB6m79uOPUByXtjQJuJLRxb5xzmfz3uwY1ZwlqEyF9f8qDppeTbcKByFbs/5ghwNM/HhiFbVN19xPWeo3z0YoQ6Qjh3fJquLKCWbpC9qWe48sPefZYYnYD7QLaYn/i95iSUvjfnL6CNa3lgQ7jSH0kYvsCBNv9BI9azV0CxzKVrZbcSIGhIGuzRd/FtqHIWhv8+Tl7hp1wRMN9TfjetBSri4nN380QlDK/LYK3ym9a7HpxKRSxWEPPG+XbouwGaHbnJkacxe4HGDwnVpt37qiPYI9nHjLwSnIHDybxxqzH057CR8sNXt2S5mpxHlUeen4F/Q7wlEk5lqCZjY8jA9cWNbKt7QPy03nzRi1YWZn+K4ZLBZ0m2eEUVTkRy8VsbdDrboo8CuVLIE7IozADj4bpg+14j/MqTq0Bt8Bs0fkLhqIv4LJ5ep2iJM0eigSUUotnF3a3OvTBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB6544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(316002)(54906003)(122000001)(6506007)(5660300002)(87266011)(85182001)(8676002)(186003)(6916009)(508600001)(86362001)(26005)(2616005)(8936002)(36756003)(107886003)(66446008)(6512007)(66556008)(66476007)(66946007)(4326008)(71200400001)(76116006)(6486002)(64756008)(91956017)(2906002)(83380400001)(38070700005)(82960400001)(62816006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NEhtT3dmS0FNUTNkaGZlckZadU40OFpvdTFhSHVmNWxFMEZ4QytFQ0cwOWty?=
 =?gb2312?B?bWV6azBjaHF1QWlCdVBYN1VOekhzdWh4M0xWdTZMbnRxUlBJNEdDWkVGTytt?=
 =?gb2312?B?OE1VUEFESTFpOHpiMXRZVjdmVkM2N0RJNUFXOVc2cFpLL3Y1S00va2JreW8v?=
 =?gb2312?B?bEFrdSt6YlBXOWlUTFQ2UGZFYTNnVGVoU25BN01HM1ZkcXJqTTRlTTlia0ps?=
 =?gb2312?B?dERWeXU1T0I1dmNmaUJRYktuRk1vbG8zMFloK1NSaTRsZFFlVFlvR2xBcTBT?=
 =?gb2312?B?NWlzQkxpSDhOZFJuZ1RiNlEyYWxZL2xHUEFyZnBYTkplSWgvNFBJc3pjczNn?=
 =?gb2312?B?bW53WWFRakxxMkZVcVRJa25qZGxWV2ZxaU9WZlcvNzc4VlZzZFdCR3pkZG1h?=
 =?gb2312?B?dHlEZHIrYnZrU2MzVkE4eE5tRXlGdGxuQ0pNdk0vcDhpTHlBQ0ZITWpydFl2?=
 =?gb2312?B?R2thNno4L255dHRDZzZnaGY0Q3dZT2djeDNrUnNCUHA1SmVHYnRMaWRFb0Ix?=
 =?gb2312?B?YVZTb0x1d0svT2dVeUxsS1FNMWV6cUxLRGk5eEpOK3lkQ3lQSWh3UzBQWS9J?=
 =?gb2312?B?b1Y0a1ZlcjBaSlhSaGtPVFdOKzdsUmVXaWsvNlBORElFQUhSYXlDRm0xZGc1?=
 =?gb2312?B?WjdtZmlVRmdlZk56Q2owU1h6bUZra2RxNmNsbUFnWkhxSGlRU3p4aXJ4R0Fs?=
 =?gb2312?B?YmIwbVM0WjAvNG0zZFd4SnM3WWJUbHpyTUMzWTlHN2JHbXhuYTZPdVZhMHMr?=
 =?gb2312?B?aC9XM2Z5TkxuYjI1b2lhSDBQeVcvcW1jL2VHRXczbVQwUVUyZml3WGVJN2Zk?=
 =?gb2312?B?alVuMlRRVGZUakRnVHg3K1oyOENEdDM3NTh0K20xcjZ2aXMrSG5jaVNUWXRZ?=
 =?gb2312?B?VTloZko2dUpPU3VJOWZmaWhrbDk1VGFVSThQbWYrdzRPRDk3NFVWTUxiSTZx?=
 =?gb2312?B?KytlQUZvNC9hWnduUkZjenR5eFFpUjBsa3BlQXJGRm1NQ0RtLzE3Y3FMM2J5?=
 =?gb2312?B?ZTl4ejRtb3R6b0VsOEdMd1lsVUhod2h5WVhxNW9RcDhVcVkvdXdlb2VlOUNw?=
 =?gb2312?B?ODI3THRCYktla25IR3VtUFlKZjM2NkJRMFNCVGE4NDNkdDRCa291amVobDFy?=
 =?gb2312?B?TUZDbExKV3hrdXZYWmxrUUppU21Tb3NKZ1hTbVFGVkU3RitTTFlMb2xSbWox?=
 =?gb2312?B?NjFIS080QzNNQ2VRVGxWc3F0Mit0amJsYlB2dnQzQW9aeTQ2eU5pOXVudXMx?=
 =?gb2312?B?U2JxRklmQURlWkFqQWo5dENDV0RaUnJBalJwTVliTVBoc0xSaFN4UkM4UnpX?=
 =?gb2312?B?RHRFQ2t5SVNRZXhVS25menpqMGlxVWpZMm1uSTNYWFF0TzJyVFNrY3V0UWg5?=
 =?gb2312?B?Q2RLTnBHYTNnMG5XdHVIOUFJaEV1OWpjZlZad0dSUExDMkpoM2dVOC91aDdE?=
 =?gb2312?B?MjJnSFBYc2NSTW9jL0VrZnBTN2VuS2NZTXZZWFlJZFhFM3VIRVErUVcySG44?=
 =?gb2312?B?K1hXKzRTc09oL1RIM1Q1bWd3a285MjJMcWNaSXkzeWVqM2R4cHVLdXNtZ21B?=
 =?gb2312?B?SlVCdHMvaHFPeXM0aFNNUGI2SG5XcFhYeXovQWtNc3E0VmNmUFIramZVUXZz?=
 =?gb2312?B?VGdjYzAyc3BHOTNnckREZmVqM3RsVnZ3c0VzTk5XdEFMR1ZSb1MwOGdlZnZS?=
 =?gb2312?B?OHkxWlFiSTlXellnSEpLVUhXcy8xWXptcHZHOE1hRkVDVzNKbU5WNUNUb1NE?=
 =?gb2312?B?YTgxSVppbU5RSWF3YjlrZVpLMjJ4dFczRzFtUVRRRlpET1FzVW90bGp0Mytr?=
 =?gb2312?B?Vmsxckl2MVFFb2padURSZFFJYUsvVU1IdmRuY3M3REk0VkQvczRTTlZ0VU5x?=
 =?gb2312?B?YnBFWHdtL0lFd2FvVzlHczhvMitBM2kzVjFtd2dQRmNDMVlnMWZEZ1p4cnBW?=
 =?gb2312?B?MG9nOWh2VlF0NzZkTkZGbG5rUDhsb1M0OW9uSjV0dHJVVWZjQXI5LzVCVmZR?=
 =?gb2312?B?dXc5VkVIYzZRcFVzakozWWRURXhLRjV3MjFkVno1Y3ZraDhzc2NYRDU2TXFU?=
 =?gb2312?B?dWdRU1Nlb0YwMVFWN041ckd2VTNTYTAzOWh5ZFd6WkhtMlhGYTR4V3hpWUhh?=
 =?gb2312?B?VFMvZEpuY0hBM2VIOGppUzZKYTZLd0o0QmZsbk5ibWpjeU8zYWRYSXh1MUZk?=
 =?gb2312?B?UU85THN2TkdsTGFBM0xQWXpEelBuRmg4SVczZUEzdjU3Tzc4OHZTeHV6NSty?=
 =?gb2312?Q?aY7lX4DMv+Sfg0b0ON0UeVxa+vwnoC0hgosYYTCC24=3D?=
Content-ID: <C9BC3F394B24B148A32042E13CF62465@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6544.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e88e6-2f87-4a60-fa95-08d9a8c24019
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 05:30:49.8000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xrz0yfVKf5d9b59Cj0HoAuOPNPa+d7XqLlAA+uepMPa/Rkj5b7LWu63/7+zPkmj/4MtQnymD85+o8S/Bd1OIEH874yy385Jhh7kMfkPFDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6288
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] Convert syscalls/dup3_{01,02} to new API
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
Cc: "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Qi

I pushed this patch set with modifying some minor things.

Thanks for your patch!

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c 
b/testcases/kernel/syscalls/dup3/dup3_01.c
index e8ed3a2..e34379b 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -5,8 +5,10 @@
   * Created - Jan 13 2009 - Ulrich Drepper <drepper@redhat.com>
   * Ported to LTP - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>
   */
+
  /*\
   * [Description]
+ *
   * Testcase to check whether dup3() supports O_CLOEXEC flag.
   */

@@ -31,22 +33,17 @@ static struct tcase {

  static void cleanup(void)
  {
-       if (fd > 0)
+       if (fd > -1)
                 close(fd);
  }
+
  static void run(unsigned int i)
  {
         int ret;
         struct tcase *tc = tcases + i;
-
-       TEST(dup3(1, 4, tc->coe_flag));
+       TST_EXP_FD_SILENT(dup3(1, 4, tc->coe_flag), "dup3(1, 4, %d)", 
tc->coe_flag);

         fd = TST_RET;
-       if (TST_RET == -1) {
-               tst_res(TFAIL | TTERRNO, "%s failed", tc->desc);
-               goto free;
-       }
-
         ret = SAFE_FCNTL(fd, F_GETFD);
         if (tc->coe_flag) {
                 if (ret & FD_CLOEXEC)
@@ -59,9 +56,6 @@ static void run(unsigned int i)
                 else
                         tst_res(TPASS, "%s set close-on-exec flag", 
tc->desc);
         }
-
-free:
-       SAFE_CLOSE(fd);
  };

  static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c 
b/testcases/kernel/syscalls/dup3/dup3_02.c
index e31a758..009b003 100644
--- a/testcases/kernel/syscalls/dup3/dup3_02.c
+++ b/testcases/kernel/syscalls/dup3/dup3_02.c
@@ -3,12 +3,15 @@
   * Copyright (c) 2013 Fujitsu Ltd.
   * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
   */
+
  /*\
   * [Description]
+ *
   * Test for various EINVAL error.
- * - EINVAL - oldfd is equal to newfd without using O_CLOEXEC flag
- * - EINVAL - oldfd is equal to newfd with using O_CLOEXEC flag
- * - EINVAL - flags contain an invalid value
+ *
+ * - oldfd is equal to newfd without using O_CLOEXEC flag
+ * - oldfd is equal to newfd with using O_CLOEXEC flag
+ * - flags contain an invalid value
   */

  #define _GNU_SOURCE
@@ -18,7 +21,7 @@
  #include "tst_test.h"
  #include "tst_safe_macros.h"

-static int old_fd;
+static int old_fd = 3;
  static int new_fd = 5;

  static struct tcase {
@@ -39,21 +42,7 @@ static void run(unsigned int i)
                 "dup3(%d, %d, %d)", *tc->oldfd, *tc->newfd, tc->flags);
  }

-static void setup(void)
-{
-       old_fd = SAFE_CREAT("testeinval.file", 0644);
-}
-
-static void cleanup(void)
-{
-       if (old_fd > 0)
-               SAFE_CLOSE(old_fd);
-}
-
  static struct tst_test test = {
         .tcnt = ARRAY_SIZE(tcases),
         .test = run,
-       .setup = setup,
-       .cleanup = cleanup,
-       .needs_tmpdir = 1,
  };

Best Regards
Yang Xu
> From: QI Fuli<qi.fuli@fujitsu.com>
>
> Convert syscalls/dup3_{01,02} to new API
>
> QI Fuli (2):
>    syscalls/dup3_01: Rewrite dup3_01 and convert it to new API
>    syscalls/dup3_02: Convert to new API
>
>   testcases/kernel/syscalls/dup3/dup3_01.c | 163 ++++++++---------------
>   testcases/kernel/syscalls/dup3/dup3_02.c | 119 +++++------------
>   2 files changed, 87 insertions(+), 195 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
