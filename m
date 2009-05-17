Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <boussettahichem@yahoo.fr>) id 1M5nAc-0005RV-OF
	for ltp-list@lists.sourceforge.net; Sun, 17 May 2009 20:41:18 +0000
Received: from planetmail5.outgw.tn ([193.95.97.10])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5nAa-0005Bu-Ot
	for ltp-list@lists.sourceforge.net; Sun, 17 May 2009 20:41:18 +0000
Received: from planet.net.tn (unknown [193.95.123.25])
	by tounes-23.ati.tn (Postfix) with SMTP id 5A0A91D3003C
	for <ltp-list@lists.sourceforge.net>;
	Sun, 17 May 2009 22:41:14 +0200 (CEST)
Received: from [41.229.1.190] (HELO [41.229.1.190])
	by fes1.planet.net.tn (CommuniGate Pro SMTP 5.2.10)
	with ESMTP id 59623679 for ltp-list@lists.sourceforge.net;
	Sun, 17 May 2009 21:40:52 +0200
Message-ID: <4A1067FE.8080501@yahoo.fr>
Date: Sun, 17 May 2009 21:39:42 +0200
From: Hichem Boussetta <boussettahichem@yahoo.fr>
MIME-Version: 1.0
Subject: [LTP] LTP cross compilation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4157407529434536693=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============4157407529434536693==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms010404070803020406040905"

This is a cryptographically signed message in MIME format.

--------------ms010404070803020406040905
Content-Type: multipart/mixed; boundary="------------010209090608010305050608"

This is a multi-part message in MIME format.
--------------010209090608010305050608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi all,

It is the first time that I use ltp and I am having some troubles trying =

to cross compile it.
I have seen a cross compilation example in the installation manual. It=20
is about cross compiling for a powerpc processor.

CROSS_COMPILER=3D/opt/ppc64/powerpc64-linux/bin/powerpc64-linux-
CROSS_CFLAGS=3D -mpowerpc64
LDFLAGS=3D-static
LOADLIBES=3D-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc
LIB_DIR=3D/lib64
export LOADLIBES LIB_DIR

In my case, I a compiling for an arm processor. I tried to do the same=20
by the specifying the toolchain prefix, the CC, LD, AR and the LIB_DIR.=20
But, I get always this error when cross compiling :

getdelays.c: In function 'print_delayacct':
getdelays.c:215: error: 'struct taskstats' has no member named=20
'freepages_count'
getdelays.c:216: error: 'struct taskstats' has no member named=20
'freepages_delay_total'
make[5]: *** [getdelays] Erreur 1

In fact, I omitted the libraries nss_dns and lnss_files since didn't=20
find them in the lib directories of my toolchain. I am not sure about=20
that, but I don't think the problem is related to this libraries since=20
they do not exist in my host machine either, and here, the compilation=20
of ltp worked well. Perhaps, the problem is due to the fact that I=20
didn't put any option in the CROSS_CFLAGS since I found nowhere how to=20
get this information.

If someone knows any thing about this or succeeded to cross compile ltp, =

it would be really nice if he could tell me, because I am really stuck=20
now :-)

Thanks,

--=20
Hichem BOUSSETTA
El=E8ve ing=E9nieur
Ecole Polytechnique de Tunisie



--------------010209090608010305050608
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


--------------010209090608010305050608--

--------------ms010404070803020406040905
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wOTA1MTcxOTM5NDJaMCMG
CSqGSIb3DQEJBDEWBBSf7dPTezgWgfPUMlkIDJ/KS9XxhDBfBgkqhkiG9w0BCQ8xUjBQMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBkUpvIoAl+1ITSg5RMYFLYMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAhBkUpvIoAl+1ITSg5RMYFLYMA0GCSqGSIb3DQEBAQUABIIBAFwJDzuK8QKg
f99x8s1K4iPrgqkHOwy8wTdgk4zCc0tG22Sb1mGQNsH4ITArlpeDcEUvB9+jVooiYEEJ/e7f
lo71pzvMQiv7A9OlTxdb2HKiW09nIcG6o3HOdVLkLhZIXlGHQ+ZSTyvr1Byjdtph0QZLatWS
BifRIXVRPAYRrXNNzrJOdhjUt1Pydx8Y6nJKzi59L0WmbOcelcgIcS4b7RgFhe3H3TATUayi
5PeoGgc1ge7pYGuCVv/AJEgUgyPoYoQNI689GxxkolTKFnxHs9kLMGngin+SInzJ41xUxblq
LsUWSieV6KGeVpL1wI4ze6weSbQ+gf5ohnIkUtEzv4oAAAAAAAA=
--------------ms010404070803020406040905--


--===============4157407529434536693==
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
--===============4157407529434536693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4157407529434536693==--

