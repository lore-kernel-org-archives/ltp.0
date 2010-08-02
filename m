Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gurudas.pai@oracle.com>) id 1Ofp3e-0008Sm-7r
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 07:03:34 +0000
Received: from rcsinet10.oracle.com ([148.87.113.121])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ofp3a-0007aa-Dg
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 07:03:34 +0000
Message-ID: <4C566B2B.5080709@oracle.com>
Date: Mon, 02 Aug 2010 12:22:27 +0530
From: Gurudas Pai <gurudas.pai@oracle.com>
MIME-Version: 1.0
References: <4C5267A2.1070800@oracle.com>	<AANLkTik3dhWhOCBRKMJv2MkUt8P616044akbCwCUspCE@mail.gmail.com>	<AANLkTimGEsbJwtLqEpkCJw+=AwcyweVJge4ntfFzGsAZ@mail.gmail.com>	<4C56636B.50907@oracle.com>
	<AANLkTimTvfD9Z4ORvf2-gjzAQjBdWJCmS4dQtD8Ena7K@mail.gmail.com>
In-Reply-To: <AANLkTimTvfD9Z4ORvf2-gjzAQjBdWJCmS4dQtD8Ena7K@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett Cooper wrote:
> On Sun, Aug 1, 2010 at 11:19 PM, Gurudas Pai <gurudas.pai@oracle.com> wrote:
>>
>> Garrett Cooper wrote:
>>> On Sun, Aug 1, 2010 at 11:17 PM, Garrett Cooper <yanegomi@gmail.com>
>>> wrote:
>>>> On Thu, Jul 29, 2010 at 10:48 PM, Gurudas Pai <gurudas.pai@oracle.com>
>>>> wrote:
>>>>> Hi There,
>>>>>
>>>>> I am using LTP-20100630 , and while running POWER_MANAGEMENT test
>>>>> I get following errors,
>>>>>
>>>>> /opt/ltp/testcases/bin/runpwtests.sh: line 201: get_sched_values:
>>>>> command not found
>>>>>
>>>>>
>>>>> Change log shows get_sched_values.c is removed.
>>>>>
>>>>> 92) Log Message:
>>>>> 1. Remove the .c files and all calls in runpwtests.sh because we can
>>>>> achieve the same thing through additional shell test logic.
>>>>> 2. Add the apicmds dependency.
>>>> File restored.
>>> Except the file already existed... did you run make in the directory?
>> I ran make under ltp-full-20100630 directory, and not specifically under
>> testcases/kernel/power_management.
>>
>>>> File restored.
>> Where can i get this file ? I couldn't find it under
>> http://sourceforge.net/projects/ltp/files
> 
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=history;f=testcases/kernel/power_management/get_sched_values.c;h=830448bfa653e57ddead3837c7b1e7f139c273bd;hb=HEAD

Thanks ! test passed now.

-Guru

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
