Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfDSN-0000Xk-6R
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:26:51 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfDSM-00052V-AS
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:26:51 +0000
Received: by wwi18 with SMTP id 18so6132595wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 07:26:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1157769992.37634.1295363444199.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <C5520275-F1CD-46F9-A9CE-3DEC1A298FD0@gmail.com>
	<1157769992.37634.1295363444199.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 18 Jan 2011 07:25:00 -0800
Message-ID: <AANLkTinKuU6ZjEv6OX_DCVmHKNSZ_U4BZ83aFESaa8tL@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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

On Tue, Jan 18, 2011 at 7:10 AM, CAI Qian <caiqian@redhat.com> wrote:
>
>> I was in the middle of writing up a style guide before I accidentally
>> quite mousepad and lost my progress... Please look at the last couple
>> commits I signed off on and try to follow my example for how to do
>> things in a more consistent manner according to I've been trying to do
>> in the project over the past couple of weeks; I'll see if I can
>> rewrite bits and pieces of the style guide before nightfall.
> Would you need me to re-send those with the style fixed?

    It would make my life a lot easier so I could commit things more
quickly and in less error prone of a fashion as I have in the past
:/... remember: my primary system isn't Linux anymore, and the amount
of stuff you can run in a single core VM with Fedora 13 is extremely
limited / middle of the road as far as testing goes.
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
