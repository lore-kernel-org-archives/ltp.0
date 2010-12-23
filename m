Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PVcXi-0002wx-0j
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 04:12:42 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PVcXh-0004hJ-6Z
	for ltp-list@lists.sourceforge.net; Thu, 23 Dec 2010 04:12:41 +0000
Received: by pxi17 with SMTP id 17so1464064pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Dec 2010 20:12:35 -0800 (PST)
References: <4CBEAF2A.1070101@cn.fujitsu.com>
	<20101221124935.GA944@hannu-debian.research.nokia.com>
	<4D12B48A.9020500@cn.fujitsu.com>
In-Reply-To: <4D12B48A.9020500@cn.fujitsu.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <ABDE7E44-F301-4846-A7C3-D0F35CCC2E4F@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 22 Dec 2010 20:12:19 -0800
Subject: Re: [LTP] About LTP
	open_posix_testsuite/functional/threads/robust_test cases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4503226100013263924=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


--===============4503226100013263924==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--909747750


--Apple-Mail-1--909747750
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 22, 2010, at 6:31 PM, Gui Jianfeng <guijianfeng@cn.fujitsu.com> wrote=
:

> Hannu Heikkinen wrote:
>> On 20/10/10 10:58 +0200, ext Gui Jianfeng wrote:
>>> Hi Garrett
>>>=20
>>> In open_posix_testsuite/functional/threads/robust_test category,
>>> all test cases don't follow the POSIX standard. They call many=20
>>> functions that glibc doesn't even support. I wonder why not just
>>> get rid of these test cases.
>>>=20
>>> --=20
>>> Regards
>>> Gui Jianfeng
>>=20
>> Hi,
>>=20
>> any progress/news about this?
>=20
> Garrett,
>=20
> Would you get rid of these cases?
>>=20

They should go in testcases/realtime . I can't commit changes for approximat=
ely another week and a half because I don't have Internet connectivity excep=
t on my phone (which doesn't do git :/..).
Garrett=

--Apple-Mail-1--909747750
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body bgcolor=3D"#FFFFFF"><div><span class=3D"Apple-style-span" style=3D=
"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-compositio=
n-fill-color: rgba(175, 192, 227, 0.230469); -webkit-composition-frame-color=
: rgba(77, 128, 180, 0.230469); ">On Dec 22, 2010, at 6:31 PM, Gui Jianfeng &=
lt;<a href=3D"mailto:guijianfeng@cn.fujitsu.com">guijianfeng@cn.fujitsu.com<=
/a>&gt; wrote:</span></div><div><br></div><div></div><blockquote type=3D"cit=
e"><div><span>Hannu Heikkinen wrote:</span><br><blockquote type=3D"cite"><sp=
an>On 20/10/10 10:58 +0200, ext Gui Jianfeng wrote:</span><br></blockquote><=
blockquote type=3D"cite"><blockquote type=3D"cite"><span>Hi Garrett</span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span></span><br></blockquote></blockquote><blockquote type=3D"cite"><bl=
ockquote type=3D"cite"><span>In open_posix_testsuite/functional/threads/robu=
st_test category,</span><br></blockquote></blockquote><blockquote type=3D"ci=
te"><blockquote type=3D"cite"><span>all test cases don't follow the POSIX st=
andard. They call many </span><br></blockquote></blockquote><blockquote type=
=3D"cite"><blockquote type=3D"cite"><span>functions that glibc doesn't even s=
upport. I wonder why not just</span><br></blockquote></blockquote><blockquot=
e type=3D"cite"><blockquote type=3D"cite"><span>get rid of these test cases.=
</span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span></span><br></blockquote></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><span>-- </span><br></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><span>Regards</span><b=
r></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><span>Gui Jianfeng</span><br></blockquote></blockquote><blockquote type=3D=
"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>Hi,</sp=
an><br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote>=
<blockquote type=3D"cite"><span>any progress/news about this?</span><br></bl=
ockquote><span></span><br><span>Garrett,</span><br><span></span><br><span>Wo=
uld you get rid of these cases?</span><font class=3D"Apple-style-span" color=
=3D"#005001"><font class=3D"Apple-style-span" color=3D"#0023A3"><br></font><=
/font><blockquote type=3D"cite"><span></span></blockquote></div></blockquote=
><br><div>They should go in testcases/realtime . I can't commit changes for a=
pproximately another week and a half because I don't have Internet connectiv=
ity except on my phone (which doesn't do git :/..).</div><div>Garrett</div><=
/body></html>=

--Apple-Mail-1--909747750--


--===============4503226100013263924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============4503226100013263924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4503226100013263924==--

