Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N1S1k-0001hu-EA
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 21:50:28 +0000
Received: from mail-ew0-f215.google.com ([209.85.219.215])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N1S1Y-0002eF-RR
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 21:50:23 +0000
MIME-Version: 1.0
In-Reply-To: <364299f40910230844n7650eb82y1deb56b062e809a8@mail.gmail.com>
References: <4AE19E86.8070100@linux.vnet.ibm.com>
	<364299f40910230844n7650eb82y1deb56b062e809a8@mail.gmail.com>
Date: Fri, 23 Oct 2009 14:50:10 -0700
Message-ID: <364299f40910231450l36536a7blc395fa95c7bddc37@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e6dab0562d0ab00476a1327e
Subject: Re: [LTP] [PATCH] realtime: fix broken build configuration files
	and warnings
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

--0016e6dab0562d0ab00476a1327e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2009 at 8:44 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Oct 23, 2009 at 5:16 AM, gowrishankar
> <gomuthuk@linux.vnet.ibm.com> wrote:
>> Hi Subrata,
>> Please accept the patch below.
>>
>> Thanks,
>> Gowri
>
> =A0 =A0I'll get back to you on this in a day Gowri... there are some
> things I wanted to note.

Hi Gowri,
    I've reviewed the changes and checked in the ones that were OK,
and definitely needed to be fixed. There are a few items that I'm
unsure about with your proposed changes in the Makefiles that need to
be discussed:
1. I'm trying to make sure that out-of-build-tree functionality isn't
broken. In order to do that, as you see I had to use abs_builddir and
abs_srcdir, instead of just realtimedir.
2. config.mk shouldn't be included by lib/Makefile -- otherwise I have
to add LDLIBS +=3D -lrealtime to all Makefiles that require that
library. So by virtue of laziness and keeping things common, it's best
just to add the required variables and includes in lib/Makefile.
    This patch has been attached as realtime-makefile-fixes.diff.
    Now, for the other part that I don't agree with 100%, but I agree
needs fixing:

Index: func/pi-tests/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/realtime/func/pi-tests/Makefile,v
retrieving revision 1.2
diff -u -r1.2 Makefile
--- func/pi-tests/Makefile      9 Oct 2009 17:56:07 -0000       1.2
+++ func/pi-tests/Makefile      23 Oct 2009 21:36:02 -0000
@@ -24,4 +24,15 @@

 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk
+
+MAKE_TARGETS           :=3D testpi-0
+
+ifeq ($(HAVE_PI_MUTEX), yes)
+MAKE_TARGETS           +=3D testpi-1 testpi-2 testpi-4 testpi-5 testpi-7
+endif
+
+ifeq ($(HAVE_ROBUST_MUTEX), yes)
+MAKE_TARGETS           +=3D testpi-6 sbrk_mutex
+endif
+

    I agree that these should be toggable or built appropriate to
whether or not the system has this kind of functionality. The method
used to determine whether or not a system has this functionality is
questionable though, and I believe all of this can be established
through additional autoconf tests added to the $(abs_top_srcdir)/m4 --
do you agree with this?
    Is the realtime test suite this made available as a separate
package outside of LTP in-house at IBM, or is it strictly available
with LTP?
    Once these build integration issues are resolved, should it be
enabled by default, or still remain an optional package to build and
execute?
    Should this component have a runtest file as well so it can be
integrated into the execution portion of LTP?
    Finally, I also discovered some QA issues with rt-migrate.c (diff
attached as well); I patterned the code to match the other tests. Do
you agree with the fixes?
Thanks!
-Garrett

--0016e6dab0562d0ab00476a1327e
Content-Type: application/octet-stream; name="realtime-makefile-fixes.diff"
Content-Disposition: attachment; filename="realtime-makefile-fixes.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g15guj1m0

SW5kZXg6IGNvbmZpZy5tawo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3Rl
c3RjYXNlcy9yZWFsdGltZS9jb25maWcubWssdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuOApkaWZm
IC11IC1yMS44IGNvbmZpZy5tawotLS0gY29uZmlnLm1rCTkgT2N0IDIwMDkgMTc6NTY6MDcgLTAw
MDAJMS44CisrKyBjb25maWcubWsJMjMgT2N0IDIwMDkgMjE6Mjk6MjEgLTAwMDAKQEAgLTIyLDcg
KzIyLDEzIEBACiAKIAogIyBEZWZhdWx0IHN0dWZmIGNvbW1vbiB0byBhbGwgdGVzdGNhc2VzCisj
CisjIFRISVMgSVMgTk9UIFRPIEJFIElOQ0xVREVEIFdJVEggbGliISEhCiAKLUNQUEZMQUdTICs9
IC1JJChhYnNfdG9wX3NyY2RpcikvdGVzdGNhc2VzL3JlYWx0aW1lL2luY2x1ZGUgLURfR05VX1NP
VVJDRQotQ0ZMQUdTICAgKz0gLVdhbGwKLUxETElCUyAgICs9IC1scmVhbHRpbWUgLWxwdGhyZWFk
IC1scnQgLWxtCityZWFsdGltZV9idWlsZGRpcgk6PSAkKGFic190b3BfYnVpbGRkaXIpL3Rlc3Rj
YXNlcy9yZWFsdGltZQorcmVhbHRpbWVfc3JjZGlyCQk6PSAkKGFic190b3Bfc3JjZGlyKS90ZXN0
Y2FzZXMvcmVhbHRpbWUKKworQ1BQRkxBR1MJCSs9IC1JJChyZWFsdGltZV9zcmNkaXIpL2luY2x1
ZGUKK0NGTEFHUwkJCSs9IC1EX0dOVV9TT1VSQ0UKK0xETElCUwkJCSs9IC1scmVhbHRpbWUgLWxw
dGhyZWFkIC1scnQgLWxtCitMREZMQUdTCQkJKz0gLUwkKHJlYWx0aW1lX2J1aWxkZGlyKS9saWIK
SW5kZXg6IGxpYi9NYWtlZmlsZQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRw
L3Rlc3RjYXNlcy9yZWFsdGltZS9saWIvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
NApkaWZmIC11IC1yMS40IE1ha2VmaWxlCi0tLSBsaWIvTWFrZWZpbGUJOSBPY3QgMjAwOSAxNzo1
NjowOCAtMDAwMAkxLjQKKysrIGxpYi9NYWtlZmlsZQkyMyBPY3QgMjAwOSAyMToyOToyMSAtMDAw
MApAQCAtMjQsNiArMjQsMTIgQEAKIAogaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsv
ZW52X3ByZS5tawogCitDUFBGTEFHUwkJKz0gLUkkKGFic19zcmNkaXIpLy4uL2luY2x1ZGUKKwor
Q0ZMQUdTCQkJKz0gLURfR05VX1NPVVJDRQorCitMRExJQlMJCQkrPSAtbHJlYWx0aW1lIC1scHRo
cmVhZCAtbHJ0IC1sbQorCiBMSUIJCQk6PSBsaWJyZWFsdGltZS5hCiAKLWluY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKK2luY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL2xpYi5tawo=
--0016e6dab0562d0ab00476a1327e
Content-Type: application/octet-stream; name="realtime-rt-migrate-fixes.diff"
Content-Disposition: attachment; filename="realtime-rt-migrate-fixes.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g15gv0ut1

SW5kZXg6IGZ1bmMvcnQtbWlncmF0ZS9ydC1taWdyYXRlLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTog
L2N2c3Jvb3QvbHRwL2x0cC90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9ydC1taWdyYXRlL3J0LW1p
Z3JhdGUuYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xCmRpZmYgLXUgLXIxLjEgcnQtbWlncmF0
ZS5jCi0tLSBmdW5jL3J0LW1pZ3JhdGUvcnQtbWlncmF0ZS5jCTcgU2VwIDIwMDkgMDg6NTk6MTAg
LTAwMDAJMS4xCisrKyBmdW5jL3J0LW1pZ3JhdGUvcnQtbWlncmF0ZS5jCTIzIE9jdCAyMDA5IDIx
OjI5OjU1IC0wMDAwCkBAIC00Niw3ICs0Niw5IEBACiAgKiAgICAgICAgICAgICAgICAgICAgdGVz
dGNhc2VzIGJ5IEtpcmFuIFByYWthc2gKICAqCiAgKi8KKyNpZm5kZWYgX0dOVV9TT1VSQ0UKICNk
ZWZpbmUgX0dOVV9TT1VSQ0UKKyNlbmRpZgogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaWZuZGVmIF9f
VVNFX1hPUEVOMksKICMgZGVmaW5lIF9fVVNFX1hPUEVOMksKQEAgLTExNiw3ICsxMTgsMTMgQEAK
IAluID0gdnNucHJpbnRmKGJ1ZmYsIEJVRlNJWiwgZm10LCBhcCk7CiAJdmFfZW5kKGFwKTsKIAot
CXdyaXRlKG1hcmtfZmQsIGJ1ZmYsIG4pOworCS8qCisJICogVGhpcyBkb2Vzbid0IHJldHVybiBh
bnkgdmFsaWQgdnMgaW52YWxpZCBleGl0IGNvZGVzLCBzbyBwcmludGluZyBvdXQKKwkgKiBhIHBl
cnJvciB0byB3YXJuIHRoZSBlbmQtdXNlciBvZiBhbiBpc3N1ZSBpcyBzdWZmaWNpZW50LgorCSAq
LworCWlmICh3cml0ZShtYXJrX2ZkLCBidWZmLCBuKSA8IDApIHsKKwkJcGVycm9yKCJ3cml0ZSIp
OworCX0KIH0KIAogI2RlZmluZSBJTlRFUlZBTCAxMDBVTEwgKiBOU19QRVJfTVMKQEAgLTE4NSwy
MSArMTkzLDM1IEBACiAJICAgICAgKTsKIH0KIAotc3RhdGljIHZvaWQgcGFyc2VfYXJncyhpbnQg
YywgY2hhciAqdikKLXsKLQkJc3dpdGNoIChjKSB7Ci0JCWNhc2UgJ2EnOiBwcmlvX3N0YXJ0ID0g
YXRvaSh2KTsgYnJlYWs7Ci0JCWNhc2UgJ3InOgotCQkJcnVuX2ludGVydmFsID0gYXRvaSh2KTsK
LQkJCWJyZWFrOwotCQljYXNlICd0JzogaW50ZXJ2YWwgPSBhdG9pKHYpOyBicmVhazsKLQkJY2Fz
ZSAnbCc6IG5yX3J1bnMgPSBhdG9pKHYpOyBicmVhazsKLQkJY2FzZSAnZSc6IG1heF9lcnIgPSBh
dG9pKHYpICogTlNfUEVSX1VTOyBicmVhazsKLQkJY2FzZSAnPyc6Ci0JCWNhc2UgJ2gnOgotCQkJ
dXNhZ2UoKTsKLQkJCWV4aXQoMCk7Ci0JCX0KKy8qCitpbnQgcnRfaW5pdChjb25zdCBjaGFyICpv
cHRpb25zLCBpbnQgKCpwYXJzZV9hcmcpKGludCBvcHRpb24sIGNoYXIgKnZhbHVlKSwKKyAgICAg
ICAgICAgIGludCBhcmdjLCBjaGFyICphcmd2W10pOworICovCitzdGF0aWMgaW50IHBhcnNlX2Fy
Z3MoaW50IGMsIGNoYXIgKnYpCit7CisJaW50IGhhbmRsZWQgPSAxOworCXN3aXRjaCAoYykgewor
CWNhc2UgJ2EnOgorCQlwcmlvX3N0YXJ0ID0gYXRvaSh2KTsKKwkJYnJlYWs7CisJY2FzZSAncic6
CisJCXJ1bl9pbnRlcnZhbCA9IGF0b2kodik7CisJCWJyZWFrOworCWNhc2UgJ3QnOgorCQlpbnRl
cnZhbCA9IGF0b2kodik7CisJCWJyZWFrOworCWNhc2UgJ2wnOgorCQlucl9ydW5zID0gYXRvaSh2
KTsKKwkJYnJlYWs7CisJY2FzZSAnZSc6CisJCW1heF9lcnIgPSBhdG9pKHYpICogTlNfUEVSX1VT
OworCQlicmVhazsKKwljYXNlICc/JzoKKwljYXNlICdoJzoKKwkJdXNhZ2UoKTsKKwkJaGFuZGxl
ZCA9IDA7CisJfQorCXJldHVybiBoYW5kbGVkOwogfQogCiBzdGF0aWMgdm9pZCByZWNvcmRfdGlt
ZShpbnQgaWQsIHVuc2lnbmVkIGxvbmcgbG9uZyB0aW1lLCB1bnNpZ25lZCBsb25nIGwpCkBAIC0y
NDcsMTIgKzI2OSwxMiBAQAogCWZvciAoaSA9IDA7IGkgPCBucl9ydW5zOyBpKyspIHsKIAkJcHJp
bnRmKCIlNGQ6ICAgIiwgaSk7CiAJCWZvciAodCA9IDA7IHQgPCBucl90YXNrczsgdCsrKQotCQkJ
cHJpbnRmKCIlNmxsZCAgIiwgaW50ZXJ2YWxzW3RdLnJlY29yZHNbaV0ueSk7CisJCQlwcmludGYo
IiU2bGQgICIsIGludGVydmFsc1t0XS5yZWNvcmRzW2ldLnkpOwogCiAJCXByaW50ZigiXG4iKTsK
IAkJcHJpbnRmKCIgbGVuOiAgICIpOwogCQlmb3IgKHQgPSAwOyB0IDwgbnJfdGFza3M7IHQrKykK
LQkJCXByaW50ZigiJTZsbGQgICIsIGludGVydmFsc19sZW5ndGhbdF0ucmVjb3Jkc1tpXS55KTsK
KwkJCXByaW50ZigiJTZsZCAgIiwgaW50ZXJ2YWxzX2xlbmd0aFt0XS5yZWNvcmRzW2ldLnkpOwog
CiAJCXByaW50ZigiXG4iKTsKIAkJcHJpbnRmKCIgbG9vcHM6ICIpOwo=
--0016e6dab0562d0ab00476a1327e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--0016e6dab0562d0ab00476a1327e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e6dab0562d0ab00476a1327e--

