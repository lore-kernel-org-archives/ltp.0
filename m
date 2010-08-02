Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OfoNt-0005yQ-Se
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:20:25 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OfoNr-0001wq-Nz
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 06:20:25 +0000
Received: by gyd8 with SMTP id 8so1524261gyd.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 01 Aug 2010 23:20:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik3dhWhOCBRKMJv2MkUt8P616044akbCwCUspCE@mail.gmail.com>
References: <4C5267A2.1070800@oracle.com>
	<AANLkTik3dhWhOCBRKMJv2MkUt8P616044akbCwCUspCE@mail.gmail.com>
Date: Sun, 1 Aug 2010 23:20:18 -0700
Message-ID: <AANLkTimGEsbJwtLqEpkCJw+=AwcyweVJge4ntfFzGsAZ@mail.gmail.com>
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

On Sun, Aug 1, 2010 at 11:17 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Jul 29, 2010 at 10:48 PM, Gurudas Pai <gurudas.pai@oracle.com> wrote:
>> Hi There,
>>
>> I am using LTP-20100630 , and while running POWER_MANAGEMENT test
>> I get following errors,
>>
>> /opt/ltp/testcases/bin/runpwtests.sh: line 201: get_sched_values:
>> command not found
>>
>>
>> Change log shows get_sched_values.c is removed.
>>
>> 92) Log Message:
>> 1. Remove the .c files and all calls in runpwtests.sh because we can
>> achieve the same thing through additional shell test logic.
>> 2. Add the apicmds dependency.
>
> File restored.

Except the file already existed... did you run make in the directory?

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
