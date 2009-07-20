Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ghaskins@novell.com>) id 1MSuEW-0004tc-J6
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 14:52:52 +0000
Received: from victor.provo.novell.com ([137.65.250.26])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSuEP-0002sz-Ui
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 14:52:52 +0000
Message-ID: <4A6484B0.3050009@novell.com>
Date: Mon, 20 Jul 2009 10:52:32 -0400
From: Gregory Haskins <ghaskins@novell.com>
MIME-Version: 1.0
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	<1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	<200907102200.12804.sripathik@in.ibm.com>
	<1247244446.5040.0.camel@subratamodak.linux.ibm.com>
	<4A57884C.10401@us.ibm.com>
	<alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.2.00.0907201039140.3858@gandalf.stny.rr.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4493953288198766844=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ltp-list <ltp-list@lists.sf.net>, Clark Williams <clark.williams@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4493953288198766844==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67FB8764C4CDB6A6E1270BBB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67FB8764C4CDB6A6E1270BBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Rostedt wrote:
> On Fri, 10 Jul 2009, Darren Hart wrote:
>
>  =20
>> Subrata Modak wrote:
>>    =20
>>> On Fri, 2009-07-10 at 22:00 +0530, Sripathi Kodi wrote:
>>>      =20
>>>> On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
>>>>        =20
>>>>> Darren/Sri/Gowri,
>>>>>
>>>>> Where do you want me to put this exactly inside the RT tree ?
>>>>>          =20
>>>> Hi Subrata,
>>>>
>>>> Going by how the tests are organized currently, I think this should =
go
>>>> into it's own directory under testcases/realtime/func. We will need =
to
>>>> add a makefile to it. Are you looking at us to help you with this?
>>>>        =20
>>> Correct. Please send me a patch which integrates it into RT tests bui=
ld,
>>> install & run.
>>>      =20
>> Just got back from a week vacation and am burning through mail as fast=
 as I
>> can :-) Haven't had a look yet, but does this test use librttest.h?  I=
 suspect
>> not.  We'll need to adapt it to run within the existing ltp real-time =
testing
>> framework, which includes things like buffered output as well as mlock=
ing
>> support.
>>
>> Lastly, I'm not sure this test does anything effectively different tha=
n
>> prio-wake, already in the tree.

Just to add to Steven's comments below:  At the time that rt-migrate was
written, LTP and others lacked sufficient resolution in their testing to
reliably find the type of problem that rt-migratate can pinpoint
quickly.  IIRC, "football" was potentially capable of finding these
types of scheduler bugs, but it often failed to find it at all, or it
took 24h+ of runtime to find it.  Steven's test could find it in under a
second or two.  And, as Steven mentions below, rt-migrate is
additionally designed to look at the top N prio tasks (where N =3D cpu-co=
unt)

That said, I am not familiar with "prio-wake" so I am not sure if its
new or if it has direct overlap with Steven's test or not.

>>   My other concerns with the test are its
>> explicit 1ms preemption criteria (as Steven described it anyway).  We =
are
>> trying to move away from criteria being inherent in measurement tests,=
 and 1
>> ms seems like an awfully long priority inversion to be an acceptable c=
riteria
>> to many users.
>>
>> Steven, am I missing something conceptually here?
>>    =20
>
> Hmm, I missed this email, sorry for the late reply.
>
> What does prio-wake do?
>
> This test is what I used to develop the rt scheduler in mainline (as we=
ll=20
> as in -rt).  It wakes up N+1 tasks with lowering real time priorities. =

> Where N is the number of CPUs in the system. Then it makes sure that th=
e=20
> these tasks spread out across the CPUs. Most tests just test the highes=
t=20
> priority task in the system. But those tests usually miss the second=20
> highest prio task in the system. If you have a second highest prio task=
 in=20
> the system and a CPU is available to run, then it should run on that CP=
U.=20
> But what happens is that it can wait to be migrated and can take millis=
ecs=20
> to wake up.
>
> This test makes sure that all the high prio tasks that are in the runni=
ng=20
> state are actually running on a CPU if it can.
>
> Make sense?
>
> (BTW, current -rt and mainline now fail this test :-? )
>
> -- Steve
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20



--------------enig67FB8764C4CDB6A6E1270BBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkpkhLAACgkQlOSOBdgZUxkhqwCeNiFiUo24BVg7d5UGLepcrqVE
NykAni5XgpvTkRpq9SBUHNXnCwEwRt+V
=dQlA
-----END PGP SIGNATURE-----

--------------enig67FB8764C4CDB6A6E1270BBB--


--===============4493953288198766844==
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
--===============4493953288198766844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4493953288198766844==--

