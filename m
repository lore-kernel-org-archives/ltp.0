Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8227C369A2
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744356319; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZT42cO6H0INRpoMDTn2nArDFt9wX8jk0n2LBBLW+CGg=;
 b=rDidLgQQ6gJOlBbL+TSY+FYDBqJzmbQ37fOboPovobEq+gloigTJ9yNw5KhIvRstqAhb1
 MBgWeRsQXt7Mwmh3CqMeQ5xGVwF/xFFeX3cOAgEmw7U02V64WZ5WrurhHkQLGY3IJ9a4DXC
 GjPzL4Bo/USU8qd0ESQRsOI5m6zI++I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45F0A3CB58E
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 09:25:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A8A63CABDF
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 23:22:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gd-ms.com (client-ip=137.100.132.43; helo=vadc01-egs01.gd-ms.com;
 envelope-from=john.morin@gd-ms.com; receiver=lists.linux.it)
Received: from vadc01-egs01.gd-ms.com (vadc01-egs01.gd-ms.com [137.100.132.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AAAB3140004B
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 23:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=gd-ms.com; i=@gd-ms.com; q=dns/txt; s=esa;
 t=1744320136; x=1775856136;
 h=from:to:subject:date:message-id:mime-version;
 bh=Y7uxw5tzn5VNuERdTmFQiUoFF0G1w7z9ORwWDv7xWwM=;
 b=sggXL3oshXi8CpddHErKu4Iauj7kSWBaJkNdL1Mmjii693yoZgfOy/3J
 pq4pMYGofs0rzqu7RsOAYKbSQR1zoGshW4DuDwySpaKAURW35ELsW0r7L
 6ovG3kRbRyQyZ1DSf68WdYkk6WZaYIyzKtIoqhVYj8ar5WDTmWVjfhV4j
 AZ+z/czbIOxkyplASTPuVnVunGwr1PaxJNImrfpyaIk/BXLNUGxAQ2BMN
 7X5zr/l8aOmSqz2RT4fFxkloLxhygpZB8yhKEUFsyHfkryjXZQGM+E/Kk
 5UpI+YwrTa8gwgHPmvKCT+rAvnlNsP67Acp73yw9wfQRadHYWpv9VNhTK w==;
X-CSE-ConnectionGUID: dL7zCwd0Qmu75v9FlsAJ3w==
X-CSE-MsgGUID: VhKLgua6RvGsXGHJkSwS6g==
X-IronPort-AV: E=Sophos;i="6.15,203,1739854800"; d="scan'208,217";a="10119955"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=Lm9n4twtcb0WKraXf4Vm6Ty0Qxikv26rHSxzK4dd/Og4992iGZw4xxAjc2SUwK6+X2Wtzx/cdXK4wdE1TGW5eV2qH22R9Ib2cOZ7BCA3/ZVIYdCQDlpN4053W7+SzJIq4tPzWzCRdI1KrtdmeOffxKaLyxwiFU43f9AqEFGSLiYykiRk9pMto+iR92LI4395asJNmCsOO7Rdou7iss8N7VE7zuy4tXmOCz3uzLHodSbLSKvItcDc6spg12njZ4wpm+tKXQnmbMVkOxdRX8U0z0sgDuuUhMmVK0uIFhFST6aLXsdtDHfvHdrd7GRINs+gqnyJnhhG1zzRP4iiMzqdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehq5aWh+UwJfirBIAPLWq11kpuhC6vVj54y+AW3cqQM=;
 b=WKKXJHQ0OSBVmn6IOR6yux+twV739RuRsr8+8/bYCVKkovoy5EpqsR5Y2nvVo7XAQpobIiW1U3b9VfUKoddqtUKxrtMCE8bWhDPw8j0ezWxyJgiPwzRf4y4wAFNXdCtccxOd+MlZezcqUphkqZhpts5Cu3C/yqYzwRxJkaW2i4zu15TtTD3tnYqlLiGL94U1vc0gfAYQ0HAyglK58N1oK5BVuBtYwSVPYVYHMy8VC0ZMpWiLBbdd6kOuqirIZdifO6bPxwNKTZVvf0WNMjAgSbM5xytGVltG7/rbH6AoMEH/8ICSyRVfUp+WdL91l5YNvyyeHvToaTjNPAc6aYh66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gd-ms.com; dmarc=pass action=none header.from=gd-ms.com;
 dkim=pass header.d=gd-ms.com; arc=none
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: Bug: ROD_SILENT does not preserve its argument list
Thread-Index: AduqXLatYYKK666VQemanz5d0/l82A==
Date: Thu, 10 Apr 2025 21:22:11 +0000
Message-ID: <BN1P110MB067481F2145E0C1A6A34240CDFB7A@BN1P110MB0674.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gd-ms.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN1P110MB0674:EE_|BN0P110MB1787:EE_
x-ms-office365-filtering-correlation-id: 0e8bb198-b72d-4179-0748-08dd7875c1c3
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tk+2FPXHraTY4TZbRN6xRDhZOa719pXqF4eKFNZaxqctD0fdfEf+ktiZ3Z?=
 =?iso-8859-1?Q?li4gRRKzhImbk+LZN81NgDSJl/iZRU47VTDjp9I1ac+nKTscCK6OyCSU0s?=
 =?iso-8859-1?Q?KSgwndqraMgZSSgPplObGQhdSHVU+wrCBzMwPaJI0m7n6vtji/tX58R0cx?=
 =?iso-8859-1?Q?Eu2903CztirwIEzP+v55sbHH8boVFVjVxATAOJpni4SVUUpCHciMa6mFnF?=
 =?iso-8859-1?Q?pOxl0lBL/tZ38zhgxqB4FPYWDvqHbbX29Kyk1EjtYMCd2PXSX9vibBmBLn?=
 =?iso-8859-1?Q?L3tmFDSUg60fB0NBrW6JtKGQA86nLOQRowz3GILpUKS4qCorJQ6NJEvWQ2?=
 =?iso-8859-1?Q?jL4FyM8ep5/agZXPfKXbACyw9cbVjsMuYlSPFCFNbSCxPZX/XHItUOcv9w?=
 =?iso-8859-1?Q?iX8X3IclxnkIkOFh+PrDZLLdLGbNBPtzEpYJCBZSi2ZAb/nVFqxm6WuczP?=
 =?iso-8859-1?Q?2vOJ5QGG9bESMGOdjK104m6rIUiI5qWwm+4eq3PN5eK9XyZNr5LD5zVXIH?=
 =?iso-8859-1?Q?y27e8B4fSPqmATnKM21WTCtFcD0z4pj0vPCl8wl5Ou8FqjdCLQJs1cO3Lw?=
 =?iso-8859-1?Q?PEfBk47X5UbMVgTfG8XLJ0Ov61mqtPWX3AVIi3hQi4QbRAJFNn/oA27rPA?=
 =?iso-8859-1?Q?3MaGkGln6cr8BiRMgqYGMbjHqq++73MKqGO/a/g+Y2DBsEh8O3SJHwC9TK?=
 =?iso-8859-1?Q?eXhGxip/1w5rpb+4jepMZ5XeqRavKWHFXucL0MPsGQ2g9/jZ655EZKbCks?=
 =?iso-8859-1?Q?3fcPUDwQaqDLDIhQtdZKq+dHPi7CuCaUDI/qmpNy26fjXydPsS7+WMnfzE?=
 =?iso-8859-1?Q?1H0yLdkERg972sUpsw5+XXrTN2stccWanfDUpIIvKfP3Sq3XQulnlUJa8E?=
 =?iso-8859-1?Q?k/r0a1X8IU/9XN82H1UOSE5Ls1PcHfjpFy2ngiOnv9ElWVL9zGV5ItK3S5?=
 =?iso-8859-1?Q?9XEukMXhb+pL8lrJu9uHoxH5tuEQI4VIa761P1BdQkYx2Ojyi1psmKlxvO?=
 =?iso-8859-1?Q?ynykJHLo0eMtbGCrC19+Y7NJ+JtwWVeCALw3r3Yw4QqxpX6ZgXHdUMYbZC?=
 =?iso-8859-1?Q?uUroe7F6BZfvybwptHqWs83wGK4qomlLqKHFWY3RDh3wR8DVtsxK5RGqC0?=
 =?iso-8859-1?Q?Gcpaq8WVI1eDPs0Wv6ys0Gkg6rbouWAHBgHDpsBDXqzaPeSd7u35rVnYta?=
 =?iso-8859-1?Q?deTRy0yimfQatzCAn2zDkpWyP96UgHxcee+dpCfucvI1Uv5A5Zxl9BRoEU?=
 =?iso-8859-1?Q?V5LGtx7kMMZufCfPXcF6t3Xa/SmrEAj6U6lfqY6sq98+P3iR/bzkQKt9Vn?=
 =?iso-8859-1?Q?f1QeZg4qIBB+wegmq7rBBcQKCIqQX3bEaFEjvEXBlaw1Gix6Tz7DviSgk6?=
 =?iso-8859-1?Q?DROYOnRWs9HwTtjUBvnFJC4SlSsCjrUN6Kl69CaDR5adh5xiti3D7/pp5J?=
 =?iso-8859-1?Q?TYkW82rsYqRvTHgCZBgP0NtSmbRUSFsiYX9RctCG67/+X+q5hG+j/uXMTK?=
 =?iso-8859-1?Q?kEtWgqo/26j7mZ5N0XaW5xv91Gpgw7JXSaJgpCRThAOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN1P110MB0674.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(38070700018)(8096899003); DIR:OUT; SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P/TwCOJemHyABgQh6LI73wYV3MZ/0tNBA99Uu16ht3CVux21ymIlAYqEbu?=
 =?iso-8859-1?Q?k2956m2axylG5+kRflvJSVIPnRg1FThpWqTPxi31BVMwcJc9u14aQ+9QqP?=
 =?iso-8859-1?Q?pYlNLmI+gp90AhZbWL7JmAxHPQ9rfI3z4jFb/GwFPcBpM9zX7k9v/e/uG0?=
 =?iso-8859-1?Q?dIiRWxf54HwC3Eiu77+VSd9aeVBCSnHhxaZOaXOXVQgml7tNEZhXrvJRNK?=
 =?iso-8859-1?Q?F60K6bz46ICcaaigDIFZvqh6uhFQH47rawu2lmtcfiqgW1m9B7YPZpIExy?=
 =?iso-8859-1?Q?YQDdvlTfbs65Fmis1WctRCJAvXJt3dzbrsG4Rm4zBj4Oo3CDyGBTuPl2kk?=
 =?iso-8859-1?Q?GYkfZv+eWw0CIpijFUSUc9Ln6InQ7vkZ629i9kBqvxApI4mBZRY/AmX5yp?=
 =?iso-8859-1?Q?cEtbWnLfDFqMrhPddZLkkTwzWWpz1djtSsJwjajFV1Ng+ApFva3qiP/wFZ?=
 =?iso-8859-1?Q?1ocCMUZhPAii3dQgpl0/kYD2MxX2q8xDaUdFfVYsJAVOf0ImUxAUxcDSKE?=
 =?iso-8859-1?Q?HniH7/whGMWMamanX4Rl94QjP3JzN/4xfuTpSAydaiaftamvXkAQ9rbp04?=
 =?iso-8859-1?Q?lDRzE9tKX+9A5xi9oQveMV/seDYLsuv1DNxm2S0YEmHg5ggH4x/5enCRqA?=
 =?iso-8859-1?Q?ntGe9w12DgGfTeUb+IVcYDSTgSrQXCF27+aw8QkylI1F2KfdUQV6bHmfiN?=
 =?iso-8859-1?Q?K1jBAsTN/QKXBlzPGEcS9LRrkrT9ecf4OLrySJQHQUJbzBHWYngtUQUBcD?=
 =?iso-8859-1?Q?0Da55U+8IbVkrESGYn502JIdNNOASTzDpj10a0+NlTuKNP6HArAEEPEZdi?=
 =?iso-8859-1?Q?r/u9fUJl74lh21ARuuAF+6z2f+ae7MMlmjHu3JHmogElCqNNSLcRhPTA83?=
 =?iso-8859-1?Q?hBnxivjyTO4OBZ27n3l63FQSnN6q0dFi7asqxx8Kw6636X+jWr6tU17fcC?=
 =?iso-8859-1?Q?9Uen8rrNZQc5Z4nspHCzDr7Teb8SncVnDUk+3Gb0dCh1c1UB39A3oxYsJx?=
 =?iso-8859-1?Q?fYjIMJiflZYmYigx9qLPTHGi3tm/KxjviEpTz66EZjuVSgM6RFRLLfdkrV?=
 =?iso-8859-1?Q?glqJZ48rCp0jASgvQFlXHSNosasjCJ/owdkHsJ2Lg+gIQLT1aTibFgTBlA?=
 =?iso-8859-1?Q?t4ovP0w37hC7rXEtrBQhbbKOrJwtD8tC5V36w2jH7Eou2gLtrjsUSLAmRE?=
 =?iso-8859-1?Q?sjOZnlPqvWCIJVHMnN0gsnSsnNVrXauDfo6pjPr4LMjHbJKNWrxgb/BFOQ?=
 =?iso-8859-1?Q?CfCJyYB7jpAPT3A+Xdr6y3vQYYGsv+Qdj9/8iPBIK1XZXWvWLEVjNJAnFL?=
 =?iso-8859-1?Q?1HT53Ch+3WhEFJPJvJPPg4zq1FNzwgD3iJ1rljbFnvi3IkJQup5iMFBS8/?=
 =?iso-8859-1?Q?EuNheNF3TRGA9tbj5TSwOE9TIUFFe1PU3Rc9q7lAi/MhnUS/lmKF/RrXBS?=
 =?iso-8859-1?Q?Ux/l7qASIIF6zliXTv4m1hshsKIGZi8FdN/ZWsn5Co4n69KVZmIjPPGgez?=
 =?iso-8859-1?Q?VhjxFpYTFMC+BPaxsLhIZmSam8/fiVqmegRdbng1m8V1tOtLjv2CBPhq8D?=
 =?iso-8859-1?Q?Fc+vL70=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN1P110MB0674.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8bb198-b72d-4179-0748-08dd7875c1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 21:22:11.3553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7c5a26cf-ddf0-400c-9703-4070b4e3a54d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1787
X-OriginatorOrg: gd-ms.com
X-Content-Scanned: Fidelis Mail
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Apr 2025 09:24:58 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Bug: ROD_SILENT does not preserve its argument list
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
From: "John.Morin--- via ltp" <ltp@lists.linux.it>
Reply-To: "John.Morin@gd-ms.com" <John.Morin@gd-ms.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello:
Submitting bug against ROD_SILENT.
Sincerely,

  *   John Morin.

==== Bug in ROD_SILENT ====
Need to quote "$@" in ROD_SILENT so each parameter is individually quoted. Otherwise, the original structure of its arguments is lost.

==== Fix ====
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 718a6b0ca..cfa327a8a 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -153,7 +153,7 @@ ROD_SILENT()
{
        local tst_out

-       tst_out="$(tst_rod $@ 2>&1)"
+       tst_out=$(tst_rod "$@" 2>&1)
        if [ $? -ne 0 ]; then
                echo "$tst_out"
                tst_brk TBROK "$@ failed"

==== Test showing bug ====
Test "test1" is an LTP tests. The runs the same command using ROD and ROD_SILENT. The command it runs simply greps for string "blah1 blah2" in file data2. When run, ROD passes while ROD_SILENT fails. This is because ROD_SILENT does not preserve quoted arguments.

% cat data2
--- blah1 blah2 blah3 ---

% cat test1
#!/bin/bash
TST_TESTFUNC="do_test"
do_test()
{
    ROD        grep "blah1 blah2" data2
    ROD_SILENT grep "blah1 blah2" data2
    tst_res TPASS "pass"
}
. tst_test.sh
tst_run

% ./test1 # Note ROD passes while ROD_SILENT fails
> ./test1
test1 1 TINFO: Running: test1
test1 1 TINFO: Tested kernel: ...
test1 1 TINFO: timeout per run is 0h 5m 0s
--- blah1 blah2 blah3 ---
grep: blah2: No such file or directory
data2:--- blah1 blah2 blah3 ---
test1 1 TBROK: grep blah1 blah2 data2 failed

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
