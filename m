Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SYYP5-0005xc-Vb
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 08:00:44 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SYYP5-0003SD-Bd
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 08:00:43 +0000
Received: by obhx4 with SMTP id x4so4855695obh.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 27 May 2012 01:00:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FC1D8C5.4050804@cn.fujitsu.com>
References: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
	<4FC1D8C5.4050804@cn.fujitsu.com>
Date: Sun, 27 May 2012 01:00:37 -0700
Message-ID: <CAGH67wQw2j6AMgKxs0JwynQYT7JB0mjVkiB+hztWUSnLRneS9w@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix the fork/11-1 conformance testcase
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sun, May 27, 2012 at 12:33 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> On 05/26/2012 10:15 PM, Garrett Cooper wrote:
>
>> The testcase tests to see whether or not locks are successfully
>> inherited across forking processes, as the requirements for fork state
>> that they should not be. The problem is that the test tests the negative
>> case for ftrylockfile (!= 0) instead of the positive case, which creates
>
> The ftrylockfile() function returns zero for success (the lock was obtained),
> and nonzero for failure.
> So I think the origin is right.

    My description might be wrong, but the fix is right. ftrylockfile
should fail in the testcase (not succeed) because the file lock isn't
owned by the forked process. It succeeds simply because the delay is
long enough on some platforms. I could check and ensure that EAGAIN
(or the POSIX prescribed error) occurs if this occurs instead in the
implicit else case.
Thanks!
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
