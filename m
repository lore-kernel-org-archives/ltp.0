Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PB3v7-0002Ao-Qc
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:11:53 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3v5-00006m-J7
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:11:53 +0000
Received: by wwb31 with SMTP id 31so543878wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:11:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinxTr-HLLpjNUw9tdoMy0oY6EUxSDMc_bBGS+gr@mail.gmail.com>
References: <AANLkTinxTr-HLLpjNUw9tdoMy0oY6EUxSDMc_bBGS+gr@mail.gmail.com>
Date: Wed, 27 Oct 2010 04:11:43 -0700
Message-ID: <AANLkTikRZj7AwTwoRbF=-4MtSdP5gn3ns-oJq4GqU_OY@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP GIT access
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 3:32 AM, David Peverley <pev@sketchymonkey.com> wro=
te:
> Hi All,
>
> I'm just kicking into gear looking at using LTP with an embedded
> target. I've pulled down and run ltp-full-20100831which is going OK -
> however I'd like to pull down the latest from RC to work against and
> so I can re-submit patches. AFAICT The repo I should be looking at is
> :
> =A0 http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp.git
>
> Looking at the sf.net project page :
> =A0 http://sourceforge.net/projects/ltp/develop/
>
> It states that I should be able to do a :
> =A0 git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
>
> We're behind a proxy here so I normally GIT with an http access type
> but this gives me :
> =A0 bob:ltp-git $ git clone http://ltp.git.sourceforge.net/gitroot/ltp/ltp
> =A0 Initialized empty Git repository in /home/pev/src/ltp-git/ltp/.git/
> =A0 fatal: http://ltp.git.sourceforge.net/gitroot/ltp/ltp/info/refs?servi=
ce=3Dgit-upload-pack
> not found: did you run git update-server-info on the server?
>
> Is this something that could possibly be fixed? I know I can download
> tgz snapshots but obbviously this isn't ideal!

I honestly don't know if it's supported; you should probably get in
touch with sourceforge about this.
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
