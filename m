Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NMueM-0005xM-Le
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 02:39:02 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMueE-00053q-SH
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 02:39:02 +0000
Received: by pxi27 with SMTP id 27so2313626pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Dec 2009 18:38:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40912210110m27ba4276g8cbce963d077e4a0@mail.gmail.com>
References: <1713808934.618481261374276809.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1964681948.618501261374329418.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<364299f40912210110m27ba4276g8cbce963d077e4a0@mail.gmail.com>
Date: Mon, 21 Dec 2009 18:38:48 -0800
Message-ID: <364299f40912211838w7ab92a76u50223c29588b6f1a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "unzip01" testcase failed.
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Mon, Dec 21, 2009 at 1:10 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Sun, Dec 20, 2009 at 9:45 PM, Caspar Zhang <czhang@redhat.com> wrote:
>>
>> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>>
>>> I'm not convinced that this is the right solution because most of
>>> what's done here just replaced $(DIR)'s value with the bareword
>>> value.
>>> .INTERMEDIATE may be the only piece of value here, but I was avoiding
>>> it because it's a 3.81-ism I thought...
>>
>> How about this one (see the attachment)?
>
> AH... -[Rr] was missing.
>
> RM += -[Rr]
>
> will do that. The rest just seems spurious.

    Uh, this was already committed on HEAD:

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/commands/unzip/Makefile?r1=1.9&r2=1.8

    What version are you working with?
Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
