Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OUZsB-0000IX-QD
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:37:15 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OUZsA-0001Qy-Va
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 06:37:15 +0000
Received: by iwn34 with SMTP id 34so4013830iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 01 Jul 2010 23:37:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C2D8672.8030406@linux.vnet.ibm.com>
References: <4C2C8492.503@linux.vnet.ibm.com>
	<1278003985.21642.7.camel@subratamodak.linux.ibm.com>
	<4C2D8672.8030406@linux.vnet.ibm.com>
Date: Thu, 1 Jul 2010 23:37:09 -0700
Message-ID: <AANLkTiko2hqAdNNyr6RmmE_sQhEmY71PqjdOzSdcoudc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] close file descriptors and munmap pages.
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
To: Darshak Shah <darshaks@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 1, 2010 at 11:25 PM, Darshak Shah
<darshaks@linux.vnet.ibm.com> wrote:
> On 07/01/2010 10:36 PM, Subrata Modak wrote:
>> Probably, you would need to fix these:
>>
>> patching file testcases/kernel/syscalls/open/open10.c
>> Hunk #1 FAILED at 282.
>> Hunk #2 FAILED at 311.
>> Hunk #3 FAILED at 359.
>> Hunk #4 FAILED at 389.
>> Hunk #5 FAILED at 440.
>> 5 out of 5 hunks FAILED -- saving rejects to file
>> testcases/kernel/syscalls/open/open10.c.rej
>> patching file testcases/kernel/syscalls/splice/splice02.c
>> patch: **** malformed patch at line 229: Passed");
>
> Dear Subrata,
>
> I downloaded the latest ltp from
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree
> I used the "snapshot" to download the tgz and patched as following.
>
> The patch seems to apply correctly.

    Please attach the patch as a file as well as inline. Some MTAs and
mail clients (like gmail for me) screw up whitespace and other fuzz in
patches when folks include it inline in email.
Thanks!
-Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
