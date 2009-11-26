Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDlGh-00074q-7d
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 20:48:47 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDlGc-00088D-Ch
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 20:48:47 +0000
Received: by pwi12 with SMTP id 12so701516pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 26 Nov 2009 12:48:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFD2A634F2.AA55F33B-ON6525767A.0060D7CD-6525767A.00614813@in.ibm.com>
References: <OFD2A634F2.AA55F33B-ON6525767A.0060D7CD-6525767A.00614813@in.ibm.com>
Date: Thu, 26 Nov 2009 12:48:36 -0800
Message-ID: <364299f40911261248u1281945cl5570062afeb4736@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] utils directory is not getting copied in /opt/ltp
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
To: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Nov 26, 2009 at 9:44 AM, Poornima Nayak
<Poornima.Nayak@in.ibm.com> wrote:
> Hi Garret
>
> Power Management functionality testcases are dependent on scirpts in utils
> directoy. The October released LTP does not copy 'utils's directory to
> /opt/ltp.
> I tried setting 'utils' in COMMON_TARGETS still utils directory does not get
> copied to /opt/ltp.
> If you could you give me a patch which I can apply to my test setup and
> continue my testing would be great help.

    I fixed up ebizzy and kernbench for you seconds ago on CVS head ;)...
Cheers!
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
