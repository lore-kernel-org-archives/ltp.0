Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PvXQJ-0005nE-6A
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:00:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvXQI-00051w-2i
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:00:11 +0000
Message-ID: <4D710C76.40900@redhat.com>
Date: Fri, 04 Mar 2011 23:59:50 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D662E3A.1050802@cn.fujitsu.com>	<AANLkTim+d5gTwh84n2s79f2s+TmZD7AMuK65iQAfQ9yw@mail.gmail.com>	<4D6AF509.7000302@cn.fujitsu.com>
	<AANLkTinfLc-WM3vkV7WWFNxdAjFMEz1LiHT9CqA5+fih@mail.gmail.com>
In-Reply-To: <AANLkTinfLc-WM3vkV7WWFNxdAjFMEz1LiHT9CqA5+fih@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------020809020105070908090707"
Subject: Re: [LTP] [PATCH] The parent process need exit of waitpid11.c,
 waitpid12.c, waitpid13.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020809020105070908090707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2011 06:13 PM, Garrett Cooper wrote:
> I've committed a more extensive patch. Please test it out and let me
> know how it goes -- thanks!
> -Garrett

Hi Garrett, compile error occurs in this patch, here is a fix.

-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------020809020105070908090707
Content-Type: text/plain; name="0001-syscalls-waitpid11-fix-compile-err.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-syscalls-waitpid11-fix-compile-err.patch"

RnJvbSBjNTJhNjc5OGNhYTVkZDY3M2VlYTUwYjlhNDE2ODY3MTNlNmMxMzAzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBGcmksIDQgTWFyIDIwMTEgMjM6NTc6MzkgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBzeXNjYWxsczogd2FpdHBpZDExOiBmaXggY29tcGlsZSBlcnIKClNpZ25lZC1vZmYtYnk6
IENhc3BhciBaaGFuZyA8Y3poYW5nQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy93YWl0cGlkL3dhaXRwaWQxMS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy93YWl0cGlkL3dhaXRwaWQxMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy93YWl0cGlkL3dhaXRwaWQxMS5jCmluZGV4IDQ1ZDgyOGMuLjM2
OGU5ODQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd2FpdHBpZC93
YWl0cGlkMTEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dhaXRwaWQvd2Fp
dHBpZDExLmMKQEAgLTI4Myw3ICsyODMsNyBAQCBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKiph
dikKIHZvaWQgc2V0dXBfc2lnaW50KHZvaWQpCiB7CiAJaWYgKHNpZ25hbChTSUdJTlQsIGlu
dGhhbmRscikgPT0gU0lHX0VSUikKLQkJdHN0X2Jya20oVEZBSUx8VEVSUk5PLCAic2lnbmFs
IFNJR0lOVCBmYWlsZWQiKTsKKwkJdHN0X2Jya20oVEZBSUx8VEVSUk5PLCBOVUxMLCAic2ln
bmFsIFNJR0lOVCBmYWlsZWQiKTsKIH0KIAogdm9pZCBzZXR1cCh2b2lkKQotLSAKMS43LjQu
MQoK
--------------020809020105070908090707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--------------020809020105070908090707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------020809020105070908090707--

