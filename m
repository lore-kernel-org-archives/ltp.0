Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1RCNVt-0001UF-CC
	for ltp-list@lists.sourceforge.net; Sat, 08 Oct 2011 03:23:49 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RCNVs-0008Vt-1p
	for ltp-list@lists.sourceforge.net; Sat, 08 Oct 2011 03:23:49 +0000
Received: by bke11 with SMTP id 11so7660110bke.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Oct 2011 20:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADfK0X5AzMG9CAsW4A-xi=+VGAi8kzjSAkEm9Q2OMmrMvNxXxg@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<1317736501.4423.7.camel@subratamodak.linux.ibm.com>
	<CADfK0X5AzMG9CAsW4A-xi=+VGAi8kzjSAkEm9Q2OMmrMvNxXxg@mail.gmail.com>
Date: Sat, 8 Oct 2011 08:53:41 +0530
Message-ID: <CADfK0X4nV8OG0OCdpkwesjts6yUTZkYE0jtoez5XHNdSPYwxcw@mail.gmail.com>
From: "Josh!" <joshiplns@gmail.com>
Subject: [LTP] Fwd:  ltp-pan: cannot execute binary file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8394883853614063128=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

--===============8394883853614063128==
Content-Type: multipart/alternative; boundary=0015174bf14aa0999a04aec115e4

--0015174bf14aa0999a04aec115e4
Content-Type: text/plain; charset=ISO-8859-1

Hi Subrata,

ya.glibc is installed in my linux PC.

+++++
[Joshi@myserver ltp-full-20110915]$ rpm -q glibc
glibc-2.5-58.el5_6.4
+++++

+++++
[Joshi@myserver ltp-full-20110915]$ ls  /lib/libc*
/lib/libc-2.5.so  /lib/libcap.so.1.10  /lib/libcom_err.so.2
/lib/libcrypto.so.0.9.7a  /lib/libcrypto.so.6
/lib/libcap.so    /lib/libcidn-2.5.so  /lib/libcom_err.so.2.1
/lib/libcrypto.so.0.9.8e  /lib/libcrypt.so.1
/lib/libcap.so.1  /lib/libcidn.so.1    /lib/libcrypt-2.5.so
/lib/libcrypto.so.4       /lib/libc.so.6
+++++

Joshi


On Tue, Oct 4, 2011 at 7:25 PM, Subrata Modak <subrata@linux.vnet.ibm.com>wrote:

> Are you sure that you have the 'glibc'(on linux) type counterpart
> installed on your system ??
>
> Without glibc your binaries will not run.
>
> Regards--
> Subrata
>
> On Tue, 2011-10-04 at 18:11 +0530, Josh! wrote:
> > Hi,
> >
> > Any Inputs  ?
> >
> > Joshi
> >
> > On Fri, Sep 30, 2011 at 2:22 PM, Josh! <joshiplns@gmail.com> wrote:
> >         Hi folks ,
> >
> >         I am running 3.0 Kernel for armv7a on *Beagle Board* target.
> >
> >         Meanwhile I'm testing kernel with ltp-full-20110915. I did the
> >         Make and Make Install properly.
> >         But while running ./runltp script I am facing following issue.
> >
> >         {{{
> >
> >         ./runltp: line
> >         824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan: cannot
> >         execute binary file
> >         INFO: ltp-pan reportedAIL
> >
> >         }}}
> >
> >         Could anyone can share knowledge on this issue ?
> >
> >         Kindly
> >         Joshi
> >
> >
> >
> >
> >
> > --
> >
> >
> > Stay Cool,
> > Joshi"Mera Bhaarath Mahaan"
> >
> >
> >
> ------------------------------------------------------------------------------
> > All the data continuously generated in your IT infrastructure contains a
> > definitive record of customers, application performance, security
> > threats, fraudulent activity and more. Splunk takes this data and makes
> > sense of it. Business sense. IT sense. Common sense.
> > http://p.sf.net/sfu/splunk-d2dcopy1
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
*
*

--0015174bf14aa0999a04aec115e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font><font><br></font></font><span class=3D"Apple-style-s=
pan" style=3D"color: rgb(51, 51, 153); font-family: &#39;trebuchet ms&#39;,=
 sans-serif; font-size: large; ">Hi Subrata,</span><font><font><br></font><=
/font><div class=3D"gmail_quote">
<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif"><br>ya.glibc is installed in my linux PC.<br><br>++++=
+<br>[Joshi@myserver ltp-full-20110915]$ rpm -q glibc<br>glibc-2.5-58.el5_6=
.4<br>

+++++<br><br>+++++<br>[Joshi@myserver ltp-full-20110915]$ ls=A0 /lib/libc*<=
br>/lib/<a href=3D"http://libc-2.5.so" target=3D"_blank">libc-2.5.so</a>=A0=
 /lib/libcap.so.1.10=A0 /lib/libcom_err.so.2=A0=A0=A0 /lib/libcrypto.so.0.9=
.7a=A0 /lib/libcrypto.so.6<br>

/lib/libcap.so=A0=A0=A0 /lib/<a href=3D"http://libcidn-2.5.so" target=3D"_b=
lank">libcidn-2.5.so</a>=A0 /lib/libcom_err.so.2.1=A0 /lib/libcrypto.so.0.9=
.8e=A0 /lib/libcrypt.so.1<br>/lib/libcap.so.1=A0 /lib/libcidn.so.1=A0=A0=A0=
 /lib/<a href=3D"http://libcrypt-2.5.so" target=3D"_blank">libcrypt-2.5.so<=
/a>=A0=A0=A0 /lib/libcrypto.so.4=A0=A0=A0=A0=A0=A0 /lib/libc.so.6<br>

+++++<br><br>Joshi<br><br></font></font></font><div><div></div><div class=
=3D"h5"><br><div class=3D"gmail_quote">On Tue, Oct 4, 2011 at 7:25 PM, Subr=
ata Modak <span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.co=
m" target=3D"_blank">subrata@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">Are you sure that you h=
ave the &#39;glibc&#39;(on linux) type counterpart<br>
installed on your system ??<br>
<br>
Without glibc your binaries will not run.<br>
<br>
Regards--<br>
<font color=3D"#888888">Subrata<br>
</font><div><div></div><div><br>
On Tue, 2011-10-04 at 18:11 +0530, Josh! wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Any Inputs =A0?<br>
&gt;<br>
&gt; Joshi<br>
&gt;<br>
&gt; On Fri, Sep 30, 2011 at 2:22 PM, Josh! &lt;<a href=3D"mailto:joshiplns=
@gmail.com" target=3D"_blank">joshiplns@gmail.com</a>&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 Hi folks ,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I am running 3.0 Kernel for armv7a on *Beagle Board* t=
arget.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Meanwhile I&#39;m testing kernel with ltp-full-2011091=
5. I did the<br>
&gt; =A0 =A0 =A0 =A0 Make and Make Install properly.<br>
&gt; =A0 =A0 =A0 =A0 But while running ./runltp script I am facing followin=
g issue.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 {{{<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 ./runltp: line<br>
&gt; =A0 =A0 =A0 =A0 824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan:=
 cannot<br>
&gt; =A0 =A0 =A0 =A0 execute binary file<br>
&gt; =A0 =A0 =A0 =A0 INFO: ltp-pan reportedAIL<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 }}}<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Could anyone can share knowledge on this issue ?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Kindly<br>
&gt; =A0 =A0 =A0 =A0 Joshi<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt;<br>
</div></div><div>&gt; Stay Cool,<br>
&gt; Joshi&quot;Mera Bhaarath Mahaan&quot;<br>
&gt;<br>
&gt;<br>
</div><div><div></div><div>&gt; -------------------------------------------=
-----------------------------------<br>
&gt; All the data continuously generated in your IT infrastructure contains=
 a<br>
&gt; definitive record of customers, application performance, security<br>
&gt; threats, fraudulent activity and more. Splunk takes this data and make=
s<br>
&gt; sense of it. Business sense. IT sense. Common sense.<br>
&gt; <a href=3D"http://p.sf.net/sfu/splunk-d2dcopy1" target=3D"_blank">http=
://p.sf.net/sfu/splunk-d2dcopy1</a><br>
&gt; _______________________________________________ Ltp-list mailing list =
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a> <a href=3D"https://lists.sourceforge.net/lists/=
listinfo/ltp-list" target=3D"_blank">https://lists.sourceforge.net/lists/li=
stinfo/ltp-list</a><br>


<br>
</div></div></blockquote></div><br><br clear=3D"all"><br></div></div>-- <br=
><div><div style=3D"color:rgb(80, 0, 80)"><font style=3D"color:rgb(102, 0, =
204);font-family:trebuchet ms,sans-serif" size=3D"4"><b><br></b></font></di=
v></div>
<span style=3D"color:rgb(51, 51, 153)"></span><span style=3D"color:rgb(51, =
51, 153)"></span><br>

</div>
</div><br><br><span style=3D"color:rgb(51, 51, 153)"></span><span style=3D"=
color:rgb(51, 51, 153)"></span><br>
</div>

--0015174bf14aa0999a04aec115e4--


--===============8394883853614063128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
--===============8394883853614063128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8394883853614063128==--

