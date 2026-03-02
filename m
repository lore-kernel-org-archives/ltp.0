Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C12D58E7E
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF94B3D71F5
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 09:57:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D033D71F3
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 09:56:44 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78E976008A2
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 09:56:38 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621Bt2j8856129; Mon, 2 Mar 2026 08:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1El27Q
 CKTtfrHlGmBTm8EHBCChxJ6hQ9B/8CjPwSF0s=; b=EBGhOGCJoQgnSzhNGgRT9n
 Kz8PVIJsSke3ZkafIYjm9to9nZzTEeXsvNwYhuL9d9MM7EeXvdADJnGSufWBGc4o
 piIukgu7uDVPfM4Hb8hRnrjNEujDmQAzQF52MBsllNHoPjBMxuOK+OM4HVVOdVAH
 7bgI5f+dMWKttKJbm3dxhe41c4lYnkDPrc95trIsozHdRYJ8akaLVMBzWtqlx5a6
 PQvQkLKj6TE2VkEIdIoN1++VOUNVgAxVNx+PoGGRfy96VN4RPh6AQpiZO2b+C917
 5eyyzk4TnxGIlaYBzIe3P3kmFQaA/rYjtWwvG9bHqxosdnd+oCX62HNltU1IjGcA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbnecr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 08:56:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6224rQ5E003275;
 Mon, 2 Mar 2026 08:56:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xw6v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 08:56:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6228uXhT16449954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 08:56:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28E34200EE;
 Mon,  2 Mar 2026 08:56:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C897B200ED;
 Mon,  2 Mar 2026 08:56:32 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.13.140])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  2 Mar 2026 08:56:32 +0000 (GMT)
Date: Mon, 2 Mar 2026 09:56:31 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: John Stultz <jstultz@google.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aaVQv4A_KLXj929M@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260224104544.101292-1-japo@linux.ibm.com>
 <CANDhNCrrZY=5bvRQGGJsigjwRNmDz8shbtM-Vtn5UkdRDGU_uA@mail.gmail.com>
 <DGNXMJ74NVTB.2DY53W36K3GET@suse.com>
 <CANDhNCqASmDD99T_viiAnRz55otuNWAzvx-JL8Td8Q_=Qjwgyg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANDhNCqASmDD99T_viiAnRz55otuNWAzvx-JL8Td8Q_=Qjwgyg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xamNaVsHoMviv3JJzB36u9-do-FrjjYc
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a550c4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iox4zFpeAAAA:8
 a=VnNF1IyMAAAA:8 a=JtI1l0JFozdEsTxVanMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NiBTYWx0ZWRfX3DLLzzgVaule
 b+nKZX83QTX+5zM9AyD0QbSq++ShkKvZS7JYyr+oyyHb7iTniCcf45VLRR6Bn1ufscYa4bVIw5V
 rwkXNv7ZJkKmSxOtpc1v9VViFFpdLe8FCqKwvPQpsKFKYssTH7AkW6IYpMrvlqE3EgqVjLSLyfw
 5t6rW493YY7d4Tc9LdU4CHPrbci/dAKD8tnGhKR8exY9envSuMKzW+NxsamjCqrg4seX3/Ujdbo
 fOAauQ1tJVqP9Y3BELb554EX7dltIGZVxE00qnAk0UQnrNs6qGNslI2T8rfCFlG9LEbZFLyvQC5
 To/tYSRrH9eOEbvkpc92lovgdwEpWr/MJB2aQA/7r6LyUK5MhNt4EJFju6UrE3tR7L4ZMR3KFUn
 rBmiXrnzYnLxX1xyDi353eujy0By630vp36SvxXCmT7Xc6QlFvZ/p16/J5iNsy2K+bMT4hrFPjb
 HSrnCojczAI/UT2fpBw==
X-Proofpoint-GUID: QYPJ95pNxZ5udxl9nq0I2fsDNwRPVPbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020076
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] sched_football: harden kickoff
 synchronization on high-CPU systems
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
Cc: Linux Test Project <ltp@lists.linux.it>,
 Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgMTE6MTE6NTNBTSAtMDgwMCwgSm9obiBTdHVsdHogd3Jv
dGU6Cj4gT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgMToyM+KAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8K
PiA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUgRmViIDI0LCAy
MDI2IGF0IDEwOjAzIFBNIENFVCwgSm9obiBTdHVsdHogdmlhIGx0cCB3cm90ZToKPiA+ID4gT24g
VHVlLCBGZWIgMjQsIDIwMjYgYXQgMjo0NeKAr0FNIEphbiBQb2xlbnNreSA8amFwb0BsaW51eC5p
Ym0uY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IFRoZSBzY2hlZF9mb290YmFsbCB0ZXN0IGhh
cyBiZWVuIGludGVybWl0dGVudGx5IGZhaWxpbmcsIG1vc3Qgbm90aWNlYWJseQo+ID4gPiA+IG9u
IHN5c3RlbXMgd2l0aCBtYW55IENQVXMgYW5kL29yIHVuZGVyIGxvYWQsIGR1ZSB0byBhIHN0YXJ0
dXAgb3JkZXJpbmcKPiA+ID4gPiBob2xlIGFyb3VuZCBraWNrb2ZmLgo+ID4gPiA+Cj4gPiA+Cj4g
PiA+IEkndmUgbm90IGhhZCB0aW1lIHRvIGNsb3NlbHkgcmV2aWV3IHlvdXIgc3VnZ2VzdGlvbiBo
ZXJlLCBidXQgaXQKPiA+ID4gc291bmRzIHJlYXNvbmFibGUuCj4gPiA+Cj4gPiA+IFRoYXQgc2Fp
ZCwgSSB3YW50IHRvIHdhcm4geW91IGFuZCBlbnN1cmUgeW91IGFyZSBhd2FyZTogdGhlCj4gPiA+
IFJUX1BVU0hfSVBJIGZlYXR1cmUgaW4gdGhlIHNjaGVkdWxlciBicmVha3MgdGhlIFJUIGludmFy
aWFudAo+ID4gPiBzY2hlZF9mb290YmFsbCBpcyB0ZXN0aW5nLgo+ID4gPgo+ID4gPiBJIHNlZSB0
aGlzIGFzIGEgYnVnIHdpdGggdGhhdCBmZWF0dXJlLCBidXQgdGhlIHNjYWxhYmlsaXR5IFJUX1BV
U0hfSVBJCj4gPiA+IGFsbG93cyBmb3Igc2VlbXMgbW9yZSBpbXBvcnRhbnQgdG8gZm9sa3Mgd2hv
IGFyZSBkb2luZyBSVCB3b3JrIHRoZW4KPiA+ID4gdGhlIG1pcy1iZWhhdmlvci4gIFN0ZXZlbiBh
bmQgSSB0YWxrZWQgYXdoaWxlIGJhY2sgYWJvdXQgc29tZSBpZGVhcyBvbgo+ID4gPiBob3cgd2Ug
bWlnaHQgYmUgYWJsZSB0byBkbyB0aGUgcHVsbCBpbiBhIG1vcmUgZWZmaWNpZW50IHdheSB3aGls
ZQo+ID4gPiBzdGlsbCBob2xkaW5nIHRoZSBpbnZhcmlhbnQgdHJ1ZSwgYW5kIEkgaGF2ZSBhIGJ1
ZyB0byB0cmFjayBpdCwgYnV0Cj4gPiA+IGl0cyBub3QgYmVlbiBoaWdoIGVub3VnaCBwcmlvcml0
eSB0byBnZXQgYmFuZHdpZHRoIHlldC4KPiA+ID4KPiA+ID4gU28geW91IG1pZ2h0IHdhbnQgdG8g
bWFrZSBzdXJlIHlvdSBkaXNhYmxlIHRoYXQgZmVhdHVyZSBiZWZvcmUgdGVzdGluZyB2aWE6Cj4g
PiA+ICMgZWNobyBOT19SVF9QVVNIX0lQSSA+IC9zeXMva2VybmVsL2RlYnVnL3NjaGVkL2ZlYXR1
cmVzCj4gPiA+Cj4gPiA+IHRoYW5rcwo+ID4gPiAtam9obgo+ID4KPiA+IFRoYW5rcyBmb3IgeW91
ciBkZWVwIGFuYWx5c2lzIG9uIHRoZSBwb3NzaWJsZSBpc3N1ZS4gSSdtIG5vdCBhbiBSVCBleHBl
cnQsCj4gPiBidXQgSSB0cnVzdCB5b3VyIGV4cGVydGlzZSBpbiBoZXJlIDotKSBXaWxsIGxlYXZl
IHRoaXMgcGF0Y2ggcmV2aWV3IHRvCj4gPiBzb21lb25lIHdobydzIG1vcmUgc2tpbGxlZCB0aGFu
IG1lIGluIHRoaXMgdG9waWMuCj4gPgo+ID4gSSBoYXZlIGEgc3VnZ2VzdGlvbiB0aG8uCj4gPgo+
ID4gQWJvdXQgdGhlIE5PX1JUX1BVU0hfSVBJLCB3ZSBhcmUgbHVja3k6IExUUCBwcm92aWRlcyBh
IHNhZmUgbWVjaGFuaXNtIHRvCj4gPiBzZXQgdGhlIHN5cyBjb25maWd1cmF0aW9ucyBhbmQgdG8g
cmVzdG9yZSBpdCB0byBkZWZhdWx0IHZhbHVlIGFmdGVyCj4gPiB0ZXN0LiBZb3UgY2FuIGZpbmQg
dGhpcyBpbiB0aGUgYHN0cnVjdCB0c3RfdGVzdGAgYW5kIGl0J3MgY2FsbGVkCj4gPiBgLnNhdmVf
cmVzdG9yZWAgWzFdCj4gPgo+ID4gSSB0aGluayBpdCdzIHdvcnRoIHRvIGZvcmNlIHRoaXMgb3B0
aW9uIGFjY29yZGluZyB0byB0aGUgdW5kZXJseWluZwo+ID4gdmFyaWFudCAoYW5kIHByb3Blcmx5
IGRvY3VtZW50IHRoaXMgaW4gdGhlIGNvZGUgd2l0aCBhIGNvbW1lbnQpLgo+ID4KPiA+IFdEWVQ/
Cj4KPiBUaGF0IHNlZW1zIHJlYXNvbmFibGUsIGFzIGxvbmcgYXMgaXQncyBjbGVhcmx5IGxhYmVs
ZWQgYXMgYSB3b3JrYXJvdW5kCj4gYW5kIGhvcGVmdWxseSBjYW4gYmUgZHJvcHBlZCAob3Iga2Vy
bmVsIHZlcnNpb24gbGltaXRlZCkgd2hlbiB0aGUKPiBpc3N1ZSBpcyBmaW5hbGx5IGFkZHJlc3Nl
ZC4KPgo+IHRoYW5rcwo+IC1qb2huCkhpIEFuZHJlYSwgaGkgSm9obiwKCnRoYW5rIHlvdSBmb3Ig
dGhlIHRob3JvdWdoIHJldmlldyBhbmQgdGhlIGhlbHBmdWwgcmVtYXJrcy4KQWZ0ZXIgZ29pbmcg
dGhyb3VnaCB0aGUgZmVlZGJhY2ssIEkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gc3RlcCBiYWNr
IGFuZApyZXdvcmsgdGhlIHBhdGNoLiBUaGUgbWFpbiBvYmplY3RpdmUgaXMgdG8gZHJpdmUgdGhl
IGZhaWx1cmUgcmF0ZSBkb3duIGFzCm11Y2ggYXMgcG9zc2libGUsIGFuZCB0aGUgY3VycmVudCB2
ZXJzaW9uIHN0aWxsIHNob3dzIHdlYWtuZXNzZXMsCmVzcGVjaWFsbHkgd2l0aCByZXNwZWN0IHRv
IHN0ZWFsIHRpbWUuIE9uIGhlYXZpbHkgbG9hZGVkIHN5c3RlbXMgSSBhbHNvCnN0aWxsIG9ic2Vy
dmUgZnJlcXVlbnQgVEJST0sgcmVzdWx0cywgc28gdGhlIHRpbWluZyBjbGVhcmx5IG5lZWRzIGZ1
cnRoZXIKdHVuaW5nLgpJIHdpbGwgdGFrZSBzb21lIHRpbWUgdG8gcmV2aXNpdCB0aGUgZGVzaWdu
IGFuZCBpbmNvcnBvcmF0ZSB0aGVzZSBhc3BlY3RzCmJlZm9yZSBwb3N0aW5nIGEgcmV2aXNlZCB2
ZXJzaW9uLgpUaGFua3MgYWdhaW4gZm9yIHlvdXIgY29tbWVudHMgYW5kIHN1Z2dlc3Rpb25zLgoK
VGhhbmtzICYgR3JlZXRpbmdzCkphbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
