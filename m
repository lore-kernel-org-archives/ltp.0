Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJNJE-0003b4-B5
	for ltp-list@lists.sourceforge.net; Wed, 03 Oct 2012 11:40:12 +0000
Date: Wed, 3 Oct 2012 13:40:39 +0200
From: chrubis@suse.cz
Message-ID: <20121003114039.GC22986@saboteur.suse.cz>
References: <E061084CB90FCE4F89232A6CF839683B32BC7591@SZXEML507-MBS.china.huawei.com>
	<1291748381.11026946.1346066218005.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1291748381.11026946.1346066218005.JavaMail.root@redhat.com>
Subject: Re: [LTP] Test case send01 fails in kernel version 3.6-rc1,
 rc2 and rc3
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
To: Jan Stancek <jstancek@redhat.com>
Cc: shyju pv <shyju.pv@huawei.com>, ltp-list@lists.sourceforge.net

Hi!
> Looks to be the same reason as sendto().
> I'm thinking we can either remove that test or change it to UDP:
> 
> diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
> index ad64c70..c8dd9bd 100644
> --- a/testcases/kernel/syscalls/sendto/sendto01.c
> +++ b/testcases/kernel/syscalls/sendto/sendto01.c
> @@ -126,8 +126,8 @@ struct test_case_t {                /* test case structure */
>                     sizeof(sin1), -1, EPIPE, setup2, cleanup1,
>                     "local endpoint shutdown"}
>         , {
> -       PF_INET, SOCK_STREAM, 0, buf, sizeof(buf), -1, &sin1,
> -                   sizeof(sin1), 0, EPIPE, setup1, cleanup1,
> +       PF_INET, SOCK_DGRAM, 0, buf, sizeof(buf), -1, &sin1,
> +                   sizeof(sin1), -1, EOPNOTSUPP, setup1, cleanup1,
>                     "invalid flags set"}
>  };

The usuall concensus for such case is to change expected return values
depending on the kernel version (see for example tst_kvercmp() in
testcases/kernel/syscalls/sysctl/sysctl03.c). Which is the best solution
I can come up with.

On the other hand we don't bother to work with rc kernels they change
far to often.

Does this behave same on released linux 3.6?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
