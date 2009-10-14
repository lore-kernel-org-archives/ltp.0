Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MyDEw-00068T-Jy
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 23:26:42 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyDEu-0001ja-7f
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 23:26:42 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA4D25.57936695"
Date: Wed, 14 Oct 2009 16:24:37 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153D575@svexch01.mvista.com>
In-Reply-To: <364299f40910141429yad16b3fr19946daf53f7d878@mail.gmail.com>
References: <8368651DACC1964480F951191B94A0780153D4DC@svexch01.mvista.com>
	<364299f40910141219q59e9b87evdfe4a5f2e131b7f4@mail.gmail.com>
	<8368651DACC1964480F951191B94A0780153D52A@svexch01.mvista.com>
	<364299f40910141429yad16b3fr19946daf53f7d878@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if parsing df
	output fails to return numeric argument
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
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA4D25.57936695
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Wednesday, October 14, 2009 2:30 PM
> To: Henry Yei
> Cc: LTP Mailing List
> Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if =
parsing
> df output fails to return numeric argument
>=20
> On Wed, Oct 14, 2009 at 2:04 PM, Henry Yei <hyei@mvista.com> wrote:
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Wednesday, October 14, 2009 12:19 PM
> >> To: Henry Yei
> >> Cc: LTP Mailing List
> >> Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if
> parsing
> >> df output fails to return numeric argument
> >>
> >> On Wed, Oct 14, 2009 at 12:04 PM, Henry Yei <hyei@mvista.com> =
wrote:
> >> > All,
> >> >
> >> > This patch for rwtest.sh sets a default size for the number of
> blocks
> >> within the filesystem the test is executing on if parsing "df
> output"
> >> somehow results in a non-numeric value(unexpected df output). Also
> >> removes trailing whitespace.
> >> >
> >> > Signed-off-by: Henry Yei <hyei@mvista.com>
> >> >
> >> >
> >> > Garret,
> >> >
> >> > Per message Subject: [LTP] [issue 8] rwtest*: iogen / rwtest =
needs
> to
> >> createprerequisite directory paths,
> >> > Would a simple mkdir suffice inside the rwtest script to handle
> that
> >> issue?
> >>
> >> mkdir -p would, yup!
> >> Thanks,
> >> -Garrett
> >
> > Here is the updated rwtest.sh patch that includes creation of the
> directory if it doesn=92t exist, and cleanup of the directory =
afterwards
> to resolve issue # pointed out by Garrett Cooper.
>=20
> Henry,
>=20
> Looks good as far as your fix to my item is concerned.
>=20
> Two things:
>=20
> +                       # check if blks is a number, else set a
> default value for blks
> +                       default_sz=3D1000000
>=20
> Is this a good default?
>=20
> Could you also please change this:
>=20
>                                max=3D${size##*\%}
>                                if [[ "$max" =3D "" ]]
>                                then
>                                        max=3D$default_sz
>                                fi
>=20
> to this?
>=20
>                                max=3D${size##*\%}
>                                [ "x$max" =3D "x" ] && =
max=3D$default_sz
>=20
> Thanks!
> -Garrett


Garrett, I've attached the patch with your suggested changes.
As for making default_sz 1000000, this was to keep to the original =
functionality, but fix cases where df output was not expected. If you =
see the original code, if sz > max, than it is capped at max=3D1000000 =
as well. Whether ~ 1GB is a good maximum, I'm not sure.

Thanks for reviewing,
-Henry






------_=_NextPart_001_01CA4D25.57936695
Content-Type: application/octet-stream;
	name="rwtest_sh.patch"
Content-Transfer-Encoding: base64
Content-Description: rwtest_sh.patch
Content-Disposition: attachment;
	filename="rwtest_sh.patch"

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL2ZzL2RvaW8vcnd0ZXN0LnNoCTIwMDktMTAtMTMgMTI6
NDE6MDMuNTg4MDAwMDAwIC0wNzAwCisrKyBsdHAtd2Rpci90ZXN0Y2FzZXMva2VybmVsL2ZzL2Rv
aW8vcnd0ZXN0LnNoCTIwMDktMTAtMTQgMTY6MTM6MTMuMjUxODI2ODQzIC0wNzAwCkBAIC0xLDMz
ICsxLDMzIEBACiAjIS9iaW4vYmFzaAogCiAjIENvcHlyaWdodCAoYykgMjAwMCBTaWxpY29uIEdy
YXBoaWNzLCBJbmMuICBBbGwgUmlnaHRzIFJlc2VydmVkLgotIyAKKyMKICMgVGhpcyBwcm9ncmFt
IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkg
aXQKICMgdW5kZXIgdGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgYXMKICMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCi0jIAorIwogIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3b3VsZCBiZSB1c2VmdWwsIGJ1dAogIyBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91
dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAjIE1FUkNIQU5UQUJJTElUWSBvciBGSVRO
RVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KLSMgCisjCiAjIEZ1cnRoZXIsIHRoaXMgc29m
dHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdCBpcwogIyBm
cmVlIG9mIHRoZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGluZyBp
bmZyaW5nZW1lbnQKICMgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4s
IHdoZXRoZXIgaW1wbGllZCBvcgogIyBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNv
ZnR3YXJlIGZpbGUuICBQYXRlbnQgbGljZW5zZXMsIGlmCiAjIGFueSwgcHJvdmlkZWQgaGVyZWlu
IGRvIG5vdCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YgdGhpcyBwcm9ncmFtIHdpdGgKICMgb3Ro
ZXIgc29mdHdhcmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCi0jIAorIwogIyBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhbG9uZwogIyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLCA1OQogIyBUZW1wbGUgUGxhY2UgLSBTdWl0ZSAz
MzAsIEJvc3RvbiBNQSAwMjExMS0xMzA3LCBVU0EuCi0jIAorIwogIyBDb250YWN0IGluZm9ybWF0
aW9uOiBTaWxpY29uIEdyYXBoaWNzLCBJbmMuLCAxNjAwIEFtcGhpdGhlYXRyZSBQa3d5LAogIyBN
b3VudGFpbiBWaWV3LCBDQSAgOTQwNDMsIG9yOgotIyAKLSMgaHR0cDovL3d3dy5zZ2kuY29tIAot
IyAKLSMgRm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHRoaXMgbm90aWNlLCBzZWU6
IAotIyAKKyMKKyMgaHR0cDovL3d3dy5zZ2kuY29tCisjCisjIEZvciBmdXJ0aGVyIGluZm9ybWF0
aW9uIHJlZ2FyZGluZyB0aGlzIG5vdGljZSwgc2VlOgorIwogIyBodHRwOi8vb3NzLnNnaS5jb20v
cHJvamVjdHMvR2VuSW5mby9Ob3RpY2VFeHBsYW4vCiAKICMKQEAgLTU5LDcgKzU5LDcgQEAgaGVs
cCgpCiB7CiAJZWNobyAiXAogICAgIC1jICAgICAgICAgICBDbGVhbnVwIHRlc3QgZmlsZXMgY3Jl
YXRlZCBieSB0aGlzIGludm9jYXRpb24gb24gZXhpdC4KLSAgICAgICAgICAgICAgICAgRGVmYXVs
dCBpcyB0byBsZWF2ZSB0aGVtLiAgCisgICAgICAgICAgICAgICAgIERlZmF1bHQgaXMgdG8gbGVh
dmUgdGhlbS4KICAgICAtaCAgICAgICAgICAgVGhpcyBoZWxwIC0gaWdub3JlIGFsbCBvdGhlciBv
cHRpb25zL2FyZ3VtZW50cwogICAgIC1GCQkgT25seSBwcm9jZXNzIGZpbGVuYW1lcyAtIGRvZXMg
bm90IHJ1biBpb2dlbiAmIGRvaW8uCiAgICAgLVAgUGxhY2VzCSBOb3QgdXNlZApAQCAtNzgsNyAr
NzgsNyBAQCBoZWxwKCkKICAgICAgICAgICAgICAgICAgRGVmYXVsdCBpcyAxLiAgSWYgLW4gaXMg
bm9uLXplcm8sIGRvaW8ncyAtayBvcHRpb24gKHVzZQogCQkgZmlsZSBsb2NraW5nKSBpcyBmb3Jj
ZWQuCiAKLSAgICBmaWxlcyAgICAgICAgRmlsZXMgdG8gdGVzdCBvbi4gIEZpbGUgbmFtZXMgaGF2
ZSB0aGUgZm9sbG93aW5nIGZvbWF0OgorICAgIGZpbGVzICAgICAgICBGaWxlcyB0byB0ZXN0IG9u
LiAgRmlsZSBuYW1lcyBoYXZlIHRoZSBmb2xsb3dpbmcgZm9ybWF0OgogCQkgWyBzaXplOiBdIHBh
dGgKIAkJIFsgZnJlZSUgWyBtYXggc2l6ZSBdIDogXSBwYXRoCiAJCSBJZiBubyBzaXplIGlzIHNw
ZWNpZmllZCwgdGhlIGZpbGVzIG11c3QgZXhpc3QKQEAgLTg2LDcgKzg2LDcgQEAgaGVscCgpCiAg
ICAgICAgICAgICAgICAgIHdyaXRlYSBzeXN0ZW0gY2FsbHMuICBJZiBhIHNpemUgaXMgc3VwcGxp
ZWQsIGFuIGF0dGVtcHQgdG8KICAgICAgICAgICAgICAgICAgY3JlYXRlL2dyb3cvc2hyaW5rIHBh
dGggdG8gdGhlIGRlc2lyZWQgc2l6ZSB3aWxsIGJlIG1hZGUuCiAgICAgICAgICAgICAgICAgIHNp
emUgaXMgYW4gaW50ZWdlciB3aGljaCBkZWZhdWx0cyB0byBieXRlcywgYnV0IG1heSBiZQotICAg
ICAgICAgICAgICAgICBzdWZmaXhlZCBieSAnYicsICdrJywgb3IgJ20nIGZvciBibG9ja3MgKDQw
OTYgYnl0ZSB1bml0cyksIAorICAgICAgICAgICAgICAgICBzdWZmaXhlZCBieSAnYicsICdrJywg
b3IgJ20nIGZvciBibG9ja3MgKDQwOTYgYnl0ZSB1bml0cyksCiAJICAgICAgICAga2lsb2J5dGVz
ICgxMDI0IGJ5dGUgdW5pdHMpLCBvciBtZWdhYnl0ZXMgKDJeMjAgYnl0ZSB1bml0cykuCiAKIAkJ
IElmIHRoZSBzaXplIGlzIGEgcGVyY2VudGFnZSwgZGYgaXMgdXNlZCB0byBmaW5kIGhvdyBtdWNo
CkBAIC0xMTIsNyArMTEyLDcgQEAgY2xlYW51cF9hbmRfZXhpdCgpCiAJdGhlbgogCQlpZiBbIC1u
ICIkRmlsZXNfVG9fUmVtb3ZlIiBdCiAJCXRoZW4KLQkJCXJtIC1mICRGaWxlc19Ub19SZW1vdmUK
KwkJCXJtIC1yZiAkRmlsZXNfVG9fUmVtb3ZlCiAJCWZpCiAJZmkKIApAQCAtMzA0LDYgKzMwNCwx
MiBAQCBkbwogCWZpCiAKIAlkaXI9JChkaXJuYW1lICRmaWxlKQorCSMgY3JlYXRlIGRpcmVjdG9y
eSBmb3IgZmlsZSBpZiBub24tZXhpc3RlbnQKKwlpZiBbICEgLWQgIiRkaXIiIF0KKwl0aGVuCisJ
CW1rZGlyIC1wICRkaXIKKwkJRmlsZXNfVG9fUmVtb3ZlPSIkRmlsZXNfVG9fUmVtb3ZlICRkaXIi
CisJZmkKIAlzaXplPSR7ZiUlOip9CiAJaWYgW1sgJHNpemUgPSAqJSogXV0KIAl0aGVuCkBAIC0z
MjYsOCArMzMyLDggQEAgZG8KICAgICAgICAgICAgICAgICAgICAgICAgIGlmIHRlc3QgLWggJCh3
aGljaCBkZikKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRoZW4KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkaXI9IiI7IGRmT3B0cz0iIjsKLSAgICAgICAgICAgICAgICAgICAg
ICAgIGZpICAgICAgCi0JCisgICAgICAgICAgICAgICAgICAgICAgICBmaQorCiAJCQlibGtzPSQo
ZGYgJGRmT3B0cyAkZGlyIHwKIAkJCSh3aGlsZSByZWFkIGZzIGJsa3MgdXNlZCBhdmFpbCBjYXAg
bW91bnRwb2ludAogCQkJIGRvCkBAIC0zMzYsMzMgKzM0MiwzOCBAQCBkbwogCQkJIGRvbmUKIAkJ
CSBlY2hvICRiKSApCiAKLQkJCWNhc2UgJCh1bmFtZSkgaW4KLQkJCUxpbnV4KSAgYmxrcz0kKCBl
eHByICRibGtzIC8gMiApIDs7Ci0JCQllc2FjCi0KLQkJCXN6Y2FjaGVbJHsjc3pjYWNoZVsqXX0r
MV09JGRpcgotCQkJc3pibGtzWyR7I3N6Ymxrc1sqXX0rMV09JGJsa3MKLQkJZmkKLQotCQltYXg9
JHtzaXplIyMqXCV9Ci0JCWlmIFtbICIkbWF4IiA9ICIiIF1dCi0JCXRoZW4KLQkJCW1heD0xMDAw
MDAwCi0JCWZpCi0JCXNpemU9JHtzaXplJSVcJSp9Ci0KLQkJY2FzZSAkKHVuYW1lKSBpbgotCQlJ
UklYKikKLQkJICBzej0kKCBwZXJsIC1sZSAncHJpbnQgaW50KCAnJGJsa3MnICogJyRzaXplJyAv
IDEwMCApJyApCi0JCSAgOzsKLQkJKikKLQkJICBzej0kKGV4cHIgXCggJGJsa3MgJyonICRzaXpl
IFwpIC8gMTAwKQotCQkgIDs7Ci0JCWVzYWMKLQotCQlpZiBbICRzeiAtZ3QgJG1heCBdCi0JCXRo
ZW4KLQkJCXN6PSRtYXgKKwkJCSMgY2hlY2sgaWYgYmxrcyBpcyBhIG51bWJlciwgZWxzZSBzZXQg
YSBkZWZhdWx0IHZhbHVlIGZvciBibGtzCisJCQlkZWZhdWx0X3N6PTEwMDAwMDAKKwkJCWlmIFsg
JGJsa3MgLWVxICRibGtzIDI+IC9kZXYvbnVsbCBdCisJCQl0aGVuCisKKwkJCQljYXNlICQodW5h
bWUpIGluCisJCQkJTGludXgpICBibGtzPSQoIGV4cHIgJGJsa3MgLyAyICkgOzsKKwkJCQllc2Fj
CisKKwkJCQlzemNhY2hlWyR7I3N6Y2FjaGVbKl19KzFdPSRkaXIKKwkJCQlzemJsa3NbJHsjc3pi
bGtzWypdfSsxXT0kYmxrcworCisJCQkJbWF4PSR7c2l6ZSMjKlwlfQorCQkJCVsgIngkbWF4IiA9
ICJ4IiBdICYmIG1heD0kZGVmYXVsdF9zegorCQkJCXNpemU9JHtzaXplJSVcJSp9CisKKwkJCQlj
YXNlICQodW5hbWUpIGluCisJCQkJSVJJWCopCisJCQkJICBzej0kKCBwZXJsIC1sZSAncHJpbnQg
aW50KCAnJGJsa3MnICogJyRzaXplJyAvIDEwMCApJyApCisJCQkJICA7OworCQkJCSopCisJCQkJ
ICBzej0kKGV4cHIgXCggJGJsa3MgJyonICRzaXplIFwpIC8gMTAwKQorCQkJCSAgOzsKKwkJCQll
c2FjCisKKwkJCQlpZiBbICRzeiAtZ3QgJG1heCBdCisJCQkJdGhlbgorCQkJCQlzej0kbWF4CisJ
CQkJZmkKKwkJCWVsc2UKKwkJCQlzej0kZGVmYXVsdF9zegorCQkJZmkKIAkJZmkKIAkJZj0kc3oi
YjoiJGZpbGUKIAlmaQo=

------_=_NextPart_001_01CA4D25.57936695
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
------_=_NextPart_001_01CA4D25.57936695
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA4D25.57936695--

