Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXYLA-00081M-5d
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 15:53:36 +0000
Date: Tue, 8 Apr 2014 17:52:52 +0200
From: chrubis@suse.cz
Message-ID: <20140408155251.GA3201@rei>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<1396944482.2100.1.camel@G08JYZSD130126>
	<20140408111920.GA8556@rei> <5344069B.8010101@oracle.com>
	<20140408144954.GA1841@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140408144954.GA1841@rei>
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

Hi!
> Hmm, as far as I can see the the error for bin.gr_gid is EPERM, while
> invalid user test expect EINVAL, so something must be different.
> 
> And it looks like you can really get EINVAL in the setregid() in
> kernel/sys.c. And that it depends on namespace mappings. See
> kernel/user_namespace.c make_kgid() that calls map_id_down(), although I
> haven't yet figured out exact conditions yet.

And here is the rest of the story.

Unless process modified it's user namespace the get_current_ns() will
return pointer to init_user_ns that is defined in kernel/user.c. This
user namespace maps gids and uids 1:1 in the interval 0 - 4294967294.
Because if I understand the code right the map_id_down checks if id is
in interval between first and first + count - 1 and the count is set to
4294967295. The 4294967295 on the other hand equals to (u32)-1 which is
not included in the mapping but this is the value used for error exit so
it maps uids and gids 1:1 by default.


I've looked closely at the setregid() syscall code and I'm pretty sure
that you can't get EINVAL unless you played with namespaces. Looking
closely at the setregid02 testcase the test is wrong see closely these
lines:


                                if (TEST_ERRNO == test_data[i].exp_errno) {
                                        tst_resm(TPASS, "setregid(%d, %d) "
                                                 "failed as expected.",
                                                 *test_data[i].real_gid,
                                                 *test_data[i].eff_gid);
                                } else if (TEST_ERRNO == test_data[0].exp_errno) {
                                        tst_resm(TPASS, "setregid(%d, %d) "
                                                 "failed as expected.",
                                                 *test_data[i].real_gid,
                                                 *test_data[i].eff_gid);
                                } else {
                                        tst_resm(TFAIL, "setregid(%d, %d) "
                                                 "failed (%d) but did not set the "
                                                 "expected errno (%d).",
                                                 *test_data[i].real_gid,
                                                 *test_data[i].eff_gid,
                                                 TEST_ERRNO,
                                                 test_data[i].exp_errno);
                                }


The test allows the call to faile with either it's expected errno or with the
expected errno of the first testcase. This looks like ugly workaround for some
kernel changes.

The git log says:

    Correct testcase return on RHEL 3 & 4 2.6.13-rc6-mm1

So the best solution would be to remove this workaround and the two testcases
as well.


The setresuid() is the same, it cannot return EINVAL unless namespaces were
involved namespaces were modified. I would go for removing the redundant
testcases there as well.

Uff, that's it, to sum it up, I would go for removing the testcase that employs
GET_INVALID* got rid of the tst_ functions as well. Sorry that I didn't get it
right the first time.


PS: The codepath looks like it can return ENOMEM. I wonder if we can get it
    if we play with process ulimits.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
