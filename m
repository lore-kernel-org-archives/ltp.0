Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxsvO-00030L-8r
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 01:45:10 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxsvG-0000Hg-Ga
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 01:45:10 +0000
Received: by pzk26 with SMTP id 26so9518915pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 18:44:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1255428755.8438.10.camel@subratamodak.linux.ibm.com>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074423.22414.52234.sendpatchset@localhost.localdomain>
	<1255428755.8438.10.camel@subratamodak.linux.ibm.com>
Date: Tue, 13 Oct 2009 18:39:15 -0700
Message-ID: <364299f40910131839r6a8ecfbdk31e4407e7f027d97@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch 6/6] Patch to fix workload installation issue
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Tue, Oct 13, 2009 at 3:12 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Tue, 2009-10-13 at 13:14 +0530, Poornima Nayak wrote:
>> Patch to fix workload installation issue
>>
>> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> This will not apply as all the LTP Makefiles has undergon huge changes.
> Checkout the latest LTP and re-create this patch:
>
> Hunk #1 FAILED at 27.
> 1 out of 1 hunk FAILED -- saving rejects to file utils/Makefile.rej
>
> Regards--
> Subrata
>
>>
>> diff -uprN ltp-full-20090930/utils/Makefile ltp-full-20090930_patched/ut=
ils/Makefile
>> --- ltp-full-20090930/utils/Makefile =A02009-10-05 02:10:46.000000000 -0=
400
>> +++ ltp-full-20090930_patched/utils/Makefile =A02009-10-12 22:48:30.0000=
00000 -0400
>> @@ -27,6 +27,6 @@ all: configure
>> =A0 =A0 =A0 @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
>>
>> =A0install:
>> -
>> + =A0 =A0 @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
>> =A0clean:
>> =A0 =A0 =A0 @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;

    That was fixed as a `side-effect' of the new Makefile changes :)...
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
