Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M61aM-0004Eg-Gl
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 12:04:50 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M61aF-0004XH-Oq
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 12:04:50 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-l0FOxSTZlxifOG+3j2bx"
Date: Mon, 18 May 2009 17:32:57 +0530
Message-Id: <1242648178.5161.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] Fwd: Returned mail: see transcript for details
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>


--=-l0FOxSTZlxifOG+3j2bx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e32.co.us.ibm.com id
	n4IC1H0U001028

Jiri,

What is your correct e-mail id ??

--Subrata

-------- Forwarded Message --------
From: Mail Delivery Subsystem <MAILER-DAEMON@e37.co.us.ibm.com>
To: subrata@linux.vnet.ibm.com
Subject: Returned mail: see transcript for details
Date: Mon, 18 May 2009 05:59:43 -0600

The original message was received at Mon, 18 May 2009 05:59:42 -0600
from d03relay04.boulder.ibm.com [9.17.195.106]

   ----- The following addresses had permanent fatal errors -----
<jpalecek@web.de>
    (reason: 550 <jpalecek@web.de> Benutzer hat das Speichervolumen ueber=
schritten. / User has exhausted allowed storage space.)

   ----- Transcript of session follows -----
... while talking to mx-ha01.web.de.:
>>> DATA
<<< 550 <jpalecek@web.de> Benutzer hat das Speichervolumen ueberschritten=
. / User has exhausted allowed storage space.
550 5.1.1 <jpalecek@web.de>... User unknown
<<< 503 Valid RCPT TO <recipient> must precede DATA
email message attachment
-------- Forwarded Message --------
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: Ji=C5=99=C3=AD Pale=C4=8Dek <jpalecek@web.de>
Cc: CAI Qian <caiqian@cclom.cn>, ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH] Fix the splice02 test
Date: Mon, 18 May 2009 17:29:59 +0530

On Fri, 2009-05-15 at 19:24 +0200, Ji=C5=99=C3=AD Pale=C4=8Dek wrote:=20
> On Wed, 13 May 2009 16:47:35 +0200, CAI Qian <caiqian@cclom.cn> wrote:
>=20
> > From: Jiri Palecek <jpalecek@web.de>
> > Subject: [LTP] [PATCH] Fix the splice02 test
> > Date: Wed, 13 May 2009 00:34:15 +0200
> >
> >>   Particularly:
> >>
> >>    - TEST_ERRNO is only set when the syscall is executed using the
> >>      TEST() macro. The tests gave bad error messages because of that.
> >>
> >>    - The end of the test was dead code; moved the TPASS code to pass=
 at
> >>      the end of file.
> >>
> >>    - The test assumes std. input is a pipe; reflect this in the runt=
est
> >>      file
> >>
> >> Regards
> >>      Jiri Palecek
> >>
> >> Signed-off-by: Jiri Palecek <jpalecek@web.de>
> >> ---
> >>   runtest/syscalls                            |    2 +-
> >>   testcases/kernel/syscalls/splice/splice02.c |   16 ++++++---------=
-
> >>   2 files changed, 7 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/runtest/syscalls b/runtest/syscalls
> >> index 9b7b2ca..33beff0 100644
> >> --- a/runtest/syscalls
> >> +++ b/runtest/syscalls
> >> @@ -1033,7 +1033,7 @@ sockioctl01 sockioctl01
> >>    #splice test
> >>   splice01 splice01
> >> -splice02 echo "Test splice02()" > splice02-temp; splice02 splice02-=
temp
> >> +splice02 seq 1 10000000 | splice02 splice02-temp
> >>    tee01 tee01
> >>   diff --git a/testcases/kernel/syscalls/splice/splice02.c
> >> b/testcases/kernel/syscalls/splice/splice02.c
> >> index 321d002..16bff86 100644
> >> --- a/testcases/kernel/syscalls/splice/splice02.c
> >> +++ b/testcases/kernel/syscalls/splice/splice02.c
> >> @@ -108,7 +108,6 @@ void setup() {
> >>    int main(int ac, char **av) {
> >>   	int fd =3D 0;
> >> -	int ret =3D 0;
> >>   =09
> >>           setup();
> >>   @@ -118,26 +117,23 @@ int main(int ac, char **av) {
> >>   	}
> >>   	fd=3Dopen(av[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
> >>   	if(fd < 0 ) {
> >> -           tst_resm(TFAIL, "%s failed - errno =3D %d : %s", TCID, =20
> >> TEST_ERRNO,
> >> strerror(TEST_ERRNO));
> >> +		tst_resm(TFAIL, "open(%s) failed - errno =3D %d : %s", av[1], err=
no,
> >> strerror(errno));
> >>   	   cleanup();
> >>   	   tst_exit();
> >>   	}
> >>   		=09
> >>           do {
> >> -	    ret =3D splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0);
> >> -	    if (ret < 0) {
> >> -            	tst_resm(TFAIL, "%s failed - errno =3D %d : %s",TCID, =
=20
> >> TEST_ERRNO,
> >> strerror(TEST_ERRNO));
> >> +					TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
> >> +	    if (TEST_RETURN < 0) {
> >> +            	tst_resm(TFAIL, "splice failed - errno =3D %d : %s", =20
> >> TEST_ERRNO,
> >> strerror(TEST_ERRNO));
> >>   	        cleanup();
> >>   		tst_exit();
> >>   	    } else
> >> -            if (ret < SPLICE_SIZE){
> >> +            if (TEST_RETURN =3D=3D 0){
> >> +							tst_resm(TPASS, "splice() system call Passed");
> >>   	        cleanup();
> >>   	        tst_exit();
> >>   	    }
> >>   	} while(1);
> >> -
> >> -	close(fd);
> >> -        tst_resm(TPASS, "splice() system call Passed");
> >> -        tst_exit();
> >>   }
> >>   -- 1.6.2
> >
> > Can't apply this patch -- long lines are wrapped. Please re-send it.
>=20
> It seems not to be caused by wrapped lines - I can still see them in th=
e =20
> digest. However, some empty lines seem to be lost.
>=20
> Anyway, it should be better now (see attachment).

Thanks.

Regards--
Subrata

>=20
> Regards
>     Jiri Palecek
> -----------------------------------------------------------------------=
------- Crystal Reports - New Free Runtime and 30 Day Trial Check out the=
 new simplified licensing option that enables unlimited royalty-free dist=
ribution of the report engine for externally facing server and web deploy=
ment. http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--=-l0FOxSTZlxifOG+3j2bx
Content-Type: message/delivery-status
Content-Transfer-Encoding: 7bit

Reporting-MTA: dns; e37.co.us.ibm.com
Received-From-MTA: DNS; d03relay04.boulder.ibm.com
Arrival-Date: Mon, 18 May 2009 05:59:42 -0600

Final-Recipient: RFC822; jpalecek@web.de
Action: failed
Status: 5.1.1
Remote-MTA: DNS; mx-ha01.web.de
Diagnostic-Code: SMTP; 550 <jpalecek@web.de> Benutzer hat das Speichervolumen
	ueberschritten. / User has exhausted allowed storage space.
Last-Attempt-Date: Mon, 18 May 2009 05:59:43 -0600

--=-l0FOxSTZlxifOG+3j2bx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--=-l0FOxSTZlxifOG+3j2bx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-l0FOxSTZlxifOG+3j2bx--


