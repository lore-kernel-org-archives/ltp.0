Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1TVPKo-0004LL-FK
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 16:15:34 +0000
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TVPKi-0004zg-Qw
	for ltp-list@lists.sourceforge.net; Mon, 05 Nov 2012 16:15:34 +0000
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Mon, 5 Nov 2012 16:15:22 -0000
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
	[9.149.37.217])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id qA5GFCnd49021038
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Nov 2012 16:15:12 GMT
Received: from d06av06.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id qA5GFJt0031939
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Nov 2012 09:15:19 -0700
Message-ID: <5097E61C.2050100@linux.vnet.ibm.com>
Date: Mon, 05 Nov 2012 17:15:24 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <20121030003915.GU24652@mediapc.snapdragonfly.net>
	<508FB84D.5050308@linux.vnet.ibm.com>
	<20121105153358.GI31939@mediapc.snapdragonfly.net>
In-Reply-To: <20121105153358.GI31939@mediapc.snapdragonfly.net>
Subject: Re: [LTP] coverage history
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
To: John Schmitt <marmalodak@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 05.11.2012 16:33, John Schmitt wrote:
> On Tue, Oct 30, 2012 at 12:21:49PM +0100, Peter Oberparleiter wrote:
>> On 30.10.2012 01:39, John Schmitt wrote:
>>> Is there a way to generate track the coverage of a project over time?  If I'm writing unit tests as my code base expands, can I see how my coverage of that code base goes up or down over time as reported by lcov?
>>
>> There is no integrated way to track coverage changes over time with
>> lcov, although this may be a good idea for a future improvement.
>>
>> For now, you could manually extract the coverage results using the
>> --summary or --list option of lcov and put that into a spreadsheet.
>
> Thank you, Peter, this is the best advice I've received.

You're welcome!

> I see the --list option in lcov but I don't see a --summary.  Are you referring to --function-summaries which gcov takes?

The "lcov --summary <filename>" option comes with lcov 1.10. It shows 
coverage rates for all of a file, while --list shows the information for 
each file.


Regards,
   Peter

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
