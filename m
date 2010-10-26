Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PAbWT-0004hB-Tb
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 04:52:33 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAbWT-00062e-0O
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 04:52:33 +0000
Received: by wwb31 with SMTP id 31so4082555wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Oct 2010 21:52:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik9B1N5cLoETVev_OnrUogvqV8StLgia4RYJDvq@mail.gmail.com>
References: <AANLkTik9B1N5cLoETVev_OnrUogvqV8StLgia4RYJDvq@mail.gmail.com>
Date: Mon, 25 Oct 2010 21:52:27 -0700
Message-ID: <AANLkTi=SEqhn78Znw+_9UywNMpf=hqS__vWGOM=Z4_3W@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] unbound vriable error.
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
Cc: ltp-list@lists.sourceforge.net, hannuxx@gmail.com

On Mon, Oct 25, 2010 at 9:07 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:
> Hi,
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 In network stress tests
>
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 following error is coming,=A0it is not able t=
o get value of
> field=A0variable.
>
> ""
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/ltp/testcases/bin/get_ifname: line 79: f=
ield: unbound
> variable
> broken_ip6-version01=A0=A0=A0 1=A0 TBROK=A0 :=A0 Failed to get the interf=
ace name at the
> remote host
> ""
>
> how to resolve this error??

    Might be a shell bug because I'm not sure how this could be unset
(the error is coming from set -u -- I did that to catch potential bugs
in cmdlib.sh):

 78 # Pick HWaddr from HWaddr list
 79 field=3D`expr $link_num + 1`
 80 hwaddr=3D`echo $hwaddrs | cut -d ' ' -f $field`
 81 if [ x${hwaddr} =3D x ]; then
 82     echo "HWaddr list ($hwaddrs) is something wrong." >&2
 83     exit 1
 84 fi

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
