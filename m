Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6WuG-0003QC-0N
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:03:44 +0000
Received: from mail-pz0-f191.google.com ([209.85.222.191])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6Wu7-0005ci-Pp
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 22:03:43 +0000
MIME-Version: 1.0
In-Reply-To: <364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<87iqdn76jg.fsf@basil.nowhere.org>
	<364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
Date: Fri, 6 Nov 2009 14:03:30 -0800
Message-ID: <364299f40911061403ied57cc5w2120a8ea8c9a8c72@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been Released for
	OCTOBER 2009
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list <ltp-list@lists.sf.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Fri, Nov 6, 2009 at 1:39 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 12:16 PM, Andi Kleen <andi@firstfloor.org> wrote:
>> Subrata Modak <subrata@linux.vnet.ibm.com> writes:
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> OCTOBER 2009 Highlights:
>>
>> s/High/Low/
>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> =A0 =A0 =A01. LTP Makefiles rewrite:(Project started 1.2 years back)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0I. To accommodate correct build/installation=
 practices,
>>> =A0 =A0 =A0 =A0 =A0 =A0 II. better integrate Autoconf/Automake with tes=
ts for safer
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 builds,
>>> =A0 =A0 =A0 =A0 =A0 =A0III. better cross-compilation of LTP sources.
>>
>> Just as a warning for everyone: that change broke building on most old
>> distributions and there seems to be no interest in fixing that.
>>
>> Unless you're running the latest and greatest better stay with older LTP
>> versions.
>
> Andi,
> =A0 =A0Let's keep this discussion on track with the other thread that's
> open. We can probably come to an engineering solution that will allow
> your version of make (3.80) to function, but I think that a line needs
> to be drawn in the sand at that version because make 3.79 is too
> ancient (~7 years old) to work with.

    Andi and Arjen did make a valid point in the other thread. If you
do not have access to make 3.81, please avoid this release. I will
work on filling in the gaps for 3.80 to function, but users with make
3.79 will need to upgrade to either 3.80 or 3.81.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
