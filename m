Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OvOtl-0006Jc-By
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:21:45 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvOtk-0003Ni-J1
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:21:45 +0000
Received: by iwn2 with SMTP id 2so7164345iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Sep 2010 23:21:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284443060.5001.6.camel@subratamodak.linux.ibm.com>
References: <000001cb50aa$ddf34080$99d9c180$@co.jp>
	<1284443060.5001.6.camel@subratamodak.linux.ibm.com>
Date: Mon, 13 Sep 2010 23:21:39 -0700
Message-ID: <AANLkTikd6rPuh8ti4iSQcf4ks1J4J+RuL=ZnkraCHOxg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About "pthread_attr_setstack/2-1" and
 "pthread_attr_setstacksize/2-1" testsets
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Mon, Sep 13, 2010 at 10:44 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> I see the following commits already:
>
> 414747ced26d943a22a3f767deb7f5b4658adb6e
> =A0 =A0 =A0 =A0Date: =A0 Sun Aug 29 03:32:18 2010 -0700
>
> and
>
> 228b250d23f36ddc95cb25179441420bea9b8bdd
> =A0 =A0 =A0 =A0Date: =A0 Sun Aug 22 15:02:43 2010 -0700

    Following up on this, I've requested that POSIX add this
functionality to BASE, but it's fallen on deaf ears. I need to attend
the thursday 8am meetings in order to become more influential in this
area.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
