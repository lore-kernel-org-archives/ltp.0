Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CB3EB8FAF
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 04:46:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330C83CB67B
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 06:46:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0DB73C9961
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 06:46:07 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE502601B0D
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 06:46:04 +0200 (CEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3864geeA009640; Wed, 6 Sep 2023 04:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pwvGB0uO9ig9wk5SncOIXXNvWs0vCchmdkQ+AHh89M0=;
 b=HRfAm6JUP0I7cUpjfNzr6Agt+FsHLlXE91rpL0sIEUe8ZHtrAETiAJtciP5TtrE22ysV
 Bx50+3DHlRjakqcgtbrHNIGKD0DbCFEASSZD/4+e3eL8cjpe+JBKNrSByj6OO8cyH7H0
 vO+tmm2+K6asY425QNNY/q2P5PGAVlcnABtOdwgL5HTBeYlDqN9gYMN5v0gm24C4oa8b
 NoY6xynX6AyMXmSyzHiYAlDDOTyYxkVgabH9VuNOdVPbrtKMkQ3xk5IKnjjJk94GyJ38
 2ISM2uEJEtJq/UBgWMa5Vjknd0zHEGHD8jkROdUtvk3/jNo7AShcGWgsoHny4kTRWy9t qA== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjmpg2g6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:46:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38649EWW012261; Wed, 6 Sep 2023 04:46:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjyvqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:46:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864jxlj24838688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:45:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40A2A20043;
 Wed,  6 Sep 2023 04:45:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99A8320040;
 Wed,  6 Sep 2023 04:45:58 +0000 (GMT)
Received: from [9.199.156.150] (unknown [9.199.156.150])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  6 Sep 2023 04:45:58 +0000 (GMT)
Message-ID: <aa1e0c0c-d11e-16e5-3830-9fb7a0294d5c@linux.ibm.com>
Date: Wed, 6 Sep 2023 10:15:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20230905060410.45560-1-rnsastry@linux.ibm.com>
 <62549924-8590-c85f-5693-129168bdb9f5@suse.cz>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <62549924-8590-c85f-5693-129168bdb9f5@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Iiu0s3vg2pK5IhStB_6B4cTT8REVkc8W
X-Proofpoint-ORIG-GUID: Iiu0s3vg2pK5IhStB_6B4cTT8REVkc8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060040
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V2] lib/tst_lockdown.c: Add PPC64 architecture
 support
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
Cc: rnsastry@linux.ibm.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgpPbiAwNS8wOS8yMyAyOjUzIHBtLCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+IEhpLAo+IAo+IE9u
IDA1LiAwOS4gMjMgODowNCwgTmFnZXN3YXJhIFIgU2FzdHJ5IHdyb3RlOgo+PiBBZGQgUFBDNjQg
YXJjaGl0ZWN0dXJlIHN1cHBvcnQgdG8gdGhlIGxvY2tkb3duIGxpYnJhcnkuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IE5hZ2Vzd2FyYSBSIFNhc3RyeSA8cm5zYXN0cnlAbGludXguaWJtLmNvbT4KPj4g
LS0tCj4+IHYyOgo+PiDCoCAtIEdyb3VwIGFsbCB0aGUgY29uc3RhbnQgZGVmaW5pdGlvbnMgdG9n
ZXRoZXIgKEN5cmlsIEhydWJpcykKPj4gwqAgLSBSZWR1Y2UgdGhlIG51bWJlciBvZiB2YXJpYWJs
ZXMgKE1hcnRpbiBEb3VjaGEpCj4+IC0tLQo+PiDCoCBsaWIvdHN0X2xvY2tkb3duLmMgfCAzNSAr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9saWIv
dHN0X2xvY2tkb3duLmMgYi9saWIvdHN0X2xvY2tkb3duLmMKPj4gaW5kZXggOTA4NmViYTM2Li5l
YTcxZjY3NTMgMTAwNjQ0Cj4+IC0tLSBhL2xpYi90c3RfbG9ja2Rvd24uYwo+PiArKysgYi9saWIv
dHN0X2xvY2tkb3duLmMKPj4gQEAgLTE0LDMzICsxNCw0MiBAQAo+PiDCoCAjaW5jbHVkZSAidHN0
X2xvY2tkb3duLmgiCj4+IMKgICNpbmNsdWRlICJ0c3RfcHJpdmF0ZS5oIgo+PiAtI2RlZmluZSBF
RklWQVJfU0VDVVJFQk9PVCAKPj4gIi9zeXMvZmlybXdhcmUvZWZpL2VmaXZhcnMvU2VjdXJlQm9v
dC04YmU0ZGY2MS05M2NhLTExZDItYWEwZC0wMGUwOTgwMzJiOGMiCj4+IC0KPj4gKyNpZiBkZWZp
bmVkKF9fcG93ZXJwYzY0X18pIHx8IGRlZmluZWQoX19wcGM2NF9fKQo+PiArIyBkZWZpbmUgS0VS
TkVMX0NPTkZJRzEgIkNPTkZJR19TRUNVUklUWV9MT0NLRE9XTl9MU00iCj4+ICsjIGRlZmluZSBL
RVJORUxfQ09ORklHMiAiQ09ORklHX1NFQ1VSSVRZX0xPQ0tET1dOX0xTTV9FQVJMWSIKPj4gKyMg
ZGVmaW5lIFNFQ1VSRUJPT1RfVkFSICIvcHJvYy9kZXZpY2UtdHJlZS9pYm0sc2VjdXJlLWJvb3Qi
Cj4+ICsjIGRlZmluZSBWQVJfREFUQV9TSVpFIDQKPj4gKyNlbHNlCj4+ICsjIGRlZmluZSBLRVJO
RUxfQ09ORklHMSAiQ09ORklHX0VGSV9TRUNVUkVfQk9PVF9MT0NLX0RPV04iCj4+ICsjIGRlZmlu
ZSBLRVJORUxfQ09ORklHMiAiQ09ORklHX0xPQ0tfRE9XTl9JTl9FRklfU0VDVVJFX0JPT1QiCj4+
ICsjIGRlZmluZSBTRUNVUkVCT09UX1ZBUiAKPj4gIi9zeXMvZmlybXdhcmUvZWZpL2VmaXZhcnMv
U2VjdXJlQm9vdC04YmU0ZGY2MS05M2NhLTExZDItYWEwZC0wMGUwOTgwMzJiOGMiCj4+ICsjIGRl
ZmluZSBWQVJfREFUQV9TSVpFIDUKPj4gKyNlbmRpZgo+PiDCoCBpbnQgdHN0X3NlY3VyZWJvb3Rf
ZW5hYmxlZCh2b2lkKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgaW50IGZkOwo+PiDCoMKgwqDCoMKg
IGNoYXIgZGF0YVs1XTsKPj4gLcKgwqDCoCBpZiAoYWNjZXNzKEVGSVZBUl9TRUNVUkVCT09ULCBG
X09LKSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhUSU5GTywgIkVmaXZhciBGUyBub3Qg
YXZhaWxhYmxlIik7Cj4+ICvCoMKgwqAgaWYgKGFjY2VzcyhTRUNVUkVCT09UX1ZBUiwgRl9PSykp
IHsKPj4gK8KgwqDCoMKgwqDCoMKgIHRzdF9yZXMoVElORk8sICJTZWN1cmVCb290IHN5c2ZzIGZp
bGUgbm90IGF2YWlsYWJsZSIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC0xOwo+PiDC
oMKgwqDCoMKgIH0KPj4gLcKgwqDCoCBmZCA9IG9wZW4oRUZJVkFSX1NFQ1VSRUJPT1QsIE9fUkRP
TkxZKTsKPj4gK8KgwqDCoCBmZCA9IG9wZW4oU0VDVVJFQk9PVF9WQVIsIE9fUkRPTkxZKTsKPj4g
wqDCoMKgwqDCoCBpZiAoZmQgPT0gLTEpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHRzdF9yZXMo
VElORk8gfCBURVJSTk8sCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJDYW5ub3Qgb3BlbiBT
ZWN1cmVCb290IEVmaXZhciBzeXNmaWxlIik7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJD
YW5ub3Qgb3BlbiBTZWN1cmVCb290IGZpbGUiKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtMTsKPj4gwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGZkIDwgMCkgewo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgIkludmFsaWQgb3BlbigpIHJldHVybiB2YWx1
ZSAlZCIsIGZkKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtMTsKPj4gwqDCoMKgwqDC
oCB9Cj4+IC0KPj4gLcKgwqDCoCBTQUZFX1JFQUQoMSwgZmQsIGRhdGEsIDUpOwo+PiArwqDCoMKg
IFNBRkVfUkVBRCgxLCBmZCwgZGF0YSwgVkFSX0RBVEFfU0laRSk7Cj4+IMKgwqDCoMKgwqAgU0FG
RV9DTE9TRShmZCk7Cj4+IC3CoMKgwqAgdHN0X3JlcyhUSU5GTywgIlNlY3VyZUJvb3Q6ICVzIiwg
ZGF0YVs0XSA/ICJvbiIgOiAib2ZmIik7Cj4+IC3CoMKgwqAgcmV0dXJuIGRhdGFbNF07Cj4+ICsK
Pj4gK8KgwqDCoCB0c3RfcmVzKFRJTkZPLCAiU2VjdXJlQm9vdDogJXMiLCBkYXRhW1ZBUl9EQVRB
X1NJWkUgLSAxXSA/ICJvbiIgOiAKPj4gIm9mZiIpOwo+PiArwqDCoMKgIHJldHVybiBkYXRhW1ZB
Ul9EQVRBX1NJWkUgLSAxXTsKPj4gwqAgfQo+PiDCoCBpbnQgdHN0X2xvY2tkb3duX2VuYWJsZWQo
dm9pZCkKPj4gQEAgLTUxLDkgKzYwLDExIEBAIGludCB0c3RfbG9ja2Rvd25fZW5hYmxlZCh2b2lk
KQo+PiDCoMKgwqDCoMKgIGlmIChhY2Nlc3MoUEFUSF9MT0NLRE9XTiwgRl9PSykgIT0gMCkgewo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciBmbGFnOwo+PiArCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBTZWN1cmVCb290IGVuYWJsZWQgY291bGQgbWVhbiBpbnRlZ3JpdHkgbG9ja2Rvd24gCj4+
IChub24tbWFpbmxpbmUgdmVyc2lvbikgKi8KPj4gLcKgwqDCoMKgwqDCoMKgIGZsYWcgPSB0c3Rf
a2NvbmZpZ19nZXQoIkNPTkZJR19FRklfU0VDVVJFX0JPT1RfTE9DS19ET1dOIikgPT0gCj4+ICd5
JzsKPj4gLcKgwqDCoMKgwqDCoMKgIGZsYWcgfD0gCj4+IHRzdF9rY29uZmlnX2dldCgiQ09ORklH
X0xPQ0tfRE9XTl9JTl9FRklfU0VDVVJFX0JPT1QiKSA9PSAneSc7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBmbGFnID0gdHN0X2tjb25maWdfZ2V0KEtFUk5FTF9DT05GSUcxKSA9PSAneSc7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBmbGFnIHw9IHRzdF9rY29uZmlnX2dldChLRVJORUxfQ09ORklHMikgPT0gJ3kn
Owo+IAo+IEkgZG9uJ3QgdGhpbmsgdGhhdCBkZWZpbmluZyB0d28gY29uc3RhbnQgbWFjcm9zIGZv
ciB0aGUga2VybmVsIGNvbmZpZyAKPiBvcHRpb25zIG1ha2VzIHNlbnNlIGhlcmUuIEl0J3MganVz
dCBhIGNvaW5jaWRlbmNlIHRoYXQgYm90aCBQUEMgYW5kIHg4NiAKPiBjdXJyZW50bHkgaGF2ZSB0
d28gcG9zc2libGUgY29uZmlnIGtleXMuIFdoZW4gd2UgYWRkIHNwZWNpYWwgc3VwcG9ydCBmb3Ig
Cj4gYSB0aGlyZCBhcmNoIHRoYXQgaGFzIG9ubHkgb25lIChvciBlLmcuIGEgdGhpcmQgb3B0aW9u
IGZvciB4ODYpLCB0aGlzIAo+IGNvZGUgd2lsbCBuZWVkIHRvIGJlIHJld29ya2VkIGJhY2sgdG8g
d2hhdCB3YXMgaW4gdjEuIE9yIHlvdSBjb3VsZCBjaGVjayAKPiBhbGwgNCBvcHRpb24gcmVnYXJk
bGVzcyBvZiBhcmNoLCB0aGUgd29yc3QgdGhpbmcgdGhhdCdsbCBoYXBwZW4gaXMgdGhhdCAKPiB0
aGUgdGVzdCBzZXR1cCB3aWxsIGJlIHNsaWdodGx5IHNsb3dlci4KCgpTdXJlLCB0aGVuIEkgd2ls
bCBmYWxsIGJhY2sgdG8gdGhlIHYxIGFwcHJvYWNoIGZvciB0aGVzZSBjaGVja2luZyBrZXJuZWwg
CmNvbmZpZyBjb2RlLgppZS4KKwkJI2lmIGRlZmluZWQoX19wb3dlcnBjNjRfXykgfHwgZGVmaW5l
ZChfX3BwYzY0X18pCisJCWZsYWcgPSB0c3Rfa2NvbmZpZ19nZXQoIkNPTkZJR19TRUNVUklUWV9M
T0NLRE9XTl9MU00iKSA9PSAneSc7CisJCWZsYWcgfD0gdHN0X2tjb25maWdfZ2V0KCJDT05GSUdf
U0VDVVJJVFlfTE9DS0RPV05fTFNNX0VBUkxZIikgPT0gJ3knOworCQkjZWxzZQogIAkJZmxhZyA9
IHRzdF9rY29uZmlnX2dldCgiQ09ORklHX0VGSV9TRUNVUkVfQk9PVF9MT0NLX0RPV04iKSA9PSAn
eSc7CiAgCQlmbGFnIHw9IHRzdF9rY29uZmlnX2dldCgiQ09ORklHX0xPQ0tfRE9XTl9JTl9FRklf
U0VDVVJFX0JPT1QiKSA9PSAneSc7CisJCSNlbmRpZgoKCj4gCj4+ICsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChmbGFnICYmIHRzdF9zZWN1cmVib290X2VuYWJsZWQoKSA+IDApCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAxOwo+IAoKLS0gClRoYW5rcyBhbmQgUmVnYXJk
cwpSLk5hZ2Vzd2FyYSBTYXN0cnkKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
