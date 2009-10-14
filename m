Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mxtdo-0004W8-NP
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:31:04 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mxtdd-0006ww-8J
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:30:59 +0000
Received: by pzk26 with SMTP id 26so9548965pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 19:30:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A0780153D3FC@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
	<200910050018.12711.jpalecek@web.de>
	<8368651DACC1964480F951191B94A0780153CC19@svexch01.mvista.com>
	<1255445017.8438.66.camel@subratamodak.linux.ibm.com>
	<364299f40910131220x162b5e02u65bae87e349f7dda@mail.gmail.com>
	<364299f40910131221h7f9acf01te65be5b462281463@mail.gmail.com>
	<8368651DACC1964480F951191B94A0780153D3FC@svexch01.mvista.com>
Date: Tue, 13 Oct 2009 19:30:47 -0700
Message-ID: <364299f40910131930of1dd362kc8096a39d3f1180c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
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
To: Henry Yei <hyei@mvista.com>
Cc: jpalecek@web.de, LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, Oct 13, 2009 at 7:25 PM, Henry Yei <hyei@mvista.com> wrote:
> All,
>
> Here is the openfile patch without the Makefile changes as they are not n=
eeded with the new Makefile changes.
> I regenerated and tested the patch with the latest version of the ltp fro=
m CVS.
>
> I had trouble compiling LTP without autoconf 2.61 even after following in=
structions from the README.mk-users file to try to build without autoconf. =
Most of our test hosts are running autoconf 2.59. Does anyone have updated =
instructions?
>
>
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Tuesday, October 13, 2009 12:22 PM
> To: subrata@linux.vnet.ibm.com
> Cc: Henry Yei; jpalecek@web.de; LTP Mailing List
> Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
>
> On Tue, Oct 13, 2009 at 12:20 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>> On Tue, Oct 13, 2009 at 7:43 AM, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>>> On Mon, 2009-10-05 at 14:33 -0700, Henry Yei wrote:
>>>> On Wednesday 04, October 2009 04:06:46 Jiri Palecek wrote:
>>>>
>>>> Hello,
>>>>
>>>> On Wednesday 30 September 2009 04:06:46 Henry Yei wrote:
>>>> > This patch for openfile contains the following changes:
>>>> > - test output to use tst_resm functions
>>>> > - sets ups and cleans up tmp dir properly
>>>> > - closes all opened file descriptors before thread exit(fixes nfs is=
sues on removing tmp dir)
>>>> >
>>>> > Signed-off-by: Henry Yei <hyei@mvista.com>
>>>> >
>>>> >
>>>> > This test opens multiple file descriptors to the same file. Perhaps =
the author meant to open file handles for separate files?
>>>>
>>>> This is suspicious, for me too. But maybe there is some logic behind o=
pening the same file many times.
>>>>
>>>> I just have a small remark about your patch: Shouldn't you call close_=
files() here, too? (With a partially full fd_list array handled, of course)
>>>>
>>>> +void * threads(void* thread_id_) {
>>>> + =A0 =A0 int thread_id =3D (uintptr_t) thread_id_;
>>>> + =A0 =A0 char errmsg[80];
>>>> + =A0 =A0 FILE *fd_list[MAXFILES];
>>>> + =A0 =A0 int i;
>>>> +
>>>> + =A0 =A0 /* Open files */
>>>> + =A0 =A0 for (i =3D 0; i < numfiles; i++) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Thread =A0%d : Openi=
ng file number %d \n", thread_id, i);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((fd_list[i] =3D fopen(filename, "rw")) =
=3D=3D NULL) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(errmsg, "FAIL - Coul=
dn't open file #%d", i);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(errmsg);
>>>>
>>>>
>>>>
>>>> Jiri,
>>>>
>>>> Thanks for reviewing the patch. Yes, that was an omission on my part. =
I have attached an updated patch. Let me know if there are any more comment=
s.

Hi Henry,
    You're suffering from an issue that I wanted to solve... I think
that we should be checking in autoconf'ed files (not _pre-configure'd_
files), but others object with my point of view.
    You can do it without autoconf, but the problem is that you'll
have to do a lot of hand-editing to make things work properly. Do you
want me to send you the autoconf'ed files?
HTH,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
