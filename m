Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61403C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 19:00:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6D53C79AA
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 20:00:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 040A33C0572
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 19:59:49 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81B49220C42
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 19:59:47 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1dch009312;
 Thu, 20 Feb 2025 18:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OQkyoP
 DDFoOqdoxDmIN7TKNLFJjbaD8hujTu/sC9V+w=; b=UYiOD7h5lnzsm2FAOcFPu8
 oxXN4ZkZvUAtAUa9yWZVn/Tt1Fe6HdGNY3+LFYzGpE9lkVb9qLLTp1TrGkRaH+tr
 woBAqu2jyY0sRxPjW7vN2yl/+Yju+MCRGjx3fmIbUMI6Q/jtHWPlcUW6sOKdXFTi
 ur3d2jbGRaoPkb9hbbtLR3A0lWgNGXl+GcEaD66GvKdRaoWeiWGMbrMyuLcOw1GG
 nLHxGWkL3jV7o/B2h8k/CUHup/85yIhFH8FZO3/1bdQBJCcV6+HJj1ypxnAKTQVR
 lzF/mzohRFuBCVZFZh1rt30eyoCiTtA9jNYtI5T93mGrPl5A2AujUKxjkU/K05Ig
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wu80csx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 18:59:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KI9rLR029299;
 Thu, 20 Feb 2025 18:59:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w024kpp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 18:59:45 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51KIxj3U65470928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 18:59:45 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F92358059;
 Thu, 20 Feb 2025 18:59:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C46E658058;
 Thu, 20 Feb 2025 18:59:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.31.103.152]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2025 18:59:44 +0000 (GMT)
Message-ID: <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2025 13:59:44 -0500
In-Reply-To: <20250220181604.GA2709977@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xY-Nj3lZjWuHGwMvP2VebYEjdVSNyG5j
X-Proofpoint-ORIG-GUID: xY-Nj3lZjWuHGwMvP2VebYEjdVSNyG5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200130
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 3/3] ima: additional ToMToU violation tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDE5OjE2ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhp
IE1pbWksCj4gCj4gPiBLZXJuZWwgcGF0Y2ggImltYTogbGltaXQgdGhlIG51bWJlciBvZiBUb01U
b1UgaW50ZWdyaXR5IHZpb2xhdGlvbnMiCj4gPiBwcmV2ZW50cyBzdXBlcmZsdW91cyBUb01Ub1Ug
dmlvbGF0aW9ucy7CoCBBZGQgY29ycmVzcG9uZGluZyBMVFAgdGVzdHMuCj4gCj4gPiBMaW5rOgo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5LzIwMjUwMjE5MTYyMTMx
LjQxNjcxOS0zLXpvaGFyQGxpbnV4LmlibS5jb20vCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaW1pIFpv
aGFyIDx6b2hhckBsaW51eC5pYm0uY29tPgo+IAo+IFVuZm9ydHVuYXRlbHkgdGVzdHMgZmFpbCBv
biBib3RoIG1haW5saW5lIGtlcm5lbCBhbmQga2VybmVsIHdpdGggeW91ciBwYXRjaGVzLgoKVGhl
IG5ldyBMVFAgSU1BIHZpb2xhdGlvbnMgcGF0Y2hlcyBzaG91bGQgZmFpbCB3aXRob3V0IHRoZSBh
c3NvY2lhdGVkIGtlcm5lbCBwYXRjaGVzLgo+IAo+IEFueSBoaW50IHdoYXQgY291bGQgYmUgd3Jv
bmc/CgpPZiBjb3Vyc2UgaXQncyBkZXBlbmRlbnQgb24gdGhlIElNQSBwb2xpY3kuICBUaGUgdGVz
dHMgYXNzdW1lIGJlaW5nIGJvb3RlZCB3aXRoIHRoZSBJTUEKVENCIG1lYXN1cmVtZW50IHBvbGlj
eSBvciBzaW1pbGFyIHBvbGljeSBiZWluZyBsb2FkZWQuICBDYW4geW91IHNoYXJlIHRoZSBJTUEg
cG9saWN5PwplLmcuIGNhdCAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5Cgp0aGFua3Ms
CgpNaW1pCgo+IAo+IE1haW5saW5lIGtlcm5lbCAob24ga2VybmVsIHdpdGggeW91ciBwYXRjaGVz
IGl0IGxvb2tzIHRoZSBzYW1lKToKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBSdW5uaW5nOiBp
bWFfdmlvbGF0aW9ucy5zaAo+IGltYV92aW9sYXRpb25zIDEgVElORk86IFRlc3RlZCBrZXJuZWw6
IExpbnV4IHRzIDYuMTMuMC0yLmcwMTI3YTM3LWRlZmF1bHQgIzEgU01QCj4gUFJFRU1QVF9EWU5B
TUlDIFRodSBKYW4gMjMgMTE6MjE6NTUgVVRDIDIwMjUgKDAxMjdhMzcpIHg4Nl82NCB4ODZfNjQg
eDg2XzY0IEdOVS9MaW51eAo+IGltYV92aW9sYXRpb25zIDEgVElORk86IFVzaW5nIC90bXAvTFRQ
X2ltYV92aW9sYXRpb25zLmNLbTM0WFZaazIgYXMgdG1wZGlyICh0bXBmcwo+IGZpbGVzeXN0ZW0p
Cj4gdHN0X2RldmljZS5jOjk5OiBUSU5GTzogRm91bmQgZnJlZSBkZXZpY2UgMCAnL2Rldi9sb29w
MCcKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBGb3JtYXR0aW5nIGV4dDMgd2l0aCBvcHRzPScv
ZGV2L2xvb3AwJwo+IGltYV92aW9sYXRpb25zIDEgVElORk86IE1vdW50aW5nIGRldmljZTogbW91
bnQgLXQgZXh0MyAvZGV2L2xvb3AwCj4gL3RtcC9MVFBfaW1hX3Zpb2xhdGlvbnMuY0ttMzRYVlpr
Mi9tbnRwb2ludAo+IGltYV92aW9sYXRpb25zIDEgVElORk86IHRpbWVvdXQgcGVyIHJ1biBpcyAw
aCA1bSAwcwo+IGltYV92aW9sYXRpb25zIDEgVElORk86IElNQSBrZXJuZWwgY29uZmlnOgo+IGlt
YV92aW9sYXRpb25zIDEgVElORk86IENPTkZJR19JTUE9eQo+IGltYV92aW9sYXRpb25zIDEgVElO
Rk86IENPTkZJR19JTUFfTUVBU1VSRV9QQ1JfSURYPTEwCj4gaW1hX3Zpb2xhdGlvbnMgMSBUSU5G
TzogQ09ORklHX0lNQV9MU01fUlVMRVM9eQo+IGltYV92aW9sYXRpb25zIDEgVElORk86IENPTkZJ
R19JTUFfTkdfVEVNUExBVEU9eQo+IGltYV92aW9sYXRpb25zIDEgVElORk86IENPTkZJR19JTUFf
REVGQVVMVF9URU1QTEFURT0iaW1hLW5nIgo+IGltYV92aW9sYXRpb25zIDEgVElORk86IENPTkZJ
R19JTUFfREVGQVVMVF9IQVNIX1NIQTI1Nj15Cj4gaW1hX3Zpb2xhdGlvbnMgMSBUSU5GTzogQ09O
RklHX0lNQV9ERUZBVUxUX0hBU0g9InNoYTI1NiIKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBD
T05GSUdfSU1BX1JFQURfUE9MSUNZPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBDT05GSUdf
SU1BX0FQUFJBSVNFPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBDT05GSUdfSU1BX0FSQ0hf
UE9MSUNZPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBDT05GSUdfSU1BX0FQUFJBSVNFX0JP
T1RQQVJBTT15Cj4gaW1hX3Zpb2xhdGlvbnMgMSBUSU5GTzogQ09ORklHX0lNQV9BUFBSQUlTRV9N
T0RTSUc9eQo+IGltYV92aW9sYXRpb25zIDEgVElORk86IENPTkZJR19JTUFfTUVBU1VSRV9BU1lN
TUVUUklDX0tFWVM9eQo+IGltYV92aW9sYXRpb25zIDEgVElORk86IENPTkZJR19JTUFfUVVFVUVf
RUFSTFlfQk9PVF9LRVlTPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBDT05GSUdfSU1BX1NF
Q1VSRV9BTkRfT1JfVFJVU1RFRF9CT09UPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiBDT05G
SUdfSU1BX0RJU0FCTEVfSFRBQkxFPXkKPiBpbWFfdmlvbGF0aW9ucyAxIFRJTkZPOiAvcHJvYy9j
bWRsaW5lOiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi4xMy4wLTIuZzAxMjdhMzctCj4gZGVm
YXVsdCByb290PVVVSUQ9ZTM2YjIzNjYtMWFmMi00NDA4LTkwM2MtMWZjYTgyYzYwZjRjIHNwbGFz
aD1zaWxlbnQgdmlkZW89MTAyNHg3NjgKPiBwbHltb3V0aC5pZ25vcmUtc2VyaWFsLWNvbnNvbGVz
IGNvbnNvbGU9dHR5UzAgY29uc29sZT10dHkga2VybmVsLnNvZnRsb2NrdXBfcGFuaWM9MQo+IHJl
c3VtZT0vZGV2L2Rpc2svYnktdXVpZC9jM2I4NjVmOS01ZDViLTQxMGUtYTZkMS05ZWJjZjcyMTU4
NGMgbWl0aWdhdGlvbnM9YXV0bwo+IHNlY3VyaXR5PWFwcGFybW9yIGlnbm9yZV9sb2dsZXZlbAo+
IGltYV92aW9sYXRpb25zIDEgVElORk86ICRUTVBESVIgaXMgb24gdG1wZnMgPT4gcnVuIG9uIGxv
b3AgZGV2aWNlCj4gaW1hX3Zpb2xhdGlvbnMgMSBUSU5GTzogdGVzdCByZXF1aXJlcyBJTUEgcG9s
aWN5Ogo+IG1lYXN1cmUgZnVuYz1GSUxFX0NIRUNLIG1hc2s9Xk1BWV9SRUFEIGV1aWQ9MAo+IG1l
YXN1cmUgZnVuYz1GSUxFX0NIRUNLIG1hc2s9Xk1BWV9SRUFEIHVpZD0wCj4gaW1hX3Zpb2xhdGlv
bnMgMSBUSU5GTzogU1VUIGhhcyByZXF1aXJlZCBwb2xpY3kgY29udGVudAo+IGltYV92aW9sYXRp
b25zIDEgVElORk86IHVzaW5nIGxvZyAvdmFyL2xvZy9hdWRpdC9hdWRpdC5sb2cKPiBpbWFfdmlv
bGF0aW9ucyAxIFRJTkZPOiB2ZXJpZnkgb3BlbiB3cml0ZXJzIHZpb2xhdGlvbgo+IGltYV92aW9s
YXRpb25zIDEgVEZBSUw6IG9wZW5fd3JpdGVycyB0b28gbWFueSB2aW9sYXRpb25zIGFkZGVkCj4g
aW1hX3Zpb2xhdGlvbnMgMiBUSU5GTzogdmVyaWZ5IFRvTVRvVSB2aW9sYXRpb24KPiBpbWFfdmlv
bGF0aW9ucyAyIFRGQUlMOiBUb01Ub1UgdG9vIG1hbnkgdmlvbGF0aW9ucyBhZGRlZAo+IGltYV92
aW9sYXRpb25zIDMgVElORk86IHZlcmlmeSBvcGVuX3dyaXRlcnMgdXNpbmcgbW1hcHBlZCBmaWxl
cwo+IHRzdF90ZXN0LmM6MTkwMDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0yMi1nY2Qy
MjE1NzAyZgo+IHRzdF90ZXN0LmM6MTkwNDogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTMuMC0y
LmcwMTI3YTM3LWRlZmF1bHQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQwo+IFRodSBKYW4gMjMgMTE6
MjE6NTUgVVRDIDIwMjUgKDAxMjdhMzcpIHg4Nl82NAo+IHRzdF9rY29uZmlnLmM6ODg6IFRJTkZP
OiBQYXJzaW5nIGtlcm5lbCBjb25maWcgJy9wcm9jL2NvbmZpZy5neicKPiB0c3Rfa2NvbmZpZy5j
OjY3NjogVElORk86IENPTkZJR19GQVVMVF9JTkpFQ1RJT04ga2VybmVsIG9wdGlvbiBkZXRlY3Rl
ZCB3aGljaCBtaWdodCBzbG93Cj4gdGhlIGV4ZWN1dGlvbgo+IHRzdF90ZXN0LmM6MTcyMjogVElO
Rk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDAybSAwMHMKPiBpbWFfbW1hcC5jOjM4
OiBUSU5GTzogc2xlZXAgM3MKPiBpbWFfdmlvbGF0aW9ucyAzIFRGQUlMOiBvcGVuX3dyaXRlcnMg
dG9vIG1hbnkgdmlvbGF0aW9ucyBhZGRlZAo+IGltYV9tbWFwLmM6NDE6IFRQQVNTOiB0ZXN0IGNv
bXBsZXRlZAo+IAo+IFN1bW1hcnk6Cj4gcGFzc2VkwqDCoCAxCj4gZmFpbGVkwqDCoCAwCj4gYnJv
a2VuwqDCoCAwCj4gc2tpcHBlZMKgIDAKPiB3YXJuaW5ncyAwCj4gaW1hX3Zpb2xhdGlvbnMgNCBU
SU5GTzogdmVyaWZ5IGxpbWl0aW5nIHNpbmdsZSBvcGVuIHdyaXRlciB2aW9sYXRpb24KPiBpbWFf
dmlvbGF0aW9ucyA0IFRGQUlMOiBvcGVuX3dyaXRlcnMgdG9vIG1hbnkgdmlvbGF0aW9ucyBhZGRl
ZAo+IGltYV92aW9sYXRpb25zIDUgVElORk86IHZlcmlmeSBsaW1pdGluZyBtdWx0aXBsZSBvcGVu
IHdyaXRlcnMgdmlvbGF0aW9ucwo+IGltYV92aW9sYXRpb25zIDUgVEZBSUw6IG9wZW5fd3JpdGVy
cyB0b28gbWFueSB2aW9sYXRpb25zIGFkZGVkCj4gaW1hX3Zpb2xhdGlvbnMgNiBUSU5GTzogdmVy
aWZ5IG5ldyBvcGVuIHdyaXRlciBjYXVzZXMgYWRkaXRpb25hbCB2aW9sYXRpb24KPiBpbWFfdmlv
bGF0aW9ucyA2IFRGQUlMOiBvcGVuX3dyaXRlcnMgdG9vIG1hbnkgdmlvbGF0aW9ucyBhZGRlZAo+
IGltYV92aW9sYXRpb25zIDcgVElORk86IHZlcmlmeSBsaW1pdGluZyBzaW5nbGUgb3BlbiByZWFk
ZXIgVG9NVG9VIHZpb2xhdGlvbnMKPiBpbWFfdmlvbGF0aW9ucyA3IFRGQUlMOiBUb01Ub1UgdG9v
IG1hbnkgdmlvbGF0aW9ucyBhZGRlZAo+IGltYV92aW9sYXRpb25zIDggVElORk86IHZlcmlmeSBu
ZXcgb3BlbiByZWFkZXIgY2F1c2VzIGFkZGl0aW9uYWwgVG9NVG9VIHZpb2xhdGlvbgo+IGltYV92
aW9sYXRpb25zIDggVEZBSUw6IFRvTVRvVSB0b28gbWFueSB2aW9sYXRpb25zIGFkZGVkCj4gCj4g
S2luZCByZWdhcmRzLAo+IFBldHIKPiAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
