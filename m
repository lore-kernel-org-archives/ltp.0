Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOgCn-00043N-SH
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:05:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOgCi-0001P7-TM
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:05:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jul 2009 19:05:32 -0400
References: <a50cf5ab0907052240xf22b2b2rf7b90cc819d0ee87@mail.gmail.com>
	<33307c790907071045v72e19614i571c36ad8af8062c@mail.gmail.com>
	<1247048369.5405.35.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1247048369.5405.35.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200907081905.35042.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] Add latest LTP test in autotest
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3816113141727350932=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Uri Lublin <uril@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Lucas Meneghel Rodrigues <mrodrigu@redhat.com>, Martin Bligh <mbligh@google.com>, Autotest mailing list <autotest@test.kernel.org>, sudhir kumar <smalikphy@gmail.com>

--===============3816113141727350932==
Content-Type: multipart/signed; boundary="nextPart2408807.2YpRUGf9VP";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2408807.2YpRUGf9VP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 July 2009 06:19:27 Subrata Modak wrote:
> On Tue, 2009-07-07 at 10:45 -0700, Martin Bligh wrote:
> > On Tue, Jul 7, 2009 at 12:24 AM, sudhir kumar<smalikphy@gmail.com> wrot=
e:
> > > On Tue, Jul 7, 2009 at 12:07 AM, Martin Bligh<mbligh@google.com> wrot=
e:
> > >>>> Issues: LTP has a history of some of the testcases getting broken.
> > >>
> > >> Right, that's always the concern with doing this.
> > >>
> > >>>> Anyways
> > >>>> that has nothing to worry about with respect to autotest. One of t=
he
> > >>>> known issue is broken memory controller issue with latest
> > >>>> kernels(cgroups and memory resource controller enabled kernels). T=
he
> > >>>> workaround for them I use is to disable or delete those tests from
> > >>>> ltp source and tar it again with the same name. Though people might
> > >>>> use different workarounds for it.
> > >>
> > >> OK, Can we encapsulate this into the wrapper though, rather than
> > >> making people do it manually? in the existing ltp.patch or something?
> > >
> > > definitely we can do that, but that needs to know about all the corner
> > > cases of failure. So may be we can continue enhancing the patch as per
> > > the failure reports on different OSes.
> > >
> > > 1 more thing I wanted to start a discussion on LTP mailing list is to
> > > make aware the testcase if it is running on a physical host or on a
> > > guest(say KVM guest). Testcases like power management, group
> > > scheduling fairness etc do not make much sense to run on a guest(as
> > > they will fail or break). So It is better for the test to recognise
> > > the environment and not execute if it is under virtualization and it
> > > is supposed to fail or break under that environment. Does that make
> > > sense to you also ?
> >
> > Yup, we can pass an excluded test list. I really wish they'd fix their
> > tests, but I've been saying that for 6 years now, and it hasn't happened
> > yet ;-(
>
> I would slightly disagree to that. 6 years is history. But, have you
> recently checked with LTP ?
>
> Yes, there were tests in LTP which were broken by design. And many of
> them were fixed in last course of years. And probably this is the first
> time in LTP=C5=9B history when people fixed all build/broken issues in a
> month. Recently people stopped complaining about the so-called broken
> issues. But i am hearing it again. Could you please point to this
> mailing list the issues that you still face. I am sure there are now
> very active members who would help you fix them.
>
> Few more observations. If the test cases design is broken, the reason
> for it reporting BROKEN, then this is a genuine issues. We would need to
> fix them. But, when a test case reports BROKEN, is it justified to put
> the whole blame on the test case. Did we verify whether the issue can
> also be with:
>
>      1. Libraries,
>      2. Kernel (the very purpose for which test case is designed),
>
> What will be the point if we just want the test case to PASS ?? So, do
> we want to point that the kernel is always OK, and we just want the test
> cases to report PASS for it, else the test case is broken ?
>
> Fixing build issues:
> LTP cannot stop inheriting new test cases with each passing day. But,
> how do we guarantee that the test suite build will succeed on:
>      1. every Distro,
>      2. every arch,
>      3. every kernel
>
> Unlike the Linux Kernel, which carries all the stuff needed to build
> itself on any arch, an user land project like LTP is completely
> dependant on the system headers/libraries to complete it=C5=9B build. So,
> when these stuff are not consistent across the architecture and Distro
> geography, so, how do we solve the problem. And in most of the instance
> we find that 50% of our effort/code goes in fixing this dependencies,
> rather than into the actual kernel test code. And, yes, to cater to the
> need, LTP has embraced the AUTOCONF framework.
>
> Fixing Real test case BROKEN issues:
> Here plays one of the unfortunate drawbacks of the Open Source Projects.
> Everything does not get funded for eternity. When test cases were
> checked in for some feature in the kernel, the project should have been
> funded. Now, when the ABIs/functionality in the kernel changes, the
> original author of those test cases is no more funded to make the
> corresponding changes in the concerned tests. So, this can be solved
> only when somebody reports such issues with a patch rather than sending
> repeated reminders that such-and-such test cases are broken. I do not
> have any other idea of how this can be solved.
>
> I am not sure, if i am able to resolve all your doubts/concerns
> completely. Mike/others from LTP mailing list will may also be of some
> help.

not much else to say.  it's an open source project and if you arent willing=
 to=20
contribute to fixing it but rather just sit back and complain, then you can=
t=20
really be surprised when things dont move.
=2Dmike

--nextPart2408807.2YpRUGf9VP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVSY+AAoJEEFjO5/oN/WBr1kP/2a5ME0dLGhT61QYjctaPX0H
a/X/K1MpbW8dNiSHYWzuFMdY2TMKCKGzZJKBnfM+rNziAKNH68nB4Ri9SI0/eCpS
QhBEXDJLVmwJ+gt9+Ui4FwCyoyn16K8ydqldVJvHsPPDYbaKFnDNONNEWMgH9d4E
9RV/sBbjWtfnXj6CmrPEP3kI0zXI70JTJVPRnOBPT0oZ/zsl4PRIn8lajMlFB7pj
oD5bfUYL1TSHB7i4KJuolwbQ4NDkfC9lcVBlFAyIusVoCrNHVuRWbV2wDwiDo1se
uyp0IruPInToGAiG4nbArf63wzp/xWpIaWESUQw1H0R+hKO6iVoR0x3W52UhCKWZ
ovvBNFQ5e6wR1LKNr4zvoiI6rgiax+fF3Q69fwvJEJaBOcyxB9DR2IMRwcIlZCR5
pwgbqttKnfwTxp4+nrZ851ezuLOpB8ZDgNRgde+ElRE4UiDwf2S3jDnwhaIZg8fb
dmwDGDoOgmk74Ef+qH7irvOV6RFqfqpoTqvjI9+6iYZW8fp8D8rn3pCvIcwymroP
1qxBSHJH/EBch8foFNNWeIh8xGpl4pVW8jlC0XP1pMdWGGaXaT51Cx0XnDMIQE2P
hInaFpK17wnoq1pRMzPbwFzKEBHW6DL8q9lzswMZ47pnyIRDwgNVnES86K2I4+W2
bknUNHW6quBG6VAw/rde
=cGUb
-----END PGP SIGNATURE-----

--nextPart2408807.2YpRUGf9VP--


--===============3816113141727350932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============3816113141727350932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3816113141727350932==--

