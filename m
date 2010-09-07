Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Osx8X-0004L5-1z
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 12:18:53 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Osx8U-0001kT-OA
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 12:18:53 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx01.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
	o87CIjfE003255
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Sep 2010 08:18:45 -0400
Date: Tue, 7 Sep 2010 08:18:45 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1916720720.235131283861925077.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1491422708.234901283861656504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] buffered I/O causes testcases/network/nfs/nfsstress failure
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
To: LTP List <ltp-list@lists.sourceforge.net>

Hi all,
  When I run testcases/network/nfs/nfsstress/ test, I found sometimes the
test failed due to buffered I/O, in detail, for example, there are the following
lines in make_tree.c :

544     numchar[0] = sprintf(prog_buf,
545                 "main()\n{\n\t printf(\"hello world\");\n}\n");

sometimes the generated .c file will be:
^@ain() // <- strange ASCII char '^@' appears instead of 'm'
{
        printf("hello world");
}

And running with this .c file will cause error.

That is to say, string 'prog_buf' gets a mistake during sprintf. And there're
somewhere else using buffered I/O in this test as well. Do we have an 
unbuffered solution to this test?

Thanks,
Caspar

-- 
Quality Assurance Associate (Kernel) in
Red Hat Inc. (Beijing R&D Branch)

TEL: +86-10-62608150
Web: http://www.redhat.com/

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
