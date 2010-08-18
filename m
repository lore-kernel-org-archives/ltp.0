Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlWvV-0000WO-7Q
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 00:54:45 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlWvU-0001Co-AB
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 00:54:45 +0000
Received: by fxm6 with SMTP id 6so4897266fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 17:54:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6B25A8.806@redhat.com>
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>
	<4C6B0243.1070306@redhat.com>
	<AANLkTi=S7Y_GW6uZeBgbfUrxFQ5oCRiXAOkWxahmgjCC@mail.gmail.com>
	<4C6B25A8.806@redhat.com>
Date: Tue, 17 Aug 2010 20:54:38 -0400
Message-ID: <AANLkTimKVdrg03d7xLcUkPNLtHfYeABYNg+W=_pphZhc@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
To: dmarlin@redhat.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 8:13 PM, David Marlin wrote:
> When creating patches I typically look to the existing sources for exampl=
es.
> =A0This is because I assume that 1) the current code has already been rev=
iewed
> and accepted, 2) the people who wrote it know more about what they were
> trying to accomplish and how they wanted it to work than I do, and 3)
> consistency in the code and coding style tend to make maintenance easier.

having been part of (1) a bit, worked with most of the people doing
(2), and seen the whole tree with (3), i can safely say that your
points, while the ideal we should strive for, when it comes to LTP, i
wouldnt hold your breath on any of them.

> I understand that over time code may become a bit dated and require some
> redesign/updates, but being new to these bits of code I defer to the expe=
rts
> for that.

not really the case here.  my understanding is that LTP has seen large
code dumps from different large organizations (SGI/IBM/etc...), so the
quality (in many respects) can quickly vary.

> There appear to be three primary ways tests are being handled in LTP for
> uClinux now:
> 1) "filter" the test directory (FILTER_OUT_DIRS in the Makefile)
> =A0 =A0e.g., testcases/kernel/syscalls/Makefile
> 2) skip the entire 'main' test, and display "not available in uCLinux"
> =A0 =A0e.g., testcases/kernel/syscalls/mremap/mremap03.c
> 3) skip only parts of the test
> =A0 =A0e.g., testcases/kernel/syscalls/stat/stat06.c

(3) is obviously the preference -- some coverage is better than none.
between (1) and (2), ive done a little of both, but dont have much
preference in either direction.

pros/cons:
(1/con) it can be confusing as to why a test isnt compiled & executed
forcing people to read the source code and/or build system for each
test to figure out what's going on
(1/pro) saves on build time
(2/con) build time over head, and some people might find the output
hard to filter, but we use the same output in other tests to do
runtime checking of capabilities
(2/pro) no confusing missing binaries and reasoning for skipped tests
are clear & up front

> I think the question is, do we want to continue using these approaches, or
> try to standardize on one or two (possibly new) approaches, with some
> guidelines on when to use each?

standardization is good, it's just a matter of coercing someone into
doing the actual work

> I am willing to help with any modifications, but I don't have enough
> experience with uClinux (or LTP development) to determine the best
> approach(es) or rules for use. =A0Once guidelines are established I can h=
elp
> update the code (submit patches). =A0As a 'user' of LTP, my goal is just =
to be
> able to set UCLINUX=3D1, build, install, and run the tests on a system ru=
nning
> uClinux. =A0 :-)

doing UCLINUX=3D1 should be automated a bit now by autoconf tests for
fork().  for Blackfin toolchains it certainly works (no fork()
symbol).
-mike

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
