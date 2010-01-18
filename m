Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWpUC-0001yj-TK
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 11:09:32 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWpUA-0001de-6J
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 11:09:32 +0000
Received: by pwj11 with SMTP id 11so1843402pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 03:09:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B543CB0.8090801@teldevice.co.jp>
References: <4B543CB0.8090801@teldevice.co.jp>
Date: Mon, 18 Jan 2010 03:09:20 -0800
Message-ID: <364299f41001180309m68619dcat7271b0e52b678652@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] i.MX31 Platform Embedded Linux LTP Test
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
To: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 18, 2010 at 2:49 AM, TED ITC Agarwal Ashish
<ashish.g@teldevice.co.jp> wrote:
> Hello All,
>
> This is Ashish Agarwal, I am new to LTP.
>
> Last day i was succeeded to install the LTP over Fedora 7 system. and run=
 test as well.
>
> As my main motive of LTP learn is to Test a customized Embedded Linux sys=
tem for Freescale i.Mx31 CPU.
>
> My Project specs are as below:
>
> Kernel: 2.6.19.2
> CPU: i.MX31
> Rootfs mounted over : Flash (jffs2 file system, 256MB)
>
> So my motive is to install the LTP and run the test.
>
> Because my system is mounted over Flash, so it can be seen as the memory =
is remained is not so much as we can use in general projects (PC's).
> and i had not include any "make" and "gcc" components to my customized ke=
rnel. (because of memory)
>
> So how can i install the LTP over the system. =A0(i have USB ports, and m=
ass storage driver support).

    Please read the INSTALL file for more details on how to configure,
compile, and install LTP. The out-of-build-tree method may be suitable
for your needs.
HTH,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
