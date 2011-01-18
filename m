Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pf7x6-0008VH-F0
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:34:12 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf7x3-0003Li-Jz
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:34:10 +0000
Received: by mail-ww0-f53.google.com with SMTP id 18so5820743wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 01:34:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1690330537.28428.1295342210063.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <1509621163.85163.1293424864766.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1690330537.28428.1295342210063.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 18 Jan 2011 01:34:06 -0800
Message-ID: <AANLkTim+7dZv-+OWMEhrVuFKmHOTKyiinSTsBqf4Hf0F@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v3 1/5] oom01: test OOM
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Tue, Jan 18, 2011 at 1:16 AM, CAI Qian <caiqian@redhat.com> wrote:
> Hi Garrett,
>
> Any comment/feedback to merge this patchset? I have some new development want to push upstream but depends on this.
>
> Thanks.

Committing now -- please provide any needed patches for runtest if you
feel that this test is stable enough to run in mainline LTP.
Thanks!
-Garrett

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
