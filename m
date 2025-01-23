Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D222AC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:39:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD763C4DF9
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:39:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB3913C2998
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:20 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CC02207F21
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:39:19 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N9d722022534;
 Thu, 23 Jan 2025 17:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=A3uXV8
 hu1U2d0DiavA56xbXq20mzfmYKzcGlzqX/vDY=; b=E4sf8v3v/93jHR9VT/iwiR
 hKeUhSLFa2TN77XxHKMLiHAtha0Xm1VEFr6V9Yt1YXDd0lxQiMc4zuF3AJzKLEV8
 VNoNU5xnUw5iTdUhaC1lo4vf52hwd2//GUTMWkSf7q511bUwdjbaovQc+hmWirB5
 gl0NR90j/HsiLisQzdI5FTFlMQpDZE7uovCwTDI1bImNwoZvtpnr7UuvwdHqytB6
 /eAaX7JEaOq0Tnt+XLoWLGUhf9iXpgmk0VH0Kwmh/H+lrKXNYtEOaQegWsgpTJD+
 hrzSp3SwOhOeaMy1XChYE++hdadVmHVdO/YEgOxCims+BGgSCmbCaA6rSBXSYY2w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cdm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NHZ3dn019223;
 Thu, 23 Jan 2025 17:39:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmspu00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:39:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHdFFT12124816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:39:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A40258055;
 Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 203BE5804B;
 Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Message-ID: <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:39:14 -0500
In-Reply-To: <20250114112915.610297-6-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
 <20250114112915.610297-6-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l5zSDrbCxZOzrgtxnh8jF8a51Woj2qxJ
X-Proofpoint-ORIG-GUID: l5zSDrbCxZOzrgtxnh8jF8a51Woj2qxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 05/10] IMA: Read required policy from file
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAyMDI1LTAxLTE0IGF0IDEyOjI5ICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IFBy
ZXZpb3VzbHkgc25pcHBlZCBvZiByZXF1aXJlZCBwb2xpY3kgd2FzIGFzIGEgc3RyaW5nIG9yIHJl
Z2V4cC4KPiBMb2FkaW5nIHJlcXVpcmVkIHBvbGljeSBmcm9tIGZpbGUgYWxsb3dzIHRvIG1vdmUg
Y29kZSB0byBpbWFfc2V0dXAuc2guCj4gVGhpcyBpcyBhIHByZXBhcmF0aW9uIGZvciBsb2FkaW5n
IElNQSBwb2xpY3kgZnJvbSBmaWxlLgo+IAo+IENoZWNrIGNhbiBiZSBkb25lIG9uIG9uZSBvciBi
b3RoOgo+IDEpIElNQSBidWlsdGluIHBvbGljeSAoYmFzZWQgb24gL3Byb2MvY21kbGluZSkKPiAy
KSBJTUEgcG9saWN5IGNvbnRlbnQgKGFjdHVhbCBjb250ZW50IG9mIC9zeXMva2VybmVsL3NlY3Vy
aXR5L2ltYS9wb2xpY3kpCj4gCj4gV2hlbiBtaXNzaW5nIENPTkZJR19JTUFfUkVBRF9QT0xJQ1k9
eSBvbiByZXF1aXJlZCBwb2xpY3kgY29udmVydDogdGVzdCwgYnV0IGNvbnZlcnQKPiBURkFJTCA9
PiBUQ09ORi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
ClRoYW5rcywgUGV0ci4gIFJlYWxseSBuaWNlIHBhdGNoLiAgQmVsb3cgaXMgYW4gaW1wcm92ZW1l
bnQgc3VnZ2VzdGlvbi4KClJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0u
Y29tPgoKPiAtLS0KPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV9zZWxpbnV4LnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL3Nl
Y3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3NlbGludXguc2gKPiBpbmRleCA3NWY5YmE4
NGU0Li40NWZkNzQxYjVmIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkv
aW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfc2VsaW51eC5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfc2VsaW51eC5zaAo+IEBAIC0xLDYg
KzEsNyBAQAo+IMKgIyEvYmluL3NoCj4gwqAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCj4gwqAjIENvcHlyaWdodCAoYykgMjAyMSBNaWNyb3NvZnQgQ29ycG9yYXRp
b24KPiArIyBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAyMS0yMDI1Cj4gwqAj
IEF1dGhvcjogTGFrc2htaSBSYW1hc3VicmFtYW5pYW4gPG5yYW1hc0BsaW51eC5taWNyb3NvZnQu
Y29tPgo+IMKgIwo+IMKgIyBWZXJpZnkgbWVhc3VyZW1lbnQgb2YgU0VMaW51eCBwb2xpY3kgaGFz
aCBhbmQgc3RhdGUuCj4gQEAgLTE0LDE1ICsxNSwxMiBAQCBUU1RfQ05UPTIKPiDCoFRTVF9TRVRV
UD0ic2V0dXAiCj4gwqBUU1RfTUlOX0tWRVI9IjUuMTIiCj4gwqAKPiAtRlVOQ19DUklUSUNBTF9E
QVRBPSdmdW5jPUNSSVRJQ0FMX0RBVEEnCj4gLVJFUVVJUkVEX1BPTElDWT0iXm1lYXN1cmUuKiRG
VU5DX0NSSVRJQ0FMX0RBVEEiCj4gK1JFUVVJUkVEX1BPTElDWV9DT05URU5UPSdzZWxpbnV4LnBv
bGljeScKClRoZSBzZWxpbnV4LnBvbGljeSBjb250YWlucyBhIHNwZWNpZmljIGNyaXRpY2FsIGRh
dGEgbWVhc3VyZW1lbnQgcnVsZToKbWVhc3VyZSBmdW5jPUNSSVRJQ0FMX0RBVEEgbGFiZWw9c2Vs
aW51eC4gIEhvd2V2ZXIgdGhlIHRlc3Qgd291bGQgd29yayB3aXRoIHRoZQpnZW5lcmljIHBvbGlj
eSBydWxlICJtZWFzdXJlIGZ1bmM9Q1JJVElDQUxfREFUQSIsIHdoaWNoIGNhbiBiZSBzcGVjaWZp
ZWQgb24gdGhlIC4gCmJvb3QgY29tbWFuZCBsaW5lIHZpYSAiaW1hX3BvbGljeT1jcml0aWNhbF9k
YXRhIi4KCkFzIGxvbmcgYXMgYmVpbmcgYWJsZSB0byByZWFkIHRoZSBJTUEgcG9saWN5IGlzIHJl
cXVpcmVkLCBpbiBhZGRpdGlvbiB0byBjaGVja2luZwp3aGV0aGVyIHRoZSBzcGVjaWZpYyBjcml0
aWNhbCBkYXRhIHJ1bGUgZXhpc3RzLCBjaGVjayB3aGV0aGVyIHRoZSBnZW5lcmljIHJ1bGUgZXhp
c3RzCmJlZm9yZSBsb2FkaW5nIHRoZSBzcGVjaWZpYyBvbmUuCgpQZXJoYXBzIGFsbCB0aGF0IGlz
IG5lZWRlZCBpcyBkZWZpbmluZyBSRVFVSVJFRF9CVUlMVElOX1BPTElDWSBsaWtlOgpSRVFVSVJF
RF9CVUlMVElOX1BPTElDWT0iY3JpdGljYWxfZGF0YSIKCj4gwqAKPiDCoHNldHVwKCkKPiDCoHsK
PiDCoAlTRUxJTlVYX0RJUj0kKHRzdF9nZXRfc2VsaW51eF9kaXIpCj4gwqAJWyAiJFNFTElOVVhf
RElSIiBdIHx8IHRzdF9icmsgVENPTkYgIlNFTGludXggaXMgbm90IGVuYWJsZWQiCj4gLQo+IC0J
cmVxdWlyZV9pbWFfcG9saWN5X2NvbnRlbnQgIiRSRVFVSVJFRF9QT0xJQ1kiICctRScgPgo+ICRU
U1RfVE1QRElSL3BvbGljeS50eHQKPiDCoH0KPiDCoAo+IMKgIyBGb3JtYXQgb2YgdGhlIG1lYXN1
cmVkIFNFTGludXggc3RhdGUgZGF0YS4KPiBAQCAtNDUsNyArNDMsNyBAQCB2YWxpZGF0ZV9wb2xp
Y3lfY2FwYWJpbGl0aWVzKCkKPiDCoAkJbWVhc3VyZWRfdmFsdWU9JChlY2hvICQxIHwgYXdrIC1G
J1s9O10nIC12IGlueD0iJGlueCIgJ3twcmludAo+ICRpbnh9JykKPiDCoAkJZXhwZWN0ZWRfdmFs
dWU9JChjYXQKPiAiJFNFTElOVVhfRElSL3BvbGljeV9jYXBhYmlsaXRpZXMvJG1lYXN1cmVkX2Nh
cCIpCj4gwqAJCWlmIFsgIiRtZWFzdXJlZF92YWx1ZSIgIT0gIiRleHBlY3RlZF92YWx1ZSIgXTsg
dGhlbgo+IC0JCQl0c3RfcmVzIFRGQUlMICIkbWVhc3VyZWRfY2FwOiBleHBlY3RlZDogJGV4cGVj
dGVkX3ZhbHVlLAo+IGdvdDogJGRpZ2VzdCIKPiArCQkJdHN0X3JlcyAkSU1BX0ZBSUwgIiRtZWFz
dXJlZF9jYXA6IGV4cGVjdGVkOgo+ICRleHBlY3RlZF92YWx1ZSwgZ290OiAkZGlnZXN0Igo+IMKg
CQkJcmV0dXJuCj4gwqAJCWZpCj4gwqAKPiBAQCAtNzUsNyArNzMsNyBAQCB0ZXN0MSgpCj4gwqAJ
IyBpbiBrZXJuZWwgbWVtb3J5IGZvciBTRUxpbnV4Cj4gwqAJbGluZT0kKGdyZXAgLUUgInNlbGlu
dXgtcG9saWN5LWhhc2giICRBU0NJSV9NRUFTVVJFTUVOVFMgfCB0YWlsIC0xKQo+IMKgCWlmIFsg
LXogIiRsaW5lIiBdOyB0aGVuCj4gLQkJdHN0X3JlcyBURkFJTCAiU0VMaW51eCBwb2xpY3kgaGFz
aCBub3QgbWVhc3VyZWQiCj4gKwkJdHN0X3JlcyAkSU1BX0ZBSUwgIlNFTGludXggcG9saWN5IGhh
c2ggbm90IG1lYXN1cmVkIgo+IMKgCQlyZXR1cm4KPiDCoAlmaQo+IMKgCj4gQEAgLTg2LDcgKzg0
LDcgQEAgdGVzdDEoKQo+IMKgCQl0c3RfYnJrIFRDT05GICJjYW5ub3QgY29tcHV0ZSBkaWdlc3Qg
Zm9yICRhbGdvcml0aG0iCj4gwqAKPiDCoAlpZiBbICIkcG9saWN5X2RpZ2VzdCIgIT0gIiRleHBl
Y3RlZF9wb2xpY3lfZGlnZXN0IiBdOyB0aGVuCj4gLQkJdHN0X3JlcyBURkFJTCAiRGlnZXN0IG1p
c21hdGNoOiBleHBlY3RlZDogJGV4cGVjdGVkX3BvbGljeV9kaWdlc3QsCj4gZ290OiAkcG9saWN5
X2RpZ2VzdCIKPiArCQl0c3RfcmVzICRJTUFfRkFJTCAiRGlnZXN0IG1pc21hdGNoOiBleHBlY3Rl
ZDoKPiAkZXhwZWN0ZWRfcG9saWN5X2RpZ2VzdCwgZ290OiAkcG9saWN5X2RpZ2VzdCIKPiDCoAkJ
cmV0dXJuCj4gwqAJZmkKPiDCoAo+IEBAIC0xMTYsNyArMTE0LDcgQEAgdGVzdDIoKQo+IMKgCSMg
c3RhdGUgbWF0Y2hlcyB0aGF0IGN1cnJlbnRseSBzZXQgZm9yIFNFTGludXgKPiDCoAlsaW5lPSQo
Z3JlcCAtRSAic2VsaW51eC1zdGF0ZSIgJEFTQ0lJX01FQVNVUkVNRU5UUyB8IHRhaWwgLTEpCj4g
wqAJaWYgWyAteiAiJGxpbmUiIF07IHRoZW4KPiAtCQl0c3RfcmVzIFRGQUlMICJTRUxpbnV4IHN0
YXRlIG5vdCBtZWFzdXJlZCIKPiArCQl0c3RfcmVzICRJTUFfRkFJTCAiU0VMaW51eCBzdGF0ZSBu
b3QgbWVhc3VyZWQiCj4gwqAJCXJldHVybgo+IMKgCWZpCj4gwqAKPiBAQCAtMTI5LDcgKzEyNyw3
IEBAIHRlc3QyKCkKPiDCoAl0c3RfYnJrIFRDT05GICJjYW5ub3QgY29tcHV0ZSBkaWdlc3QgZm9y
ICRhbGdvcml0aG0iCj4gwqAKPiDCoAlpZiBbICIkZGlnZXN0IiAhPSAiJGV4cGVjdGVkX2RpZ2Vz
dCIgXTsgdGhlbgo+IC0JCXRzdF9yZXMgVEZBSUwgImRpZ2VzdCBtaXNtYXRjaDogZXhwZWN0ZWQ6
ICRleHBlY3RlZF9kaWdlc3QsIGdvdDoKPiAkZGlnZXN0Igo+ICsJCXRzdF9yZXMgJElNQV9GQUlM
ICJkaWdlc3QgbWlzbWF0Y2g6IGV4cGVjdGVkOiAkZXhwZWN0ZWRfZGlnZXN0LAo+IGdvdDogJGRp
Z2VzdCIKPiDCoAkJcmV0dXJuCj4gwqAJZmkKPiDCoAo+IEBAIC0xNDYsMjAgKzE0NCwyMCBAQCB0
ZXN0MigpCj4gwqAJZW5mb3JjZWRfdmFsdWU9JChlY2hvICRtZWFzdXJlZF9kYXRhIHwgYXdrIC1G
J1s9O10nICd7cHJpbnQgJDR9JykKPiDCoAlleHBlY3RlZF9lbmZvcmNlZF92YWx1ZT0kKGNhdCAk
U0VMSU5VWF9ESVIvZW5mb3JjZSkKPiDCoAlpZiBbICIkZXhwZWN0ZWRfZW5mb3JjZWRfdmFsdWUi
ICE9ICIkZW5mb3JjZWRfdmFsdWUiIF07IHRoZW4KPiAtCQl0c3RfcmVzIFRGQUlMICJlbmZvcmNl
OiBleHBlY3RlZDogJGV4cGVjdGVkX2VuZm9yY2VkX3ZhbHVlLCBnb3Q6Cj4gJGVuZm9yY2VkX3Zh
bHVlIgo+ICsJCXRzdF9yZXMgJElNQV9GQUlMICJlbmZvcmNlOiBleHBlY3RlZDogJGV4cGVjdGVk
X2VuZm9yY2VkX3ZhbHVlLAo+IGdvdDogJGVuZm9yY2VkX3ZhbHVlIgo+IMKgCQlyZXR1cm4KPiDC
oAlmaQo+IMKgCj4gwqAJY2hlY2tyZXFwcm90X3ZhbHVlPSQoZWNobyAkbWVhc3VyZWRfZGF0YSB8
IGF3ayAtRidbPTtdJyAne3ByaW50ICQ2fScpCj4gwqAJZXhwZWN0ZWRfY2hlY2tyZXFwcm90X3Zh
bHVlPSQoY2F0ICRTRUxJTlVYX0RJUi9jaGVja3JlcXByb3QpCj4gwqAJaWYgWyAiJGV4cGVjdGVk
X2NoZWNrcmVxcHJvdF92YWx1ZSIgIT0gIiRjaGVja3JlcXByb3RfdmFsdWUiIF07IHRoZW4KPiAt
CQl0c3RfcmVzIFRGQUlMICJjaGVja3JlcXByb3Q6IGV4cGVjdGVkOgo+ICRleHBlY3RlZF9jaGVj
a3JlcXByb3RfdmFsdWUsIGdvdDogJGNoZWNrcmVxcHJvdF92YWx1ZSIKPiArCQl0c3RfcmVzICRJ
TUFfRkFJTCAiY2hlY2tyZXFwcm90OiBleHBlY3RlZDoKPiAkZXhwZWN0ZWRfY2hlY2tyZXFwcm90
X3ZhbHVlLCBnb3Q6ICRjaGVja3JlcXByb3RfdmFsdWUiCj4gwqAJCXJldHVybgo+IMKgCWZpCj4g
wqAKPiDCoAlpbml0aWFsaXplZF92YWx1ZT0kKGVjaG8gJG1lYXN1cmVkX2RhdGEgfCBhd2sgLUYn
Wz07XScgJ3twcmludCAkMn0nKQo+IMKgCWlmIFsgIiRpbml0aWFsaXplZF92YWx1ZSIgIT0gIjEi
IF07IHRoZW4KPiAtCQl0c3RfcmVzIFRGQUlMICJpbml0aWFsaXplZDogZXhwZWN0ZWQgMSwgZ290
OiAkaW5pdGlhbGl6ZWRfdmFsdWUiCj4gKwkJdHN0X3JlcyAkSU1BX0ZBSUwgImluaXRpYWxpemVk
OiBleHBlY3RlZCAxLCBnb3Q6Cj4gJGluaXRpYWxpemVkX3ZhbHVlIgo+IMKgCQlyZXR1cm4KPiDC
oAlmaQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
