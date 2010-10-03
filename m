Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2Cpj-0004KF-2W
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:53:43 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2Cpi-0007ve-7j
	for ltp-list@lists.sourceforge.net; Sun, 03 Oct 2010 00:53:43 +0000
Received: by iwn2 with SMTP id 2so7050691iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 02 Oct 2010 17:53:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1083549076.997191285828921616.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <587303608.585691285347829006.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1083549076.997191285828921616.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Sat, 2 Oct 2010 17:53:36 -0700
Message-ID: <AANLkTi=K+LMkKTfn+hzJ+kzine9A1ZaefZC5wnxL1cFy@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] buffered I/O causes testcases/network/nfs/nfsstress
	failure
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Wed, Sep 29, 2010 at 11:42 PM, Caspar Zhang <czhang@redhat.com> wrote:
>
> ----- "Caspar Zhang" <czhang@redhat.com> wrote:
>
>> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>
>> > On Tue, Sep 7, 2010 at 8:13 AM, Caspar Zhang <czhang@redhat.com>
>> > wrote:
>> > >
>> > > ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>> > >
>> > >> On Tue, Sep 7, 2010 at 5:18 AM, Caspar Zhang <czhang@redhat.com>
>> > >> wrote:
>> > >> > Hi all,
>> > >> > =A0When I run testcases/network/nfs/nfsstress/ test, I found
>> > sometimes
>> > >> the
>> > >> > test failed due to buffered I/O, in detail, for example, there
>> > are
>> > >> the following
>> > >> > lines in make_tree.c :
>> > >> >
>> > >> > 544 =A0 =A0 numchar[0] =3D sprintf(prog_buf,
>> > >> > 545 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "main()\n{\n\t printf(\"hello
>> > world\");\n}\n");
>> > >> >
>> > >> > sometimes the generated .c file will be:
>> > >> > ^@ain() // <- strange ASCII char '^@' appears instead of 'm'
>> > >> > {
>> > >> > =A0 =A0 =A0 =A0printf("hello world");
>> > >> > }
>> > >> >
>> > >> > And running with this .c file will cause error.
>> > >> >
>> > >> > That is to say, string 'prog_buf' gets a mistake during
>> sprintf.
>> > And
>> > >> there're
>> > >> > somewhere else using buffered I/O in this test as well. Do we
>> > have
>> > >> an
>> > >> > unbuffered solution to this test?
>> > >>
>> > >> That seems a bit odd. Is the NFS mount/server TCP or UDP?
>> > >
>> > > Hi Garrett, it's UDP.
>> >
>> > =A0 =A0 Ok. Something else that might be good to note is whether or not
>> > it's v2, v3, or v4 on the client and server side.
>> > =A0 =A0 Could you please try with TCP and see whether or not the issue
>> > persists? I'm just curious if it's a potentially real issue with
>> NFS
>> > code in the kernel, random networking infrastructure issues, etc.
>> > Thanks,
>>
>> Hi Garrett, sorry for late reply. I tried all combinations of TCP/UDP
>>
>> and v2/v3/v4 but the error still existed. I wrote a workaround patch
>> and re-tested with the combinations above, the issue seemed to be
>> solved.
>>
>> This patch have 2 fixes:
>>
>> a) extend malloc length from 1024 to 2048. If we keep both default dir
>> num
>> and file num as 100, the string length of dirname/filename length will
>> be
>> easily > 1024 bytes. This will cause string buffer overflow and the
>> main.c
>> may be filled with such wrong chars:
>> '19123.97/19123.98/19123.99/19123.99.0.cmain()...'
>>
>> b) add tmpdirname var in some sprintf sentences. According the man
>> page of
>> sprintf:
>>
>> NOTES
>> =A0 =A0 =A0 =A0Some programs imprudently rely on code such as the follow=
ing
>> =A0 =A0 =A0 =A0 =A0 =A0sprintf(buf, "%s some further text", buf);
>> =A0 =A0 =A0 =A0to append text to buf. =A0However, the standards explicit=
ly note
>> =A0that the results are undefined if source =A0and =A0destination buffers
>> =A0overlap =A0when =A0calling =A0sprintf(), =A0snprintf(), vsprintf(), a=
nd
>> =A0vsnprintf(). =A0Depending on the version of gcc(1) used, and the
>> =A0compiler options employed, calls such as the above will not produce
>> =A0the expected results.
>>
>> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> Hi all, any comments on this?
>
> Patch was tested under RHEL5 and RHEL6 and passed.

    Committed. BTW, I fixed the second `sync;' call.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
