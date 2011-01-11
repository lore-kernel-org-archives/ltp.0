Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PcXnB-0006wc-BA
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 06:33:17 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcXnA-0002gC-HY
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 06:33:17 +0000
Received: by wyb40 with SMTP id 40so19475821wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 10 Jan 2011 22:33:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <233343295.39412.1294705307001.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <783A1EB7-BF40-4188-BF63-81C2C43EAAAE@gmail.com>
	<233343295.39412.1294705307001.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Mon, 10 Jan 2011 22:33:10 -0800
Message-ID: <AANLkTinzRFkEX7Hf-seH+P_WbTudvG=-c02YWBBYybxY@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Jan 10, 2011 at 4:21 PM, CAI Qian <caiqian@redhat.com> wrote:
>
>> I applied your fixes but the test is still buggy in the following
>> ways:
>>
>> 1. It has to be run as root (otherwise it fails with EPERM opening the
>> file).
> That is true for lots of LTP tests. To get the most of our of tests, it
> requests root privilege. We can even setup config scripts to warning people
> about the non-root users. Again, what is the guideline here? We probably
> don't want to add many code to each of the test that required root.

tst_require_root(NULL) is all you need to do in setup() if you need
it. You can test a lot of EACCES and EPERM cases if you use users
other than root.

Most of the testcases that slack in this area that I've seen are the
newer ones. The older testcases by IBM and SGI do the right thing when
it comes to requiring root privileges.

>> 2. Even when the test is run as root it leaves around allocated
>> hugepages, despite the fact that the temporary filesystem has been
>> unmounted.
> Would you please be elaborate the failure? I can't see why it would work
> that way. The cleanup routine does this.
>
> - restore nr_hugepages
> - restore nr_overcommit_hugepages
> - unlink && umount (mmap case)
> - shmdt (shmget case)

It's a little better now that it's using a temporary directory, but it
still fails when I call it like:

./hugemmap05

on Fedora 13/i386 (first the mmap fails, then the test tries to do a
bunch of stuff in cleanup, including unmount the hugemmap filesystem
-- which fails with EBUSY -- and remove the temporary directory --
which fails because the mountpoint isn't unmounted -- and fails).

Thanks,
-Garrett

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
