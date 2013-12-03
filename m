Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vnrmn-0004mL-Sh
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 15:21:17 +0000
Date: Tue, 3 Dec 2013 16:20:41 +0100
From: chrubis@suse.cz
Message-ID: <20131203152041.GB28700@rei>
References: <1385130616-1415-1-git-send-email-alexey.kodanev@oracle.com>
	<20131203135829.GA28700@rei> <529DF2D7.80909@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529DF2D7.80909@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: uaccess: test access to
 user-space memory
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> +static ssize_t sys_result(struct device *dev,
> >> +	struct device_attribute *attr, char *buf)
> >> +{
> >> +	return scnprintf(buf, PAGE_SIZE, "%d\n", test_result);
> >> +}
> >> +static DEVICE_ATTR(result, S_IRUSR, sys_result, NULL);
> >> +
> >> +
> >> +static ssize_t sys_tcase(struct device *dev,
> >> +	struct device_attribute *attr,  const char *buf, size_t count)
> >> +{
> >> +	uintptr_t ptr = 0;
> > The same as bellow, unsigned long would be more correct.
> OK, is it because of sscanf?

Yes, the parameter types should always match the format string. And
although in this case the uintptr_t would end up the same as unsigned
long I would like see it fixed for clarity.

> >> +	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> > Again I would normalize the return value here, i.e.
> >
> > 	if (res)
> > 		return TFAIL;
> >
> > 	return TPASS;
> OK
> >> +	return res;
> >> +}
> >> +
> >> +/*
> >> + * Can read user-space using copy_from_user(), get_user().
> >> + */
> >> +static void tc_read_userspace(void)
> >> +{
> >> +	int res = set_ptr_to_sysfs(TC_READ_USER, user_str,
> >> +		"can read user-space data from kernel");
> >> +
> >> +	tst_resm(res, "copy_from_user(), get_user(): data%smatch",
> >> +		(res) ? " don't " : " ");
> >> +}
> >> +
> >> +/*
> >> + * Can write data from kernel-space to user-space
> >> + * using copy_to_user(), put_user().
> >> + */
> >> +static void tc_write_userspace(void)
> >> +{
> >> +	char buf[str_size];
> >> +	memset(buf, 0, str_size);
> >> +
> >> +	int res = set_ptr_to_sysfs(TC_WRITE_USER, buf,
> >> +		"can write data from kernel to user-space");
> >> +	tst_resm(res, "write data from kernel-space");
> > And here as well.
> if I rewrite set_ptr_to_sysfs, it will return TFAIL or TPASS.

Sounds good.

> Should I also rewrite this part to print only one result (TPASS/TFAIL) 
> per test-case?

Yes please.

> int res = set_ptr_to_sysfs(TC_WRITE_USER, buf,
> 	"can write data from kernel to user-space");
> if (res) {
> 	tst_resm(TFAIL, "failed to write data from kernel");
> 	return;
> }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
