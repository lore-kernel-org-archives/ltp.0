Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RSnKC-0006Ed-SF
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 10:11:36 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RSnK7-00008Q-Jy
	for ltp-list@lists.sourceforge.net; Tue, 22 Nov 2011 10:11:36 +0000
Received: by ywt2 with SMTP id 2so7191832ywt.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Nov 2011 02:11:26 -0800 (PST)
Date: Tue, 22 Nov 2011 02:11:22 -0800 (PST)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4ECB6DE2.1090802@cn.fujitsu.com>
Message-ID: <alpine.BSF.2.00.1111220206090.16277@toaster.local>
References: <4E377560.7060600@cn.fujitsu.com> <4ECB6DE2.1090802@cn.fujitsu.com>
MIME-Version: 1.0
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, 22 Nov 2011, tangchen wrote:

> hi,
>
> I have been waiting such a long time for the feedback of this patch set.
> Does anybody have any time to give some comments?
> Thanks:)
>
> On 08/02/2011 11:56 AM, tangchen wrote:
>> hi,
>>
>> I am sorry for replying your comments so late.
>> Here, I seperate all the code into 6 patches.
>>
>> The purpose of this patch set is to automatically
>> mount hugetlbfs for hugemmap tests, so that users
>> don't need to mount hugetlbfs themselves before
>> testing.
>>
>> I made a new library, including some common
>> functions, mounting hugetlbfs and allocating
>> hugepages for test programs. And testcase
>> hugemmap01 ~ hugemmap04 used these functions to
>> mount hugetlbfs before testing.

Tang-Chen,
 	You didn't reply to all of my comments based on my looking back at 
my gmail mailbox. Granted, I could have preened the messages by accident, 
but I don't see replies. If you can dig up links and/or [re]submit updated 
patches to the list, I'll review it today and commit them if the comments 
have been addressed.
Thanks!
-Garrett

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
