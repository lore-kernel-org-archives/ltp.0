Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PbI2i-0003fa-MW
	for ltp-list@lists.sourceforge.net; Fri, 07 Jan 2011 19:32:08 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PbI2h-0000GI-MC
	for ltp-list@lists.sourceforge.net; Fri, 07 Jan 2011 19:32:08 +0000
Received: by pzk12 with SMTP id 12so3411353pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Jan 2011 11:32:02 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <0A8C979C21B8D745A471962AD91DBAD84ACFA658A2@SAFEX1MAIL4.st.com>
Date: Fri, 7 Jan 2011 11:31:56 -0800
Message-Id: <65D7559E-1777-4F18-9DDB-83BA359FAD22@gmail.com>
References: <0A8C979C21B8D745A471962AD91DBAD84ACFA658A2@SAFEX1MAIL4.st.com>
Subject: Re: [LTP] fallocate() patch -NOT YET CHECKED-
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6918521938803387764=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


--===============6918521938803387764==
Content-Type: multipart/alternative; boundary=Apple-Mail-7-441420781


--Apple-Mail-7-441420781
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

	I committed a minor modified version of the patch (the =
difference being the indentation, and the fact that I'm not using the =
__off_t kernel type).
Thanks!
-Garrett

On Jan 3, 2011, at 12:27 AM, Francesco RUNDO wrote:

> Hi Garret,
> =20
> Please, check the attached fallocate() patch for the reasons below =
reported.
> =20
> Thanks
> Regards
> Francesco
> =20
> From: Francesco RUNDO=20
> Sent: Monday, November 22, 2010 3:41 PM
> To: 'ltp-list@lists.sourceforge.net'
> Subject: Patch to cover fallocate issue
> =20
> Dear All,
> =20
> I=92m using latest LTP-full-20101031 cross-built for SH based =
platforms.
> =20
> I=92d like to submit a fix related to =93fallocate=94 testcase =
(fallocate01,fallocate02,fallocate03).
> =20
> Currently, the testcase checks the fallocate syscall also in case of =
=93such=94 (and not =93all=94) architectures with wordsize=3D32: ppc64, =
ppc, x86_64. Clearly, the testcase manages the parameters -for the =
fallocate syscall- according to the endianess supported by the above =
archs.
> =20
> The so developed testcase will fail for all the architectures -with =
wordsize=3D32- and/or different endianess, with respect to the ones =
(board and/or endianess) above described and currently supported in the =
tests (for instance, the test failed in case of execution on SH based =
platforms!).
> =20
> Please, find in attach a patch which aim is to extend the fallocate =
testcase(all subtests: fallocate01,fallocate02,fallocate03) to all the =
architectures with wordsize=3D32 both big and little endian.
> =20
> Regards,
> Francesco
> =
<ltp-full-20101031-fix-fallocate_syscall_test.patch>----------------------=
--------------------------------------------------------
> Learn how Oracle Real Application Clusters (RAC) One Node allows =
customers
> to consolidate database storage, standardize their database =
environment, and,=20
> should the need arise, upgrade to a full multi-node Oracle RAC =
database=20
> without downtime or disruption
> =
http://p.sf.net/sfu/oracle-sfdevnl________________________________________=
_______
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--Apple-Mail-7-441420781
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><base href=3D"x-msg://541/"></head><body style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>I committed a minor modified =
version of the patch (the difference being the indentation, and the fact =
that I'm not using the __off_t kernel =
type).<div>Thanks!</div><div>-Garrett<br><div><br><div><div>On Jan 3, =
2011, at 12:27 AM, Francesco RUNDO wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
font-family: Helvetica; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; =
widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; font-size: medium; "><div =
lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div class=3D"WordSection1" =
style=3D"page: WordSection1; "><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><span style=3D"color: rgb(31, =
73, 125); ">Hi Garret,<o:p></o:p></span></div><div style=3D"margin-top: =
0in; margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; =
font-size: 11pt; font-family: Calibri, sans-serif; "><span style=3D"color:=
 rgb(31, 73, 125); "><o:p>&nbsp;</o:p></span></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
"><span style=3D"color: rgb(31, 73, 125); ">Please, check the attached =
fallocate() patch for the reasons below =
reported.<o:p></o:p></span></div><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><span style=3D"color: rgb(31, =
73, 125); "><o:p>&nbsp;</o:p></span></div><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><span style=3D"color: rgb(31, =
73, 125); ">Thanks<o:p></o:p></span></div><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><span style=3D"color: rgb(31, =
73, 125); ">Regards<o:p></o:p></span></div><div style=3D"margin-top: =
0in; margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; =
font-size: 11pt; font-family: Calibri, sans-serif; "><span style=3D"color:=
 rgb(31, 73, 125); ">Francesco<o:p></o:p></span></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
"><span style=3D"color: rgb(31, 73, 125); =
"><o:p>&nbsp;</o:p></span></div><div><div style=3D"border-right-style: =
none; border-bottom-style: none; border-left-style: none; border-width: =
initial; border-color: initial; border-top-style: solid; =
border-top-color: rgb(181, 196, 223); border-top-width: 1pt; =
padding-top: 3pt; padding-right: 0in; padding-bottom: 0in; padding-left: =
0in; "><div style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: =
0.0001pt; margin-left: 0in; font-size: 11pt; font-family: Calibri, =
sans-serif; "><b><span style=3D"font-size: 10pt; font-family: Tahoma, =
sans-serif; ">From:</span></b><span style=3D"font-size: 10pt; =
font-family: Tahoma, sans-serif; "><span =
class=3D"Apple-converted-space">&nbsp;</span>Francesco RUNDO<span =
class=3D"Apple-converted-space">&nbsp;</span><br><b>Sent:</b><span =
class=3D"Apple-converted-space">&nbsp;</span>Monday, November 22, 2010 =
3:41 PM<br><b>To:</b><span class=3D"Apple-converted-space">&nbsp;</span><a=
 href=3D"mailto:'ltp-list@lists.sourceforge.net" style=3D"color: blue; =
text-decoration: underline; =
">'ltp-list@lists.sourceforge.net</a>'<br><b>Subject:</b><span =
class=3D"Apple-converted-space">&nbsp;</span>Patch to cover fallocate =
issue<o:p></o:p></span></div></div></div><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><o:p>&nbsp;</o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
">Dear All,<o:p></o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; "><o:p>&nbsp;</o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
">I=92m using latest LTP-full-20101031 cross-built for SH based =
platforms.<o:p></o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; "><o:p>&nbsp;</o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
">I=92d like to submit a fix related to =93fallocate=94 testcase =
(fallocate01,fallocate02,fallocate03).<o:p></o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
"><o:p>&nbsp;</o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; ">Currently, the testcase checks the =
fallocate syscall also in case of =93such=94 (and not =93all=94) =
architectures with wordsize=3D32: ppc64, ppc, x86_64. Clearly, the =
testcase manages the parameters -for the fallocate syscall- according to =
the endianess supported by the above archs.<o:p></o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
"><o:p>&nbsp;</o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; ">The so developed testcase will fail =
for all the architectures -with wordsize=3D32- and/or different =
endianess, with respect to the ones (board and/or endianess) above =
described and currently supported in the tests (for instance, the test =
failed in case of execution on SH based =
platforms!).<o:p></o:p></div><div style=3D"margin-top: 0in; =
margin-right: 0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: =
11pt; font-family: Calibri, sans-serif; "><o:p>&nbsp;</o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
">Please, find in attach a patch which aim is to extend the fallocate =
testcase(all subtests: fallocate01,fallocate02,fallocate03) to all the =
architectures with wordsize=3D32 both big and little =
endian.<o:p></o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; "><o:p>&nbsp;</o:p></div><div =
style=3D"margin-top: 0in; margin-right: 0in; margin-bottom: 0.0001pt; =
margin-left: 0in; font-size: 11pt; font-family: Calibri, sans-serif; =
">Regards,<o:p></o:p></div><div style=3D"margin-top: 0in; margin-right: =
0in; margin-bottom: 0.0001pt; margin-left: 0in; font-size: 11pt; =
font-family: Calibri, sans-serif; =
">Francesco<o:p></o:p></div></div><span>&lt;ltp-full-20101031-fix-fallocat=
e_syscall_test.patch&gt;</span>-------------------------------------------=
-----------------------------------<br>Learn how Oracle Real Application =
Clusters (RAC) One Node allows customers<br>to consolidate database =
storage, standardize their database environment, and,<span =
class=3D"Apple-converted-space">&nbsp;</span><br>should the need arise, =
upgrade to a full multi-node Oracle RAC database<span =
class=3D"Apple-converted-space">&nbsp;</span><br>without downtime or =
disruption<br><a =
href=3D"http://p.sf.net/sfu/oracle-sfdevnl________________________________=
_______________" style=3D"color: blue; text-decoration: underline; =
">http://p.sf.net/sfu/oracle-sfdevnl______________________________________=
_________</a><br>Ltp-list mailing list<br><a =
href=3D"mailto:Ltp-list@lists.sourceforge.net" style=3D"color: blue; =
text-decoration: underline; ">Ltp-list@lists.sourceforge.net</a><br><a =
href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" =
style=3D"color: blue; text-decoration: underline; =
">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br></div></spa=
n></blockquote></div><br></div></div></body></html>=

--Apple-Mail-7-441420781--


--===============6918521938803387764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
--===============6918521938803387764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6918521938803387764==--

