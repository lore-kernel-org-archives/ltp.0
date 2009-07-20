Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MT10e-0000le-3P
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 22:07:00 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT10Z-00074N-7x
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 22:07:00 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id B41DE1B100
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jul 2009 15:06:53 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA0986.567E2438"
Date: Mon, 20 Jul 2009 15:06:31 -0700
Message-ID: <8368651DACC1964480F951191B94A078EBA887@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] exit_group01, fix syscall number for exit_group
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA0986.567E2438
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This issue was found when running on an arm machine.


Fix syscall number for exit_group

<Signed-off-by: Henry Yei <hyei@mvista.com>

---
ltp-full-20090531/testcases/kernel/syscalls/exit_group/exit_group01.c
2009-05-21 11:14:40.000000000 -0700
+++
ltp-full-20090531/testcases/kernel/syscalls/exit_group/exit_group01.c
2009-07-17 12:03:47.000000000 -0700
@@ -136,7 +136,7 @@
                      } else if (TEST_RETURN =3D=3D 0){
 	                 	tst_resm(TINFO, "In the child process");
                            	sleep(5);
-				TEST(syscall(252,4));
+				TEST(syscall(__NR_exit_group,4));
                      }else {
 				tst_resm(TINFO,"in the parent process");
 				TEST(w =3D wait(&status));

--=20
Henry Yei <hyei@mvista.com>
MontaVista Software

------_=_NextPart_001_01CA0986.567E2438
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiAWAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPQAAAFtMVFBdW1BBVENIXSBleGl0
X2dyb3VwMDEsIGZpeCBzeXNjYWxsIG51bWJlciBmb3IgZXhpdF9ncm91cAC7FQEFgAMADgAAANkH
BwAUAA8ABgAfAAEAMAEBIIADAA4AAADZBwcAFAAPAAYAHwABADABAQmAAQAhAAAAQzhCNDVGODZB
N0M3RTM0NEEwQjE5RDdDNjczNkIzMTQANwcBA5AGAAgHAAAjAAAAAwA2AAAAAABAADkAOCR+VoYJ
ygECAUcAAQAAADoAAABjPVVTO2E9IDtwPUZpcnN0IE9yZ2FuaXphdGk7bD1TVkVYQ0gwMS0wOTA3
MjAyMjA2MzFaLTM3MzcAAAAeAHAAAQAAAD0AAABbTFRQXVtQQVRDSF0gZXhpdF9ncm91cDAxLCBm
aXggc3lzY2FsbCBudW1iZXIgZm9yIGV4aXRfZ3JvdXAAAAAAAgFxAAEAAAAWAAAAAcoJhlZ+3Mg9
VZRWT5+Z/ghilWgn6AAAHgAaDAEAAAAKAAAASGVucnkgWWVpAAAAHgAdDgEAAAA9AAAAW0xUUF1b
UEFUQ0hdIGV4aXRfZ3JvdXAwMSwgZml4IHN5c2NhbGwgbnVtYmVyIGZvciBleGl0X2dyb3VwAAAA
AAIBCRABAAAAgwIAAH8CAADDBAAATFpGdZIeXrcDAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAff/CoAC
pAPkBxMCgA/zAFAEVj8IVQeyESUOUQMBAgBjaOEKwHNldDIGAAbDESX2MwRGE7cwEiwRMwjvCfe2
OxgfDjA1ESIMYGMAUDMLCQFkMzYWUAumIFQaaAQAIAQBClAgd2GjBCACEHVuZB2QaAnwjCByHgAD
AG5nIAIgZiADkQrAbSAAwR0AbhxlLgqiCoQgdkZpeDggc3kE8AdAAyBudR8G0BKBAhAFwA7AaXRf
CwnACGBwIDo8U2lnESAAZC1vASAtYnkIOiBICfByeSBZQGVpIDxoeSWQQCxtdgQAAZAuBaBtPg0g
Oi0nkCA0bHRwLRRmdSHgLQHQMDkw8DUzMS8OsCZQIcAUEIhzL2sEkWVsLyGV5ynAIsgq2TAxJoAg
NCiyBi0o8CigMSAxMTrAMTQ6NDAuKMAuFdogLRA3KMAgNCsvYCfPHyjfKe8q/ywPLrEtMTehLXAy
OjAzLdA3Lg+pIENAQC6gMRwgLDUwbis3dDcwIDQgOM85ElwefSKwMoAdgAaQIChUAEVTVF9SRVRV
AFJOID09IDApvlwAADh0DII5Hzx0dCZQEl8YIHNtOtBJTkagTywgIkkDoHQeUKogH9FsHiBwA2Bj
B5B4cyIpGTA4fzzvPJJz4mwJ4HAoNUCWJ7A8kitELTriKCGVKA4xLDQeKUCWL4BEP0VNX19O/FJf
IshGaUHPOdU6Uzv8+009Pj0iC4A/YwqxCfAFQH9AH00/RTYH4DuwHaAi4CjiJiZRdHVzRocnNgrj
lwqAJS8mPk0CIWFWJkK7BgAkoHQdoBggIDR9WSAAHgA1EAEAAAA9AAAAPDgzNjg2NTFEQUNDMTk2
NDQ4MEY5NTExOTFCOTRBMDc4RUJBODg3QHN2ZXhjaDAxLm12aXN0YS5jb20+AAAAAAsA8hABAAAA
HwDzEAEAAACCAAAAWwBMAFQAUABdAFsAUABBAFQAQwBIAF0AIABlAHgAaQB0AF8AZwByAG8AdQBw
ADAAMQAsACAAZgBpAHgAIABzAHkAcwBjAGEAbABsACAAbgB1AG0AYgBlAHIAIABmAG8AcgAgAGUA
eABpAHQAXwBnAHIAbwB1AHAALgBFAE0ATAAAAAAACwD2EAAAAABAAAcw2Jp0VoYJygFAAAgwSHKM
VoYJygEDAPE/CQQAAB4A+D8BAAAACgAAAEhlbnJ5IFllaQAAAAIB+T8BAAAAZgAAAAAAAADcp0DI
wEIQGrS5CAArL+GCAQAAAAAAAAAvTz1GSVJTVCBPUkdBTklaQVRJT04vT1U9RklSU1QgQURNSU5J
U1RSQVRJVkUgR1JPVVAvQ049UkVDSVBJRU5UUy9DTj1IWUVJAAAAHgD6PwEAAAAVAAAAU3lzdGVt
IEFkbWluaXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAA
AC4AAAADAP0/5AQAAAMAGUAAAAAAAwAaQAAAAAAeADBAAQAAAAUAAABIWUVJAAAAAB4AMUABAAAA
BQAAAEhZRUkAAAAAHgA4QAEAAAAFAAAASFlFSQAAAAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8L
ACkAAAAAAAsAIwAAAAAAAwAGEIYRFPoDAAcQJAIAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUA
AABUSElTSVNTVUVXQVNGT1VORFdIRU5SVU5OSU5HT05BTkFSTU1BQ0hJTkVGSVhTWVNDQUxMTlVN
QkVSRk9SRVhJVEdST1VQPFNJR05FRC1PRkYtQlk6SEVOUllZRUk8SFlFSUBNAAAAAAIBfwABAAAA
PQAAADw4MzY4NjUxREFDQzE5NjQ0ODBGOTUxMTkxQjk0QTA3OEVCQTg4N0BzdmV4Y2gwMS5tdmlz
dGEuY29tPgAAAACptQICkAYADgAAAAEA/////yAAIAAAAAAAPQQCEoADAA4AAADZBwcAFAAPAAYA
HwABADABAhOAAwAOAAAA2QcHABQADwAGAB8AAQAwAQIQgAEAEwAAAGV4aXRfZ3JvdXAwMS5wYXRj
aADlBgIPgAYANQIAAC0tLSBsdHAtZnVsbC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2V4aXRfZ3JvdXAvZXhpdF9ncm91cDAxLmMJMjAwOS0wNS0yMSAxMToxNDo0MC4wMDAwMDAw
MDAgLTA3MDAKKysrIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZXhpdF9ncm91cC9leGl0X2dyb3VwMDEuYwkyMDA5LTA3LTE3IDEyOjAzOjQ3LjAwMDAwMDAwMCAt
MDcwMApAQCAtMTM2LDcgKzEzNiw3IEBACiAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgaWYg
KFRFU1RfUkVUVVJOID09IDApewogCSAgICAgICAgICAgICAgICAgCXRzdF9yZXNtKFRJTkZPLCAi
SW4gdGhlIGNoaWxkIHByb2Nlc3MiKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIAlzbGVl
cCg1KTsKLQkJCQlURVNUKHN5c2NhbGwoMjUyLDQpKTsKKwkJCQlURVNUKHN5c2NhbGwoX19OUl9l
eGl0X2dyb3VwLDQpKTsKICAgICAgICAgICAgICAgICAgICAgIH1lbHNlIHsKIAkJCQl0c3RfcmVz
bShUSU5GTywiaW4gdGhlIHBhcmVudCBwcm9jZXNzIik7CiAJCQkJVEVTVCh3ID0gd2FpdCgmc3Rh
dHVzKSk7CgANlAIFkAYAgAAAAAkAAAADACAOdQIAAAMAIQ4AAAAAAwD3DwAAAAACAfkPAQAAABAA
AABE8hasfXizSbwewaC1G5OzQAAHMNiadFaGCcoBQAAIMNiadFaGCcoBAwAFNwEAAAAeAAc3AQAA
ABMAAABleGl0X2dyb3VwMDEucGF0Y2gAAAMACzf/////Mx8=

------_=_NextPart_001_01CA0986.567E2438
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
------_=_NextPart_001_01CA0986.567E2438
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA0986.567E2438--

