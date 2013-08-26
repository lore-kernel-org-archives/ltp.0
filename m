Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1VDldX-0006Z0-Hg
	for ltp-list@lists.sourceforge.net; Mon, 26 Aug 2013 01:30:31 +0000
Received: from [63.217.87.10] (helo=smtpwcom.263xmail.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VDldC-0001jd-WE
	for ltp-list@lists.sourceforge.net; Mon, 26 Aug 2013 01:30:31 +0000
Received: from mail-pd0-f169.google.com (localhost [127.0.0.1])
	by smtpwcom.263xmail.com (Postfix) with ESMTP id 0F425487
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Aug 2013 09:29:26 +0800 (CST)
Received: by mail-pd0-f169.google.com with SMTP id r10so2827338pdi.14
	for <ltp-list@lists.sourceforge.net>;
	Sun, 25 Aug 2013 18:29:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201308242123.36727.vapier@gentoo.org>
References: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
	<201308242123.36727.vapier@gentoo.org>
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Mon, 26 Aug 2013 09:28:47 +0800
Message-ID: <CALGiYOGn1trNWZfSLVDTaWqhLSwCjWc0AXS1prs_MTw2PVC7tw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=047d7b6dbdcaea97cf04e4cfafe6
Subject: Re: [LTP] [PATCH] network/stress/route/route[4,
 6]-redirect: add PATH setting for ip
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP List <ltp-list@lists.sourceforge.net>

--047d7b6dbdcaea97cf04e4cfafe6
Content-Type: multipart/alternative; boundary=047d7b6dbdcaea97cc04e4cfafe4

--047d7b6dbdcaea97cc04e4cfafe4
Content-Type: text/plain; charset=ISO-8859-1

I'm sorry for the wrong format of the patch sent from Gmail

The attachment is the patch I posted



Thanks,
Lingyun Xie


2013/8/25 Mike Frysinger <vapier@gentoo.org>

> On Thursday 08 August 2013 05:59:06 Xie Lingyun wrote:
> > ip command is not in default rsh $PATH, add PATH setting for 'ip addr
> > flush' the same
> > change
> > in route4-redirect and route6-redirect
>
> your patch is line wrapped.  maybe you should use `git send-email` to post
> things ...
> -mike
>

--047d7b6dbdcaea97cc04e4cfafe4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:simsun,s=
erif;color:#000000">I&#39;m sorry for the wrong format of the patch sent fr=
om Gmail</div><div class=3D"gmail_default" style=3D"font-family:simsun,seri=
f;color:#000000">

<br></div><div class=3D"gmail_default" style=3D"font-family:simsun,serif;co=
lor:#000000">The attachment is the patch I posted</div><div class=3D"gmail_=
extra"><br clear=3D"all"><div><div dir=3D"ltr"><br><div><br></div><div>Than=
ks,<br>

Lingyun Xie</div></div></div>
<br><br><div class=3D"gmail_quote">2013/8/25 Mike Frysinger <span dir=3D"lt=
r">&lt;<a href=3D"mailto:vapier@gentoo.org" target=3D"_blank">vapier@gentoo=
.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">On Thursday 08 August 2013 05:59:06 Xie Lingyun wrote:<br=
>
&gt; ip command is not in default rsh $PATH, add PATH setting for &#39;ip a=
ddr<br>
&gt; flush&#39; the same<br>
&gt; change<br>
&gt; in route4-redirect and route6-redirect<br>
<br>
</div>your patch is line wrapped. =A0maybe you should use `git send-email` =
to post<br>
things ...<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-mike<br>
</font></span></blockquote></div><br></div></div>

--047d7b6dbdcaea97cc04e4cfafe4--

--047d7b6dbdcaea97cf04e4cfafe6
Content-Type: application/octet-stream; 
	name="0001-route-route-4-6-redirect-add-PATH-setting-for-ip.patch"
Content-Disposition: attachment; 
	filename="0001-route-route-4-6-redirect-add-PATH-setting-for-ip.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkt058mr1

RnJvbSA3MGE1ZmZiNWEyMGU2MTIyOWZmZGM3YzQ4ZGM4MzNjZTgxODEyYjRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWUgTGluZ3l1biA8bGluZ3l1bi54aWVAYmouY3MyYy5jb20u
Y24+CkRhdGU6IFRodSwgOCBBdWcgMjAxMyAxNzo1MjoxNCArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IHJvdXRlL3JvdXRlWzQsNl0tcmVkaXJlY3Q6IGFkZCBQQVRIIHNldHRpbmcgZm9yIGlwCgppcCBj
b21tYW5kIGlzIG5vdCBpbiBkZWZhdWx0IHJzaCAkUEFUSCwgYWRkIFBBVEggc2V0dGluZyBmb3Ig
J2lwIGFkZHIgZmx1c2ggJwp0aGUgc2FtZSBpbiByb3V0ZTQtcmVkaXJlY3QgYW5kIHJvdXRlNi1y
ZWRpcmVjdAoKU2lnbmVkLW9mZi1ieTogWGllIExpbmd5dW4gPGxpbmd5dW4ueGllQGJqLmNzMmMu
Y29tLmNuPgotLS0KIHRlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy9yb3V0ZS9yb3V0ZTQtcmVkaXJl
Y3QgfCAyICstCiB0ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvcm91dGUvcm91dGU2LXJlZGlyZWN0
IHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdvcmsvc3RyZXNzL3JvdXRlL3JvdXRlNC1yZWRp
cmVjdCBiL3Rlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy9yb3V0ZS9yb3V0ZTQtcmVkaXJlY3QKaW5k
ZXggOWViOGE0Ni4uYWI2YWFmMSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL25ldHdvcmsvc3RyZXNz
L3JvdXRlL3JvdXRlNC1yZWRpcmVjdAorKysgYi90ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvcm91
dGUvcm91dGU0LXJlZGlyZWN0CkBAIC0xNDAsNyArMTQwLDcgQEAgZG9fc2V0dXAoKQogCiAgICAg
IyBSZW1vdmUgdGhlIGxpbmstbG9jYWwgYWRkcmVzcyBvZiB0aGUgcmVtb3RlIGhvc3QKICAgICBz
bGVlcCAzCi0gICAgJExUUF9SU0ggJFJIT1NUICJpcCBhZGRyIGZsdXNoIGRldiAkcmhvc3RfaWZu
YW1lIiA+IC9kZXYvbnVsbAorICAgICRMVFBfUlNIICRSSE9TVCAiUEFUSD0vc2JpbjovdXNyL3Ni
aW46JFBBVEggaXAgYWRkciBmbHVzaCBkZXYgJHJob3N0X2lmbmFtZSIgPiAvZGV2L251bGwKIAog
ICAgICMgQXNzaWduIElQdjQgYWRkcmVzcyB0byB0aGUgaW50ZXJmYWNlIG9mIHRoZSBsb2NhbCBo
b3N0CiAgICAgc2V0X2lwdjRhZGRyIGxob3N0ICR7TElOS19OVU19ICR7SVBWNF9ORVRXT1JLfSAk
e0xIT1NUX0lQVjRfSE9TVH0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9uZXR3b3JrL3N0cmVzcy9y
b3V0ZS9yb3V0ZTYtcmVkaXJlY3QgYi90ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvcm91dGUvcm91
dGU2LXJlZGlyZWN0CmluZGV4IDFjMzFiNjIuLjFlOGY1ZGYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNl
cy9uZXR3b3JrL3N0cmVzcy9yb3V0ZS9yb3V0ZTYtcmVkaXJlY3QKKysrIGIvdGVzdGNhc2VzL25l
dHdvcmsvc3RyZXNzL3JvdXRlL3JvdXRlNi1yZWRpcmVjdApAQCAtMTM3LDcgKzEzNyw3IEBAIGRv
X3NldHVwKCkKIAogICAgICMgUmVtb3ZlIHRoZSBsaW5rLWxvY2FsIGFkZHJlc3Mgb2YgdGhlIHJl
bW90ZSBob3N0CiAgICAgc2xlZXAgNQotICAgICRMVFBfUlNIICRSSE9TVCAiaXAgYWRkciBmbHVz
aCBkZXYgJHJob3N0X2lmbmFtZSIgPiAvZGV2L251bGwKKyAgICAkTFRQX1JTSCAkUkhPU1QgIlBB
VEg9L3NiaW46L3Vzci9zYmluOiRQQVRIIGlwIGFkZHIgZmx1c2ggZGV2ICRyaG9zdF9pZm5hbWUi
ID4gL2Rldi9udWxsCiAKICAgICAjIEFzc2lnbiBJUHY2IGFkZHJlc3MgdG8gdGhlIGludGVyZmFj
ZSBvZiB0aGUgbG9jYWwgaG9zdAogICAgIGFkZF9pcHY2YWRkciBsaG9zdCAke0xJTktfTlVNfSAk
e0lQVjZfTkVUV09SS30gJHtMSE9TVF9JUFY2X0hPU1R9Ci0tIAoxLjguMy4xCgo=
--047d7b6dbdcaea97cf04e4cfafe6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
--047d7b6dbdcaea97cf04e4cfafe6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--047d7b6dbdcaea97cf04e4cfafe6--

