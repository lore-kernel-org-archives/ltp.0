Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WMvLP-0004Vd-Rv
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 08:13:55 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WMvLO-0004D7-3K
	for ltp-list@lists.sourceforge.net; Mon, 10 Mar 2014 08:13:55 +0000
Message-ID: <1394439199.1952.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 10 Mar 2014 16:13:19 +0800
In-Reply-To: <53186BC5.7050406@oracle.com>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<5305B472.4010909@oracle.com> <1394105651.2061.12.camel@G08JYZSD130126>
	<53186BC5.7050406@oracle.com>
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

On Thu, 2014-03-06 at 16:36 +0400, Stanislav Kholmanskikh wrote:
> 
> On 06.03.2014 15:34, Zeng Linggang wrote:
> > On Thu, 2014-02-20 at 11:53 +0400, Stanislav Kholmanskikh wrote:
> >> Hi!
> >>
> >> On 02/20/2014 06:10 AM, Zeng Linggang wrote:
> >>> When we  call getgrgid_r()  to  verify whether the corresponding gid is
> >>> existent, if not, getgrgid_r() will return 0 or ENOENT or ESRCH or
> >>> EBADF or EPERM...
> >>>
> >>> But tst_get_unused_gid() only check return value 0, this is not complete.
> >>> For example, if the gid is not existent, getgrgid_r() in RHEL7 beta will
> >>> return ENOENT, which will cause tst_get_unused_gid failed incorrectly.
> >>> This is the same for getpwuid_r().
> >>
> >> Thank you.
> >>
> >> I was puzzled by these two sentences in the getgrgid_r man (RHEL6):
> >> "If no matching  group  record was  found,  these  functions  return  0
> >>    and  store  NULL  in *result.  In case of error, an error number is
> >> returned, and NULL is stored in *result."
> >>
> >> Maybe update the man page according with
> >> http://www.gnu.org/software/libc/manual/html_node/Lookup-Group.html. I
> >> think that there the return values are described more clear.
> >>
> >> What do you think?
> >>
> >
> > Hi,
> > So sorry for the late response.
> > I think there is a little different in RHEL7.0Beta.
> > If no gid was found, it returned ENOENT in RHEL7.0Beta.
> >
> 
> Yes, I got this difference at that time:)

> I don't have any objections/comments about your patch. I just wanted to 
> mention one logic "collision" (for me) in the man page. After reading 
> this page it's not clear whether we should treat the "no matching group 
> record" situation as a special case or as one of possible errors. But 
> glibc documentation makes everything clear.
> 

:)
OK, thanks. I know what you mean. The man page for getgrgid_r() really
makes us puzzle. I also think the glibc documentation description " If
no group is found or if an error occurred, the pointer returned in
result is a null pointer. The function returns zero or an error code" is
not clear enough. I think the correct implementation should be "If no
group found, this function returns 0 and sets result to a null pointer.
If an error occurs, this function should return an error code".  I think
it would be more accurate.

At the same time, I notice the difference in /etc/nsswitch.conf.  In
RHEL6.5GA, for group name service, the configure is "group:      files",
but in RHEL7.0beta, this configure is "group:      files sss". It seems
that service sssd forms this return value difference or the configure
influences the glibc's work.

When I modified the "group:      files sss" to "group:      files" in
RHEL7.0beta, the test program will return 0.

Thanks.


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
