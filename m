Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OLeoQ-0005SS-Dg
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 16:04:30 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OLeoO-0007zW-80
	for ltp-list@lists.sourceforge.net; Mon, 07 Jun 2010 16:04:30 +0000
Received: by iwn6 with SMTP id 6so1915774iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 07 Jun 2010 09:04:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1275901898.4851.2.camel@subratamodak.linux.ibm.com>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<1275834288.7037.3.camel@subratamodak.linux.ibm.com>
	<201006070651.o576p4S0093912@www262.sakura.ne.jp>
	<1275901898.4851.2.camel@subratamodak.linux.ibm.com>
Date: Mon, 7 Jun 2010 09:04:22 -0700
Message-ID: <AANLkTilYjsC9C0CcZu6wPAXCHlXsqsjnj6uYlCCFECdc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [linux-2.6.36] TOMOYO Linux update
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
To: subrata@linux.vnet.ibm.com
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, ltp-list@lists.sourceforge.net

On Mon, Jun 7, 2010 at 2:11 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2010-06-07 at 15:51 +0900, Tetsuo Handa wrote:
>> Hello.
>>
>> Subrata Modak wrote:
>> > > I updated TOMOYO testcases for Linux 2.6.36.
>> > > http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.3.x/tomoyo-tools/kernel_test/tomoyo-ltp.diff?revision=3740&root=tomoyo
>> > > 4425 lines, 141,420 bytes.
>> > > MD5: aeb0af73a8f140d50d4ab7435b10de16
>> >
>> > Thanks for intimating us the updates about the TOMYO test cases. Would
>> > you mind sending us a patch against the LTP git
>> > repo(git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev) so that i can
>> > push your path against the latest tree.
>> >
>> Above one applies against http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=snapshot;h=7f20a3add6c7f2166dbab5a712713ae8b5943448;sf=tgz
>>
>> I didn't know ltp moved repository from cvs to git.
>> I downloaded files from cvs. Adding some notes on
>> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.2
>> might help preventing users from downloading old files.
>
> The patch will apply fine with the git tree as well, as, no changes has
> gone into the TOMYO tree recently. And git is just a migration from cvs
> without harming the code. So, all patches will apply to git as well.
> However, this patch did not apply as it was not created properly:
>
> patching file testcases/kernel/security/tomoyo/README
> patching file testcases/kernel/security/tomoyo/include.h
> patching file testcases/kernel/security/tomoyo/newns.c
> patching file testcases/kernel/security/tomoyo/testall.sh
> patching file testcases/kernel/security/tomoyo/tomoyo_accept_test.c
> patching file testcases/kernel/security/tomoyo/tomoyo_file_test.c
> patching file testcases/kernel/security/tomoyo/tomoyo_filesystem_test.c
> patch: **** malformed patch at line 2088:
>
> Please create it properly and send me.
>
> Meanwhile i am having trouble logging to the sf.net site. I will change
> the documentation accordingly when i get a proper access.

Here's some info that might help:

1. Rishi tried to get the SF folks to disable the CVS SCM, but it
appears that it didn't get pushed through.
2. You might be trying to pull the from the wrong git branch. Try
something like: git clone
git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git next .

HTH,
-Garrett

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
