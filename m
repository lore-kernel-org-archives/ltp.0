Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nu75s-0004Qt-Dk
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:36:40 +0000
Received: from mail-px0-f204.google.com ([209.85.216.204])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nu75r-0004Mb-Gt
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:36:40 +0000
Received: by pxi42 with SMTP id 42so1498241pxi.24
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 09:36:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100323132546.GA20611@us.ibm.com>
References: <20100321011004.GA28202@us.ibm.com>
	<20100323085352.GC4384@linux.vnet.ibm.com>
	<20100323132546.GA20611@us.ibm.com>
Date: Tue, 23 Mar 2010 09:36:33 -0700
Message-ID: <364299f41003230936gc0c88cas9bc220b0b060c548@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH ltp] fix detection of setcap for filecaps test
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Mar 23, 2010 at 6:25 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Rishikesh K Rajak (risrajak@linux.vnet.ibm.com):
>> Hi Serge,
>>
>> Today we(me & iranna) got a chance to test your patch. Patch worked fine.
>>
>> while running i tried fixing few unwanted messages. You can Ack if it is correct fix.
>>
>> ===== error log =====
>> Running in:
>> cp: cannot stat `/opt/ltp/testcases/bin/print_caps': No such file or directory
>> mkfifo: cannot create fifo `caps_fifo': File exists
>> cap_sys_admin tests
>> ==== error log ======
>>
>> Signed-off by : Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
> I think these should be fine.
>
> Acked-by: Serge Hallyn <serue@us.ibm.com>

    If you're commenting out the lines, why not just delete them?
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
