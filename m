Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RtbQb-0001v0-W8
	for ltp-list@lists.sourceforge.net; Sat, 04 Feb 2012 08:57:01 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RtbQa-0001EM-7z
	for ltp-list@lists.sourceforge.net; Sat, 04 Feb 2012 08:57:01 +0000
Message-ID: <4F2CF2D9.4090004@cn.fujitsu.com>
Date: Sat, 04 Feb 2012 16:56:57 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <CADfK0X4BrdBUq=pQ8zjgsHPtbrXTz2w+xSvn+HP4UBtmMEfgZg@mail.gmail.com>
In-Reply-To: <CADfK0X4BrdBUq=pQ8zjgsHPtbrXTz2w+xSvn+HP4UBtmMEfgZg@mail.gmail.com>
Subject: Re: [LTP] Please clarify
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
To: joshiplns@gmail.com
Cc: LTP List <ltp-list@lists.sourceforge.net>


Josh! said the following on 2012-2-2 18:48:
> Hi folks,
> 
> As I am testing 3.0 Kernel with 2012 January LTP version. I successfully tested the 3.0 Kernel. BUT from the result log TESTED result is 1279   and when I counted its 1274 . attached log with this mail.
> 
> Result log :
> {
> -----------------------------------------------
> Total Tests: 1279
> Total Failures: 54
> Kernel Version: 3.0.12_nl-kzm-a9-rt29-00003-g5c963e0
> Machine Architecture: armv7l
> Hostname: 10.2.222.5
> -----------------------------------------------
> }
> 
> BUT
> 
> {
> [Joshi@myserver Desktop]$ cat 2012_LTP_Result | wc -l
> 1274
> }
> 
> *So My query is about*:
>       *1.**I am confusing about missing test cases - where is missing test cases?*
>       *2*.*even though in log 1274 test cases, Why is showing as 1279 as TOTAL tested cases*.

I know the four cases: aio01, aio02, Cap_bounds and Filecaps.

aio01 and aio02 need header file /usr/include/libaio.h in libaio-devel.
Cap_bounds need header file /usr/include/sys/capability.h in libcap-devel.
Filecaps need command setcap, but ltp has a bug:(

When the above condition is not satisfied, the cases will not build and install.
When execute, the cases will return error, but not add in logfile.

for example:
initiation_status="pan(18488): execvp of 'filecapstest.sh' (tag Filecaps) failed.  errno:2  No such file or directory"

>       *3*.*How it will segregate the the test cases from runtest directory?*

If you run "/opt/ltp/runltp -f io", you will find aio01 and aio02 is not in the logfile.

-- 
Best Regards,
Peng

> *Please clarify these points*
> 
> Thanks in advance
> Joshi 
> 
> 
> ------------------------------------------------------------------------------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-d2d
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
