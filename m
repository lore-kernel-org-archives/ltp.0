Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1Rq1XB-0000im-Rt
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 12:01:01 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rq1X7-0004DI-Bh
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 12:01:01 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8689413C
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jan 2012 12:00:50 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6C4123C3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 25 Jan 2012 12:00:49 +0000 (GMT)
Message-ID: <4F1FEEEF.2080506@st.com>
Date: Wed, 25 Jan 2012 13:00:47 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <1327481724-28367-1-git-send-email-salvatore.cro@st.com>
In-Reply-To: <1327481724-28367-1-git-send-email-salvatore.cro@st.com>
Subject: Re: [LTP] [PATCH] syscalls: fix creat07 setup and argv to execve
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
To: ltp-list@lists.sourceforge.net

On 25/01/2012 9.55, Salvatore CRO' wrote:
> Fix test_path variable logic in setup function.
> Also use a new argv variable to be passed to execve.
> 
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> ---
>  testcases/kernel/syscalls/creat/creat07.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
> index 4ed2c22..43a6030 100644
> --- a/testcases/kernel/syscalls/creat/creat07.c
> +++ b/testcases/kernel/syscalls/creat/creat07.c
> @@ -90,9 +90,8 @@ int main(int ac, char **av)
>  			tst_brkm(TBROK|TERRNO, cleanup, "fork #1 failed");
>  
>  		if (pid == 0) {
> -			char *av[1];
> -			av[0] = basename(test_app);
> -			(void)execve(test_app, av, NULL);
> +			char *argv[] = { test_app, NULL };
> +			(void)execve(test_app, argv, NULL);
>  			perror("execve failed");
>  			exit(1);
>  		}
> @@ -138,14 +137,15 @@ void setup(char *app)
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
>  
>  		snprintf(test_path, sizeof(test_path), "%s/%s",
> -		    pwd, basename(test_app));
> +		    pwd, test_app);
>  
>  		free(pwd);
>  	}
Hi Salvo,
could you clarify why this change is needed ?

cheers

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
