Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZSS91-0004cv-Gj
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 15:52:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZSS8z-0007YZ-7c
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 15:52:47 +0000
Date: Thu, 20 Aug 2015 17:52:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150820155213.GB5144@rei.suse.de>
References: <1439887006-17985-1-git-send-email-liwang@redhat.com>
	<1439887006-17985-2-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439887006-17985-2-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH 2/3] ltp/pounder: Don't let the testing log output
 to /dev/tty
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> During the pounder21 test, it gives many errors like:
> 
> ./pounder: line 262: /dev/tty: No such device or address
> ./pounder: line 263: /dev/tty: No such device or address
> 
> After google '/dev/tty', got this description:
> 
> /dev/tty is the controlling terminal for the current process, if there is such a terminal.
> Do ps -a and look for /dev/tty. If it doesn't appear then that process doesn't have a
> controlling terminal.  It is quite normal for there to be no controlling terminal. So if
> there is no device associated with it then the kernel will just ignore anything you send
> to that file. It only cares if it has attached a device (possibly pseudo) to that node. If
> it does care, and echoing is on, then anything you send to the (special) file will be echoed.

Writing directly to /dev/tty is indeed wrong thing to do.

> The second part may be related to the login shell. Check in /etc/passwd and make sure that
> you really do start bash for the user you are logging in as. Using /bin/sh instead is a likely cause.
> So do grep username /etc/passwd and look for the path to the program that is launched at the end of
> the text line. If its /bin/sh then you have the wrong shell. What you should have is /bin/bash.

Eh? I do not understand this part at all. It does not seem to be related
to the problem at all.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  tools/pounder21/Install              |  2 +-
>  tools/pounder21/fancy_timed_loop.c   |  2 +-
>  tools/pounder21/infinite_loop.c      |  2 +-
>  tools/pounder21/pounder              | 14 +++++++-------
>  tools/pounder21/test_scripts/memtest |  2 +-
>  tools/pounder21/timed_loop.c         |  2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/pounder21/Install b/tools/pounder21/Install
> index bf13528..6fb3a8f 100755
> --- a/tools/pounder21/Install
> +++ b/tools/pounder21/Install
> @@ -65,7 +65,7 @@ done
>  # Set up optdir
>  mkdir -p "$POUNDER_OPTDIR"
>  if [ ! -d "$POUNDER_OPTDIR" ]; then
> -	echo "Could not create $POUNDER_OPTDIR; aborting." > /dev/tty
> +	echo "Could not create $POUNDER_OPTDIR; aborting."
>  	exit 1
>  fi
>  
> diff --git a/tools/pounder21/fancy_timed_loop.c b/tools/pounder21/fancy_timed_loop.c
> index cf8580e..50305c3 100644
> --- a/tools/pounder21/fancy_timed_loop.c
> +++ b/tools/pounder21/fancy_timed_loop.c
> @@ -92,7 +92,7 @@ int main(int argc, char *argv[])
>  
>  	tty_fp = fdopen(3, "w+");
>  	if (tty_fp == NULL) {
> -		tty_fp = fopen("/dev/tty", "w+");
> +		tty_fp = fdopen(STDOUT_FILENO, "w+");
>  		if (tty_fp == NULL) {
>  			perror("stdout");
>  			exit(2);

Can't we rather rename the FILE * to 'out' or similar, naming it tty_fp
when it does not point to tty is kind of confusing.

Also we can simply do FILE *out = stdout; If we reopen it by it's file
descriptior we will end up with two different file objects, each of them
will buffer data and we will end up with messed output when something
will write to stdout and not the one we created.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
