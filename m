Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfTyo-0004z2-5t
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:05:26 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfTyn-0006lV-15
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 09:05:26 +0000
Received: by wwi18 with SMTP id 18so600187wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jan 2011 01:05:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <604599063.56180.1295424713619.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <488834807.56177.1295424703727.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<604599063.56180.1295424713619.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Wed, 19 Jan 2011 01:05:18 -0800
Message-ID: <AANLkTikeQ=tfLUo=OGW2La36MtmX2V+UbSvSCreGxQP=@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] rework code for oom and ksm tests
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

On Wed, Jan 19, 2011 at 12:11 AM, CAI Qian <caiqian@redhat.com> wrote:
> Mainly to reduce code duplication. Also, to add an option for ksm01 to
> use a different memory allocation unit size to take advantage of THP.
> In addition, adjust ksm01 according the latest upstream development
> effort,
> http://marc.info/?l=linux-mm&m=129473104716901&w=2
> http://marc.info/?l=linux-mm&m=129442718808733&w=2

Commit pending.
Thanks,
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
