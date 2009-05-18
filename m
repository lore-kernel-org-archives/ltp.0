Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <boussettahichem@yahoo.fr>) id 1M5yx4-0000Pw-83
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 09:16:06 +0000
Received: from planetmail5.outgw.tn ([193.95.97.10])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5yx2-000752-E7
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 09:16:06 +0000
Message-ID: <4A1118E9.1000501@yahoo.fr>
Date: Mon, 18 May 2009 10:14:33 +0200
From: Hichem Boussetta <boussettahichem@yahoo.fr>
MIME-Version: 1.0
References: <4A1067FE.8080501@yahoo.fr>
In-Reply-To: <4A1067FE.8080501@yahoo.fr>
Subject: Re: [LTP] LTP cross compilation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3303873826026342522=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Hichem Boussetta <boussettahichem@yahoo.fr>
Cc: ltp-list@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============3303873826026342522==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms040704070609090804000207"

This is a cryptographically signed message in MIME format.

--------------ms040704070609090804000207
Content-Type: multipart/mixed; boundary="------------000309060507000003080505"

This is a multi-part message in MIME format.
--------------000309060507000003080505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hichem Boussetta a =E9crit :
> Hi all,
>
> It is the first time that I use ltp and I am having some troubles=20
> trying to cross compile it.
> I have seen a cross compilation example in the installation manual. It =

> is about cross compiling for a powerpc processor.
>
> CROSS_COMPILER=3D/opt/ppc64/powerpc64-linux/bin/powerpc64-linux-
> CROSS_CFLAGS=3D -mpowerpc64
> LDFLAGS=3D-static
> LOADLIBES=3D-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc
> LIB_DIR=3D/lib64
> export LOADLIBES LIB_DIR
>
> In my case, I a compiling for an arm processor. I tried to do the same =

> by the specifying the toolchain prefix, the CC, LD, AR and the=20
> LIB_DIR. But, I get always this error when cross compiling :
>
> getdelays.c: In function 'print_delayacct':
> getdelays.c:215: error: 'struct taskstats' has no member named=20
> 'freepages_count'
> getdelays.c:216: error: 'struct taskstats' has no member named=20
> 'freepages_delay_total'
> make[5]: *** [getdelays] Erreur 1
>
> In fact, I omitted the libraries nss_dns and lnss_files since didn't=20
> find them in the lib directories of my toolchain. I am not sure about=20
> that, but I don't think the problem is related to this libraries since =

> they do not exist in my host machine either, and here, the compilation =

> of ltp worked well. Perhaps, the problem is due to the fact that I=20
> didn't put any option in the CROSS_CFLAGS since I found nowhere how to =

> get this information.
>
> If someone knows any thing about this or succeeded to cross compile=20
> ltp, it would be really nice if he could tell me, because I am really=20
> stuck now :-)
>
> Thanks,
>
Hi all,

I think that I've figured out how to configure LTP for cross
compilation. In fact, we need to put the right parameters during the
configuration. We should append the cross toolchain's bin directory to
the path and add --host=3D$(toolchain_prefix) to the configure script. By=

doing that, ltp succeds to find out the binary utilities that it should
use (gcc, ld ,ar, ranlib, ...). We should also specify the path to the
include and lib directory of the toolchain we are using by setting the
variables CPPFLAGS and LDFLAGS. However, I still get a compilation error
that I think it is related to the fact that some libraries are missing
(signalfd for example). The message I receive is this :

getdelays.c: In function 'print_delayacct':
getdelays.c:215: error: 'struct taskstats' has no member named
'freepages_count'
getdelays.c:216: error: 'struct taskstats' has no member named
'freepages_delay_total'

Does anyone know how to overcome this problem or does this mean that it
is not possible to cross compile LTP ? In fact, the crosstoolchains I am
using are generated using crosstool-ng. So, I don't think that the
problem is due to the toolchain.

Regards,

--=20
Hichem BOUSSETTA
El=E8ve ing=E9nieur
Ecole Polytechnique de Tunisie




--------------000309060507000003080505
Content-Type: text/x-vcard; charset=utf-8;
 name="boussettahichem.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="boussettahichem.vcf"

begin:vcard
fn:Hichem
n:Boussetta;Hichem
org;quoted-printable:Ecole Polytechnique de Tunisie;Signaux et syst=C3=A8mes
adr:;;;La marsa;Tunis;2078;Tunisie
email;internet:boussettahichem@yahoo.fr
title;quoted-printable:El=C3=A8ve ing=C3=A9nieur
tel;cell:(+216) 21 149 549
note:Date de naissance : 17-04-1986
url:http://hichem.boussetta.netcv.fr/
version:2.1
end:vcard


--------------000309060507000003080505--

--------------ms040704070609090804000207
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJHzCC
AuowggJToAMCAQICEGRSm8igCX7UhNKDlExgUtgwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDIxNzExMjY0N1oX
DTEwMDIxNzExMjY0N1owSjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEnMCUG
CSqGSIb3DQEJARYYYm91c3NldHRhaGljaGVtQHlhaG9vLmZyMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEA1BR1FRwln/emY3z7EinJ6LVzaqmSw1x3+vsewQ7VysIhiYEv52c9
javwizq/WOZ4XJlnMjkVGBHNWdDQWk6FCgIAUwXmmcKjXzyfw80WE5WvVsrKZ4TVQovv4KPW
rdEXuMt/BOoP4vvGHjWcptx14XEzC9lfYideHUozk96DYVZxbQ9VQeSfhbVhEl3VLE3xV93e
USGGJUbbm+kM1eMFaReDIcjfrxYbvg66RLJaAVA7N2igpJCSyNeD4JsueqIIqvQRBR8UKGcn
D1V7EwPu3xkp5WRntjkxU+jEd+MdnX8jMmzBeLulfYAlSVZe5+18X8d9ydyQMGY4K9qjYumX
HQIDAQABozUwMzAjBgNVHREEHDAagRhib3Vzc2V0dGFoaWNoZW1AeWFob28uZnIwDAYDVR0T
AQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQA501v4uczLyKjflI5cnUOkgETMGWq9NZST5zld
68PHz06stsBGSjlPPLVAF+aCNPGZrxkctt0tevhwnqoQilviVyHYOMkDzL6XrplKL+nXSD5P
S1BMxbp5lj0NnVgm5yqg76c5oQTwzGwnFQkg82ADJtd0Lu9LxZUEVHCiPczlnjCCAuowggJT
oAMCAQICEGRSm8igCX7UhNKDlExgUtgwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDIxNzExMjY0N1oXDTEwMDIx
NzExMjY0N1owSjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEnMCUGCSqGSIb3
DQEJARYYYm91c3NldHRhaGljaGVtQHlhaG9vLmZyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEA1BR1FRwln/emY3z7EinJ6LVzaqmSw1x3+vsewQ7VysIhiYEv52c9javwizq/
WOZ4XJlnMjkVGBHNWdDQWk6FCgIAUwXmmcKjXzyfw80WE5WvVsrKZ4TVQovv4KPWrdEXuMt/
BOoP4vvGHjWcptx14XEzC9lfYideHUozk96DYVZxbQ9VQeSfhbVhEl3VLE3xV93eUSGGJUbb
m+kM1eMFaReDIcjfrxYbvg66RLJaAVA7N2igpJCSyNeD4JsueqIIqvQRBR8UKGcnD1V7EwPu
3xkp5WRntjkxU+jEd+MdnX8jMmzBeLulfYAlSVZe5+18X8d9ydyQMGY4K9qjYumXHQIDAQAB
ozUwMzAjBgNVHREEHDAagRhib3Vzc2V0dGFoaWNoZW1AeWFob28uZnIwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQUFAAOBgQA501v4uczLyKjflI5cnUOkgETMGWq9NZST5zld68PHz06s
tsBGSjlPPLVAF+aCNPGZrxkctt0tevhwnqoQilviVyHYOMkDzL6XrplKL+nXSD5PS1BMxbp5
lj0NnVgm5yqg76c5oQTwzGwnFQkg82ADJtd0Lu9LxZUEVHCiPczlnjCCAz8wggKooAMCAQIC
AQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENh
cGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAm
BgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1h
aWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B
1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79A
gAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8E
CDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3
dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEa
MBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7M
DaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk1
3iSx0x1G/11fZU8xggNxMIIDbQIBATB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQZFKbyKAJftSE0oOUTGBS2DAJBgUrDgMCGgUAoIIB0DAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wOTA1MTgwODE0MzNaMCMG
CSqGSIb3DQEJBDEWBBTOjTMOCZp1mxA0/kN3UizX9L3WFzBfBgkqhkiG9w0BCQ8xUjBQMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBkUpvIoAl+1ITSg5RMYFLYMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAhBkUpvIoAl+1ITSg5RMYFLYMA0GCSqGSIb3DQEBAQUABIIBALpGnHNjyiEw
zwiv5uPTwT4GWVS4d+CDkHfAJHqdW1GHegbIaxPntDdoSZFPh1Z/D+F1PCy1z3uZHcBdTCtt
vE71jndHINzUVWpYaxgu75p3mitFKImRUvjiIYz540f59C+r3BFCcY1xGxKYwr6qv7BnP1Dj
AdTB0EMuf+c1SkRxOKpEA80KzaJ94fcyNENo6HvH5jNhrFww8HdyMImAU9VAtiaSV+vr1++p
66gIpDeFqAgW2NjJEi3NUyECYYh/zjte1uPJW2q3T+QfVBjj0/fhnKwnHBy4iTw77x0jKMnh
lrIib42dBP82ix6CI3xWCNsgr4gJ7Vie+53I1rHJ/mAAAAAAAAA=
--------------ms040704070609090804000207--


--===============3303873826026342522==
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
--===============3303873826026342522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3303873826026342522==--

