Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1RSmrK-0004zb-8L
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 09:41:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RSmrE-0001OR-4y
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 09:41:46 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 1A115170137
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Nov 2011 17:41:32 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id pAM9fVIU025195
	for <ltp-list@lists.sourceforge.net>; Tue, 22 Nov 2011 17:41:32 +0800
Message-ID: <4ECB6DE2.1090802@cn.fujitsu.com>
Date: Tue, 22 Nov 2011 17:39:46 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4E377560.7060600@cn.fujitsu.com>
In-Reply-To: <4E377560.7060600@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 0/6] Automatically mount hugetlbfs for hugemmap
 tests.
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
To: ltp-list@lists.sourceforge.net

hi,

I have been waiting such a long time for the feedback of this patch set.
Does anybody have any time to give some comments?
Thanks:)

On 08/02/2011 11:56 AM, tangchen wrote:
> hi,
> 
> I am sorry for replying your comments so late.
> Here, I seperate all the code into 6 patches.
> 
> The purpose of this patch set is to automatically 
> mount hugetlbfs for hugemmap tests, so that users 
> don't need to mount hugetlbfs themselves before 
> testing.
> 
> I made a new library, including some common 
> functions, mounting hugetlbfs and allocating 
> hugepages for test programs. And testcase 
> hugemmap01 ~ hugemmap04 used these functions to 
> mount hugetlbfs before testing.
> 
> Please comment! Thanks:)
> 

-- 
Best Regards,
Tang chen
--------------------------------------------------
Tang Chen
Development Dept.I
Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
No.6 Wenzhu Road, Nanjing, 210012, China 
TEL: +86+25-86630566-8527
FUJITSU INTERNAL: 7998-8527
FAX: +86+25-83317685
EMail: tangchen@cn.fujitsu.com
--------------------------------------------------
This communication is for use by the intended recipient(s) only and may contain information that is privileged, confidential and exempt from disclosure under applicable law. If you are not an intended recipient of this communication, you are hereby notified that any dissemination, distribution or copying hereof is strictly prohibited.  If you have received this communication in error, please notify me by reply e-mail, permanently delete this communication from your system, and destroy any hard copies you may have printed


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
