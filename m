Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M5wmZ-0002IG-Pd
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 06:57:07 +0000
Received: from mail-ew0-f169.google.com ([209.85.219.169])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5wmU-0002ON-Pc
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 06:57:07 +0000
Received: by ewy17 with SMTP id 17so4014815ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 17 May 2009 23:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242372515.7224.18.camel@subratamodak.linux.ibm.com>
References: <d51f89b0905070410v468978ecjf6d8ee31bb4ede3c@mail.gmail.com>
	<20090508.232031.104047613.caiqian@cclom.cn>
	<d51f89b0905120440y8d3eacbh6874458946af6ea3@mail.gmail.com>
	<20090513.223538.71106642.caiqian@cclom.cn>
	<d51f89b0905132102y8a8e57dpeb6b73a24b693ea7@mail.gmail.com>
	<1242372515.7224.18.camel@subratamodak.linux.ibm.com>
Date: Sun, 17 May 2009 23:56:59 -0700
Message-ID: <d51f89b0905172356p696a34faj82e212bf2e3fa6f6@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=0016364c7c0701ff34046a2a4df6
Subject: Re: [LTP] Fwd: Patch for :Unzip01 Test Not Working Correctly
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

--0016364c7c0701ff34046a2a4df6
Content-Type: multipart/alternative; boundary=0016364c7c0701ff2b046a2a4df4

--0016364c7c0701ff2b046a2a4df4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Subrata,

I  have removed the warning and error and attached the updated patch with
this mail.

I request you to apply the patch and let me know if any issues.

Request: Could you share the patch (checkpatch.pl ) which you have
developed, so that I can cross check it at my end for future patches before
sending to the ltp-list .

Regards,
Rohit

On Fri, May 15, 2009 at 12:28 AM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

> Thanks.
>
> I have started to do some holy job, might be in annoyance to everybody,
> to check all patches with checkpatch.pl before they are merged with
> LTP.
>
> So, i would inform you what needs to be changed in the patch before they
> can be merged. This exercise will help us in preventing any code mess as
> we keep growing, and help maintaining LTP better. Hope, you will agree
> too.
>
> Your patch contains the following errors/warning. Please rectify and
> resend :-)
>
> ========================================================================
> WARNING: line over 80 characters
> #40: FILE: testcases/commands/unzip/unzip_tests.sh:152:
> +               diff -iwB "$PWD/tst_unzip.out" "$PWD/tst_unzip.out.exp"
> > "$PWD/tst_unzip.out.err" || RC=$?
>
> ERROR: Missing Signed-off-by: line(s)
>
> total: 1 errors, 1 warnings, 49 lines checked
> ========================================================================
>
> Regards--
> Subrata
>
> On Thu, 2009-05-14 at 09:32 +0530, rohit verma wrote:
> >
> >
> > ---------- Forwarded message ----------
> > From: CAI Qian <caiqian@cclom.cn>
> > Date: Wed, May 13, 2009 at 8:05 PM
> > Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
> > To: rohit.170309@gmail.com
> >
> >
> > From: rohit verma <rohit.170309@gmail.com>
> > Subject: Re: Patch for [LTP] :Unzip01 Test Not Working Correctly
> >
> > Date: Tue, 12 May 2009 17:10:36 +0530
> >
> > > Hi Qian,
> > >
> > > Yes you are correct. We cannot predict the output order of unzip. So
> > I
> > > have sorted the
> > > actual and expected output and attached the updated patch with this
> > mail.
> > >
> > > I request you to apply this patch and let me know if any issues.
> > >
> > > Regards,
> > > Rohit
> > >
> >
> >
> > Works fine. Please submit to the mailing list.
> >
> > Acked-by: CAI Qian <caiqian@cclom.cn>
> >
> > Thanks,
> > CAI Qian
> >
> >
> >
> >
> ------------------------------------------------------------------------------
> > The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
> > production scanning environment may not be a perfect world - but thanks
> to
> > Kodak, there's a perfect scanner to get the job done! With the NEW KODAK
> i700
> > Series Scanner you'll get full speed at 300 dpi even with all image
> > processing features enabled. http://p.sf.net/sfu/kodak-com
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--0016364c7c0701ff2b046a2a4df4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Dear Subrata,</div>
<div>=A0</div>
<div>I =A0have removed the warning and error and attached the updated patch=
 with this mail.</div>
<div>=A0</div>
<div>I request you to apply the patch and let me know if any issues.</div>
<div>=A0</div>
<div>Request: Could you share the patch (checkpatch.pl=A0) which you have d=
eveloped, so that=A0I can cross check it at my end for future patches befor=
e sending=A0to the ltp-list .</div>
<div>=A0</div>
<div>Regards,</div>
<div>Rohit<br><br></div>
<div class=3D"gmail_quote">On Fri, May 15, 2009 at 12:28 AM, Subrata Modak =
<span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com">subrata=
@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Thanks.<br><br>I have started to=
 do some holy job, might be in annoyance to everybody,<br>to check all patc=
hes with checkpatch.pl before they are merged with<br>
LTP.<br><br>So, i would inform you what needs to be changed in the patch be=
fore they<br>can be merged. This exercise will help us in preventing any co=
de mess as<br>we keep growing, and help maintaining LTP better. Hope, you w=
ill agree<br>
too.<br><br>Your patch contains the following errors/warning. Please rectif=
y and<br>resend :-)<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>WARNING: line over 80 characters<br>#40: FILE: testca=
ses/commands/unzip/unzip_tests.sh:152:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff -iwB &quot;$PWD/tst_unzip.out&quot; &quo=
t;$PWD/tst_unzip.out.exp&quot;<br>&gt; &quot;$PWD/tst_unzip.out.err&quot; |=
| RC=3D$?<br><br>ERROR: Missing Signed-off-by: line(s)<br><br>total: 1 erro=
rs, 1 warnings, 49 lines checked<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>R=
egards--<br>Subrata<br><br>On Thu, 2009-05-14 at 09:32 +0530, rohit verma w=
rote:<br>&gt;<br>&gt;<br>&gt; ---------- Forwarded message ----------<br>
&gt; From: CAI Qian &lt;<a href=3D"mailto:caiqian@cclom.cn">caiqian@cclom.c=
n</a>&gt;<br>&gt; Date: Wed, May 13, 2009 at 8:05 PM<br>&gt; Subject: Re: P=
atch for [LTP] :Unzip01 Test Not Working Correctly<br>&gt; To: <a href=3D"m=
ailto:rohit.170309@gmail.com">rohit.170309@gmail.com</a><br>
&gt;<br>&gt;<br>&gt; From: rohit verma &lt;<a href=3D"mailto:rohit.170309@g=
mail.com">rohit.170309@gmail.com</a>&gt;<br>&gt; Subject: Re: Patch for [LT=
P] :Unzip01 Test Not Working Correctly<br>&gt;<br>&gt; Date: Tue, 12 May 20=
09 17:10:36 +0530<br>
&gt;<br>&gt; &gt; Hi Qian,<br>&gt; &gt;<br>&gt; &gt; Yes you are correct. W=
e cannot predict the output order of unzip. So<br>&gt; I<br>&gt; &gt; have =
sorted the<br>&gt; &gt; actual and expected output and attached the updated=
 patch with this<br>
&gt; mail.<br>&gt; &gt;<br>&gt; &gt; I request you to apply this patch and =
let me know if any issues.<br>&gt; &gt;<br>&gt; &gt; Regards,<br>&gt; &gt; =
Rohit<br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt; Works fine. Please submit to the=
 mailing list.<br>
&gt;<br>&gt; Acked-by: CAI Qian &lt;<a href=3D"mailto:caiqian@cclom.cn">cai=
qian@cclom.cn</a>&gt;<br>&gt;<br>&gt; Thanks,<br>&gt; CAI Qian<br>&gt;<br>&=
gt;<br>&gt;<br>&gt; -------------------------------------------------------=
-----------------------<br>
&gt; The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Yo=
ur<br>&gt; production scanning environment may not be a perfect world - but=
 thanks to<br>&gt; Kodak, there&#39;s a perfect scanner to get the job done=
! With the NEW KODAK i700<br>
&gt; Series Scanner you&#39;ll get full speed at 300 dpi even with all imag=
e<br>&gt; processing features enabled. <a href=3D"http://p.sf.net/sfu/kodak=
-com" target=3D"_blank">http://p.sf.net/sfu/kodak-com</a><br>&gt; _________=
______________________________________ Ltp-list mailing list <a href=3D"mai=
lto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a> <a h=
ref=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D"_bl=
ank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br>

--0016364c7c0701ff2b046a2a4df4--

--0016364c7c0701ff34046a2a4df6
Content-Type: text/plain; charset=US-ASCII; name="unzip01.txt"
Content-Disposition: attachment; filename="unzip01.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuutpai80

ICBJZiAgcHVzaCBjb21tYW5kIGlzIHN1Y2Nlc3NmdWwgb24gZGlyZWN0b3J5ICwgaXQgY2QgdG8g
TFRQVE1QLgogIEFzIGN1cnJlbnQgcGF0aCBpcyBpbnNpZGUgTFRQVE1QIGRpcmVjdG9yeSwgaXQg
aXMgbm90IHBvc3NpYmxlIHRvIGNyZWF0ZSBmaWxlIGluIExUUFRNUC8KICBkaXJlY3RvcnkgYW5k
IHRlc3Qgd291bGQgZmFpbC5TbyB0ZXN0IGNhc2UgY2hhbmdlZCBmcm9tIExUUFRNUCB0byBQV0Qu
CgogIEFzIG91dHB1dCBvcmRlciBvZiB1bnppcCBpcyBub3QgcHJlZGljdGVkLCBvcmRlciBzaG91
bGQgYmUgc29ydGVkLgoKIFJlZ2FyZHMsCiByb2hpdCB2ZXJtYQoKIFNpZ25lZC1vZmYtYnk6IHJv
aGl0IHZlcm1hPHJvaGl0LjE3MDMwOUBnbWFpbC5jb20+IAoKZGlmZiAtcnV4QiBsdHAtZnVsbC0y
MDA5MDQzMF9vcmlnaW5hbC90ZXN0Y2FzZXMvY29tbWFuZHMvdW56aXAvdW56aXBfdGVzdHMuc2gg
bHRwLWZ1bGwtMjAwOTA0MzAvdGVzdGNhc2VzL2NvbW1hbmRzL3VuemlwL3VuemlwX3Rlc3RzLnNo
Ci0tLSBsdHAtZnVsbC0yMDA5MDQzMF9vcmlnaW5hbC90ZXN0Y2FzZXMvY29tbWFuZHMvdW56aXAv
dW56aXBfdGVzdHMuc2gJMjAwOS0wMi0yNiAxODo0MDo1NC4wMDAwMDAwMDAgKzA1MzAKKysrIGx0
cC1mdWxsLTIwMDkwNDMwL3Rlc3RjYXNlcy9jb21tYW5kcy91bnppcC91bnppcF90ZXN0cy5zaAky
MDA5LTA3LTE4IDA2OjAzOjU2LjAwMDAwMDAwMCArMDUzMApAQCAtNDQsNyArNDQsNyBAQAogY2hr
X2lmZXhpc3RzKCkKIHsKIAlSQz0wCi0Jd2hpY2ggJDIgPiAiJExUUFRNUC90c3RfdW56aXAuZXJy
IiB8fCBSQz0kPworCXdoaWNoICQyID4gIiRQV0QvdHN0X3VuemlwLmVyciIgfHwgUkM9JD8KIAlp
ZiBbICQ/IC1uZSAwIF0KIAl0aGVuCiAJCXRzdF9icmttIFRCUk9LIE5VTEwgIiQxOiBjb21tYW5k
ICQyIG5vdCBmb3VuZC4iCkBAIC05OCw4ICs5OCw4IEBACiAJY2hrX2lmZXhpc3RzIElOSVQgYXdr
ICAgICAgIHx8IHJldHVybiAkUkMKIAogCSMgY3JlYXRlIGV4cGVjdGVkIG91dHB1dCBmaWxlcy4g
dHN0X3VuemlwLmV4cAotCWNhdCA+ICRMVFBUTVAvdHN0X3VuemlwLm91dC5leHAgPDwtRU9GCi0J
QXJjaGl2ZTogICRUTVAvdHN0X3VuemlwX2ZpbGUuemlwCisJY2F0ID4gJFBXRC90c3RfdW56aXAu
b3V0LmV4cCA8PC1FT0YKKwlBcmNoaXZlOiAgJDEKICAgICBjcmVhdGluZzogdHN0X3VuemlwLmRp
ci8KICAgICBjcmVhdGluZzogdHN0X3VuemlwLmRpci9kLjAvCiAgICAgZXh0cmFjdGluZzogdHN0
X3VuemlwLmRpci9kLjAvZi4wCkBAIC0xNDAsMTcgKzE0MCwyMiBAQAogCiAJdHN0X3Jlc20gVElO
Rk8gIlRlc3QgIzE6IHVuemlwIGNvbW1hbmQgdW4tY29tcHJlc3NlcyBhIC56aXAgZmlsZS4iCiAK
LQl1bnppcCAiJHt6aXBmaWxlfSIgPiAiJExUUFRNUC90c3RfdW56aXAub3V0IiB8fCBSQz0kPwor
CXVuemlwICIke3ppcGZpbGV9IiA+ICIkUFdEL3RzdF91bnppcC5vdXQiIHx8IFJDPSQ/CiAJaWYg
WyAkUkMgLW5lIDAgXQogCXRoZW4KLQkJdHN0X3JlcyBURkFJTCAiJExUUFRNUC90c3RfdW56aXAu
b3V0IiBcCisJCXRzdF9yZXMgVEZBSUwgIiRQV0QvdHN0X3VuemlwLm91dCIgXAogCQkJIlRlc3Qg
IzE6IHVuemlwIGNvbW1hbmQgZmFpbGVkLiBSZXR1cm4gdmFsdWUgPSAkUkMuIERldGFpbHM6Igog
CQlyZXR1cm4gJFJDCiAJZWxzZQotCQlkaWZmIC1pd0IgIiRMVFBUTVAvdHN0X3VuemlwLm91dCIg
IiRMVFBUTVAvdHN0X3VuemlwLm91dC5leHAiID4gIiRMVFBUTVAvdHN0X3VuemlwLm91dC5lcnIi
IHx8IFJDPSQ/CisJCXNvcnQgLW8gIiRQV0QvdHN0X3VuemlwLm91dCIgIiRQV0QvdHN0X3Vuemlw
Lm91dCIKKwkJc29ydCAtbyAiJFBXRC90c3RfdW56aXAub3V0LmV4cCIgIiRQV0QvdHN0X3Vuemlw
Lm91dC5leHAiCisKKwkJZGlmZiAtaXdCICIkUFdEL3RzdF91bnppcC5vdXQiICIkUFdEL3RzdF91
bnppcC5vdXQuZXhwIiA+XAorICAgIAkJICAgICAgICAgICIkUFdEL3RzdF91bnppcC5vdXQuZXJy
IiB8fCBSQz0kPworCQkKIAkJaWYgWyAkUkMgLW5lIDAgXQogCQl0aGVuCi0JCQl0c3RfcmVzIFRG
QUlMICIkTFRQVE1QL3RzdF91bnppcC5vdXQuZXJyIiBcCisJCQl0c3RfcmVzIFRGQUlMICIkUFdE
L3RzdF91bnppcC5vdXQuZXJyIiBcCiAJCQkJIlRlc3QgIzE6IHVuemlwIG91dHB1dCBkaWZmZXJz
IGZyb20gZXhwZWN0ZWQgb3V0cHV0LiBEZXRhaWxzIgogCQllbHNlCiAJCQl0c3RfcmVzbSBUSU5G
TyAiVGVzdCAjMTogY2hlY2sgaWYgXCIkUFdEL3RzdF91bnppcC5kaXJcIiBleGl0cy4iCkBAIC0x
ODAsNyArMTg1LDcgQEAKIAogUkM9MAogc3RhdCAiJDEiIHx8IGV4aXQgJD8KLWluaXQgfHwgZXhp
dCAkPworaW5pdCAiJDEiIHx8IGV4aXQgJD8KIAogdGVzdDAxICIkMSIgfHwgUkM9JD8KIAo=
--0016364c7c0701ff34046a2a4df6
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
--0016364c7c0701ff34046a2a4df6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016364c7c0701ff34046a2a4df6--

