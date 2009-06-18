Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHCZF-0004M2-I1
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 08:01:53 +0000
Received: from yw-out-1718.google.com ([74.125.46.155])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHCZE-0004s8-NI
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 08:01:53 +0000
Received: by yw-out-1718.google.com with SMTP id 5so459921ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Jun 2009 01:01:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906180054v457c0ab9s9fc075804b270e22@mail.gmail.com>
References: <f5a7b3810906171320p432db48l92fc6a42cddfa6df@mail.gmail.com>
	<20090617214220.GA227500@medusa.sis.pasteur.fr>
	<f5a7b3810906180054v457c0ab9s9fc075804b270e22@mail.gmail.com>
Date: Thu, 18 Jun 2009 13:24:51 +0530
Message-ID: <f5a7b3810906180054k488a03fdxc8a4a98569b90238@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f128401dc86046c9ab9e7
Subject: Re: [LTP] [FIX PATCH] ltp-rt_sigprocmask
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
To: Nicolas Joly <njoly@pasteur.fr>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Oleg Nesterov <oleg@redhat.com>, Manas Kumar Nayak <maknayak@in.ibm.com>, rohit.170309@gmail.com

--001e680f128401dc86046c9ab9e7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

attachment.

On Thu, Jun 18, 2009 at 1:24 PM, naresh kamboju<naresh.kernel@gmail.com> wr=
ote:
> Hi Nicolas Joly,
>
> =A0 =A0 =A0 =A0>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(s=
yscall(174, 33, &act, &oact, 8));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_tkil=
l, 33, &act, &oact, 8));
>>
>> This one looks wrong ... Shouldn't it be __NR_rt_sigaction ?
>
> yes.
> your right it should be __NR_rt_sigaction.
>
> Subrata,
> please ignore previous patch.
> i have attached latest patch.
>
> Best regards
> Naresh Kamboju
>
>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if(TEST_RETURN !=3D 0){
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TF=
AIL,"Call to
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
> rt_sigprocmask()succeeded,but should
>>> failed, errno=3D%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fail++;
>>
>> --
>> Nicolas Joly
>>
>> Biological Software and Databanks.
>> Institut Pasteur, Paris.
>>
>

--001e680f128401dc86046c9ab9e7
Content-Type: application/octet-stream; name="ltp-fix-rt_sigprocmask.patch"
Content-Disposition: attachment; filename="ltp-fix-rt_sigprocmask.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw36eycr0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0
X3NpZ3Byb2NtYXNrMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lncHJvY21h
c2svcnRfc2lncHJvY21hc2swMS5jCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRf
c2lncHJvY21hc2svcnRfc2lncHJvY21hc2swMS5jCTIwMDktMDUtMjEgMjM6NTM6MDAuMDAwMDAw
MDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lncHJvY21hc2sv
cnRfc2lncHJvY21hc2swMS5jCTIwMDktMDYtMTggMTI6NTM6MTkuMDAwMDAwMDAwICswNTMwCkBA
IC0xNjMsMTQgKzE2MywxNCBAQAogCQkJCiAJCQkvKiBjYWxsIHJ0X3NpZ2FjdGlvbigpICovCiAJ
CQlhY3Quc2FfaGFuZGxlciA9IHNpZ19oYW5kbGVyOwotICAgICAgICAgICAgICAgICAgICAgICAg
VEVTVChzeXNjYWxsKDE3NCwgMzMsICZhY3QsICZvYWN0LCA4KSk7CisgICAgICAgICAgICAgICAg
ICAgICAgICBURVNUKHN5c2NhbGwoX19OUl9ydF9zaWdhY3Rpb24sIDMzLCAmYWN0LCAmb2FjdCwg
OCkpOwogCQkJaWYoVEVTVF9SRVRVUk4gIT0gMCl7CiAJCQkJdHN0X3Jlc20oVEZBSUwsIkNhbGwg
dG8gcnRfc2lnYWN0aW9uKCkgRmFpbGVkLCBlcnJubz0lZCA6ICVzIixURVNUX0VSUk5PLCBzdHJl
cnJvcihURVNUX0VSUk5PKSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAJY2xlYW51cCgpOwog
CQkJCXRzdF9leGl0KCk7CiAJCQl9CiAJCQkvKiBjYWxsIHJ0X3NpZ3Byb2NtYXNrKCkgdG8gYmxv
Y2sgc2lnbmFsIzMzICovCi0gICAgICAgICAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwoMTc1
LCBTSUdfQkxPQ0ssICZzZXQsICZvc2V0LCA4KSk7CisgICAgICAgICAgICAgICAgICAgICAgICBU
RVNUKHN5c2NhbGwoX19OUl9ydF9zaWdwcm9jbWFzaywgU0lHX0JMT0NLLCAmc2V0LCAmb3NldCwg
OCkpOwogCQkJaWYoVEVTVF9SRVRVUk4gPT0gLTEpewogCQkJCXRzdF9yZXNtKFRGQUlMLCJDYWxs
IHRvIHJ0X3NpZ3Byb2NtYXNrKCkqKioqIEZhaWxlZCwgZXJybm89JWQgOiAlcyIsVEVTVF9FUlJO
Tywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgCWNsZWFu
dXAoKTsKQEAgLTE5Miw3ICsxOTIsNyBAQAogCQkJCX0KIAkJCQllbHNlIHsKIAkJCQkJLyogY2Fs
bCBydF9zaWdwZW5kaW5nKCkgKi8KLQkJCQkJVEVTVChzeXNjYWxsKDE3NiwgJm9zZXQsIDgpKTsK
KwkJCQkJVEVTVChzeXNjYWxsKF9fTlJfcnRfc2lncGVuZGluZywgJm9zZXQsIDgpKTsKIAkJCQkJ
aWYoVEVTVF9SRVRVUk4gPT0gLTEpewogCQkJCQkJdHN0X3Jlc20oVEZBSUwsImNhbGwgcnRfc2ln
cGVuZGluZygpIGZhaWxlZCwgZXJybm89JWQgOiAlcyIsVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVT
VF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgCQkJY2xlYW51cCgpOwpAQCAtMjA1
LDcgKzIwNSw3IEBACiAJCQkJCQl0c3RfZXhpdCgpOwogCQkJCQl9CiAJCQkJCS8qIGNhbGwgcnRf
c2lncHJvY21hc2soKSB0byB1bmJsb2NrIHNpZ25hbCMzMyAqLwotCQkJCQlURVNUKHN5c2NhbGwo
MTc1LCBTSUdfVU5CTE9DSywgJnNldCwgJm9zZXQsIDgpKTsKKwkJCQkJVEVTVChzeXNjYWxsKF9f
TlJfcnRfc2lncHJvY21hc2ssIFNJR19VTkJMT0NLLCAmc2V0LCAmb3NldCwgOCkpOwogCQkJCQlp
ZihURVNUX1JFVFVSTiA9PSAtMSl7CiAJCQkJCQl0c3RfcmVzbShURkFJTCwiQ2FsbCB0byBydF9z
aWdwcm9jbWFzaygpIEZhaWxlZCwgZXJybm89JWQgOiAlcyIsVEVTVF9FUlJOTywgc3RyZXJyb3Io
VEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgCQkJY2xlYW51cCgpOwpkaWZm
IC1OYXVyYiBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lncHJvY21hc2svcnRfc2ln
cHJvY21hc2swMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdwcm9jbWFzay9y
dF9zaWdwcm9jbWFzazAyLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdw
cm9jbWFzay9ydF9zaWdwcm9jbWFzazAyLmMJMjAwOS0wNS0yMSAyMzo1NDoxNS4wMDAwMDAwMDAg
KzA1MzAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdwcm9jbWFzay9ydF9z
aWdwcm9jbWFzazAyLmMJMjAwOS0wNi0xOCAxMjo1MjozNC4wMDAwMDAwMDAgKzA1MzAKQEAgLTE3
Niw3ICsxNzYsNyBAQAogCiAJCQlmb3IoaT0wOyBpPHRlc3RfY291bnQ7IGkrKykKIAkJICAgICAg
ICB7Ci0JCQkJVEVTVChzeXNjYWxsKDE3NSwgU0lHX0JMT0NLLCAmcywgdGVzdF9jYXNlc1tpXS5z
cywgdGVzdF9jYXNlc1tpXS5zc3NpemUpKTsKKwkJCQlURVNUKHN5c2NhbGwoX19OUl9ydF9zaWdw
cm9jbWFzaywgU0lHX0JMT0NLLCAmcywgdGVzdF9jYXNlc1tpXS5zcywgdGVzdF9jYXNlc1tpXS5z
c3NpemUpKTsKIAkJCQlpZihURVNUX1JFVFVSTiA9PSAwKXsKIAkJCQkJdHN0X3Jlc20oVEZBSUws
IkNhbGwgdG8gcnRfc2lncHJvY21hc2soKXN1Y2NlZWRlZCxidXQgc2hvdWxkIGZhaWxlZCwgZXJy
bm89JWQgOiAlcyIsVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwogCQkJCQlmYWls
Kys7Cg==
--001e680f128401dc86046c9ab9e7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--001e680f128401dc86046c9ab9e7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f128401dc86046c9ab9e7--

