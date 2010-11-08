Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFLfr-0003Z7-Br
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:57:51 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFLfq-0005aD-Cm
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 06:57:51 +0000
Received: by wya21 with SMTP id 21so5152561wya.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Nov 2010 22:57:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTikamfd=umjY0fmGAjzkrQy1vMYJjKhbkyyZzs0a@mail.gmail.com>
References: <AANLkTikamfd=umjY0fmGAjzkrQy1vMYJjKhbkyyZzs0a@mail.gmail.com>
Date: Sun, 7 Nov 2010 22:57:43 -0800
Message-ID: <AANLkTimJ245qHOVnmTFW=vpOgq8vUxc3H7Aak5WQJbLU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] unbond variable
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ajay.khandelwal@st.com, hannuxx@gmail.com

On Sun, Nov 7, 2010 at 9:39 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:
> Hi,
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 In network stress tests
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 following error is coming, it is not able to =
get value of field
> variable.
>
> ""
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/ltp/testcases/bin/get_ifname: line 79: f=
ield: unbound
> variable
>
> broken_ip6-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interf=
ace name at the
> remote host
>
> ""
>
> why the variable is unbound, i tried to=A0correct this but same error is
> coming.

Fix your shell. There's no reason why it should be unbound on the line
where it's being set for the first time:

 78 # Pick HWaddr from HWaddr list
 79 field=3D`expr $link_num + 1`
 80 hwaddr=3D`echo $hwaddrs | cut -d ' ' -f $field`
 81 if [ x${hwaddr} =3D x ]; then

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
