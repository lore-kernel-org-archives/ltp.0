Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z7158-0003dS-G3
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 12:44:10 +0000
Date: Mon, 22 Jun 2015 14:42:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150622124255.GB7476@rei.suse.de>
References: <1434712459-21878-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1434712459-21878-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] cgroup_xattr: fix test on kernels >= 3.15
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
>  /* only security.* & trusted.* are valid key names */
> -static const struct tst_key tkeys[] = {
> +static struct tst_key tkeys[] = {
>  	{ .name = "trusted.test",	.good = 1,	},
> +	{ .name = "trusted.",		.good = 1,	},
>  	{ .name = "security.",		.good = 1,	},
>  	{ .name = "user.",		.good = 0,	},
>  	{ .name = "system.",		.good = 0,	},
> @@ -152,6 +153,14 @@ void setup(int argc, char *argv[])
>  			"Test must be run with kernel 3.7 or newer");
>  	}
>  
> +	if (tst_kvercmp(3, 15, 0) >= 0) {
> +		/* In kernel v3.15 cgroup was converted to kernfs
> +		 * that doesn't provide simple security namespace handlers.
> +		 * Setting just 'security.' should return EOPNOTSUPP.
> +		 */
> +		tkeys[2].good = 0;
> +	}

I don't like indexing the testcases array with a hand computed values like
this. One reason is that this is harder to figure out what exactly is
changed and the second is that this way too fragile and will break if
somebody changes the order of the array.

Unfortunately I don't know ideal solution for this either. More explicit
version may be to iterate over the array and doing strcmp() on the name.
It's not particulary nice but it's the best I can come up with.

Or you can define good == 2 value to be special value that means "needs
to be figured out in the setup" that way we can avoid the string
comparsion at least.

>  	int value_size = DEFAULT_VALUE_SIZE;
>  	if (nflag) {
>  		if (sscanf(narg, "%i", &value_size) != 1)
> @@ -270,8 +279,11 @@ int mount_cgroup(void)
>  		 * additional "xattr" option. In that case, mount will succeed,
>  		 * but xattr won't be supported in the new mount anyway.
>  		 * Should be removed as soon as a fix committed to upstream.
> +		 *
> +		 * But not applicable for kernels >= 3.15 where xattr supported
> +		 * natively.
>  		 */
> -		if (hier != 0)
> +		if (hier != 0 && tst_kvercmp(3, 15, 0) < 0)
>  			continue;
>  
>  		int i, found = 0;
> @@ -321,7 +333,7 @@ int mount_cgroup(void)
>  
>  static int set_xattrs(const char *file)
>  {
> -	int i, err, fail, res = 0;
> +	unsigned int i, err, fail, res = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
>  		err = setxattr(file, tkeys[i].name,
> @@ -343,7 +355,7 @@ static int set_xattrs(const char *file)
>  
>  static int get_xattrs(const char *file)
>  {
> -	int i, fail, res = 0;
> +	unsigned int i, fail, res = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(tkeys); ++i) {
>  		/* get value size */
> @@ -366,7 +378,7 @@ static int get_xattrs(const char *file)
>  				"Can't get buffer of key %s",
>  				tkeys[i].name);
>  		}
> -		fail = val.size != size ||
> +		fail = val.size != (size_t)size ||
>  			strncmp(val.buf, xval, val.size) != 0;
>  		res |= fail;
>  
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
