Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09876C5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 09:30:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC13C3E6CAA
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 11:30:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FFA83DD309
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 08:54:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CCFB6002A0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 08:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786517666; x=1818053666;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=Br+1iMHv61cnlmrwgJ8dZq/Cn/0HAW5MTceMDf0ZnT8=;
 b=YBLNkyh8eHvqXjbSKfzq7wdKrACqqb/ZPrOhGVJxz7JQMeeM3ASXyLCs
 I1I7V/qrEH5jtOijAishwCDgis5BMmu4uO3tZ70fp/46uVvgL0v0OPF5K
 PlPEFr/c1iw5cKU4+RZO2GJusNQ0LXHitjgaVste+L+O6N+LPmPbYjeao
 pExvWCxHjezS81SEhkKRnlZQ8+jSDcn2C1U08nK815rPXd4HJ1z5eYHYy
 sZITHIfDw3lppCGN2QpoEN6W39HjMUl5v+Py6BkX/ckRdTB3bLvDYLaK3
 jmC6V+sBsECOeVR67uCvZWSmpCaXWk/yP9Gkc944+hx43VBMl0xtaUunW A==;
X-CSE-ConnectionGUID: SmzT4HdKSkyBNqClff3Ewg==
X-CSE-MsgGUID: nFNFVK3AQviSOb34D6b9Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87073594"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="87073594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 23:54:22 -0700
X-CSE-ConnectionGUID: feR7ym9vQRGdV++SySbjvw==
X-CSE-MsgGUID: svgbhTWYTQaAa5OeR6b3EQ==
X-ExtLoop1: 1
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 23:54:19 -0700
Date: Wed, 12 Aug 2026 14:54:16 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Message-ID: <202608120846.30e0fb5b-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 12 Aug 2026 11:29:58 +0200
Subject: [LTP] [linus:master] [net]  8e63c9e617: ltp.uevent02.fail
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
Cc: Shahar Shitrit <shshitrit@nvidia.com>, lkp@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com,
 oe-lkp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpIZWxsbywKCmtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgImx0cC51ZXZlbnQwMi5mYWlsIiBv
bjoKCmNvbW1pdDogOGU2M2M5ZTYxNzlhY2UzMDMzZGNkMTk5OTFmOTUzODZlOWQzMTMwZiAoIm5l
dDogRGVmZXIgbmV0ZGV2IEtPQkpfQUREIHVldmVudCB1bnRpbCB0aGUgZGV2aWNlIGlzIHB1Ymxp
c2hlZCIpIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdCBtYXN0ZXIKClt0ZXN0IGZhaWxlZCBvbiBsaW51cy9tYXN0ZXIgICAgICAw
NmNmNjE4OTlkNjQ5OGIzM2U0YjdjODdkOTlkNWJkNDcxY2NjMzc1XQpbdGVzdCBmYWlsZWQgb24g
bGludXgtbmV4dC9tYXN0ZXIgNmI4YzhhZjUxNGQ3MzlkMDMzNWY1NTc5YjU4NWUwMmJhYmU4YTcy
N10KCmluIHRlc3RjYXNlOiBsdHAKdmVyc2lvbjogCndpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6
CgoJdGVzdDogdWV2ZW50CgoKCmNvbmZpZzogeDg2XzY0LXJoZWwtOS40LWx0cApjb21waWxlcjog
Z2NjLTE0CnRlc3QgbWFjaGluZTogMTYgdGhyZWFkcyBJbnRlbChSKSBDb3JlKFRNKSBpNy0xMzYy
MEggKFJhcHRvciBMYWtlKSB3aXRoIDMyRyBtZW1vcnkKCihwbGVhc2UgcmVmZXIgdG8gYXR0YWNo
ZWQgZG1lc2cva21zZyBmb3IgZW50aXJlIGxvZy9iYWNrdHJhY2UpCgoKCgpJZiB5b3UgZml4IHRo
ZSBpc3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2
ZXJzaW9uIG9mIHRoZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRh
Z3MKfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPHlpMS5sYWlAaW50ZWwuY29tPgp8
IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjYwODEyMDg0Ni4zMGUw
ZmI1Yi1sa3BAaW50ZWwuY29tCgoKUEFUSD0vbGtwL2JlbmNobWFya3MvbHRwOi91c3IvbG9jYWwv
c2JpbjovdXNyL2xvY2FsL2JpbjovdXNyL3NiaW46L3Vzci9iaW46L2xrcC9sa3Avc3JjL2Jpbgoy
MDI2LTA4LTA5IDAxOjA3OjM2IGNkIC9sa3AvYmVuY2htYXJrcy9sdHAKMjAyNi0wOC0wOSAwMTow
NzozNiBleHBvcnQgTFRQX1JVTlRJTUVfTVVMPTIKMjAyNi0wOC0wOSAwMTowNzozNiBleHBvcnQg
TFRQUk9PVD0vbGtwL2JlbmNobWFya3MvbHRwCjIwMjYtMDgtMDkgMDE6MDc6MzYga2lyayAtZiB1
ZXZlbnQKSG9zdCBpbmZvcm1hdGlvbgoJSG9zdG5hbWU6ICAgaWdrLXJwbC1kMDEKCVB5dGhvbjog
ICAgIDMuMTMuNSAobWFpbiwgSnVuIDEzIDIwMjYsIDE0OjE4OjAxKSBbR0NDIDE0LjIuMF0KCURp
cmVjdG9yeTogIC90bXAva2lyay5yb290L3RtcDUzYTBwbDQ1CgpDb25uZWN0aW5nIHRvIFNVVDog
ZGVmYXVsdAoKU3VpdGU6IHVldmVudArilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIAKIFsxOzM3bXVldmVudDAxOiAgWzBtIFsxOzMybXBhc3MgWzBtIHwgIFsxOzMzbXRhaW50
ZWQgWzBtICAoMC4xMzdzKQogWzE7MzdtdWV2ZW50MDI6ICBbMG0gWzE7MzFtZmFpbCBbMG0gfCAg
WzE7MzNtdGFpbnRlZCBbMG0gICg1LjM2NHMpCiBbMTszN211ZXZlbnQwMzogIFswbSBbMTszMm1w
YXNzIFswbSB8ICBbMTszM210YWludGVkIFswbSAgKDAuMDM1cykKCkV4ZWN1dGlvbiB0aW1lOiA1
LjU5MnMKCkRpc2Nvbm5lY3RpbmcgZnJvbSBTVVQ6IGRlZmF1bHQKClRhcmdldCBpbmZvcm1hdGlv
bgrilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAK
S2VybmVsOiAgIExpbnV4IDcuMi4wLXJjNSsgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBTdW4gQXVn
ICA5IDAyOjQ3OjMzIENFU1QgMjAyNgpDbWRsaW5lOiAgaXA9MTAuMjUwLjE3LjIyOjoxMC4yNTAu
MTcuMjoyNTUuMjU1LjI1NS4wOmlnay1ycGwtZDAxOjpzdGF0aWMKICAgICAgICAgIHJvb3Q9L2Rl
di9yYW0wCiAgICAgICAgICBSRVNVTFRfUk9PVD0vcmVzdWx0L2x0cC91ZXZlbnQvaWdrLXJwbC1k
MDEvZGViaWFuLTEzLXg4Nl82NC0yMDI1MDkwMi5jZ3oveDg2XzY0LXJoZWwtOS40LWx0cC9nY2Mt
MTQvOGU2M2M5ZTYxNzlhY2UzMDMzZGNkMTk5OTFmOTUzODZlOWQzMTMwZi8wCiAgICAgICAgICBC
T09UX0lNQUdFPS9wa2cvbGludXgveDg2XzY0LXJoZWwtOS40LWx0cC9nY2MtMTQvOGU2M2M5ZTYx
NzlhY2UzMDMzZGNkMTk5OTFmOTUzODZlOWQzMTMwZi92bWxpbnV6LTcuMi4wLXJjNSsKICAgICAg
ICAgIGJyYW5jaD1saW51eC1kZXZlbC9kZXZlbC1ob3VybHktMjAyNjA4MDctMjExOTIwCiAgICAg
ICAgICBqb2I9L2xrcC9qb2JzL3NjaGVkdWxlZC9pZ2stcnBsLWQwMS9sdHAtdWV2ZW50LWRlYmlh
bi0xMy14ODZfNjQtMjAyNTA5MDIuY2d6LThlNjNjOWU2MTc5YS0yMDI2MDgwOS0yMzI0ODktM2V4
bzhwLTAueWFtbAogICAgICAgICAgdXNlcj1sa3AKICAgICAgICAgIEFSQ0g9eDg2XzY0CiAgICAg
ICAgICBrY29uZmlnPXg4Nl82NC1yaGVsLTkuNC1sdHAKICAgICAgICAgIGNvbW1pdD04ZTYzYzll
NjE3OWFjZTMwMzNkY2QxOTk5MWY5NTM4NmU5ZDMxMzBmCiAgICAgICAgICBpbnRyZW1hcD1wb3N0
ZWRfbXNpCiAgICAgICAgICBhY3BpX3JzZHA9MHgzZjg4YTAxNAogICAgICAgICAga2hvPW9mZgog
ICAgICAgICAgbWF4X3VwdGltZT03MjAwCiAgICAgICAgICBMS1BfU0VSVkVSPWludGVybmFsLWxr
cC1zZXJ2ZXIKICAgICAgICAgIG5va2FzbHIKICAgICAgICAgIHNlbGludXg9MAogICAgICAgICAg
ZGVidWcKICAgICAgICAgIGFwaWM9ZGVidWcKICAgICAgICAgIHN5c3JxX2Fsd2F5c19lbmFibGVk
CiAgICAgICAgICByY3VwZGF0ZS5yY3VfY3B1X3N0YWxsX3RpbWVvdXQ9MTAwCiAgICAgICAgICBu
ZXQuaWZuYW1lcz0wCiAgICAgICAgICBwcmludGsuZGV2a21zZz1vbgogICAgICAgICAgcGFuaWM9
LTEKICAgICAgICAgIHNvZnRsb2NrdXBfcGFuaWM9MQogICAgICAgICAgbm1pX3dhdGNoZG9nPXBh
bmljCiAgICAgICAgICBvb3BzPXBhbmljCiAgICAgICAgICBsb2FkX3JhbWRpc2s9MgogICAgICAg
ICAgcHJvbXB0X3JhbWRpc2s9MAogICAgICAgICAgZHJiZC5taW5vcl9jb3VudD04CiAgICAgICAg
ICBzeXN0ZW1kLmxvZ19sZXZlbD1lcnIKICAgICAgICAgIGlnbm9yZV9sb2dsZXZlbAogICAgICAg
ICAgY29uc29sZT10dHkwCiAgICAgICAgICBlYXJseXByaW50az10dHlVU0IwLDExNTIwMAogICAg
ICAgICAgY29uc29sZT10dHlVU0IwLDExNTIwMAogICAgICAgICAgdmdhPW5vcm1hbAogICAgICAg
ICAgcncKICAgICAgICAgIGtlZXBfaW5pdHJkcz0vb3NpbWFnZS9wa2cvZGViaWFuLTEzLXg4Nl82
NC0yMDI1MDkwMi5jZ3ovbHRwLXg4Nl82NC0wYWQ3OWU2ZmEtMV8yMDI2MDgwOC5jZ3oKICAgICAg
ICAgIGFjcGlfcnNkcD0weDNmODhhMDE0Ck1hY2hpbmU6ICB1bmtub3duCkFyY2g6ICAgICB4ODZf
NjQKUkFNOiAgICAgIDI4MjM2MTkyIGtCClN3YXA6ICAgICAwIGtCCkRpc3RybzogICBkZWJpYW4g
MTMKCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgAogICAgICBURVNUIFNVTU1BUlkK4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSAClN1
aXRlOiAgIHVldmVudApSdW50aW1lOiA1LjUzNnMKUnVuczogICAgMwoKUmVzdWx0czoKICAgIFBh
c3NlZDogICA5CiAgICBGYWlsZWQ6ICAgMQogICAgQnJva2VuOiAgIDAKICAgIFNraXBwZWQ6ICAw
CiAgICBXYXJuaW5nczogMAoKIFsxOzMxbUZhaWx1cmVzOiBbMG0KICAgIOKAoiB1ZXZlbnQwMgoK
U2Vzc2lvbiBzdG9wcGVkCkxUUCB0ZXN0IGRldGFpbHMKLS0tLS0tLS0tLS0tLS0tLQp1ZXZlbnQw
MjogdWV2ZW50Lmg6MTczOiBURkFJTDogRGlkIG5vdCBnZXQgYWxsIGV4cGVjdGVkIFVFVkVOVFMK
CgoKVGhlIGtlcm5lbCBjb25maWcgYW5kIG1hdGVyaWFscyB0byByZXByb2R1Y2UgYXJlIGF2YWls
YWJsZSBhdDoKaHR0cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjYwODEy
LzIwMjYwODEyMDg0Ni4zMGUwZmI1Yi1sa3BAaW50ZWwuY29tCgoKCi0tCjAtREFZIENJIEtlcm5l
bCBUZXN0IFNlcnZpY2UKaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10ZXN0cy93aWtpCgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
