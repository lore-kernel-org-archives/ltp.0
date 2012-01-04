Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiQ9w-0006uG-Hx
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 12:41:36 +0000
Date: Wed, 4 Jan 2012 13:52:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104125226.GA12086@saboteur.suse.cz>
References: <1324869052-22433-1-git-send-email-jin.li@windriver.com>
	<20111230143413.GA29431@saboteur.suse.cz>
	<4F03B99B.4080500@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F03B99B.4080500@windriver.com>
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
To: Jin Li <Jin.Li@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Could you please resend this without the html formatting.
(it's commont nettiquete not to send these into mailing lists)

> <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
> <html>
> <head>
>   <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
> </head>
> <body bgcolor="#ffffff" text="#000000">
> <font face="Helvetica, Arial, sans-serif">Hi Cyril <br>
> <br>
> Please see the feed back below.<br>
> </font><br>
> Cyril Hrubis &#20889;&#36947;:
> <blockquote cite="mid:20111230143413.GA29431@saboteur.suse.cz"
>  type="cite">
>   <pre wrap="">Hi!
>   </pre>
>   <blockquote type="cite">
>     <pre wrap="">In setpgid03 test02, the function "setpgid" is likely to be invoked
> in father process before the function "execlp" get invoked in child
> process. Sometimes The performance or NFS file system may cause that
> the switch of context could not be done even after the 1 second sleeping
> of father process. In this case, the setpgid will get unexpected error
> number. Add sync mechanism to insure the 'setpgid' get invoked in the right
> order.
> 
> Signed-off-by: Jin Li <a class="moz-txt-link-rfc2396E" href="mailto:jin.li@windriver.com">&lt;jin.li@windriver.com&gt;</a>
> ---
>  void do_child(void);
>  void setup(void);
> @@ -60,6 +61,7 @@ int main(int ac, char **av)
>  
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> +	char cmd_line[1024];    /* command line for exec */
>     </pre>
>   </blockquote>
>   <pre wrap=""><!---->
> Please don't add trivial comments (and remove trivial comments that are
> in the code allready).
>   </pre>
> </blockquote>
> Accepted <br>
> <blockquote cite="mid:20111230143413.GA29431@saboteur.suse.cz"
>  type="cite">
>   <pre wrap="">
>   </pre>
>   <blockquote type="cite">
>     <pre wrap=""> 	/* parse standard options */
>  	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
> @@ -74,6 +76,10 @@ int main(int ac, char **av)
>  	 */
>  	setup();
>  
> +	sprintf(temp_file,"/tmp/%s_file",TCID);
>     </pre>
>   </blockquote>
>   <pre wrap=""><!---->
> Maybe it would be better to use tst_tmpdir() so the test has it's own
> and unique directory to create temp files instead of utlizing /tmp
> directly. (several instances of the test could then run at once).
>   </pre>
> </blockquote>
> Accepted<br>
> <blockquote cite="mid:20111230143413.GA29431@saboteur.suse.cz"
>  type="cite">
>   <pre wrap="">
>   </pre>
>   <blockquote type="cite">
>     <pre wrap="">+	sprintf(cmd_line,"touch %s;sleep 5s;rm -f %s", temp_file, temp_file);
>     </pre>
>   </blockquote>
>   <pre wrap=""><!---->
> Hm, I still don't think the race is gone now. As once the shell calls
> rm, it exits, so most likely when the parent calls setpgid() the process
> is gone (and from the original source it seems that the process should
> be running while the parent calls setpgid()). And moreover the file
> doesn't need to be created when the parent tries access() for the first
> time.
>   </pre>
> </blockquote>
> I'm afraid that I don't agree with you. The child and father get the
> same schedule priority. <br>
> So during the 5s sleeping of father, the child have enough time to run
> "setpgid".<br>
> Here is just a execution sync-up that make sure the "execlp" is
> invoked&nbsp; just&nbsp; before&nbsp; <br>
> the "setpgid" get invoked in father<br>
> <br>
> Thanks,<br>
> <br>
> Jin<br>
> <br>
> <blockquote cite="mid:20111230143413.GA29431@saboteur.suse.cz"
>  type="cite">
>   <pre wrap="">
>   </pre>
>   <blockquote type="cite">
>     <pre wrap=""> 	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
>  		/* reset Tst_count in case we are looping */
> @@ -132,12 +138,15 @@ int main(int ac, char **av)
>  
>  		}
>  		if (pid == 0) {
> -			if (execlp("sleep", "sleep", "3", NULL) &lt; 0) {
> +			if (execlp("sh", "sh", "-c", cmd_line, NULL) &lt; 0) {
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
>     </pre>
>   </blockquote>
>   <pre wrap=""><!---->
> And please use the checkpatch next time.
> 
>   </pre>
> </blockquote>
> </body>
> </html>

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
