Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M63oS-0000nc-4i
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 14:27:32 +0000
Received: from smtp106.biz.mail.re2.yahoo.com ([206.190.52.175])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M63oO-0002Kf-62
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 14:27:32 +0000
Date: Mon, 18 May 2009 18:34:48 +0800 (CST)
Message-Id: <20090518.183448.71103795.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Mon_May_18_18_34_48_2009_313)--"
Content-Transfer-Encoding: 7bit
Subject: [LTP] Fw: ptrace06 is not being compiled (temporary fix)
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

----Next_Part(Mon_May_18_18_34_48_2009_313)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Apparently-To: caiqian@cclom.cn via 74.6.114.35;
	Fri, 15 May 2009 01:47:17 -0700
X-Originating-IP: [72.14.220.153]
Authentication-Results: mta119.biz.mail.mud.yahoo.com  from=gmail.com;
	domainkeys=pass (ok); from=gmail.com; dkim=pass (ok)
Received: from 72.14.220.153  (EHLO fg-out-1718.google.com) (72.14.220.153)
	by mta119.biz.mail.mud.yahoo.com with SMTP;
	Fri, 15 May 2009 01:47:17 -0700
Received: by fg-out-1718.google.com with SMTP id 22so565410fge.12
	for <caiqian@cclom.cn>; Fri, 15 May 2009 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:date:message-id:subject
	:from:to:content-type;
	bh=aiQLWxcmVuVV9DJjyZhad0FjOiMndyByu7dShbAUJTA=;
	b=BWUv5drQrvk90fHU4IyjO9nVRCwIcD+mWS+0bqiCYwRDm8QK9Y6Qvl8ObxQl7sRtvo
	3tN/IwEkb7bjdet3ivU2SkE/XU5pW5GMIkxNqaV1fXr00cQolU+bZV5y463UMSeJ94O2
	tMc3vrgchX0fyGJjEmFFIEf/TNe7rUi+nHVjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:date:message-id:subject:from:to:content-type;
	b=pZq9OKLGwdUs6pTUq0aXaFWqsztAC/+wfaRpQM1Pt8N+TsGeO6Y180DgSbANB0GdNH
	bIm/9HFmrYNnI6a9hc2GMwuaGsYvEABhptxBycn9OdBORzWB9eL4m43xbcM0ouIsCKuR
	A9XHyJRy31ZadpJyqzb84/m7DSHXvyth0iAKg=
MIME-Version: 1.0
Received: by 10.86.90.2 with SMTP id n2mr3414468fgb.61.1242377235746; Fri, 15 
	May 2009 01:47:15 -0700 (PDT)
Date: Fri, 15 May 2009 14:17:15 +0530
Message-ID: <d51f89b0905150147r42311f55j349f23ccb59c4f6e@mail.gmail.com>
Subject: ptrace06 is not being compiled (temporary fix)
From: rohit verma <rohit.170309@gmail.com>
To: CAI Qian <caiqian@cclom.cn>
Content-Type: multipart/mixed; boundary=000e0cd25048d051730469ef7dab

--000e0cd25048d051730469ef7dab
Content-Type: multipart/alternative; boundary=000e0cd25048d0516a0469ef7da9

--000e0cd25048d0516a0469ef7da9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
PFA the patch which can be a possible solution to the compilation problems
that you had mentioned about regarding the ptrace06 compilation on PPC64 and
IA-64. I haven't tested on PPC64 and IA-64 as I do not have access to them.
Let me know if it work fine, and can be integrated into the LTP tree.

link to mailing list entry --

http://www.nabble.com/ptrace06-is-not-being-compiled-td23035203.html#a23328058

Regards,
rohit



-----------------------------
# uname -r
2.6.9-89.EL

# rpm -q glibc
glibc-2.3.4-2.43

# make
cc -I../../../../include -Wall    *ptrace06*.c  -L../../../../lib -lltp -o
*ptrace06*
In file included from *ptrace06*.c:25:
spawn_ptrace_child.h:97: error: `*PTRACE_GETSIGINFO*' undeclared here (not
in a function)
spawn_ptrace_child.h:97: error: nonconstant array index in initializer
spawn_ptrace_child.h:97: error: (near initialization for `strings')
spawn_ptrace_child.h:98: error: `*PTRACE_SETSIGINFO*' undeclared here (not
in a function)
spawn_ptrace_child.h:98: error: nonconstant array index in initializer
spawn_ptrace_child.h:98: error: (near initialization for `strings')
*ptrace06*.c:143: error: initializer element is not constant
*ptrace06*.c:143: error: (near initialization for
`test_cases[48].request')
...

--------------

--000e0cd25048d0516a0469ef7da9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>PFA the patch which can be a possible solution to th=
e compilation problems that you had mentioned about regarding the ptrace06 =
compilation on=A0PPC64 and IA-64. I haven&#39;t tested on=A0PPC64 and IA-64=
 as I do not have access to them. Let me know if it work fine, and can be i=
ntegrated into the LTP tree.</div>
<div><br></div><div>link to mailing list entry --</div><div><br></div><div>=
<a href=3D"http://www.nabble.com/ptrace06-is-not-being-compiled-td23035203.=
html#a23328058">http://www.nabble.com/ptrace06-is-not-being-compiled-td2303=
5203.html#a23328058</a><br>
</div><div><br></div><div>Regards,</div><div>rohit</div><div><br></div><div=
><br></div><div><br></div><div>-----------------------------</div><div><spa=
n class=3D"Apple-style-span" style=3D"border-collapse: collapse; font-famil=
y: verdana; -webkit-border-horizontal-spacing: 2px; -webkit-border-vertical=
-spacing: 2px; "><span># uname -r=A0</span><br>
<span>2.6.9-89.EL=A0</span><br><br><span># rpm -q glibc=A0</span><br><span>=
glibc-2.3.4-2.43=A0</span><br><br><span># make=A0</span><br><span>cc -I../.=
./../../include -Wall =A0 =A0<b class=3D"highlight" style=3D"background-ima=
ge: initial; background-repeat: initial; background-attachment: initial; -w=
ebkit-background-clip: initial; -webkit-background-origin: initial; backgro=
und-color: rgb(255, 255, 102); background-position: initial initial; ">ptra=
ce06</b>.c =A0-L../../../../lib -lltp -o=A0</span><br>
<span><b class=3D"highlight" style=3D"background-image: initial; background=
-repeat: initial; background-attachment: initial; -webkit-background-clip: =
initial; -webkit-background-origin: initial; background-color: rgb(255, 255=
, 102); background-position: initial initial; ">ptrace06</b>=A0</span><br>
<span>In file included from=A0<b class=3D"highlight" style=3D"background-im=
age: initial; background-repeat: initial; background-attachment: initial; -=
webkit-background-clip: initial; -webkit-background-origin: initial; backgr=
ound-color: rgb(255, 255, 102); background-position: initial initial; ">ptr=
ace06</b>.c:25:=A0</span><br>
<span>spawn_ptrace_child.h:97: error: `<b class=3D"highlight" style=3D"back=
ground-image: initial; background-repeat: initial; background-attachment: i=
nitial; -webkit-background-clip: initial; -webkit-background-origin: initia=
l; background-color: rgb(255, 255, 102); background-position: initial initi=
al; ">PTRACE_GETSIGINFO</b>&#39; undeclared here (not=A0</span><br>
<span>in a function)=A0</span><br><span>spawn_ptrace_child.h:97: error: non=
constant array index in initializer=A0</span><br><span>spawn_ptrace_child.h=
:97: error: (near initialization for `strings&#39;)=A0</span><br><span>spaw=
n_ptrace_child.h:98: error: `<b class=3D"highlight" style=3D"background-ima=
ge: initial; background-repeat: initial; background-attachment: initial; -w=
ebkit-background-clip: initial; -webkit-background-origin: initial; backgro=
und-color: rgb(255, 255, 102); background-position: initial initial; ">PTRA=
CE_SETSIGINFO</b>&#39; undeclared here (not=A0</span><br>
<span>in a function)=A0</span><br><span>spawn_ptrace_child.h:98: error: non=
constant array index in initializer=A0</span><br><span>spawn_ptrace_child.h=
:98: error: (near initialization for `strings&#39;)=A0</span><br><span><b c=
lass=3D"highlight" style=3D"background-image: initial; background-repeat: i=
nitial; background-attachment: initial; -webkit-background-clip: initial; -=
webkit-background-origin: initial; background-color: rgb(255, 255, 102); ba=
ckground-position: initial initial; ">ptrace06</b>.c:143: error: initialize=
r element is not constant=A0</span><br>
<span><b class=3D"highlight" style=3D"background-image: initial; background=
-repeat: initial; background-attachment: initial; -webkit-background-clip: =
initial; -webkit-background-origin: initial; background-color: rgb(255, 255=
, 102); background-position: initial initial; ">ptrace06</b>.c:143: error: =
(near initialization for=A0</span><br>
<span>`test_cases[48].request&#39;)=A0</span><br><span>...=A0</span></span>=
<br></div><div><span class=3D"Apple-style-span" style=3D"border-collapse: c=
ollapse; font-family: verdana; -webkit-border-horizontal-spacing: 2px; -web=
kit-border-vertical-spacing: 2px;"><br>
</span></div><div><span class=3D"Apple-style-span" style=3D"border-collapse=
: collapse; font-family: verdana; -webkit-border-horizontal-spacing: 2px; -=
webkit-border-vertical-spacing: 2px;">--------------</span></div>

--000e0cd25048d0516a0469ef7da9--

--000e0cd25048d051730469ef7dab
Content-Type: text/plain; charset=US-ASCII; name="ptrace06_txt.txt"
Content-Disposition: attachment; filename="ptrace06_txt.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuqn35ib0

ZGlmZiAtcnV4QiBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcHRyYWNlL01ha2VmaWxlIGx0cC1mdWxsLTIwMDkwNDMwL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHRyYWNlL01ha2VmaWxlCi0tLSBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL01ha2VmaWxlCTIwMDgtMTAtMTUgMjI6Mzc6MzYuMDAw
MDAwMDAwICswNTMwCisrKyBsdHAtZnVsbC0yMDA5MDQzMC90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3B0cmFjZS9NYWtlZmlsZQkyMDA5LTA3LTE1IDA4OjUwOjM3LjAwMDAwMDAwMCArMDUzMApA
QCAtMTksNyArMTksOCBAQAogQ0ZMQUdTICs9IC1JLi4vLi4vLi4vLi4vaW5jbHVkZSAtV2FsbAog
TERMSUJTICs9IC1MLi4vLi4vLi4vLi4vbGliIC1sbHRwCiAKLVNSQ1MgICAgPSAkKHdpbGRjYXJk
ICpbXjZdLmMpCisjU1JDUyAgICA9ICQod2lsZGNhcmQgKlteNl0uYykKK1NSQ1MgICAgPSAkKHdp
bGRjYXJkICouYykKIFRBUkdFVFMgPSAkKHBhdHN1YnN0IHB0cmFjZSUuYyxwdHJhY2UlLCQoU1JD
UykpCiAKIGFsbDogJChUQVJHRVRTKQpkaWZmIC1ydXhCIGx0cC1mdWxsLTIwMDkwNDMwX29yaWcv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2UvcHRyYWNlMDYuYyBsdHAtZnVsbC0yMDA5
MDQzMC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3B0cmFjZS9wdHJhY2UwNi5jCi0tLSBsdHAt
ZnVsbC0yMDA5MDQzMF9vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFj
ZTA2LmMJMjAwOS0wMy0yMyAxOTowNjowMS4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIw
MDkwNDMwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3B0cmFjZTA2LmMJMjAwOS0w
Ny0xNSAwODo1MDozNy4wMDAwMDAwMDAgKzA1MzAKQEAgLTEzNSw2ICsxMzUsNyBAQAogCVBUUkFD
RV9TRVRGR1JFR1MsLmRhdGEgPSAtM30sIHsKIAlQVFJBQ0VfU0VURkdSRUdTLC5kYXRhID0gLTR9
LAogI2VuZGlmCisjaWZkZWYgUFRSQUNFX0dFVFNJR0lORk8KIAl7CiAJUFRSQUNFX0dFVFNJR0lO
Rk8sLmRhdGEgPSAwfSwgewogCVBUUkFDRV9HRVRTSUdJTkZPLC5kYXRhID0gMX0sIHsKQEAgLTE0
Myw3ICsxNDQsMTAgQEAKIAlQVFJBQ0VfR0VUU0lHSU5GTywuZGF0YSA9IC0xfSwgewogCVBUUkFD
RV9HRVRTSUdJTkZPLC5kYXRhID0gLTJ9LCB7CiAJUFRSQUNFX0dFVFNJR0lORk8sLmRhdGEgPSAt
M30sIHsKLQlQVFJBQ0VfR0VUU0lHSU5GTywuZGF0YSA9IC00fSwgeworCVBUUkFDRV9HRVRTSUdJ
TkZPLC5kYXRhID0gLTR9LCAKKyNlbmRpZgorI2lmZGVmIFBUUkFDRV9TRVRTSUdJTkZPCisJewog
CVBUUkFDRV9TRVRTSUdJTkZPLC5kYXRhID0gMH0sIHsKIAlQVFJBQ0VfU0VUU0lHSU5GTywuZGF0
YSA9IDF9LCB7CiAJUFRSQUNFX1NFVFNJR0lORk8sLmRhdGEgPSAyfSwgewpAQCAtMTUxLDcgKzE1
NSw5IEBACiAJUFRSQUNFX1NFVFNJR0lORk8sLmRhdGEgPSAtMX0sIHsKIAlQVFJBQ0VfU0VUU0lH
SU5GTywuZGF0YSA9IC0yfSwgewogCVBUUkFDRV9TRVRTSUdJTkZPLC5kYXRhID0gLTN9LCB7Ci1Q
VFJBQ0VfU0VUU0lHSU5GTywuZGF0YSA9IC00fSx9OworCVBUUkFDRV9TRVRTSUdJTkZPLC5kYXRh
ID0gLTR9LAorI2VuZGlmCit9OwogCiBpbnQgVFNUX1RPVEFMID0gQVJSQVlfU0laRSh0ZXN0X2Nh
c2VzKTsKIApkaWZmIC1ydXhCIGx0cC1mdWxsLTIwMDkwNDMwX29yaWcvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wdHJhY2Uvc3Bhd25fcHRyYWNlX2NoaWxkLmggbHRwLWZ1bGwtMjAwOTA0MzAv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2Uvc3Bhd25fcHRyYWNlX2NoaWxkLmgKLS0t
IGx0cC1mdWxsLTIwMDkwNDMwX29yaWcvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wdHJhY2Uv
c3Bhd25fcHRyYWNlX2NoaWxkLmgJMjAwOC0xMS0wMiAxMTozNjowMC4wMDAwMDAwMDAgKzA1MzAK
KysrIGx0cC1mdWxsLTIwMDkwNDMwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHRyYWNlL3Nw
YXduX3B0cmFjZV9jaGlsZC5oCTIwMDktMDctMTUgMDg6NTA6MzYuMDAwMDAwMDAwICswNTMwCkBA
IC05NCw4ICs5NCwxMiBAQAogI2lmZGVmIFBUUkFDRV9TRVRSRUdTCiAJU1BUKFNFVFJFR1MpCiAj
ZW5kaWYKKyNpZmRlZiBQVFJBQ0VfR0VUU0lHSU5GTwogCVNQVChHRVRTSUdJTkZPKQorI2VuZGlm
CisjaWZkZWYgUFRSQUNFX1NFVFNJR0lORk8KIAlTUFQoU0VUU0lHSU5GTykKKyNlbmRpZgogI2lm
ZGVmIFBUUkFDRV9HRVRGR1JFR1MKIAlTUFQoR0VURkdSRUdTKQogI2VuZGlmCg==
--000e0cd25048d051730469ef7dab--

----Next_Part(Mon_May_18_18_34_48_2009_313)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
----Next_Part(Mon_May_18_18_34_48_2009_313)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----Next_Part(Mon_May_18_18_34_48_2009_313)----

