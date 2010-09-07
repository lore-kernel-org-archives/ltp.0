Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oszay-0001od-Uh
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 14:56:24 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oszay-00086d-0m
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 14:56:24 +0000
Received: by bwz12 with SMTP id 12so5415942bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Sep 2010 07:56:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1916720720.235131283861925077.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <1491422708.234901283861656504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1916720720.235131283861925077.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 7 Sep 2010 07:56:18 -0700
Message-ID: <AANLkTikGbs8NvSSvt6WabaS9=QsPsj1rDXmBuiT8EP-6@mail.gmail.com>
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

On Tue, Sep 7, 2010 at 5:18 AM, Caspar Zhang <czhang@redhat.com> wrote:
> Hi all,
> =A0When I run testcases/network/nfs/nfsstress/ test, I found sometimes the
> test failed due to buffered I/O, in detail, for example, there are the fo=
llowing
> lines in make_tree.c :
>
> 544 =A0 =A0 numchar[0] =3D sprintf(prog_buf,
> 545 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "main()\n{\n\t printf(\"hello world\"=
);\n}\n");
>
> sometimes the generated .c file will be:
> ^@ain() // <- strange ASCII char '^@' appears instead of 'm'
> {
> =A0 =A0 =A0 =A0printf("hello world");
> }
>
> And running with this .c file will cause error.
>
> That is to say, string 'prog_buf' gets a mistake during sprintf. And ther=
e're
> somewhere else using buffered I/O in this test as well. Do we have an
> unbuffered solution to this test?

That seems a bit odd. Is the NFS mount/server TCP or UDP?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
