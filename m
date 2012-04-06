Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFzwR-0000aw-7l
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 03:34:27 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SFzwQ-0006sg-Ip
	for ltp-list@lists.sourceforge.net; Fri, 06 Apr 2012 03:34:27 +0000
Received: by ggcy3 with SMTP id y3so1403990ggc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 05 Apr 2012 20:34:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201204042149.20439.vapier@gentoo.org>
References: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
	<201204042028.52373.vapier@gentoo.org>
	<alpine.BSF.2.00.1204041732320.25027@toaster.local>
	<201204042149.20439.vapier@gentoo.org>
Date: Thu, 5 Apr 2012 20:34:21 -0700
Message-ID: <CAGH67wQcNtAkP4aMmGELSyEavEx-AbWqhjJxd_M-mh-u6qdn+w@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Apr 4, 2012 at 6:49 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 04 April 2012 20:33:40 Garrett Cooper wrote:
>> On Wed, 4 Apr 2012, Mike Frysinger wrote:
>> > On Wednesday 04 April 2012 15:18:53 Garrett Cooper wrote:
>> >> On Wed, Apr 4, 2012 at 10:54 AM, Mike Frysinger wrote:
>> >>> On Wednesday 04 April 2012 13:31:10 Garrett Cooper wrote:
>> >>>> On Wed, Apr 4, 2012 at 10:22 AM, Mike Frysinger wrote:
>> >>>>> On Wednesday 04 April 2012 01:23:43 Garrett Cooper wrote:
>> >>>>>> The intent behind these changes are to remove unnecessary perl
>> >>>>>> dependencies in LTP by using awk in its stead. It was something t=
hat
>> >>>>>> was discussed a while ago on ltp-list@.
>> >>>>>
>> >>>>> i like awk over perl a lot. =A0my only concern is non-POSIX stuff
>> >>>>> slipping in (such as people who have gawk installed). =A0should we=
 add
>> >>>>> a local wrapper script that sees if the awk accepts a --posix flag
>> >>>>> and automatically pass it ?
>> >>>>
>> >>>> That's actually a gawk-ism :)...
>> >>>
>> >>> yes, that's why i phrased it "if the awk accepts"
>> >>>
>> >>> awk --help | grep -q -e --posix && args=3D"${args} --posix"
>> >>
>> >> This makes sense and it would protect against gawk'isms, but not other
>> >> *awk-isms.
>> >
>> > sure, but some protection is better than none. =A0if other awks have
>> > similar knobs, we can leverage them too.
>>
>> Agreed, but this should be handled in other commits, right?
>
> sure, i'm not saying let's hold up the conversion from perl. =A0but we sh=
ould do
> it at some point imo.

    Are there any objections to the proposed [final?] patches I
submitted for this patch set?
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
