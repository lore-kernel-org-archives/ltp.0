Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmUuZ-0005lj-Rj
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 16:25:31 +0000
Received: from mail-fx0-f214.google.com ([209.85.220.214])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmUuZ-0005mF-0P
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 16:25:31 +0000
Received: by fxm6 with SMTP id 6so499722fxm.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 08:25:24 -0800 (PST)
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
Message-Id: <B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100302152135.GA6691@us.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Date: Tue, 2 Mar 2010 08:25:16 -0800
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Sent from my iPhone

On Mar 2, 2010, at 7:21 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Iranna D Ankad (iranna.ankad@in.ibm.com):
>> LTP reports setcap is installed, but actually, my system has setcap
>> installed, along with all required libcap related rpms.
>>
>> mx3950:/opt/ltp # setc
>> setcap      setconsole  setctsid
>> mx3950:/opt/ltp #
>>
>> mx3950:/opt/ltp # rpm -qa | grep cap
>> libcap1-1.10-6.10
>> libcap2-2.11-2.15
>> libcap-progs-2.11-2.15
>> libpcap0-0.9.8-50.4.32
>> libcap2-32bit-2.11-2.15
>> libcap1-32bit-1.10-6.10
>> mx3950:/opt/ltp #
>
> THere are a bunch of #if directives in there (only looked at
> check_simple_capset.c which I assume is where your trouble is) which
> are not defined on my fedora 10 test system.  Don't know where they
> came from - they predate the git history.
>
> HAVE_SYS_CAPABILITY_H, HAVE_DECL_CAP_FROM_TEXT, etc.
>
> -serge

That would be from me; I do that via autoconf and they probably  
fubared the headers on Redhat or something... Do you have libcap-devel  
installed?

Fwiw, that probably could be grossly simplified at the top of the file  
or something, do I'll look into doing that later.

Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
