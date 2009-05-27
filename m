Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M9CsA-0003QG-8E
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 06:44:22 +0000
Received: from mail-ew0-f168.google.com ([209.85.219.168])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9Cs8-0002Uo-65
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 06:44:22 +0000
MIME-Version: 1.0
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
References: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
Date: Wed, 27 May 2009 12:14:18 +0530
Message-ID: <d51f89b0905262344h46722756vb255541a47904dbe@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] [PATCH] Detect test results more accurately when
	generating HTML
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
To: Marc Gauthier <marc@tensilica.com>
Cc: Ltp-List <ltp-list@lists.sf.net>

Hi Marc,

I think this a possible solution. I think the tag "initiation_status=3D"
can be moved after <<<execution_status>>>. Moving this tag to
write_test_end() and shifting write_test_start() before fork() might
solve the problem. However, corresponding changes have to be done in
genhtml.pl

Subrata: Just let me your view on this. I'll try and come up with a
patch if the changes are acceptable.

Regards,
Rohit.



On Wed, May 27, 2009 at 1:44 AM, Marc Gauthier <marc@tensilica.com> wrote:
> Okay, so I looked at it a bit...
>
> Isn't the fundamental race condition because pan outputs
> <<<test_start>>> *after* doing the fork(), rather than before?
>
> If some status info can't be output that early, maybe it just
> needs to be output after <<<execution_status>>> as part of
> write_test_end() ?
>
> -Marc
>
> P.S. =A0I find it useful to run genhtml against older LTP releases
> (including those without genhtml), so might be useful to keep the
> out-of-order workarounds even if ordering is fixed in this release.
>
>
> Subrata Modak wrote:
>> How much would you want to delay ? May be to some microsecs !!
>> However delaying is not a good option, but, i am ready to consider.
>> See, what is the reasanable time so that this problem vanishes.
>>
>> Meanwhile, i have generated this small patch. It tries to
>> flush all data
>> to be written to STDOUT before the Parent (PAN) tries to write his
>> next tag. Moreover, i have included the fflush() to be executed inside
>> the if()=C2=B4s domain whenever the parent is writing from <<test_start>>
>> till <<test_output>>. See, if this can help in solving the problem.
>>
>> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
>> ---
>>
>> --- ltp-intermediate-20090521/pan/ltp-pan.c.orig
>> 2009-05-26 16:30:39.000000000 +0530
>> +++ ltp-intermediate-20090521/pan/ltp-pan.c =A0 2009-05-26
>> 19:44:37.000000000 +0530
>> @@ -1015,6 +1015,7 @@ static pid_t run_child(struct coll_entry
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 errbuf[errlen] =3D '\0';
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fprintf(stderr, "%s", errbuf); */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 waitpid(cpid, &status, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 fflush(stdout); /* Flush any data before
>> writing <<test_end>>*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WIFSIGNALED(status)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 termid =3D WTERMSIG(status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 termtype =3D "signaled";
>> @@ -1300,14 +1301,14 @@ static void copy_buffered_output(struct
>>
>> =A0static void write_test_start(struct tag_pgrp *running, const
>> char *init_status)
>> =A0{
>> - =A0 =A0 if (!strcmp(reporttype, "rts"))
>> + =A0 =A0 if (!strcmp(reporttype, "rts")) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("%s\ntag=3D%s
>> stime=3D%ld\ncmdline=3D\"%s\"\ncontacts=3D\"%s\"\nanalysis=3D%s\niniti
> ation_status=3D\"%s\"\n%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<<<test_start>>>",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0running->cmd->name, running->=
mystime,
>> running->cmd->cmdline, "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"exit", init_status,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"<<<test_output>>>");
>> -
>> =A0 =A0 =A0 fflush(stdout);
>> + =A0 =A0 }
>> =A0}
>>
>

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
