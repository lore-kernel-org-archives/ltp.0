Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pa0BE-0005MA-SI
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 06:15:36 +0000
Received: from mail-ww0-f67.google.com ([74.125.82.67])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pa0BD-0006yJ-TX
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 06:15:36 +0000
Received: by wwb31 with SMTP id 31so4353199wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Jan 2011 22:15:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1721058193.119579.1294116494383.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <AANLkTimdcjx7DmoWgsXfS25LymO0U2RFkjS-uNhAnfMD@mail.gmail.com>
	<1721058193.119579.1294116494383.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Mon, 3 Jan 2011 22:15:28 -0800
Message-ID: <AANLkTin7xjYuquA=tsn0=_9gGUhC+n2D9m-p1XkoA6r3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] hugemmap05 issues
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
To: CAI Qian <caiqian@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

    Ack -- gotcha. Too much stuff going on... I'll revert some of the
changes and fix things up a bit.
Thanks,
-Garrett

On Mon, Jan 3, 2011 at 8:48 PM, CAI Qian <caiqian@redhat.com> wrote:
>
>> TESTDIR isn't publicly visible anymore because people really shouldn't
>> be mucking around with that value, or querying it if they haven't
>> called tst_tmpdir (which is actually what you did in this test!).
> I am sorry about that. That is why I had sent a follow-up patch to address
> it,
> http://marc.info/?l=3Dltp-list&m=3D129379291515012&w=3D2
>
>> > Again, what issues are your facing with this code?
>> >> + char *tmp_tstdir;
>> >> +
>> >> + tmp_tstdir =3D get_tst_tmpdir();
>> >> + if (tmp_tstdir =3D=3D NULL)
>> >> + tst_brkm(TBROK|TERRNO, cleanup, "get_tmp_tstdir failed");
>> >> + snprintf(s, BUFSIZ, "%s/hugemmap05/file", tmp_tstdir);
>> >> + free(tmp_tstdir);
>> >> +
>> >> + fd =3D open(s, O_CREAT|O_RDWR, 0755);
>> >> if (fd =3D=3D -1)
>> >> tst_brkm(TBROK|TERRNO, cleanup, "open");
>> >> addr =3D mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
>> >> @@ -195,19 +203,14 @@ static void overcommit(void)
>> >> return;
>> >> fclose(fp);
>> >> }
>> >> - if (shmid !=3D -1) {
>> >> - tst_resm(TINFO, "shmid: 0x%x", shmid);
>> >> - shmaddr =3D shmat(shmid, ADDR, SHMAT_FLAGS);
>> >> - if (shmaddr =3D=3D (void *)-1)
>> >> - tst_brkm(TBROK|TERRNO, cleanup, "shmat");
>> >> - write_bytes(shmaddr);
>> >> - read_bytes(shmaddr);
>> >> - } else {
>> >> - write_bytes(addr);
>> >> - read_bytes(addr);
>> >> - }
>> > As you can read from the help(), the test can allocate hugepages
>> > either
>> > from shmget() or mmap(). In case of shmget(), a global variable
>> > shmid with
>> > the default value -1 will be change to 1 via command-line,
>>
>> Ok, I must have missed that part. Sorry...
>>
>> > static option_t options[] =3D {
>> > =A0 =A0 =A0 =A0{ "s", &opt_sysfs, NULL},
>> > =A0 =A0 =A0 =A0{ "m", &shmid, NULL},
>> > =A0 =A0 =A0 =A0{ "a:", &opt_alloc, &opt_allocstr},
>> > =A0 =A0 =A0 =A0{ NULL, NULL, NULL}
>> > };
>> >
>> > Therefore, there is a need to call shmat(). That is why it only call
>> > it
>> > when shmid !=3D -1. In case of mmap(), there is no need to call
>> > shmat().
>> >> + tst_resm(TINFO, "shmid: 0x%x", shmid);
>> >> + shmaddr =3D shmat(shmid, ADDR, SHMAT_FLAGS);
>> >> + if (shmaddr =3D=3D (void *)-1)
>> >> + tst_brkm(TBROK|TERRNO, cleanup, "shmat");
>> >> + write_bytes(shmaddr);
>> >> + read_bytes(shmaddr);
>> >> if (opt_sysfs) {
>> >> - tst_resm(TINFO, "check sysfs.");
>> >> + tst_resm(TINFO, "checking sysfs.");
>> >> if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
>> >> length / 2) !=3D 0)
>> >> return;
>> >> @@ -221,7 +224,7 @@ static void overcommit(void)
>> >> !=3D 0)
>> >> return;
>> >> } else {
>> >> - tst_resm(TINFO, "check /proc/meminfo.");
>> >> + tst_resm(TINFO, "checking /proc/meminfo.");
>> > If you are going to change the syntax here, there are many other
>> > places
>> > also need to changed to be consistent like,
>> > "check sysfs."
>> > "check /proc/meminfo before allocation."
>> > etc
>>
>> Agreed. It was just an example, and the point was to clearly state
>> with proper verb tenses so that people could get a clear idea of what
>> the test was doing instead of having to read the code to decypher the
>> intent of the test writer. Granted, I've gotten lazy and stopped
>> fixing some of these items in later commits because of all of the LOCs
>> I've made, but it needs to be fixed later because the grammar and
>> spelling used by test writers is less than desirable, which makes it
>> hard for folks trying to understand what the intention is behind these
>> tests.
> OK.
>
> Thanks.
>
> CAI Qian
>

---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
