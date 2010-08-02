Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OfoLb-0006Kt-3S
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:18:03 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OfoLa-0001tk-F5
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:18:03 +0000
Received: by iwn34 with SMTP id 34so4947890iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 01 Aug 2010 23:17:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C5267A2.1070800@oracle.com>
References: <4C5267A2.1070800@oracle.com>
Date: Sun, 1 Aug 2010 23:17:57 -0700
Message-ID: <AANLkTik3dhWhOCBRKMJv2MkUt8P616044akbCwCUspCE@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP-20100630:POWER_MANAGEMENT runpwtests.sh fails.
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
To: gurudas.pai@oracle.com
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 29, 2010 at 10:48 PM, Gurudas Pai <gurudas.pai@oracle.com> wrote:
> Hi There,
>
> I am using LTP-20100630 , and while running POWER_MANAGEMENT test
> I get following errors,
>
> /opt/ltp/testcases/bin/runpwtests.sh: line 201: get_sched_values:
> command not found
>
>
> Change log shows get_sched_values.c is removed.
>
> 92) Log Message:
> 1. Remove the .c files and all calls in runpwtests.sh because we can
> achieve the same thing through additional shell test logic.
> 2. Add the apicmds dependency.

File restored.
Thanks,
-Garrett

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
