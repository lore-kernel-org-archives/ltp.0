Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3037C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:40:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9C261262
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A9C261262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AF5C3C6EA6
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:40:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24FB23C8E40
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 03:23:23 +0200 (CEST)
Received: from unicom145.biz-email.net (unicom145.biz-email.net
 [210.51.26.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 759C51000412
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 03:23:19 +0200 (CEST)
Received: from ([60.208.111.195])
 by unicom145.biz-email.net ((LNX1044)) with ASMTP (SSL) id TAX00115;
 Sun, 26 Sep 2021 09:23:15 +0800
Received: from jtjnmail201621.home.langchao.com (10.100.2.21) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 26 Sep 2021 09:23:13 +0800
Received: from jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a])
 by jtjnmail201621.home.langchao.com ([fe80::31c7:1db7:6c09:282a%7])
 with mapi id 15.01.2308.014; Sun, 26 Sep 2021 09:23:13 +0800
From: =?gb2312?B?S2FuZSBXb25nICjN9b+s1Kop?= <wangkaiyuan@inspur.com>
To: "pvorel@suse.cz" <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH] Fix the statistical number of results in the html
Thread-Index: Adeyc43ECa0E6u++nUCkuLsAbAlWGw==
Date: Sun, 26 Sep 2021 01:23:13 +0000
Message-ID: <57a704f5c9ee4cc29d9514077afbed42@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.72.174.216]
MIME-Version: 1.0
tUid: 20219260923150f77f05789426830b60fcb5014272700
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Sep 2021 10:40:04 +0200
Subject: Re: [LTP] [PATCH] Fix the statistical number of results in the html
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
Cc: =?gb2312?B?SGFycmlzIHNvbmcgKMvOv60pLcDLs7HQxc+i?= <songkai01@inspur.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1453159331=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1453159331==
Content-Language: zh-CN
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0015_01D7B2B8.20D8E190"

------=_NextPart_000_0015_01D7B2B8.20D8E190
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,

> Hi,
> 
> > From: wangkaiyuan <wangkaiyuan@inspur.com>
> 
> > According to the statistical method of ltp-pan on TFAIL TBROK TCONF
> > TPASS..., the statistical method of the ltp test result type in
> > genhtml.pl is modified to ensure that the .log format of the ltp
> > result is consistent with the test result in the .html format.
> 
> > The original statistical method policy expression "/\ TFAIL\ /" in the
> > original genhtml.pl for the test result type cannot match the "TFAIL:"
> > in the normal test result, causing problems in the
> This could be fixed with :?, right?
First of all, the regular expression matching error causes the html result
to be inconsistent with the log result. If only the regular expression is 
modified, it will cause multiple test results for one test item.For example,
if TPSS/TCONF appears in the same test item, the test item will be
counted twice, TPSS&TCONF, this is unreasonable, and the statistical 
logic in genhtml.pl is flawed

Kind regards,
wangkaiyuan
> > calculation result. At the same time, the statistical method in
> > genhtml.pl cannot guarantee that each test item has only one test
> > result, because the output of a test item may include TFAIL, TCONF,
> > and TPASS at the same time.
> That's a valid input.
> 
> > Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
> >                Chunsing.dey <daichx@inspur.com>
> nit: both should have Signed-off-by:, you can also use Co-developed-by:
> for the second developer.
> 
> nit: there are whitespace errors in the patch.
> 
> I do not dare to review it as I've never used the tool.
> FYI ltp-pan is deprecated, you can try to use runltp-ng [1] which we'd
like to
> bring to LTP upstream (to replace ltp-pan and runltp).
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/metan-ucw/runltp-ng


------=_NextPart_000_0015_01D7B2B8.20D8E190
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
AwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUHBXC
FiMze80KodS/uAgWSWdM+C8wHwYDVR0jBBgwFoAUXlkDprRMWGCRTvYetaU5pjLBNWowggEPBgNV
HR8EggEGMIIBAjCB/6CB/KCB+YaBumxkYXA6Ly8vQ049SU5TUFVSLUNBLENOPUpUQ0EyMDEyLENO
PUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPWhvbWUsREM9bGFuZ2NoYW8sREM9Y29tP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/
YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIY6aHR0cDovL0pUQ0EyMDEyLmhv
bWUubGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSU5TUFVSLUNBLmNybDCCASkGCCsGAQUFBwEBBIIB
GzCCARcwgbEGCCsGAQUFBzAChoGkbGRhcDovLy9DTj1JTlNQVVItQ0EsQ049QUlBLENOPVB1Ymxp
YyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9aG9tZSxE
Qz1sYW5nY2hhbyxEQz1jb20/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNlcnRpZmlj
YXRpb25BdXRob3JpdHkwYQYIKwYBBQUHMAKGVWh0dHA6Ly9KVENBMjAxMi5ob21lLmxhbmdjaGFv
LmNvbS9DZXJ0RW5yb2xsL0pUQ0EyMDEyLmhvbWUubGFuZ2NoYW8uY29tX0lOU1BVUi1DQS5jcnQw
SQYDVR0RBEIwQKAmBgorBgEEAYI3FAIDoBgMFndhbmdrYWl5dWFuQGluc3B1ci5jb22BFndhbmdr
YWl5dWFuQGluc3B1ci5jb20wDQYJKoZIhvcNAQELBQADggEBACIJa1zjgl1MKXgYO3e3oY7xTo6h
hjbEDq5TPGlTyBXhwMAXKUVVWfc1VDU9s1vibvRJvdcGfNBe4s0tQHOZ5oNny9dF7BipP7/QA2i4
a8xtJatu5lxonOYKaHx43bunRTwy3meG90B2lq5JCIYYl+d0kx9B5af5B0T5V9n2CF9NLbzTYgNL
OcNXBdQAcpNnJtAd+HugBsiJ2AJpxdPt/j9k3l/QOsVbvFQITZbAX5w7fzOrZ6+qmOARmoIuADuB
lqB9IexrV1gIFbog70oYzJ0pwc89J28amROAlTcgAws6knPraJOvabJ6AiBx2fZgQ/3ych1q74+f
ug9itNMu1WcxggOTMIIDjwIBATBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/Is
ZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQIT
fgAA0c6DxAMX4foBcQAAAADRzjAJBgUrDgMCGgUAoIIB+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA5MjYwMTIzMTJaMCMGCSqGSIb3DQEJBDEWBBRIO1xuv10v
NQxbJ5PY1FSBApkV3zB/BgkrBgEEAYI3EAQxcjBwMFkxEzARBgoJkiaJk/IsZAEZFgNjb20xGDAW
BgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkWBGhvbWUxEjAQBgNVBAMTCUlO
U1BVUi1DQQITfgAA0c6DxAMX4foBcQAAAADRzjCBgQYLKoZIhvcNAQkQAgsxcqBwMFkxEzARBgoJ
kiaJk/IsZAEZFgNjb20xGDAWBgoJkiaJk/IsZAEZFghsYW5nY2hhbzEUMBIGCgmSJomT8ixkARkW
BGhvbWUxEjAQBgNVBAMTCUlOU1BVUi1DQQITfgAA0c6DxAMX4foBcQAAAADRzjCBkwYJKoZIhvcN
AQkPMYGFMIGCMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMw
CwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBD0SOlgEgngehl4SLC
CN0qTCiB2NgkXu7nhAKBxy0jjPFsSSqtWUc75BjCCvKSoZN3L1TRQuw2yW4XIesAHIv+u//8zbW/
tJ5I24AF3Qn8udIziP9yrkuNZRolMqwpv8cmSxe8oQgXnz9ybUxRW9Yze3RWYNJIJ1RJQhBc8Rk+
vN8JLwJ/5ayoKvmo7hLfo2ZIc86QYs2ujwc8YkvowB1zeN1sk/sqoeSn8rHFjDHKtirOSsnwz0+d
S9JWn+TX8rEu+QhuTybGesQ+e7dP/QiifaXegNbAJcvmMBS67tJwbKxSTuqKeChbYnHdCn97xxbd
B6L1dHUjwyFioWSdtVcQAAAAAAAA

------=_NextPart_000_0015_01D7B2B8.20D8E190--

--===============1453159331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1453159331==--
