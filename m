Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgdN6-0007nS-3O
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 14:23:48 +0000
Date: Fri, 30 Dec 2011 15:34:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111230143413.GA29431@saboteur.suse.cz>
References: <1324869052-22433-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324869052-22433-1-git-send-email-jin.li@windriver.com>
Subject: Re: [LTP] [PATCH] This fix make sure the function "setpgid" get
 invoked in the right time in setpgid03 test02.
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
To: Jin Li <jin.li@windriver.com>
Cc: ltp-list@lists.sourceforge.net, haotian.zhang@windriver.com

Hi!
> In setpgid03 test02, the function "setpgid" is likely to be invoked
> in father process before the function "execlp" get invoked in child
> process. Sometimes The performance or NFS file system may cause that
> the switch of context could not be done even after the 1 second sleeping
> of father process. In this case, the setpgid will get unexpected error
> number. Add sync mechanism to insure the 'setpgid' get invoked in the right
> order.
> 
> Signed-off-by: Jin Li <jin.li@windriver.com>
> ---
>  void do_child(void);
>  void setup(void);
> @@ -60,6 +61,7 @@ int main(int ac, char **av)
>  
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> +	char cmd_line[1024];    /* command line for exec */

Please don't add trivial comments (and remove trivial comments that are
in the code allready).

>  	/* parse standard options */
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> @@ -74,6 +76,10 @@ int main(int ac, char **av)
>  	 */
>  	setup();
>  
> +	sprintf(temp_file,"/tmp/%s_file",TCID);

Maybe it would be better to use tst_tmpdir() so the test has it's own
and unique directory to create temp files instead of utlizing /tmp
directly. (several instances of the test could then run at once).

> +	sprintf(cmd_line,"touch %s;sleep 5s;rm -f %s", temp_file, temp_file);

Hm, I still don't think the race is gone now. As once the shell calls
rm, it exits, so most likely when the parent calls setpgid() the process
is gone (and from the original source it seems that the process should
be running while the parent calls setpgid()). And moreover the file
doesn't need to be created when the parent tries access() for the first
time.

>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
>  		/* reset Tst_count in case we are looping */
> @@ -132,12 +138,15 @@ int main(int ac, char **av)
>  
>  		}
>  		if (pid == 0) {
> -			if (execlp("sleep", "sleep", "3", NULL) < 0) {
> +			if (execlp("sh", "sh", "-c", cmd_line, NULL) < 0) {
>  				perror("exec failed");
>  			}
>  			exit(127);
>  		} else {
> -			sleep(1);
> +			while ( access(temp_file, F_OK) != 0 ) {
> +                            sleep(1);
> +			}
> +
>  			rval = setpgid(pid, getppid());
>  			if (errno == EACCES) {
>  				tst_resm(TPASS, "setpgid SUCCEEDED to set "
> @@ -203,4 +212,4 @@ void cleanup(void)
>  	 */
>  	TEST_CLEANUP;

And please use the checkpatch next time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
