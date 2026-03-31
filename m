Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1560610F92F2
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 20:00:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 551993E5708
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 22:00:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 917F83CEDD3
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 21:59:50 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C42AA140098F
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 21:59:49 +0200 (CEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VJX16i108580; Tue, 31 Mar 2026 19:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lc+T+b
 tkwN1IwxTDPh9HXi8wYSvMek33QvVseJtBgHI=; b=UjzoUBod1jTBuzLUBJXOES
 4w7kha1eh6A1Gk3kEnlvu9junX2zI9GR6AxZmL6mx58Lf+EnF2qYl9b1vPks+Nx8
 Qrbr4I0Spp9gxeRQgtOLIT/g3HtQi0AHET7MEE9BKtJgn500zuZCe7BOWlVgydFN
 CdZAEhZoMVmQ5zYzHAoWATYvoO8ZEW9ucyMYNace7FeNjaGJq77x6/jk+tmvaY9L
 erARa0fipy+soSB9FMDd7qM1ohYiINp8p9wgbhc8SkZRmXuEaTf7qnxJdZ7GUrlk
 O9c2aVzmHlKrsLQJqgjDK/hhdm5vTPqzBkAfg/xnlYzrjaltits7DsjDRsjsmiFw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dccp4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 19:59:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VGTuUJ030990;
 Tue, 31 Mar 2026 19:59:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjtj5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 19:59:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VJxiVD29557254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 19:59:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4AED2004B;
 Tue, 31 Mar 2026 19:59:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF8920040;
 Tue, 31 Mar 2026 19:59:44 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.25.34]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Mar 2026 19:59:44 +0000 (GMT)
Date: Tue, 31 Mar 2026 21:59:43 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
Message-ID: <acwnrxDHHcHLNHZp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260327152952.GB1092845@pevik>
 <69ca24ec.050a0220.1c41d8.a7e9@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69ca24ec.050a0220.1c41d8.a7e9@mx.google.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cc27b3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iox4zFpeAAAA:8
 a=15bsxF5lQb7_HR4itmEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: Y2qFcQRaTbTXYVCXUWSS4JShI0mqNoq3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE5MSBTYWx0ZWRfX8bhEdPpTGxBR
 duRLTVhD5xsNSofKu5olJjk8tE07b3Fc1Me1vTJkbfNBnN6Dk2QVAqhjiW0IMbQVokKFr2G8tlj
 uJkYVILt33t2NoaZESdu0ZbqCWJBtpVF1OKiQUgPRhExJyWM8HI9gxCNONvrC3FENd67RkbY2Sb
 4gagBsuBX2+LPMLKgjWqDpSdgTsBS1PqY3/p2/RmfGUWcf+R0DKdb2TqMSUE9YC5Y5g8eqiOjbD
 /8MK8eAskdq1DYz+cZijRtfq+24L0MoEsyHtu1bR6MSf1iHkEibbZg3oUtOT+1VM7N4EG9HPA1n
 Utqz+LNYvvloiA0RWKxfBD/XlyCcShWUliXcJX3s4HNeAL6mOzW86hsDlJnqIVeZLK4qBKhVkEp
 lOop8F81FHaflFCOqVBt6iHu5iDpFWzmnhlL+amN2HEo99evJSfpM5SniDlQFlKNkUpNbIYphib
 vxA9sRJNHU5zO1tSRvg==
X-Proofpoint-ORIG-GUID: Y2qFcQRaTbTXYVCXUWSS4JShI0mqNoq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310191
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

T24gTW9uLCBNYXIgMzAsIDIwMjYgYXQgMDc6MjM6MjNBTSArMDAwMCwgQW5kcmVhIENlcnZlc2F0
byB3cm90ZToKPiA+IFdvdWxkIGl0IHdvcmsgaWYga2lyayBoYXMgaXQncyBvd24gLmVkaXRvcmNv
bmZpZz8gSSBtZWFuLCBpdCBzaG91bGQgaGF2ZSBhbnl3YXksCj4gPiBidXQgaWYgaXQgd2lsbCBi
ZSBhcHBsaWVkIG9uIGl0IGFzIGEgc3VibW9kdWxlLgo+Cj4gVGhlcmUncyBubyBuZWVkLCBldmVy
eXRoaW5nIGlzIGhhbmRsZWQgYnkgYHJ1ZmZgIHRoYXQgaXMgYXV0by1mb3JtYXR0aW5nCj4gYW5k
IGNsZWFuaW5nIHVwIHB5dGhvbiBjb2RlLiBJdHMgY29uZmlndXJhdGlvbiBpcyBpbiBgcHlwcm9q
ZWN0LnRvbWxgIGFuZAo+IGl0J3MgZGUtZmFjdG8gc3RhbmRhcmQgZm9yIHB5dGhvbiBkZXZlbG9w
bWVudCBub3dhZGF5cy4KPgo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0UgUUUgQXV0b21h
dGlvbiBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KSGkgQW5kcmVh
LCBoaSBQZXRyLAoKdGhhbmtzIGZvciB0aGUgcmV2aWV3IQoKSeKAmW0gc2VuZGluZyB2MyBhZGRy
ZXNzaW5nIHRoZSBjb21tZW50czoKCkNoYW5nZXMgc2luY2UgdjI6Ci0gVXNlIGtlcm5lbC1zdHls
ZSB0YWJzIGZvciBDL0FTTS9zaGVsbCAodGFiIHN0b3AgOCB2aWEgdGFiX3dpZHRoPTgsIGluZGVu
dF9zaXplPXRhYikuICh0aHggQW5kcmVhIENlcnZlc2F0bywgUGV0ciBWb3JlbCkKLSBTcGxpdCBQ
eXRob24vUGVybCBpbmRlbnRhdGlvbjogKi5weSB1c2VzIDQgc3BhY2VzOyAqLnBsIGtlZXBzIHRh
YnMuICh0aHggQW5kcmVhIENlcnZlc2F0bykKCkJlc3QgcmVnYXJkcywKSmFuCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
