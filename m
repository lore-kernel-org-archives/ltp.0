Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2HBw-0002vv-Pr
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 10:55:36 +0000
Date: Tue, 9 Jun 2015 12:54:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609105431.GB24843@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 2/5] acl_test01: Verify the exit code of the
 second test case
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Now we verify the exit code of the second test case. We did not
> do this previously, and it was a bug.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/fs/acls/acl_test01 |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/fs/acls/acl_test01 b/testcases/kernel/fs/acls/acl_test01
> index be88aa8..0f050b9 100755
> --- a/testcases/kernel/fs/acls/acl_test01
> +++ b/testcases/kernel/fs/acls/acl_test01
> @@ -228,7 +228,8 @@ else
>  	chown $TEST_USER1 $FILE_ACL
>  	chown $TEST_USER1 $FILE_ACL_LINK
>  
> -	su $TEST_USER1 -c "$0"
> +	su $TEST_USER1 -c "$0" &
> +	tst_record_childstatus $!

We should probably wrap the su into a script that makes sure that the
return value is compatible with LTP. Because it may set bogus test
return status if su reported anything else than 0 or 1.

Or we may add just another function into test.sh that would work
similariry to tst_record_childstatus but that will normalize the return
value. I.e. 0 == TPASS, anything else TFAIL.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
