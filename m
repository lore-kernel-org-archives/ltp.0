Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1TT9tS-0005dk-9H
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 11:22:02 +0000
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TT9tN-00036D-Ln
	for ltp-list@lists.sourceforge.net; Tue, 30 Oct 2012 11:22:02 +0000
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Tue, 30 Oct 2012 11:21:51 -0000
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id q9UBLfic49479724
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Oct 2012 11:21:41 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id q9UBLmTE012110
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Oct 2012 05:21:48 -0600
Message-ID: <508FB84D.5050308@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2012 12:21:49 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <20121030003915.GU24652@mediapc.snapdragonfly.net>
In-Reply-To: <20121030003915.GU24652@mediapc.snapdragonfly.net>
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

On 30.10.2012 01:39, John Schmitt wrote:
> Is there a way to generate track the coverage of a project over time?  If I'm writing unit tests as my code base expands, can I see how my coverage of that code base goes up or down over time as reported by lcov?

There is no integrated way to track coverage changes over time with 
lcov, although this may be a good idea for a future improvement.

For now, you could manually extract the coverage results using the 
--summary or --list option of lcov and put that into a spreadsheet.


Regards,
   Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
