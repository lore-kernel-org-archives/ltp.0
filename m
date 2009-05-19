Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M6M5H-0005KE-V5
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2009 09:58:07 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6M58-0005BD-Jh
	for ltp-list@lists.sourceforge.net; Tue, 19 May 2009 09:58:07 +0000
Received: by ewy17 with SMTP id 17so4942919ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 May 2009 02:57:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090511.200555.226785908.caiqian@cclom.cn>
References: <d51f89b0905072329u1d7d2e34j1fb95b09f347bf1a@mail.gmail.com>
	<20090511.200555.226785908.caiqian@cclom.cn>
Date: Tue, 19 May 2009 02:57:56 -0700
Message-ID: <d51f89b0905190257t4505860ej1461b32ad789e96@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e2f4ff502f2046a40f1f9
Subject: Re: [LTP] Patch for "File" test case issue of 30-April-2009 release
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

--0016368e2f4ff502f2046a40f1f9
Content-Type: multipart/alternative; boundary=0016368e2f4ff502e3046a40f1f7

--0016368e2f4ff502e3046a40f1f7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Qian,

As rpmbuild path is differenet for FC10 and RHEL, I have fixed the build
path using following option

 rpmbuild --define "_topdir  <builddirectory>"

 builddirectory mentioned as /usr/src/redhat in test program

I have attached patch with this mail. I request you to check the patch
description  for more details and let me know if any issues.

Note:  I have run checkpatch.pl script on this patch and there no errors and
warnings.

Regards,
Rohit

On Mon, May 11, 2009 at 5:05 AM, CAI Qian <caiqian@cclom.cn> wrote:

> From: rohit verma <rohit.170309@gmail.com>
> Subject: Patch for [LTP] "File" test case issue of 30-April-2009 release
> Date: Fri, 8 May 2009 11:59:35 +0530
>
> > Dear Qian,
> >
> > Patch for "file" test case is attached with this mail.
> >
> > I have changed build directory from "/usr/src/redhat" to "$HOME/rpmbuild"
> at
> > line no.
> >
> > 394 in "ltp-full-20090430/testcases/commands/ade/file/file_test.sh"
> >
> > With these modification test case pass for any user.
> >
> > Please confirm if this solution is OK.
> >
>
>  $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
>  if [ -f /etc/redhat-release ]; then
> -       bDIR=/usr/src/redhat
> +       bDIR=$HOME/rpmbuild
>        bCMD=rpmbuild
>  else
>        bDIR=/usr/src/packages
>
> This will not work for systems like RHEL, which are using the default
> buildroot in /usr/src/redhat. You can also tell rpmbuild command to use
> an user specified buildroot like this,
>
> rpmbuild --buildroot=$HOME/rpmbuild
>
> CAI Qian
>
> >
> > Regards,
> > rohit
> >
> >
> >
> > On Thu, May 7, 2009 at 1:03 PM, CAI Qian <caiqian@cclom.cn> wrote:
> >
> >> From: rohit verma <rohit.170309@gmail.com>
> >> Subject: [LTP] "File" test case issue with Fedoracore10 in 31-March-2009
> >> release
> >> Date: Mon, 4 May 2009 10:59:54 +0530
> >>
> >> > Hi,
> >> >
> >> > O/P of 'File' test case  with fedora core-10 as follows
> >> >
> >> > *file01      0  INFO  :  TEST #1: file commad recogizes ASCII text
> files
> >> > file01      7  PASS  :  file: Recognised ASCII file correctly
> >> > file02      0  INFO  :  TEST #2: file command recognizes bash shell
> >> scripts
> >> > file02      2  PASS  :  file: Recognised bash shell script correctly
> >> > file03      0  INFO  :  TEST #3: file command recognizes korn shell
> >> scripts
> >> > file03      3  PASS  :  file: recognised korn shell script
> >> > file04      0  INFO  :  TEST #4: file command recognizes C shell
> scripts
> >> > file04      4  PASS  :  file: Recognised C shell script correctly
> >> > file05      0  INFO  :  TEST #5: file command recognizes C programs
> text
> >> > file05      5  PASS  :  file: Recognised C program text correctly
> >> > file06      0  INFO  :  TEST #6: file command recognizes ELF
> executables
> >> > file06      6  PASS  :  file: Recognized ELF binary executable
> >> > file07      0  INFO  :  TEST #7: file command recognizes tar files.
> >> > file07      7  PASS  :  file: Recognised tar files
> >> > file08      0  INFO  :  TEST #8: file command recognizes tar zip files
> >> > file08      8  PASS  :  file: Recognised tar zip file
> >> > file09      0  INFO  :  TEST #9: file command recognizes RPM files
> >> > file09      9  BROK  :  rpm command brok. Reason:
> >> > error: File /root/rpmbuild/SOURCES/cprog.c: No such file or directory
> >> > file09     10  BROK  :  Remaining cases broken
> >> > file09      9  FAIL  :  file: Failed to Recognize RPM file. Reason:
> >> > /usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm: cannot open
> >> > `/usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm' (No such file or
> directory)
> >> > file10      0  INFO  :  TEST #10: file command recognizes vmlinuz file
> >> > file10     10  PASS  :  file: Recognised vmlinuz file correctly *
> >> > **
> >> >
> >> > Default path for 'rpmbuild' command in fc10  is /root/rpmbuild/SOURCES
> >> > folder instead of  "/usr/src/redhat" which was present in fc8
> rpmbuild.
> >> >
> >> > In FC10 rpmbuild looks for the cprog.c file  in user's home directory.
> >> (i.e
> >> > /root/rpmbuild  for root user)
> >> >
> >> > Please visit the below URL for more information
> >> >
> >> > http://www.mail-archive.com/fedora-list@redhat.com/msg27958.html
> >> >
> >> > As per the 'file' test program, it creates the 'cprog.c' file in
> >> > /usr/src/redhat and recognize RPM file in same path
> >> > which should be changed accordingly to user's home directory.
> >> >
> >> > Please check the  line number 394 : bDIR=/usr/src/redhat. in
> >> file_tests.sh
> >> >
> >> > So I request you to incorporate the changes according to rpmbuild of
> fc10
> >> in
> >> > file_tests.sh.
> >> >
> >> > Regards,
> >> > rohit
> >> >
> >>
> >> Yes, you are correct. Perhaps we can use,
> >>
> >> rpmbuild --buildroot=/usr/src/redhat
> >>
> >> to override the default setting?
> >>
> >> CAI Qian
> >>
>

--0016368e2f4ff502e3046a40f1f7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Dear Qian,</div>
<div>=A0</div>
<div>As rpmbuild path is differenet for FC10 and RHEL, I have fixed the bui=
ld path using following option</div>
<div>=A0</div>
<div>=A0rpmbuild --define &quot;_topdir =A0&lt;builddirectory&gt;&quot;</di=
v>
<div>=A0</div>
<div>=A0builddirectory mentioned as /usr/src/redhat in=A0test program </div=
>
<div>=A0</div>
<div>I have attached patch with this mail. I request you to check the=A0pat=
ch description =A0for more details and let me know if any issues.</div>
<div>=A0</div>
<div>Note:=A0 I have run checkpatch.pl script on this patch and there no er=
rors and warnings.</div>
<div>=A0</div>
<div>Regards,</div>
<div>Rohit<br><br></div>
<div class=3D"gmail_quote">On Mon, May 11, 2009 at 5:05 AM, CAI Qian <span =
dir=3D"ltr">&lt;<a href=3D"mailto:caiqian@cclom.cn">caiqian@cclom.cn</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">From: rohit verma &lt;<a href=3D"mailto:rohit.170309@gmai=
l.com">rohit.170309@gmail.com</a>&gt;<br></div>Subject: Patch for [LTP] &qu=
ot;File&quot; test case issue of 30-April-2009 release<br>Date: Fri, 8 May =
2009 11:59:35 +0530<br>

<div class=3D"im"><br>&gt; Dear Qian,<br>&gt;<br>&gt; Patch for &quot;file&=
quot; test case is attached with this mail.<br>&gt;<br>&gt; I have changed =
build directory from &quot;/usr/src/redhat&quot; to &quot;$HOME/rpmbuild&qu=
ot; at<br>
&gt; line no.<br>&gt;<br>&gt; 394 in &quot;ltp-full-20090430/testcases/comm=
ands/ade/file/file_test.sh&quot;<br>&gt;<br>&gt; With these modification te=
st case pass for any user.<br>&gt;<br>&gt; Please confirm if this solution =
is OK.<br>
&gt;<br><br></div>=A0$LTPBIN/tst_resm TINFO &quot;TEST #9: file command rec=
ognizes RPM files&quot;<br>=A0if [ -f /etc/redhat-release ]; then<br>- =A0 =
=A0 =A0 bDIR=3D/usr/src/redhat<br>+ =A0 =A0 =A0 bDIR=3D$HOME/rpmbuild<br>=
=A0 =A0 =A0 =A0bCMD=3Drpmbuild<br>
=A0else<br>=A0 =A0 =A0 =A0bDIR=3D/usr/src/packages<br><br>This will not wor=
k for systems like RHEL, which are using the default<br>buildroot in /usr/s=
rc/redhat. You can also tell rpmbuild command to use<br>an user specified b=
uildroot like this,<br>
<br>rpmbuild --buildroot=3D$HOME/rpmbuild<br><font color=3D"#888888"><br>CA=
I Qian<br></font>
<div>
<div></div>
<div class=3D"h5"><br>&gt;<br>&gt; Regards,<br>&gt; rohit<br>&gt;<br>&gt;<b=
r>&gt;<br>&gt; On Thu, May 7, 2009 at 1:03 PM, CAI Qian &lt;<a href=3D"mail=
to:caiqian@cclom.cn">caiqian@cclom.cn</a>&gt; wrote:<br>&gt;<br>&gt;&gt; Fr=
om: rohit verma &lt;<a href=3D"mailto:rohit.170309@gmail.com">rohit.170309@=
gmail.com</a>&gt;<br>
&gt;&gt; Subject: [LTP] &quot;File&quot; test case issue with Fedoracore10 =
in 31-March-2009<br>&gt;&gt; release<br>&gt;&gt; Date: Mon, 4 May 2009 10:5=
9:54 +0530<br>&gt;&gt;<br>&gt;&gt; &gt; Hi,<br>&gt;&gt; &gt;<br>&gt;&gt; &g=
t; O/P of &#39;File&#39; test case =A0with fedora core-10 as follows<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; *file01 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #1=
: file commad recogizes ASCII text files<br>&gt;&gt; &gt; file01 =A0 =A0 =
=A07 =A0PASS =A0: =A0file: Recognised ASCII file correctly<br>&gt;&gt; &gt;=
 file02 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #2: file command recognizes bash =
shell<br>
&gt;&gt; scripts<br>&gt;&gt; &gt; file02 =A0 =A0 =A02 =A0PASS =A0: =A0file:=
 Recognised bash shell script correctly<br>&gt;&gt; &gt; file03 =A0 =A0 =A0=
0 =A0INFO =A0: =A0TEST #3: file command recognizes korn shell<br>&gt;&gt; s=
cripts<br>&gt;&gt; &gt; file03 =A0 =A0 =A03 =A0PASS =A0: =A0file: recognise=
d korn shell script<br>
&gt;&gt; &gt; file04 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #4: file command rec=
ognizes C shell scripts<br>&gt;&gt; &gt; file04 =A0 =A0 =A04 =A0PASS =A0: =
=A0file: Recognised C shell script correctly<br>&gt;&gt; &gt; file05 =A0 =
=A0 =A00 =A0INFO =A0: =A0TEST #5: file command recognizes C programs text<b=
r>
&gt;&gt; &gt; file05 =A0 =A0 =A05 =A0PASS =A0: =A0file: Recognised C progra=
m text correctly<br>&gt;&gt; &gt; file06 =A0 =A0 =A00 =A0INFO =A0: =A0TEST =
#6: file command recognizes ELF executables<br>&gt;&gt; &gt; file06 =A0 =A0=
 =A06 =A0PASS =A0: =A0file: Recognized ELF binary executable<br>
&gt;&gt; &gt; file07 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #7: file command rec=
ognizes tar files.<br>&gt;&gt; &gt; file07 =A0 =A0 =A07 =A0PASS =A0: =A0fil=
e: Recognised tar files<br>&gt;&gt; &gt; file08 =A0 =A0 =A00 =A0INFO =A0: =
=A0TEST #8: file command recognizes tar zip files<br>
&gt;&gt; &gt; file08 =A0 =A0 =A08 =A0PASS =A0: =A0file: Recognised tar zip =
file<br>&gt;&gt; &gt; file09 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #9: file com=
mand recognizes RPM files<br>&gt;&gt; &gt; file09 =A0 =A0 =A09 =A0BROK =A0:=
 =A0rpm command brok. Reason:<br>
&gt;&gt; &gt; error: File /root/rpmbuild/SOURCES/cprog.c: No such file or d=
irectory<br>&gt;&gt; &gt; file09 =A0 =A0 10 =A0BROK =A0: =A0Remaining cases=
 broken<br>&gt;&gt; &gt; file09 =A0 =A0 =A09 =A0FAIL =A0: =A0file: Failed t=
o Recognize RPM file. Reason:<br>
&gt;&gt; &gt; /usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm: cannot open<br>&=
gt;&gt; &gt; `/usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm&#39; (No such fil=
e or directory)<br>&gt;&gt; &gt; file10 =A0 =A0 =A00 =A0INFO =A0: =A0TEST #=
10: file command recognizes vmlinuz file<br>
&gt;&gt; &gt; file10 =A0 =A0 10 =A0PASS =A0: =A0file: Recognised vmlinuz fi=
le correctly *<br>&gt;&gt; &gt; **<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Defaul=
t path for &#39;rpmbuild&#39; command in fc10 =A0is /root/rpmbuild/SOURCES<=
br>&gt;&gt; &gt; folder instead of =A0&quot;/usr/src/redhat&quot; which was=
 present in fc8 rpmbuild.<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; In FC10 rpmbuild looks for the cprog.c file =
=A0in user&#39;s home directory.<br>&gt;&gt; (i.e<br>&gt;&gt; &gt; /root/rp=
mbuild =A0for root user)<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Please visit the=
 below URL for more information<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; <a href=3D"http://www.mail-archive.com/fedor=
a-list@redhat.com/msg27958.html" target=3D"_blank">http://www.mail-archive.=
com/fedora-list@redhat.com/msg27958.html</a><br>&gt;&gt; &gt;<br>&gt;&gt; &=
gt; As per the &#39;file&#39; test program, it creates the &#39;cprog.c&#39=
; file in<br>
&gt;&gt; &gt; /usr/src/redhat and recognize RPM file in same path<br>&gt;&g=
t; &gt; which should be changed accordingly to user&#39;s home directory.<b=
r>&gt;&gt; &gt;<br>&gt;&gt; &gt; Please check the =A0line number 394 : bDIR=
=3D/usr/src/redhat. in<br>
&gt;&gt; file_tests.sh<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; So I request you t=
o incorporate the changes according to rpmbuild of fc10<br>&gt;&gt; in<br>&=
gt;&gt; &gt; file_tests.sh.<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Regards,<br>
&gt;&gt; &gt; rohit<br>&gt;&gt; &gt;<br>&gt;&gt;<br>&gt;&gt; Yes, you are c=
orrect. Perhaps we can use,<br>&gt;&gt;<br>&gt;&gt; rpmbuild --buildroot=3D=
/usr/src/redhat<br>&gt;&gt;<br>&gt;&gt; to override the default setting?<br=
>
&gt;&gt;<br>&gt;&gt; CAI Qian<br>&gt;&gt;<br></div></div></blockquote></div=
><br>

--0016368e2f4ff502e3046a40f1f7--

--0016368e2f4ff502f2046a40f1f9
Content-Type: text/plain; charset=US-ASCII; name="file.txt"
Content-Disposition: attachment; filename="file.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fuwflqj90

QXMgcnBtYnVpbGQgY29tbWFuZCBidWlsZHMgc291cmNlIHJwbSBmaWxlcyBpbiBkaWZmZXJlbnQg
bG9jYXRpb25zIAppbiBGQzEwIGFuZCBSSEVMLiBpLmUgaW4gRkMxMCBpdCBpcyAkSE9NRS9ycG1i
dWlsZCBhbmQgaW4gUkhFTCBpdCAKaXMgL3Vzci9zcmMvcmVkaGF0LgoKVGhpcyBwYXRjaCBwcm92
aWRlcyB0aGUgZml4ZWQgcGF0aCBmb3IgYnVpbGRpbmcgdGhlIHJwbSwgaXJyZXNwZWN0aXZlIG9m
IApkaXN0cmlidXRpb24uVGhlIGZpeGVkIHBhdGggd291bGQgYmUgYXMgZGVmaW5lZCBmb3IgYkRJ
UiBpbiAKZmlsZV90ZXN0cy5zaCBwcm9ncmFtLgoKU2lnbmVkLW9mZi1ieTogcm9oaXQgdmVybWE8
cm9oaXQuMTcwMzA5QGdtYWlsLmNvbT4KCmRpZmYgLXJ1eEIgbHRwLWZ1bGwtMjAwOTA0MzBfb3Jp
Z2luYWwvdGVzdGNhc2VzL2NvbW1hbmRzL2FkZS9maWxlL2ZpbGVfdGVzdC5zaCBsdHAtZnVsbC0y
MDA5MDQzMC90ZXN0Y2FzZXMvY29tbWFuZHMvYWRlL2ZpbGUvZmlsZV90ZXN0LnNoCi0tLSBsdHAt
ZnVsbC0yMDA5MDQzMF9vcmlnaW5hbC90ZXN0Y2FzZXMvY29tbWFuZHMvYWRlL2ZpbGUvZmlsZV90
ZXN0LnNoCTIwMDgtMTAtMjEgMTQ6MzE6NDguMDAwMDAwMDAwICswNTMwCisrKyBsdHAtZnVsbC0y
MDA5MDQzMC90ZXN0Y2FzZXMvY29tbWFuZHMvYWRlL2ZpbGUvZmlsZV90ZXN0LnNoCTIwMDktMDct
MTkgMDg6NDc6NDkuMDAwMDAwMDAwICswNTMwCkBAIC00NjcsNyArNDY3LDcgQEAKICAgICAkTFRQ
QklOL3RzdF9icmttIFRCUk9LIE5VTEwgImNhdDogZmFpbGVkIHRvIGNyZWF0ZSB0ZXN0IGZpbGUg
Y3Byb2cuYyIKIGZpCiAKLSRiQ01EIC1icyAgJExUUFRNUC9maWxlcy5zcGVjID4gJExUUFRNUC9m
aWxlLm91dCAyPiYxCiskYkNNRCAtLWRlZmluZSAiX3RvcGRpciAkYkRJUiIgLWJzICAkTFRQVE1Q
L2ZpbGVzLnNwZWMgPiAkTFRQVE1QL2ZpbGUub3V0IDI+JjEKIGlmIFsgJD8gLW5lIDAgXQogdGhl
bgogICAgICRMVFBCSU4vdHN0X2JyayBUQlJPSyAkTFRQVE1QL2ZpbGUub3V0IE5VTEwgInJwbSBj
b21tYW5kIGJyb2suIFJlYXNvbjoiCg==
--0016368e2f4ff502f2046a40f1f9
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
--0016368e2f4ff502f2046a40f1f9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e2f4ff502f2046a40f1f9--

