Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UxF4b-0007cE-TU
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 11:30:09 +0000
Date: Thu, 11 Jul 2013 13:31:45 +0200
From: chrubis@suse.cz
Message-ID: <20130711113145.GC6142@rei.suse.cz>
References: <1373509951-10850-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373509951-10850-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] inotify04: add RHEL5 extra kernel version check
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> @@ -79,6 +79,11 @@ char event_buf[EVENT_BUF_LEN];
>  
>  int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;
>  
> +static struct tst_kern_exv kvers[] = {
> +	{ "RHEL5", "132" },
> +	{ NULL, NULL },
> +};
> +
>  static void cleanup(void)
>  {
>  
> @@ -172,7 +177,7 @@ int main(int argc, char **argv)
>  	 * This isn't well documented in inotify(7), but it's intuitive if you
>  	 * understand how Unix works.
>  	 */
> -	if (0 <= tst_kvercmp(2, 6, 25)) {
> +	if (tst_kvercmp(2, 6, 25) >= 0 || tst_kvercmp2(2, 6, 18, kvers) >= 0) {
>  		event_set[tst_count].mask = IN_ATTRIB;
>  		strcpy(event_set[tst_count].name, "");
>  		tst_count++;

It looks like I've misunderstand the initial definition of the problem,
sorry.

Now it is pretty clear that the tst_kern_exv should have included the
whole kernel version as when we would like to the add another special
case based on different kerenel version the change would be more
complicated than adding a line to the tst_kern_exv array.

The approach I would like to have is to have one tst_kvercmp2() with
kernel version for vanilla kernels and pointer to a structure describing
special cases. Do you agree to change the code this way?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
