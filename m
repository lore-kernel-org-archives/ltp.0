Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfD8v-0003xs-PY
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:06:45 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfD8u-0002va-L7
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:06:45 +0000
Received: by iwn8 with SMTP id 8so6017746iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 07:06:39 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <2071432981.37105.1295362614543.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 18 Jan 2011 07:06:34 -0800
Message-Id: <C5520275-F1CD-46F9-A9CE-3DEC1A298FD0@gmail.com>
References: <2071432981.37105.1295362614543.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 1/3] rework code for oom and ksm tests
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

On Jan 18, 2011, at 6:56 AM, CAI Qian wrote:

> Mainly to reduce code duplication. Also, to add an option for ksm01 to
> use a different memory allocation unit size to take advantage of
> THP. In addition, adjust ksm01 according the latest upstream
> development effort,
> http://marc.info/?l=linux-mm&m=129473104716901&w=2
> http://marc.info/?l=linux-mm&m=129442718808733&w=2
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>

	I was in the middle of writing up a style guide before I accidentally quite mousepad and lost my progress... Please look at the last couple commits I signed off on and try to follow my example for how to do things in a more consistent manner according to I've been trying to do in the project over the past couple of weeks; I'll see if I can rewrite bits and pieces of the style guide before nightfall.
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
