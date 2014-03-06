Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WLXXR-0002RI-0O
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 12:36:37 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WLXXP-0001B4-U6
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 12:36:36 +0000
Message-ID: <53186BC5.7050406@oracle.com>
Date: Thu, 06 Mar 2014 16:36:21 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1392862246.1997.6.camel@G08JYZSD130126>	
	<5305B472.4010909@oracle.com>
	<1394105651.2061.12.camel@G08JYZSD130126>
In-Reply-To: <1394105651.2061.12.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] lib/tst_uid_gid.c: fix checking return value
 errors about getpwuid_r/getgrgid_r
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



On 06.03.2014 15:34, Zeng Linggang wrote:
> On Thu, 2014-02-20 at 11:53 +0400, Stanislav Kholmanskikh wrote:
>> Hi!
>>
>> On 02/20/2014 06:10 AM, Zeng Linggang wrote:
>>> When we  call getgrgid_r()  to  verify whether the corresponding gid is
>>> existent, if not, getgrgid_r() will return 0 or ENOENT or ESRCH or
>>> EBADF or EPERM...
>>>
>>> But tst_get_unused_gid() only check return value 0, this is not complete.
>>> For example, if the gid is not existent, getgrgid_r() in RHEL7 beta will
>>> return ENOENT, which will cause tst_get_unused_gid failed incorrectly.
>>> This is the same for getpwuid_r().
>>
>> Thank you.
>>
>> I was puzzled by these two sentences in the getgrgid_r man (RHEL6):
>> "If no matching  group  record was  found,  these  functions  return  0
>>    and  store  NULL  in *result.  In case of error, an error number is
>> returned, and NULL is stored in *result."
>>
>> Maybe update the man page according with
>> http://www.gnu.org/software/libc/manual/html_node/Lookup-Group.html. I
>> think that there the return values are described more clear.
>>
>> What do you think?
>>
>
> Hi,
> So sorry for the late response.
> I think there is a little different in RHEL7.0Beta.
> If no gid was found, it returned ENOENT in RHEL7.0Beta.
>

Yes, I got this difference at that time:)

I don't have any objections/comments about your patch. I just wanted to 
mention one logic "collision" (for me) in the man page. After reading 
this page it's not clear whether we should treat the "no matching group 
record" situation as a special case or as one of possible errors. But 
glibc documentation makes everything clear.


------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
