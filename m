Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA82C54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 07:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5EC23CE640
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:03:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4E23C2DFC
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:03:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44180616626
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 08:03:39 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L6W3Kk023140; Thu, 21 Mar 2024 07:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+Nt/EtOsuLDsoibX42qwHf9ab5qCv67QKhNIKmsba9Y=;
 b=gq8RZQXfjcoQkERBYLBtk9iu+jWcoNMsmkW5Eds4PJtgLtaxyL0Ba1k8yjQ43kO4SQ6h
 jYI5VR9a5MW2b5sgLyTmZAeoiqEc9Uftv0E0jUbrvgIpl+EwW8ZzYPYFaOo5vFbWN30f
 S1mmfC2eHXT53uAj9CZWSbaeqAYqcMUytNXs5iKwpVAq0lbzl05AzMzAe2p7VIYcEuw7
 JPf5CynsNwnPbiZsBfbKeWpNvxg40jS0/3t+gEflgJEdJ4i6OBhqwPddTDknusaA0lty
 kTTG3YxFmDoF48JED8LqulVr4Bp4UTdUFN+v8ytABj7ioalc6lCMVpHPzjumbA+Ndg0T FQ== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0e5ug7nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 07:03:37 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L5lYJw017231; Thu, 21 Mar 2024 07:03:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrtknah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 07:03:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42L73XvP46727630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 07:03:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B07720043;
 Thu, 21 Mar 2024 07:03:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64EC520040;
 Thu, 21 Mar 2024 07:03:32 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown
 [9.199.152.158])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 07:03:32 +0000 (GMT)
Message-ID: <c58c5365f7c801e93745775577a3cbb83159fb91.camel@linux.ibm.com>
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2024 12:33:31 +0530
In-Reply-To: <20231128112254.GA367506@pevik>
References: <20230929091401.205277-1-shirisha@linux.ibm.com>
 <20231128112254.GA367506@pevik>
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 40HYZlhXwG1ZK50Ajw6JR4UNTvG9DL_c
X-Proofpoint-GUID: 40HYZlhXwG1ZK50Ajw6JR4UNTvG9DL_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=589 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210045
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate.c test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCAyMDIzLTExLTI4IGF0IDEyOjIyICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhp
LAo+IAo+IC4uLgo+ID4gK3N0YXRpYyB2b2lkIHNpZ2J1c19oYW5kbGVyKGludCBzaWdudW0pCj4g
PiArewo+ID4gKwl0ZXN0X3Bhc3MgPSAxOwo+ID4gKwlzaWdsb25nam1wKHNpZ19lc2NhcGUsIDE3
KTsKPiBXaGF0IDE3IHN0YW5kcyBmb3I/IElzIHRoZXJlIGFueSBjb25zdGFudCB3aGljaCBjb3Vs
ZCBiZSB1c2VkPyBPciBjYW4KPiB5b3UgZGVmaW5lCj4gc29tZXRoaW5nICh0aGUgbmFtZSBvZiB0
aGUgY29uc3RhbnQgd291bGQgYmUgc2VsZi1kZXNjcmliaW5nKS4KVGhlIHZhbHVlIDE3IGlzIG9m
dGVuIGNob3NlbiBhcyBhIG5vbi16ZXJvIHJldHVybiB2YWx1ZSBmb3Igc2lnc2V0am1wCmJlY2F1
c2UgaXQgaXMgdW5saWtlbHkgdG8gYmUgYSB2YWxpZCByZXR1cm4gdmFsdWUgZnJvbSBhIG5vcm1h
bApmdW5jdGlvbi4gQnkgdXNpbmcgYSBub24temVybyB2YWx1ZSwgeW91IGNhbiBkaXN0aW5ndWlz
aCBiZXR3ZWVuIGEKZGlyZWN0IHJldHVybiBmcm9tIHNpZ3NldGptcCAod2hlcmUgdGhlIHJldHVy
biB2YWx1ZSBpcyAwKSBhbmQgYSByZXR1cm4KYWZ0ZXIgYSBzaWdsb25nam1wICh3aGVyZSB0aGUg
cmV0dXJuIHZhbHVlIGlzIG5vbi16ZXJvKS4KQnkgdXNpbmcgYSBub24temVybyB2YWx1ZSAobGlr
ZSAxNyksIHlvdSBjYW4gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuCm5vcm1hbCBmdW5jdGlvbiByZXR1
cm5zIGFuZCBqdW1wcyBkdWUgdG8gZXhjZXB0aW9uYWwgY29uZGl0aW9ucy4gaGUKc3BlY2lmaWMg
dmFsdWUgY2hvc2VuIChzdWNoIGFzIDE3KSBjYW4gdmFyeSBiYXNlZCBvbiB0aGUgcHJvZ3JhbW1l
cuKAmXMKcHJlZmVyZW5jZSBvciB0aGUgY29udGV4dCBvZiB0aGUgYXBwbGljYXRpb24uIFNvbWUg
ZGV2ZWxvcGVycyBtaWdodCB1c2UKb3RoZXIgbm9uLXplcm8gdmFsdWVzLCBidXQgMTcgaGFzIGJl
Y29tZSBhIGNvbnZlbnRpb24gZHVlIHRvIGl0cwp1bmlxdWVuZXNzIGFuZCByZWFkYWJpbGl0eS4K
PiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQgcnVuX3Rlc3Qodm9pZCkKPiA+ICt7Cj4gPiAr
CXZvaWQgKnA7Cj4gPiArCXZvbGF0aWxlIHVuc2lnbmVkIGludCAqcTsKPiA+ICsKPiA+ICsJc2ln
YnVzX2NvdW50ID0gMDsKPiA+ICsJdGVzdF9wYXNzID0gMDsKPiA+ICsJaW50IGVycjsKPiA+ICsK
PiA+ICsJcCA9IFNBRkVfTU1BUChOVUxMLCBocGFnZV9zaXplLCBQUk9UX1JFQUR8UFJPVF9XUklU
RSwKPiA+IE1BUF9TSEFSRUQsCj4gPiArCQkJZmQsIDApOwo+ID4gKwlxID0gcDsKPiA+ICsJKnEg
PSAwOwo+ID4gKwllcnIgPSBmdHJ1bmNhdGUoZmQsIDApOwo+ID4gKwlpZiAoZXJyKQo+ID4gKwkJ
dHN0X3JlcyhURkFJTCwgImZ0cnVuY2F0ZSBmYWlsZWQiKTsKPiBXZSBoYXZlIFNBRkVfRlRSVU5D
QVRFKCksIGVycm9yIGNoZWNrIGlzIG5vdCBuZWVkZWQuCldpbGwgdGFrZSBjYXJlIG9mIHRoaXMg
aW4gVjQKPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
