Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NLdSD-0005Ap-Re
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 14:05:13 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLdS3-0006Xp-EV
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 14:05:13 +0000
Message-ID: <4B2B7704.8000003@cn.fujitsu.com>
Date: Fri, 18 Dec 2009 20:35:16 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <1187453091.565781261137697221.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1187453091.565781261137697221.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 2/3] ade: fix the bug of ar01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8859943494303139585=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============8859943494303139585==
Content-Type: multipart/alternative;
	boundary="------------010505000004050907050602"

This is a multi-part message in MIME format.
--------------010505000004050907050602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/2009 08:01 PM, Caspar Zhang wrote:
> ----- "Caspar Zhang" <czhang@redhat.com> wrote:
>
>   
>> ----- "liubo" <liubo2009@cn.fujitsu.com> wrote: 
>>
>>     
>>> Yes, this problem does occur because of the version... 
>>> In binutils-2.19.51.0.2, the strange dot appears. 
>>> In binutils-2.17.50.0.18, the strange dot does not appear. 
>>> And these cause the dismatch. 
>>>
>>> Thanks, 
>>> Liu Bo 
>>>
>>>       
>> My Fedora12 has binutils-2.19.51.0.14-34, I can't see this dot
>> either.
>>
>>     
> Tested in binutils-2.19.51.0.2-17.fc11, don't see this dot either 
> :-(
>
> -Caspar
>
>
>   

  Are you using a 32bit box or not?
  I tested on a few 32bit boxes(Ubuntu Fedora), and I think it is the point.

  Thanks.
  Liu Bo


--------------010505000004050907050602
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
On 12/18/2009 08:01 PM, Caspar Zhang wrote:
<blockquote
 cite=3D"mid:1187453091.565781261137697221.JavaMail.root@zmail04.collab.p=
rod.int.phx2.redhat.com"
 type=3D"cite">
  <pre wrap=3D"">----- "Caspar Zhang" <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:czhang@redhat.com">&lt;czhang@redhat.com&gt;</a> wrote:

  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">----- "liubo" <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wr=
ote:=20

    </pre>
    <blockquote type=3D"cite">
      <pre wrap=3D"">Yes, this problem does occur because of the version.=
..=20
In binutils-2.19.51.0.2, the strange dot appears.=20
In binutils-2.17.50.0.18, the strange dot does not appear.=20
And these cause the dismatch.=20

Thanks,=20
Liu Bo=20

      </pre>
    </blockquote>
    <pre wrap=3D"">My Fedora12 has binutils-2.19.51.0.14-34, I can't see =
this dot
either.

    </pre>
  </blockquote>
  <pre wrap=3D""><!---->Tested in binutils-2.19.51.0.2-17.fc11, don't see=
 this dot either=20
:-(

-Caspar


  </pre>
</blockquote>
<br>
=C2=A0 Are you using a 32bit box or not?<br>
=C2=A0 I tested on a few 32bit boxes(Ubuntu Fedora), and I think it is th=
e
point.<br>
<br>
=C2=A0 Thanks.<br>
=C2=A0 Liu Bo<br>
<br>
</body>
</html>

--------------010505000004050907050602--


--===============8859943494303139585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============8859943494303139585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8859943494303139585==--

