Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RiA6h-0004pp-9V
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:33:11 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RiA6g-0002eK-M1
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 19:33:11 +0000
Received: by obcwn6 with SMTP id wn6so18164761obc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Jan 2012 11:33:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F03015B.5050700@imgtec.com>
References: <4F03015B.5050700@imgtec.com>
Date: Tue, 3 Jan 2012 11:33:05 -0800
Message-ID: <CAGH67wS6fUzsZS2AjEtCJVkJXTYM8==1wfSaT=G63wfdw-etVw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 18/21] network/lib6/asapi_06: pcmsg->cmsg_len is
 of type size_t
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

On Tue, Jan 3, 2012 at 5:23 AM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> Hi, please review the attached patch

    This is ok. While the stance here has been to follow the PRI*
style format string qualifiers, this works and is pseudo standard
across BSD, Linux, and probably a few other printf(3) implementations.
Thanks,
-Garrett

Reviewed-by: Garrett Cooper <yanegomi@gmail.com>

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
