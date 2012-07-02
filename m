Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shivam.mehta@sasken.com>) id 1Slfsx-0005U2-Jb
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 12:37:47 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Slfsq-0006gE-AQ
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 12:37:47 +0000
From: Shivam Mehta <shivam.mehta@sasken.com>
Date: Mon, 2 Jul 2012 17:54:37 +0530
Message-ID: <2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04@EXGMBX01.sasken.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_"
MIME-Version: 1.0
Subject: [LTP] clock_nanosleep01
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,


I am executing the testcase clock_nanosleep01.But subcase(04) is failing an=
d giving the error 95.but the expected error is 22. logs for the same on Zo=
om board is:


Clock_nanosleep test case is still failing. Please find the log for it as b=
elow:

<<<test_start>>>
tag=3Dclock_nanosleep01 stime=3D950931179
cmdline=3D"clock_nanosleep01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
EXPECT: return value(ret)=3D22 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
EXPECT: return value(ret)=3D22 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
EXPECT: return value(ret)=3D22 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D95 (Operation not supported on trans=
port endpoint)
EXPECT: return value(ret)=3D4 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D4 (Interrupted system call)
clock_nanosleep01    0  TINFO  :  (case00) START

---------log15--------

------log10-----

---return value2---0 0 500000000
--------------SYSRET=3D0
--------------------------errno-----0---------

---------log1--------
clock_nanosleep01    0  TINFO  :  check sleep time: (min:480) < 500 < (max:=
520) (msec)

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: -1 0

---------log7--------

---0------

-0 0 0 0


------0-----

---------log9--------

------return value1--- 0
clock_nanosleep01    0  TINFO  :  (case00) END =3D> OK
clock_nanosleep01    0  TINFO  :  (case01) START

---------log15--------

------log10-----

---return value2---0 0 500000000
--------------SYSRET=3D0
--------------------------errno-----0---------

---------log1--------
clock_nanosleep01    0  TINFO  :  check sleep time: (min:480) < 500 < (max:=
520) (msec)

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: -1 0

---------log7--------

---0------

-0 0 0 0


------0-----

---------log9--------

------return value1--- 0
clock_nanosleep01    0  TINFO  :  (case01) END =3D> OK
clock_nanosleep01    0  TINFO  :  (case02) START

---------log15--------

------log10-----

---return value2---0 0 -1
--------------SYSRET=3D-1
--------------------------errno-----22---------

---------log5--------

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: -1 0

---------log7--------

---0------

--1 22 0 0


------0-----

---------log9--------

------return value1--- 0
clock_nanosleep01    0  TINFO  :  (case02) END =3D> OK
clock_nanosleep01    0  TINFO  :  (case03) START

---------log15--------

------log10-----

---return value2---0 0 1000000000
--------------SYSRET=3D-1
--------------------------errno-----22---------

---------log5--------

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: -1 0

---------log7--------

---0------

--1 22 0 0


------0-----

---------log9--------

------return value1--- 0
clock_nanosleep01    0  TINFO  :  (case03) END =3D> OK
clock_nanosleep01    0  TINFO  :  (case04) START

---------log15--------

------log10-----

---return value2---0 0 500000000
--------------SYSRET=3D-1
--------------------------errno-----95---------

---------log5--------

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: -1 0

---------log7--------

---0------

--1 22 0 0


------1-----

---------log9--------

------return value1--- 1
clock_nanosleep01    0  TINFO  :  (case04) END =3D> NG
clock_nanosleep01    0  TINFO  :  (case05) START

---------log15--------

------log10-----

------log11-----

---return value4---3143

---return value2---0 10 0
--------------SYSRET=3D-1
--------------------------errno-----4---------

---------log5--------

---------log12--------
clock_nanosleep01    0  TINFO  :  remain time: 9 498402051

---------log13--------

---0------

--1 4 0 0


------0-----

---------log9--------

------return value1--- 0
clock_nanosleep01    0  TINFO  :  (case05) END =3D> OK
clock_nanosleep01    1  TFAIL  :  clock_nanosleep failed: errno=3D???(0): S=
uccess
TESTDIR checking ..... /tmp/ltp-dump-syscalls-01/tmp/ltp-XXXXxliEzJ/clopr31=
42
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D1 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>

please find the class file as an attachment and suggest me some some soluti=
on.




Thanks & Regards

Shivam Mehta

SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propriet=
ary or legally privileged information. In case you are not the original int=
ended Recipient of the message, you must not, directly or indirectly, use, =
disclose, distribute, print, or copy any part of this message and you are r=
equested to delete it and inform the sender. Any views expressed in this me=
ssage are those of the individual sender unless otherwise stated. Nothing c=
ontained in this message shall be construed as an offer or acceptance of an=
y offer by Sasken Communication Technologies Limited ("Sasken") unless sent=
 with that express intent and with due authority of Sasken. Sasken has take=
n enough precautions to prevent the spread of viruses. However the company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

--_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_
Content-Type: text/x-csrc; name="clock_nanosleep01.c"
Content-Description: clock_nanosleep01.c
Content-Disposition: attachment; filename="clock_nanosleep01.c"; size=11312;
	creation-date="Mon, 02 Jul 2012 17:54:43 GMT";
	modification-date="Mon, 02 Jul 2012 17:54:43 GMT"
Content-Transfer-Encoding: base64

LyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKi8KLyogQ29weXJpZ2h0IChjKSBDcmFja2VyamFjayBQcm9q
ZWN0LiwgMjAwNy0yMDA4ICxIaXRhY2hpLCBMdGQJCSovCi8qCSAgQXV0aG9yKHMpOiBUYWthaGly
byBZYXN1aSA8dGFrYWhpcm8ueWFzdWkubXBAaGl0YWNoaS5jb20+LAkgICAgICAqLwovKgkJICAg
ICAgIFl1bWlrbyBTdWdpdGEgPHl1bWlrby5zdWdpdGEueWZAaGl0YWNoaS5jb20+LCAJICAgICAg
Ki8KLyoJCSAgICAgICBTYXRvc2hpIEZ1aml3YXJhIDxzYS1mdWppQHNkbC5oaXRhY2hpLmNvLmpw
PgkgICAgICAqLwovKgkJCQkJCQkJICAJICAgICAgKi8KLyogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5ICAgICAgKi8K
LyogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkgICAgICAgKi8KLyogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsg
ZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IJICAqLwovKiAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLgkJCQkJKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogVGhpcyBw
cm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
CSAgICAqLwovKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YJICAgICovCi8qIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZQkJICAqLwovKiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4JCQkgICAqLwovKgkJCQkJCQkJCSAgICAqLwov
KiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZQkgICovCi8qIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0
ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQkgICAgICAgKi8KLyogRm91bmRhdGlvbiwgSW5jLiwgNTkg
VGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EgICAgKi8K
LyoJCQkJCQkJCQkgICAgKi8KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KLyoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogRmlsZToJY2xvY2tfbmFub3NsZWVwMDEuYwkJ
CQkJICAgKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogRGVzY3JpcHRpb246IFRoaXMgdGVzdHMgdGhl
IGNsb2NrX25hbm9zbGVlcCgpIHN5c2NhbGwJCSAgICAgICovCi8qCQkJCQkJCQkJICAgICAgKi8K
LyogCQkJCQkJCQkJICAgICAgKi8KLyoJCQkJCQkJCQkgICAgICAqLwovKgkJCQkJCQkJCSAgICAg
ICovCi8qCQkJCQkJCQkJICAgICAgKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogVXNhZ2U6ICA8Zm9y
IGNvbW1hbmQtbGluZT4JCQkJCQkgKi8KLyogY2xvY2tfbmFub3NsZWVwMDEgWy1jIG5dIFstZV1b
LWkgbl0gWy1JIHhdIFstcCB4XSBbLXRdCQkgICAgICovCi8qICAgICAgd2hlcmUsICAtYyBuIDog
UnVuIG4gY29waWVzIGNvbmN1cnJlbnRseS4JCQkgICAgICovCi8qCSAgICAgIC1lICAgOiBUdXJu
IG9uIGVycm5vIGxvZ2dpbmcuCQkJCSAqLwovKgkgICAgICAtaSBuIDogRXhlY3V0ZSB0ZXN0IG4g
dGltZXMuCQkJCSAgKi8KLyoJICAgICAgLUkgeCA6IEV4ZWN1dGUgdGVzdCBmb3IgeCBzZWNvbmRz
LgkJCSAgICAqLwovKgkgICAgICAtUCB4IDogUGF1c2UgZm9yIHggc2Vjb25kcyBiZXR3ZWVuIGl0
ZXJhdGlvbnMuCQkqLwovKgkgICAgICAtdCAgIDogVHVybiBvbiBzeXNjYWxsIHRpbWluZy4JCQkJ
Ki8KLyoJCQkJCQkJCQkgICAgKi8KLyogVG90YWwgVGVzdHM6IDEJCQkJCQkJICAgICAqLwovKgkJ
CQkJCQkJCSAgICAqLwovKiBUZXN0IE5hbWU6ICAgY2xvY2tfbmFub3NsZWVwMDEJCQkJCSAgICAg
Ki8KLyogSGlzdG9yeTogICAgIFBvcnRpbmcgZnJvbSBDcmFja2VyamFjayB0byBMVFAgaXMgZG9u
ZSBieQkJICAgICovCi8qCSAgICAgIE1hbmFzIEt1bWFyIE5heWFrIG1ha25heWFrQGluLmlibS5j
b20+CQkJKi8KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+
CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPGdldG9wdC5oPgojaW5jbHVkZSA8c3Ry
aW5nLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8c2lnbmFsLmg+CiNpbmNsdWRlICIu
Li91dGlscy9jb21tb25fal9oLmMiCiNpbmNsdWRlICIuLi91dGlscy9pbmNsdWRlX2pfaC5oIgoK
LyogSGFybmVzcyBTcGVjaWZpYyBJbmNsdWRlIEZpbGVzLiAqLwojaW5jbHVkZSAidGVzdC5oIgoj
aW5jbHVkZSAidXNjdGVzdC5oIgojaW5jbHVkZSAibGludXhfc3lzY2FsbF9udW1iZXJzLmgiCgov
KiBFeHRlcm4gR2xvYmFsIFZhcmlhYmxlcyAqLwoKLyogR2xvYmFsIFZhcmlhYmxlcyAqLwpjaGFy
ICpUQ0lEID0gImNsb2NrX25hbm9zbGVlcDAxIjsgIC8qIFRlc3QgcHJvZ3JhbSBpZGVudGlmaWVy
LiovCmludCAgdGVzdG5vOwppbnQgIFRTVF9UT1RBTCA9IDE7CQkgICAvKiB0b3RhbCBudW1iZXIg
b2YgdGVzdHMgaW4gdGhpcyBmaWxlLiAgICovCnN0cnVjdCBzaWdhY3Rpb24gYWN0OwoKLyoKICog
c2lnaGFuZGxlcigpCiAqLwp2b2lkIHNpZ2hhbmRsZXIoaW50IHNpZykKewoJaWYgKHNpZyA9PSBT
SUdJTlQpCgkJcmV0dXJuOwoKCXJldHVybjsKfQoKLyogRXh0ZXJuIEdsb2JhbCBGdW5jdGlvbnMg
Ki8KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogRnVuY3Rpb246
ICAgIGNsZWFudXAJCQkJCQkgICAgICAgKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogRGVzY3JpcHRp
b246IFBlcmZvcm1zIGFsbCBvbmUgdGltZSBjbGVhbiB1cCBmb3IgdGhpcyB0ZXN0IG9uIHN1Y2Nl
c3NmdWwgICAgKi8KLyoJICAgICAgY29tcGxldGlvbiwgIHByZW1hdHVyZSBleGl0IG9yICBmYWls
dXJlLiBDbG9zZXMgYWxsIHRlbXBvcmFyeSAqLwovKgkgICAgICBmaWxlcywgcmVtb3ZlcyBhbGwg
dGVtcG9yYXJ5IGRpcmVjdG9yaWVzIGV4aXRzIHRoZSB0ZXN0IHdpdGggICovCi8qCSAgICAgIGFw
cHJvcHJpYXRlIHJldHVybiBjb2RlIGJ5IGNhbGxpbmcgdHN0X2V4aXQoKSBmdW5jdGlvbi4gICAg
ICAgKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogSW5wdXQ6ICAgICAgIE5vbmUuCQkJCQkJCSAqLwov
KgkJCQkJCQkJCSAgICAqLwovKiBPdXRwdXQ6ICAgICAgTm9uZS4JCQkJCQkJICovCi8qCQkJCQkJ
CQkJICAgICovCi8qIFJldHVybjogICAgICBPbiBmYWlsdXJlIC0gRXhpdHMgY2FsbGluZyB0c3Rf
ZXhpdCgpLiBOb24gJzAnIHJldHVybiBjb2RlLiAgICovCi8qCSAgICAgIE9uIHN1Y2Nlc3MgLSBF
eGl0cyBjYWxsaW5nIHRzdF9leGl0KCkuIFdpdGggJzAnIHJldHVybiBjb2RlLiAgKi8KLyoJCQkJ
CQkJCQkgICAgKi8KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KZXh0ZXJuIHZvaWQgY2xlYW51cCgp
IHsKCglURVNUX0NMRUFOVVA7Cgl0c3Rfcm1kaXIoKTsKCn0KCi8qIExvY2FsICBGdW5jdGlvbnMg
Ki8KLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKi8KLyoJCQkJCQkJCQkgICAgKi8KLyogRnVuY3Rpb246
ICAgIHNldHVwCQkJCQkJCSAqLwovKgkJCQkJCQkJCSAgICAqLwovKiBEZXNjcmlwdGlvbjogUGVy
Zm9ybXMgYWxsIG9uZSB0aW1lIHNldHVwIGZvciB0aGlzIHRlc3QuIFRoaXMgZnVuY3Rpb24gaXMg
ICAqLwovKgkgICAgICB0eXBpY2FsbHkgdXNlZCB0byBjYXB0dXJlIHNpZ25hbHMsIGNyZWF0ZSB0
ZW1wb3JhcnkgZGlycyAgICAgICovCi8qCSAgICAgIGFuZCB0ZW1wb3JhcnkgZmlsZXMgdGhhdCBt
YXkgYmUgdXNlZCBpbiB0aGUgY291cnNlIG9mIHRoaXMgICAgKi8KLyoJICAgICAgdGVzdC4JCQkJ
CQkJICovCi8qCQkJCQkJCQkJICAgICovCi8qIElucHV0OiAgICAgICBOb25lLgkJCQkJCQkgKi8K
LyoJCQkJCQkJCQkgICAgKi8KLyogT3V0cHV0OiAgICAgIE5vbmUuCQkJCQkJCSAqLwovKgkJCQkJ
CQkJCSAgICAqLwovKiBSZXR1cm46ICAgICAgT24gZmFpbHVyZSAtIEV4aXRzIGJ5IGNhbGxpbmcg
Y2xlYW51cCgpLgkJICAgICAgKi8KLyoJICAgICAgT24gc3VjY2VzcyAtIHJldHVybnMgMC4JCQkJ
ICAgICAgICovCi8qCQkJCQkJCQkJICAgICovCi8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCnZvaWQg
c2V0dXAoKSB7CgkvKiBDYXB0dXJlIHNpZ25hbHMgaWYgYW55ICovCglhY3Quc2FfaGFuZGxlciA9
IHNpZ2hhbmRsZXI7CglzaWdmaWxsc2V0KCZhY3Quc2FfbWFzayk7CglzaWdhY3Rpb24oU0lHSU5U
LCAmYWN0LCBOVUxMKTsKCgkvKiBDcmVhdGUgdGVtcG9yYXJ5IGRpcmVjdG9yaWVzICovCglURVNU
X1BBVVNFOwoJdHN0X3RtcGRpcigpOwp9CgovKgogKiBNYWNyb3MKICovCiNkZWZpbmUgU1lTQ0FM
TF9OQU1FICAgICJjbG9ja19uYW5vc2xlZXAiCgplbnVtIHRlc3RfdHlwZSB7CgkJTk9STUFMLAoJ
CU5VTExfUE9JTlRFUiwKCQlTRU5EX1NJR0lOVCwKfTsKCi8qCiAqIERhdGEgU3RydWN0dXJlCiAq
LwpzdHJ1Y3QgdGVzdF9jYXNlIHsKCWNsb2NraWRfdCBjbGtfaWQ7CglpbnQgdHR5cGU7CglpbnQg
ZmxhZ3M7Cgl0aW1lX3Qgc2VjOwoJbG9uZyBuc2VjOwoJaW50IHJldDsKCWludCBlcnI7Cn07Cgov
KiBUZXN0IGNhc2VzCiAqCiAqICAgdGVzdCBzdGF0dXMgb2YgZXJyb3JzIG9uIG1hbiBwYWdlCiAq
CiAqICAgRUlOVFIJICAgICAgdiAoZnVuY3Rpb24gd2FzIGludGVycnVwdGVkIGJ5IGEgc2lnbmFs
KQogKiAgIEVJTlZBTAkgICAgIHYgKGludmFsaWQgdHZfbnNlYywgZXRjLikKICogICBFTk9UU1VQ
CSAgICBjYW4ndCBjaGVjayBiZWNhdXNlIG5vdCBzdXBwb3J0ZWQgY2xrX2lkIGdlbmVyYXRlcwog
KgkJICAgICAgRUlOVkFMCiAqLwoKc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2UgdGNhc2VbXSA9IHsK
CXsgLy8gY2FzZTAwCgkJLmNsa19pZAkgPSBDTE9DS19SRUFMVElNRSwKCQkudHR5cGUJICA9IE5P
Uk1BTCwKCQkuZmxhZ3MJICA9IDAsCgkJLnNlYwkgICAgPSAwLAoJCS5uc2VjCSAgID0gNTAwMDAw
MDAwLCAvLyA1MDBtc2VjCgkJLnJldAkgICAgPSAwLAoJCS5lcnIJICAgID0gMCwKCX0sCgl7IC8v
IGNhc2UwMQoJCS5jbGtfaWQJID0gQ0xPQ0tfTU9OT1RPTklDLAoJCS50dHlwZQkgID0gTk9STUFM
LAoJCS5mbGFncwkgID0gMCwKCQkuc2VjCSAgICA9IDAsCgkJLm5zZWMJICAgPSA1MDAwMDAwMDAs
IC8vIDUwMG1zZWMKCQkucmV0CSAgICA9IDAsCgkJLmVycgkgICAgPSAwLAoJfSwKCXsgLy8gY2Fz
ZTAyCgkJLnR0eXBlCSAgPSBOT1JNQUwsCgkJLmNsa19pZAkgPSBDTE9DS19SRUFMVElNRSwKCQku
ZmxhZ3MJICA9IDAsCgkJLnNlYwkgICAgPSAwLAoJCS5uc2VjCSAgID0gLTEsICAgLy8gaW52YWxp
ZAoJCS5yZXQJICAgID0gRUlOVkFMLAoJCS5lcnIJICAgID0gMCwKCX0sCgl7IC8vIGNhc2UwMwoJ
CS50dHlwZQkgID0gTk9STUFMLAoJCS5jbGtfaWQJID0gQ0xPQ0tfUkVBTFRJTUUsCgkJLmZsYWdz
CSAgPSAwLAoJCS5zZWMJICAgID0gMCwKCQkubnNlYwkgICA9IDEwMDAwMDAwMDAsICAgLy8gaW52
YWxpZAoJCS5yZXQJICAgID0gRUlOVkFMLAoJCS5lcnIJICAgID0gMCwKCX0sCgl7IC8vIGNhc2Uw
NAoJCS50dHlwZQkgID0gTk9STUFMLAoJCS5jbGtfaWQJID0gQ0xPQ0tfVEhSRUFEX0NQVVRJTUVf
SUQsIC8vIG5vdCBzdXBwb3J0ZWQKCQkuZmxhZ3MJICA9IDAsCgkJLnNlYwkgICAgPSAwLAoJCS5u
c2VjCSAgID0gNTAwMDAwMDAwLCAvLyA1MDBtc2VjCgkJLnJldAkgICAgPSBFSU5WQUwsIC8vIFJI
RUw0VTEgKyAyLjYuMTggcmV0dXJucyBFSU5WQUwKCQkuZXJyCSAgICA9IDAsCgl9LAoJeyAvLyBj
YXNlMDUKCQkudHR5cGUJICA9IFNFTkRfU0lHSU5ULAoJCS5jbGtfaWQJID0gQ0xPQ0tfUkVBTFRJ
TUUsCgkJLmZsYWdzCSAgPSAwLAoJCS5zZWMJICAgID0gMTAsCgkJLm5zZWMJICAgPSAwLAoJCS5y
ZXQJICAgID0gRUlOVFIsCgkJLmVycgkgICAgPSAwLAoJfSwKI2lmIDAgICAvLyBnbGliYyBnZW5l
cmF0ZXMgU0VHViBlcnJvciAoUkhFTDRVMSArIDIuNi4xOCkKCXsgLy8gY2FzZVhYCgkJLnR0eXBl
CSAgPSBOVUxMX1BPSU5URVIsCgkJLmNsa19pZAkgPSBDTE9DS19SRUFMVElNRSwKCQkuZmxhZ3MJ
ICA9IDAsCgkJLnNlYwkgICAgPSAwLAoJCS5uc2VjCSAgID0gNTAwMDAwMDAwLCAvLyA1MDBtc2Vj
CgkJLnJldAkgICAgPSBFRkFVTFQsCgkJLmVycgkgICAgPSAwLAoJfSwKI2VuZGlmCn07CgovKgog
KiBjaGtfZGlmZnRpbWUoKQogKiAgIFJldHVybiA6IE9LKDApLCBORygtMSkKICovCiNkZWZpbmUg
TUFYX01TRUNfRElGRiAgIDIwCgpzdGF0aWMgaW50IGNoa19kaWZmdGltZShzdHJ1Y3QgdGltZXNw
ZWMgKmJlZiwgc3RydWN0IHRpbWVzcGVjICphZnQsCgkJCXRpbWVfdCBzZWMsIGxvbmcgbnNlYykK
eyAgcHJpbnRmKCJcbi0tLS0tLS0tLWxvZzEtLS0tLS0tLVxuIik7CglzdHJ1Y3QgdGltZXNwZWMg
dDsKCXRpbWVfdCBleHBlY3Q7Cgl0aW1lX3QgcmVzdWx0OwoKCXQudHZfc2VjID0gYWZ0LT50dl9z
ZWMgLSBiZWYtPnR2X3NlYzsKCXQudHZfbnNlYyA9IGFmdC0+dHZfbnNlYyAtIGJlZi0+dHZfbnNl
YzsKCWlmICh0LnR2X25zZWMgPCAwKSB7CgkJdC50dl9zZWMgLT0gMTsKCQl0LnR2X25zZWMgKz0g
MTAwMDAwMDAwMDsKCX0KCWV4cGVjdCA9IChzZWMgKiAxMDAwKSArIChuc2VjIC8gMTAwMDAwMCk7
CglyZXN1bHQgPSAodC50dl9zZWMgKiAxMDAwKSArICh0LnR2X25zZWMgLyAxMDAwMDAwKTsKCXRz
dF9yZXNtKFRJTkZPLCJjaGVjayBzbGVlcCB0aW1lOiAobWluOiVsZCkgPCAlbGQgPCAobWF4OiVs
ZCkgKG1zZWMpIixleHBlY3QgLSBNQVhfTVNFQ19ESUZGLCByZXN1bHQsIGV4cGVjdCArIE1BWF9N
U0VDX0RJRkYpOwoJaWYgKHJlc3VsdCA8IGV4cGVjdCAtIE1BWF9NU0VDX0RJRkYgfHwgcmVzdWx0
ID4gZXhwZWN0ICsgTUFYX01TRUNfRElGRil7CnByaW50ZigiXG4tLS0tLS0tLS1sb2cyLS0tLS0t
LS1cbiIpOwoJCXJldHVybiAtMTsKfQoJcmV0dXJuIDA7Cn0KCi8qCiAqIGRvX3Rlc3QoKQogKgog
KiAgIElucHV0ICA6IFRlc3RDYXNlIERhdGEKICogICBSZXR1cm4gOiBSRVNVTFRfT0soMCksIFJF
U1VMVF9ORygxKQogKgogKi8Kc3RhdGljIGludCBkb190ZXN0KHN0cnVjdCB0ZXN0X2Nhc2UgKnRj
KQp7CglpbnQgc3lzX3JldDsKCWludCBzeXNfZXJybm87CglpbnQgcmVzdWx0ID0gUkVTVUxUX09L
OwoJc3RydWN0IHRpbWVzcGVjIGJlZnRwLCBhZnR0cCwgcnEsIHJtOwoJaW50IHJjLCByYW5nZV9v
ayA9IDEsIHJlbWFpbl9vayA9IDE7CglwaWRfdCBwaWQgPSAwOwpwcmludGYoIlxuLS0tLS0tbG9n
MTAtLS0tLVxuIik7CgkgLyoKCSAqIENoZWNrIGJlZm9yZSBzbGVlcCB0aW1lCgkgKi8KCWlmICh0
Yy0+dHR5cGUgPT0gU0VORF9TSUdJTlQpIHsKcHJpbnRmKCJcbi0tLS0tLWxvZzExLS0tLS1cbiIp
OwoJCXBpZCA9IGNyZWF0ZV9zaWdfcHJvYyg1MDAwMDAsIFNJR0lOVCwgVUlOVF9NQVgpOwoJcHJp
bnRmKCJcbi0tLXJldHVybiB2YWx1ZTQtLS0lZFxuIixwaWQpOwoJaWYgKHBpZCA8IDApewpwcmlu
dGYoIlxuLS0tLS0tbG9nMTItLS0tLVxuIik7CQkJCnJldHVybiAxOwp9Cgl9CgoJLyoKCSAqIENo
ZWNrIGJlZm9yZSBzbGVlcCB0aW1lCgkgKi8KCVRFU1QocmMgPSBjbG9ja19nZXR0aW1lKHRjLT5j
bGtfaWQsICZiZWZ0cCkpOwoJaWYgKHJjIDwgMCkgewpwcmludGYoIlxuLS0tLS0tLS0tbG9nMy0t
LS0tLS0tXG4iKTsKCQl0c3RfcmVzbShURkFJTHxUVEVSUk5PLCAiaWNsb2NrX2dldHRpbWUgZmFp
bGVkIik7CgkJcmVzdWx0ID0gMTsgCgoJCWdvdG8gRVhJVDsKCX0KCSAvKgoJICogRXhlY3V0ZSBz
eXN0ZW0gY2FsbAoJICovCglycS50dl9zZWMgPSB0Yy0+c2VjOwoJcnEudHZfbnNlYyA9IHRjLT5u
c2VjOwoJLy8gISEhQ0FVVElPTjogJ2Nsb2NrX2dldHRpbWUnIHJldHVybnMgZXJybm8gaXRzZWxm
CgllcnJubyA9IDA7CglpZiAodGMtPnR0eXBlID09IE5VTExfUE9JTlRFUikKewkJcHJpbnRmKCJc
bi0tLS0tLS0tLWxvZzQtLS0tLS0tLVxuIik7ClRFU1Qoc3lzX3JldCA9IGNsb2NrX25hbm9zbGVl
cCh0Yy0+Y2xrX2lkLCB0Yy0+ZmxhZ3MsIE5VTEwsICZybSkpOwpwcmludGYoIlxuLS0tcmV0dXJu
IHZhbHVlMy0tLSVkXG4iLHN5c19yZXQpOwp9CQplbHNlCgl7CXByaW50ZigiXG4tLS1yZXR1cm4g
dmFsdWUyLS0tJWQgJWQgJWQgXG4iLHN5c19yZXQscnEudHZfc2VjLHJxLnR2X25zZWMpOwpURVNU
KHN5c19yZXQgPSBjbG9ja19uYW5vc2xlZXAodGMtPmNsa19pZCwgdGMtPmZsYWdzLCAmcnEsICZy
bSkpOwpwcmludGYoIi0tLS0tLS0tLS0tLS0tU1lTUkVUPSVkXG4tLS0tLS0tLS0tLS0tLS0tLS0t
LS0iLHN5c19yZXQpOwp9CQpzeXNfZXJybm8gPSBlcnJubzsKcHJpbnRmKCItLS0tLWVycm5vLS0t
LS0lZC0tLS0tLS0tLVxuIixlcnJubyk7CgoKCWlmIChzeXNfcmV0ICE9IDApCntwcmludGYoIlxu
LS0tLS0tLS0tbG9nNS0tLS0tLS0tXG4iKTsKCQlnb3RvIFRFU1RfRU5EOwoKfQkgLyoKCSAqIENo
ZWNrIGFmdGVyIHNsZWVwIHRpbWUKCSAqLwoJVEVTVChyYyA9IGNsb2NrX2dldHRpbWUodGMtPmNs
a19pZCwgJmFmdHRwKSk7CglpZiAoVEVTVF9SRVRVUk4gPCAwKSB7CnByaW50ZigiXG4tLS0tLS0t
LS1sb2c2LS0tLS0tLS1cbiIpOwoJCUVQUklOVEYoImNsb2NrX2dldHRpbWUgZmFpbGVkLlxuIik7
CgkJcmVzdWx0ID0gMTsKCgkJZ290byBFWElUOwoJfQoJcmFuZ2Vfb2sgPSBjaGtfZGlmZnRpbWUo
JmJlZnRwLCAmYWZ0dHAsIHRjLT5zZWMsIHRjLT5uc2VjKSA9PSAwOwoJLyoKCSAqIENoZWNrIHJl
bWFpbmluZyB0aW1lCgkgKi8KVEVTVF9FTkQ6CglpZiAodGMtPnR0eXBlID09IE5PUk1BTCB8fCB0
Yy0+dHR5cGUgPT0gU0VORF9TSUdJTlQpIHsKcHJpbnRmKCJcbi0tLS0tLS0tLWxvZzEyLS0tLS0t
LS1cbiIpOwoJCXRzdF9yZXNtKFRJTkZPLCJyZW1haW4gdGltZTogJWxkICVsZCIsIHJtLnR2X3Nl
Yywgcm0udHZfbnNlYyk7CgkJaWYgKHRjLT50dHlwZSA9PSBOT1JNQUwpCnsJcHJpbnRmKCJcbi0t
LS0tLS0tLWxvZzctLS0tLS0tLVxuIik7CQkKcmVtYWluX29rID0gMTsKfQoJCWVsc2UKeyAgcHJp
bnRmKCJcbi0tLS0tLS0tLWxvZzEzLS0tLS0tLS1cbiIpOwoJCQlyZW1haW5fb2sgPSBybS50dl9z
ZWMgIT0gMCB8fCBybS50dl9uc2VjICE9IDA7Cn0KCX0KCgkvKgoJICogQ2hlY2sgcmVzdWx0cwoJ
ICovCnByaW50ZigiXG4tLS0lZC0tLS0tLVxuIixyZXN1bHQpOwpwcmludGYoIlxuLSVkICVkICVk
ICVkXG5cbiIsKHN5c19yZXQpLCh0Yy0+cmV0KSAsKCFyYW5nZV9vaykgLCAoIXJlbWFpbl9vaykp
OwoJcmVzdWx0IHw9IChlcnJubyAhPSB0Yy0+cmV0KSB8fCAhcmFuZ2Vfb2sgfHwgIXJlbWFpbl9v
azsKcHJpbnRmKCJcbi0tLS0tLSVkLS0tLS1cbiIscmVzdWx0KTsKCWlmICghcmFuZ2Vfb2spCgkJ
ewpwcmludGYoIlxuLS0tLS0tLS0tbG9nMTQtLS0tLS0tLVxuIik7ClBSSU5UX1JFU1VMVF9FWFRS
QSgwLCB0Yy0+cmV0LCB0Yy0+ZXJyLCBzeXNfcmV0LCBzeXNfZXJybm8sCgkJCSJ0aW1lIHJhbmdl
IGNoZWNrIiwgcmFuZ2Vfb2spOwpwcmludGYoIlxuLS0tLS0tLS0tbG9nOC0tLS0tLS0tXG4iKTsK
fQoJZWxzZQp7CQpwcmludGYoIlxuLS0tLS0tLS0tbG9nOS0tLS0tLS0tXG4iKTsJClBSSU5UX1JF
U1VMVF9FWFRSQSgwLCB0Yy0+cmV0LCB0Yy0+ZXJyLCBzeXNfcmV0LCBzeXNfZXJybm8sCgkJCSJy
ZW1haW4gdGltZSBjaGVjayIsIHJlbWFpbl9vayk7Cgp9CkVYSVQ6CglpZiAocGlkID4gMCkgewoJ
CWludCBzdDsKCQlURVNUKGtpbGwocGlkLCBTSUdURVJNKSk7CgkJVEVTVCh3YWl0KCZzdCkpOwoJ
fQoJcmV0dXJuIHJlc3VsdDsKfQoKLyoKICogbWFpbigpCiAqLwoKaW50IG1haW4oaW50IGFjLCBj
aGFyICoqYXYpIHsKCWludCByZXN1bHQgPSBSRVNVTFRfT0s7CglpbnQgaTsKCWludCBsYzsKCWNo
YXIgKm1zZzsKCglpZiAoKG1zZyA9IHBhcnNlX29wdHMoYWMsIGF2LCBOVUxMLCBOVUxMKSkgIT0g
TlVMTCkKCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMi
LCBtc2cpOwoKCXNldHVwKCk7CgoJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7ICsrbGMp
IHsKCgkJVHN0X2NvdW50ID0gMDsKCgkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9U
QUw7ICsrdGVzdG5vKSB7CgoJCQlmb3IgKGkgPSAwOyBpIDwgKGludCkoc2l6ZW9mKHRjYXNlKSAv
IHNpemVvZih0Y2FzZVswXSkpOyBpKyspIHsKCQkJCWludCByZXQ7CgkJCQl0c3RfcmVzbShUSU5G
TywiKGNhc2UlMDJkKSBTVEFSVCIsIGkpOwpwcmludGYoIlxuLS0tLS0tLS0tbG9nMTUtLS0tLS0t
LVxuIik7CgkJCQlyZXQgPSBkb190ZXN0KCZ0Y2FzZVtpXSk7CnByaW50ZigiXG4tLS0tLS1yZXR1
cm4gdmFsdWUxLS0tICVkXG4iLHJldCk7CgkJCQl0c3RfcmVzbShUSU5GTywiKGNhc2UlMDJkKSBF
TkQgPT4gJXMiLAoJCQkJCWksIChyZXQgPT0gMCkgPyAiT0siIDogIk5HIik7CgkJCQlyZXN1bHQg
fD0gcmV0OwoJCQl9CgoJCQlzd2l0Y2ggKHJlc3VsdCkgewoJCQljYXNlIFJFU1VMVF9PSzoKCQkJ
CXRzdF9yZXNtKFRQQVNTLCAiY2xvY2tfbmFub3NsZWVwIGNhbGwgc3VjY2VlZGVkIik7CgkJCQli
cmVhazsKCgkJCWRlZmF1bHQ6CgkgCSAgIAkJdHN0X2Jya20oVEZBSUx8VEVSUk5PLCBjbGVhbnVw
LCAiY2xvY2tfbmFub3NsZWVwIGZhaWxlZCIpOwoJCQkJYnJlYWs7CgkJCX0KCgkJfQoKCX0KCglj
bGVhbnVwKCk7Cgl0c3RfZXhpdCgpOwoKfQo=

--_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_002_2316A524B7DB8C4AB39B9EDEDF597C8F015B606E6C04EXGMBX01sas_--

