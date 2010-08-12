Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OjQSO-0000WX-Q7
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 05:36:00 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjQSK-0004BV-1P
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 05:36:00 +0000
Received: by bwz8 with SMTP id 8so838494bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 22:35:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1281590286-11833-1-git-send-email-harsh@linux.vnet.ibm.com>
References: <1281590286-11833-1-git-send-email-harsh@linux.vnet.ibm.com>
Date: Wed, 11 Aug 2010 22:35:50 -0700
Message-ID: <AANLkTi=Ok4Wa0wr1Fi3CyBc_GeTG_2Etm70kA9LR5AbU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fs/9p: setrlimit testcase fix for RLIMIT_FSIZE
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
To: Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Aug 11, 2010 at 10:18 PM, Harsh Prateek Bora
<harsh@linux.vnet.ibm.com> wrote:
> Current testcase for setrlimit for parameter RLIMIT_FSIZE
> does not convey the number of bytes actually written from
> child process to parent, as the child process writes to its
> own copy of global variable. This patch introduces a pipe
> to send the information from child to the parent process.

Please use the tst_res(3) APIs instead of using raw perror(3) and
exit(3), like so (ignoring indentation):

if (pipe(pipefd) == -1) {
    tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
}

Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
