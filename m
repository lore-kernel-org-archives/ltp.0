Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <marc@tensilica.com>) id 1M95tm-0006rf-0y
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 23:17:34 +0000
Received: from mailgw.tensilica.com ([65.205.227.134])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M95tk-0006xM-SH
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 23:17:33 +0000
From: Marc Gauthier <marc@tensilica.com>
Date: Tue, 26 May 2009 13:14:59 -0700
Message-ID: <522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
References: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Detect test results more accurately
	when	generating HTML
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, Rohit Verma <rohit.170309@gmail.com>
Cc: Ltp-List <ltp-list@lists.sf.net>

Okay, so I looked at it a bit...

Isn't the fundamental race condition because pan outputs
<<<test_start>>> *after* doing the fork(), rather than before?

If some status info can't be output that early, maybe it just
needs to be output after <<<execution_status>>> as part of
write_test_end() ?

-Marc

P.S.  I find it useful to run genhtml against older LTP releases
(including those without genhtml), so might be useful to keep the
out-of-order workarounds even if ordering is fixed in this release.


Subrata Modak wrote:
> How much would you want to delay ? May be to some microsecs !!
> However delaying is not a good option, but, i am ready to consider.
> See, what is the reasanable time so that this problem vanishes.
>
> Meanwhile, i have generated this small patch. It tries to
> flush all data
> to be written to STDOUT before the Parent (PAN) tries to write his
> next tag. Moreover, i have included the fflush() to be executed inside
> the if()=C2=B4s domain whenever the parent is writing from <<test_start>>
> till <<test_output>>. See, if this can help in solving the problem.
>
> Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> ---
>
> --- ltp-intermediate-20090521/pan/ltp-pan.c.orig
> 2009-05-26 16:30:39.000000000 +0530
> +++ ltp-intermediate-20090521/pan/ltp-pan.c   2009-05-26
> 19:44:37.000000000 +0530
> @@ -1015,6 +1015,7 @@ static pid_t run_child(struct coll_entry
>               errbuf[errlen] =3D '\0';
>               /* fprintf(stderr, "%s", errbuf); */
>               waitpid(cpid, &status, 0);
> +             fflush(stdout); /* Flush any data before
> writing <<test_end>>*/
>               if (WIFSIGNALED(status)) {
>                       termid =3D WTERMSIG(status);
>                       termtype =3D "signaled";
> @@ -1300,14 +1301,14 @@ static void copy_buffered_output(struct
>
>  static void write_test_start(struct tag_pgrp *running, const
> char *init_status)
>  {
> -     if (!strcmp(reporttype, "rts"))
> +     if (!strcmp(reporttype, "rts")) {
>               printf("%s\ntag=3D%s
> stime=3D%ld\ncmdline=3D\"%s\"\ncontacts=3D\"%s\"\nanalysis=3D%s\niniti
ation_status=3D\"%s\"\n%s\n",
>                      "<<<test_start>>>",
>                      running->cmd->name, running->mystime,
> running->cmd->cmdline, "",
>                      "exit", init_status,
>                      "<<<test_output>>>");
> -
>       fflush(stdout);
> +     }
>  }
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
