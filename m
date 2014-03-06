Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WLWyC-0001MS-Ka
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 12:00:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WLWyA-0000lA-R7
	for ltp-list@lists.sourceforge.net; Thu, 06 Mar 2014 12:00:12 +0000
Message-ID: <1394105651.2061.12.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 06 Mar 2014 19:34:11 +0800
In-Reply-To: <5305B472.4010909@oracle.com>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<5305B472.4010909@oracle.com>
Mime-Version: 1.0
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, 2014-02-20 at 11:53 +0400, Stanislav Kholmanskikh wrote:
> Hi!
> 
> On 02/20/2014 06:10 AM, Zeng Linggang wrote:
> > When we  call getgrgid_r()  to  verify whether the corresponding gid is
> > existent, if not, getgrgid_r() will return 0 or ENOENT or ESRCH or
> > EBADF or EPERM...
> >
> > But tst_get_unused_gid() only check return value 0, this is not complete.
> > For example, if the gid is not existent, getgrgid_r() in RHEL7 beta will
> > return ENOENT, which will cause tst_get_unused_gid failed incorrectly.
> > This is the same for getpwuid_r().
> 
> Thank you.
> 
> I was puzzled by these two sentences in the getgrgid_r man (RHEL6):
> "If no matching  group  record was  found,  these  functions  return  0 
>   and  store  NULL  in *result.  In case of error, an error number is
> returned, and NULL is stored in *result."
> 
> Maybe update the man page according with 
> http://www.gnu.org/software/libc/manual/html_node/Lookup-Group.html. I 
> think that there the return values are described more clear.
> 
> What do you think?
> 

Hi,
So sorry for the late response.
I think there is a little different in RHEL7.0Beta.
If no gid was found, it returned ENOENT in RHEL7.0Beta.

[root@RHEL7U0Beta_zenglg tmp]# cat test.c 
#include <stdlib.h>
#include <sys/types.h>
#include <grp.h>
#include <unistd.h>
#include <limits.h>

int main(void)
{
        gid_t gid;
        int s;
        struct group grp;
        char *buf;
        long bufsize;
        struct group *result;

        bufsize = sysconf(_SC_GETGR_R_SIZE_MAX);
        if (bufsize == -1)
                bufsize = 16384;

        buf = malloc(bufsize);
        if (buf == NULL)
                return -1;

        for (gid = 0; gid <= UINT_MAX - 1; gid++) {
                s = getgrgid_r(gid, &grp, buf, bufsize, &result);
                if (result == NULL) {
                        free(buf);
                        printf("s: %d\tgid: %d\n", s, gid);
                        if (s == 0)
                                return gid;
                        else
                                return -1;
                }
        }
}


Here is the result that output:
[root@RHEL5U10GA_Intel64 tmp]# ./test 
s: 0    gid: 11

[root@RHEL6U5GA_Intel64 tmp]# ./test 
s: 0    gid: 13

[root@RHEL7U0Beta_zenglg tmp]# ./test 
s: 2    gid: 13

Best regards,
Zeng


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
