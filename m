Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yaneurabeya@gmail.com>) id 1OcQLR-00029v-L7
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 22:03:53 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OcQLQ-0000Cp-Oh
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 22:03:53 +0000
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yaneurabeya@gmail.com>
In-Reply-To: <20100723184824.GA55142@medusa.sis.pasteur.fr>
Date: Fri, 23 Jul 2010 15:03:45 -0700
Message-Id: <FE807C4F-FBEF-4F35-A53D-95290C6B0CC9@gmail.com>
References: <20100723171717.GA54890@medusa.sis.pasteur.fr>
	<AANLkTik=DJ+0NsMoD-ucZZtVrsaiBHeVEMmh-3GEixD+@mail.gmail.com>
	<20100723184824.GA55142@medusa.sis.pasteur.fr>
Subject: Re: [LTP] abort01 testcase cleanup
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
To: Nicolas Joly <njoly@pasteur.fr>
Cc: LTP list <ltp-list@lists.sf.net>

On Jul 23, 2010, at 11:48 AM, Nicolas Joly wrote:

> On Fri, Jul 23, 2010 at 10:56:58AM -0700, Garrett Cooper wrote:
>> On Fri, Jul 23, 2010 at 10:17 AM, Nicolas Joly <njoly@pasteur.fr> wrote:
>>> 
>>> Hi,
>>> 
>>> The attached patch do some cleanup in the abort01 testcase ...
>>> 
>>> 1) The attempt to remove the generated core is wrong. The hard-coded
>>>   `core' name is bad and the test temporary directory removal already
>>>   take care of this.
>>> 
>>> 2) Make the test fail gracefully if the running environment does not
>>>   allow generating core files.
>>> 
>>> njoly@lanfeust [syscalls/abort]> ./abort01
>>> abort01     1  TPASS  :  Test passed
>>> njoly@lanfeust [syscalls/abort]> (ulimit -c 0 && ./abort01)
>>> abort01     1  TCONF  :  core file size limit must be greater than 0.
>>> 
>>> Signed-off-by: Nicolas Joly <njoly@pasteur.fr>
>> 
>> Looks ok, but is there any particular reason why you removed the unlink(2) call?
> 
> The `unlink("core")' one ?
> 
> Well, at least RHEL do use `proc.<pid>' when generating core file
> names ... Not speaking about admins that might have configured it to
> use another scheme.
> 
> IMO, relying on a specific name, for a configurable system, is a bad
> idea; and can only lead to problems.
> 
> By example, this test from mkdir09.c cannot succeed on most RHEL
> systems:
> 
>        /* Check for core file in test directory. */
>        if (access("core", 0) == 0) {
>                tst_resm(TWARN, "\tCore file found in test directory.");
>                tst_exit();
>        }

Yeah. Perhaps it might be a good idea to integrate a tool into LTP which detects corefile names, like what's described here: http://aplawrence.com/Linux/limit_core_files.html .
Cheers,
-Garrett
------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
