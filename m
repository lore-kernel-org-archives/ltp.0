From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 24 Mar 2016 11:38:17 -0400 (EDT)
Subject: [LTP] readahead02 failure on PPC
In-Reply-To: <SN1PR12MB07827F3DA5BDF10860ED7DC4EE820@SN1PR12MB0782.namprd12.prod.outlook.com>
References: <f688d3da-69f3-4199-b3a4-e603130414d1@email.android.com>
 <AF04265A3FC2B144B9892F621A394E13EA3F898B@tethys>
 <SN1PR12MB07827F3DA5BDF10860ED7DC4EE820@SN1PR12MB0782.namprd12.prod.outlook.com>
Message-ID: <978771477.14173505.1458833897194.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it





----- Original Message -----
> From: "Kshitij Malik" <Kshitij.Malik@mitel.com>
> To: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>, "Jan Stancek" <jsta=
ncek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 24 March, 2016 3:40:21 PM
> Subject: Re: [LTP] readahead02 failure on PPC
>=20
> Thank you Julio for the update.
>=20
> Jan,
>=20
> Can we take the changes shared by you as an official fix?

I'm on the fence whether we should also add configure check for it.
Wrapper is in glibc since 2.3, which is quite old. Let's try posting
it as is and see if anyone objects.

Regards,
Jan

>=20
> Thanks
> KK
> ________________________________________
> From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
> Sent: Wednesday, March 23, 2016 01:46
> To: Kshitij Malik
> Cc: Jan Stancek; ltp@lists.linux.it
> Subject: RE: [LTP] readahead02 failure on PPC
>=20
> Hi again,
>=20
> Additionally, to previous comments, I try the patch in a 32bits system (w=
ith
> Kernel 3.14) and the TWARN is gone.
>=20
> I perform the test 10 times in two boards: 1) 32 bits with one core and 5=
12MB
> RAM and 2) 32 bits with two cores and same RAM:
>=20
> - With patch: 5 times show PASS in both boards
> - Without patch: 5 times show FAIL in both boards
>=20
> This time, I don=E2=80=99t get inconsistent results.
>=20
> Regards
>=20
> Julio
>=20
> > -----Original Message-----
> > From: Kshitij Malik [mailto:Kshitij.Malik@mitel.com]
> > Sent: Wednesday, March 23, 2016 10:55 AM
> > To: Julio Cruz Barroso
> > Cc: Jan Stancek; ltp@lists.linux.it
> > Subject: RE: [LTP] readahead02 failure on PPC
> >
> > Hi Julio,
> >
> > Thank you for the update.
> >
> > I was also getting the /proc/pid/io error to start with and I fixed it =
by
> > enabling kernel configurations CONFIG_TASKSTATS,
> > CONFIG_TASK_IO_ACCOUNTING and other related configs.
> >
> > These configs creates the io directory for a thread in proc.
> >
> > Jan,
> >
> > Do you think your fix can be used as an official patch?
> >
> > Thanks
> > KK
> >
> > On Mar 22, 2016 22:39, Julio Cruz Barroso <julio.cruz@smartmatic.com>
> > wrote:
> > >
> > > Hi Jan, Kshitij,
> > >
> > > Checking my logs (imx6 32bits based platform) the error is similar [1=
]:
> > >
> > > readahead02 0 TWARN : readahead02.c:324: using less cache than
> > expected
> > >
> > > However, the results were not consistent, because, once time PASS and
> > another FAIL (with previous TWARN).
> > >
> > > Another thing different was (in my case):
> > >
> > > readahead02 3 TCONF : readahead02.c:309: Your system doesn't have
> > /proc/pid/io, unable to determine read bytes during test
> > >
> > > This last one, is the part 1 of the test case (read bytes during test=
).
> > > The part
> > 2 (verify the cache) is the same TWARN.
> > >
> > > At the end, I skipped this test case because the results were not
> > > consistent
> > and need further analysis.
> > >
> > > Regards,
> > > Julio
> > >
> > >
> > > [1] logs for imx6: https://justpaste.it/s4zk
> > >
> > > -----Original Message-----
> > > From: ltp [mailto:ltp-bounces+julio.cruz=3Dsmartmatic.com@lists.linux=
.it]
> > > On
> > Behalf Of Julio Cruz Barroso
> > > Sent: Tuesday, March 22, 2016 11:19 PM
> > > To: Jan Stancek
> > > Cc: Julio Cruz; Kshitij Malik; ltp@lists.linux.it
> > > Subject: Re: [LTP] readahead02 failure on PPC
> > >
> > > Hi Jan, Kshitij,
> > >
> > > I just saw this email!
> > >
> > > I will review the issue because I cannot remember the result details =
and
> > > let
> > you know tomorrow (CST).
> > >
> > > I expect also to upload the others patchs reviewed.
> > >
> > > Regards
> > >
> > > Julio
> > >
> > >
> > > > On Mar 22, 2016, at 5:50 PM, Jan Stancek <jstancek@redhat.com> wrot=
e:
> > > >
> > > > Kshitij
> > >
> > > --
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > ________________________________
> > NOTE: This e-mail (including any attachments) is for the sole use of the
> > intended recipient(s) and may contain information that is confidential
> > and/or
> > protected by legal privilege. Any unauthorized review, use, copy,
> > disclosure
> > or distribution of this e-mail is strictly prohibited. If you are not t=
he
> > intended
> > recipient, please notify Mitel immediately and destroy all copies of th=
is
> > e-
> > mail. Mitel does not accept any liability for breach of security, error=
 or
> > virus
> > that may result from the transmission of this message.
>=20
