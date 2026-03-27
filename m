Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABA710F2862
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:55:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDE343C572D
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:55:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6828E3C572D
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:55:21 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 588E260007C
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:55:11 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RGUqb11846372; Fri, 27 Mar 2026 17:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VvWGwr
 s9rCzwot5Ulb2hAybc1rok3ifKtQuCD79sfEQ=; b=YuV4ttKNIj8oGhTzgHWCVw
 8lwbMm3g7rmMyevJiR+saGtSTuuA7AFMpmwD/94PRl32I/3gTWRaZbnYjxcJdpYv
 1E1ROoODt+wCU7fcx+IpFnhilXkU8DglBbL9u+1gfmMOBXw5YSFaDRwNRzzHdwDv
 tCiC962ajfq+1oj5DQ2CXe1xYJ6wolqkbnjeawRqAiaSDzkIFVVWFqvfAG8xKskE
 vs1hrsUAQ1VJnfXPUsGHz0iU8cGhAmvo/03I2mZB6b6zvKa0EtbOPUFvRQESG3Ui
 TVUmlM722QobfWgCLDgfF1L38HQmqYaf54WwMBQtnumZhs0rtRmO42CWumIICdxg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqujh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 17:55:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62REqYRP031687;
 Fri, 27 Mar 2026 17:55:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt8qd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 17:55:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RHt7Yh43712974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 17:55:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A08D2004F;
 Fri, 27 Mar 2026 17:55:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBF7320043;
 Fri, 27 Mar 2026 17:55:06 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.27.150])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Mar 2026 17:55:06 +0000 (GMT)
Date: Fri, 27 Mar 2026 18:55:05 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <acbEef_Kk8OMpHAI@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260316130320.138328-1-japo@linux.ibm.com>
 <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
 <20260327152952.GB1092845@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327152952.GB1092845@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4mxCCCWVuy4FCcWjp30dOjZuBe8UToQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyMyBTYWx0ZWRfXwpMn54WmQpKG
 utCUPjndsFeotb4PKjtnPpmma+brMv1UlEM7S3DbpMM0QiZ2pl53ZBA/8w2IeW5Zg28od1zQv1D
 A0J/2toRK5N5CntJvb5D0j3JInow6yFqrwmekmfr7jxeKF5b+UHa3DTIot01JW1drGS0+xzlxVL
 Q/BVEzlnB8ZTRhxVldNsE1PyUF3hgRZgVcInrOL+xoR9UDhd6EBbBo1ukp9dGAwt4b8Ni3cqduR
 sjgplOD0m9NjLpZ2UfPbvZ4L5Ynp7VCD1jse8g+PVWsDQE7J/o+gLy7Q22pBskqKLkfO53ts+MC
 jnON6eLoqzmlTzhfaAUmInyXjphiKYAx2m+Q7OTk6dKFe+CUGqQ/tKP0WXeZsPllSfVDDinkKnt
 2zNUBINynTl5xFq+0mNbEMqEKH52ZWs8jfgf0pOPGmLIlMSO5Dj8QZ6vqYQCb3mb2JEr71pgLMS
 zFORd/lQh67+hfsoT2g==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6c47d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=kGRJeMLKPfa2Rn21hsoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4mxCCCWVuy4FCcWjp30dOjZuBe8UToQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270123
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjcsIDIwMjYgYXQgMDQ6Mjk6NTJQTSArMDEwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiAuLi4KPiA+ID4gIyBQeXRob24gYW5kIFBlcmw6IGRlZmF1bHQgdG8gdGFicyAobW9zdCB0
ZXN0IGZpbGVzIHVzZSB0YWJzLCBjaGVja3BhdGNoLnBsIHdoaWNoIHdlIG1vZGlmeSkKPiA+ID4g
Wyoue3B5LHBsfV0KPiA+ID4gaW5kZW50X3N0eWxlID0gdGFiCj4gPiA+IGluZGVudF9zaXplID0g
OAo+Cj4gPiBOb3QgMTAwJSBzdXJlIGFib3V0IHRoaXMuCj4KPiA+IFRoZSBQeXRob24gdGVzdCBm
aWxlcyBpbiB0aGUgdHJlZSAoZS5nLiBwbV9zY2hlZF9kb21haW4ucHksIHBtX2lsYl90ZXN0LnB5
KQo+ID4gYWxsIHVzZSA0LXNwYWNlIGluZGVudGF0aW9uLCBub3QgdGFicy4gVGhlIGRlZmF1bHQg
Zm9yICoucHkgc2hvdWxkIGJlCj4gPiBpbmRlbnRfc3R5bGUgPSBzcGFjZSAvIGluZGVudF9zaXpl
ID0gNC4gUGVybCAoY2hlY2twYXRjaC5wbCkgZG9lcyB1c2UgdGFicywKPiA+IHNvIGl0IHNob3Vs
ZCBnZXQgaXRzIG93biBzZWN0aW9uLgo+Cj4gPiBBbHNvIGtpcmsgdXNlcyA0IHRhYnMgaW5kZW50
YXRpb24uIFNvIEkgZ3Vlc3Mgd2UgbmVlZCB0byBpbnZlcnQgdGhlIHR3byBydWxlcwo+ID4gYXQg
dGhpcyBwb2ludC4KPgo+IFdvdWxkIGl0IHdvcmsgaWYga2lyayBoYXMgaXQncyBvd24gLmVkaXRv
cmNvbmZpZz8gSSBtZWFuLCBpdCBzaG91bGQgaGF2ZSBhbnl3YXksCj4gYnV0IGlmIGl0IHdpbGwg
YmUgYXBwbGllZCBvbiBpdCBhcyBhIHN1Ym1vZHVsZS4KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRy
CkhpIFBldHIsCgpJbiB1cHN0cmVhbSBMVFAsIGtpcmsgaXMgYWN0dWFsbHkgaW5jbHVkZWQgYXMg
YSBnaXQgc3VibW9kdWxlIGF0CmB0b29scy9raXJrYCAoc2VlIGAuZ2l0bW9kdWxlc2ApLCBzbyBo
YXZpbmcga2lyayBjYXJyeSBpdHMgb3duCmAuZWRpdG9yY29uZmlnYCBpcyBhIG5hdHVyYWwgZml0
LgoKRWRpdG9yQ29uZmlnIGlzIGRpcmVjdG9yeS1oaWVyYXJjaGljYWw6IGVkaXRvcnMgbG9vayBm
b3IgYC5lZGl0b3Jjb25maWdgCmZpbGVzIGZyb20gdGhlIGZpbGXigJlzIGRpcmVjdG9yeSB1cHdh
cmRzLCBhbmQgdGhlIGNsb3Nlc3QgbWF0Y2hpbmcKc2V0dGluZ3Mgb3ZlcnJpZGUgcGFyZW50IG9u
ZXMuIElmIGtpcmvigJlzIGAuZWRpdG9yY29uZmlnYCBzZXRzIGByb290ID0KdHJ1ZWAsIHRoZSBs
b29rdXAgc3RvcHMgYXQgdGhlIHN1Ym1vZHVsZSByb290LCBzbyBMVFDigJlzIHRvcC1sZXZlbCBy
dWxlcwp3b27igJl0IGFmZmVjdCBmaWxlcyBpbnNpZGUgYHRvb2xzL2tpcmtgLgoKQWx0ZXJuYXRp
dmVseSwgaWYgb25lIHByZWZlciBhIHNpbmdsZSBwb2xpY3kgZmlsZSwgb25lIGNvdWxkIGtlZXAK
ZXZlcnl0aGluZyBpbiBMVFDigJlzIHRvcC1sZXZlbCBgLmVkaXRvcmNvbmZpZ2AgYW5kIGFkZCBh
IGRlZGljYXRlZApvdmVycmlkZSBzZWN0aW9uIGxpa2UgYFt0b29scy9raXJrLyoqXWAuCgpLaW5k
IHJlZ2FyZHMsCkphbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
