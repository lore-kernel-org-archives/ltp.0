Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770F7C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 17:38:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E533C4DD8
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:37:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3284F3C4C65
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:37:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DDC331A0089D
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 18:37:41 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NBMSiK022576;
 Thu, 23 Jan 2025 17:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5FMTfV
 /YbNjqNiCiZf0tWPbXe390qR+aazPeYohJAsE=; b=sMsMJEwhYq7aPblNHujXp+
 qMMEnELxWt9Y3eBh+WQpGZq2IUHfzg7g0asPaXxXglTcCg1qtUBuoe7xpQwxTgYA
 cjF/fO3NFT1ZIVrE+B7fT3kVfZtApJssyAPp/fsah5Lb2O0NFoBZrOziZqBnHkbw
 5WupFg/KS1aNjhn6bmyaf/D3KClBBtO4hxJ8JuP2wGbGj72Ugjl2diDLwF+ap3Tt
 s1ln1fvdlvYOb10qx4BYJQnnfAeDRuLCW9e1ie4yBtPv7L/zMpqZhpb4vCpebVu5
 jeJaVhPKVbUF24tdyGqOZdI798XF6PWU2N0NGgtJCyDiLEeFpSctyCFhl6/B+m/w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cdch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:37:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGaCjo021002;
 Thu, 23 Jan 2025 17:37:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p8qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2025 17:37:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50NHbbAO40239560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 17:37:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E2BA5804E;
 Thu, 23 Jan 2025 17:37:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 099A35803F;
 Thu, 23 Jan 2025 17:37:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.4.223]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jan 2025 17:37:36 +0000 (GMT)
Message-ID: <317110b32e6cad2d2e828374be16e4057ca896bd.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Thu, 23 Jan 2025 12:37:36 -0500
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eZvRqARaKTCuy4ghDV6vLSYgYMhQ_4Ba
X-Proofpoint-ORIG-GUID: eZvRqARaKTCuy4ghDV6vLSYgYMhQ_4Ba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 00/10] LTP tests: load predefined policy,
 enhancements
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

SGkgUGV0ciwKCk9uIFR1ZSwgMjAyNS0wMS0xNCBhdCAxMjoyOSArMDEwMCwgUGV0ciBWb3JlbCB3
cm90ZToKPiBDaGFuZ2VzIHYyLT52MzoKPiAqIFJld3JpdGUgdmVyaWZ5aW5nIGxvZ2ljIGlmIHBv
bGljeSBuZWVkcyB0byBiZSBsb2FkZWQgYW5kIGhvdyBpdCBpcwo+IMKgIGxvYWRlZC4KPiAqIEFs
bG93IHRlc3Rpbmcgd2hlbiBwb2xpY3kgaXMgbm90IHJlbGlhYmxlLCBidXQgcmVsYXggZmFpbHVy
ZXMgdG8gVENPTkYuCj4gKiBBZGQgVENCIHBvbGljeSBleGFtcGxlLgo+ICogRG9jdW1lbnQgTFRQ
X0lNQV9MT0FEX1BPTElDWSBpbiBkb2MvdXNlcnMvc2V0dXBfdGVzdHMucnN0Lgo+ICogRml4IHRl
c3QgcG9saWN5IGluc3RhbGxhdGlvbiAocHJldmlvdXNseSB3cm9uZyBNYWtlZmlsZSkuCj4gKiBS
ZW1vdmVkIHNvbWUgb2YgdGhlIHByZXZpb3VzIGNvbW1pdHMgKCJpbWFfa2V4ZWMuc2g6IFJlbGF4
IHJlc3VsdCBvbgo+IMKgIHVucmVhZGFibGUgcG9saWN5IHRvIFRDT05GIiwgImltYV92aW9sYXRp
b25zLnNoOiBDaGVjayBmb3IgYSByZXF1aXJlZCBwb2xpY3kiLAo+IMKgICJpbWFfc2V0dXA6IFBy
aW50IHdhcm5pbmcgd2hlbiBwb2xpY3kgbm90IHJlYWRhYmxlIikuCj4gKiBNb3JlIGNsZWFudXAu
CgpWZXJ5IG5pY2UgcGF0Y2ggc2V0LiAgVGhhbmsgeW91IQoKPiAKPiBUT0RPOiBpbWFfbWVhc3Vy
ZW1lbnRzLnNoIGFuZCBpbWFfdmlvbGF0aW9ucy5zaCB1c2UgZGV0ZWN0aW9uIGZvcgo+IGltYV9w
b2xpY3k9dGNiIGJ1aWx0aW4gcG9saWN5LiBCdXQgaWYgZXhhbXBsZSBwb2xpY3kgaXMgbG9hZGVk
IHRoZXJlIGlzCj4gbm8gbG9uZ2VyIHRjYiBwb2xpY3kuIE5vdCBzdXJlIGhvdyB0byBmaXggaXQg
LSBzb21lIHRvb2xpbmcgbWlnaHQgbm90Cj4gc3VwcG9ydCByZWJvb3QsIHRodXMgSSB3YW50ZWQg
dG8gdXNlIGltYV9wb2xpY3k9dGNiLCB3aGljaCBwcmV2aW91c2x5Cj4gd29ya2VkLgoKVGhlIHNw
ZWNpZmljIHBvbGljeSBydWxlcyBhcmUgbW9zdGx5IGEgc3Vic2V0IG9mIHRoZSB0Y2IgcG9saWN5
LiAgVGhlIG9ubHkgdGltZSB0aGF0CmxvYWRpbmcgYSBzcGVjaWZpYyBwb2xpY3kgZmlyc3QgaXMg
YW4gaXNzdWUgaXMgd2hlbiBpdCBpcyB0aGUgb25lIGFuZCBvbmx5IGN1c3RvbQpwb2xpY3kgYWxs
b3dlZCB0byBiZSBsb2FkZWQuICBPbmUgcG9zc2libGUgbWV0aG9kIG9mIGF2b2lkaW5nIHRoaXMg
cHJvYmxlbSwgd291bGQgYmUKdG8gcmVxdWlyZSBydW5uaW5nIHRoZSBpbWFfbWVhc3VyZW1lbnRz
LnNoIGZpcnN0LgoKTWltaQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
