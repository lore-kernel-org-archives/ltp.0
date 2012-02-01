Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RsbJi-0006jP-1d
	for ltp-list@lists.sourceforge.net; Wed, 01 Feb 2012 14:37:46 +0000
Date: Wed, 1 Feb 2012 15:50:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120201145059.GB30390@saboteur.suse.cz>
References: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328097104-25615-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] syscalls: fix creat07 setup and arg to execve
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
To: Salvatore CRO' <salvatore.cro@st.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fix typo in setup function as app[0] should be
> checked instead of test_app[0].
> Fix test_path concatenating the absolute
> path to test_app when required (app[0] == '/').
> Finally fix execve (returning Bad address - EFAULT)
> argument av[1] as it requires argument
> array to be terminated by a null pointer.
> 
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> ---
>  testcases/kernel/syscalls/creat/creat07.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index 4ed2c22..edaa182 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -92,6 +92,7 @@ int main(int ac, char **av)
>  		if (pid == 0) {
>  			char *av[1];
>  			av[0] = basename(test_app);
> +			av[1] = NULL;

Hmm, shouldn't then the array be declared as char *av[2] and moreover I
would chose a differnet name for it as at first sight it seems to be
modifying the parameter passed to main.

>  			(void)execve(test_app, av, NULL);
>  			perror("execve failed");
>  			exit(1);
> @@ -138,8 +139,9 @@ void setup(char *app)
>  	char *cmd, *pwd = NULL;
>  	char test_path[MAXPATHLEN];
>  
> -	if (test_app[0] == '/')
> -		strncpy(test_path, test_app, sizeof(test_app));
> +	if (app[0] == '/')
> +		snprintf(test_path, sizeof(test_path), "%s/%s",
> +				dirname(app), test_app);
>  	else {
>  		if ((pwd = get_current_dir_name()) == NULL)
>  			tst_brkm(TBROK|TERRNO, NULL, "getcwd failed");

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
