Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Ri10j-0002ow-UX
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:50:25 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ri10h-0001XI-6x
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:50:25 +0000
Received: by obcwn6 with SMTP id wn6so17308857obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 01:50:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F02CBDE.70400@imgtec.com>
References: <4F02CBDE.70400@imgtec.com>
Date: Tue, 3 Jan 2012 01:50:17 -0800
Message-ID: <CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 3, 2012 at 1:35 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi, please review the attached patch

    Converting the function to tst_brkm and removing the tst_exit call
below it would be better.
Thanks!
-Garrett

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
