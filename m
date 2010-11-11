Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGanG-0007ox-Jk
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 17:18:38 +0000
Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGanF-0006Bj-SE
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 17:18:38 +0000
Received: by eya28 with SMTP id 28so1228940eya.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Nov 2010 09:18:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF0CF663E4.3DA7EB94-ON652577D8.0037CCDB-652577D8.00391B71@in.ibm.com>
References: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
	<OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@LocalDomain>
	<OF0CF663E4.3DA7EB94-ON652577D8.0037CCDB-652577D8.00391B71@in.ibm.com>
Date: Thu, 11 Nov 2010 09:18:30 -0800
Message-ID: <AANLkTi=i0QWb616WG=FsD5aQh5kjeFjggzj3mKJV-d2-@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
To: Shubham Goyal <shubgoya@in.ibm.com>
Cc: Iranna D Ankad <iranna.ankad@in.ibm.com>, takahash <takahash@us.ibm.com>, LTP list <ltp-list@lists.sourceforge.net>

On Thu, Nov 11, 2010 at 2:23 AM, Shubham Goyal <shubgoya@in.ibm.com> wrote:
> Yes Iranna I agree with you and I also feel that "pounder21" tree should
> not be removed from LTP. As you correctly said currently its difficult to
> run LTP's pounder on stand alone systems due to some other helper files
> dependency. I will try to address this problem ASAP and try to make pound=
er
> run on stand alone systems without any other dependencies. =A0I have it i=
n my
> TODO list.

    Should it be moved to a separate module under LTP CVS?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
